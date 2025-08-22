Return-Path: <dmaengine+bounces-6129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE7B32332
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50169A03AA2
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352312D5C8B;
	Fri, 22 Aug 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt4OqasN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FC1DE89B;
	Fri, 22 Aug 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892226; cv=none; b=JOC+8l3WwEpMR4MWqP18Lo6VBCGVgX+zwvSstWdihIk/2oGWDwsWWEzIFd3KRirslf8a2XzBYL2qHL6mh3lemaiJ5figTMSLsf3v7s8emyQoYJ3HWFWRBtZjW5tPxJnN6jAc24x5obFbtlbFF/LUDCWM2jg/KWlXL2eBO2KiQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892226; c=relaxed/simple;
	bh=P8XO6uxUJvu5PgaebbjGtObYHIiSkwF0nj+13YqWxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMl9iHLPHoDNSfQY7eJUPr0bd0jj33LZOAA8AuTTkh8UB138MHx1V2+BEa/Ym5jsacX8LrrHsIaoQBK7Wd98ZZzUjvdzVcY3PA3G86wo3kkptLuHSS5PpOTYL8RCGzkMhBrWM3MVi9A8XAmXzwXuQNoJFU/633tIgw3M9G4J3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt4OqasN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E7EC4CEED;
	Fri, 22 Aug 2025 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892225;
	bh=P8XO6uxUJvu5PgaebbjGtObYHIiSkwF0nj+13YqWxF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bt4OqasNzVwIc2KD2Jlv+CxvCVOUJhbHjR9JSrl96qyqoNIDmu4iwD+qDKBBaHeeS
	 lmHLWPAO+t0Pzl3Ig4/QX58p+EcdDxqFBv+sicoQVrKX9rsMKoqIoFGM5UKp1/yl5C
	 HfUoISxfHenfbLPgr7jjlw5DeiHqXd8fi6ZsMN6C4AzOlj/R6bAroE1GufNY23/3Ki
	 Auc4N+88uFGIsm60jnj4KycWzfsQdew4cm2VP0FxN6Jnuuqc6MLXZZaQkqSJF84VBc
	 oWwilu7i8MANirmKsEmno33b8ZJMaWaxINnGcPqt/nO1eG/GuJzkrEK/g7cZulHm2d
	 XFGj66aXHiNfw==
Date: Fri, 22 Aug 2025 14:50:24 -0500
From: Rob Herring <robh@kernel.org>
To: Nino Zhang <ninozhang001@gmail.com>
Cc: vkoul@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: img-mdc-dma: convert to DT schema
Message-ID: <20250822195024.GA194990-robh@kernel.org>
References: <20250821150255.236884-1-ninozhang001@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821150255.236884-1-ninozhang001@gmail.com>

On Thu, Aug 21, 2025 at 11:02:55PM +0800, Nino Zhang wrote:
> Convert the img-mdc-dma binding from txt to YAML schema.
> No functional changes except dropping the consumer node
> (spi@18100f00) from the example, which belongs to the
> consumer binding instead.
> 
> Tested with 'make dt_binding_check'.

No need to say that in the commit msg. It is assumed you did this.

> 
> Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
> ---
>  .../devicetree/bindings/dma/img-mdc-dma.txt   | 57 -----------
>  .../devicetree/bindings/dma/img-mdc-dma.yaml  | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt b/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> deleted file mode 100644
> index 28c1341db346..000000000000
> --- a/Documentation/devicetree/bindings/dma/img-mdc-dma.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -* IMG Multi-threaded DMA Controller (MDC)
> -
> -Required properties:
> -- compatible: Must be "img,pistachio-mdc-dma".
> -- reg: Must contain the base address and length of the MDC registers.
> -- interrupts: Must contain all the per-channel DMA interrupts.
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clock/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - sys: MDC system interface clock.
> -- img,cr-periph: Must contain a phandle to the peripheral control syscon
> -  node which contains the DMA request to channel mapping registers.
> -- img,max-burst-multiplier: Must be the maximum supported burst size multiplier.
> -  The maximum burst size is this value multiplied by the hardware-reported bus
> -  width.
> -- #dma-cells: Must be 3:
> -  - The first cell is the peripheral's DMA request line.
> -  - The second cell is a bitmap specifying to which channels the DMA request
> -    line may be mapped (i.e. bit N set indicates channel N is usable).
> -  - The third cell is the thread ID to be used by the channel.
> -
> -Optional properties:
> -- dma-channels: Number of supported DMA channels, up to 32.  If not specified
> -  the number reported by the hardware is used.
> -
> -Example:
> -
> -mdc: dma-controller@18143000 {
> -	compatible = "img,pistachio-mdc-dma";
> -	reg = <0x18143000 0x1000>;
> -	interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 29 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 30 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 31 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 32 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 33 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 34 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 35 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 36 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 37 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SHARED 38 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&system_clk>;
> -	clock-names = "sys";
> -
> -	img,max-burst-multiplier = <16>;
> -	img,cr-periph = <&cr_periph>;
> -
> -	#dma-cells = <3>;
> -};
> -
> -spi@18100f00 {
> -	...
> -	dmas = <&mdc 9 0xffffffff 0>, <&mdc 10 0xffffffff 0>;
> -	dma-names = "tx", "rx";
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml
> new file mode 100644
> index 000000000000..b635125d7ae3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/img-mdc-dma.yaml

Use the compatible string for the filename.

> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/img-mdc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IMG Multi-threaded DMA Controller (MDC)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>

No, must be someone with this h/w and cares about this h/w.

> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    description: Must be "img,pistachio-mdc-dma".

Drop. The schema says that. Same goes for all the other descriptions, so 
I won't repeat it everywhere.

> +    const: img,pistachio-mdc-dma
> +
> +  reg:
> +    description:
> +      Must contain the base address and length of the MDC registers.

Drop.

> +    minItems: 1

maxItems instead.

> +
> +  interrupts:
> +    description:
> +      Must contain all the per-channel DMA interrupts.

Must define how many.

> +
> +  clocks:
> +    description: |
> +      Must contain an entry for each entry in clock-names.
> +      See clock/clock.yaml for details.

Drop.

Must define how many clocks and what they are.

> +
> +  clock-names:
> +    description: |
> +      Must include the following entries:
> +        - sys: MDC system interface clock.

Drop. The schema says that.

> +    minItems: 1
> +    contains: { const: sys }

Must be exact list of values, not 'sys' plus anything else you want.

> +
> +  img,cr-periph:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |

Drop '|'. Not needed if no formatting to maintain.


> +      Must contain a phandle to the peripheral control syscon node
> +      which contains the DMA request to channel mapping registers.
> +
> +  img,max-burst-multiplier:
> +    description: |
> +      Must be the maximum supported burst size multiplier.
> +      The maximum burst size is this value multiplied by the
> +      hardware-reported bus width.

Wrap lines at 80 and drop '|'.

> +    $ref: /schemas/types.yaml#/definitions/uint32

constraints?

> +
> +  "#dma-cells":
> +    description: |
> +      Must be 3:
> +        - The first cell is the peripheral's DMA request line.
> +        - The second cell is a bitmap specifying to which channels the DMA request
> +          line may be mapped (i.e. bit N set indicates channel N is usable).
> +        - The third cell is the thread ID to be used by the channel.
> +    const: 3
> +
> +  dma-channels:
> +    description: |
> +      Number of supported DMA channels, up to 32. If not specified
> +      the number reported by the hardware is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop. Already has a type defined.

> +    maximum: 32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "img,cr-periph"
> +  - "img,max-burst-multiplier"

Don't need quotes.

> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mdc: dma-controller@18143000 {

Drop 'mdc'

> +      compatible = "img,pistachio-mdc-dma";
> +      reg = <0x18143000 0x1000>;
> +      interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>,
> +            <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&system_clk>;
> +      clock-names = "sys";
> +
> +      img,max-burst-multiplier = <16>;
> +      img,cr-periph = <&cr_periph>;
> +
> +      #dma-cells = <3>;
> +    };
> -- 
> 2.43.0
> 

