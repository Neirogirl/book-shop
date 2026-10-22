const fs = require('fs');
const https = require('https');

// Список ISBN (для тех книг, которые точно есть в Open Library)
const isbnList = [
    '9785040980790', // Мастер и Маргарита
    '9780451524935', // 1984
    '9780143058144', // Преступление и наказание
    '9780747532743', // Гарри Поттер
    '9780449912423', // Три товарища
    '9781400079988', // Война и мир
    '9780143035008', // Анна Каренина
    '9780735211292', // Атомные привычки
    '9780374533557', // Думай медленно
    '9780062316097'  // Sapiens
];

async function fetchBookData(isbn) {
    return new Promise((resolve) => {
        // Запрос к Open Library по ISBN
        const url = `https://openlibrary.org/api/books?bibkeys=ISBN:${isbn}&format=json&jscmd=data`;
        
        https.get(url, (res) => {
            let data = '';
            res.on('data', (chunk) => data += chunk);
            res.on('end', () => {
                try {
                    const json = JSON.parse(data);
                    const key = `ISBN:${isbn}`;
                    
                    if (!json[key]) {
                        console.log(`ISBN ${isbn} не найден.`);
                        return resolve(null); 
                    }
                    
                    const bookData = json[key];
                    
                    // Формируем объект под нашу модель Book
                    resolve({
                        title: bookData.title || 'Без названия',
                        author: (bookData.authors && bookData.authors[0].name) || 'Неизвестен',
                        price: Math.floor(Math.random() * 400) + 300, // Рандомная цена 300-700
                        description: bookData.notes || 'Описание отсутствует',
                        // Берем большую обложку, если есть
                        coverUrl: (bookData.cover && bookData.cover.large) 
                                    ? bookData.cover.large 
                                    : ''
                    });
                } catch (e) { 
                    console.log(`Ошибка при обработке ISBN ${isbn}`);
                    resolve(null); 
                }
            });
        }).on('error', (e) => {
            console.log(`Ошибка сети: ${e.message}`);
            resolve(null);
        });
    });
}

async function main() {
    const books = [];
    console.log('Начинаем сбор данных из Open Library...');
    
    for (const isbn of isbnList) {
        console.log(`Ищем ISBN: ${isbn}...`);
        const book = await fetchBookData(isbn);
        if (book) {
            books.push(book);
            console.log(`   -> Найдено: ${book.title}`);
        }
        // Пауза, чтобы не забанили
        await new Promise(r => setTimeout(r, 1000)); 
    }
    
    fs.writeFileSync('books.json', JSON.stringify(books, null, 2));
    console.log(`\nГотово! Собрано ${books.length} книг. Файл books.json создан.`);
}

main();