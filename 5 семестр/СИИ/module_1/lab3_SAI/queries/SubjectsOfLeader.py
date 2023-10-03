from swiplserver import PrologThread


class SubjectsOfLeader:
    def __init__(self, name: str):
        self.name = name

    def query(self):
        return f"subject(X, '{self.name}')"

    def execute(self, prolog: PrologThread):
        response = prolog.query(self.query())
        if not response or len(response) == 0:
            print(f'{self.name} не является правителем или нет информации о его подданных.')
        else:
            print(f"Найдены следующие подданные {self.name}:")
            for index in range(0, len(response)):
                print(response[index]['X'])


