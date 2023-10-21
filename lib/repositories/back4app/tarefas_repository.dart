import 'package:tarefa_app/model/tarefas_back4_model.dart';
import 'package:tarefa_app/repositories/back4app/custon_dio.dart';

class TarefasB4AppRepository {
  final _diob4 = CustonDio();

  TarefasB4AppRepository();

  Future<TarefasBack4Model> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";

    if (naoConcluidas) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _diob4.dio.get(url);

    return TarefasBack4Model.fromJson(result.data);
  }

  Future criar(TarefaBack4Model tarefaBack4Model) async {
    try {
      await _diob4.dio.post("/Tarefas", data: tarefaBack4Model.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future atualizar(TarefaBack4Model tarefaBack4Model) async {
    try {
      await _diob4.dio.put("/Tarefas/${tarefaBack4Model.objectId}",
          data: tarefaBack4Model.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future remover(String id) async {
    try {
      await _diob4.dio.delete("/Tarefas/$id");
    } catch (e) {
      throw e;
    }
  }
}
