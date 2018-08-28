module PhilColumns
  module Activerecord
    module SilenceStreams

    protected

      def silence_streams( &block )
        block.call
      end
      
    end
  end
end
