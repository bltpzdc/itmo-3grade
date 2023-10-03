from swiplserver import PrologThread


class Novigrad:
    def __init__(self, name: str):
        self.name = name

    def query(self):
        return f"can_be_in_Novigrad('{self.name}')"

    def execute(self, prolog: PrologThread):
        response = prolog.query(self.query())
        if not response:
            print(f'{self.name} не существует или этому персонажу запрещено быть в Новиграде.')
        else:
            print(f"{self.name} разрешено быть в Новиграде.")


