require 'rails_helper'

RSpec.describe Services::Search, type: :service do
  scopes = %w(All Kite Board Bar Stuff)
  query = 'My query'
  scopes.each do |scope|
    it do
      case scope
      when 'All'
        expect(Ad).to receive(:search).with(query)
        Services::Search.call({query: query, scope: scope})
      when 'Kite'
        expect(Ad).to receive(:search).with(conditions: {kite_name: query})
        Services::Search.call({query: query, scope: scope})
      when 'Board'
        expect(Ad).to receive(:search).with(conditions: {board_name: query})
        Services::Search.call({query: query, scope: scope})
      when 'Bar'
        expect(Ad).to receive(:search).with(conditions: {bar_name: query})
        Services::Search.call({query: query, scope: scope})
      when 'Stuff'
        expect(Ad).to receive(:search).with(conditions: {stuff_name: query})
        Services::Search.call({query: query, scope: scope})
      else
        return
      end
    end
  end
end
