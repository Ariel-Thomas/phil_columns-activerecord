require "phil_columns/activerecord/version"
require "phil_columns"
require "active_record"

module PhilColumns
  module Activerecord

    autoload :Archivist,      'phil_columns/activerecord/archivist'
    autoload :Migrator,       'phil_columns/activerecord/migrator'
    autoload :SchemaSeed,     'phil_columns/activerecord/schema_seed'
    autoload :SilenceStreams, 'phil_columns/activerecord/silence_streams'

    PhilColumns::archivist_klass = PhilColumns::Activerecord::Archivist
    PhilColumns::migrator_klass  = PhilColumns::Activerecord::Migrator

  end
end
