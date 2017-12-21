

Pod::Spec.new do |s|


  s.name         = "TSSwiftExtension"
  s.version      = "0.0.8"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "swift的自用扩展"

  s.description  = <<-DESC 
			some swift extension			
                   DESC

  s.homepage     = "https://github.com/leetangsong/TSSwiftExtension"
  s.author             = { "leetangsong" => "leetangsong@icloud.com" }

  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/leetangsong/TSSwiftExtension.git", :tag => "0.0.8" }

  s.source_files  = "TSSwiftExtension/*.swift"

  s.requires_arc = true


end
