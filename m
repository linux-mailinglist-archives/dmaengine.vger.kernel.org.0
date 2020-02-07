Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3682154FEF
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2020 02:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgBGBPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Feb 2020 20:15:22 -0500
Received: from mx.socionext.com ([202.248.49.38]:2700 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBGBPV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Feb 2020 20:15:21 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Feb 2020 10:15:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3B949180237;
        Fri,  7 Feb 2020 10:15:20 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 7 Feb 2020 10:15:20 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B18EA40365;
        Fri,  7 Feb 2020 10:15:19 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 780A3120133;
        Fri,  7 Feb 2020 10:15:19 +0900 (JST)
Date:   Fri, 07 Feb 2020 10:15:19 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20200206175458.GA12845@bogus>
References: <1580362048-28455-2-git-send-email-hayashi.kunihiko@socionext.com> <20200206175458.GA12845@bogus>
Message-Id: <20200207101519.6F78.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Thank you for reviewing.
Your comments are helpful as I'm not familiar with the new bindings yet.

On Thu, 6 Feb 2020 17:54:58 +0000 <robh@kernel.org> wrote:

> On Thu, Jan 30, 2020 at 02:27:27PM +0900, Kunihiko Hayashi wrote:
> > Add devicetree binding documentation for external DMA controller
> > implemented on Socionext UniPhier SoCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../bindings/dma/socionext,uniphier-xdmac.yaml     | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> > new file mode 100644
> > index 00000000..32abf18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings:
> 
> (GPL-2.0-only OR BSD-2-Clause)

I'll replace with it.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/socionext,uniphier-xdmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Socionext UniPhier external DMA controller
> > +
> > +description: |
> > +  This describes the devicetree bindings for an external DMA engine to perform
> > +  memory-to-memory or peripheral-to-memory data transfer capable of supporting
> > +  16 channels, implemented in Socionext UniPhier SoCs.
> > +
> > +maintainers:
> > +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: socionext,uniphier-xdmac
> 
> You can drop 'items' for a single item.

I see.
I found some documents didn't have expression for a compatible string.

> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> 
> You need to say what each entry is:
> 
> items:
>   - description: ...
>   - description: ...

Surely there must be descriotions here.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#dma-cells":
> > +    const: 2
> > +    description: |
> > +      DMA request from clients consists of 2 cells:
> > +        1. Channel index
> > +        2. Transfer request factor number, If no transfer factor, use 0.
> > +           The number is SoC-specific, and this should be specified with
> > +           relation to the device to use the DMA controller.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> 
> Add:
> 
> additionalProperties: false

I'll add it.

> > +
> > +examples:
> > +  - |
> > +    xdmac: dma-controller@5fc10000 {
> > +        compatible = "socionext,uniphier-xdmac";
> > +        reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
> > +        interrupts = <0 188 4>;
> > +        #dma-cells = <2>;
> > +        dma-channels = <16>;
> 
> Not documented. You need at least 'dma-channels: true' to indicate 
> you're using this. But you should be able to have some constraints such 
> as 'maximum: 16'.

I forgot to document 'dma-channels'. I'll add it.

Thank you,

---
Best Regards,
Kunihiko Hayashi

