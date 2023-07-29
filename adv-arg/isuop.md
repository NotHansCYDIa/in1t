---
description: Gets packages outside of in1t
---

# ISUOP

{% hint style="danger" %}
The ISUOP argument can be dangerous and can break or hack your computer if you install the wrong package or not carefully use it.
{% endhint %}

```
in1t install -ISUOP ISU://examplePackage
```

`ISURC` aka `IN1T Sub URL Outside Packages` gets packages outside of in1t. The `ISU://` can only be used on the install argument. To uninstall an ISUOP package, you can do is run `in1t uninstall -ISUOP examplePackage`



## Format

<pre><code><a data-footnote-ref href="#user-content-fn-1">in1t</a> <a data-footnote-ref href="#user-content-fn-2">install</a> <a data-footnote-ref href="#user-content-fn-3">-</a>ISUOP <a data-footnote-ref href="#user-content-fn-4">ISU://</a><a data-footnote-ref href="#user-content-fn-5">packagename</a>
</code></pre>

{% hint style="info" %}
The `ISUOP` argument checks for packages that are still pending or has been not approved to be in the official package store.
{% endhint %}



[^1]: Command

[^2]: Install argument

[^3]: Advanced argument notation

[^4]: Must have `ISU://` to install restricted packages

[^5]: The name of the package in the ISU
