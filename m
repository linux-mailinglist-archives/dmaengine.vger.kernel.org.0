Return-Path: <dmaengine+bounces-331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B37FF83A
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B53281678
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DC5674F;
	Thu, 30 Nov 2023 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Siqls4DW"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119510D1
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 09:28:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0KdHf+TcTGkpbPIFRu4sreO8b/wZfkwKZvlokAumMLj3FGuFJWXssFya2HMTozlytbblw7X7q/PnWOjzjScNeNjisxyvMYo1xlUN56jdb2cE4lxkzay16oqC09VohQ5qsg6HcTfeH2W5bmnYPagGXpYL0Z8KdfICrh7e1zhdznhipXRJLfAg6jCxd+pzwO8GvMtzq0ggh1jvTTYI3dYa0loy6Keg6siWIn7SUxxaE0ReUPXWDOZhaU9Z/eu/3Kibvm6YRNfxvbxGtlGc4XuWSfZM1sihEZQnPHZm94mCVGhEWjnmJwOphAEQaTK9kbi5nttjUBSRagCbHN1rz8fwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjq8HQpEEvf3r/ZtBvIF5CLD7t1kH77EUBCb4qgQ/qY=;
 b=RJ2Ub3g8uLw5Q+5BizllNJu59+guVAfvCrzJ7NNUKAOuzPdUWhjF4QOl2wN+GX03IKN9BD5JF6L5qDogqdWasqx3MZABPKMUn3FvCUth/9aDJdk/JT+HTaiRCiuQGJcU92S55pTgXiqs+z33HB83NIgkbmO03enNJbt+KPGz4GzSF+Gthts5N7zoD+iiU7iXAdebG6ncAsX6KiAveG+GB7UJkoMuFBaOR/wKuKBZMkMrMzptEKVXMGrXGsUT1kgKqfFFB27sNBq4nO7DDu2DHFPy/Z8a5WNNHoElG9SKTUdBlIpncNFpdZWMa+nZ4P8i8xm3FGIk9l09V732GqS1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjq8HQpEEvf3r/ZtBvIF5CLD7t1kH77EUBCb4qgQ/qY=;
 b=Siqls4DWqNYhxbQC0kTIIw+8D3B+YxzhJz/L0csLI4VJHfWahLtYzScTvv6V0tagPswvyMXapYUq5tqwq/icbEWnX92wNq8q6ZMKMsAPsslAnm+OaCVeWOqfznmMjArAV+zZ6IvGbTedL/1zZOu7WAn0ILdxpoPaXw0pg8hqU/s=
Received: from SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 17:28:49 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::b1) by SN7PR04CA0060.outlook.office365.com
 (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 17:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 17:28:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 11:28:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 11:28:48 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 11:28:47 -0600
Message-ID: <674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
Date: Thu, 30 Nov 2023 09:28:47 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul
	<vkoul@kernel.org>, Jan Kuliga <jankul@alatek.krakow.pl>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michal Simek
	<monstr@monstr.eu>, <dmaengine@vger.kernel.org>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
 <20231130111315.729430-5-miquel.raynal@bootlin.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231130111315.729430-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: ae544c6e-ca38-4d21-119e-08dbf1c9d0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bOfF6zvd/OoreNEdfvzJrVFGPcwekS5rPJhUfXWwOJQNUxkT7P9dhzQrFcqizQIAt+M4HucyDiY/HN8LW71lHvrj+NH46D/BR+1QJHzs5Up1RoFto7p46TuRl65jr5REqEiNf/n0Y2DDLq05+DqFwxTTuoEEBMPAyFt3PL71maUn7KTvPHCtbBQPUR30ou4TCI6Kj0Bv1DAuK4JmNQzQ3oKyavmQEL8A2DdmntDqfInHy/eCmBArGvkly6igoyhkaBBBE8PrjX8nNG+0B9o/NvUOsUmuuDCiZmNjRuXTPLaW0dvKUNZUaV1XP2murOPNxXdDoxplRBgwO8ydbnraRHo1uXGicb+mhFZR236KHSOvXrBJWkBGd8xyQfFwpJQ0UZb/lVX9+cA/5RaM5ETVKFBz9k8PZdmqrTip7K7K6o+0ibDp0wvhnkP7fRPGsX2JBQM3HTA/FjoP4XfS/PSoGiO8h0dL/HRiAgfy0qGDChli1SgnGGSxDcLkE4bTV7y3q4wmvybkOqerlWWDXdHKEiJx+S6TqoKCxHigG7n9i/JF+b06rbU/BFsJ9Rxdn7e6CLyaLAAexF+JbgO57efFAlhJ1iLJXowANuTxMQTWl8WoRoXGSiBKRGWOAkih6Y+FXl6qOr5bufHrEfiRLpNEuMg3v/uidjNgjIbywd7rQzyyW7kxKbG9AkV2olgCjHru1+EldZEuaF9wSR+5N/ALxjiMxYtqZZXia02mbmXIR7ks0mR4HHm5Pj4qq/AdjFQE9pSdb/Lg/1XSMNLNmGH/YK3WY6UmyAXA4YmWBywBCUo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(31686004)(40480700001)(41300700001)(36860700001)(86362001)(31696002)(478600001)(5660300002)(40460700003)(2906002)(356005)(83380400001)(44832011)(966005)(4326008)(16576012)(70206006)(54906003)(110136005)(70586007)(426003)(36756003)(26005)(316002)(2616005)(336012)(8936002)(8676002)(82740400003)(81166007)(47076005)(53546011)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 17:28:49.4901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae544c6e-ca38-4d21-119e-08dbf1c9d0b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

Added Jan Kuliga who submitted a similar change.

https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek.krakow.pl/T/#m20c1ca4bba291f6ca07a8e5fbcaeed9fd0a6f008


Thanks,

Lizhi

On 11/30/23 03:13, Miquel Raynal wrote:
> The driver is capable of starting scatter-gather transfers and needs to
> wait until their end. It is also capable of starting cyclic transfers
> and will only be "reset" next time the channel will be reused. In
> practice most of the time we hear no audio glitch because the sound card
> stops the flow on its side so the DMA transfers are just
> discarded. There are however some cases (when playing a bit with a
> number of frames and with a discontinuous sound file) when the sound
> card seems to be slightly too slow at stopping the flow, leading to a
> glitch that can be heard.
>
> In all cases, we need to earn better control of the DMA engine and
> adding proper ->device_terminate_all() and ->device_synchronize()
> callbacks feels totally relevant. With these two callbacks, no glitch
> can be heard anymore.
>
> Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfers")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> This was only tested with cyclic transfers.
> ---
>   drivers/dma/xilinx/xdma.c | 68 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index e931ff42209c..290bb5d2d1e2 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -371,6 +371,31 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>   		return ret;
>   
>   	xchan->busy = true;
> +
> +	return 0;
> +}
> +
> +/**
> + * xdma_xfer_stop - Stop DMA transfer
> + * @xchan: DMA channel pointer
> + */
> +static int xdma_xfer_stop(struct xdma_chan *xchan)
> +{
> +	struct virt_dma_desc *vd = vchan_next_desc(&xchan->vchan);
> +	struct xdma_device *xdev = xchan->xdev_hdl;
> +	int ret;
> +
> +	if (!vd || !xchan->busy)
> +		return -EINVAL;
> +
> +	/* clear run stop bit to prevent any further auto-triggering */
> +	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
> +			   CHAN_CTRL_RUN_STOP);
> +	if (ret)
> +		return ret;
> +
> +	xchan->busy = false;
> +
>   	return 0;
>   }
>   
> @@ -475,6 +500,47 @@ static void xdma_issue_pending(struct dma_chan *chan)
>   	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
>   }
>   
> +/**
> + * xdma_terminate_all - Terminate all transactions
> + * @chan: DMA channel pointer
> + */
> +static int xdma_terminate_all(struct dma_chan *chan)
> +{
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct xdma_desc *desc = NULL;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> +	xdma_xfer_stop(xdma_chan);
> +
> +	vd = vchan_next_desc(&xdma_chan->vchan);
> +	if (vd)
> +		desc = to_xdma_desc(vd);
> +	if (desc) {
> +		dma_cookie_complete(&desc->vdesc.tx);
> +		vchan_terminate_vdesc(&desc->vdesc);
> +	}
> +
> +	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
> +	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> +	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
> +
> +	return 0;
> +}
> +
> +/**
> + * xdma_synchronize - Synchronize terminated transactions
> + * @chan: DMA channel pointer
> + */
> +static void xdma_synchronize(struct dma_chan *chan)
> +{
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +
> +	vchan_synchronize(&xdma_chan->vchan);
> +}
> +
>   /**
>    * xdma_prep_device_sg - prepare a descriptor for a DMA transaction
>    * @chan: DMA channel pointer
> @@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *pdev)
>   	xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
>   	xdev->dma_dev.device_config = xdma_device_config;
>   	xdev->dma_dev.device_issue_pending = xdma_issue_pending;
> +	xdev->dma_dev.device_terminate_all = xdma_terminate_all;
> +	xdev->dma_dev.device_synchronize = xdma_synchronize;
>   	xdev->dma_dev.filter.map = pdata->device_map;
>   	xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
>   	xdev->dma_dev.filter.fn = xdma_filter_fn;

