Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8990E39A170
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFCMvS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 08:51:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFCMvS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 08:51:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153CnOt7104242;
        Thu, 3 Jun 2021 07:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622724564;
        bh=3tUasl4CjwBSl1XuXyKNpzOo0NZEAhF7Cos3of0Pn/0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gpY/wdWqzf+TJzbRHQ8xQPS/e2T+SqgRBJOC5zIu5t63drg7HktQQW+OTZQCz4J18
         KG9h0PXZP1FNEBVL2DkqrJISHvz9aaMQlWNBf0SehNzL1fbk1oEOJLZftHeOkDbDTE
         8McbzYFrjZHko+buU50aMYR8zjqAmSp1A45iON8Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153CnOlu074023
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 07:49:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 07:49:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 07:49:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153CnNnH075333;
        Thu, 3 Jun 2021 07:49:23 -0500
Date:   Thu, 3 Jun 2021 18:19:22 +0530
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
Subject: Re: [PATCH v2 13/18] media: ti: Add CSI2RX support for J721E
Message-ID: <20210603124920.5o34klhlhjg5phlj@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-14-p.yadav@ti.com>
 <5e00444a-683f-b4fa-9156-4450ca4edaf6@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e00444a-683f-b4fa-9156-4450ca4edaf6@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/05/21 04:29PM, Tomi Valkeinen wrote:
> Hi Pratyush,
> 
> On 26/05/2021 18:23, Pratyush Yadav wrote:
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
> 
> I noticed that my test app didn't work at all with this, and I also wasn't
> able to use v4l2-ctl to set the format.

I have not used v4l2-ctl, but I can see yavta works fine. What command 
did you use for setting format via v4l2-ctl?

> 
> At least for my test app the problem was that this driver doesn't initialize
> the format at all. My app first calls VIDIOC_G_FMT with v4l2_format.type ==
> V4L2_BUF_TYPE_VIDEO_CAPTURE, then after the call modifies the fields it
> wants to change and calls VIDIOC_S_FMT. This failed, as G_FMT returned
> uninitialized fmt, i.e. type was 0, which my app didn't set again.
> 
> I believe the driver should have an initial format, something that it will
> accept if an app calls G_FMT and then S_FMT.

Right. This is a bug. The question is what should the initial format be? 
It is more or less arbitrary since there is no configuration made yet 
and we don't know what the camera can or will send. So for example, what 
if I use UYVY 640x480? The camera might not support it at all. Is it 
still OK to have it as the default?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
