require_relative './thegraph.rb'
namespace :fetch_tokens do
  desc "Fetch tokens from thegraph"
  task fetch: :environment do
    while true
      # last_token = Token.order(mint_time: :desc).first

      sql = "select mint_time from tokens where id=(select max(id) as id from tokens)"
      records_array = ActiveRecord::Base.connection.execute(sql)
      record = records_array.first
      last_mint_time = record.nil? ? nil : record[0]
      puts last_mint_time
      
      result = 
        if last_mint_time.nil?
          puts "Init query tokens ..."
          TGAPI::Client.query(InitTokensQuery, 
                              variables: {
                                first: TOKENS_QUERY_BATCH_SIZE
                              }
                             )
        else
          puts "Query tokens ..."
          TGAPI::Client.query(TokensQuery, 
                              variables: {
                                first: TOKENS_QUERY_BATCH_SIZE, 
                                last_mint_time: last_mint_time
                              }
                             )
        end

      if result.data.tokens.length > 0
        result.data.tokens.each do |t|
          token_contract_address_and_token_id = t.id.split("_")
          token_contract_address = token_contract_address_and_token_id[0]
          token_id = token_contract_address_and_token_id[1]

          token_contract = TokenContract.find_by_address(token_contract_address)

          if token_contract.nil?
            puts "Token contract #{token_contract_address} not exist, wait 1 minutes."
            sleep 60
          else
            Token.create({
              token_contract_id: token_contract.id,
              token_contract_address: token_contract_address,
              token_id: token_id,
              token_uri: t.token_uri,
              owner_address: t.owner.id,
              mint_time: t.mint_time
            })
          end

        end
      else
        puts "There is no more token contracts, wait 1 minutes."
        sleep 60
      end
    end

  end
end
