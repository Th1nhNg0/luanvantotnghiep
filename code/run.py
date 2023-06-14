from lawquery import Engine, list_documents

print(list_documents())

engine = Engine(list_documents()[0])

print(engine)
