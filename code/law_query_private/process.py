import re
import json
import gzip


class Node:
    def __init__(self, name, content, node_type, node_id, parent=None):
        self.name = name
        self.content = content
        self.node_id = node_id
        self.node_type = node_type
        self.children = []
        self.parent = parent

    def add_child(self, obj: 'Node'):
        obj.parent = self
        self.children.append(obj)

    def __repr__(self):
        return self.name

    def __str__(self):
        return f'--node--\nName: {self.name}\nNode type: {self.node_type}\nNode id: {self.node_id}\nChildren: {len(self.children)}\nContent: {len(self.content)} characters\n--node--\n'

    def print_path(self):
        s = ''
        node = self
        while node is not None:
            s = node.name + ' > ' + s
            node = node.parent
        return s[:-3]

    def asdict(self):
        return {
            'name': self.name,
            'node_id': self.node_id,
            'node_type': self.node_type,
            'children': [i.asdict() for i in self.children],
        }


class Tree:
    def __init__(self, metadata: dict, content: str, raw_text: str):
        self.root = self._create_tree(metadata['ten_van_ban'], content, 'root')
        self.raw_text = raw_text
        self.metadata = metadata

    def _create_tree(self, name, content, node_type, parent=None) -> Node:
        root = Node(name, content, node_type,
                    self._make_node_id(name, node_type), parent)
        pattern = r'^“(.*?)”$'
        matches = re.finditer(pattern, content, re.MULTILINE | re.DOTALL)
        new_content = content
        for match in matches:
            new_content = new_content.replace(match.group(0), '')
        matches = re.findall(
            r'^(Phần thứ [\d\w]+.*)$', new_content, flags=re.MULTILINE | re.IGNORECASE)
        node_type = 'phần'
        if len(matches) == 0:
            matches = re.findall(
                r'^(Chương [\d\w]+.*)$', new_content, flags=re.MULTILINE)
            node_type = 'chương'
        if len(matches) == 0:
            matches = re.findall(
                r'^(Mục [\d|I|V|X|L|C|D|M]+.*)$', new_content, flags=re.MULTILINE)
            node_type = 'mục'
        if len(matches) == 0:
            matches = re.findall(
                r'^(Điều [\d]+.*)$', new_content, flags=re.MULTILINE)
            node_type = 'điều'
        if len(matches) == 0:
            matches = re.findall(
                r'^(\d+\. .*)$', new_content, flags=re.MULTILINE)
            node_type = 'khoản'
        if len(matches) == 0:
            matches = re.findall(r'^(\d+\.\d+\.? .*)$',
                                 new_content, flags=re.MULTILINE)
            node_type = 'khoản'
        if len(matches) == 0:
            matches = re.findall(r'^(\d+\.\d+\.\d+\.? .*)$',
                                 new_content, flags=re.MULTILINE)
            node_type = 'khoản'
        if len(matches) == 0:
            matches = re.findall(r'^(\d+\.[\d\w]+\. .*)$',
                                 new_content, flags=re.MULTILINE)
            node_type = 'điểm'
        if len(matches) == 0:
            matches = re.findall(r'^(\w\).*)$', new_content,
                                 flags=re.MULTILINE)
            node_type = 'điểm'
        if len(matches) == 0:
            return root
        for i in range(len(matches)):
            idx = content.find(matches[i])
            name = matches[i]
            if i == len(matches)-1:
                child_content = content[idx+len(name):].strip()
            else:
                child_content = content[idx +
                                        len(name):content.find(matches[i+1])].strip()
            root.add_child(self._create_tree(
                name, child_content, node_type, root))
        return root

    def _make_node_id(self, name, node_type):
        node_id = None
        if node_type == 'root':
            node_id = name
        if node_type == 'phần':
            matches = re.findall(
                r'^Phần thứ ([\d\w]+)', name, flags=re.IGNORECASE)
            node_id = matches[0]
        if node_type == 'chương':
            matches = re.findall(r'^Chương ([\d\w]+)', name)
            node_id = matches[0]
        if node_type == 'mục':
            matches = re.findall(r'^Mục ([\d|I|V|X|L|C|D|M]+)', name)
            node_id = matches[0]
        if node_type == 'khoản':
            matches = re.findall(
                r'^(\d+\.\d+\.\d+)\.? |^(\d+\.\d+)\.? |^(\d+)\.', name)
            node_id = matches[0][0] if len(matches[0][0]) > 0 else matches[0][1] if len(
                matches[0][1]) > 0 else matches[0][2]
        if node_type == 'điều':
            matches = re.findall(r'^Điều ([\w\d]+)', name)
            node_id = matches[0]
        if node_type == 'điểm':
            matches = re.findall(r'^(\w)\)|^(\d+\.[\d\w]+)\. ', name)
            node_id = matches[0][0] if len(
                matches[0][0]) > 0 else matches[0][1]
        return node_id

    def __repr__(self):
        return self._print_tree(self.root)

    def __str__(self):
        return self._print_tree(self.root)

    def _print_tree(self, node: 'Node', level=0):
        s = ''
        s += '  '*level + node.name + '\n'
        if len(node.children) == 0 and len(node.content) > 0:
            content = node.content
            content = re.sub(r'\n', '\n'+'  '*(level+1)+'📄', content)
            s += '  '*(level+1)+'📄' + content + '\n'
        else:
            for child in node.children:
                s += self._print_tree(child, level+1)
        return s

    def export(self):
        data = {
            'metadata': self.metadata,
            'tree': self._export(self.root),
            'raw_text': self.raw_text,
        }
        return data

    def _export(self, node: Node):
        to_find = node.content
        if to_find == '':
            to_find = node.name
        pivot = self.raw_text.find(to_find)
        if pivot == -1 and node.node_type == 'root':
            pivot = 0
        if pivot == -1 and node.node_type != 'root':
            print('❌', node.name)
        return {
            'name': node.name,
            'node_id': node.node_id,
            'node_type': node.node_type,
            'content': {
                'start': pivot,
                'end': pivot + len(to_find),
            },
            'children': [self._export(child) for child in node.children],

        }


class ITree:
    def __init__(self, data: dict):
        self.raw_text = data['raw_text']
        self.metadata = data['metadata']
        self.root = self._import(data['tree'])

    def _import(self, data: dict) -> Node:
        content = self.raw_text[data['content']
                                ['start']:data['content']['end']]
        root = Node(data['name'], content, data['node_type'],
                    data['node_id'])
        for child in data['children']:
            root.add_child(self._import(child))
        return root

    def __repr__(self):
        return self._print_tree(self.root)

    def __str__(self):
        return self._print_tree(self.root)

    def _print_tree(self, node: 'Node', level=0):
        s = ''
        s += '  '*level + node.name + '\n'
        if len(node.children) == 0 and len(node.content) > 0 and node.content != node.name:
            content = node.content
            content = re.sub(r'\n', '\n'+'  '*(level+1)+'📄', content)
            s += '  '*(level+1)+'📄' + content + '\n'
        else:
            for child in node.children:
                s += self._print_tree(child, level+1)
        return s


class LawQuery:
    tree: ITree

    def __init__(self, filepath: str):
        with gzip.open(filepath, 'rb') as f:
            data = json.loads(f.read())
        self.tree = ITree(data)
        self.__nodes = []
        self._traverse(self.tree.root)

    def _traverse(self, node: Node):
        """Traverse tree and add node to self.nodes

        Parameters
        ----------
        node : Node
            node of tree

        Returns
        -------
        None
        """

        self.__nodes.append(node)
        for child in node.children:
            self._traverse(child)

    def query_by_paths(self, node_path: list[dict]) -> Node:
        nodes = []
        for path in node_path:
            node_type = path['node_type'] if 'node_type' in path else None
            node_id = path['node_id'] if 'node_id' in path else None
            name = path['name'] if 'name' in path else None
            new_nodes = []
            for node in nodes:
                new_nodes += self.query(node_type=node_type,
                                        node_id=node_id, name=name, parent=node)
            if len(nodes) == 0:
                new_nodes += self.query(node_type=node_type,
                                        node_id=node_id, name=name)
            nodes = new_nodes
        return nodes

    def query(self, name: str = None, node_type: str = None, node_id: str = None,  parent: Node = None) -> list[Node]:
        results = []
        for node in self.__nodes:
            if node_type is not None and node.node_type != node_type:
                continue
            if node_id is not None and node.node_id != node_id:
                continue
            if name is not None and name.lower() not in node.name.lower():
                continue
            if parent is not None and node.parent != parent:
                continue
            results.append(node)
        return results

    def __repr__(self):
        return self.tree.__repr__()

    def __str__(self):
        return self.tree.__str__()
