import 'package:flutter/material.dart';
import 'package:tarefa_app/model/tarefas_back4_model.dart';
import 'package:tarefa_app/pages/add_tarefa_page.dart';
import 'package:tarefa_app/repositories/back4app/tarefas_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TarefasB4AppRepository tarefaRepository = TarefasB4AppRepository();
  var _tarefasB4 = TarefasBack4Model([]);
  var descricaoContoller = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefasB4 = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("Lista de Tarefas"))),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Add'),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTarefa(),
                  ));
              setState(() {
                carregando = true;
              });
              obterTarefas();
            },
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Apenas não concluídos",
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                          value: apenasNaoConcluidos,
                          onChanged: (bool value) {
                            apenasNaoConcluidos = value;
                            obterTarefas();
                          })
                    ],
                  ),
                ),
                carregando
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: Visibility(
                          visible: carregando,
                          replacement: ListView.builder(
                              itemCount: _tarefasB4.tarefas.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var tarefa = _tarefasB4.tarefas[index];
                                return Dismissible(
                                    onDismissed: (DismissDirection
                                        dismissDirection) async {
                                      await tarefaRepository
                                          .remover(tarefa.objectId);
                                      obterTarefas();
                                    },
                                    key: Key(tarefa.titulo),
                                    child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddTarefa(
                                                  tarefa: tarefa,
                                                ),
                                              ));
                                          setState(() {
                                            carregando = true;
                                          });
                                          obterTarefas();
                                        },
                                        child: Card(
                                          elevation: 4.0,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          // Cor de fundo do Card no tema escuro
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors
                                                  .blue, // Cor do fundo do CircleAvatar
                                              child: Text(
                                                '${index + 1}',
                                                style: const TextStyle(
                                                  color: Colors
                                                      .white, // Cor do número
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              tarefa.titulo,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .white, // Cor do título no tema escuro
                                              ),
                                            ),
                                            subtitle: Text(
                                              tarefa.descricao,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[
                                                    400], // Cor da descrição no tema escuro
                                              ),
                                            ),
                                            trailing: Checkbox(
                                              onChanged: (bool? value) async {
                                                tarefa.concluido = value!;
                                                await tarefaRepository
                                                    .atualizar(tarefa);
                                                obterTarefas();
                                              },
                                              value: tarefa.concluido,
                                              activeColor: Colors
                                                  .blue, // Cor quando o Checkbox está marcado
                                              checkColor: Colors
                                                  .white, // Cor do check dentro do Checkbox
                                            ),
                                          ),
                                        )));
                              }),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
