garlic do
  repo 'rails', :url => 'git://github.com/rails/rails'
  repo 'rspec', :url => 'git://github.com/dchelimsky/rspec'
  repo 'rspec-rails', :url => 'git://github.com/dchelimsky/rspec-rails'
  repo 'factory_girl', :url => 'git://github.com/thoughtbot/factory_girl'
  repo 'machinist', :url => 'git://github.com/notahat/machinist'
  repo 'cucumber', :url => 'git://github.com/aslakhellesoy/cucumber'
  repo 'pickle', :path => '.'

  ['master', '2-3-stable', '2-2-stable', '2-1-stable'].each do |rails|
  
    target rails, :tree_ish => "origin/#{rails}" do
      prepare do
        plugin 'pickle', :clone => true
        plugin 'rspec', :tag => '1.2.2'
        plugin 'rspec-rails', :tag => '1.2.2' do
          `script/generate rspec -f`
        end
        plugin 'factory_girl'
        plugin 'cucumber' do
          `script/generate cucumber -f`
        end
        plugin 'machinist'
      end
  
      run do
        cd "vendor/plugins/pickle" do
          sh "rake rcov:verify && rake features"
        end
      end
    end
    
  end
end
