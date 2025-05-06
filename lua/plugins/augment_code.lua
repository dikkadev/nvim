local should_load_augment_code = os.getenv("NVIM_AUGMENT_CODE") == "true"

if should_load_augment_code then
  return {
    {
      "augmentcode/augment.vim",
    },
  }
else
  return {}
end
