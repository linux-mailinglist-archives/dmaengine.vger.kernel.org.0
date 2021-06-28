Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0F3B5CCF
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jun 2021 12:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhF1LAy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Jun 2021 07:00:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhF1LAy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Jun 2021 07:00:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15SAwQpX103933;
        Mon, 28 Jun 2021 05:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624877906;
        bh=79lPMj2fBXO2/pJTAfmUC6u1Xh8Gzm5MRaeG51N6SnM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aRE02PpZa5LT23OGnZvWDmpuj1xZ78+Y3tNIgurUDrUdR6onAkoirFbnNtzF8Y24c
         kEzySy9OqjmEP+37QtjILUiRhTju19rUARa3F1kBadKu4MgLgXYFQpdLQFzTeVEHmi
         XoQdvtY2a5mLK64/ClLJnYU+7YEssu9vHFxsjZno=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15SAwQ9U049788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jun 2021 05:58:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 28
 Jun 2021 05:58:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 28 Jun 2021 05:58:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15SAwPTW083972;
        Mon, 28 Jun 2021 05:58:25 -0500
Date:   Mon, 28 Jun 2021 16:28:24 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Message-ID: <20210628105822.ighgnu6ebs5npbv3@ti.com>
References: <20210624182449.31164-1-p.yadav@ti.com>
 <6b8662e2-2dd5-b1c4-6bc1-24a69776ffac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b8662e2-2dd5-b1c4-6bc1-24a69776ffac@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/06/21 01:38PM, Péter Ujfalusi wrote:
> 
> 
> On 24/06/2021 21:24, Pratyush Yadav wrote:
> > The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory.
> 
> If we want to be correct:
> The CSI2RX subsystem in j721e is serviced by UDMA via PSI-L to transfer
> frames to memory.
> 
> If you update the commit message you can also add my:

Ah, I thought you were picking the patch up. Does Vinod pick them up
instead?

Vinod,

Can you update the commit message when applying or do you want me to 
send another re-roll?

> 
> Acked-by: Peter Ujfalusi <peter.ujflausi@gmail.com>
> 
> > It can
> > have up to 32 threads per instance. J721E has two instances of the
> > subsystem, so there are 64 threads total. Add them to the endpoint map.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > This patch has been split off from [0] to facilitate easier merging. I
> > have still kept it as v3 to maintain continuity with the previous patches.
> > 
> > [0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both
> > 
> > Changes in v3:
> > - Update commit message to mention that all 64 threads are being added.
> > 
> > Changes in v2:
> > - Add all 64 threads, instead of having only the one thread being
> >   currently used by the driver.
> > 
> >  drivers/dma/ti/k3-psil-j721e.c | 73 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> > index 7580870ed746..34e3fc565a37 100644
> > --- a/drivers/dma/ti/k3-psil-j721e.c
> > +++ b/drivers/dma/ti/k3-psil-j721e.c
> > @@ -58,6 +58,14 @@
> >  		},					\
> >  	}
> >  
> > +#define PSIL_CSI2RX(x)					\
> > +	{						\
> > +		.thread_id = x,				\
> > +		.ep_config = {				\
> > +			.ep_type = PSIL_EP_NATIVE,	\
> > +		},					\
> > +	}
> > +
> >  /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
> >  static struct psil_ep j721e_src_ep_map[] = {
> >  	/* SA2UL */
> > @@ -138,6 +146,71 @@ static struct psil_ep j721e_src_ep_map[] = {
> >  	PSIL_PDMA_XY_PKT(0x4707),
> >  	PSIL_PDMA_XY_PKT(0x4708),
> >  	PSIL_PDMA_XY_PKT(0x4709),
> > +	/* CSI2RX */
> > +	PSIL_CSI2RX(0x4940),
> > +	PSIL_CSI2RX(0x4941),
> > +	PSIL_CSI2RX(0x4942),
> > +	PSIL_CSI2RX(0x4943),
> > +	PSIL_CSI2RX(0x4944),
> > +	PSIL_CSI2RX(0x4945),
> > +	PSIL_CSI2RX(0x4946),
> > +	PSIL_CSI2RX(0x4947),
> > +	PSIL_CSI2RX(0x4948),
> > +	PSIL_CSI2RX(0x4949),
> > +	PSIL_CSI2RX(0x494a),
> > +	PSIL_CSI2RX(0x494b),
> > +	PSIL_CSI2RX(0x494c),
> > +	PSIL_CSI2RX(0x494d),
> > +	PSIL_CSI2RX(0x494e),
> > +	PSIL_CSI2RX(0x494f),
> > +	PSIL_CSI2RX(0x4950),
> > +	PSIL_CSI2RX(0x4951),
> > +	PSIL_CSI2RX(0x4952),
> > +	PSIL_CSI2RX(0x4953),
> > +	PSIL_CSI2RX(0x4954),
> > +	PSIL_CSI2RX(0x4955),
> > +	PSIL_CSI2RX(0x4956),
> > +	PSIL_CSI2RX(0x4957),
> > +	PSIL_CSI2RX(0x4958),
> > +	PSIL_CSI2RX(0x4959),
> > +	PSIL_CSI2RX(0x495a),
> > +	PSIL_CSI2RX(0x495b),
> > +	PSIL_CSI2RX(0x495c),
> > +	PSIL_CSI2RX(0x495d),
> > +	PSIL_CSI2RX(0x495e),
> > +	PSIL_CSI2RX(0x495f),
> > +	PSIL_CSI2RX(0x4960),
> > +	PSIL_CSI2RX(0x4961),
> > +	PSIL_CSI2RX(0x4962),
> > +	PSIL_CSI2RX(0x4963),
> > +	PSIL_CSI2RX(0x4964),
> > +	PSIL_CSI2RX(0x4965),
> > +	PSIL_CSI2RX(0x4966),
> > +	PSIL_CSI2RX(0x4967),
> > +	PSIL_CSI2RX(0x4968),
> > +	PSIL_CSI2RX(0x4969),
> > +	PSIL_CSI2RX(0x496a),
> > +	PSIL_CSI2RX(0x496b),
> > +	PSIL_CSI2RX(0x496c),
> > +	PSIL_CSI2RX(0x496d),
> > +	PSIL_CSI2RX(0x496e),
> > +	PSIL_CSI2RX(0x496f),
> > +	PSIL_CSI2RX(0x4970),
> > +	PSIL_CSI2RX(0x4971),
> > +	PSIL_CSI2RX(0x4972),
> > +	PSIL_CSI2RX(0x4973),
> > +	PSIL_CSI2RX(0x4974),
> > +	PSIL_CSI2RX(0x4975),
> > +	PSIL_CSI2RX(0x4976),
> > +	PSIL_CSI2RX(0x4977),
> > +	PSIL_CSI2RX(0x4978),
> > +	PSIL_CSI2RX(0x4979),
> > +	PSIL_CSI2RX(0x497a),
> > +	PSIL_CSI2RX(0x497b),
> > +	PSIL_CSI2RX(0x497c),
> > +	PSIL_CSI2RX(0x497d),
> > +	PSIL_CSI2RX(0x497e),
> > +	PSIL_CSI2RX(0x497f),
> >  	/* CPSW9 */
> >  	PSIL_ETHERNET(0x4a00),
> >  	/* CPSW0 */
> > 
> 
> -- 
> Péter

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
