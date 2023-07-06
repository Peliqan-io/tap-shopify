import sys
sys.path.insert(1, '..')
import tap_shopify

tap_shopify.main()

# Run discovery mode: python3 tap-peliqan.py --discover --config config.json > catalog.json
# Run sync mode: python3 tap-peliqan.py --config config.json --catalog catalog.json --state state.json
# Sync to target: python3 tap-peliqan.py --config config.json --catalog catalog.json --state state.json | target-postgres --config target_config.json
