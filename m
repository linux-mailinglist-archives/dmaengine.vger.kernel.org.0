Return-Path: <dmaengine+bounces-5764-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6BB0297A
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 07:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EE54A7B89
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 05:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC351EFF8D;
	Sat, 12 Jul 2025 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K2pP79Kn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D123BE;
	Sat, 12 Jul 2025 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752298601; cv=none; b=bq03O3iuWGFdI1XRd9pTFGVMKDHAQ2cgOnQ2a1crmA5Zu2VR+xe7ktBTcJtJAaqtrOLAtRZ7KFEXfLPVUOFrOdLrgKlG/H3Ztb/TOAVS3EU2Xrb2oC0gp0aOUaCbTheuqF7ttR0CzRrdENFjSEiFyigOxEdP9JPlsIZ3Y6hz40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752298601; c=relaxed/simple;
	bh=g91zeobSlfEhybMtWBiNg7pwEzyEkIKObP3K0tWGE74=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXvTvtpXEKOiaWhdOAFJhTLRgNx3QdGA/CATK+mFEQQBk+9ZzNAX17hXnOdORKtlEG5wvvuLv6+W8sEfxvzyBmS4UHqBBSRmK9o1ztxuaZAQ4UEGojSNNIhmwhkN+mypfxQcn439UNVcMfLf1+HzpgJWlr2+FU7rZH/zO+GzWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K2pP79Kn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C5X7Vb003295;
	Fri, 11 Jul 2025 22:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LtV+jlRpZYjgCbtV3ulUUj1Z2
	BVtybyCOqqE+XDUxf4=; b=K2pP79KnUcv4g5YmReNPYd+WCYa/qgfIypUzMDh1O
	lfHQ54LAEpcqYDko6CF45HFgQQEOlV5Glxd/1ifAdExZHzeYZe2L/INJinF/GTAO
	IkMAeaT/5qSPvm251uonz5/rED9odEaynl9yZdNilqvG7VM1A4QuNyL0iYCTgA7c
	RUhBqb3CZFAlR7thpPYwijkChHQcaJ7YODPc4I0nl9p+Rok7ZZjkPnk8YWrqQ6pt
	o0a8Cv1w7dutlkxJLREn3p8nDl4s8zW3izVnZO5oF6MQehgKKzHoe+i9ULG9lBni
	agtwoJhVH1N/cM9LJ/fapea3Si0aH42jgrmhQy07ZO3pQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ug75r396-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 22:36:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 22:36:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 22:36:18 -0700
Received: from 94363b911d3e (unknown [10.193.79.61])
	by maili.marvell.com (Postfix) with SMTP id 90CD03F708D;
	Fri, 11 Jul 2025 22:36:16 -0700 (PDT)
Date: Sat, 12 Jul 2025 05:36:12 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Simek, Michal"
	<michal.simek@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>,
        "Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start
 transfer path for AXI DMA
Message-ID: <aHH0TPFQmhGYZm21@94363b911d3e>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-3-suraj.gupta2@amd.com>
 <aHE7II-tL6zAzNYB@ff87d1e86a04>
 <BL3PR12MB657159BD5F7C2161D6B9A5AAC94BA@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL3PR12MB657159BD5F7C2161D6B9A5AAC94BA@BL3PR12MB6571.namprd12.prod.outlook.com>
X-Proofpoint-GUID: y48TYXdzl2S-WoqMLgHdJMNuGcrULm4G
X-Proofpoint-ORIG-GUID: y48TYXdzl2S-WoqMLgHdJMNuGcrULm4G
X-Authority-Analysis: v=2.4 cv=Mdxsu4/f c=1 sm=1 tr=0 ts=6871f455 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=BPLeHpbfgctcYvNycb8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDA0MiBTYWx0ZWRfXwcIFlUaWBe8j QmmTGCb1r8MnLvxEyOa9+G6VPIwgGOMzhBT/faODkkPuk4Eijsx6iRfPKTW4d5ViKdWTSMo69PN Wa2bTJDXtNMbUlQtGbQZnqnC2c4aMqob8wBz2tM9OS9Gqw9/UHCsE8LiLVc3yQ2wmxYNZEmOsP5
 lz6K6X9KT2EluWTKWoHWvy+8I8jWTJiNAwGyJFCYUUIz1Lc19Rdj126obzP+hKy38iKDlezM1P/ WY0vY46ty2eso/XRW0SD/64PTqZDYnBslVhbGwuWCSVKQDwaV21ZGjmUu+TydIQsI5Mkp9YFFFp t9qAn7zQ2GbwFxL6oroF9scSuuBK2/LHtOZXxcW58FdiTrgTdUkhHqGfFBG8/o3yRT+BrRx1Oqr
 puCXInbGYwlqyp2D1c6UPST40c5ctZLEHcYDwrDjRFDVWJhT5/c5IKfRAeIcHIPs+Yn1c1vO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_01,2025-07-09_01,2025-03-28_01

On 2025-07-11 at 20:13:40, Gupta, Suraj (Suraj.Gupta2@amd.com) wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> > Sent: Friday, July 11, 2025 9:56 PM
> > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; kuba@kernel.org;
> > pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; vkoul@kernel.org;
> > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; dmaengine@vger.kernel.org; Katakam, Harini
> > <harini.katakam@amd.com>
> > Subject: Re: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start transfer
> > path for AXI DMA
> >
> > Caution: This message originated from an External Source. Use proper caution when
> > opening attachments, clicking links, or responding.
> >
> >
> > On 2025-07-10 at 10:12:27, Suraj Gupta (suraj.gupta2@amd.com) wrote:
> > > AXI DMA driver incorrectly assumes complete transfer completion upon
> > > IRQ reception, particularly problematic when IRQ coalescing is active.
> > > Updating the tail pointer dynamically fixes it.
> > > Remove existing idle state validation in the beginning of
> > > xilinx_dma_start_transfer() as it blocks valid transfer initiation on
> > > busy channels with queued descriptors.
> > > Additionally, refactor xilinx_dma_start_transfer() to consolidate
> > > coalesce and delay configurations while conditionally starting
> > > channels only when idle.
> > >
> > > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > > Fixes: Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx
> > > AXI Direct Memory Access Engine")
> >
> > You series looks like net-next material and this one is fixing some existing bug. Send
> > this one patch seperately to net.
> > Also include net or net-next in subject.
> >
> > Thanks,
> > Sundeep
> 
> This series is more of DMAengine as we're enabling coalesce parameters configuration via DMAengine framework. AXI ethernet is just an example client using AXI DMA.
> 
> I sent V1 as separate patches for net-next and dmaengine mailing list and got suggestion[1] to send them as single series for better review, so I didn't used net specific subject prefix.
> [1]: https://lore.kernel.org/all/d5be7218-8ec1-4208-ac24-94d4831bfdb6@linux.dev/

My bad I forgot AXI ethernet and DMA are different IPs.

Thanks,
Sundeep
> 
> Regards,
> Suraj
> 
> > > ---
> > >  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > > b/drivers/dma/xilinx/xilinx_dma.c index a34d8f0ceed8..187749b7b8a6
> > > 100644
> > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > @@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct
> > xilinx_dma_chan *chan)
> > >       if (list_empty(&chan->pending_list))
> > >               return;
> > >
> > > -     if (!chan->idle)
> > > -             return;
> > > -
> > >       head_desc = list_first_entry(&chan->pending_list,
> > >                                    struct xilinx_dma_tx_descriptor, node);
> > >       tail_desc = list_last_entry(&chan->pending_list,
> > > @@ -1558,23 +1555,24 @@ static void xilinx_dma_start_transfer(struct
> > xilinx_dma_chan *chan)
> > >       tail_segment = list_last_entry(&tail_desc->segments,
> > >                                      struct xilinx_axidma_tx_segment,
> > > node);
> > >
> > > +     if (chan->has_sg && list_empty(&chan->active_list))
> > > +             xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> > > +                          head_desc->async_tx.phys);
> > > +
> > >       reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
> > >
> > >       if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
> > >               reg &= ~XILINX_DMA_CR_COALESCE_MAX;
> > >               reg |= chan->desc_pendingcount <<
> > >                                 XILINX_DMA_CR_COALESCE_SHIFT;
> > > -             dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> > >       }
> > >
> > > -     if (chan->has_sg)
> > > -             xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> > > -                          head_desc->async_tx.phys);
> > >       reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> > >       reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
> > >       dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> > >
> > > -     xilinx_dma_start(chan);
> > > +     if (chan->idle)
> > > +             xilinx_dma_start(chan);
> > >
> > >       if (chan->err)
> > >               return;
> > > @@ -1914,8 +1912,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void
> > *data)
> > >                     XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
> > >               spin_lock(&chan->lock);
> > >               xilinx_dma_complete_descriptor(chan);
> > > -             chan->idle = true;
> > > -             chan->start_transfer(chan);
> > > +             if (list_empty(&chan->active_list)) {
> > > +                     chan->idle = true;
> > > +                     chan->start_transfer(chan);
> > > +             }
> > >               spin_unlock(&chan->lock);
> > >       }
> > >
> > > --
> > > 2.25.1
> > >

