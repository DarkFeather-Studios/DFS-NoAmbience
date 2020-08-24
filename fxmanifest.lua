fx_version 'bodacious'

game 'gta5'

dependency "dfs"

client_scripts {
    'dfs_noambience.lua',
    'config_cl.lua'
}

dependency 'mysql-async'
dependency 'disc-hud'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "dfs_noambience_sv.lua"
}

--data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'
--data_file 'POPSCHED_FILE' 'popcycles.dat'