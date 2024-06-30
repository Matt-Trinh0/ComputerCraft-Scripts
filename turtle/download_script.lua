-- Script to download an arbitrary file via GET request
INTERACTIVE = false
URL = ''

local args = {...}

function split(s, delimiter)
    local delimiter = delimiter or '%s'
    local parts = {}
    for part in string.gmatch(s, string.format('[^%s]+', delimiter)) do
        table.insert(parts, part)
    end
    return parts
end

function parse_args(args)
    for i, arg in ipairs(args) do
        if arg == '--interactive' then
            INTERACTIVE = true
        elseif arg == '--url' then
            URL = args[i + 1]
        end
    end
end

function main(args)
    -- Check flags and take URL input if in interactive mode
    if INTERACTIVE and URL == '' then
        io.write('Enter the URL of a file to download: ')
        URL = io.read()
    end
    
    -- Extract the file name from the URL
    local split_url = split(URL, '/')
    local file_name = split_url[#split_url]
    
    -- Download the file and read the data into memory
    local url_response = http.get(URL)
    local url_data = url_response.readAll()
    url_response.close()

    -- Write the downloaded file into the local disk
    print(string.format('Downloading file %s from %s', file_name, URL))
    local local_file = io.open(file_name, 'w')
    io.output(local_file)
    io.write(url_data)
    io.close(local_file)
end

main(args)