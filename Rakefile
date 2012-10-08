#!/usr/bin/env rake
require "bundler/gem_tasks"
require "fileutils"

namespace :emoji do

  desc "Bundle emoji into full renderer assets"
  task :update  do
    gemoji = Bundler.load.specs.find{|s| s.name == "gemoji" }
    gem_emojis_path = File.join(gemoji.full_gem_path, "images", "emoji")
    gitki_emojis_path = File.join(File.expand_path("."), "lib", "gitki", "renderers", "full", "assets", "emoji")
    FileUtils.rm_r gitki_emojis_path if File.exist?(gitki_emojis_path)
    FileUtils.mkdir_p gitki_emojis_path
    FileUtils.cp_r gem_emojis_path, gitki_emojis_path
  end

  desc "Remove emoji to reduce archive size"
  task :remove do
    gitki_emojis_path = File.join(File.expand_path("."), "lib", "gitki", "renderers", "full", "assets", "emoji")
    FileUtils.rm_r gitki_emojis_path if File.exist?(gitki_emojis_path)
  end
end

