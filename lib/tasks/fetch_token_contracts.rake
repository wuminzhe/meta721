require_relative './thegraph.rb'
namespace :fetch_token_contracts do
  desc "Fetch token contracts from thegraph"
  task fetch: :environment do
    while true
      begin
        last_token_contract = LastTokenContract.first
        
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
            if TokenContract.find_by_address(tc.id).nil?
              TokenContract.create({
                address: tc.id,
                name: tc.name,
                symbol: tc.symbol,
                metadata: tc.supports_eip721_metadata
              })
            end
          end
          last_tc = result.data.token_contracts.last
          if last_token_contract.nil?
            LastTokenContract.create({address: last_tc.id})
          else
            last_token_contract.update({address: last_tc.id})
          end
        else
          LastTokenContract.first&.delete
          puts "++++++++++++++++++++++++++++++++++"
          puts "Finished, sleep 5 minutes and rerun."
          sleep 5*60
        end
      rescue => ex
        puts "-----"
        puts "Error, sleep 60 seconds."
        puts ex.message
        sleep 60
      end
    end

  end
end
