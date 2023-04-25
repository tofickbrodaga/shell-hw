#!/bin/bash
# Указываем путь к файлу со списком фамилий
input_file="college_surnames.txt"
# Указываем путь к файлу, в который будут записываться выбранные фамилии
output_file="expelled_surnames.txt"
# Определяем кол-во фамилий, которые нужно выбрать
num_surnames=20
# Указываем путь к папке, в которой будут сохраняться изображения
image_folder="expelled"
# Косметические процедурки с файлами
# Если один из txt файлов не найден 
if [[ ! -f $input_file ]] || [[ ! -f $output_file ]]
then
    echo "Input or output file not found, please create them"
    exit 1
fi
# Файл пустой
if [[ ! -s $input_file ]]
then
    echo "File $input_file is empty, please write surnames in file"
    exit 1
fi
# Нет папки для изображений
if [[ ! -d $image_folder ]]
then
    echo "Folder $image_folder not found, creating..."
    mkdir -p $image_folder
fi

# Используем команду shuf для выбора случайных фамилий и записываем
shuf -n $num_surnames $input_file > $output_file
# Генерируем URL для API и загружаем изображения в папку
while read name;
do
    api_url="https://cataas.com/cat/says/$name%20отчислен?width=500&height=500&color=yellow&size=100&format=png"
    # Генерируем имя файла
    file_name="$name.png"
    # Загружаем изображение в папку
    curl -s $api_url > "$image_folder/$file_name"
done < $output_file
