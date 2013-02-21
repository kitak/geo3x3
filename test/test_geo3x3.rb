require "minitest/unit"
require "minitest/autorun"
require File.expand_path("../../lib/geo3x3", __FILE__)

class TestGeo3x3 < MiniTest::Unit::TestCase

  def test_decode
    assert_equal({
      lat: 40.0,
      lng: -86.2962962962963,
      level: 6,
      unit:  0.7407407407407408}, Geo3x3.decode("W28644"))
    assert_equal({
      lat: 11.111111111111114,
      lng: 105.55555555555556,
      level: 5.0,
      unit: 2.2222222222222223}, Geo3x3.decode("E5379"))
    assert_equal({
      lat: 40.0,
      lng: -86.2962962962963,
      level: 6,
      unit: 0.7407407407407408}, Geo3x3.decode("-28644"))
  end

  def test_encode
    accepts = [
      %w(W
         W2
         W28
         W286
         W2864
         W28644
         W286445
         W2864455
         W28644555)
    ]

    [
      [40.0, -86.2962962962963]
    ].each_with_index do |params, i|
      assert_raises(ArgumentError) do
        Geo3x3.encode(lat: params[0], lng: params[1], level: 0)
      end
      (1..9).each do |l|
        assert_equal accepts[i][l - 1], Geo3x3.encode(lat: params[0], lng: params[1], level: l)
      end
    end
  end
end
