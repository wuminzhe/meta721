namespace :get_metadata do
  desc "Get metadata from nftport"
  task get: :environment do
    # sql = 
    #   "SELECT * FROM tokens WHERE id in (" +
    #   " SELECT t1.id FROM (" + 
    #   " (SELECT CEIL(RAND() * (SELECT MAX(id) FROM tokens)) AS id)"

    # 1000.times do |i|
    #   sql = sql + 
    #   " UNION (SELECT CEIL(RAND() * (SELECT MAX(id) FROM tokens)) AS id)"
    # end

    # sql = sql + 
    #   "  ) as t1 " + 
    #   ")"
    # puts sql
    # records_array = ActiveRecord::Base.connection.execute(sql)
    # records_array.each do |r|
    #   puts r[0]
    # end

    
    # tokens = Token.where("id>=1 and id<=1000")

    # tokens.each do |token|
    #   contract_address = token.token_contract_address
    #   url = "https://api.nftport.xyz/v0/nfts/#{contract_address}?chain=ethereum&page_number=#{page_number}&page_size=#{page_size}&include=default&refresh_metadata=false"
    #   response = Faraday.get(url, nil, {'User-Agent' => '0xuniscan', 'Authorization' => '7a1fc8ee-d945-4c02-8001-c190c22c85e9'})
    #   result = JSON.parse response.body
    #   puts result["nfts"]
    # end
    # 

    contract_address = "0x66fCA7555CD481545A5e66bA9a2bEC1e256F98e7"
    result = get_metadata_by_contract(contract_address)
    puts result
  end
end

def get_metadata_by_contract(contract_address)
  page_number = 1
  while true
    url = "https://api.nftport.xyz/v0/nfts/#{contract_address}?chain=ethereum&page_number=#{page_number}&page_size=50&include=default&refresh_metadata=false"
    response = Faraday.get(url, nil, {'User-Agent' => '0xuniscan', 'Authorization' => '7a1fc8ee-d945-4c02-8001-c190c22c85e9'})
    nfts = JSON.parse(response.body)["nfts"]
    puts nfts.length
    if nfts.length < 50
      break
    end

    page_number += 1
  end
end
