task :clear_cw do
  CarrierWave.clean_cached_files!
end
