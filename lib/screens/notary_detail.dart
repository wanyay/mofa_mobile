import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/notary_history.dart';
import 'package:mofa_mobile/providers/notary_provider.dart';
import 'package:mofa_mobile/util/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotaryDetail extends StatefulWidget {
  final NotaryHistory history;

  const NotaryDetail({super.key, required this.history});

  @override
  State<NotaryDetail> createState() => _NotaryDetailState();
}

class _NotaryDetailState extends State<NotaryDetail> {
  final String phone = AuthManager.getPhone();
  final String name = AuthManager.getName();
  final String nrc = AuthManager.getNRC();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotaryDetail();
    });
  }

  Future<void> _loadNotaryDetail() async {
    final notaryProvider = Provider.of<NotaryProvider>(context, listen: false);
    switch (widget.history.notaryID) {
      case 1:
        await notaryProvider.getMatrixMarkDetail(widget.history.ticketID);
        break;
      case 2:
        await notaryProvider.getMatrixPassDetail(widget.history.ticketID);
        break;
      case 3:
        await notaryProvider.getBachelorCertificateDetail(
          widget.history.ticketID,
        );
        break;
      default:
        notaryProvider.setError('Unknown notary type');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF6A2C91);
    const Color backgroundColor = Color(0xFFE3DFFD);
    const Color secondaryTextColor = Colors.black87;
    const Color labelColor = Colors.black54;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        // The AppBar has the same background color and no shadow
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // Handle back button tap
            Navigator.of(context).pop();
          },
          child: const Row(
            children: [
              SizedBox(width: 8.0), // A little spacing
              Icon(Icons.arrow_back_ios, color: primaryTextColor, size: 20),
              Text(
                'Back',
                style: TextStyle(color: primaryTextColor, fontSize: 16),
              ),
            ],
          ),
        ),
        leadingWidth: 80, // Adjust width to fit the icon and text
      ),
      body: Consumer<NotaryProvider>(
        builder: (context, notaryProvider, child) {
          if (notaryProvider.status == NotaryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (notaryProvider.status == NotaryStatus.failure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${notaryProvider.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          dynamic notary;
          if (notaryProvider.status == NotaryStatus.success) {
            switch (widget.history.notaryID) {
              case 1:
                notary = notaryProvider.matrixMarkDetail;
                break;
              case 2:
                notary = notaryProvider.matrixPassDetail;
                break;
              case 3:
                notary = notaryProvider.bachelorCertificateDetail;
                break;
              default:
                return const Center(child: Text('Error: Unknown notary type'));
            }
          }

          if (notary == null) {
            return const Center(
              child: Text('Error: Could not load notary details.'),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- Title Text ---
                  Text(
                    widget.history.notaryName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.5, // Line height
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- QR Code ---
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: widget.history.ticketID,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Information Card ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.08),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          'Phone No:',
                          phone,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'Name:',
                          name,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'မှတ်ပုံတင်အမှတ်:',
                          nrc,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'Reference No:',
                          widget.history.ticketID,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'ခုံနံပါတ်:',
                          // This is now safe to access
                          notary.rollNo,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'ခုနှစ်:',
                          // This is now safe to access
                          notary.year,
                          labelColor,
                          secondaryTextColor,
                        ),
                        const Divider(height: 30),
                        if (widget.history.notaryID == 3)
                          _buildInfoRow(
                            'ဘွဲ့ အမည်:',
                            notary.degree,
                            labelColor,
                            secondaryTextColor,
                          )
                        else
                          _buildInfoRow(
                            'ကျောင်းအမည်:',
                            notary.school,
                            labelColor,
                            secondaryTextColor,
                          ),
                        const Divider(height: 30),
                        if (widget.history.notaryID == 3)
                          _buildInfoRow(
                            'အောင်မြင်သည့် တက္ကသိုလ်:',
                            notary.passUniversity.name,
                            labelColor,
                            secondaryTextColor,
                          )
                        else
                          _buildInfoRow(
                            'အောင်မြင်သည့် မြို့နယ်:',
                            notary.passTownship.name,
                            labelColor,
                            secondaryTextColor,
                          ),
                        const Divider(height: 30),
                        _buildInfoRow(
                          'ထုတ်ယူသည့် မြို့နယ်:',
                          notary.getTownship.name,
                          labelColor,
                          secondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    Color labelColor,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 16)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
