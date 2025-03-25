part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}
