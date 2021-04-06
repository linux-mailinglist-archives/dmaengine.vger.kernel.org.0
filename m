Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9409B355AD2
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbhDFRyY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 13:54:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52216 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbhDFRx6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 13:53:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136HrTfw115653;
        Tue, 6 Apr 2021 12:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617731609;
        bh=LA7VQv3A9JWbmuuofLpTAukY9+6Pt/CKyjnIiSE3bVA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tLW1V9b3hVe0zIyrKxs2pD062AVxvBpx3WKB6ayqg8csg/x0iHDtHUTcypV1JgZLb
         eUkKGM4owNep1gcYM/raftDG/5DplPLkrMRBtdfcE7Nbd+aQtmVFS2ETbkPRyH3JmU
         XClo4NYwtNSLHv/xlubFiTdjwCySyEalOgJq9Ol8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136HrTAe107173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 12:53:29 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 12:53:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 12:53:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136HrSna103034;
        Tue, 6 Apr 2021 12:53:29 -0500
Date:   Tue, 6 Apr 2021 23:23:27 +0530
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
Subject: Re: [PATCH 09/16] media: cadence: csi2rx: Turn subdev power on
 before starting stream
Message-ID: <20210406175325.rgmjgk4suggeldaz@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-10-p.yadav@ti.com>
 <YGb4J5q9N0ExOgn9@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGb4J5q9N0ExOgn9@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:55PM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Tue, Mar 30, 2021 at 11:03:41PM +0530, Pratyush Yadav wrote:
> > The subdevice power needs to be turned on before the stream is started.
> > Otherwise it might not be in the proper state to stream the data. Turn
> > it off when stopping the stream.
> 
> The .s_power() operation is deprecated. Subdev drivers should control
> power internally in their .s_stream() operation, and they should use
> runtime PM to do so (this will allow usage of runtime PM autosuspend, to
> avoid expensive power off/on cycles when stopping and restarting video
> capture).

The s_power documentation in v4l2-subdev.h does not mention that it is 
depreciated. A documentation update is in order. I will send a separate 
patch to do it.

I tested this with OV5640. Not doing an s_power() operation before 
s_stream() does not work. The application freezes forever waiting for 
the first frame. So the OV5640 driver needs to be updated to use runtime 
PM to do this, right?

> 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/media/platform/cadence/cdns-csi2rx.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index 7d1ac51e0698..3385e1bc213e 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -256,6 +256,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >  
> >  	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
> >  
> > +	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, true);
> > +	if (ret && ret != -ENOIOCTLCMD)
> > +		goto err_disable_pclk;
> > +
> >  	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
> >  	if (ret)
> >  		goto err_disable_pclk;
> > @@ -358,6 +362,10 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
> >  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
> >  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
> >  
> > +	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, false);
> > +	if (ret && ret != -ENOIOCTLCMD)
> > +		dev_warn(csi2rx->dev, "Couldn't power off subdev\n");
> > +
> >  	if (csi2rx->dphy) {
> >  		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
