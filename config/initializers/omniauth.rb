Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1111137025914949', '2bf6478f89569143c2bd755c086ce398'
end