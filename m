Return-Path: <dmaengine+bounces-3412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB49AB7D7
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 22:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF1A283E23
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F81CC8A1;
	Tue, 22 Oct 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvB4UYKM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DC1CC88A;
	Tue, 22 Oct 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629794; cv=none; b=OsGunNU/rskTTaJgs5OEmjpnro4ILrMI9tQ6i/4kP4/EE9jXXqk1/F0y1jSJvgYcdoMQXjarkKj3U8LNTy7y2rtAuWdSmTV3+H5dMc9zlqCUo/m3BJdLO6UiXdVQC2xkbgjLfkUWCn92VSKQg5CKaUB/lZ0TNdBT6u7wpvS3SDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629794; c=relaxed/simple;
	bh=5fembjrFYHH0Uxd/AJeoKR2phtLvd9IwGMMXh/aNqUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhnhC6SyG5RjIN25lCnx/8rBtSEssM8AUoA0ux5mvmrfBmhD/lQUb9gT1fm7y8MWe0tRZO9MPHX0HxFDL2oien+d2R/nKym6OQRSil1nZ3LPTC8WZGbkLy3wO8EB6ihtfgOFaAgJ3LtqbWZWNzA/3TVeIQNQHWIBrHilmz6Sg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvB4UYKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D603C4CEC3;
	Tue, 22 Oct 2024 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729629793;
	bh=5fembjrFYHH0Uxd/AJeoKR2phtLvd9IwGMMXh/aNqUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvB4UYKMsaCcd9sGc/YETcZeKf9PAiD83chFfuoCPJJQbVerE342CrGhTzbIaJFf5
	 e7+ZZ5KfGM7h9VS1eAoTPI+C+ydAKduvaSMQ89d4BF7i4ExM2/VbL0GXBYr4wCoW+B
	 NV2zRkGIqUFC3zlPa6vNc3xqWp0rZFDVSF4erCZ4PPuf0pXo6VUXiE4rMOYSKBdGnh
	 fqpPG6YFiH3BAG3Oxp25IDNPqV0O1Ce5Ke5UH0UO6oWdbug6zvpV5U1elOkI0R7knY
	 8LdN2iKjsY9p3pfwxB/gnvD/RajNS+8lPfZzD5lU1OBVTmvNIYi3Lrd2YNWs4ZPHw1
	 qQlYpgvw/dB/g==
Date: Tue, 22 Oct 2024 15:43:12 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema
Message-ID: <20241022204312.GA1524310-robh@kernel.org>
References: <20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com>
 <20241022-axi-dma-dt-yaml-v1-1-68f2a2498d53@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-axi-dma-dt-yaml-v1-1-68f2a2498d53@baylibre.com>

On Tue, Oct 22, 2024 at 12:46:40PM -0500, David Lechner wrote:
> Convert the AXI DMAC bindings from .txt to .yaml.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For the maintainer, Lars is the original author, but isn't really
> active with ADI anymore, so I have added Nuno instead since he is the
> most active ADI representative currently and is knowledgeable about this
> hardware.
> 
> Also, the rob-bot is likely to complain. Locally, I am getting the
> following warning from dt_bindings_check:
> 
> 	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
> 		hint: A vendor boolean property can use "type: boolean"
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb
> 
> I think this is telling me that object nodes should not have a vendor
> prefix. However, since this is an existing bindings, we can't change
> that.

Yes, that can be ignored. I'll have to drop that check from dtschema.

> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 137 +++++++++++++++++++++
>  2 files changed, 137 insertions(+), 61 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt b/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
> deleted file mode 100644
> index cd17684aaab5..000000000000
> --- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -Analog Devices AXI-DMAC DMA controller
> -
> -Required properties:
> - - compatible: Must be "adi,axi-dmac-1.00.a".
> - - reg: Specification for the controllers memory mapped register map.
> - - interrupts: Specification for the controllers interrupt.
> - - clocks: Phandle and specifier to the controllers AXI interface clock
> - - #dma-cells: Must be 1.
> -
> -Required sub-nodes:
> - - adi,channels: This sub-node must contain a sub-node for each DMA channel. For
> -   the channel sub-nodes the following bindings apply. They must match the
> -   configuration options of the peripheral as it was instantiated.
> -
> -Required properties for adi,channels sub-node:
> - - #size-cells: Must be 0
> - - #address-cells: Must be 1
> -
> -Required channel sub-node properties:
> - - reg: Which channel this node refers to.
> - - adi,source-bus-width,
> -   adi,destination-bus-width: Width of the source or destination bus in bits.
> - - adi,source-bus-type,
> -   adi,destination-bus-type: Type of the source or destination bus. Must be one
> -   of the following:
> -	0 (AXI_DMAC_TYPE_AXI_MM): Memory mapped AXI interface
> -	1 (AXI_DMAC_TYPE_AXI_STREAM): Streaming AXI interface
> -	2 (AXI_DMAC_TYPE_AXI_FIFO): FIFO interface
> -
> -Deprecated optional channel properties:
> - - adi,length-width: Width of the DMA transfer length register.
> - - adi,cyclic: Must be set if the channel supports hardware cyclic DMA
> -   transfers.
> - - adi,2d: Must be set if the channel supports hardware 2D DMA transfers.
> -
> -DMA clients connected to the AXI-DMAC DMA controller must use the format
> -described in the dma.txt file using a one-cell specifier. The value of the
> -specifier refers to the DMA channel index.
> -
> -Example:
> -
> -dma: dma@7c420000 {
> -	compatible = "adi,axi-dmac-1.00.a";
> -	reg = <0x7c420000 0x10000>;
> -	interrupts = <0 57 0>;
> -	clocks = <&clkc 16>;
> -	#dma-cells = <1>;
> -
> -	adi,channels {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -
> -		dma-channel@0 {
> -			reg = <0>;
> -			adi,source-bus-width = <32>;
> -			adi,source-bus-type = <ADI_AXI_DMAC_TYPE_MM_AXI>;
> -			adi,destination-bus-width = <64>;
> -			adi,destination-bus-type = <ADI_AXI_DMAC_TYPE_FIFO>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
> new file mode 100644
> index 000000000000..e457630ec7c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/adi,axi-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI-DMAC DMA controller
> +
> +description: http://analogdevicesinc.github.io/hdl/library/axi_dmac/index.html

Please make description more than just a link.

> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +
> +properties:
> +  compatible:
> +    const: adi,axi-dmac-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  adi,channels:
> +    type: object
> +    description: This sub-node must contain a sub-node for each DMA channel.
> +
> +    properties:
> +      "#size-cells":
> +        const: 0
> +      "#address-cells":
> +        const: 1
> +
> +    patternProperties:
> +      "^dma-channel@[0-9a-f]+$":
> +        type: object
> +        description:
> +          DMA channel properties based on HDL compile-time configuration.
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          adi,source-bus-width:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Width of the source bus in bits.
> +            enum: [8, 16, 32, 64, 128]
> +
> +          adi,destination-bus-width:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Width of the destination bus in bits.
> +            enum: [8, 16, 32, 64, 128]
> +
> +          # 0 (AXI_DMAC_TYPE_AXI_MM): Memory mapped AXI interface
> +          # 1 (AXI_DMAC_TYPE_AXI_STREAM): Streaming AXI interface
> +          # 2 (AXI_DMAC_TYPE_AXI_FIFO): FIFO interface

Put these in the 'description'

> +
> +          adi,source-bus-type:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Type of the source bus.
> +            enum: [0, 1, 2]
> +
> +          adi,destination-bus-type:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Type of the destination bus.
> +            enum: [0, 1, 2]
> +
> +          adi,length-width:
> +            deprecated: true
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Width of the DMA transfer length register.
> +
> +          adi,cyclic:
> +            deprecated: true
> +            type: boolean
> +            description:
> +              Must be set if the channel supports hardware cyclic DMA transfers.
> +
> +          adi,2d:
> +            deprecated: true
> +            type: boolean
> +            description:
> +              Must be set if the channel supports hardware 2D DMA transfers.
> +
> +        required:
> +          - reg
> +          - adi,source-bus-width
> +          - adi,destination-bus-width
> +          - adi,source-bus-type
> +          - adi,destination-bus-type
> +
> +        additionalProperties: false

Put this before 'properties'. Easier to read the indented cases that 
way.

> +
> +    required:
> +      - "#size-cells"
> +      - "#address-cells"
> +
> +    additionalProperties: false

ditto

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - "#dma-cells"
> +  - adi,channels
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma: dma@7c420000 {

Drop unused labels.

dma-controller@7c420000

> +        compatible = "adi,axi-dmac-1.00.a";
> +        reg = <0x7c420000 0x10000>;
> +        interrupts = <0 57 0>;
> +        clocks = <&clkc 16>;
> +        #dma-cells = <1>;
> +
> +        adi,channels {
> +            #size-cells = <0>;
> +            #address-cells = <1>;
> +
> +            dma-channel@0 {
> +                reg = <0>;
> +                adi,source-bus-width = <32>;
> +                adi,source-bus-type = <0>; /* AXI_DMAC_TYPE_AXI_MM */
> +                adi,destination-bus-width = <64>;
> +                adi,destination-bus-type = <2>; /* AXI_DMAC_TYPE_AXI_FIFO */
> +            };
> +        };
> +    };
> 
> -- 
> 2.43.0
> 

