Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2905936F136
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhD2Ujq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 16:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236675AbhD2Ujp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 16:39:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA9B61424;
        Thu, 29 Apr 2021 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619728738;
        bh=7fpzpOV4zd0vGWk7Nig3KUb6uMJJYVewdGFJlgXV4LY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cNpYsunI00J2o1O4QCg8osIK8v04uOc/PbHjS4Y4zu2D5I/+eqeyDYZrSDU5FmVbj
         0G2UtVVjmkkt7WxU0uOMKAIfa9rCWwxpSk2y+3dzNPILqIfhtjNwcx6KHa8n0yrs4j
         EIy/9Z/KXE1a9BkIase6egfGDf4n2W1Unuq/blldVABxfty4wFUyic5bpwpV/CWX9Z
         qXc3yWEVsuARaZlVG2rSZ0iaEREf2ZQXxLwGMF0lVmcd/iM+G6oJvWCjFuCCHTFv3o
         dWTNZVh6/wys/RkO3Nh53WIzySBYPLGlkIkXRXOa47KiGmzKj58HAMX75D7xGcALL0
         uZglbRslGJl/g==
Received: by mail-ej1-f51.google.com with SMTP id n2so101854491ejy.7;
        Thu, 29 Apr 2021 13:38:58 -0700 (PDT)
X-Gm-Message-State: AOAM531M9hk9YIVsbscfLwQET38f16VfFIHjBkTmSFCSxs/1K3OFQmOJ
        jxoqjAtLaR7z+w+QA1+aO4IlzorpKMbSHjhyPA==
X-Google-Smtp-Source: ABdhPJys+AHIA7g0Hb9LngctVWlxApTbTRNaemN0NP5iP2Mprf+bpox8GRotpdVwoHfbA6KYjOGY7O7u2wDHKbJNX7I=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr393550ejm.130.1619728737129;
 Thu, 29 Apr 2021 13:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210429192504.1148842-1-clabbe@baylibre.com>
In-Reply-To: <20210429192504.1148842-1-clabbe@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Apr 2021 15:38:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqFGU5EG+7GuRKFBaYZkB+Af41ZvqZH=54PH7qCQoMEg@mail.gmail.com>
Message-ID: <CAL_JsqJqFGU5EG+7GuRKFBaYZkB+Af41ZvqZH=54PH7qCQoMEg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: dma: convert arm-pl08x to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Vinod <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 29, 2021 at 2:25 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> Converts dma/arm-pl08x.txt to yaml.
> In the process, I add an example for the faraday variant.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixes yamllint warning about indent
> - added select
> - fixed example (needed includes)
>
>  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
>  .../devicetree/bindings/dma/arm-pl08x.yaml    | 141 ++++++++++++++++++
>  2 files changed, 141 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml

> diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> new file mode 100644
> index 000000000000..06dec6f3e9a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM PrimeCells PL080 and PL081 and derivatives DMA controller
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +# We need a select here so we don't match all nodes with 'arm,primecell'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - arm,pl080
> +          - arm,pl081
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: "arm,pl080"
> +          - const: "arm,primecell"
> +      - items:
> +          - const: "arm,pl081"
> +          - const: "arm,primecell"

The first 2 oneOf entries can be combined into one.

And you don't need quotes.

> +      - items:
> +          - const: faraday,ftdma020
> +          - const: arm,pl080
> +          - const: arm,primecell

blank line between each DT property

> +  arm,primecell-periphid:
> +    $ref: /schemas/types.yaml#/definitions/uint32

This already has a type in the common definition, so drop.

> +    description: on the FTDMAC020 the primecell ID is not hard-coded
> +                 in the hardware and must be specified here as <0x0003b080>. This number
> +                 follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
> +                 for Faraday Technology.
> +  reg:
> +    minItems: 1

Convention is 'maxItems: 1'.

> +    description: Address range of the PL08x registers
> +  interrupts:
> +    minItems: 1
> +    description: The PL08x interrupt number
> +  clocks:
> +    minItems: 1
> +    description: The clock running the IP core clock
> +  clock-names:
> +    const: "apb_pclk"

primecell.yaml already covers this IIRC. Just 'maxItems: 1' is fine here.

> +  lli-bus-interface-ahb1:
> +    type: boolean
> +    description: if AHB master 1 is eligible for fetching LLIs
> +  lli-bus-interface-ahb2:
> +    type: boolean
> +    description: if AHB master 2 is eligible for fetching LLIs
> +  mem-bus-interface-ahb1:
> +    type: boolean
> +    description: if AHB master 1 is eligible for fetching memory contents
> +  mem-bus-interface-ahb2:
> +    type: boolean
> +    description: if AHB master 2 is eligible for fetching memory contents
> +  "#dma-cells":
> +    const: 2
> +    description: must be <2>. First cell should contain the DMA request,

'must be <2>' is already stated by the schema.

> +                 second cell should contain either 1 or 2 depending on
> +                 which AHB master that is used.
> +
> +  memcpy-burst-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 1
> +      - 4
> +      - 8
> +      - 16
> +      - 32
> +      - 64
> +      - 128
> +      - 256
> +    description: the size of the bursts for memcpy
> +  memcpy-bus-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 8
> +      - 16
> +      - 32
> +      - 64
> +    description: |

Don't need '|' unless you need to preserve formatting.

> +                 the bus width used for memcpy in bits: 8, 16 or 32 are legal
> +                 values, the Faraday FTDMAC020 can also accept 64 bits
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dmac0: dma-controller@10130000 {
> +      compatible = "arm,pl080", "arm,primecell";
> +      reg = <0x10130000 0x1000>;
> +      interrupt-parent = <&vica>;
> +      interrupts = <15>;
> +      clocks = <&hclkdma0>;
> +      clock-names = "apb_pclk";
> +      lli-bus-interface-ahb1;
> +      lli-bus-interface-ahb2;
> +      mem-bus-interface-ahb2;
> +      memcpy-burst-size = <256>;
> +      memcpy-bus-width = <32>;
> +      #dma-cells = <2>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    dma-controller@67000000 {
> +      compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
> +      /* Faraday Technology FTDMAC020 variant */
> +      arm,primecell-periphid = <0x0003b080>;
> +      reg = <0x67000000 0x1000>;
> +      interrupts = <9 IRQ_TYPE_EDGE_RISING>;
> +      resets = <&syscon GEMINI_RESET_DMAC>;
> +      clocks = <&syscon GEMINI_CLK_AHB>;
> +      clock-names = "apb_pclk";
> +      /* Bus interface AHB1 (AHB0) is totally tilted */
> +      lli-bus-interface-ahb2;
> +      mem-bus-interface-ahb2;
> +      memcpy-burst-size = <256>;
> +      memcpy-bus-width = <32>;
> +      #dma-cells = <2>;
> +    };
> --
> 2.26.3
>
