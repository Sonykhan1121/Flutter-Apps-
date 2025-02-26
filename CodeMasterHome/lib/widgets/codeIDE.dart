import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeIDEScreen extends StatefulWidget {
  const CodeIDEScreen({super.key});

  @override
  State<CodeIDEScreen> createState() => _CodeIDEScreenState();
}

class _CodeIDEScreenState extends State<CodeIDEScreen> {
  String selectedLanguage = 'python';
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  String _output = '';
  bool _isRunning = false;
  bool _showOutput = false;
  bool _isDark = true;
  bool _showInput = false;

  final Map<String, String> _codeTemplates = {
    'python': 'def main():\n    print("Hello, World!")\n\nif __name__ == "__main__":\n    main()',
    'javascript': 'function main() {\n    console.log("Hello, World!");\n}\n\nmain();',
    'java': 'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}',
    'c': '#include <stdio.h>\n\nint main() {\n    printf("Hello, World!\\n");\n    return 0;\n}',
    'cpp': '#include <iostream>\n\nint main() {\n    std::cout << "Hello, World!" << std::endl;\n    return 0;\n}',
    'go': 'package main\n\nimport "fmt"\n\nfunc main() {\n    fmt.Println("Hello, World!")\n}',
    'rust': 'fn main() {\n    println!("Hello, World!");\n}',
    'ruby': 'def main\n    puts "Hello, World!"\nend\n\nmain',
    'kotlin': 'fun main() {\n    println("Hello, World!")\n}',
    'swift': 'print("Hello, World!")',
  };

  void _changeLanguage(String language) {
    setState(() {
      selectedLanguage = language;
      _codeController.text = _codeTemplates[language] ?? '';
    });
  }

  void _runCode() {
    // In a real app, this would send the code to a backend service for execution
    setState(() {
      _isRunning = true;
      _showOutput = true;
    });

    // Simulating code execution with a delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isRunning = false;
        // This is a mock output - in a real app, this would be the actual execution result
        if (_inputController.text.isNotEmpty) {
          _output = 'Program executed successfully with input:\n${_inputController.text}\n\nOutput:\nHello, World!';
        } else {
          _output = 'Program executed successfully!\n\nOutput:\nHello, World!';
        }
      });
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    _codeController.text = _codeTemplates[selectedLanguage] ?? '';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        title: const Text('Code IDE'),
        actions: [
          IconButton(
            icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
            tooltip: 'Toggle theme',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Code saved')),
              );
            },
            tooltip: 'Save code',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share code')),
              );
            },
            tooltip: 'Share code',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildEditor(),
                ),
                if (_showOutput) ...[
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    flex: 3,
                    child: _buildOutputConsole(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isRunning ? null : _runCode,
        backgroundColor: _isRunning ? Colors.grey : Colors.green,
        child: _isRunning
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      color: _isDark ? const Color(0xFF252525) : Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildLanguageDropdown(),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Run'),
            onPressed: _isRunning ? null : _runCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            icon: Icon(_showInput ? Icons.keyboard_hide : Icons.keyboard),
            label: Text(_showInput ? 'Hide Input' : 'Show Input'),
            onPressed: () {
              setState(() {
                _showInput = !_showInput;
              });
            },
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            icon: Icon(_showOutput ? Icons.visibility_off : Icons.visibility),
            label: Text(_showOutput ? 'Hide Output' : 'Show Output'),
            onPressed: () {
              setState(() {
                _showOutput = !_showOutput;
              });
            },
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.format_indent_increase),
            onPressed: () {
              // Format code - in a real app, this would implement proper indentation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Code formatted')),
              );
            },
            tooltip: 'Format code',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Open settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings')),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _isDark ? const Color(0xFF333333) : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          dropdownColor: _isDark ? const Color(0xFF333333) : Colors.grey[300],
          icon: const Icon(Icons.arrow_drop_down),
          style: TextStyle(
            color: _isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (String? value) {
            if (value != null) {
              _changeLanguage(value);
            }
          },
          items: _codeTemplates.keys.map<DropdownMenuItem<String>>((String language) {
            return DropdownMenuItem<String>(
              value: language,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getLanguageIcon(language),
                  const SizedBox(width: 8),
                  Text(language[0].toUpperCase() + language.substring(1)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getLanguageIcon(String language) {
    IconData iconData;
    Color iconColor;

    switch (language) {
      case 'python':
        iconData = Icons.code;
        iconColor = Colors.blue;
        break;
      case 'javascript':
        iconData = Icons.javascript;
        iconColor = Colors.yellow;
        break;
      case 'java':
        iconData = Icons.coffee;
        iconColor = Colors.brown;
        break;
      case 'c':
      case 'cpp':
        iconData = Icons.developer_mode;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.code;
        iconColor = Colors.green;
    }

    return Icon(iconData, size: 18, color: iconColor);
  }

  Widget _buildEditor() {
    return Container(
      color: _isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Line numbers
                Container(
                  width: 40,
                  color: _isDark ? const Color(0xFF252525) : Colors.grey[200],
                  padding: const EdgeInsets.only(right: 8),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: _codeController.text.split('\n').length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 24,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _isDark ? Colors.grey : Colors.grey[700],
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Code editor
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_showInput) _buildInputConsole(),
        ],
      ),
    );
  }

  Widget _buildInputConsole() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: _isDark ? const Color(0xFF252525) : Colors.grey[200],
        border: Border(
          top: BorderSide(color: _isDark ? Colors.grey[800]! : Colors.grey[400]!, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.input, size: 16),
              const SizedBox(width: 8),
              Text(
                'Program Input',
                style: TextStyle(
                  color: _isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () {
                  setState(() {
                    _showInput = false;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 16,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: TextField(
              controller: _inputController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: 'Enter program input here...',
                hintStyle: TextStyle(color: _isDark ? Colors.grey[400] : Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              style: TextStyle(
                fontFamily: 'monospace',
                color: _isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputConsole() {
    return Container(
      color: _isDark ? const Color(0xFF252525) : Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: _isDark ? const Color(0xFF333333) : Colors.grey[300],
            child: Row(
              children: [
                const Icon(Icons.terminal, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Output',
                  style: TextStyle(
                    color: _isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _output));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Output copied to clipboard')),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 16,
                  tooltip: 'Copy output',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    setState(() {
                      _output = '';
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 16,
                  tooltip: 'Clear output',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    setState(() {
                      _showOutput = false;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 16,
                  tooltip: 'Close output',
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: _isDark ? Colors.black : Colors.white,
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _isDark ? Colors.lightGreenAccent : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}