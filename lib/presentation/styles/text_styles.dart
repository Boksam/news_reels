import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTextStyles {
  static final TextStyle headline = GoogleFonts.montserrat(
    fontSize: 24,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    decoration: TextDecoration.none,
    letterSpacing: 0.5,
    wordSpacing: 0.5,
  );

  static final TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    decoration: TextDecoration.none,
    letterSpacing: 1,
    wordSpacing: 1,
  );

  static final TextStyle detailBody = GoogleFonts.inter(
    fontSize: 16,
    height: 2,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    decoration: TextDecoration.none,
    letterSpacing: 0.5,
    wordSpacing: 1,
  );

  static final TextStyle tag = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    decoration: TextDecoration.none,
    letterSpacing: 0.5,
  );

  static final MarkdownStyleSheet markdown = MarkdownStyleSheet(
    h1: NewsTextStyles.headline.copyWith(fontSize: 28),
    h2: NewsTextStyles.headline,
    h3: NewsTextStyles.headline.copyWith(fontSize: 20),
    p: NewsTextStyles.detailBody,
    strong: NewsTextStyles.detailBody.copyWith(
      fontWeight: FontWeight.w500,
    ),
    em: NewsTextStyles.detailBody.copyWith(
      fontStyle: FontStyle.italic,
    ),
    listBullet: NewsTextStyles.detailBody,
    a: NewsTextStyles.detailBody.copyWith(
      color: Colors.blue.shade300,
      decoration: TextDecoration.underline,
    ),
    horizontalRuleDecoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 1.0,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    ),
    code: NewsTextStyles.detailBody.copyWith(
      fontFamily: 'monospace',
      backgroundColor: Colors.black.withOpacity(0.3),
    ),
    blockquote: NewsTextStyles.detailBody.copyWith(
      fontStyle: FontStyle.italic,
      color: Colors.white.withOpacity(0.8),
    ),
    tableHead: NewsTextStyles.detailBody.copyWith(
      fontWeight: FontWeight.w500,
    ),
    tableBody: NewsTextStyles.detailBody,
  );

  static final s2 = MarkdownStyleSheet(
      h1: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3,
        letterSpacing: 0.5,
      ),
      h2: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF5F5F5),
        height: 1.3,
        letterSpacing: 0.3,
      ),
      h3: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF5F5F5),
        height: 1.3,
      ),
      p: GoogleFonts.sourceSans3(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.95),
        letterSpacing: 0.3,
      ),
      strong: GoogleFonts.sourceSans3(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      em: GoogleFonts.sourceSans3(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: Colors.white.withOpacity(0.95),
        letterSpacing: 0.3,
      ),
      listBullet: GoogleFonts.sourceSans3(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.95),
        letterSpacing: 0.3,
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ),
      h1Padding: const EdgeInsets.only(top: 24, bottom: 12),
      h2Padding: const EdgeInsets.only(top: 20, bottom: 10),
      h3Padding: const EdgeInsets.only(top: 16, bottom: 8),
      listIndent: 20,
      blockquotePadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 3.0,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ));
}
