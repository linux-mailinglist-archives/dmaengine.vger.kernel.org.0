Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B773B0DC3
	for <lists+dmaengine@lfdr.de>; Tue, 22 Jun 2021 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFVTrS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Jun 2021 15:47:18 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:34380 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFVTrS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Jun 2021 15:47:18 -0400
Received: by mail-io1-f44.google.com with SMTP id g22so552191iom.1;
        Tue, 22 Jun 2021 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jt10eaPE2d0A23q2PDE5V1BLvXyDr99ajxzQdh6Kcd0=;
        b=HWfx31+WtSURRYbJ/7MlkNSm+SEQodfSzxzXfygAmFgzAlypyll/NFp1Sm32pQ9BRL
         Z5Q+eJE4m3tygC9vR1zFxAtbBfR811cGTUOaLqZgOonuIE/Lm7/3zynAD0h1ndSBFVRl
         a6jPGiosHEsG9jGfUAaPDWloe/+V3YPqnfogybjMidozP9xVrOiXsfcJPItlZ3GzU1q5
         GciGvLG/PdfepAyShHuM85y7XCBgDBrLGMEOJDN08Y3qTw1aPApszwLuMP86BvpfT+KA
         9pk1QY4ehV2os/PWInI8SsT29xHa4EaeSpkoWg0bCXl9455fIps4dRUQ0lx2XXR3lktj
         La5A==
X-Gm-Message-State: AOAM531lip+4GgSA9FbB10Ms84L8lIQLVLu6UQ3i1oFNTowpIdz53Cjd
        Avz/M7tNtMmbvKJKsYlrehwM06kFTQ==
X-Google-Smtp-Source: ABdhPJzUm/qgMghhv3cFAfgIucKHSIU1Ao9zoFXcWsgOMpfQgypogCGC/J8Aqqh/SlvnOBIlFZSBUQ==
X-Received: by 2002:a02:a501:: with SMTP id e1mr5444394jam.83.1624391101994;
        Tue, 22 Jun 2021 12:45:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g7sm8447737ilq.15.2021.06.22.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 12:45:01 -0700 (PDT)
Received: (nullmailer pid 17105 invoked by uid 1000);
        Tue, 22 Jun 2021 19:44:59 -0000
Date:   Tue, 22 Jun 2021 13:44:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: Document RZ/G2L bindings
Message-ID: <20210622194459.GA3755@robh.at.kernel.org>
References: <20210621143339.16754-1-biju.das.jz@bp.renesas.com>
 <20210621143339.16754-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621143339.16754-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 21, 2021 at 03:33:36PM +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in 
> next 5.14-rc1 release.
> 
> v2->v3:
>   * Added error interrupt first.
>   * Updated clock and reset maxitems.
>   * Added Geert's Rb tag.
> v1->v2:
>   * Made interrupt names in defined order
>   * Removed src address and channel configuration from dma-cells.
>   * Changed the compatibele string to "renesas,r9a07g044-dmac".
> v1:-
>   * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> new file mode 100644
> index 000000000000..0a59907ed041
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -0,0 +1,120 @@
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
> +          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> +      - const: renesas,rz-dmac
> +
> +  reg:
> +    items:
> +      - description: Control and channel register block
> +      - description: DMA extended resource selector block
> +
> +  interrupts:
> +    maxItems: 17
> +
> +  interrupt-names:
> +    items:
> +      - const: error
> +      - const: ch0
> +      - const: ch1
> +      - const: ch2
> +      - const: ch3
> +      - const: ch4
> +      - const: ch5
> +      - const: ch6
> +      - const: ch7
> +      - const: ch8
> +      - const: ch9
> +      - const: ch10
> +      - const: ch11
> +      - const: ch12
> +      - const: ch13
> +      - const: ch14
> +      - const: ch15
> +
> +  clocks:
> +    maxItems: 2

Need to define what each one is.

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
> +    maxItems: 2

Need to define what each one is.

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
> +        compatible = "renesas,r9a07g044-dmac",
> +                     "renesas,rz-dmac";
> +        reg = <0x11820000 0x10000>,
> +              <0x11830000 0x10000>;
> +        interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
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
> +                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "error",
> +                          "ch0", "ch1", "ch2", "ch3",
> +                          "ch4", "ch5", "ch6", "ch7",
> +                          "ch8", "ch9", "ch10", "ch11",
> +                          "ch12", "ch13", "ch14", "ch15";
> +        clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
> +                 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
> +        power-domains = <&cpg>;
> +        resets = <&cpg R9A07G044_DMAC_ACLK>,
> +                 <&cpg R9A07G044_DMAC_PCLK>;
> +        #dma-cells = <1>;
> +        dma-channels = <16>;
> +    };
> -- 
> 2.17.1
> 
> 
