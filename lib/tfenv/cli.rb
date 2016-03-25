#!/usr/bin/env ruby
require 'optparse'
require 'json'
require 'yaml'

module TFEnv
  class CLI
    def initialize(*args)
      @args = args
    end

    def export_hash(hash)
      hash.each do |key, value|
        ENV["TF_VAR_#{key}"] = value
      end
    end

    def read_consul_uri(uri)
      raise "Not implemented"
    end

    def read_outputs(state_file)
      {}.tap do |outputs|
        read_state(state_file).tap do |state|
          state["modules"].each do |module_state|
            outputs.merge!(module_state["outputs"])
          end
        end
      end
    end

    def read_state(state_file)
      raw_state = File.read(state_file)
      JSON.parse(raw_state)
    end

    def parse_options
      options = {
        :includes => [],
        :consuls => []
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: tfenv [options] [command]"

        opts.on("-s", "--state-file FILE", "Include external state output from state file") do |v|
          options[:includes] << v
        end

        opts.on("-c", "--consul URL/KEY", "Include external state output from consul") do |v|
          options[:consuls] << v
        end

        opts.on("-t", "--tfvar FILE", "Write variables to tfvar file") do |v|
          options[:tfvar] = v
        end

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options[:verbose] = v
        end
      end.parse!

      options
    end

    def collate_outputs(options)
      {}.tap do |outputs|
        options[:includes].each do |state_file|
          outputs.merge!(read_outputs(state_file))
        end

        options[:consuls].each do |consul_uri|
          outputs.merge!(read_consul_uri(consul_uri))
        end
      end
    end

    def load_outputs(options)
      {}.tap do |outputs|
        if options[:includes].empty? && options[:consuls].empty?
          if File.exists?("terraform.tfstate")
            return read_outputs("terraform.tfstate")
          end
        else
          collate_outputs(options)
        end
      end
    end

    def start
      options = parse_options
      outputs = load_outputs(options)

      if ARGV.length > 0
        export_hash(outputs)
        exec(*ARGV)
      else
        puts outputs.to_yaml
      end
    end
  end
end
