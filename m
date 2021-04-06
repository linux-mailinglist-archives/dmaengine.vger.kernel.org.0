Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440EA355AEB
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhDFSA5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:00:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34512 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDFSA5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:00:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136I0U1p074029;
        Tue, 6 Apr 2021 13:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617732030;
        bh=pdrN4fdiS9znRyNa4gZLkEt2osmeyCC9GkQ1FnhYcZc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mxcBPsucGP/zPR5/Dg0J6lzgkt6c9+IlWEow/j2r1uYATMNTbVz99zNTZICQZGM4D
         Id5qBL4YxBrFdp/HbqF/GXHH+Zf3J8HyGJTmSmy5iD6178SYj/CXMHmOfTog3DCKZE
         QPq4evHt0UTK2WFhKpmu6hfvKU4SUpGAQsQG020s=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136I0UXh114415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:00:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:00:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:00:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136I0TqO115647;
        Tue, 6 Apr 2021 13:00:29 -0500
Date:   Tue, 6 Apr 2021 23:30:28 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20210406180026.dexu6xelj63wvfeg@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-13-p.yadav@ti.com>
 <20210401155201.GA488101@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210401155201.GA488101@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/04/21 10:52AM, Rob Herring wrote:
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

Ok.

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

Ok.

> 
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description:
> > +      PM domain provider node and an args specifier containing
> > +      the device id value.
> 
> Drop.

Ok.

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

Ok.

> 
> > +    type: object
> > +    description: CSI2 bridge node.
> 
> Just an empty node?

No. It should be a node for the Cadence csi2rx IP (compatible 
"cdns,csi2rx"). I'm not sure how to model this. This subnode is needed 
but it should take its properties from the Cadence csi2rx schema. Will a 

  properties:
    allOf:
      - $ref: cdns,csi2rx.yaml#

be a good idea?

> 
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
> > -- 
> > 2.30.0
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
