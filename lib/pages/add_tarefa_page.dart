import 'package:flutter/material.dart';
import 'package:tarefa_app/model/tarefas_back4_model.dart';
import 'package:tarefa_app/repositories/back4app/tarefas_repository.dart';

class AddTarefa extends StatefulWidget {
  final TarefaBack4Model? tarefa;
  const AddTarefa({super.key, this.tarefa});

  @override
  State<AddTarefa> createState() => _AddTarefaState();
}

class _AddTarefaState extends State<AddTarefa> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  bool isEdit = false;
  TarefasB4AppRepository tarefaRepository = TarefasB4AppRepository();

  @override
  void initState() {
    super.initState();
    TarefaBack4Model? todo = widget.tarefa;
    if (todo != null) {
      isEdit = true;
      tituloController.text = todo.titulo;
      descricaoController.text = todo.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text(isEdit ? 'Editar Tarefa' : 'Adicionar Tarefa')),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          controller: tituloController,
          decoration: const InputDecoration(hintText: 'Titulo'),
        ),
        TextField(
          controller: descricaoController,
          decoration: const InputDecoration(hintText: 'Descrição'),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await tarefaRepository.criar(TarefaBack4Model.criar(
                  tituloController.text, descricaoController.text, false));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit ? 'Atualizar' : 'Salvar'),
            ))
      ]),
    ));
  }
}
