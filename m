Return-Path: <dmaengine+bounces-2510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3399141D8
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED055280FA3
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B612E5D;
	Mon, 24 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcPTo2Gd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE49376;
	Mon, 24 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206242; cv=none; b=YkpqJGA1dq7HUWNcvq/1or5Eapxa0YnqEarMJ+sG7faNzy/U12slxrU8V6WJmg31JPT3rbfugw/n/hYfEkliHWGW8ZuWt/5uh+LvZ978Gd+GSsoI+jbUokD8n/2fknjPZ+tDBGbZyOdtVOTVJvDR56sA8JIc2tYkpKCeYfao1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206242; c=relaxed/simple;
	bh=f3CSyQPnt4VQRDp0xyzNOTKzo6rzuItbewtSfQO1CQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGADFRq34XB8NNGcn7TZjdoNkukIBeGp9pFQgQfywYaFherG2wcyEU/ci5cbAhBkdGBKfgcLyGniZPAoG/pqrASHiX6rwTaDwx7/DT5p2pdcZCKr/pFQhud7OSpu6Fi59VgCY2d4H/ZjkoE28bwb7RMMrTTZP0LWA8nFPF316g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcPTo2Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA84C2BBFC;
	Mon, 24 Jun 2024 05:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719206242;
	bh=f3CSyQPnt4VQRDp0xyzNOTKzo6rzuItbewtSfQO1CQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HcPTo2GdhUbcDmljHZjgg9Hghocna1EtYlxaV6n9blyLE6bpJt6bafuZSKFRhNj34
	 VNGiyXqnmrFbDe0N/qOWWcOxXZcDw+i6M0QMmQ5pWgH+U7NAgTCNNo8BM+7GuWdf/7
	 3+1Qb1eh8dLBU9PPAaPxodguH+wSORur2phWNP92deH9Lu8EdV0D0mWQtEfIh6/5KU
	 7/VZquSqYRIMPFrJ9mIa1vTIUevBeT7b/pePFD/Mx4P1tlinVYi/5FDmwzxpVuVJKz
	 RW4MuzUEJab+iQ4UFUrBcNhtJjrvqJlHRtqeG+P5iHegMNbxmJKW9/E4F8MaPillsy
	 Ee3bhKnwgjM8Q==
Message-ID: <62c05c34-0b69-4091-8c3a-d0b8befa9150@kernel.org>
Date: Mon, 24 Jun 2024 07:17:16 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: mv-xor-v2: Convert to dtschema
To: Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240623124507.27297-2-shresthprasad7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240623124507.27297-2-shresthprasad7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2024 14:45, Shresth Prasad wrote:
> Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
> for validation.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
> and `marvell/armada-8080-db.dtb`
> 
>  .../bindings/dma/marvell,xor-v2.yaml          | 69 +++++++++++++++++++
>  .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 --------
>  2 files changed, 69 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> new file mode 100644
> index 000000000000..3d7481c1917e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell XOR v2 engines
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>

Should be rather platform maintainer.

> +
> +properties:
> +  compatible:
> +    contains:

This cannot be unspecific. Drop contains.

> +      enum:
> +        - marvell,armada-7k-xor
> +        - marvell,xor-v2
> +
> +  reg:
> +    items:
> +      - description: DMA registers location and length
> +      - description: global registers location and length

Drop "location and length", redundant.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: reg

This does not match number of items in clocks:

> +
> +  msi-parent:
> +    description:
> +      Phandle to the MSI-capable interrupt controller used for
> +      interrupts.
> +    maxItems: 1
> +
> +  dma-coherent: true

This was not present in the binding and commit msg did not explain why
this is needed. Are devices really DMA coherent?

> +
> +required:
> +  - compatible
> +  - reg
> +  - msi-parent
> +  - dma-coherent
> +
> +if:

Put it under allOf: in this place.

> +  required:
> +    - clocks

This does not work and does not make much sense. Probably you want to
list the items per variant?


> +  properties:
> +    clocks:
> +      minItems: 2
> +      maxItems: 2

Instead list and describe the items.

> +then:
> +  required:
> +    - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xor0@6a0000 {
> +        compatible = "marvell,armada-7k-xor", "marvell,xor-v2";

This totally does not match your binding.

Please, read example-schema, other bindings, my old talks and other
resources before doing conversions, so we can avoid such trivial
mistakes. You enumerated compatibles (enum), but here have a list. A
list is not an enumeration, obviously...

Best regards,
Krzysztof


