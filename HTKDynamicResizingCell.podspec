Pod::Spec.new do |s|
  s.name         = "HTKDynamicResizingCell"
  s.version      = "0.0.2"
  s.summary      = "Subclassed UITableView/UICollectionView cells that auto calculate size when AutoLayout constraints are applied correctly. iOS 7+."
  s.description  = <<-DESC
                   Subclassed UITableView/UICollectionView cells that will auto calculate their size so long as AutoLayout constraints are applied correctly. For iOS 7+. Works similar to how iOS 8's auto sizing of cells work.
                   DESC
  s.homepage     = "http://www.github.com/henrytkirk/HTKDynamicResizingCell"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "Henry T Kirk" => "henrytkirk@gmail.com" }
  s.social_media_url   = "http://twitter.com/henrytkirk"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/henrytkirk/HTKDynamicResizingCell.git", :tag => "v0.0.2" }
  s.source_files  = "HTKDynamicResizingCell/**/*.{h,m}"
  s.requires_arc = true
end
