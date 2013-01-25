# coding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe Geo3x3 do
  it "chubu region level five is E3792" do
    expect(Geo3x3.encode({
      lat: 36.208823,
      lng: 138.251953,
      level: 5
    })).to eql "E3793"  
  end
end
