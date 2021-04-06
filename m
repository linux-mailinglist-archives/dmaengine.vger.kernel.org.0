Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F81355BAC
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbhDFStA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:49:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46552 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbhDFSs7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:48:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136ImVOO093015;
        Tue, 6 Apr 2021 13:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617734911;
        bh=Q/jz6vulWvnwCL1uFn+Cr3yxMcztB0HWPUk2BbmlXmo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lAxTY7RFfAR0NVtCLSY3XQLd1V0imGpedADxjGR/G91DG3p2fFZyeTLhaPSbtP9P3
         3jITUgQURv3VcGougfG7sBrBYj4rH2nN1r67LXnTy6TzwoLp+bwqXReqnwJ3aJ8NYi
         54jVyqyiUo7quqOhK/uQWKZOQrJB3Ist+YYugTcg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136ImVUW071802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:48:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:48:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:48:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136ImUd1076720;
        Tue, 6 Apr 2021 13:48:31 -0500
Date:   Wed, 7 Apr 2021 00:18:30 +0530
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
Subject: Re: [PATCH 15/16] dt-bindings: phy: cdns,dphy: make clocks optional
Message-ID: <20210406184828.ftxrrnrrvbprrlom@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-16-p.yadav@ti.com>
 <YGbyfg4hs/yLsqw0@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGbyfg4hs/yLsqw0@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:31PM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Tue, Mar 30, 2021 at 11:03:47PM +0530, Pratyush Yadav wrote:
> > The clocks are not used by the DPHY when used in Rx mode so make them
> > optional.
> 
> Isn't there a main functional clock (DPHY_RX_MAIN_CLK in the J721E TRM)
> that is needed in RX mode ?

That clock is different from the clocks being used in this binding. The 
"psm" clock is for the PMA state machine (the internal state machine for 
the DPHY). The divider for this clock should be set such that the 
resultant clock is as close to 1 MHz as possible. This can be done 
either by programming the register value or by setting the correct value 
on the psm_clock_freq pin. On J721E the pin already has the correct 
value so there is no need for setting it via the register.

The other clock is "pll_ref" which is used to set the input clock 
divider. Setting this divider is part of the DPHY TX programming 
sequence but is not part of the RX programming sequence. I'm not sure 
what exactly the divider does but I think it is supposed to divide the 
clock from the input stream to the TX DPHY to make sure the internal 
state machine is running at the correct speed. Anyway, it is not needed 
on the RX side because for that there is another register used (see 
cdns_dphy_rx_get_band_ctrl() in patch 4).

The DPHY_RX_MAIN_CLK does eventually get divided into the PSM clock but 
it is not used directly.

> 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > index d1bbf96a8250..0807ba68284d 100644
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -33,8 +33,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - clocks
> > -  - clock-names
> >    - "#phy-cells"
> >  
> >  additionalProperties: false
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
