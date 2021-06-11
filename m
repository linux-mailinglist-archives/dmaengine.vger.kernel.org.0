Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70CC3A4986
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFKTl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 15:41:29 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:43716 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKTl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 15:41:29 -0400
Received: by mail-il1-f174.google.com with SMTP id x18so6184329ila.10;
        Fri, 11 Jun 2021 12:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NpZcvggxFqahbTtAQ/JfigfoBMJtVtYbBK96DFp/VA=;
        b=SZy+YePLQ1MaPGXBE/+sNMTVZuMjGDnczjWM2LbRsyt+tkdUWEtjx3Sc+YZPtAfUKk
         PeIprja86CywuFutiX3vFoFxlhfDSsNGW9mwcnfdHffatpTcDk3eIf01YCnz6L64KWj3
         BXGzy3DnsdZdI1f3rxA2kZLlJbqdSr1Q2CMq1ADTRIxmLM62xDUIm7HgAOWmk7TLiI+D
         W6JM/FksUXD/zmnZv0bZmARG/x1FJC6w8Je1U9IhCb9sGZdRuhnYPLGQC2rtUUzf6H2D
         SKgWN2ZXQNHYwUKSbAHLCsQonLt5ch3pk5ORP+9xroJE3sE+xF39Bj/S3Y0B5qJQNN0W
         N40g==
X-Gm-Message-State: AOAM532+xUlbvCPuGGR4oV7H4b9/Ix3k9C8/j41KXtcNchRFG8LCn/u4
        G2nUWl1VdcU5AsTTbF33hbQhTsyiyg==
X-Google-Smtp-Source: ABdhPJx71Mrc+D8b93a6XajbFWbdozG3tzhyh3BUTghkbFlopXboyObUkpGJsZ7QSG1FxLGB74bSsA==
X-Received: by 2002:a05:6e02:eaf:: with SMTP id u15mr4302344ilj.0.1623440359098;
        Fri, 11 Jun 2021 12:39:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q6sm3971652ilm.45.2021.06.11.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:39:18 -0700 (PDT)
Received: (nullmailer pid 1541768 invoked by uid 1000);
        Fri, 11 Jun 2021 19:39:16 -0000
Date:   Fri, 11 Jun 2021 13:39:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Message-ID: <20210611193916.GA1254227@robh.at.kernel.org>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 11, 2021 at 12:36:38PM +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> new file mode 100644
> index 000000000000..df54bd6ddfd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L DMA Controller
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> +      - const: renesas,rz-dmac
> +
> +  reg:
> +    items:
> +      - description: Control and channel register block
> +      - description: DMA extension resource selector block
> +
> +  interrupts:
> +    maxItems: 17
> +
> +  interrupt-names:
> +    maxItems: 17
> +    items:
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"

Is there some reason these need be in undefined order?

> +      - const: error
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      The cell specifies the MID/RID of the DMAC port connected to
> +      the DMA client.
> +
> +  dma-channels:
> +    const: 16
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  renesas,rz-dmac-slavecfg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      DMA configuration for a slave channel. Each channel must have an array of
> +      3 items as below.
> +      first item in the array is MID+RID
> +      second item in the array is slave src or dst address
> +      third item in the array is channel configuration value.

Why not put all these in the dma-cells? You already have 1 of them.

Though doesn't the client device know what address to use?

> +    items:
> +      minItems: 3
> +      maxItems: 48
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +
> +    dmac: dma-controller@11820000 {
> +        compatible = "renesas,dmac-r9a07g044",
> +                     "renesas,rz-dmac";
> +        reg = <0x11820000 0x10000>,
> +              <0x11830000 0x10000>;
> +        interrupts = <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "ch0", "ch1", "ch2", "ch3",
> +                          "ch4", "ch5", "ch6", "ch7",
> +                          "ch8", "ch9", "ch10", "ch11",
> +                          "ch12", "ch13", "ch14", "ch15",
> +                          "error";
> +        clocks = <&cpg CPG_MOD R9A07G044_CLK_DMAC>;
> +        power-domains = <&cpg>;
> +        resets = <&cpg R9A07G044_CLK_DMAC>;
> +        #dma-cells = <1>;
> +        dma-channels = <16>;
> +        renesas,rz-dmac-slavecfg = <0x255 0x10049C18 0x0011228>;
> +    };
> -- 
> 2.17.1
