Return-Path: <dmaengine+bounces-5761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0403B021AE
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jul 2025 18:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BFD566AE2
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jul 2025 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138112EF2B7;
	Fri, 11 Jul 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JZUhVmV/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CA2EF677;
	Fri, 11 Jul 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251190; cv=none; b=kFLfy2MmsbCHBATUNL0DPpuot9sc1uRkUfr/oRGaRejcvAbAXpEvHoTs7ip1xMWljn8591uEwMIuvYBNNt1RRY9y9JSvSe1jZ/WNZC5TOwCyMD8O7CyCZ36y4KPGS8kKeM5/zKAtgnoredUJdmhBm3xfNybcFF/s6k0sV+KaFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251190; c=relaxed/simple;
	bh=w9jyJVsLSf6vMw60FONLCt5T/c3YCrZaITMbtU2RnNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX7VHbHcsKfda6RBRxhGohIqoRKWLJ+yjHtTxzKgylbu2aWaMbVHQGgpOLMInxKI1YIOLhZ1QXPWnHUqkaFQZQoPqmLUoZ8mPeGgGoCawB3IInveeSQpJ7Dvh/Aya3dQeD5csRWuYLd2s5n89oE0dOVxvFf0o1P1xZgb9+ZxjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JZUhVmV/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDKZdn015681;
	Fri, 11 Jul 2025 09:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Fd/EMmvBgaYToBsHafzJw2Zvn
	AqIig4ogpEOlH1qL1E=; b=JZUhVmV/7o1mDLab+UP7TZ9GjLbeB78vKQ5CYSZm/
	dvQ3AoJLOww5kVIA+IRzWh+CmA+D74rEPPeu1uG1nOqswL4E9lJLT9fuh7W+EtCZ
	mLZZNbhnzB4RPIXmto1C8paj1bTT2OuWa7tD0dqLLlvIhI6L3xkTuFjUtcw0J4r7
	YGB2La3/vCDN0IkmwQjb44P5oJo89UZoTu07vnye3YqbUjIPTCbignCkdK3x2JUf
	fquNrvFjcdCir6hCPg3gH6j3yX4xgkQUWVlMLsIxzxqSdwVSzU58RSw/mC6/cKNG
	3t/5XORrGkAfGaaR1Kd/PcVddSzREpMSMP/9Cru1bAIsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47u3d2rccp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:26:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 09:26:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 09:26:12 -0700
Received: from ff87d1e86a04 (unknown [10.193.79.61])
	by maili.marvell.com (Postfix) with SMTP id F257F3F7043;
	Fri, 11 Jul 2025 09:26:09 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:26:08 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
        <radhey.shyam.pandey@amd.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <harini.katakam@amd.com>
Subject: Re: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start
 transfer path for AXI DMA
Message-ID: <aHE7II-tL6zAzNYB@ff87d1e86a04>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710101229.804183-3-suraj.gupta2@amd.com>
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=68713b27 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=zd2uoN0lAAAA:8 a=GxtMjvDmutgGo7HIGz4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: M1ENkY8N2dSvyOTTYEHgkbY9i52JgnTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExOSBTYWx0ZWRfX1LfXBd1YRCa+ rq8f2i8PJ1cgCUvQzEhF4zRq2xgIb5NRAE9E9EBQUKbTp0+Xgwj2HrHfPR5g1p6hahyv8l3ahU7 xAhvyMLbJt1voK6YV1fq36LBhxjNJ1UpPRXGZj4blkO+ItC5JmuIG0SXpUxWxp9d8hp2TyobsjN
 eiBO3eAOV/cR+1wmLa2MVZLiurRcCCKI6m/pfCy/g8ds6GI2WtrDF8ZTBAlCKLWSEpmp9gCkl81 VGcWGK6nIfYZsiHCqfxFl2U5lpp9W+1zaA5O7O8pZ1PCMC3Lad/+8WFYtQA6raDU1jRgSCk8IBL dXSUIfWwO0e72yc0Kg0wcqSz/K9n/Dq9ORgc2NSJv30G/gpoxksMgtX7WZAlW7qw9VcrPVqPpDE
 T/3qGg6797Nkmy5NaSFH4gR5cEqQ2FqgSDlOEgtUpOZW4vDlTJBbJ7DgPeQI0ZevC5Viu3cb
X-Proofpoint-ORIG-GUID: M1ENkY8N2dSvyOTTYEHgkbY9i52JgnTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01

On 2025-07-10 at 10:12:27, Suraj Gupta (suraj.gupta2@amd.com) wrote:
> AXI DMA driver incorrectly assumes complete transfer completion upon
> IRQ reception, particularly problematic when IRQ coalescing is active.
> Updating the tail pointer dynamically fixes it.
> Remove existing idle state validation in the beginning of
> xilinx_dma_start_transfer() as it blocks valid transfer initiation on
> busy channels with queued descriptors.
> Additionally, refactor xilinx_dma_start_transfer() to consolidate coalesce
> and delay configurations while conditionally starting channels
> only when idle.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")

You series looks like net-next material and this one is fixing some
existing bug. Send this one patch seperately to net.
Also include net or net-next in subject.

Thanks,
Sundeep
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a34d8f0ceed8..187749b7b8a6 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (list_empty(&chan->pending_list))
>  		return;
>  
> -	if (!chan->idle)
> -		return;
> -
>  	head_desc = list_first_entry(&chan->pending_list,
>  				     struct xilinx_dma_tx_descriptor, node);
>  	tail_desc = list_last_entry(&chan->pending_list,
> @@ -1558,23 +1555,24 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	tail_segment = list_last_entry(&tail_desc->segments,
>  				       struct xilinx_axidma_tx_segment, node);
>  
> +	if (chan->has_sg && list_empty(&chan->active_list))
> +		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> +			     head_desc->async_tx.phys);
> +
>  	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
>  
>  	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
>  		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>  		reg |= chan->desc_pendingcount <<
>  				  XILINX_DMA_CR_COALESCE_SHIFT;
> -		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
>  
> -	if (chan->has_sg)
> -		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> -			     head_desc->async_tx.phys);
>  	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
>  	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
>  	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);
>  
>  	if (chan->err)
>  		return;
> @@ -1914,8 +1912,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>  		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> -		chan->idle = true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle = true;
> +			chan->start_transfer(chan);
> +		}
>  		spin_unlock(&chan->lock);
>  	}
>  
> -- 
> 2.25.1
> 

