# @summary A custom type for systemd service enable states
type Stunnel::Enable = Variant[Boolean, Enum['mask']]
