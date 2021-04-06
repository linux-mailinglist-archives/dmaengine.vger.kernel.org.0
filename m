Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31220355BB1
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhDFSvo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:51:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38306 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhDFSvl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:51:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136IpEDw007939;
        Tue, 6 Apr 2021 13:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617735074;
        bh=Vs1ay3jn3W1+KiUPHbAfauoyCwmztua6vBwO95z5HqQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VYYrwQEOWc1SWk7ciLNyA57LJbw9tFtBCpQ5AWnHTVMG8Q7Ic8QgaPtvDQVM0Sbd8
         CybIiBCgqJ+uEK2AwvIqiJPFj+/WiYewKhjMyaP+P0eHVk5UK49tGjHB2dIgpgqxYv
         +VMVoom29gWlw545GN/4lqcbMGyKQpfnTNXy1wXM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136IpEAL076140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:51:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:51:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:51:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136IpD3k028810;
        Tue, 6 Apr 2021 13:51:13 -0500
Date:   Wed, 7 Apr 2021 00:21:12 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 14/16] dt-bindings: phy: Convert Cadence DPHY binding to
 YAML
Message-ID: <20210406185110.d7mp7grsevndcrr2@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-15-p.yadav@ti.com>
 <YGbwnTNiL6WYoxPF@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGbwnTNiL6WYoxPF@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:23PM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Tue, Mar 30, 2021 at 11:03:46PM +0530, Pratyush Yadav wrote:
> > Convert Cadence DPHY binding to YAML.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  .../devicetree/bindings/phy/cdns,dphy.txt     | 20 --------
> >  .../devicetree/bindings/phy/cdns,dphy.yaml    | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 20 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
> >  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> > deleted file mode 100644
> > index 1095bc4e72d9..000000000000
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -Cadence DPHY
> > -============
> > -
> > -Cadence DPHY block.
> > -
> > -Required properties:
> > -- compatible: should be set to "cdns,dphy".
> > -- reg: physical base address and length of the DPHY registers.
> > -- clocks: DPHY reference clocks.
> > -- clock-names: must contain "psm" and "pll_ref".
> > -- #phy-cells: must be set to 0.
> > -
> > -Example:
> > -	dphy0: dphy@fd0e0000{
> > -		compatible = "cdns,dphy";
> > -		reg = <0x0 0xfd0e0000 0x0 0x1000>;
> > -		clocks = <&psm_clk>, <&pll_ref_clk>;
> > -		clock-names = "psm", "pll_ref";
> > -		#phy-cells = <0>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > new file mode 100644
> > index 000000000000..d1bbf96a8250
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/cdns,dphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence DPHY Device Tree Bindings
> > +
> > +maintainers:
> > +  - Pratyush Yadav <p.yadav@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: cdns,dphy
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Physical base address and length of the DPHY registers.
> 
> You can drop the description.

Ok.

> 
> > +
> > +  clocks:
> > +    maxItems: 2
> > +    description: DPHY reference clocks.
> 
> It's best to describe individual items, which will then allow dropping
> the maxItems property:
> 
>   clocks:
>     items:
>       - description: Description of the psm clock
>       - description: Description of the pll_ref clock

Ok. Though I'd mention that I am not 100% sure what the pll_ref clock is 
supposed to be. The original binding doesn't have a description either.

> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: psm
> > +      - const: pll_ref
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    dphy0: dphy@fd0e0000{
> 
> This is copied verbatim from the existing description, but while at it,
> I'd rename the node from dphy@... to phy@..., as DT node are supposed to
> be named according to the class of devices, not the specific device
> type.

Ok.

> 
> With these small issues addressed,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks.

> 
> > +        compatible = "cdns,dphy";
> > +        reg = <0xfd0e0000 0x1000>;
> > +        clocks = <&psm_clk>, <&pll_ref_clk>;
> > +        clock-names = "psm", "pll_ref";
> > +        #phy-cells = <0>;
> > +    };
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
