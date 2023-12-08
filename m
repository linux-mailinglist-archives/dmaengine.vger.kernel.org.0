Return-Path: <dmaengine+bounces-427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B580AE87
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E921C208D4
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079A57318;
	Fri,  8 Dec 2023 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3KqmzsKs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA842137;
	Fri,  8 Dec 2023 13:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNGITcyE/rtyoiLF3ZRtEVg3P6Oi2a2ZHOb8ZdfYJg6SbUlZ7pwJ0iQvhzaHL/OvAru/FqhTn/an93F9rnYemtz7GKZVbydgwx9qz4g6b4IZdJFHVX5yHi2kpbWqh1S2iL/BeWzvGZCOk34Vo4a2mAODq5rqYb8OHjrWoOQsQ34XhQ0PkVdoXFe+gCShhAaiofnd0QyFQam5+XZjq6oPwHaa4pgzbWhnpLNK9nMLqpKXWauEa3NVsUpkJuGaP/tX+kM0r9JjI0EJQtLufU4eA98b3dtzzKguOeMjlCUPVSiWwxjkY9v+4b8HcX16bAXY7JaBzNqA3CLB3GIoVgFKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1HiFdweHQNtay5KZy/c7ZJHHHbi374fBmKATE6izTw=;
 b=oeGlKteJRq+ywGBkPOvcjGJpbl2Zd/Y6fHe5lV2R7c+34+TRhN4CKgyEtQbKtwa9WKxgNVpkTnxw7wtPskB2pLQg6L+De47d5bDu5V4cQsmwn0G6LjzLLSSxbFANkEH2HuXWxDLfkjg6ltrSuNOpbDfQTs6lNVMFPngQkeRKkzmIWQIH05CpmDYgs8iJlFnYZ8AO458axhH/r+0Zdqa3CIudCGJ1aJck2m4DlSrx1gIj+Rgnqd8xzFPPdp84bZBxZYTXDUDTLzvECJ6OfhhnMmc/J1jwPIILX4HuOaIb5xBvj3A0FtNBTg7s5uQsPWlw03i4JBCTLZSDhDEU2Pei5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alatek.krakow.pl smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1HiFdweHQNtay5KZy/c7ZJHHHbi374fBmKATE6izTw=;
 b=3KqmzsKs5+W68avqgY5d3wY17+HgXPEt40qO0AdRClWSILSNWTEVOO5O1ak3iDnDF7WUYZGw7kYWvJuSe9O5zGlkT2MbI/CVXqbtKHmjWsMukxdX6TBr5e942AxhV0ufebHbMU8vWAFr8dc1yu4obELuPnxzGViEEbO2LMJYmSo=
Received: from SN7PR04CA0070.namprd04.prod.outlook.com (2603:10b6:806:121::15)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 21:06:12 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::f5) by SN7PR04CA0070.outlook.office365.com
 (2603:10b6:806:121::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Fri, 8 Dec 2023 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 21:06:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 15:06:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 15:06:08 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 8 Dec 2023 15:06:07 -0600
Message-ID: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
Date: Fri, 8 Dec 2023 13:06:07 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] dmaengine: xilinx: xdma: Add transfer error
 reporting
Content-Language: en-US
To: Jan Kuliga <jankul@alatek.krakow.pl>, <brian.xu@amd.com>,
	<raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>, <michal.simek@amd.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<miquel.raynal@bootlin.com>
References: <20231208134838.49500-1-jankul@alatek.krakow.pl>
 <20231208134929.49523-7-jankul@alatek.krakow.pl>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231208134929.49523-7-jankul@alatek.krakow.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de3af6f-5913-43d3-034a-08dbf8318210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KbH5YyLa7LbktQo3xAmNf3453NdKwAd4eX2HxiTnGyYVpz2K9uXs86/mlBoFmyeLBhlvE+36X9mGm2USoIzqcnmqRP+Ta+6xZ6S4nEozNlSLaXspyVJnp5mMokXOsoL7JOHur09UVZgBeC74smhtThJLfFmETX1AwqXnCSbySCVKnVqzuVGGeqk4Chv1SV31kYiIfM02qN+jOiIHGK0F9axEfVfU+7Ecu3vyRx8ldpAXw/fLaC0xTVVDu7pBy6u1+TTRlkSc5Cl2vgHPv+nBMpqmQ0nL5970NCZOsZSErl1SpoYQPjOtSm5kTtP0guP4PdaLO7aSs1juZ89HyP59EnZl8WG6N9iccTw1ew9ONGSgK6Ly6HIfCwWqf08TD14JmugeZO4wxELxCMfU1vQ0s3j5wAQkQ5i7PHR2y/pPmP3VcuHZ866WuaYIwbj73IasolAgan6tbxWrz5SVQB8fAcbim9PqocvEqitBHjX1o6FHLSRATJq/xGRpD2YHJgdNVR45ywPYeZN+NFQ0pEgWcorJZr/kqLafRREz6zXGblsuvAehom+fosGlZeoQqenz2I9Iwa3sBwNvRVeuxolnBiOg4gI0tv0meG1IjyImfbdWDei728Q19axqAKRw0MLWTrfNqec23S64J4ZOD8Dh1YqnXrkvOtUiFqDj3WUVHhP7oKTTmjo95E3w29C2Z3E8xSiNA2uF9dY9E8l1lfHUVabXpl2EnOLSb+eotE9lVZh2g+5YmUWWGQEF/H8lHDKQt0HPAONqgQoQi/95lx2jfIIyiUCvE3niSdrg4qnrf/q8W5Ry9QZZQYmFo8ql7sx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(336012)(2616005)(426003)(26005)(53546011)(8936002)(47076005)(8676002)(44832011)(5660300002)(316002)(478600001)(110136005)(70586007)(16576012)(83380400001)(36860700001)(70206006)(356005)(2906002)(82740400003)(81166007)(86362001)(31696002)(36756003)(40480700001)(40460700003)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 21:06:12.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de3af6f-5913-43d3-034a-08dbf8318210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244


On 12/8/23 05:49, Jan Kuliga wrote:
> Extend the capability of transfer status reporting. Introduce error flag,
> which allows to report error in case of a interrupt-reported error
> condition.
>
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>   drivers/dma/xilinx/xdma.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index d1bc36133a45..dbde6905acc7 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -85,6 +85,7 @@ struct xdma_chan {
>    * @cyclic: Cyclic transfer vs. scatter-gather
>    * @periods: Number of periods in the cyclic transfer
>    * @period_size: Size of a period in bytes in cyclic transfers
> + * @error: tx error flag
>    */
>   struct xdma_desc {
>   	struct virt_dma_desc		vdesc;
> @@ -97,6 +98,7 @@ struct xdma_desc {
>   	bool				cyclic;
>   	u32				periods;
>   	u32				period_size;
> +	bool				error;
>   };
>
>   #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
> @@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
>   	sw_desc->chan = chan;
>   	sw_desc->desc_num = desc_num;
>   	sw_desc->cyclic = cyclic;
> +	sw_desc->error = false;
>   	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
>   	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
>   				       GFP_NOWAIT);
> @@ -770,20 +773,20 @@ static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie
>   	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>
>   	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> -	if (vd)
> -		desc = to_xdma_desc(vd);
> -	if (!desc || !desc->cyclic) {
> -		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> -		return ret;
> -	}
> -
> -	period_idx = desc->completed_desc_num % desc->periods;
> -	residue = (desc->periods - period_idx) * desc->period_size;
> +	if (!vd)
> +		goto out;
>
> +	desc = to_xdma_desc(vd);
> +	if (desc->error) {
> +		ret = DMA_ERROR;
> +	} else if (desc->cyclic) {
> +		period_idx = desc->completed_desc_num % desc->periods;
> +		residue = (desc->periods - period_idx) * desc->period_size;
> +		dma_set_residue(state, residue);
> +	}
> +out:
>   	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
>
> -	dma_set_residue(state, residue);
> -
>   	return ret;
> }
>
> @@ -808,6 +811,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	vd = vchan_next_desc(&xchan->vchan);
>   	if (!vd)
>   		goto out;
> +	desc = to_xdma_desc(vd);
Duplicated line.
>
>   	desc = to_xdma_desc(vd);
>   	xdev = xchan->xdev_hdl;
> @@ -820,6 +824,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	st &= XDMA_CHAN_STATUS_MASK;
>   	if ((st & XDMA_CHAN_ERROR_MASK) ||
>   		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
> +		desc->error = true;
>   		xdma_err(xdev, "channel error, status register value: 0x%x", st);
>   		goto out;
>   	}
> --
> 2.34.1
>

