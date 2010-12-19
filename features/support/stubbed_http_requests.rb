include WebMock::API

stub_request(:get, "http://www.vim-scripts.org/api/script_ids.json").
  with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => File.read(File.dirname(__FILE__) + "/../fixtures/script_ids.json"))

