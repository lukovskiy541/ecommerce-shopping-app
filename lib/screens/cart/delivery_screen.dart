import 'package:ecommerce_app/blocs/bloc/deliverysearch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<DeliverysearchBloc>().add(InitializeDeliverySearchEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нова пошта'),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 20,
              style: const TextStyle(
                fontSize: 17,
                height: 0.9,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String? newSearchTerm) {
                if (newSearchTerm != null) {
                  print(newSearchTerm);
                  context
                      .read<DeliverysearchBloc>()
                      .add(SetSearchTermEvent(newSearchTerm: newSearchTerm));
                }
              },
              decoration: InputDecoration(
                hintText: 'Пошук',
                hintStyle: TextStyle(
                    fontSize: 17,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 3, top: -3),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<DeliverysearchBloc, DeliverySearchState>(
              builder: (context, state) {
                if (state.deliverySearchList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: state.deliverySearchList.length,
                  itemBuilder: (context, index) {
                    if (state.searchTerm.isNotEmpty &&
                        !state.deliverySearchList[index]
                            .toLowerCase()
                            .contains(state.searchTerm.toLowerCase())) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      title: Text(state.deliverySearchList[index]),
                      onTap: () {
                        Navigator.of(context)
                            .pop(state.deliverySearchList[index]);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
