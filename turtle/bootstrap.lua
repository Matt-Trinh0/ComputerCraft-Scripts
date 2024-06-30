-- Download script downloader program
SCRIPT_DOWNLOADER_URL = ''

function main()
    io.write(string.format('Downloading script downloader from %s', SCRIPT_DOWNLOADER_URL))
    local script_downloader = http.get(SCRIPT_DOWNLOADER_URL)
    local script_downloader_data = script_downloader.readAll()
    script_downloader.close()

    print('Downloading script downloader')
    local script_downloader_filename = 'download_script.lua'
    local script_downloader_file = io.open(script_downloader_filename, 'w')
    io.output(script_downloader_file)
    io.write(script_downloader_data)
    io.close(script_downloader_file)
end

main()