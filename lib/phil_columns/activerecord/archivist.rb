module PhilColumns
  module Activerecord
    class Archivist

      include SilenceStreams

      def record_seed( version )
        ensure_schema_seeds_table!
        return if seed_already_executed?( version )

        SchemaSeed.new.tap do |schema_seed|
          schema_seed.version = version
          schema_seed.save!
        end
      end

      def remove_seed( version )
        ensure_schema_seeds_table!

        SchemaSeed.where( version: version ).delete_all #first.tap do |schema_seed|
      end

      def clear_seeds
        SchemaSeed.delete_all
      end

      def seed_already_executed?( version )
        ensure_schema_seeds_table!
        SchemaSeed.where( version: version ).exists?
      end

      def ensure_schema_seeds_table!
        return if ActiveRecord::Base.connection.table_exists?( :schema_seeds )

        silence_streams do
          ActiveRecord::Schema.define do
            create_table :schema_seeds, id: false do |t|
              t.column :version, :string, limit: 20, null: false
            end
          end
        end
      end

    end
  end
end
