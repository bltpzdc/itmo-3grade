from swiplserver import PrologThread


class SideOfTheWorld:
    def __init__(self, name: str):
        self.name = name

    def query(self):
        return f"location('{self.name}', X)"

    def execute(self, prolog: PrologThread):
        response = prolog.query(self.query())
        if not response or len(response) == 0:
            print(f'Страны {self.name} не существует или нет информации о ее местонахождении.')
        else:
            print(f'{self.name} находится на {response[0]["X"]}.')

