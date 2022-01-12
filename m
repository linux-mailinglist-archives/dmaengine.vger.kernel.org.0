Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE748BC5A
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 02:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiALBUw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jan 2022 20:20:52 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35371 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiALBUv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jan 2022 20:20:51 -0500
Received: by mail-ot1-f44.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so867700otu.2;
        Tue, 11 Jan 2022 17:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39pxu9W4GStnj6dnzwd+vQy+S9j15Cor0t03y34bb+0=;
        b=Ma+KpwgoFLMQ8lNdV9D8j+p45lqGLyBEttHdbq4cS54bO8RmnWkS8/O8wX+2XgFWVY
         C/R/vDKVwsZLnQDaNL0U8Fi+uV99Q5XxANnegducnF9u+x669KDElPFds9yTxRFvyfQY
         LmpctM+jhiyCNaTy8BQP7405m0RMbKuGO9esezn7bEicM+OV1r2snwhzesqD/nZq8Q+L
         3UM3odmuKzPA/q1VQd4RteuZjI44QJmwNuP9Vz064PIJCzBPm+kkmnHXBgxYhKup1mhd
         aXBNcmX3S3S7qzZ1lhXQppfj69fVG1plKEOPEdVfKhkWaGIo9vnUxJVacJXMX1kA+x7P
         1v+A==
X-Gm-Message-State: AOAM532REcpV8lQjlUz75r9BBg3jeqOw0z+/CBTq6RzWRTJee+UphoF2
        m8UVNUeZhKNnl/isMfP7Xw==
X-Google-Smtp-Source: ABdhPJwKVbRVa9Z+xJJQV2Zoqbju8GugslOnFTcRStaUzP01u262pTEw+JI9IsWNyzXghdTvpvlLiw==
X-Received: by 2002:a05:6830:25c1:: with SMTP id d1mr5202110otu.240.1641950450430;
        Tue, 11 Jan 2022 17:20:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p23sm2389801otf.37.2022.01.11.17.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:20:49 -0800 (PST)
Received: (nullmailer pid 3855120 invoked by uid 1000);
        Wed, 12 Jan 2022 01:20:48 -0000
Date:   Tue, 11 Jan 2022 19:20:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-oxnas@groups.io, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: dma: Add bindings for ox810se dma engine
Message-ID: <Yd4s8OYf7QSryXzr@robh.at.kernel.org>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
 <20220104145206.135524-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104145206.135524-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 04, 2022 at 03:52:03PM +0100, Neil Armstrong wrote:
> This adds the YAML dt-bindings for the DMA engine found in the
> Oxford Semiconductor OX810SE SoC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/dma/oxsemi,ox810se-dma.yaml      | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> new file mode 100644
> index 000000000000..6efa28e8b124
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/oxsemi,ox810se-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Oxford Semiconductor DMA Controller Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1
> +
> +  compatible:
> +    const: oxsemi,ox810se-dma
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: dma
> +      - const: sgdma
> +
> +  interrupts:
> +    maxItems: 5

Need to define what each one is.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: dma
> +      - const: sgdma
> +
> +  dma-channels: true

Constraints on number of channels?

> +
> +  oxsemi,targets-types:
> +    description:
> +      Table with allowed memory ranges and memory type associated.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> +    minItems: 4
> +    items:
> +      items:
> +        - description:
> +            The first cell defines the memory range start address
> +        - description:
> +            The first cell defines the memory range end address
> +        - description:
> +            The third cell represents memory type, 0 for SATA,
> +            1 for DPE RX, 2 for DPE TX, 5 for AUDIO TX, 6 for AUDIO RX,
> +            15 for DRAM MEMORY.
> +          enum: [ 0, 1, 2, 5, 6, 15 ]
> +
> +required:
> +  - "#dma-cells"
> +  - dma-channels
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - reset-names
> +  - oxsemi,targets-types
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma: dma-controller@600000 {

Drop unused labels.

> +        compatible = "oxsemi,ox810se-dma";
> +        reg = <0x600000 0x100000>, <0xc00000 0x100000>;
> +        reg-names = "dma", "sgdma";
> +        interrupts = <13>, <14>, <15>, <16>, <20>;
> +        clocks = <&stdclk 1>;
> +        resets = <&reset 8>, <&reset 24>;
> +        reset-names = "dma", "sgdma";
> +
> +        /* Encodes the authorized memory types */
> +        oxsemi,targets-types =
> +            <0x45900000 0x45a00000 0>,  /* SATA */
> +            <0x42000000 0x43000000 0>,  /* SATA DATA */
> +            <0x48000000 0x58000000 15>, /* DDR */
> +            <0x58000000 0x58020000 15>; /* SRAM */
> +
> +        #dma-cells = <1>;
> +        dma-channels = <5>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
