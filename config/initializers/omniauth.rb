Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '448981068445455', 'c1576820bcca019f62bc630e457b0713' , :display => 'popup'} 
end