%% -*- mode: LaTeX; compile-command: "cd ..; make compile" -*-

%if style == newcode
%include rae.fmt
%endif


\chapter{Motivation}
\label{cha:motivation}

Functional programmers use dependent types in two primary ways: in order
to eliminate erroneous programs from being accepted, and in order to write
intricate programs that a simply-typed language cannot accept. In this chapter,
we will motivate the use of dependent types from both of these angles. The
chapter concludes with a section motivating why Haskell, in particular, is
ripe for dependent types.

\section{Eliminating erroneous programs}

\begin{proposal}
In this proposal, I elide the details of the motivating examples. Instead,
I list them as stubs to be filled out later, when writing the dissertation
proper.
\end{proposal}

\subsection{Simple example: Length-indexed vectors}

\subsection{A strongly typed simply typed lambda calculus interpreter}
\label{sec:stlc}

It is straightforward to write an interpreter for the simply typed lambda
calculus (STLC) in Haskell. However, how can we be sure that our interpreter
is written correctly? Using some features of dependent types -- notably,
generalized algebraic datatypes, or GADTs -- we can incorporate the STLC's
type discipline into our interpreter. Using the extra features in Dependent
Haskell, we can then write both a large-step semantics and a small-step
semantics and have GHC check that they correspond.

Our first step is to write a type to represent the types in our lambda-calculus:
\begin{code}
data Ty = Unit | Ty :~> Ty
infixr 0 :~>
\end{code}
I choose |Unit| as our one and only base type, for simplicity. This calculus
is clearly not suitable for computation, but it demonstrates the use of GADTs
well. The model described here scaled up to a more featureful
lambda-calculus.\footnote{For example, see my work on \package{glambda} at
  \url{https://github.com/goldfirere/glambda}.}
The |infixr| declaration declares that the constructor |:~>| is right-associative,
as usual.

We are then confronted quickly with the decision of how to encode bound
variables. Let's choose de Bruijn indices~\cite{de-bruijn}, as these are well-known
and conceptually simple. However, instead of using natural numbers to
represent our variables, we'll use a custom |Elem| type. A value of type



\subsection{Units-of-measure}

\subsection{Machine-checked sorting algorithm}

\subsection{Type-safe database access}

See also other examples in \citet{power-of-pi} and \citet{hasochism}.

\section{Encoding hard-to-type programs}

\subsection{Variable-arity |zipWith|}

\subsection{Deconstructing runtime types}

\subsection{Inferred algebraic effects}

\cite{algebraic-effects}

\section{Why Haskell?}

\begin{proposal}
This section will be an expansion of the issues raised in the introduction, citing
community interest in dependent types, and the plethora of attempts to encode
dependent types in today's Haskell.

A further part of this section will counter a common argument along the lines of
``If we want Haskell with dependent types, why not just use Agda or Idris?'' There
will be several main points:

\begin{itemize}
\item Haskell is a richer language than Idris or Agda. Studying the interaction
between dependent types and Haskell's other features is illuminating.

\item Implementing dependent types in Haskell requires backward compatibility.
Since my work is intended to be merged with the main releases of GHC, all current
programs must continue to be accepted and retain their meanings. This requirement
puts interesting constraints on type inference, and it will not allow me to take
any shortcuts around pre-existing code.

\item Haskell has more users than Agda or Idris, and having dependent types
available in Haskell will further our knowledge about dependent types, as more
people can experiment with them.
\end{itemize}
\end{proposal}
