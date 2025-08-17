---
date: 2025-01-16T10:30:00
agent: react-researcher
type: research
topics: [react, hooks, state-management, performance]
tags: [#framework/react, #topic/hooks, #pattern/state-management, #performance/optimization]
related: [[Custom Hooks Patterns]], [[React Performance]], [[State Management Comparison]]
aliases: [React Hooks, Hooks Patterns, React State Hooks]
---

# React Research: Hooks Patterns and Best Practices

## Executive Summary
Comprehensive analysis of React hooks patterns, covering all built-in hooks, performance optimization techniques, and custom hook creation patterns. Focus on practical implementations that can be reused across projects.

## Context
- Project: Claude CLI Knowledge Base
- Research trigger: Request for React hooks patterns documentation
- React version: React 18+ (including concurrent features)
- Related research: [[React Performance Patterns]], [[State Management Strategies]]

## Key Findings

### Finding 1: State Hooks Architecture
React provides two primary state hooks with distinct use cases:

```jsx
// useState for simple state
function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+</button>
    </div>
  );
}

// useReducer for complex state logic
function TodoList() {
  const [state, dispatch] = useReducer(todoReducer, initialState);
  
  const addTodo = (text) => {
    dispatch({ type: 'ADD_TODO', payload: text });
  };
  
  return (
    <div>
      {state.todos.map(todo => (
        <TodoItem key={todo.id} todo={todo} dispatch={dispatch} />
      ))}
    </div>
  );
}

function todoReducer(state, action) {
  switch (action.type) {
    case 'ADD_TODO':
      return {
        ...state,
        todos: [...state.todos, { id: Date.now(), text: action.payload }]
      };
    case 'TOGGLE_TODO':
      return {
        ...state,
        todos: state.todos.map(todo =>
          todo.id === action.payload
            ? { ...todo, completed: !todo.completed }
            : todo
        )
      };
    default:
      return state;
  }
}
```

**Use case**: useState for simple values, useReducer for complex state transitions
**Benefits**: Clear separation of concerns, predictable state updates
**Considerations**: useReducer adds boilerplate but improves maintainability for complex logic

### Finding 2: Effect Hooks - When and When NOT to Use
Critical understanding of useEffect proper usage patterns:

```jsx
// ✅ Good: Synchronizing with external systems
function ChatRoom({ roomId }) {
  useEffect(() => {
    const connection = createConnection(roomId);
    connection.connect();
    
    return () => {
      connection.disconnect(); // Cleanup
    };
  }, [roomId]); // Dependencies array
  
  return <div>Connected to {roomId}</div>;
}

// ❌ Bad: Using Effect for data transformation
function UserProfile({ user }) {
  const [fullName, setFullName] = useState('');
  
  // Don't do this!
  useEffect(() => {
    setFullName(`${user.firstName} ${user.lastName}`);
  }, [user.firstName, user.lastName]);
  
  return <div>{fullName}</div>;
}

// ✅ Good: Calculate during rendering
function UserProfile({ user }) {
  const fullName = `${user.firstName} ${user.lastName}`;
  
  return <div>{fullName}</div>;
}

// ✅ Good: Event handling in event handlers
function SearchForm() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  
  const handleSearch = async () => {
    const searchResults = await searchAPI(query);
    setResults(searchResults);
  };
  
  return (
    <form onSubmit={handleSearch}>
      <input 
        value={query} 
        onChange={(e) => setQuery(e.target.value)} 
      />
      <button type="submit">Search</button>
    </form>
  );
}
```

**Use case**: Effects only for synchronizing with external systems (APIs, DOM, timers)
**Benefits**: Cleaner code, better performance, fewer bugs
**Considerations**: Resist the urge to use Effects for internal state logic

### Finding 3: Performance Hooks Patterns
Strategic use of useMemo and useCallback for optimization:

```jsx
// useMemo for expensive calculations
function ProductList({ products, filters }) {
  const filteredProducts = useMemo(() => {
    return products.filter(product => {
      return filters.every(filter => filter(product));
    });
  }, [products, filters]);
  
  const totalPrice = useMemo(() => {
    return filteredProducts.reduce((sum, product) => sum + product.price, 0);
  }, [filteredProducts]);
  
  return (
    <div>
      <h2>Total: ${totalPrice}</h2>
      {filteredProducts.map(product => (
        <ProductItem key={product.id} product={product} />
      ))}
    </div>
  );
}

// useCallback for stable function references
function TodoApp() {
  const [todos, setTodos] = useState([]);
  
  // Memoize callback to prevent child re-renders
  const toggleTodo = useCallback((id) => {
    setTodos(prev => prev.map(todo => 
      todo.id === id 
        ? { ...todo, completed: !todo.completed }
        : todo
    ));
  }, []); // Empty deps - function never changes
  
  const deleteTodo = useCallback((id) => {
    setTodos(prev => prev.filter(todo => todo.id !== id));
  }, []);
  
  return (
    <div>
      {todos.map(todo => (
        <MemoizedTodoItem
          key={todo.id}
          todo={todo}
          onToggle={toggleTodo}
          onDelete={deleteTodo}
        />
      ))}
    </div>
  );
}

const MemoizedTodoItem = React.memo(TodoItem);
```

**Use case**: Optimize expensive calculations and prevent unnecessary re-renders
**Benefits**: Improved performance, especially with complex computations
**Considerations**: Don't overuse - measure performance impact first

## Patterns Discovered

### Pattern: Context + useReducer for Global State
```jsx
// State management pattern for complex apps
const AppContext = createContext();

function AppProvider({ children }) {
  const [state, dispatch] = useReducer(appReducer, initialState);
  
  const value = {
    ...state,
    dispatch,
    // Derived values
    isLoading: state.requests.length > 0,
    user: state.auth.user,
  };
  
  return (
    <AppContext.Provider value={value}>
      {children}
    </AppContext.Provider>
  );
}

function useAppContext() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useAppContext must be used within AppProvider');
  }
  return context;
}

// Usage in components
function UserDashboard() {
  const { user, dispatch, isLoading } = useAppContext();
  
  if (isLoading) return <LoadingSpinner />;
  
  return <div>Welcome, {user.name}!</div>;
}
```
**Problem it solves**: Global state management without prop drilling
**When to use**: Medium to large applications with shared state
**Alternatives**: Redux, Zustand, Jotai for more complex needs

### Pattern: Custom Hooks for External Systems
```jsx
// Custom hook for API data fetching
function useApi(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    let cancelled = false;
    
    async function fetchData() {
      try {
        setLoading(true);
        setError(null);
        const response = await fetch(url);
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        
        if (!cancelled) {
          setData(result);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err.message);
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    }
    
    fetchData();
    
    return () => {
      cancelled = true;
    };
  }, [url]);
  
  return { data, loading, error };
}

// Custom hook for browser APIs
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error);
      return initialValue;
    }
  });
  
  const setValue = useCallback((value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error);
    }
  }, [key, storedValue]);
  
  return [storedValue, setValue];
}

// Usage
function UserPreferences() {
  const [theme, setTheme] = useLocalStorage('theme', 'light');
  const { data: user, loading } = useApi('/api/user');
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <div className={`theme-${theme}`}>
      <h1>Welcome, {user.name}</h1>
      <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
        Toggle Theme
      </button>
    </div>
  );
}
```
**Problem it solves**: Reusable logic for external systems and browser APIs
**When to use**: When multiple components need similar external integrations
**Alternatives**: Third-party libraries like SWR, React Query for data fetching

### Pattern: Compound State with useReducer
```jsx
// Complex state management pattern
const formReducer = (state, action) => {
  switch (action.type) {
    case 'SET_FIELD':
      return {
        ...state,
        values: {
          ...state.values,
          [action.field]: action.value
        },
        errors: {
          ...state.errors,
          [action.field]: null // Clear error when user types
        }
      };
    
    case 'SET_ERRORS':
      return {
        ...state,
        errors: action.errors
      };
    
    case 'SET_SUBMITTING':
      return {
        ...state,
        isSubmitting: action.isSubmitting
      };
    
    case 'RESET':
      return action.initialState;
    
    default:
      return state;
  }
};

function useForm(initialValues, onSubmit) {
  const [state, dispatch] = useReducer(formReducer, {
    values: initialValues,
    errors: {},
    isSubmitting: false
  });
  
  const setField = useCallback((field, value) => {
    dispatch({ type: 'SET_FIELD', field, value });
  }, []);
  
  const handleSubmit = useCallback(async (e) => {
    e.preventDefault();
    dispatch({ type: 'SET_SUBMITTING', isSubmitting: true });
    
    try {
      await onSubmit(state.values);
      dispatch({ type: 'RESET', initialState: { values: initialValues, errors: {}, isSubmitting: false } });
    } catch (errors) {
      dispatch({ type: 'SET_ERRORS', errors });
    } finally {
      dispatch({ type: 'SET_SUBMITTING', isSubmitting: false });
    }
  }, [state.values, onSubmit, initialValues]);
  
  return {
    values: state.values,
    errors: state.errors,
    isSubmitting: state.isSubmitting,
    setField,
    handleSubmit
  };
}
```
**Problem it solves**: Complex form state with validation and submission
**When to use**: Forms with multiple fields and complex validation logic
**Alternatives**: Formik, React Hook Form for production applications

## Anti-Patterns Identified

- **Anti-pattern 1**: Using useEffect for data transformation - Calculate values during rendering instead
- **Anti-pattern 2**: Missing cleanup in useEffect - Always return cleanup functions for subscriptions
- **Anti-pattern 3**: Overusing useMemo/useCallback - Only optimize when there's a measured performance issue
- **Anti-pattern 4**: Mutating state directly - Always use setState or dispatch for updates
- **Anti-pattern 5**: Creating unstable dependencies - Memoize objects passed to dependency arrays

## Performance Implications

- **Bundle size impact**: Hooks themselves add minimal overhead, custom hooks can reduce code duplication
- **Runtime performance**: Proper use of useMemo/useCallback can prevent expensive re-computations
- **Memory considerations**: Clean up effects properly to prevent memory leaks, especially with event listeners and timers

## Recommendations

1. **Immediate adoption**: 
   - Use useState for simple state, useReducer for complex state
   - Create custom hooks for reusable logic
   - Implement proper effect cleanup

2. **Consider for future**: 
   - useTransition and useDeferredValue for concurrent features
   - useSyncExternalStore for external state libraries

3. **Avoid**: 
   - Using effects for data transformation
   - Overusing performance hooks without measurement
   - Creating generic "lifecycle" custom hooks

4. **Migration path**: 
   - Convert class components to functional components with hooks
   - Extract reusable logic into custom hooks
   - Use context + useReducer instead of Redux for simpler apps

## Comparison with Other Frameworks

- **Svelte**: Reactive assignments vs explicit setState calls
- **Vue**: Composition API provides similar hook-like patterns
- **Angular**: Services vs custom hooks for shared logic

## 📚 Sources
- [React Documentation - Hooks](https://react.dev/reference/react/hooks)
- [React Documentation - Managing State](https://react.dev/learn/managing-state)
- [React Documentation - You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)
- [React Documentation - Reusing Logic with Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

## 🔗 Connections

### Framework Comparisons
- [[Svelte Reactivity]] vs React re-renders and state updates
- [[Vue Composition API]] vs React Hooks patterns

### Extends To
- [[Next.js App Router]] - Server Components and hooks interaction
- [[React Testing]] - Testing hooks with React Testing Library

### Patterns
- [[State Management Patterns]] - Context vs Redux vs other solutions
- [[Component Composition]] - How hooks enable better composition
- [[Performance Optimization]] - React 18 concurrent features

#framework/react #topic/hooks #pattern/state-management #performance/optimization

## Open Questions

- How do React Server Components affect hook usage patterns?
- What are the performance implications of deep context nesting?
- How to best structure custom hooks for maximum reusability?
- What testing strategies work best for complex custom hooks?