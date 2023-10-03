from swiplserver import PrologThread


class CountryOfLiving:
    def __init__(self, name: str):
        self.name = name

    def query(self):
        return f"country('{self.name}', X)"

    def execute(self, prolog: PrologThread):
        response = prolog.query(self.query())
        if not response or len(response) == 0:
            print(f'Персонажа {self.name} не существует или нет информации о стране его пребывания.')
        else:
            print(f'{self.name} живет в {response[0]["X"]}.')

