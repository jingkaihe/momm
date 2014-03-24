module Momm
  class Bridge
    def initialize(options={})
      @storage = options[:store] || Memcached.new
      @feed = options[:feed] || Feeds::ECB.instance
    end

    # Inject the storage
    #
    # == Parameters
    # storage_name::
    # :redis_store or memcached. Memcached is set as default.
    #
    # == Returns
    # the picked storage
    #
    # == Examples
    # store :redis_store, port: 12345
    #
    def store(storage_name, **kv)
      @storage = begin
        name = storage_name.to_s.split('_').map(&:capitalize).join
        klass = Kernel.const_get("Momm::#{name}")

        klass.new **kv
      end
    end

    # Inject the feed
    #
    # == Parameters
    # feed_name::
    # currently only support ECB
    #
    # == Returns
    # the picked feed
    #
    # == Examples
    # source :ECB (which is by default)
    #
    def source(feed_name)
      @feed = Kernel.const_get("Momm::Feeds::#{feed_name}").instance
    end

    attr_reader :storage, :feed
  end
end