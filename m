Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA3393DB4
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhE1HZu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 03:25:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhE1HZt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 03:25:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S7O5Sk130782;
        Fri, 28 May 2021 02:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622186645;
        bh=nu/t+eRoAY6NtRobRU6f3fX1UwivEdiSbjMIVTJEhRI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=otvU6YfVvMb0VmTfNfLokxvoHGITg5Yqi+Bg+rqneUxQeQU2hHXR1nsy8ADTT+ODj
         UKffTmjq+TT/E03XgDbRKrsSR7kdKMa9jK1D8xYlG2KiTEailf5y6KtRIkpnTc1V3R
         BGUBsVhf6bxHEjX7l5zTRtw1lu6o95vdcNLI32pA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S7O5U8036400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 02:24:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 02:24:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 02:24:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S7O4dV114575;
        Fri, 28 May 2021 02:24:04 -0500
Date:   Fri, 28 May 2021 12:54:03 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 10/18] media: cadence: csi2rx: Populate subdev devnode
Message-ID: <20210528072401.2vdrtjdiepnr72vv@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-11-p.yadav@ti.com>
 <9c38a72c-18e8-1e54-b3b4-85ff5d47857a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c38a72c-18e8-1e54-b3b4-85ff5d47857a@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/05/21 10:16AM, Tomi Valkeinen wrote:
> On 26/05/2021 18:23, Pratyush Yadav wrote:
> > The devnode can be used by media-ctl and other userspace tools to
> > perform configurations on the subdev. Without it, media-ctl returns
> > ENOENT when setting format on the sensor subdev.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> > 
> > (no changes since v1)
> > 
> >   drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index 1df21f462f3c..49bed63d5faa 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -613,6 +613,7 @@ static int csi2rx_probe(struct platform_device *pdev)
> >   	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> >   	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
> >   		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
> > +	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> >   	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
> >   				     csi2rx->pads);
> > 
> 
> I don't understand this one. There's nothing to configure in cdns-csi2rx
> from userspace, as far as I can see, so why is the dev node needed? And why
> would the lack of csi2rx dev node cause sensor subdev config to fail?

Sensor config does not fail. But when I run media-ctl to set the format 
on /dev/media0, I get an error message that comes because the devnode 
for the bridge does not exist. I was not 100% sure about this patch but 
I figured if media-ctl expects it then it should be exposed.

I don't mind dropping this patch. Just want to make sure what the right 
thing to do here is. Should every element of the pipeline have a devnode 
or not?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
