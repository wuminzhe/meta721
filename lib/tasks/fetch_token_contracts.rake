require_relative './thegraph.rb'
namespace :fetch_token_contracts do
  desc "Fetch token contracts from thegraph"
  task fetch: :environment do
    while true
      begin
        # 假设这条记录是一定存在的
        ctrl = TokenContractsInfo.find_by_key("ctrl").value
        break if ctrl == "1"

        last_address = TokenContractsInfo.find_by_key("last_token_contract_address").value
        
        result = 
          if last_address.nil?
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
                                  last_id: last_address
                                }
                              )
          end

        if result.data.token_contracts.length > 0
          result.data.token_contracts.each do |tc|
            if TokenContract.find_by_address(tc.id).nil?
              create_token_contract(tc.id, tc.name, tc.symbol, tc.supports_eip721_metadata)
            end
          end
          last_tc = result.data.token_contracts.last
          TokenContractsInfo.find_by_key("last_token_contract_address").update({value: last_tc.id})
        else
          TokenContractsInfo.find_by_key("last_token_contract_address").update({value: nil})
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

def create_token_contract(address, name, symbol, supports_eip721_metadata)
  info = TokenContractsInfo.find_by_key("token_contracts_count")
  ori_count = info.value.to_i
  ActiveRecord::Base.transaction do
    TokenContract.create({
      address: address,
      name: name,
      symbol: symbol,
      metadata: supports_eip721_metadata
    })

    info.update({value: ori_count + 1})
  end
end
