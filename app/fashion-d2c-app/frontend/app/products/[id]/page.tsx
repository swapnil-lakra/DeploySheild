export default async function SingleProduct({ params }) {
  const { id } = await params;
  const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products/${id}`);
  const product = await res.json();

  return (
    <div className="container mx-auto p-6">
      <div className="flex flex-col md:flex-row gap-8">
        <img src={product.image_url} alt={product.name} className="w-full md:w-1/2 rounded-xl" />
        <div>
          <h1 className="text-4xl font-bold">{product.name}</h1>
          <p className="text-2xl text-gray-700 mt-2">₹{product.price}</p>
          {product.compare_at_price && (
            <p className="text-sm line-through text-gray-500">₹{product.compare_at_price}</p>
          )}
          <p className="mt-4">{product.description}</p>
          <div className="mt-6">
            <p><strong>Sizes:</strong> {product.sizes?.join(", ")}</p>
            <p><strong>Colors:</strong> {product.colors?.join(", ")}</p>
          </div>
          <button className="mt-6 bg-black text-white px-6 py-2 rounded-full hover:bg-gray-800">
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  );
}