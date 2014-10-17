require 'pathname'

module PhilColumns
  module Activerecord
    class Migrator

      include SilenceStreams

      def down( version=0 )
        silence_streams do
          ActiveRecord::Migrator.down( ActiveRecord::Migrator.migrations_path, version )
        end
      end

      def up( version=nil )
        silence_streams do
          ActiveRecord::Migrator.up( ActiveRecord::Migrator.migrations_path, version )
        end
      end

      def clear_migrations_table
        return unless ActiveRecord::Base.connection.table_exists?( schema_migrations_table_name )

        case connection_config[:adapter]
          when 'sqlite', 'sqlite3'
            connection.execute("DELETE FROM #{table_name}")
            connection.execute("DELETE FROM sqlite_sequence where name='#{table_name}'")
          else
            ActiveRecord::Base.connection.execute( "TRUNCATE #{schema_migrations_table_name}" )
        end

        connection.execute( 'VACUUM' ) if connection_config[:adapter] == 'sqlite3'
      end

      def latest_version
        ActiveRecord::Migrator.get_all_versions.sort.last
      end

      def connection
        ActiveRecord::Base::connection
      end

      def connection_config
        connection.instance_variable_get( '@config' )
      end

      def drop_tables
        tables.each do |table|
          drop_table( table )
        end
      end

      def drop_table( table )
        silence_streams do
          if ActiveRecord::Migration.table_exists?( table )
            ActiveRecord::Migration.drop_table( table )
          end
        end
      end

      def load_schema
        silence_streams do
          if schema_filepath.exist?
            load( schema_filepath.expand_path )
          end
        end
      end

      def migrations_path
        ActiveRecord::Migrator.migrations_path
      end

      def schema_filepath
        Pathname.new( migrations_path.gsub( 'migrate', 'schema.rb' ))
      end

      def tables
        ActiveRecord::Base::connection.
                            tables.
                            reject { |t| exclude_tables.include?( t ) }
      end

      def exclude_tables
        [
          schema_migrations_table_name,
          'schema_seeds'
        ]
      end

      def schema_migrations_table_name
        ActiveRecord::Migrator.schema_migrations_table_name
      end

    end
  end
end
