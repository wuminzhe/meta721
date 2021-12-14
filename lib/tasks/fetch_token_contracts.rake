require_relative './thegraph.rb'
namespace :fetch_token_contracts do
  desc "Fetch token contracts from thegraph"
  task fetch: :environment do
    while true
      last_token_contract = TokenContract.order(address: :desc).first
      
      result = 
        if last_token_contract.nil?
          puts "Init query ..."
          TGAPI::Client.query(InitTokenContractsQuery, 
                              variables: {
                                first: TOKEN_CONTRACTS_QUERY_BATCH_SIZE
                              }
                             )
        else
          puts "Query ..."
          TGAPI::Client.query(TokenContractsQuery, 
                              variables: {
                                first: TOKEN_CONTRACTS_QUERY_BATCH_SIZE, 
                                last_id: last_token_contract.address
                              }
                             )
        end

      if result.data.token_contracts.length > 0
        result.data.token_contracts.each do |tc|
          TokenContract.create({
            address: tc.id,
            name: tc.name,
            symbol: tc.symbol,
            metadata: tc.supports_eip721_metadata
          })
        end
      else
        puts "There is no more token contracts, wait 1 minutes."
        sleep 60
      end
    end

  end
end
