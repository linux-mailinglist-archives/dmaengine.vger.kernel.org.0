Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026A1355B16
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhDFSPg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:15:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57338 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhDFSPg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:15:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136IF8br123953;
        Tue, 6 Apr 2021 13:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617732908;
        bh=6WWOGoVwUmU8hn0OiwFKDgcwGqWJVhVQIFo3m6t14HI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=F+e6Bstz8oYQRzY5IazO6a/Q+zySAT9uP4b5nlQxiGtOHsup5bJi/xKOSHu0RDoiU
         vudeYuYPF4R3QnqUffLvSmG3SEUj/yThXoM3Y3G0iTsHLguhqSiotjNjykRuPoaAbX
         B0m38ZBPIC9g9i5/XpXsaRXtS+TBBXX6/D/mwwS8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136IF8wa018660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:15:08 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:15:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:15:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136IF7Dp072661;
        Tue, 6 Apr 2021 13:15:07 -0500
Date:   Tue, 6 Apr 2021 23:45:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Rob Herring <robh@kernel.org>,
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
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX
 driver
Message-ID: <20210406181504.6wcungcw2dwhp6vg@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-13-p.yadav@ti.com>
 <20210401155201.GA488101@robh.at.kernel.org>
 <YGbrcKPA9K8Ws0lv@pendragon.ideasonboard.com>
 <YGb3rnuDCdM6XnvJ@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGb3rnuDCdM6XnvJ@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:53PM, Laurent Pinchart wrote:
> On Fri, Apr 02, 2021 at 01:01:22PM +0300, Laurent Pinchart wrote:
> > On Thu, Apr 01, 2021 at 10:52:01AM -0500, Rob Herring wrote:
> > > On Tue, Mar 30, 2021 at 11:03:44PM +0530, Pratyush Yadav wrote:
> > > > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > > > capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> > > > parts together.
> > > > 
> > > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > > ---
> > > >  .../devicetree/bindings/media/ti,csi2rx.yaml  | 70 +++++++++++++++++++
> > > >  1 file changed, 70 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/ti,csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > > > new file mode 100644
> > > > index 000000000000..ebd894364391
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> > > > @@ -0,0 +1,70 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/ti,csi2rx.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: TI CSI2RX Wrapper Device Tree Bindings
> > > > +
> > 
> > A description would be useful, especially given that the TRM doesn't
> > mention "CSI2RX".
> > 
> > > > +maintainers:
> > > > +  - Pratyush Yadav <p.yadav@ti.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: ti,csi2rx
> > > > +
> > > > +  dmas:
> > > > +    description: RX DMA Channel 0
> > > 
> > > items:
> > >   - description: RX DMA Channel 0
> > > 
> > > Or just 'maxItems: 1'
> > > 
> > > > +
> > > > +  dma-names:
> > > > +    items:
> > > > +      - const: rx0
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description: Base address and size of the TI wrapper registers.
> > > 
> > > That's all 'reg' properties, drop 'description'.
> > 
> > According to SPRUIL1B, there are four register banks for the CSI_RX_IF,
> > and two register banks for the DPHY_RX. What's your plan to support
> > these ? Not everything need to be implemented at once, but backward
> > compatibility need to be taken into account in the design.
> > 
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      PM domain provider node and an args specifier containing
> > > > +      the device id value.
> > > 
> > > Drop.
> > > 
> > > > +
> > > > +  ranges: true
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 2
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 2
> > > > +
> > > > +patternProperties:
> > > > +  "csi-bridge@":
> > > 
> > > "^csi-bridge@"
> > > 
> > > > +    type: object
> > > > +    description: CSI2 bridge node.
> > > 
> > > Just an empty node?
> > 
> > Even if the node is optional, it would be useful to include it in the
> > example below, to show how it's supposed to be used.
> > 
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - dmas
> > > > +  - dma-names
> > > > +  - power-domains
> > > > +  - "#address-cells"
> > > > +  - "#size-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> > > > +
> > > > +    ti_csi2rx0: ticsi2rx {
> > > > +        compatible = "ti,csi2rx";
> > > > +        dmas = <&main_udmap 0x4940>;
> > > > +        dma-names = "rx0";
> > > > +        reg = <0x0 0x4500000 0x0 0x1000>;
> > > > +        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
> > > > +        #address-cells = <2>;
> > > > +        #size-cells = <2>;
> > > > +    };
> 
> It would also be useful to expand this to a full example that includes
> integration with the PHY.

Integration with PHY is Cadence CSI2RX schema's problem. But I will add 
the subnode here anyway so it should have the PHY related properties as 
well.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
