from swiplserver import PrologThread


class Allies:
    def __init__(self, name: str):
        self.name = name

    def query(self):
        return f"allies(X, '{self.name}')"

    def execute(self, prolog: PrologThread):
        response = prolog.query(self.query())
        if not response or len(response) == 0:
            print(f'{self.name} не существует или у него нет союзников.')
        else:
            print(f"Найдены следующие союзники {self.name}:")
            for index in range(0, len(response)):
                print(response[index]['X'])


