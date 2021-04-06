Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227433559C0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhDFQ4b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 12:56:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46230 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDFQ40 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 12:56:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136Gtw5h047850;
        Tue, 6 Apr 2021 11:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617728158;
        bh=+9XjRgYfCOrNjdj1kkEqP/Q3v02FwLNYKDPldfbcuiI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tjAN7lxASQ7GQgzBSfvPUAJVbed53QtBUL9oOxt1+Px6vCgCJYXJKr17FC9lKR7rS
         oJwnUGUbf3qZ1to0kpE4KZPESWsmElTk4g34/qqHqGNT6PTMWOW6qTbBOTu8lbineW
         KkEhEZ7bcZx3Sq/y1NYfjS6Iepw1ZCwLjlrx9lrU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136Gtwrb021543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 11:55:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 11:55:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 11:55:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136Gtvuo052410;
        Tue, 6 Apr 2021 11:55:57 -0500
Date:   Tue, 6 Apr 2021 22:25:56 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Subject: Re: [PATCH 11/16] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Message-ID: <20210406165554.5mhn4u5enbf2tvaz@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-12-p.yadav@ti.com>
 <78a5983c-04c8-4a4c-04fe-bb1f31e87375@gmail.com>
 <20210406150942.4kyjh2ehsvklupjr@ti.com>
 <54b0846e-d633-2a03-2c64-f1f0a85c2410@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b0846e-d633-2a03-2c64-f1f0a85c2410@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/04/21 06:33PM, Péter Ujfalusi wrote:
> 
> 
> On 4/6/21 6:09 PM, Pratyush Yadav wrote:
> > On 04/04/21 04:24PM, Péter Ujfalusi wrote:
> >> Hi Pratyush,
> >>
> >> On 3/30/21 8:33 PM, Pratyush Yadav wrote:
> >>> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> >>> have up to 32 threads but the current driver only supports using one. So
> >>> add an entry for that one thread.
> >>
> >> If you are absolutely sure that the other threads are not going to be
> >> used, then:
> > 
> > The opposite in fact. I do expect other threads to be used in the 
> > future. But the current driver can only use one so I figured it is 
> > better to add just the thread that is currently needed and then I can 
> > always add the rest later.
> > 
> > Why does this have to be a one-and-done deal? Is there anything wrong 
> > with adding the other threads when the driver can actually use them?
> 
> You can skip CCing DMAengine (and me ;) ). Less subsystems is the better
> when sending patches...

I'm a bit confused here. If you are no longer interested in maintaining 
the TI DMA drivers then that's fine, I can skip CCing you. But the patch 
is still relevant to the dmaengine list so why should I skip CCing it? 
And if I don't CC the dmaengine list then on which list would I get 
comments/reviews for the patch?

> 
> > 
> >> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> >>
> >> but I would consider adding the other threads if there is a chance that
> >> the cs2rx will need to support it in the future.
> >>
> >>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> >>> ---
> >>>  drivers/dma/ti/k3-psil-j721e.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> >>> index 7580870ed746..19ffa31e6dc6 100644
> >>> --- a/drivers/dma/ti/k3-psil-j721e.c
> >>> +++ b/drivers/dma/ti/k3-psil-j721e.c
> >>> @@ -58,6 +58,14 @@
> >>>  		},					\
> >>>  	}
> >>>  
> >>> +#define PSIL_CSI2RX(x)					\
> >>> +	{						\
> >>> +		.thread_id = x,				\
> >>> +		.ep_config = {				\
> >>> +			.ep_type = PSIL_EP_NATIVE,	\
> >>> +		},					\
> >>> +	}
> >>> +
> >>>  /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
> >>>  static struct psil_ep j721e_src_ep_map[] = {
> >>>  	/* SA2UL */
> >>> @@ -138,6 +146,8 @@ static struct psil_ep j721e_src_ep_map[] = {
> >>>  	PSIL_PDMA_XY_PKT(0x4707),
> >>>  	PSIL_PDMA_XY_PKT(0x4708),
> >>>  	PSIL_PDMA_XY_PKT(0x4709),
> >>> +	/* CSI2RX */
> >>> +	PSIL_CSI2RX(0x4940),
> >>>  	/* CPSW9 */
> >>>  	PSIL_ETHERNET(0x4a00),
> >>>  	/* CPSW0 */
> >>>
> >>
> >> -- 
> >> Péter
> > 
> 
> -- 
> Péter

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
