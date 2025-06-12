Return-Path: <dmaengine+bounces-5416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB66AD705A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 14:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FA1BC69FA
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984F21FF5B;
	Thu, 12 Jun 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcfBFAxr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A22192F8;
	Thu, 12 Jun 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731223; cv=none; b=TWyxNIUt82QVruePAQUOlN1vQVNHiVRElEawxEcHcva+SUrnfyZfpgtlxBMrUeOj48mJMZzPCrqdVFAtivEBEAcVkNR7kjmy2Vt7ui74fMAENcqKELop+3+iNU+X9omzji/7PR53IW4evwxPPUq8hA4ZsCiTzYCci3wt40rOgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731223; c=relaxed/simple;
	bh=5MEjtAv0TqGxOCKaA9pBWp/Tk5XUhQhcp65ZW/zGUnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7kAR9tE9yL1lhF9itfFHOSRn6nHYL+DGv9dXKNeV0xEZicz6jUMj+BExRjU0FCBn4gdk++d5GulL2rUdeHEIk1QiVhEug/kiHSIizrpgKMnWUYZlLDlcVuxQOAorKXklmCoOCk3i/EPIhUfUEPkJ7bxJjY4/B/yAFJ+5uPYonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcfBFAxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE706C4CEEA;
	Thu, 12 Jun 2025 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731223;
	bh=5MEjtAv0TqGxOCKaA9pBWp/Tk5XUhQhcp65ZW/zGUnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcfBFAxr3a6JicMjX5aD0ukleYBYEeRoFZ+Pmer0DVHYGclj7exMVMdaEexYOHPuK
	 x0mAY62mxzio5CNVjOfKkExAONLtMqAZTKnqldh9SHu3cjxykNBZhlvgG5YeXEncL/
	 y4k+R/2mTgJzyYlxFgX/bn7tI91ryNNskeDgxRCRycgjrGcULabmcfo4tlRlwstQ14
	 BRrU0ts1myPa3jtRWg7nhuEFXG6ksLkfWPesebnBOg39aGrwXDHges66egPTFKRbM2
	 02rNYPTYuH2ZQV6psft2dEVwiCX0ygIeSaig+lMneQC4t1oZRGRdUMYB2JTYURK/24
	 4a4prVDWMBeIQ==
Date: Thu, 12 Jun 2025 07:27:01 -0500
From: Rob Herring <robh@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
	vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com, p-mantena@ti.com
Subject: Re: [PATCH v2 12/17] dt-bindings: dma: ti: Add document for K3 BCDMA
 V2
Message-ID: <20250612122701.GA1171082-robh@kernel.org>
References: <20250612071521.3116831-1-s-adivi@ti.com>
 <20250612071521.3116831-13-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612071521.3116831-13-s-adivi@ti.com>

On Thu, Jun 12, 2025 at 12:45:16PM +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA) V2.

Drop 'document for' in the subject.

> 
> BCDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/k3-bcdma-v2.yaml          | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> new file mode 100644
> index 0000000000000..9d86e515bdefb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024-2025 Texas Instruments Incorporated
> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>

git records the author. Don't need it here.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/k3-bcdma-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS BCDMA V2
> +
> +maintainers:
> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +
> +description: |
> +  The BCDMA V2 is intended to perform similar functions as the TR
> +  mode channels of K3 UDMA-P.
> +  BCDMA V2 includes block copy channels and Split channels.

Is this one paragraph or 2? Either blank line between paragraphs or wrap 
at 80 char.

> +
> +  Block copy channels mainly used for memory to memory transfers, but with
> +  optional triggers a block copy channel can service peripherals by accessing
> +  directly to memory mapped registers or area.
> +
> +  Split channels can be used to service PSI-L based peripherals.
> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
> +  legacy peripheral.
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,am62l-dmss-bcdma
> +
> +  reg:
> +    items:
> +      - description: BCDMA Control /Status
> +      - description: Block Copy Channel Realtime
> +      - description: Channel Realtime
> +      - description: Ring Realtime
> +
> +  reg-names:
> +    items:
> +      - const: gcfg
> +      - const: bchanrt
> +      - const: chanrt
> +      - const: ringrt
> +
> +  "#dma-cells":
> +    const: 4
> +    description: |
> +      cell 1: Trigger type for the channel
> +        0 - disable / no trigger
> +        1 - internal channel event
> +        2 - external signal
> +        3 - timer manager event
> +
> +      cell 2: parameter for the trigger:
> +        if cell 1 is 0 (disable / no trigger):
> +          Unused, ignored
> +        if cell 1 is 1 (internal channel event):
> +          channel number whose TR event should trigger the current channel.
> +        if cell 1 is 2 or 3 (external signal or timer manager event):
> +          index of global interfaces that come into the DMA.
> +
> +          Please refer to the device documentation for global interface indexes.
> +
> +      cell 3: Channel number for the peripheral
> +
> +        Please refer to the device documentation for the channel map.
> +
> +      cell 4: ASEL value for the channel
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    cbass_main {

Don't use '_' in node names. 

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dma-controller@485c4000 {
> +            compatible = "ti,dmss-bcdma-v2";
> +            reg = <0x00 0x485c4000 0x00 0x4000>,
> +                  <0x00 0x48880000 0x00 0x10000>,
> +                  <0x00 0x48800000 0x00 0x80000>,
> +                  <0x00 0x47000000 0x00 0x200000>;
> +            reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
> +            #dma-cells = <4>;
> +        };
> +    };
> -- 
> 2.34.1
> 

