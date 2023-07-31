Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047CB76A537
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 01:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjGaXxl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaXxk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 19:53:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B67AF
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 16:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmv9e5eyCMmKHCVH1HpJm9YJMhDsVzrBQhb7P+gQTGFcEoKwlD5b8H4HuAdNvsxP3o60NeR1jVo/WNq4JZg+DkZ27wGxDoAaVnOf8WB4FLmoaa7zQpoGkxorSP/qYNGUw5fO/8W6rZb/j3rZ2fuurHujVrhqhvGBl4ti50WW5xIw039af4WV8Lg7OUjDQSghyYHpNLkSYxBDQCdAmbd7oKq8zUDdUGc2TxbnDhvHc83ju4KWeaywo8dbL4IQ70aIqjfHhuhxjp/RdMlQPUvjEzMA9EegKjf6DfyUi7ZOLTwDPjBPSEIekurifmjIhj8N6azKlyZ4qygNe2vSWDjV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzPR+p6jUptZufPW8EEToM7oN3uJg8Iow4Ik5SfAxpM=;
 b=SCup5rN71mhG5P8rSs1B9k8FRPUiInl3tcmEAjr5VJLSPE6AHUcF3Es0Pu2k7B4e294XXLVIM6wPB2a/03Pxo8uLmtdVHDufAMhbykzPrl9XzXwLb+wtx8J+nJ4nw432+0WSofQql3WypMGWfDmb9DqY7VY/nhH1Fq+5i1htPZrVDNhF/f03g+BjMMi03DFwnNgvGBdqZ0nZYyMRXoFERF8ZpYTGM5IUEK7pSHvVAW9zYn2JIwdT7hHgNdvPqGTMEtliwk+2DK3Kj5DUu4RSRarSiz9DSeo6Te4D0deFtFicwqDNcKjPQeSFmmI1r2IWgCdWRo1Kt658/6cBZWSwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzPR+p6jUptZufPW8EEToM7oN3uJg8Iow4Ik5SfAxpM=;
 b=J5O2P5sK4hVb+Mx3yDxRjCmoLGVPqYcWcmzIylsCNRHUzuKsGMr+s405Xw0i0B8kR3cySu2KzdUBeKIF7RCy5Clc0ChbS7At/hPJAfF4kxbIV20yAzWYx8D9h688TpIXMtptiXYSmxGm584A1TQ5BNIudVwWB1Kp4EFWXbMka6w=
Received: from CYZPR12CA0003.namprd12.prod.outlook.com (2603:10b6:930:8b::16)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 23:53:34 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::45) by CYZPR12CA0003.outlook.office365.com
 (2603:10b6:930:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 23:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 23:53:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 18:53:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 16:53:32 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 18:53:31 -0500
Message-ID: <e6535253-e298-1f42-3363-760955953a22@amd.com>
Date:   Mon, 31 Jul 2023 16:53:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dmaengine: xilinx: xdma: Support cyclic transfers
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        "Sonal Santan" <sonal.santan@amd.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
 <20230731101442.792514-5-miquel.raynal@bootlin.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230731101442.792514-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: bab3cbaa-6255-443a-c54e-08db92215948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98Q45S7lSt0U+Cf0ogDBp1iEY8aHs7n+xqlIBumt4EJMbP2KIGLyPnNo5O04HlIaJdj4I11GFN5jBNG8SAJOlyMI0xyU/316RHYzbzW2C8Mmep7Q9vxMRie9vpyYJNemrqBjgooHirk4U+A76lHfxa5fjkDTaTm5HgMMfaLzD4YALwRaJjXw2gn5Pxp/+VxPgM5RPrQaZn/qWzCEppZpmfq4EBP5y8f3rQ1ja2muWwjgmqOMYv4aLfm45s7U9APL2bWZDJpujT6vekXBPIttAHBP5ppnyMIpqlWGolFDHEeLFzlE5wIccDkAC2I38IcBQGzp93RrutXx/wxUbBAcFZZGgeYL2s/nnzEhPfn1PwkciKm4EWnVRTEoYQqdwOYPWGJC1BFEo/voTU/q9O3Su/G6yAWcB/+skKct5BTWlYBy1sf/VoYyFhMjCD0sRGqUsO5tPv7koA9wylg2LQ5QeJVP7JDgsTqBRuG30Lj+jk5hWPqmafiYMTIqcIdh2QpBWbnLBPkAX+0hK35ZnJKfVJzm5+IMtdWcCk4Mzzd7VIz79OMjLrhE6AMgd3iXqbDwF3+spk1BWT7Jg0jn6YV4L6uGManBMj4KAUIrWgqATHOT8ThlIcu5s7U7zNc47xPwqI+kq0Jqf8rRza9NE5GDgKNNhAm/EPsCtFrYW4kF/JlJNw5CJk9luxWJs0Dlxa8P1OYEoqe/mHjDKPkxJbuG7OuUwEtkq2xJm1Sacwy1odVKTwPqBEVI7ZhIYogOOcQaUGuy86Luyu6qZU8RTA0CCreHjcFHyumOTKmV/9ehHG6ayKXfcPgqHygeMfYTZOGK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(36756003)(186003)(336012)(426003)(40480700001)(26005)(53546011)(2616005)(40460700003)(36860700001)(316002)(16576012)(30864003)(41300700001)(81166007)(356005)(4326008)(2906002)(70586007)(70206006)(5660300002)(8936002)(31696002)(86362001)(44832011)(31686004)(8676002)(54906003)(110136005)(82740400003)(478600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:53:33.1480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab3cbaa-6255-443a-c54e-08db92215948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/31/23 03:14, Miquel Raynal wrote:
> In order to use this dmaengine with sound devices, let's add cyclic
> transfers support. Most of the code is reused from the existing
> scatter-gather implementation, only the final linking between
> descriptors, the control fields (to trigger interrupts more often) and
> the interrupt handling are really different.
>
> This controller supports up to 32 adjacent descriptors, we assume this
> is way more than enough for the purpose of cyclic transfers and limit to
> 32 the number of cycled descriptors. This way, we simplify a lot the
> overall handling of the descriptors.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/dma/xilinx/xdma-regs.h |   2 +
>   drivers/dma/xilinx/xdma.c      | 173 +++++++++++++++++++++++++++++++--
>   2 files changed, 169 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index dd98b4526b90..e641a5083e14 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -44,6 +44,8 @@
>   	 FIELD_PREP(XDMA_DESC_FLAGS_BITS, (flag)))
>   #define XDMA_DESC_CONTROL_LAST						\
>   	XDMA_DESC_CONTROL(1, XDMA_DESC_STOPPED | XDMA_DESC_COMPLETED)
> +#define XDMA_DESC_CONTROL_CYCLIC					\
> +	XDMA_DESC_CONTROL(1, XDMA_DESC_COMPLETED)
>   
>   /*
>    * Descriptor for a single contiguous memory block transfer.
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 40983d9355c4..be3a212be30c 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -83,6 +83,9 @@ struct xdma_chan {
>    * @dblk_num: Number of hardware descriptor blocks
>    * @desc_num: Number of hardware descriptors
>    * @completed_desc_num: Completed hardware descriptors
> + * @cyclic: Cyclic transfer vs. scatter-gather
> + * @periods: Number of periods in the cyclic transfer
> + * @period_size: Size of a period in bytes in cyclic transfers
>    */
>   struct xdma_desc {
>   	struct virt_dma_desc		vdesc;
> @@ -93,6 +96,9 @@ struct xdma_desc {
>   	u32				dblk_num;
>   	u32				desc_num;
>   	u32				completed_desc_num;
> +	bool				cyclic;
> +	u32				periods;
> +	u32				period_size;
>   };
>   
>   #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
> @@ -174,6 +180,25 @@ static void xdma_link_sg_desc_blocks(struct xdma_desc *sw_desc)
>   	desc->control = cpu_to_le32(XDMA_DESC_CONTROL_LAST);
>   }
>   
> +/**
> + * xdma_link_cyclic_desc_blocks - Link cyclic descriptor blocks for DMA transfer
> + * @sw_desc: Tx descriptor pointer
> + */
> +static void xdma_link_cyclic_desc_blocks(struct xdma_desc *sw_desc)
> +{
> +	struct xdma_desc_block *block;
> +	struct xdma_hw_desc *desc;
> +	int i;
> +
> +	block = sw_desc->desc_blocks;
> +	for (i = 0; i < sw_desc->desc_num - 1; i++) {
> +		desc = block->virt_addr + i * XDMA_DESC_SIZE;
> +		desc->next_desc = cpu_to_le64(block->dma_addr + ((i + 1) * XDMA_DESC_SIZE));
> +	}
> +	desc = block->virt_addr + i * XDMA_DESC_SIZE;
> +	desc->next_desc = cpu_to_le64(block->dma_addr);
> +}
> +
>   static inline struct xdma_chan *to_xdma_chan(struct dma_chan *chan)
>   {
>   	return container_of(chan, struct xdma_chan, vchan.chan);
> @@ -233,7 +258,7 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
>    * @desc_num: Number of hardware descriptors
>    */
>   static struct xdma_desc *
> -xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
> +xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
>   {
>   	struct xdma_desc *sw_desc;
>   	struct xdma_hw_desc *desc;
> @@ -249,13 +274,17 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
>   
>   	sw_desc->chan = chan;
>   	sw_desc->desc_num = desc_num;
> +	sw_desc->cyclic = cyclic;
>   	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
>   	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
>   				       GFP_NOWAIT);
>   	if (!sw_desc->desc_blocks)
>   		goto failed;
>   
> -	control = XDMA_DESC_CONTROL(1, 0);
> +	if (cyclic)
> +		control = XDMA_DESC_CONTROL_CYCLIC;
> +	else
> +		control = XDMA_DESC_CONTROL(1, 0);
>   
>   	sw_desc->dblk_num = dblk_num;
>   	for (i = 0; i < sw_desc->dblk_num; i++) {
> @@ -269,7 +298,10 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
>   			desc[j].control = cpu_to_le32(control);
>   	}
>   
> -	xdma_link_sg_desc_blocks(sw_desc);
> +	if (cyclic)
> +		xdma_link_cyclic_desc_blocks(sw_desc);
> +	else
> +		xdma_link_sg_desc_blocks(sw_desc);
>   
>   	return sw_desc;
>   
> @@ -469,7 +501,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
>   	for_each_sg(sgl, sg, sg_len, i)
>   		desc_num += DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
>   
> -	sw_desc = xdma_alloc_desc(xdma_chan, desc_num);
> +	sw_desc = xdma_alloc_desc(xdma_chan, desc_num, false);
>   	if (!sw_desc)
>   		return NULL;
>   	sw_desc->dir = dir;
> @@ -524,6 +556,89 @@ xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
>   	return NULL;
>   }
>   
> +/**
> + * xdma_prep_dma_cyclic - prepare for cyclic DMA transactions
> + * @chan: DMA channel pointer
> + * @address: Device DMA address to access
> + * @size: Total length to transfer
> + * @period_size: Period size to use for each transfer
> + * @dir: Transfer direction
> + * @flags: Transfer ack flags
> + */
> +static struct dma_async_tx_descriptor *
> +xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t address,
> +		     size_t size, size_t period_size,
> +		     enum dma_transfer_direction dir,
> +		     unsigned long flags)
> +{
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct xdma_device *xdev = xdma_chan->xdev_hdl;
> +	unsigned int periods = size / period_size;
What if size is not multiple of period_size?
> +	struct dma_async_tx_descriptor *tx_desc;
> +	u64 addr, dev_addr, *src, *dst;
> +	struct xdma_desc_block *dblk;
> +	struct xdma_hw_desc *desc;
> +	struct xdma_desc *sw_desc;
> +	unsigned int i;
> +
> +	/*
> +	 * Simplify the whole logic by preventing an abnormally high number of
> +	 * periods and periods size.
> +	 */
> +	if (period_size > XDMA_DESC_BLEN_MAX) {
> +		xdma_err(xdev, "period size limited to %lu bytes\n", XDMA_DESC_BLEN_MAX);
> +		return NULL;
> +	}
> +
> +	if (periods > XDMA_DESC_ADJACENT) {
> +		xdma_err(xdev, "number of periods limited to %u\n", XDMA_DESC_ADJACENT);
> +		return NULL;
> +	}
> +
> +	sw_desc = xdma_alloc_desc(xdma_chan, periods, true);
> +	if (!sw_desc)
> +		return NULL;
> +
> +	sw_desc->periods = periods;
> +	sw_desc->period_size = period_size;
> +	sw_desc->dir = dir;
> +
> +	if (dir == DMA_MEM_TO_DEV) {
> +		dev_addr = xdma_chan->cfg.dst_addr;
> +		src = &addr;
> +		dst = &dev_addr;
> +	} else {
> +		dev_addr = xdma_chan->cfg.src_addr;
> +		src = &dev_addr;
> +		dst = &addr;
> +	}
> +
> +	dblk = sw_desc->desc_blocks;
> +	desc = dblk->virt_addr;
> +	for (i = 0; i < periods; i++) {
> +		addr = address;
> +
> +		/* fill hardware descriptor */
> +		desc->bytes = cpu_to_le32(period_size);
> +		desc->src_addr = cpu_to_le64(*src);
> +		desc->dst_addr = cpu_to_le64(*dst);
> +
> +		desc++;
> +		address += period_size;
> +	}
> +
> +	tx_desc = vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
> +	if (!tx_desc)
> +		goto failed;
> +
> +	return tx_desc;
> +
> +failed:
> +	xdma_free_desc(&sw_desc->vdesc);
> +
> +	return NULL;
> +}
> +
>   /**
>    * xdma_device_config - Configure the DMA channel
>    * @chan: DMA channel
> @@ -583,7 +698,36 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>   static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>   				      struct dma_tx_state *state)
>   {
> -	return dma_cookie_status(chan, cookie, state);
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct virt_dma_desc *vd;
> +	struct xdma_desc *desc;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	unsigned int period_idx;
> +	u32 residue = 0;
> +
> +	ret = dma_cookie_status(chan, cookie, state);
> +	if (ret == DMA_COMPLETE || !state)
probably do not need to check state. Or at least check before calling 
dma_cookie_status.
> +		return ret;
> +
> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> +
> +	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> +	if (vd)
> +		desc = to_xdma_desc(vd);
> +	if (!desc || !desc->cyclic) {
desc is un-initialized if vd is NULL.
> +		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> +		return ret;
> +	}
> +
> +	period_idx = desc->completed_desc_num % desc->periods;
> +	residue = (desc->periods - period_idx) * desc->period_size;
> +
> +	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> +
> +	dma_set_residue(state, residue);
> +
> +	return ret;
>   }
>   
>   /**
> @@ -599,6 +743,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	struct virt_dma_desc *vd;
>   	struct xdma_desc *desc;
>   	int ret;
> +	u32 st;
>   
>   	spin_lock(&xchan->vchan.lock);
>   
> @@ -617,6 +762,19 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   		goto out;
>   
>   	desc->completed_desc_num += complete_desc_num;
> +
> +	if (desc->cyclic) {
> +		ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
> +				  &st);
> +		if (ret)
> +			goto out;
> +
> +		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st);

What does reading/writing channel status register do here?


Thanks,

Lizhi

> +
> +		vchan_cyclic_callback(vd);
> +		goto out;
> +	}
> +
>   	/*
>   	 * if all data blocks are transferred, remove and complete the request
>   	 */
> @@ -630,7 +788,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	    complete_desc_num != XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)
>   		goto out;
>   
> -	/* transfer the rest of data */
> +	/* transfer the rest of data (SG only) */
>   	xdma_xfer_start(xchan);
>   
>   out:
> @@ -930,8 +1088,10 @@ static int xdma_probe(struct platform_device *pdev)
>   
>   	dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
>   	dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, xdev->dma_dev.cap_mask);
>   
>   	xdev->dma_dev.dev = &pdev->dev;
> +	xdev->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
>   	xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
>   	xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
>   	xdev->dma_dev.device_tx_status = xdma_tx_status;
> @@ -941,6 +1101,7 @@ static int xdma_probe(struct platform_device *pdev)
>   	xdev->dma_dev.filter.map = pdata->device_map;
>   	xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
>   	xdev->dma_dev.filter.fn = xdma_filter_fn;
> +	xdev->dma_dev.device_prep_dma_cyclic = xdma_prep_dma_cyclic;
>   
>   	ret = dma_async_device_register(&xdev->dma_dev);
>   	if (ret) {
