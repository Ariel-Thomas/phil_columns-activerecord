module PhilColumns
  module Activerecord
    module SilenceStreams

    protected

      def silence_streams( &block )
        silence_stream STDOUT do
          silence_stream STDERR do
            block.call
          end
        end
      end

    end
  end
end
