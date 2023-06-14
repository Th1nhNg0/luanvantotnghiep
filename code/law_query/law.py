import re


class Paths:
    def __init__(self, node: 'Node'):
        self.paths = []
        self._traverse(node)

    def _traverse(self, node: 'Node'):
        # travel to root
        path = {
            'node_type': node.node_type,
            'node_id': node.node_id,
        }
        self.paths = [path] + self.paths
        if node.parent is not None:
            self._traverse(node.parent)

    def __repr__(self):
        s = ''
        for path in self.paths:
            s += f'{path["node_type"]} {path["node_id"]} -> '
        return s[:-4]

    def __str__(self):
        return self.__repr__()

    def __len__(self):
        return len(self.paths)

    def __getitem__(self, idx):
        return self.paths[idx]

    def __iter__(self):
        return iter(self.paths)


class Node:
    """Node class"""

    def __init__(self, name, content, node_type, node_id, parent=None):
        """Constructor of Node class

        Parameters
        ----------
        name : str
            name of node
        content : str
            content of node
        node_type : str
            node type
        node_id : int
            node id
        parent : Node, optional
            parent of node, by default None
        """

        self.name = name
        self.content = content
        self.node_id = node_id
        self.node_type = node_type
        self.children = []
        self.parent = parent
        self.path = Paths(self)

    def add_child(self, obj):
        """Add child to node

        Parameters
        ----------
        obj : Node
            child node
        """
        self.children.append(obj)

    def __repr__(self):
        return self.name

    def __str__(self):
        return f'Name: {self.name}\nNode type: {self.node_type}\nNode id: {self.node_id}\nChildren: {len(self.children)}\nContent:\n{self.content}'

    def asdict(self):
        """Convert node to dict"""
        return {
            'name': self.name,
            'node_id': self.node_id,
            'node_type': self.node_type,
            'children': [i.asdict() for i in self.children],
        }


class Tree:
    """Tree class"""

    def __init__(self, name, content):
        self.root = self._create_tree(name, content, 'root')

    def _create_tree(self, name, content, node_type, parent=None):
        root = Node(name, content, node_type,
                    self._make_node_id(name, node_type), parent)
        pattern = r'^“(.*?)”$'
        matches = re.finditer(pattern, content, re.MULTILINE | re.DOTALL)
        new_content = content
        for match in matches:
            new_content = new_content.replace(match.group(0), '')
        matches = re.findall(
            r'^(Phần thứ [\d\w]+.*)$', new_content, flags=re.MULTILINE)
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
            matches = re.findall(r'^Phần thứ ([\d\w]+)', name)
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


class LawQuery:
    """LawQuery class"""

    def __init__(self, text: str, metadata: dict, raw_text: str):
        self.metadata = metadata
        self.tree = Tree(metadata['ten_van_ban'], text)
        self.text = text
        self.nodes = []
        self._traverse(self.tree.root)
        self.raw_text = raw_text

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

        self.nodes.append(node)
        for child in node.children:
            self._traverse(child)

    def find_node_by_path(self, node_path: list[dict]) -> Node:
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

    def query(self, node_type: str = None, node_id: str = None, name: str = None, parent: Node = None) -> list[Node]:
        """Query nodes in tree

        Parameters
        ----------
        node_type : str, optional
            node type, by default None
        node_id : [type], optional
            node id, by default None
        name : str, optional
            name of node, by default None

        Returns
        ------- 
        list[Node]
            list of nodes in tree
        """
        results = []
        for node in self.nodes:
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

    def print_tree(self):
        print(self.tree)
