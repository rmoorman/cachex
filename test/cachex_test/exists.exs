defmodule CachexTest.Exists.Default do
  use PowerAssert

  setup do
    { :ok, cache: TestHelper.create_cache() }
  end

  test "exists? requires an existing cache name", _state do
    assert(Cachex.exists?("test", "key") == { :error, "Invalid cache name provided, got: \"test\"" })
  end

  test "exists? with an existing key", state do
    set_result = Cachex.set(state.cache, "my_key", 5)
    assert(set_result == { :ok, true })

    get_result = Cachex.get(state.cache, "my_key")
    assert(get_result == { :ok, 5 })

    exists_result = Cachex.exists?(state.cache, "my_key")
    assert(exists_result == { :ok, true })
  end

  test "exists? with a missing key", state do
    exists_result = Cachex.exists?(state.cache, "missing_key")
    assert(exists_result == { :ok, false })
  end

end
