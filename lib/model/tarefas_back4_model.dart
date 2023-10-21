class TarefasBack4Model {
  List<TarefaBack4Model> tarefas = [];

  TarefasBack4Model(this.tarefas);

  TarefasBack4Model.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefaBack4Model>[];
      json['results'].forEach((v) {
        tarefas.add(TarefaBack4Model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaBack4Model {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String titulo = "";
  String descricao = "";
  bool concluido = false;

  TarefaBack4Model.criar(this.titulo, this.descricao, this.concluido);

  TarefaBack4Model(this.objectId, this.createdAt, this.updatedAt,
      this.descricao, this.concluido);

  TarefaBack4Model.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['titulo']    = titulo;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
