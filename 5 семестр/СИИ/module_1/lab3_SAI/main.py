from swiplserver import PrologMQI, create_posix_path, PrologThread
from queries import CountryOfLiving, SideOfTheWorld, SubjectsOfLeader, Allies, Novigrad
import re

KNOWLEDGE_BASE_PATH = r'C:\Users\Honor\Downloads\ml.pl'

examples = [
    'В какой стране живет *имя_героя*?',
    'В какой части Континента находится *название_страны*?',
    'Перечисли подданных *имя_императора/имя_короля*.',
    'Кто является союзником *имя_героя*?',
    '*имя_героя* может находиться в Новиграде?'
]

patterns = {
    r'В какой стране живет (.+)\?': CountryOfLiving.CountryOfLiving,
    r'В какой части Континента находится (.+)\?': SideOfTheWorld.SideOfTheWorld,
    r'Перечисли подданных (.+)\.': SubjectsOfLeader.SubjectsOfLeader,
    r'Кто является союзником (.+)\?': Allies.Allies,
    r'(.+) может находиться в Новиграде\?': Novigrad.Novigrad
}


with PrologMQI() as mqi:
    with mqi.create_thread() as prolog:
        path = create_posix_path(KNOWLEDGE_BASE_PATH)
        prolog.query(f'consult("{path}")')
        print("Подключение с базой знаний по вселенной Witcher установлено.\n")
        print('Вам доступны следующие типы запросов:')
        for i in range(0, len(examples)):
            print(str(i + 1) + ")", examples[i])
        print('Для выхода напишите "exit".')
        while True:
            query = input('> ')
            if query.lower() == 'exit':
                break
            for pattern in patterns:
                match = re.match(pattern, query, re.IGNORECASE)
                if match is None:
                    continue
                processor = patterns[pattern](*match.groups())
                processor.execute(prolog)
                break
            else:
                print('Запрос невалиден.')



