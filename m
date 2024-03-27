Return-Path: <dmaengine+bounces-1578-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD288ED1F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B99629F514
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D614F9C5;
	Wed, 27 Mar 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rbewKmZm"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF18153583;
	Wed, 27 Mar 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561579; cv=fail; b=Egk+xKB6JfzirHEo/p3kRjw1RTQvWW4jAMweDviWBBu/KSMOmCvo5oJmqtsVIoXylWlXC5pCv8l7JOP3SI89LGEM8ycl9rw/bMgEaltp5RjiMg7i9dMoVpxcQO9yRNapvVMpgcnZa1wGUo/Ln9+gSdSavpddsDY1xRh/ldRgBcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561579; c=relaxed/simple;
	bh=pV6C+AdT4qoB5Uy1rd0vFGzkVQxVVuDphINIV1oexIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ncsVhpD9EA9AseSvtdFprcXneLwuBoiMYmqsOAt5nbgQnJgViT0mxOkMp6XOwU/WJdobEz3BhkcNtgEEU2/1qkiGpzRAyO/uhrG9RQBjkpXheXzzVm1EevBotfldlbOziso/oak13/MVRrPqvxWzoArWGq9+CLwmuouqMMLhcCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rbewKmZm; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RivqHknfJ72PcNj+1kno9qKMfQQ2tuxWoldBZE9cOJkBphlTh4FuZzbxs5n5Uxns7huuZW2ObiFfJv/BBFOUPqkMfGa8gBWAv3hOt7zH9WFhDIlRxy5+NU+CcxHqnNo21SwaZXAirCluhoJM8P/qU13OO7B88SEhWuC/LZSM9ji+Hb/wJrzJDWLazvhVT0WSU8U+n/ZTXjT1rrK680EIeTc6n0Ze7MKR1LYw+eh9KI/fsGTxOr1G0vM2EFJVFgx3LKtnH+X6Yyd2YfPoKHo85Ezg9n80pwHFzlSkYEB9L7PGmTE7Yayod9H323WZiBIYjIHmQmXczokEwHnuWyLL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5ujsvk4mUOKOvBaB0dKfSbq07Zs2gK1KfKj4YewCOY=;
 b=cNuk3ppJpOGbeOYGomX91m52JtDNf3fIgxr6mARUoNOFs+Z1Kv7Ud2Nzg2BAeW+4+RItQALs0uA6WizWMcmnW6OXVhPDIeiVh4Kw0Tda8nWaM5CP8fjHxF9/NZnBUGy/3Yzh4O+aNju+ouboZjan8fBdaosXBahjFknimS33CQcWKNJf/C9Z4nqat04QWYZyiEAwkzZO6cIcv+ci12RY1ydGNV+SyvWKLXwx/7VIW2Yd2oaLsZeJ76nctNfgBDlI8R5RZao2BAF0GKMdg/N8dLgr3zNisSJA2gv3iq9k06LtAcdi7PRvjI5c0fSHCr/m0p2IoEJQYogoupyOHvJABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5ujsvk4mUOKOvBaB0dKfSbq07Zs2gK1KfKj4YewCOY=;
 b=rbewKmZmFJtfFKbTx2eHnRYru097MathP0lcC6AQLqCzeLObSZtIuEE3xGMzJIHYXHC4Za4V15KIZ+oWiVlhsyuUMdNUlH+NxKjCdx3lAT+2G1CczFT5oVeSh8sF8eVPq5n75I7iS5il7FUGaSHGLcSlmoDpIldknf9LgIN1qi4=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 17:46:15 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::86) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 17:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 17:46:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 12:46:13 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 27 Mar 2024 12:46:12 -0500
Message-ID: <b59dd8cd-fd75-5342-d411-817f33e0ff48@amd.com>
Date: Wed, 27 Mar 2024 10:46:04 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
Content-Language: en-US
To: Louis Chauvet <louis.chauvet@bootlin.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul
	<vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, Jan Kuliga
	<jankul@alatek.krakow.pl>, Miquel Raynal <miquel.raynal@bootlin.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
 <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b29a999-b1d1-43c0-cc42-08dc4e85cc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KcYXyXUKSzBIzNhX2iD0m87kulplNnigX5BNU1nOmSFscd35nI20XqsE1V8rdK+3Zw01ruLQez5Wcn7ykwCtZRfbEiGjuqTSgsgAGEjFkJbz9HemTeYeY3L0Wt6Ui/H6QK49Mi4BVqhqNxCsVzytTsUK/m3MpDStDRBvaeIwnRV3d8V+XicscCq+FwqOFPv0RteL398WAs2irrc+if8hU8K/M2H1tfnFgDE8fgdTJh+376XqzGxRu28vgQ1Bqe14S+4UgpeZ4T503bbOoMu8KlrL9lpZRPLF6mxDY+HXLOnc8w85lMfqgKdVCXHThEYZTBGz4v8yDPAP8xl1SEfvSRXxi2M/yc2VFXgMWAHAmBKOdqgJd97wTqsIUBT7soghwKsxHHUInArQLLOHhQkbVYyZvgU0ntiQMgIIGlsVrh6b3qCZIDPaaEUKhQbYOxEymN07b7uQLbQFQ1fevD6rtzuYkXtPXTjvh83I3dBPE8S2Yor2xXsznsHlUk3b3vYq0P0uiYX3IHFhbQ8QV6xZs1x+/e3by3zaFE3CYJufaXHfVEDr1um7FGPnugNZ7gKEFKTS5cvfGWovbW+hzCC8ZAsxZMxQgUKwVt5oQhnW5E9KlMvN4IKM4o3sIswRTyEw9yqQSppvoX/5XTa4kdkaL51KttrI3NHESTKqgMR7y3YIcyTo+lrP6OATcK+UO5tU16hgY4/L3UI3Mtul1SbHCpJfwvmnvtMUQAmMwPYdpVw8TPNGMuWBiRuxviVzSC0E
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 17:46:13.9575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b29a999-b1d1-43c0-cc42-08dc4e85cc08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129


On 3/27/24 02:58, Louis Chauvet wrote:
> The current xdma_synchronize method does not properly wait for the last
> transfer to be done. Due to limitations of the XMDA engine, it is not
> possible to stop a transfer in the middle of a descriptor. Said
> otherwise, if a stop is requested at the end of descriptor "N" and the OS
> is fast enough, the DMA controller will effectively stop immediately.
> However, if the OS is slightly too slow to request the stop and the DMA
> engine starts descriptor "N+1", the N+1 transfer will be performed until
> its end. This means that after a terminate_all, the last descriptor must
> remain valid and the synchronization must wait for this last descriptor to
> be terminated.
>
> Fixes: 855c2e1d1842 ("dmaengine: xilinx: xdma: Rework xdma_terminate_all()")
> Fixes: f5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
> Cc: stable@vger.kernel.org
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/dma/xilinx/xdma-regs.h |  3 +++
>   drivers/dma/xilinx/xdma.c      | 26 ++++++++++++++++++--------
>   2 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 98f5f6fb9ff9..6ad08878e938 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -117,6 +117,9 @@ struct xdma_hw_desc {
>   			 CHAN_CTRL_IE_WRITE_ERROR |			\
>   			 CHAN_CTRL_IE_DESC_ERROR)
>   
> +/* bits of the channel status register */
> +#define XDMA_CHAN_STATUS_BUSY			BIT(0)
> +
>   #define XDMA_CHAN_STATUS_MASK CHAN_CTRL_START
>   
>   #define XDMA_CHAN_ERROR_MASK (CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |	\
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index b9788aa8f6b7..5a3a3293b21b 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -71,6 +71,8 @@ struct xdma_chan {
>   	enum dma_transfer_direction	dir;
>   	struct dma_slave_config		cfg;
>   	u32				irq;
> +	struct completion		last_interrupt;
> +	bool				stop_requested;
>   };
>   
>   /**
> @@ -376,6 +378,8 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>   		return ret;
>   
>   	xchan->busy = true;
> +	xchan->stop_requested = false;
> +	reinit_completion(&xchan->last_interrupt);

If stop_requested is true, it should not start another transfer. So I 
would suggest to add

      if (xchan->stop_requested)

                 return -ENODEV;

at the beginning of xdma_xfer_start().

xdma_xfer_start() is protected by chan lock.

>   
>   	return 0;
>   }
> @@ -387,7 +391,6 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>   static int xdma_xfer_stop(struct xdma_chan *xchan)
>   {
>   	int ret;
> -	u32 val;
>   	struct xdma_device *xdev = xchan->xdev_hdl;
>   
>   	/* clear run stop bit to prevent any further auto-triggering */
> @@ -395,13 +398,7 @@ static int xdma_xfer_stop(struct xdma_chan *xchan)
>   			   CHAN_CTRL_RUN_STOP);
>   	if (ret)
>   		return ret;
Above two lines can be removed with your change.
> -
> -	/* Clear the channel status register */
> -	ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return ret;
>   }
>   
>   /**
> @@ -474,6 +471,8 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
>   		xchan->xdev_hdl = xdev;
>   		xchan->base = base + i * XDMA_CHAN_STRIDE;
>   		xchan->dir = dir;
> +		xchan->stop_requested = false;
> +		init_completion(&xchan->last_interrupt);
>   
>   		ret = xdma_channel_init(xchan);
>   		if (ret)
> @@ -521,6 +520,7 @@ static int xdma_terminate_all(struct dma_chan *chan)
>   	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>   
>   	xdma_chan->busy = false;
> +	xdma_chan->stop_requested = true;
>   	vd = vchan_next_desc(&xdma_chan->vchan);
>   	if (vd) {
>   		list_del(&vd->node);
> @@ -542,6 +542,13 @@ static int xdma_terminate_all(struct dma_chan *chan)
>   static void xdma_synchronize(struct dma_chan *chan)
>   {
>   	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct xdma_device *xdev = xdma_chan->xdev_hdl;
> +	int st = 0;
> +
> +	/* If the engine continues running, wait for the last interrupt */
> +	regmap_read(xdev->rmap, xdma_chan->base + XDMA_CHAN_STATUS, &st);
> +	if (st & XDMA_CHAN_STATUS_BUSY)
> +		wait_for_completion_timeout(&xdma_chan->last_interrupt, msecs_to_jiffies(1000));
I suggest to add error message for timeout case.
>   
>   	vchan_synchronize(&xdma_chan->vchan);
>   }
> @@ -876,6 +883,9 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	u32 st;
>   	bool repeat_tx;
>   
> +	if (xchan->stop_requested)
> +		complete(&xchan->last_interrupt);
> +

This should be moved to the end of function to make sure processing 
previous transfer is completed.

out:

     if (xchan->stop_requested) {

             xchan->busy = false;

             complete(&xchan->last_interrupt);

     }

     spin_unlock(&xchan->vchan.lock);

     return IRQ_HANDLED;


Thanks,

Lizhi

>   	spin_lock(&xchan->vchan.lock);
>   
>   	/* get submitted request */
>

