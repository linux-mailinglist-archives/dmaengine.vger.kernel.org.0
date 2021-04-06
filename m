Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D035573F
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbhDFPFu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 11:05:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41390 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbhDFPFu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 11:05:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136F5HVr049644;
        Tue, 6 Apr 2021 10:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617721517;
        bh=XBmEDieA+skNRILQW4BZSH6UOH2I9m+4MVXEObgkjII=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jE9/f/uhlbh+sMmXd4Bph/+0VuPORLT0b4j8h+VrTBHmT1MEGzGG2eXXnprL/Qr3R
         YY2SEhc5a3LsvvvPB4kcG6WSyad6iKBmjjywBT597qlHdq5DrZ2gaB+npYktQ5guy3
         0xfUOB5z/ulYyRT12LnsgVVDaI2uo9gATzRrOGAQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136F5HQ8075901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 10:05:17 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 10:05:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 10:05:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136F5Gqn089797;
        Tue, 6 Apr 2021 10:05:16 -0500
Date:   Tue, 6 Apr 2021 20:35:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        <dmaengine@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 13/16] media: ti-vpe: csi2rx: Add CSI2RX support
Message-ID: <20210406150513.zj4g6zrtghgunvor@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-14-p.yadav@ti.com>
 <91bbf2a9-9d27-7f9b-1c17-ad6544a828f1@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91bbf2a9-9d27-7f9b-1c17-ad6544a828f1@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/03/21 09:06AM, Tomi Valkeinen wrote:
> Hi,
> 
> On 30/03/2021 20:33, Pratyush Yadav wrote:
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus.
> > 
> > The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> > the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> > called the SHIM layer. It takes in data from stream 0, repacks it, and
> > sends it to memory over PSI-L DMA.
> > 
> > This driver acts as the "front end" to V4L2 client applications. It
> > implements the required ioctls and buffer operations, passes the
> > necessary calls on to the bridge, programs the SHIM layer, and performs
> > DMA via the dmaengine API to finally return the data to a buffer
> > supplied by the application.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >   MAINTAINERS                               |   7 +
> >   drivers/media/platform/Kconfig            |  11 +
> >   drivers/media/platform/ti-vpe/Makefile    |   1 +
> >   drivers/media/platform/ti-vpe/ti-csi2rx.c | 964 ++++++++++++++++++++++
> >   4 files changed, 983 insertions(+)
> >   create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c
> 
> Some quick comments:
> 
> "ti-vpe" directory is not correct, this has nothing to do with VPE. That
> said, the directory has already been abused by having CAL driver there,
> perhaps we should rename the directory just to "ti". But if we do that, I
> think we should have subdirs for cal, vpe and this new one.

Right. I thought about doing this but then figured "let's just follow 
what CAL does". Will move them into separate subdirectories.

> 
> "ti-csi2rx" is rather generic name. TI has had CSI-2 RX IPs before (CAL) and
> probably will also have new ones in the future. If there's no clear model
> name for the IP, as I think is the case here, it's probably best to just use
> the SoC model in the name. E.g. the DSS on J7 is "ti,j721e-dss".

Ok.

> 
> This driver implements the legacy video API. I think it would be better (and
> easier to maintain) to only implement the media-controller API, unless you
> specifically need to support the legacy API for existing userspace.

:-(

I'm afraid the documentation has let me down here. There is no clear 
mention about the fact that media controller API replaces the "legacy" 
API. In fact, [0] seems to suggest that the media controller API is 
optional.

  Bridge drivers traditionally expose one or multiple video nodes to 
  userspace, and control subdevices through the v4l2_subdev_ops 
  operations in response to video node operations. This hides the 
  complexity of the underlying hardware from applications. For complex 
  devices, finer-grained control of the device than what the video nodes 
  offer may be required. In those cases, bridge drivers that implement 
  the media controller API may opt for making the subdevice operations 
  directly accessible from userpace.

Anyway, I don't think supporting the legacy API makes much sense since 
this is a new driver. Will convert it to use the MC API. We can always 
add the legacy API support if some application demands it.

[0] https://www.kernel.org/doc/html/latest/driver-api/media/v4l2-subdev.html#v4l2-sub-device-userspace-api

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
