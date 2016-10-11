local nn = require 'nn'

local Model = {}

function Model:createAutoencoder(X, nOfHiddenUnits)
  local featureSize = X:size(2) * X:size(3)

  -- Create encoder
  self.encoder = nn.Sequential()
  self.encoder:add(nn.View(-1, featureSize))
  self.encoder:add(nn.Linear(featureSize, nOfHiddenUnits))
  self.encoder:add(nn.ReLU(true))

  -- Create decoder
  self.decoder = nn.Sequential()
  self.decoder:add(nn.Linear(nOfHiddenUnits, featureSize))
  self.decoder:add(nn.Sigmoid(true))
  self.decoder:add(nn.View(X:size(2), X:size(3)))

  -- Create autoencoder
  self.autoencoder = nn.Sequential()
  self.autoencoder:add(self.encoder)
  self.autoencoder:add(self.decoder)
end

return Model
