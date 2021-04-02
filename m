Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE36035293E
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhDBKCO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhDBKCJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:02:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B2C0613E6;
        Fri,  2 Apr 2021 03:02:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CAEF72C1;
        Fri,  2 Apr 2021 12:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617357725;
        bh=BwK8ADmyN5yPbUxid040ws2OoDNAKB3jwfGdu8fQZu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6U9n5vdWLQqcMaG+9TqXJIFsIVakimELdS5Z4Q0CD1sqXzXU/wZzECK/T3glx4Qb
         RYFYe4xlxpBoHt9Em4McABWRJBPpzbetZ5xp3Qc9rIs63dc1STbbKAKWC2Mo+5BRmu
         1DLv5hDerBLDJY2N3NBSy04VBkudO9QtsHBZMong=
Date:   Fri, 2 Apr 2021 13:01:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX
 driver
Message-ID: <YGbrcKPA9K8Ws0lv@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-13-p.yadav@ti.com>
 <20210401155201.GA488101@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401155201.GA488101@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 01, 2021 at 10:52:01AM -0500, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 11:03:44PM +0530, Pratyush Yadav wrote:
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> > parts together.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  .../devicetree/bindings/media/ti,csi2rx.yaml  | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/ti,csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > new file mode 100644
> > index 000000000000..ebd894364391
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/ti,csi2rx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI CSI2RX Wrapper Device Tree Bindings
> > +

A description would be useful, especially given that the TRM doesn't
mention "CSI2RX".

> > +maintainers:
> > +  - Pratyush Yadav <p.yadav@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: ti,csi2rx
> > +
> > +  dmas:
> > +    description: RX DMA Channel 0
> 
> items:
>   - description: RX DMA Channel 0
> 
> Or just 'maxItems: 1'
> 
> > +
> > +  dma-names:
> > +    items:
> > +      - const: rx0
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Base address and size of the TI wrapper registers.
> 
> That's all 'reg' properties, drop 'description'.

According to SPRUIL1B, there are four register banks for the CSI_RX_IF,
and two register banks for the DPHY_RX. What's your plan to support
these ? Not everything need to be implemented at once, but backward
compatibility need to be taken into account in the design.

> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description:
> > +      PM domain provider node and an args specifier containing
> > +      the device id value.
> 
> Drop.
> 
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +patternProperties:
> > +  "csi-bridge@":
> 
> "^csi-bridge@"
> 
> > +    type: object
> > +    description: CSI2 bridge node.
> 
> Just an empty node?

Even if the node is optional, it would be useful to include it in the
example below, to show how it's supposed to be used.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dmas
> > +  - dma-names
> > +  - power-domains
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> > +
> > +    ti_csi2rx0: ticsi2rx {
> > +        compatible = "ti,csi2rx";
> > +        dmas = <&main_udmap 0x4940>;
> > +        dma-names = "rx0";
> > +        reg = <0x0 0x4500000 0x0 0x1000>;
> > +        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +    };

-- 
Regards,

Laurent Pinchart
