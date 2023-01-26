/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 2

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* "%code top" blocks.  */
#line 39 "1905004.y"

#include <stdarg.h> // va_list.
#include <stdio.h>  // printf.
#include <stdlib.h> // getenv.
#include <string.h>

#include <bits/stdc++.h>
using namespace std;


#line 79 "1905004.c"




# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "parser.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_IF = 3,                         /* IF  */
  YYSYMBOL_WHILE = 4,                      /* WHILE  */
  YYSYMBOL_FOR = 5,                        /* FOR  */
  YYSYMBOL_RETURN = 6,                     /* RETURN  */
  YYSYMBOL_INT = 7,                        /* INT  */
  YYSYMBOL_FLOAT = 8,                      /* FLOAT  */
  YYSYMBOL_VOID = 9,                       /* VOID  */
  YYSYMBOL_LPAREN = 10,                    /* LPAREN  */
  YYSYMBOL_LCURL = 11,                     /* LCURL  */
  YYSYMBOL_RCURL = 12,                     /* RCURL  */
  YYSYMBOL_LTHIRD = 13,                    /* LTHIRD  */
  YYSYMBOL_RTHIRD = 14,                    /* RTHIRD  */
  YYSYMBOL_SEMICOLON = 15,                 /* SEMICOLON  */
  YYSYMBOL_COMMA = 16,                     /* COMMA  */
  YYSYMBOL_PRINTLN = 17,                   /* PRINTLN  */
  YYSYMBOL_ID = 18,                        /* ID  */
  YYSYMBOL_RPAREN = 19,                    /* RPAREN  */
  YYSYMBOL_ELSE = 20,                      /* ELSE  */
  YYSYMBOL_ASSIGNOP = 21,                  /* ASSIGNOP  */
  YYSYMBOL_LOGICOP = 22,                   /* LOGICOP  */
  YYSYMBOL_RELOP = 23,                     /* RELOP  */
  YYSYMBOL_ADDOP = 24,                     /* ADDOP  */
  YYSYMBOL_MULOP = 25,                     /* MULOP  */
  YYSYMBOL_NOT = 26,                       /* NOT  */
  YYSYMBOL_INCOP = 27,                     /* INCOP  */
  YYSYMBOL_DECOP = 28,                     /* DECOP  */
  YYSYMBOL_CONST_INT = 29,                 /* CONST_INT  */
  YYSYMBOL_CONST_FLOAT = 30,               /* CONST_FLOAT  */
  YYSYMBOL_YYACCEPT = 31,                  /* $accept  */
  YYSYMBOL_start = 32,                     /* start  */
  YYSYMBOL_program = 33,                   /* program  */
  YYSYMBOL_unit = 34,                      /* unit  */
  YYSYMBOL_func_declaration = 35,          /* func_declaration  */
  YYSYMBOL_func_definition = 36,           /* func_definition  */
  YYSYMBOL_parameter_list = 37,            /* parameter_list  */
  YYSYMBOL_compound_statement = 38,        /* compound_statement  */
  YYSYMBOL_scope = 39,                     /* scope  */
  YYSYMBOL_var_declaration = 40,           /* var_declaration  */
  YYSYMBOL_type_specifier = 41,            /* type_specifier  */
  YYSYMBOL_declaration_list = 42,          /* declaration_list  */
  YYSYMBOL_statements = 43,                /* statements  */
  YYSYMBOL_statement = 44,                 /* statement  */
  YYSYMBOL_expression_statement = 45,      /* expression_statement  */
  YYSYMBOL_variable = 46,                  /* variable  */
  YYSYMBOL_expression = 47,                /* expression  */
  YYSYMBOL_logic_expression = 48,          /* logic_expression  */
  YYSYMBOL_rel_expression = 49,            /* rel_expression  */
  YYSYMBOL_simple_expression = 50,         /* simple_expression  */
  YYSYMBOL_term = 51,                      /* term  */
  YYSYMBOL_unary_expression = 52,          /* unary_expression  */
  YYSYMBOL_factor = 53,                    /* factor  */
  YYSYMBOL_argument_list = 54,             /* argument_list  */
  YYSYMBOL_arguments = 55                  /* arguments  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;



/* Unqualified %code blocks.  */
#line 52 "1905004.y"

	ofstream parsetree_file;
    ofstream log_file;
    ofstream error_file;

	SymbolTable symbol_table = SymbolTable(10);

	// error function

	void error_default(int lineno, string error_msg)
	{
		error_file << "Line# " << lineno << ": " << error_msg << "\n";
	}

	void error_parameter_redefinition(int lineno, string parameter_name)
	{
		error_file << "Line# " << lineno << ": " << "Redefinition of parameter '" << parameter_name << "'\n";
	}

	void error_conflicting_type(int lineno, string id_name)
	{
		error_file << "Line# " << lineno << ": " << "Conflicting types for '" << id_name << "'\n";
	}

	void error_redeclared_different_kind(int lineno, string id_name)
	{
		error_file << "Line# " << lineno << ": " << "'" << id_name << "' redeclared as different kind of symbol\n";
	}

	void error_void_variable(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "Variable or field '" << variable_name << "' declared void\n";
	}

	void error_argument_type_mismatch(int lineno, int argno, string function_name)
	{
		error_file << "Line# " << lineno << ": Type mismatch for argument " << argno << " of '" << function_name << "'\n"; 
	}

	void error_too_few_arguments(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": Too few arguments to function '" << function_name << "'\n";
	}

	void error_too_many_arguments(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": Too many arguments to function '" << function_name << "'\n";
	}

	void error_undeclared_variable(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "Undeclared variable '" << variable_name << "'\n";
	}

	void error_undeclared_function(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": " << "Undeclared function '" << function_name << "'\n";
	}

	void error_not_an_array(int lineno, string variable_name)
	{
		error_file << "Line# " << lineno << ": " << "'" << variable_name << "' is not an array\n";
	}

	void error_array_index_not_integer(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Array index is not an integer\n";
	}

	void error_void_in_expression(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Void cannot be used in expression\n";
	}

	void warning_data_loss(int lineno, SYMBOLTYPE from, SYMBOLTYPE to)
	{
		error_file << "Line# " << lineno << ": " << "Warning: possible loss of data in assignment of "<<aa_terminal_symbols[from]<<" to "<<aa_terminal_symbols[to]<<"\n";
	}

	void warning_div_by_zero(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Warning: division by zero\n";
	}

	void error_nonint_mod_op(int lineno)
	{
		error_file << "Line# " << lineno << ": " << "Operands of modulus must be integers\n";
	}

	void error_redeclared_function(int lineno, string function_name)
	{
		error_file << "Line# " << lineno << ": " << "Redeclared function '" << function_name << "'\n";
	}


#line 268 "1905004.c"

#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* 1 */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE) \
             + YYSIZEOF (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   161

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  31
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  25
/* YYNRULES -- Number of rules.  */
#define YYNRULES  65
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  119

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   285


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   197,   197,   213,   230,   245,   259,   272,   287,   355,
     407,   479,   532,   560,   583,   602,   619,   643,   667,   670,
     717,   732,   746,   763,   789,   828,   845,   878,   891,   909,
     922,   935,   948,   982,  1015,  1055,  1088,  1125,  1153,  1167,
    1186,  1216,  1271,  1285,  1320,  1334,  1371,  1385,  1422,  1436,
    1472,  1486,  1529,  1553,  1576,  1592,  1606,  1668,  1690,  1705,
    1720,  1738,  1758,  1773,  1778,  1800
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if 1
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  static const char *const yy_sname[] =
  {
  "end of file", "error", "invalid token", "IF", "WHILE", "FOR", "RETURN",
  "INT", "FLOAT", "VOID", "LPAREN", "LCURL", "RCURL", "LTHIRD", "RTHIRD",
  "SEMICOLON", "COMMA", "PRINTLN", "ID", "RPAREN", "ELSE", "ASSIGNOP",
  "LOGICOP", "RELOP", "ADDOP", "MULOP", "NOT", "INCOP", "DECOP",
  "CONST_INT", "CONST_FLOAT", "$accept", "start", "program", "unit",
  "func_declaration", "func_definition", "parameter_list",
  "compound_statement", "scope", "var_declaration", "type_specifier",
  "declaration_list", "statements", "statement", "expression_statement",
  "variable", "expression", "logic_expression", "rel_expression",
  "simple_expression", "term", "unary_expression", "factor",
  "argument_list", "arguments", YY_NULLPTR
  };
  return yy_sname[yysymbol];
}
#endif

#define YYPACT_NINF (-65)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      77,   -65,   -65,   -65,    21,    77,   -65,   -65,   -65,   -65,
      12,   -65,   -65,    10,    23,     6,    18,   -65,    41,    37,
      16,    43,    67,    74,   -65,   -65,   -65,    77,    47,   -65,
     -65,    59,    65,    72,   -65,   -65,    78,    83,    96,    97,
      27,    27,   -65,   -65,    99,    50,    27,    27,   -65,   -65,
     -65,   -65,    94,    93,   -65,   -65,   -10,    98,   -65,    92,
      26,    90,   -65,   -65,   -65,   -65,    27,    27,   131,   101,
     102,   100,    27,    27,    51,   -65,   -65,   107,   -65,   -65,
      27,   -65,   -65,   -65,    27,    27,    27,    27,   114,   115,
     131,   -65,   -65,   116,   -65,   118,   124,   128,   -65,   -65,
     119,    90,   -65,   121,   121,    27,   129,   -65,    27,   -65,
     132,   -65,   134,   -65,   -65,   121,   121,   -65,   -65
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,    20,    21,    22,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    25,     0,     0,     0,    19,     0,     0,
       0,    15,     0,    23,    18,     9,    11,     0,     0,    14,
      26,     0,     0,    13,     8,    10,     0,     0,     0,     0,
       0,     0,    17,    38,     0,    40,     0,     0,    58,    59,
      31,    29,     0,     0,    27,    30,    55,     0,    42,    44,
      46,    48,    50,    54,    12,    24,     0,     0,     0,     0,
       0,     0,    63,     0,    55,    52,    53,    25,    16,    28,
       0,    60,    61,    39,     0,     0,     0,     0,     0,     0,
       0,    37,    57,     0,    65,     0,    62,     0,    43,    45,
      47,    49,    51,     0,     0,     0,     0,    56,     0,    41,
      33,    35,     0,    36,    64,     0,     0,    34,    32
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -65,   -65,   -65,   143,   -65,   -65,   -65,    -9,   -65,    24,
       7,   -65,   -65,   -49,   -59,   -44,   -40,   -64,    70,    71,
      73,   -41,   -65,   -65,   -65
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     4,     5,     6,     7,     8,    20,    50,    32,    51,
      52,    14,    53,    54,    55,    56,    57,    58,    59,    60,
      61,    62,    63,    95,    96
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      69,    70,    74,    74,    79,    75,    76,    10,    94,    90,
      26,    80,    10,     1,     2,     3,    98,    81,    82,    35,
      15,    11,    21,    16,     9,    19,    88,    89,    74,     9,
      13,   105,    27,    97,    33,    28,    74,    41,    17,    18,
      74,    74,    74,    74,   114,    45,   102,    22,    24,    85,
      86,    46,    25,    47,   110,   111,    48,    49,    24,    23,
      72,    29,    34,    73,    74,   112,   117,   118,    37,    38,
      39,    40,     1,     2,     3,    41,    24,    42,    81,    82,
      43,    30,    44,    45,     1,     2,     3,    31,    36,    46,
      64,    47,    65,    66,    48,    49,    37,    38,    39,    40,
       1,     2,     3,    41,    24,    78,    67,    68,    43,    71,
      44,    45,    77,    83,    84,    87,    91,    46,    93,    47,
      16,    92,    48,    49,    37,    38,    39,    40,     1,     2,
       3,    41,    24,   103,   104,   106,    43,   107,    44,    45,
     108,    41,   109,    86,   113,    46,    43,    47,    12,    45,
      48,    49,   115,   116,    99,    46,   100,    47,     0,   101,
      48,    49
};

static const yytype_int8 yycheck[] =
{
      40,    41,    46,    47,    53,    46,    47,     0,    72,    68,
      19,    21,     5,     7,     8,     9,    80,    27,    28,    28,
      10,     0,    15,    13,     0,    19,    66,    67,    72,     5,
      18,    90,    16,    73,    27,    19,    80,    10,    15,    16,
      84,    85,    86,    87,   108,    18,    87,    29,    11,    23,
      24,    24,    15,    26,   103,   104,    29,    30,    11,    18,
      10,    18,    15,    13,   108,   105,   115,   116,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    27,    28,
      15,    14,    17,    18,     7,     8,     9,    13,    29,    24,
      18,    26,    14,    10,    29,    30,     3,     4,     5,     6,
       7,     8,     9,    10,    11,    12,    10,    10,    15,    10,
      17,    18,    18,    15,    22,    25,    15,    24,    18,    26,
      13,    19,    29,    30,     3,     4,     5,     6,     7,     8,
       9,    10,    11,    19,    19,    19,    15,    19,    17,    18,
      16,    10,    14,    24,    15,    24,    15,    26,     5,    18,
      29,    30,    20,    19,    84,    24,    85,    26,    -1,    86,
      29,    30
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     7,     8,     9,    32,    33,    34,    35,    36,    40,
      41,     0,    34,    18,    42,    10,    13,    15,    16,    19,
      37,    41,    29,    18,    11,    15,    38,    16,    19,    18,
      14,    13,    39,    41,    15,    38,    29,     3,     4,     5,
       6,    10,    12,    15,    17,    18,    24,    26,    29,    30,
      38,    40,    41,    43,    44,    45,    46,    47,    48,    49,
      50,    51,    52,    53,    18,    14,    10,    10,    10,    47,
      47,    10,    10,    13,    46,    52,    52,    18,    12,    44,
      21,    27,    28,    15,    22,    23,    24,    25,    47,    47,
      45,    15,    19,    18,    48,    54,    55,    47,    48,    49,
      50,    51,    52,    19,    19,    45,    19,    19,    16,    14,
      44,    44,    47,    15,    48,    20,    19,    44,    44
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    31,    32,    33,    33,    34,    34,    34,    35,    35,
      36,    36,    37,    37,    37,    37,    38,    38,    39,    40,
      41,    41,    41,    42,    42,    42,    42,    43,    43,    44,
      44,    44,    44,    44,    44,    44,    44,    44,    45,    45,
      46,    46,    47,    47,    48,    48,    49,    49,    50,    50,
      51,    51,    52,    52,    52,    53,    53,    53,    53,    53,
      53,    53,    54,    54,    55,    55
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     5,
       6,     5,     4,     3,     2,     1,     4,     3,     0,     3,
       1,     1,     1,     3,     6,     1,     4,     1,     2,     1,
       1,     1,     7,     5,     7,     5,     5,     3,     1,     2,
       1,     4,     1,     3,     1,     3,     1,     3,     1,     3,
       1,     3,     2,     2,     1,     1,     4,     3,     1,     1,
       2,     2,     1,     0,     3,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = TOK_YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == TOK_YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (&yylloc, scanner, YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use TOK_YYerror or TOK_YYUNDEF. */
#define YYERRCODE TOK_YYUNDEF

/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YYLOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

# ifndef YYLOCATION_PRINT

#  if defined YY_LOCATION_PRINT

   /* Temporary convenience wrapper in case some people defined the
      undocumented and private YY_LOCATION_PRINT macros.  */
#   define YYLOCATION_PRINT(File, Loc)  YY_LOCATION_PRINT(File, *(Loc))

#  elif defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static int
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
}

#   define YYLOCATION_PRINT  yy_location_print_

    /* Temporary convenience wrapper in case some people defined the
       undocumented and private YY_LOCATION_PRINT macros.  */
#   define YY_LOCATION_PRINT(File, Loc)  YYLOCATION_PRINT(File, &(Loc))

#  else

#   define YYLOCATION_PRINT(File, Loc) ((void) 0)
    /* Temporary convenience wrapper in case some people defined the
       undocumented and private YY_LOCATION_PRINT macros.  */
#   define YY_LOCATION_PRINT  YYLOCATION_PRINT

#  endif
# endif /* !defined YYLOCATION_PRINT */


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value, Location, scanner); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t scanner)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  YY_USE (yylocationp);
  YY_USE (scanner);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t scanner)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  YYLOCATION_PRINT (yyo, yylocationp);
  YYFPRINTF (yyo, ": ");
  yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, scanner);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp,
                 int yyrule, yyscan_t scanner)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)],
                       &(yylsp[(yyi + 1) - (yynrhs)]), scanner);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, scanner); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


/* Context of a parse error.  */
typedef struct
{
  yy_state_t *yyssp;
  yysymbol_kind_t yytoken;
  YYLTYPE *yylloc;
} yypcontext_t;

/* Put in YYARG at most YYARGN of the expected tokens given the
   current YYCTX, and return the number of tokens stored in YYARG.  If
   YYARG is null, return the number of expected tokens (guaranteed to
   be less than YYNTOKENS).  Return YYENOMEM on memory exhaustion.
   Return 0 if there are more than YYARGN expected tokens, yet fill
   YYARG up to YYARGN. */
static int
yypcontext_expected_tokens (const yypcontext_t *yyctx,
                            yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  int yyn = yypact[+*yyctx->yyssp];
  if (!yypact_value_is_default (yyn))
    {
      /* Start YYX at -YYN if negative to avoid negative indexes in
         YYCHECK.  In other words, skip the first -YYN actions for
         this state because they are default actions.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;
      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yyx;
      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
        if (yycheck[yyx + yyn] == yyx && yyx != YYSYMBOL_YYerror
            && !yytable_value_is_error (yytable[yyx + yyn]))
          {
            if (!yyarg)
              ++yycount;
            else if (yycount == yyargn)
              return 0;
            else
              yyarg[yycount++] = YY_CAST (yysymbol_kind_t, yyx);
          }
    }
  if (yyarg && yycount == 0 && 0 < yyargn)
    yyarg[0] = YYSYMBOL_YYEMPTY;
  return yycount;
}




#ifndef yystrlen
# if defined __GLIBC__ && defined _STRING_H
#  define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
# else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
# endif
#endif

#ifndef yystpcpy
# if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#  define yystpcpy stpcpy
# else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
# endif
#endif



static int
yy_syntax_error_arguments (const yypcontext_t *yyctx,
                           yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yyctx->yytoken != YYSYMBOL_YYEMPTY)
    {
      int yyn;
      if (yyarg)
        yyarg[yycount] = yyctx->yytoken;
      ++yycount;
      yyn = yypcontext_expected_tokens (yyctx,
                                        yyarg ? yyarg + 1 : yyarg, yyargn - 1);
      if (yyn == YYENOMEM)
        return YYENOMEM;
      else
        yycount += yyn;
    }
  return yycount;
}

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return -1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return YYENOMEM if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                const yypcontext_t *yyctx)
{
  enum { YYARGS_MAX = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  yysymbol_kind_t yyarg[YYARGS_MAX];
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* Actual size of YYARG. */
  int yycount = yy_syntax_error_arguments (yyctx, yyarg, YYARGS_MAX);
  if (yycount == YYENOMEM)
    return YYENOMEM;

  switch (yycount)
    {
#define YYCASE_(N, S)                       \
      case N:                               \
        yyformat = S;                       \
        break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
    }

  /* Compute error message size.  Don't count the "%s"s, but reserve
     room for the terminator.  */
  yysize = yystrlen (yyformat) - 2 * yycount + 1;
  {
    int yyi;
    for (yyi = 0; yyi < yycount; ++yyi)
      {
        YYPTRDIFF_T yysize1
          = yysize + yystrlen (yysymbol_name (yyarg[yyi]));
        if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
          yysize = yysize1;
        else
          return YYENOMEM;
      }
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return -1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp = yystpcpy (yyp, yysymbol_name (yyarg[yyi++]));
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, yyscan_t scanner)
{
  YY_USE (yyvaluep);
  YY_USE (yylocationp);
  YY_USE (scanner);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}






/*----------.
| yyparse.  |
`----------*/

int
yyparse (yyscan_t scanner)
{
/* Lookahead token kind.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

/* Location data for the lookahead symbol.  */
static YYLTYPE yyloc_default
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
YYLTYPE yylloc = yyloc_default;

    /* Number of syntax errors so far.  */
    int yynerrs = 0;

    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

    /* The location stack: array, bottom, top.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls = yylsa;
    YYLTYPE *yylsp = yyls;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

  /* The locations where the error started and ended.  */
  YYLTYPE yyerror_range[3];

  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = TOK_YYEMPTY; /* Cause a token to be read.  */

  yylsp[0] = yylloc;
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yyls1, yysize * YYSIZEOF (*yylsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
        yyls = yyls1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == TOK_YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex (&yylval, &yylloc, scanner);
    }

  if (yychar <= TOK_YYEOF)
    {
      yychar = TOK_YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == TOK_YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = TOK_YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      yyerror_range[1] = yylloc;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;

  /* Discard the shifted token.  */
  yychar = TOK_YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location. */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  yyerror_range[1] = yyloc;
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* start: program  */
#line 198 "1905004.y"
        {
		log_file << "start : program\n";

		NonterminalNode* program_node = (NonterminalNode*)(yyvsp[0].TOK_program);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::START, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("start : program");

		non_terminal_node->add_child(program_node);

		(yyval.TOK_start) = (Node*)non_terminal_node;
		Node::print_parsetree((yyval.TOK_start), parsetree_file, 0);
	}
#line 1664 "1905004.c"
    break;

  case 3: /* program: program unit  */
#line 214 "1905004.y"
        {
		log_file << "program : program unit\n";

		NonterminalNode* unit_node = (NonterminalNode*)(yyvsp[0].TOK_unit);

		NonterminalNode* program_node = (NonterminalNode*)(yyvsp[-1].TOK_program);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::PROGRAM, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("program : program unit");

		non_terminal_node->add_child(program_node);
		non_terminal_node->add_child(unit_node);

		(yyval.TOK_program) = (Node*)non_terminal_node;

	}
#line 1685 "1905004.c"
    break;

  case 4: /* program: unit  */
#line 231 "1905004.y"
        {
		log_file << "program : unit\n";

		NonterminalNode* unit_node = (NonterminalNode*)(yyvsp[0].TOK_unit);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::PROGRAM, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("program : unit");

		non_terminal_node->add_child(unit_node);

		(yyval.TOK_program) = (Node*)non_terminal_node;
	}
#line 1702 "1905004.c"
    break;

  case 5: /* unit: var_declaration  */
#line 246 "1905004.y"
        {
		log_file << "unit : var_declaration\n";

		NonterminalNode* var_declaration_node = (NonterminalNode*)(yyvsp[0].TOK_var_declaration);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unit : var_declaration");

		non_terminal_node->add_child(var_declaration_node);

		(yyval.TOK_unit) = (Node*)non_terminal_node;

	}
#line 1720 "1905004.c"
    break;

  case 6: /* unit: func_declaration  */
#line 260 "1905004.y"
        {
		log_file << "unit : func_declaration\n";

		NonterminalNode* func_declaration_node = (NonterminalNode*)(yyvsp[0].TOK_func_declaration);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unit : func_declaration");

		non_terminal_node->add_child(func_declaration_node);

		(yyval.TOK_unit) = (Node*)non_terminal_node;
	}
#line 1737 "1905004.c"
    break;

  case 7: /* unit: func_definition  */
#line 273 "1905004.y"
        {
		log_file << "unit : func_definition\n";

		NonterminalNode* func_definition_node = (NonterminalNode*)(yyvsp[0].TOK_func_definition);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::UNIT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unit : func_definition");

		non_terminal_node->add_child(func_definition_node);

		(yyval.TOK_unit) = (Node*)non_terminal_node;
	}
#line 1754 "1905004.c"
    break;

  case 8: /* func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON  */
#line 288 "1905004.y"
        {
		log_file << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		ParameterListNode* parameter_list_node = (ParameterListNode*)(yyvsp[-2].TOK_parameter_list);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-3]).first_line);
		lparen_node->set_symbol_info((yyvsp[-3].TOK_LPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-4]).first_line);
		id_node->set_symbol_info((yyvsp[-4].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-5].TOK_type_specifier);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DECLARATION, (yylsp[-5]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);



		(yyval.TOK_func_declaration) = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-4].TOK_ID)->get_lexeme());

		if(symbol_info != NULL_SYMBOL_INFO)
		{
			if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
			{
				error_redeclared_function((yylsp[-4]).first_line, (yyvsp[-4].TOK_ID)->get_lexeme());
			}
			else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
			{
				error_conflicting_type((yylsp[-4]).first_line, (yyvsp[-4].TOK_ID)->get_lexeme());
			}
		}
		else 
		{
			//handling multiple parameters with same name
			map<string, int> parameter_count = parameter_list_node->get_parameter_count();
			for(auto p: parameter_count)
			{
				if(p.second > 1)
				{
					error_parameter_redefinition((yylsp[-4]).first_line, p.first);
				}
			}

			FuncInfo* func_info = new FuncInfo((yyvsp[-4].TOK_ID));
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			func_info->set_param_type_specifiers(parameter_list_node->get_parameters());

			symbol_table.insert((SymbolInfo*)func_info);

		}
		
	}
#line 1826 "1905004.c"
    break;

  case 9: /* func_declaration: type_specifier ID LPAREN RPAREN SEMICOLON  */
#line 356 "1905004.y"
        {
		log_file << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-2]).first_line);
		lparen_node->set_symbol_info((yyvsp[-2].TOK_LPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-4].TOK_type_specifier);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DECLARATION, (yylsp[-4]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_func_declaration) = (Node*)non_terminal_node;
		SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-3].TOK_ID)->get_lexeme());

		if(symbol_info != NULL_SYMBOL_INFO)
		{
			if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
			{
				error_redeclared_function((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
			else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
			{
				error_conflicting_type((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
		}
		else 
		{
			
			FuncInfo* func_info = new FuncInfo((yyvsp[-3].TOK_ID));
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			symbol_table.insert((SymbolInfo*)func_info);

		}
	}
#line 1880 "1905004.c"
    break;

  case 10: /* func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement  */
#line 408 "1905004.y"
        {
		log_file << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)(yyvsp[0].TOK_compound_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		ParameterListNode* parameter_list_node = (ParameterListNode*)(yyvsp[-2].TOK_parameter_list);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-3]).first_line);
		lparen_node->set_symbol_info((yyvsp[-3].TOK_LPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-4]).first_line);
		id_node->set_symbol_info((yyvsp[-4].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-5].TOK_type_specifier);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DEFINITION, (yylsp[-5]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(compound_statement_node);


		(yyval.TOK_func_definition) = (Node*)non_terminal_node;

        SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-4].TOK_ID)->get_lexeme());

		if(symbol_info == NULL_SYMBOL_INFO) 
		{
			//handling multiple parameters with same name
			map<string, int> parameter_count = parameter_list_node->get_parameter_count();
			for(auto p: parameter_count)
			{
				if(p.second > 1)
				{
					error_parameter_redefinition((yylsp[-4]).first_line, p.first);
				}
			}

			FuncInfo* func_info = new FuncInfo((yyvsp[-4].TOK_ID));
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());
			func_info->set_param_type_specifiers(parameter_list_node->get_parameters());

			symbol_table.insert((SymbolInfo*)func_info);

		}
		else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
		{
			error_redeclared_different_kind((yylsp[-4]).first_line, (yyvsp[-4].TOK_ID)->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;

			if(!func_info->is_return_type_same(type_specifier_node->get_type_specifier()))
			{
				error_conflicting_type((yylsp[-4]).first_line, (yyvsp[-4].TOK_ID)->get_lexeme());
			}
			else if(!func_info->is_param_type_same(parameter_list_node->get_parameters()))
			{
				error_conflicting_type((yylsp[-4]).first_line, (yyvsp[-4].TOK_ID)->get_lexeme());
			}
		}

	}
#line 1956 "1905004.c"
    break;

  case 11: /* func_definition: type_specifier ID LPAREN RPAREN compound_statement  */
#line 480 "1905004.y"
        {
		log_file << "func_definition : type_specifier ID LPAREN RPAREN compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)(yyvsp[0].TOK_compound_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-2]).first_line);
		lparen_node->set_symbol_info((yyvsp[-2].TOK_LPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-4].TOK_type_specifier);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::FUNC_DEFINITION, (yylsp[-4]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(compound_statement_node);

		(yyval.TOK_func_definition) = (Node*)non_terminal_node;

        SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-3].TOK_ID)->get_lexeme());

		if(symbol_info == NULL_SYMBOL_INFO) 
		{
			FuncInfo* func_info = new FuncInfo((yyvsp[-3].TOK_ID));
			func_info->set_return_type_specifier(type_specifier_node->get_type_specifier());

			symbol_table.insert((SymbolInfo*)func_info);
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::VAR_ID)
		{
			error_redeclared_different_kind((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;
			if(!func_info->is_return_type_same(type_specifier_node->get_type_specifier()))
			{
				error_conflicting_type((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
		}
	}
#line 2010 "1905004.c"
    break;

  case 12: /* parameter_list: parameter_list COMMA type_specifier ID  */
#line 533 "1905004.y"
        {
		log_file << "parameter_list  : parameter_list COMMA type_specifier ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[0]).first_line);
		id_node->set_symbol_info((yyvsp[0].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_type_specifier);

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, (yylsp[-2]).first_line);
		comma_node->set_symbol_info((yyvsp[-2].TOK_COMMA));

		ParameterListNode* parameter_list_node = (ParameterListNode*)(yyvsp[-3].TOK_parameter_list);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[-3]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("parameter_list  : parameter_list COMMA type_specifier ID");
		non_terminal_node->set_parameters(parameter_list_node->get_parameters());
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->set_parameter_count(parameter_list_node->get_parameter_count());
		non_terminal_node->increase_parameter_count((yyvsp[0].TOK_ID)->get_lexeme());

		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);

		(yyval.TOK_parameter_list) = (Node*)non_terminal_node;
	}
#line 2042 "1905004.c"
    break;

  case 13: /* parameter_list: parameter_list COMMA type_specifier  */
#line 561 "1905004.y"
        {
		log_file << "parameter_list  : parameter_list COMMA type_specifier\n";

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[0].TOK_type_specifier);

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, (yylsp[-1]).first_line);
		comma_node->set_symbol_info((yyvsp[-1].TOK_COMMA));

		ParameterListNode* parameter_list_node = (ParameterListNode*)(yyvsp[-2].TOK_parameter_list);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("parameter_list  : parameter_list COMMA type_specifier");
		non_terminal_node->set_parameters(parameter_list_node->get_parameters());
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->set_parameter_count(parameter_list_node->get_parameter_count());

		non_terminal_node->add_child(parameter_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(type_specifier_node);

		(yyval.TOK_parameter_list) = (Node*)non_terminal_node;
	}
#line 2069 "1905004.c"
    break;

  case 14: /* parameter_list: type_specifier ID  */
#line 584 "1905004.y"
        {
		log_file << "parameter_list  : type_specifier ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[0]).first_line);
		id_node->set_symbol_info((yyvsp[0].TOK_ID));

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_type_specifier);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("parameter_list  : type_specifier ID");
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());
		non_terminal_node->increase_parameter_count((yyvsp[0].TOK_ID)->get_lexeme());

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(id_node);

		(yyval.TOK_parameter_list) = (Node*)non_terminal_node;
	}
#line 2092 "1905004.c"
    break;

  case 15: /* parameter_list: type_specifier  */
#line 603 "1905004.y"
        {
		log_file << "parameter_list  : type_specifier\n";

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[0].TOK_type_specifier);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("parameter_list  : type_specifier");
		non_terminal_node->add_parameter(type_specifier_node->get_type_specifier());

		non_terminal_node->add_child(type_specifier_node);

		(yyval.TOK_parameter_list) = (Node*)non_terminal_node;
	}
#line 2110 "1905004.c"
    break;

  case 16: /* compound_statement: LCURL scope statements RCURL  */
#line 620 "1905004.y"
        {
		log_file << "compound_statement : LCURL statements RCURL\n";

		TerminalNode* rcurl_node = new TerminalNode(SYMBOLTYPE::RCURL, (yylsp[0]).first_line);
		rcurl_node->set_symbol_info((yyvsp[0].TOK_RCURL));

		NonterminalNode* statements_node = (NonterminalNode*)(yyvsp[-1].TOK_statements);

		TerminalNode* lcurl_node = new TerminalNode(SYMBOLTYPE::LCURL, (yylsp[-3]).first_line);
		lcurl_node->set_symbol_info((yyvsp[-3].TOK_LCURL));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::COMPOUND_STATEMENT, (yylsp[-3]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("compound_statement : LCURL statements RCURL");

		non_terminal_node->add_child(lcurl_node);
		non_terminal_node->add_child(statements_node);
		non_terminal_node->add_child(rcurl_node);

		(yyval.TOK_compound_statement) = (Node*)non_terminal_node;

		log_file <<symbol_table;
		symbol_table.exit_scope();
	}
#line 2138 "1905004.c"
    break;

  case 17: /* compound_statement: LCURL scope RCURL  */
#line 644 "1905004.y"
        {
		log_file << "compound_statement : LCURL RCURL\n";

		TerminalNode* rcurl_node = new TerminalNode(SYMBOLTYPE::RCURL, (yylsp[0]).first_line);
		rcurl_node->set_symbol_info((yyvsp[0].TOK_RCURL));

		TerminalNode* lcurl_node = new TerminalNode(SYMBOLTYPE::LCURL, (yylsp[-2]).first_line);
		lcurl_node->set_symbol_info((yyvsp[-2].TOK_LCURL));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::COMPOUND_STATEMENT, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("compound_statement : LCURL RCURL");

		non_terminal_node->add_child(lcurl_node);
		non_terminal_node->add_child(rcurl_node);

		(yyval.TOK_compound_statement) = (Node*)non_terminal_node;

		log_file <<symbol_table;
		symbol_table.exit_scope();
	}
#line 2163 "1905004.c"
    break;

  case 18: /* scope: %empty  */
#line 667 "1905004.y"
{
	symbol_table.enter_scope();
}
#line 2171 "1905004.c"
    break;

  case 19: /* var_declaration: type_specifier declaration_list SEMICOLON  */
#line 671 "1905004.y"
        {
		log_file << "var_declaration : type_specifier declaration_list SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)(yyvsp[-1].TOK_declaration_list);

		TypedNonterminalNode* type_specifier_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_type_specifier);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::VAR_DECLARATION, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("var_declaration : type_specifier declaration_list SEMICOLON");

		non_terminal_node->add_child(type_specifier_node);
		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_var_declaration) = (Node*)non_terminal_node;

		// setting type_specifier of all the variables in the declaration_list
		
		for(auto var: declaration_list_node->get_declared_variables())
		{
            if(type_specifier_node->get_type_specifier() == SYMBOLTYPE::VOID)
			{
				error_void_variable((yylsp[-2]).first_line, var->get_lexeme());
			}
			else
			{
				SymbolInfo *symbol_info = symbol_table.lookup(var->get_lexeme());

				if(symbol_info == NULL_SYMBOL_INFO)
				{
					var->set_type_specifier(type_specifier_node->get_type_specifier());
					symbol_table.insert((SymbolInfo*)var);
				}
				else 
				{
					error_conflicting_type((yylsp[-2]).first_line, var->get_lexeme());
				}
			}
		}

	}
#line 2220 "1905004.c"
    break;

  case 20: /* type_specifier: INT  */
#line 718 "1905004.y"
        {
		log_file << "type_specifier	: INT\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("type_specifier : INT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::INT, (yylsp[0]).first_line);
		terminal_node->set_symbol_info((yyvsp[0].TOK_INT));

		non_terminal_node->add_child(terminal_node);
		(yyval.TOK_type_specifier) = (Node*)non_terminal_node;

	}
#line 2239 "1905004.c"
    break;

  case 21: /* type_specifier: FLOAT  */
#line 733 "1905004.y"
        {
		log_file << "type_specifier	: FLOAT\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("type_specifier : FLOAT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::FLOAT, (yylsp[0]).first_line);
		terminal_node->set_symbol_info((yyvsp[0].TOK_FLOAT));

		non_terminal_node->add_child(terminal_node);
		(yyval.TOK_type_specifier) = (Node*)non_terminal_node;
	}
#line 2257 "1905004.c"
    break;

  case 22: /* type_specifier: VOID  */
#line 747 "1905004.y"
        {
		log_file << "type_specifier	: VOID\n";

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TYPE_SPECIFIER, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("type_specifier : VOID");
		non_terminal_node;
		non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);

		TerminalNode* terminal_node = new TerminalNode(SYMBOLTYPE::VOID, (yylsp[0]).first_line);
		terminal_node->set_symbol_info((yyvsp[0].TOK_VOID));

		non_terminal_node->add_child(terminal_node);
		(yyval.TOK_type_specifier) = (Node*)non_terminal_node;
	}
#line 2276 "1905004.c"
    break;

  case 23: /* declaration_list: declaration_list COMMA ID  */
#line 764 "1905004.y"
        {
		log_file << "declaration_list : declaration_list COMMA ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[0]).first_line);
		id_node->set_symbol_info((yyvsp[0].TOK_ID));

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, (yylsp[-1]).first_line);
		comma_node->set_symbol_info((yyvsp[-1].TOK_COMMA));

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)(yyvsp[-2].TOK_declaration_list);

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("declaration_list : declaration_list COMMA ID");
		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(id_node);

		VarInfo* var_info = new VarInfo((yyvsp[0].TOK_ID)); //type_specifier will be set in var_declaration rule

		non_terminal_node->set_declared_variables(declaration_list_node->get_declared_variables());
		non_terminal_node->add_declared_variable(var_info);

		(yyval.TOK_declaration_list) = (Node*)non_terminal_node;

	}
#line 2306 "1905004.c"
    break;

  case 24: /* declaration_list: declaration_list COMMA ID LTHIRD CONST_INT RTHIRD  */
#line 790 "1905004.y"
        {
		log_file << "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, (yylsp[0]).first_line);
		rthird_node->set_symbol_info((yyvsp[0].TOK_RTHIRD));

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, (yylsp[-1]).first_line);
		const_int_node->set_symbol_info((yyvsp[-1].TOK_CONST_INT));

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, (yylsp[-2]).first_line);
		lthird_node->set_symbol_info((yyvsp[-2].TOK_LTHIRD));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, (yylsp[-4]).first_line);
		comma_node->set_symbol_info((yyvsp[-4].TOK_COMMA));

		DeclarationListNode* declaration_list_node = (DeclarationListNode*)(yyvsp[-5].TOK_declaration_list);

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, (yylsp[-5]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");

		non_terminal_node->add_child(declaration_list_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(const_int_node);
		non_terminal_node->add_child(rthird_node);

		VarInfo* var_info = new VarInfo((yyvsp[-3].TOK_ID)); //type_specifier will be set in var_declaration rule
		var_info->set_array_size(stoi((yyvsp[-1].TOK_CONST_INT)->get_lexeme()));

		non_terminal_node->set_declared_variables(declaration_list_node->get_declared_variables());
		non_terminal_node->add_declared_variable(var_info);

		(yyval.TOK_declaration_list) = (Node*)non_terminal_node;
	}
#line 2349 "1905004.c"
    break;

  case 25: /* declaration_list: ID  */
#line 829 "1905004.y"
        {
		log_file << "declaration_list : ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[0]).first_line);
		id_node->set_symbol_info((yyvsp[0].TOK_ID));

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("declaration_list : ID");

		non_terminal_node->add_child(id_node);

		VarInfo* var_info = new VarInfo((yyvsp[0].TOK_ID)); //type_specifier will be set in var_declaration rule
		non_terminal_node->add_declared_variable(var_info);

		(yyval.TOK_declaration_list) = (Node*)non_terminal_node;
	}
#line 2370 "1905004.c"
    break;

  case 26: /* declaration_list: ID LTHIRD CONST_INT RTHIRD  */
#line 846 "1905004.y"
        {
		log_file << "declaration_list : ID LTHIRD CONST_INT RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, (yylsp[0]).first_line);
		rthird_node->set_symbol_info((yyvsp[0].TOK_RTHIRD));

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, (yylsp[-1]).first_line);
		const_int_node->set_symbol_info((yyvsp[-1].TOK_CONST_INT));

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, (yylsp[-2]).first_line);
		lthird_node->set_symbol_info((yyvsp[-2].TOK_LTHIRD));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));		

		DeclarationListNode* non_terminal_node = new DeclarationListNode(SYMBOLTYPE::DECLARATION_LIST, (yylsp[-3]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("declaration_list : ID LTHIRD CONST_INT RTHIRD");

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(const_int_node);
		non_terminal_node->add_child(rthird_node);

		VarInfo* var_info = new VarInfo((yyvsp[-3].TOK_ID)); //type_specifier will be set in var_declaration rule
		var_info->set_array_size(stoi((yyvsp[-1].TOK_CONST_INT)->get_lexeme()));

		non_terminal_node->add_declared_variable(var_info);

		(yyval.TOK_declaration_list) = (Node*)non_terminal_node;
	}
#line 2405 "1905004.c"
    break;

  case 27: /* statements: statement  */
#line 879 "1905004.y"
        {
		log_file << "statements : statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)(yyvsp[0].TOK_statement);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENTS, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statements : statement");

		non_terminal_node->add_child(statement_node);

		(yyval.TOK_statements) = (Node*)non_terminal_node;
	}
#line 2422 "1905004.c"
    break;

  case 28: /* statements: statements statement  */
#line 892 "1905004.y"
        {
		log_file << "statements : statements statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)(yyvsp[0].TOK_statement);

		NonterminalNode* statements_node = (NonterminalNode*)(yyvsp[-1].TOK_statements);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENTS, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statements : statements statement");

		non_terminal_node->add_child(statements_node);
		non_terminal_node->add_child(statement_node);

		(yyval.TOK_statements) = (Node*)non_terminal_node;
	}
#line 2442 "1905004.c"
    break;

  case 29: /* statement: var_declaration  */
#line 910 "1905004.y"
        {
		log_file << "statement : var_declaration\n";

		NonterminalNode* var_declaration_node = (NonterminalNode*)(yyvsp[0].TOK_var_declaration);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : var_declaration");

		non_terminal_node->add_child(var_declaration_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;
	}
#line 2459 "1905004.c"
    break;

  case 30: /* statement: expression_statement  */
#line 923 "1905004.y"
        {
		log_file << "statement : expression_statement\n";

		NonterminalNode* expression_statement_node = (NonterminalNode*)(yyvsp[0].TOK_expression_statement);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : expression_statement");

		non_terminal_node->add_child(expression_statement_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;
	}
#line 2476 "1905004.c"
    break;

  case 31: /* statement: compound_statement  */
#line 936 "1905004.y"
        {
		log_file << "statement : compound_statement\n";

		NonterminalNode* compound_statement_node = (NonterminalNode*)(yyvsp[0].TOK_compound_statement);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : compound_statement");

		non_terminal_node->add_child(compound_statement_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;
	}
#line 2493 "1905004.c"
    break;

  case 32: /* statement: FOR LPAREN expression_statement expression_statement expression RPAREN statement  */
#line 949 "1905004.y"
        {
		log_file << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)(yyvsp[0].TOK_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_expression);

		NonterminalNode* expression_statement_node2 = (NonterminalNode*)(yyvsp[-3].TOK_expression_statement);

		NonterminalNode* expression_statement_node1 = (NonterminalNode*)(yyvsp[-4].TOK_expression_statement);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-5]).first_line);
		lparen_node->set_symbol_info((yyvsp[-5].TOK_LPAREN));

		TerminalNode* for_node = new TerminalNode(SYMBOLTYPE::FOR, (yylsp[-6]).first_line);
		for_node->set_symbol_info((yyvsp[-6].TOK_FOR));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-6]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");

		non_terminal_node->add_child(for_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_statement_node1);
		non_terminal_node->add_child(expression_statement_node2);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;
	}
#line 2531 "1905004.c"
    break;

  case 33: /* statement: IF LPAREN expression RPAREN statement  */
#line 983 "1905004.y"
        {
		log_file << "statement : IF LPAREN expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)(yyvsp[0].TOK_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_expression);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-3]).first_line);
		lparen_node->set_symbol_info((yyvsp[-3].TOK_LPAREN));

		TerminalNode* if_node = new TerminalNode(SYMBOLTYPE::IF, (yylsp[-4]).first_line);
		if_node->set_symbol_info((yyvsp[-4].TOK_IF));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-4]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : IF LPAREN expression RPAREN statement");

		non_terminal_node->add_child(if_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void expression cannot b e in a if statement");
		}
	}
#line 2568 "1905004.c"
    break;

  case 34: /* statement: IF LPAREN expression RPAREN statement ELSE statement  */
#line 1016 "1905004.y"
        {
		log_file << "statement : IF LPAREN expression RPAREN statement ELSE statement\n";

		NonterminalNode* statement_node2 = (NonterminalNode*)(yyvsp[0].TOK_statement);

		TerminalNode* else_node = new TerminalNode(SYMBOLTYPE::ELSE, (yylsp[-1]).first_line);
		else_node->set_symbol_info((yyvsp[-1].TOK_ELSE));

		NonterminalNode* statement_node1 = (NonterminalNode*)(yyvsp[-2].TOK_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-3]).first_line);
		rparen_node->set_symbol_info((yyvsp[-3].TOK_RPAREN));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-4].TOK_expression);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-5]).first_line);
		lparen_node->set_symbol_info((yyvsp[-5].TOK_LPAREN));

		TerminalNode* if_node = new TerminalNode(SYMBOLTYPE::IF, (yylsp[-6]).first_line);
		if_node->set_symbol_info((yyvsp[-6].TOK_IF));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-6]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : IF LPAREN expression RPAREN statement ELSE statement");

		non_terminal_node->add_child(if_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node1);
		non_terminal_node->add_child(else_node);
		non_terminal_node->add_child(statement_node2);

		(yyval.TOK_statement) = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-4]).first_line, "void expression cannot b e in a if statement");
		}
	}
#line 2612 "1905004.c"
    break;

  case 35: /* statement: WHILE LPAREN expression RPAREN statement  */
#line 1056 "1905004.y"
        {
		log_file << "statement : WHILE LPAREN expression RPAREN statement\n";

		NonterminalNode* statement_node = (NonterminalNode*)(yyvsp[0].TOK_statement);

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_expression);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-3]).first_line);
		lparen_node->set_symbol_info((yyvsp[-3].TOK_LPAREN));

		TerminalNode* while_node = new TerminalNode(SYMBOLTYPE::WHILE, (yylsp[-4]).first_line);
		while_node->set_symbol_info((yyvsp[-4].TOK_WHILE));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-4]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : WHILE LPAREN expression RPAREN statement");

		non_terminal_node->add_child(while_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(statement_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void expression cannot b e in a while statement");
		}
	}
#line 2649 "1905004.c"
    break;

  case 36: /* statement: PRINTLN LPAREN ID RPAREN SEMICOLON  */
#line 1089 "1905004.y"
        {
		log_file << "statement : PRINTLN LPAREN ID RPAREN SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[-1]).first_line);
		rparen_node->set_symbol_info((yyvsp[-1].TOK_RPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-2]).first_line);
		//todo: check if ID is declared and set symbol info
		id_node->set_symbol_info((yyvsp[-2].TOK_ID));

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-3]).first_line);
		lparen_node->set_symbol_info((yyvsp[-3].TOK_LPAREN));

		TerminalNode* println_node = new TerminalNode(SYMBOLTYPE::PRINTLN, (yylsp[-4]).first_line);
		println_node->set_symbol_info((yyvsp[-4].TOK_PRINTLN));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-4]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON");

		non_terminal_node->add_child(println_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(rparen_node);
		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-2].TOK_ID)->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_variable((yylsp[-2]).first_line, (yyvsp[-2].TOK_ID)->get_lexeme());
		}
	}
#line 2690 "1905004.c"
    break;

  case 37: /* statement: RETURN expression SEMICOLON  */
#line 1126 "1905004.y"
        {
		log_file << "statement : RETURN expression SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_expression);

		TerminalNode* return_node = new TerminalNode(SYMBOLTYPE::RETURN, (yylsp[-2]).first_line);
		return_node->set_symbol_info((yyvsp[-2].TOK_RETURN));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::STATEMENT, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("statement : RETURN expression SEMICOLON");

		non_terminal_node->add_child(return_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_statement) = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-1]).first_line, "void expression cannot b e in a return statement");
		}
	}
#line 2720 "1905004.c"
    break;

  case 38: /* expression_statement: SEMICOLON  */
#line 1154 "1905004.y"
        {
		log_file << "expression_statement : SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::EXPRESSION_STATEMENT, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("expression_statement : SEMICOLON");

		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_expression_statement) = (Node*)non_terminal_node;
	}
#line 2738 "1905004.c"
    break;

  case 39: /* expression_statement: expression SEMICOLON  */
#line 1168 "1905004.y"
        {
		log_file << "expression_statement : expression SEMICOLON\n";

		TerminalNode* semicolon_node = new TerminalNode(SYMBOLTYPE::SEMICOLON, (yylsp[0]).first_line);
		semicolon_node->set_symbol_info((yyvsp[0].TOK_SEMICOLON));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_expression);

		NonterminalNode* non_terminal_node = new NonterminalNode(SYMBOLTYPE::EXPRESSION_STATEMENT, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("expression_statement : expression SEMICOLON");

		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(semicolon_node);

		(yyval.TOK_expression_statement) = (Node*)non_terminal_node;
	}
#line 2759 "1905004.c"
    break;

  case 40: /* variable: ID  */
#line 1187 "1905004.y"
        {
		log_file << "variable : ID\n";

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[0]).first_line);
		id_node->set_symbol_info((yyvsp[0].TOK_ID));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::VARIABLE, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("variable : ID");
		SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[0].TOK_ID)->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			//error
			error_undeclared_variable( (yylsp[0]).first_line, (yyvsp[0].TOK_ID)->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			//error
		}
		else
		{
			VarInfo* var_info = (VarInfo*)symbol_info;   	
			non_terminal_node->set_type_specifier(var_info->get_type_specifier());
		}

		non_terminal_node->add_child(id_node);

		(yyval.TOK_variable) = (Node*)non_terminal_node;

	}
#line 2793 "1905004.c"
    break;

  case 41: /* variable: ID LTHIRD expression RTHIRD  */
#line 1217 "1905004.y"
        {
		log_file << "variable : ID LTHIRD expression RTHIRD\n";

		TerminalNode* rthird_node = new TerminalNode(SYMBOLTYPE::RTHIRD, (yylsp[0]).first_line);
		rthird_node->set_symbol_info((yyvsp[0].TOK_RTHIRD));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_expression);

		TerminalNode* lthird_node = new TerminalNode(SYMBOLTYPE::LTHIRD, (yylsp[-2]).first_line);
		lthird_node->set_symbol_info((yyvsp[-2].TOK_LTHIRD));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::VARIABLE, (yylsp[-3]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("variable : ID LTHIRD expression RTHIRD");

        SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-3].TOK_ID)->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			//error
			error_undeclared_variable( (yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
		}
		else if(symbol_info->get_type() == SYMBOLTYPE::FUNC_ID)
		{
			error_default((yylsp[-3]).first_line, "function cannot be used as an array");
		}
		else
		{
			VarInfo* var_info = (VarInfo*)symbol_info;

			if(var_info->get_array_size() < 0)
			{
				error_not_an_array((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
		    	
		    non_terminal_node->set_type_specifier(var_info->get_type_specifier());
		}

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lthird_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rthird_node);

		(yyval.TOK_variable) = (Node*)non_terminal_node;

		if(expression_node->get_type_specifier() != SYMBOLTYPE::INT)
		{
			//error
			error_array_index_not_integer( (yylsp[-1]).first_line);
		}
	}
#line 2850 "1905004.c"
    break;

  case 42: /* expression: logic_expression  */
#line 1272 "1905004.y"
        {
		log_file << "expression : logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_logic_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::EXPRESSION, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("expression : logic_expression");
		non_terminal_node->set_type_specifier(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(logic_expression_node);

		(yyval.TOK_expression) = (Node*)non_terminal_node;
	}
#line 2868 "1905004.c"
    break;

  case 43: /* expression: variable ASSIGNOP logic_expression  */
#line 1286 "1905004.y"
        {
		log_file << "expression : variable ASSIGNOP logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_logic_expression);

		TerminalNode* assignop_node = new TerminalNode(SYMBOLTYPE::ASSIGNOP, (yylsp[-1]).first_line);
		assignop_node->set_symbol_info((yyvsp[-1].TOK_ASSIGNOP));

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_variable);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::EXPRESSION, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("expression : variable ASSIGNOP logic_expression");

		//todo: check type_specifier

        if(variable_node->get_type_specifier() == SYMBOLTYPE::VOID || logic_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void type is not allowed in assignment expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(variable_node->get_type_specifier() == SYMBOLTYPE::INT && logic_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			warning_data_loss((yylsp[-2]).first_line, SYMBOLTYPE::FLOAT, SYMBOLTYPE::INT);
		}


		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(assignop_node);
		non_terminal_node->add_child(logic_expression_node);

		(yyval.TOK_expression) = (Node*)non_terminal_node;
	}
#line 2905 "1905004.c"
    break;

  case 44: /* logic_expression: rel_expression  */
#line 1321 "1905004.y"
        {
		log_file << "logic_expression : rel_expression\n";

		TypedNonterminalNode* rel_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_rel_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::LOGIC_EXPRESSION, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("logic_expression : rel_expression");
		non_terminal_node->set_type_specifier(rel_expression_node->get_type_specifier());

		non_terminal_node->add_child(rel_expression_node);

		(yyval.TOK_logic_expression) = (Node*)non_terminal_node;
	}
#line 2923 "1905004.c"
    break;

  case 45: /* logic_expression: rel_expression LOGICOP rel_expression  */
#line 1335 "1905004.y"
        {
		log_file << "logic_expression : rel_expression LOGICOP rel_expression\n";

		TypedNonterminalNode* rel_expression_node2 = (TypedNonterminalNode*)(yyvsp[0].TOK_rel_expression);

		TerminalNode* logicop_node = new TerminalNode(SYMBOLTYPE::LOGICOP, (yylsp[-1]).first_line);
		logicop_node->set_symbol_info((yyvsp[-1].TOK_LOGICOP));

		TypedNonterminalNode* rel_expression_node1 = (TypedNonterminalNode*)(yyvsp[-2].TOK_rel_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::LOGIC_EXPRESSION, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("logic_expression : rel_expression LOGICOP rel_expression");
		//todo: handle type_specifier 

        if(rel_expression_node1->get_type_specifier() == SYMBOLTYPE::VOID || rel_expression_node2->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void type is not allowed in logical expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(rel_expression_node1->get_type_specifier() == SYMBOLTYPE::FLOAT || rel_expression_node2->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(rel_expression_node1);
		non_terminal_node->add_child(logicop_node);
		non_terminal_node->add_child(rel_expression_node2);

		(yyval.TOK_logic_expression) = (Node*)non_terminal_node;
	}
#line 2962 "1905004.c"
    break;

  case 46: /* rel_expression: simple_expression  */
#line 1372 "1905004.y"
        {
		log_file << "rel_expression	: simple_expression\n";

		TypedNonterminalNode* simple_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_simple_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::REL_EXPRESSION, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("rel_expression	: simple_expression");
		non_terminal_node->set_type_specifier(simple_expression_node->get_type_specifier());

		non_terminal_node->add_child(simple_expression_node);

		(yyval.TOK_rel_expression) = (Node*)non_terminal_node;
	}
#line 2980 "1905004.c"
    break;

  case 47: /* rel_expression: simple_expression RELOP simple_expression  */
#line 1386 "1905004.y"
        {
		log_file << "rel_expression	: simple_expression RELOP simple_expression\n";

		TypedNonterminalNode* simple_expression_node2 = (TypedNonterminalNode*)(yyvsp[0].TOK_simple_expression);

		TerminalNode* relop_node = new TerminalNode(SYMBOLTYPE::RELOP, (yylsp[-1]).first_line);
		relop_node->set_symbol_info((yyvsp[-1].TOK_RELOP));

		TypedNonterminalNode* simple_expression_node1 = (TypedNonterminalNode*)(yyvsp[-2].TOK_simple_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::REL_EXPRESSION, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("rel_expression	: simple_expression RELOP simple_expression");

		//todo: handle type_specifier
    	if(simple_expression_node1->get_type_specifier() == SYMBOLTYPE::VOID || simple_expression_node2->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void type is not allowed in relational expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(simple_expression_node1->get_type_specifier() == SYMBOLTYPE::FLOAT || simple_expression_node2->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(simple_expression_node1);
		non_terminal_node->add_child(relop_node);
		non_terminal_node->add_child(simple_expression_node2);

		(yyval.TOK_rel_expression) = (Node*)non_terminal_node;
	}
#line 3019 "1905004.c"
    break;

  case 48: /* simple_expression: term  */
#line 1423 "1905004.y"
        {
		log_file << "simple_expression : term\n";

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)(yyvsp[0].TOK_term);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::SIMPLE_EXPRESSION, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("simple_expression : term");
		non_terminal_node->set_type_specifier(term_node->get_type_specifier());

		non_terminal_node->add_child(term_node);

		(yyval.TOK_simple_expression) = (Node*)non_terminal_node;
	}
#line 3037 "1905004.c"
    break;

  case 49: /* simple_expression: simple_expression ADDOP term  */
#line 1437 "1905004.y"
        {
		log_file << "simple_expression : simple_expression ADDOP term\n";

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)(yyvsp[0].TOK_term);

		TerminalNode* addop_node = new TerminalNode(SYMBOLTYPE::ADDOP, (yylsp[-1]).first_line);
		addop_node->set_symbol_info((yyvsp[-1].TOK_ADDOP));

		TypedNonterminalNode* simple_expression_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_simple_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::SIMPLE_EXPRESSION, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("simple_expression : simple_expression ADDOP term");

		//todo: handle type_specifier
		if(simple_expression_node->get_type_specifier() == SYMBOLTYPE::VOID || term_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void type is not allowed in arithmetic expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(simple_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT || term_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}
		non_terminal_node->add_child(simple_expression_node);
		non_terminal_node->add_child(addop_node);
		non_terminal_node->add_child(term_node);

		(yyval.TOK_simple_expression) = (Node*)non_terminal_node;
	}
#line 3075 "1905004.c"
    break;

  case 50: /* term: unary_expression  */
#line 1473 "1905004.y"
        {
		log_file << "term : unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_unary_expression);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TERM, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("term : unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(unary_expression_node);

		(yyval.TOK_term) = (Node*)non_terminal_node;
	}
#line 3093 "1905004.c"
    break;

  case 51: /* term: term MULOP unary_expression  */
#line 1487 "1905004.y"
        {
		log_file << "term :	term MULOP unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_unary_expression);

		TerminalNode* mulop_node = new TerminalNode(SYMBOLTYPE::MULOP, (yylsp[-1]).first_line);
		mulop_node->set_symbol_info((yyvsp[-1].TOK_MULOP));

		TypedNonterminalNode* term_node = (TypedNonterminalNode*)(yyvsp[-2].TOK_term);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::TERM, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("term :	term MULOP unary_expression");

		// todo: handle type_specifier
		if(((yyvsp[-1].TOK_MULOP)->get_lexeme() == "%") && !(term_node->get_type_specifier() == SYMBOLTYPE::INT && unary_expression_node->get_type_specifier() == SYMBOLTYPE::INT))
		{
			error_nonint_mod_op((yylsp[-1]).first_line);
			
		}

		else if(term_node->get_type_specifier() == SYMBOLTYPE::VOID || unary_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_default((yylsp[-2]).first_line, "void type is not allowed in arithmetic expression");
			non_terminal_node->set_type_specifier(SYMBOLTYPE::VOID);
		}
		else if(term_node->get_type_specifier() == SYMBOLTYPE::FLOAT || unary_expression_node->get_type_specifier() == SYMBOLTYPE::FLOAT)
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);
		}
		else
		{
			non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);
		}

		non_terminal_node->add_child(term_node);
		non_terminal_node->add_child(mulop_node);
		non_terminal_node->add_child(unary_expression_node);

		(yyval.TOK_term) = (Node*)non_terminal_node;
	}
#line 3138 "1905004.c"
    break;

  case 52: /* unary_expression: ADDOP unary_expression  */
#line 1530 "1905004.y"
        {
		log_file << "unary_expression : ADDOP unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_unary_expression);

		TerminalNode* addop_node = new TerminalNode(SYMBOLTYPE::ADDOP, (yylsp[-1]).first_line);
		addop_node->set_symbol_info((yyvsp[-1].TOK_ADDOP));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unary_expression : ADDOP unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(addop_node);
		non_terminal_node->add_child(unary_expression_node);

		(yyval.TOK_unary_expression) = (Node*)non_terminal_node;

		//show void in expression error
		if (unary_expression_node->get_type_specifier() == SYMBOLTYPE::VOID)
		{
			error_void_in_expression((yylsp[0]).first_line);
		}
	}
#line 3166 "1905004.c"
    break;

  case 53: /* unary_expression: NOT unary_expression  */
#line 1554 "1905004.y"
        {
		log_file << "unary_expression : NOT unary_expression\n";

		TypedNonterminalNode* unary_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_unary_expression);

		TerminalNode* not_node = new TerminalNode(SYMBOLTYPE::NOT, (yylsp[-1]).first_line);
		not_node->set_symbol_info((yyvsp[-1].TOK_NOT));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unary_expression : NOT unary_expression");
		non_terminal_node->set_type_specifier(unary_expression_node->get_type_specifier());

		non_terminal_node->add_child(not_node);
		non_terminal_node->add_child(unary_expression_node);

		(yyval.TOK_unary_expression) = (Node*)non_terminal_node;
		
		if(unary_expression_node->get_type_specifier()!= SYMBOLTYPE::INT)
		{
			error_default((yylsp[0]).first_line, "not expression must be int");
		}
	}
#line 3193 "1905004.c"
    break;

  case 54: /* unary_expression: factor  */
#line 1577 "1905004.y"
        {
		log_file << "unary_expression : factor\n";

		TypedNonterminalNode* factor_node = (TypedNonterminalNode*)(yyvsp[0].TOK_factor);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::UNARY_EXPRESSION, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("unary_expression : factor");
		non_terminal_node->set_type_specifier(factor_node->get_type_specifier());

		non_terminal_node->add_child(factor_node);

		(yyval.TOK_unary_expression) = (Node*)non_terminal_node;
	}
#line 3211 "1905004.c"
    break;

  case 55: /* factor: variable  */
#line 1593 "1905004.y"
        {
		log_file << "factor	: variable\n";

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)(yyvsp[0].TOK_variable);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : variable");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3229 "1905004.c"
    break;

  case 56: /* factor: ID LPAREN argument_list RPAREN  */
#line 1607 "1905004.y"
        {
		log_file << "factor	: ID LPAREN argument_list RPAREN\n";

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[0]).first_line);
		rparen_node->set_symbol_info((yyvsp[0].TOK_RPAREN));

		ParameterListNode* argument_list_node = (ParameterListNode*)(yyvsp[-1].TOK_argument_list);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-2]).first_line);
		lparen_node->set_symbol_info((yyvsp[-2].TOK_LPAREN));

		TerminalNode* id_node = new TerminalNode(SYMBOLTYPE::ID, (yylsp[-3]).first_line);
		id_node->set_symbol_info((yyvsp[-3].TOK_ID));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[-3]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : ID LPAREN argument_list RPAREN");
		//todo: handle type_specifier

		non_terminal_node->add_child(id_node);
		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(argument_list_node);
		non_terminal_node->add_child(rparen_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;

		SymbolInfo* symbol_info = symbol_table.lookup((yyvsp[-3].TOK_ID)->get_lexeme());
		if(symbol_info == NULL_SYMBOL_INFO)
		{
			error_undeclared_function((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
		}
		else if(symbol_info->get_type() != SYMBOLTYPE::FUNC_ID)
		{
			error_conflicting_type((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
		}
		else
		{
			FuncInfo* func_info = (FuncInfo*)symbol_info;
			int num_of_params = func_info->get_param_type_specifiers().size();
			int num_of_args = argument_list_node->get_parameters().size();
			
			if(num_of_params > num_of_args)
			{
				error_too_few_arguments((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
			else if(num_of_params < num_of_args)
			{
				error_too_many_arguments((yylsp[-3]).first_line, (yyvsp[-3].TOK_ID)->get_lexeme());
			}
			else 
			{
				for(int i = 0; i < num_of_params; i++)
				{
					if(func_info->get_param_type_specifiers()[i] != argument_list_node->get_parameters()[i])
					{
						error_argument_type_mismatch((yylsp[-3]).first_line,i+1, (yyvsp[-3].TOK_ID)->get_lexeme());
					}
				}
			}
		}

	}
#line 3295 "1905004.c"
    break;

  case 57: /* factor: LPAREN expression RPAREN  */
#line 1669 "1905004.y"
        {
		log_file << "factor	: LPAREN expression RPAREN\n";

		TerminalNode* rparen_node = new TerminalNode(SYMBOLTYPE::RPAREN, (yylsp[0]).first_line);
		rparen_node->set_symbol_info((yyvsp[0].TOK_RPAREN));

		TypedNonterminalNode* expression_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_expression);

		TerminalNode* lparen_node = new TerminalNode(SYMBOLTYPE::LPAREN, (yylsp[-2]).first_line);
		lparen_node->set_symbol_info((yyvsp[-2].TOK_LPAREN));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : LPAREN expression RPAREN");
		non_terminal_node->set_type_specifier(expression_node->get_type_specifier());

		non_terminal_node->add_child(lparen_node);
		non_terminal_node->add_child(expression_node);
		non_terminal_node->add_child(rparen_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3321 "1905004.c"
    break;

  case 58: /* factor: CONST_INT  */
#line 1691 "1905004.y"
        {
		log_file << "factor	: CONST_INT\n";

		TerminalNode* const_int_node = new TerminalNode(SYMBOLTYPE::CONST_INT, (yylsp[0]).first_line);
		const_int_node->set_symbol_info((yyvsp[0].TOK_CONST_INT));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : CONST_INT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::INT);

		non_terminal_node->add_child(const_int_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3340 "1905004.c"
    break;

  case 59: /* factor: CONST_FLOAT  */
#line 1706 "1905004.y"
        {
		log_file << "factor	: CONST_FLOAT\n";

		TerminalNode* const_float_node = new TerminalNode(SYMBOLTYPE::CONST_FLOAT, (yylsp[0]).first_line);
		const_float_node->set_symbol_info((yyvsp[0].TOK_CONST_FLOAT));

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : CONST_FLOAT");
		non_terminal_node->set_type_specifier(SYMBOLTYPE::FLOAT);

		non_terminal_node->add_child(const_float_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3359 "1905004.c"
    break;

  case 60: /* factor: variable INCOP  */
#line 1721 "1905004.y"
        {
		log_file << "factor	: variable INCOP\n";

		TerminalNode* incop_node = new TerminalNode(SYMBOLTYPE::INCOP, (yylsp[0]).first_line);
		incop_node->set_symbol_info((yyvsp[0].TOK_INCOP));

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_variable);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : variable INCOP");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(incop_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3381 "1905004.c"
    break;

  case 61: /* factor: variable DECOP  */
#line 1739 "1905004.y"
        {
		log_file << "factor	: variable DECOP\n";

		TerminalNode* decop_node = new TerminalNode(SYMBOLTYPE::DECOP, (yylsp[0]).first_line);
		decop_node->set_symbol_info((yyvsp[0].TOK_DECOP));

		TypedNonterminalNode* variable_node = (TypedNonterminalNode*)(yyvsp[-1].TOK_variable);

		TypedNonterminalNode* non_terminal_node = new TypedNonterminalNode(SYMBOLTYPE::FACTOR, (yylsp[-1]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("factor : variable DECOP");
		non_terminal_node->set_type_specifier(variable_node->get_type_specifier());

		non_terminal_node->add_child(variable_node);
		non_terminal_node->add_child(decop_node);

		(yyval.TOK_factor) = (Node*)non_terminal_node;
	}
#line 3403 "1905004.c"
    break;

  case 62: /* argument_list: arguments  */
#line 1759 "1905004.y"
        {
		log_file << "argument_list : arguments\n";

		ParameterListNode* arguments_node = (ParameterListNode*)(yyvsp[0].TOK_arguments);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::ARGUMENT_LIST, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("argument_list : arguments");
		non_terminal_node->set_parameters(arguments_node->get_parameters());

		non_terminal_node->add_child(arguments_node);

		(yyval.TOK_argument_list) = (Node*)non_terminal_node;
	}
#line 3421 "1905004.c"
    break;

  case 63: /* argument_list: %empty  */
#line 1773 "1905004.y"
        {
		log_file << "argument_list : \n";
	}
#line 3429 "1905004.c"
    break;

  case 64: /* arguments: arguments COMMA logic_expression  */
#line 1779 "1905004.y"
        {
		log_file << "arguments : arguments COMMA logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_logic_expression);

		TerminalNode* comma_node = new TerminalNode(SYMBOLTYPE::COMMA, (yylsp[-1]).first_line);
		comma_node->set_symbol_info((yyvsp[-1].TOK_COMMA));

		ParameterListNode* arguments_node = (ParameterListNode*)(yyvsp[-2].TOK_arguments);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[-2]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("arguments : arguments COMMA logic_expression");
		non_terminal_node->set_parameters(arguments_node->get_parameters());
		non_terminal_node->add_parameter(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(arguments_node);
		non_terminal_node->add_child(comma_node);
		non_terminal_node->add_child(logic_expression_node);

		(yyval.TOK_arguments) = (Node*)non_terminal_node;
	}
#line 3455 "1905004.c"
    break;

  case 65: /* arguments: logic_expression  */
#line 1801 "1905004.y"
        {
		log_file << "arguments : logic_expression\n";

		TypedNonterminalNode* logic_expression_node = (TypedNonterminalNode*)(yyvsp[0].TOK_logic_expression);

		ParameterListNode* non_terminal_node = new ParameterListNode(SYMBOLTYPE::PARAMETER_LIST, (yylsp[0]).first_line, (yylsp[0]).last_line);
		non_terminal_node->set_production_rule("arguments : logic_expression");
		non_terminal_node->add_parameter(logic_expression_node->get_type_specifier());

		non_terminal_node->add_child(logic_expression_node);

		(yyval.TOK_arguments) = (Node*)non_terminal_node;
	}
#line 3473 "1905004.c"
    break;


#line 3477 "1905004.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == TOK_YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      {
        yypcontext_t yyctx
          = {yyssp, yytoken, &yylloc};
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == -1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *,
                             YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (yymsg)
              {
                yysyntax_error_status
                  = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
                yymsgp = yymsg;
              }
            else
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = YYENOMEM;
              }
          }
        yyerror (&yylloc, scanner, yymsgp);
        if (yysyntax_error_status == YYENOMEM)
          YYNOMEM;
      }
    }

  yyerror_range[1] = yylloc;
  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= TOK_YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == TOK_YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc, scanner);
          yychar = TOK_YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp, yylsp, scanner);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  ++yylsp;
  YYLLOC_DEFAULT (*yylsp, yyerror_range, 2);

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (&yylloc, scanner, YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != TOK_YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc, scanner);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp, yylsp, scanner);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
  return yyresult;
}

#line 1817 "1905004.y"


// Epilogue (C code).
#include "scanner.h"

void yyerror (const YYLTYPE* loc, yyscan_t scanner, const char *msg, ...)
{
  (void) scanner;
  va_list args;
  va_start (args, msg);
  vfprintf (stderr, msg, args);
  va_end (args);
  fputc ('\n', stderr);
}


int main(int argc, char const *argv[])
{

    if (argc != 2)
    {
        cout<< "Usage: ./a.out <input_file>" << endl;
        exit(1);
    }

	FILE *input_file = fopen(argv[1],"r");
	if(input_file == NULL)
	{
		cout<<"Cannot Open Input File.\n";
		exit(1);
	}

	string input_file_name = argv[1];
	string parsetree_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_parsetree.txt";
	string log_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_log.txt";
	string error_file_name = input_file_name.substr(0,input_file_name.size()-2) + "_error.txt";

	parsetree_file.open(parsetree_file_name);
	log_file.open(log_file_name);
	error_file.open(error_file_name);
  
  	custom_scanner_data scandata(&log_file);
  	yyscan_t scaninfo;
	yylex_init_extra(&scandata, &scaninfo);
	yyset_in(input_file,scaninfo);
	yyparse(scaninfo);
	yylex_destroy(scaninfo);

	fclose(input_file);

  	parsetree_file.close();
  	log_file.close();
  	error_file.close();

  	return 0;
}
