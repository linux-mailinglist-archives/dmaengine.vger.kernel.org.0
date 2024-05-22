Return-Path: <dmaengine+bounces-2141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D668CC53C
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 18:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B359D1F21A78
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8C1420B9;
	Wed, 22 May 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yEi6hnUl"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C095141987
	for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397188; cv=fail; b=d2uddGplF+gYcxxcX36Z9M3/QgZaxmtjRXRRuqpi1z2/8d2sWE9NSymbQ8hOavUmKGc8wSspHYFPdNP3vp0/gDf+YSAzHTYdnlrrCC6zmSOCdydYzIaCmB3xhEzn6w8wv5AZPl92CinHg7BJEgrz3nmjz/VBhBwNKgM/tPdQ0Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397188; c=relaxed/simple;
	bh=kYw48Z7ShnWJtYN+a5eN4UHXdSz+K5sw+pjHn7j85To=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rqHVz66LAXS7z0YfGSyPZNlzmLqEXLfGxfR/Eddqwwnwb2hqKpMKj52S3WnZX3uxb/4XriFF2VZLBrc8PFSdKXrZROFdM7FVUA6goAu05tLwkF7UwZ/Ktu6GGnHj7Vz5NPZ2tq+IM1RdptWAeqKT6jyKo1IYpJ5B2fagZnplyrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yEi6hnUl; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3LhV81wm8ZJSg0VPMI21W68R0IZTY2bKv+E0g/mBgn+uudBm8ETiGNfyoz7IYzi1GN2HbCTLqOIawvIax5dsTUV9cP2Yet8ZHPlqqoB460i12Gcqz2cW4D6uRwA166XkbhQHMrDofAva5f5QDom705hq1+lGMo2S8yO79h9Le9fsjUoYwXBoaSWnpHGUCysBySqqJPlZCqLO9ESU2h0JLqTi2ejJgCms6tqgwx98W8CPBqc2I0U0forASnexeEKRvrrlY4Veog8Z/1LoCdNqshB7CyVY813Cw54i76KwMWt85o9/SSoA+xpJ7aj3L4HD2g36+qMZ5MIDK4sIR+rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGvMqB4iUm26Id+TwimMCmQZ4fLDRrRNVsJ7C21grNQ=;
 b=GOZm98kyPBW9+vIyqMOqgBdr9rLaZX8iplt+l+1TbeMbogPJjMepnCC76R6g+d4mik2p/2eU1BXXJAaMU/n88ZW33F2gnaLxF7UZKb+BkF+WmSKCE+C/PmHqEeFl6DtxvWDusjsbPZuGUajFeuFg3zPAQKu+zuJIl07eR0ndtOZga/yNefS6uVbgijTcl+JD0VGOOfaEfh3NY5wHbwp+O6cpThFlgp7SvJRyh67ZS+wIowriyB9haBDqFlhzLA2bph8rkaUbp9C+QZKDOmI6GbD+9CbtGSEHV5sSGBuTTUxFiBb/m9fZY16mq07bj9wI9EouwD3aj0O7uVsVB9rwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=digigram.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGvMqB4iUm26Id+TwimMCmQZ4fLDRrRNVsJ7C21grNQ=;
 b=yEi6hnUloSPmfjxGSp+uGoCnIr2itM3iMrMxdAjTU87qZGWJ4n15aO9whLM6vOcA+qNOsdZOXcbq3+EqBUQTr7YmF6qyh0mbS8qsXF7QV6JLpSezTCO67IIiW4dh1/KtVie3caXUij90iqHL4yy+VRf+b0HzB9DKQzKZEj1INNU=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:59:43 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::54) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 16:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 16:59:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 11:59:39 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 22 May 2024 11:59:39 -0500
Message-ID: <f5d73b4b-ff2c-f94b-e75e-c9f60c657c11@amd.com>
Date: Wed, 22 May 2024 09:59:39 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 1/2] : Fix DMAR Error NO_PASID when IOMMU is
 enabled
Content-Language: en-US
To: Eric Debief <debief@digigram.com>, <dmaengine@vger.kernel.org>
References: <CALYqZ9myK4rD6gds3j2WeuFq52i6_wghnZ9BVQAaEcVvZ6RxZA@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CALYqZ9myK4rD6gds3j2WeuFq52i6_wghnZ9BVQAaEcVvZ6RxZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2edfe-5577-40eb-7d02-08dc7a8091dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0txRDJFcWJEWUZqNTc2SHNQak1qNVpUWk55SWtDNElQTXFveXhTOW02ajMy?=
 =?utf-8?B?YnlDNzRuZ2pJRHlDc2tPODZDN0U2ZlVaTWVWdUNVVDhmVzJwSEpNcVZnTXdC?=
 =?utf-8?B?R0ZweGxjMlRrMlhpSmhreHN3VDB5WUk4REZEa2Q3b0FlQnk3aUo1Vloyb0FO?=
 =?utf-8?B?QnBIaXNpdEE4Ym5sRDJZN1FETzRWNUN6TFN2WDE3aHJwOXByTzJtSnd3TlIz?=
 =?utf-8?B?YnRoLzB4S2x6OCtWYU1udGc2VklCNkV6R0dxR2VWeHlaZVk0RmFCWUJ5cTEr?=
 =?utf-8?B?TjBQci8ySFRuTDAvN3J4N3A0ZlZoU3Znc3YvdTF4QjZLL1IwU0NTamZHT3Ax?=
 =?utf-8?B?VGJsYTVoUU85bGpRQTRnaVJReUdYVzRJZXRZem1Vd3cwQUtyRVJWeVFBd01m?=
 =?utf-8?B?c3VwSVNNMi9QUUtWT3BtVFdRM3JJZlJTR3dlMlRmdHhOMmxlODBYYXFZTmNm?=
 =?utf-8?B?L29WR0dMOHR3cDhDeGNGK3BVYzNFVVZiTjRjVzVmcG9OQVBiMFBQbUNHM01s?=
 =?utf-8?B?WHhoKzB3WGU3cmRKMEFaeXBiYjdvb2FmelRpWUJDTnMwbHN1QnROaGhkcUNV?=
 =?utf-8?B?c2RZbUVnMkk2K1JKMHNNdWJ4V2dsSGdwYTdGRUhnMUVUVjFoU0QrcmJyTDF2?=
 =?utf-8?B?Q1NpVjlJc3RKWExNdXFNL3RhWGhnMCs3bldDTzVySVZoWUFhMnBOaVhCRkFE?=
 =?utf-8?B?N3k4RFpiTWRnbUxxMGxEaGJwTHdUY0d1NGp5cnQzc1dHdWQ1Z2Z3eDJkejd5?=
 =?utf-8?B?UzJqM1FOMWhoQjJyRDV2QU50ZElIYXB5ZWI0eWkrcmdtdHlYSzNqMHdqYmIx?=
 =?utf-8?B?ZG1kazdMdGIrS1JWcysxamV1WDdYU1BaS25OT1NNaDlqeHRpTTByeGVyWHFz?=
 =?utf-8?B?T1ZjZ3JZQWZkMnJieVgvZ0VqNExLaTFicmVPNHM2UExKNHhzNWNyZzJwNDFW?=
 =?utf-8?B?UFYwYzR4cERtaTBOekFPbXVhelVwNFpxa2czaTVpRFlGSTdTd29qbWdQN3Zr?=
 =?utf-8?B?SEdZVEhob3R6VHAxRU9CUTg5QjVOb2xEN0Z2SE1wTDVueEsxSDNSKzBSMGhT?=
 =?utf-8?B?aXVGSmUxOVBtcEEvNnNNS2NvSURaOEdyOXY0aEl0c2Yyc095U1pkbStkWkRD?=
 =?utf-8?B?OFdiQXFsSU1BQVViNlNBZlZHZXpLbUFjR24rUmUrcFpwTjVWdlBoZ01rbmdj?=
 =?utf-8?B?LzhLZ2pqTk43dUtpZzhOUTRPbTlJMlkzdm9iTTRvLzZUbWI2NU1BemREdk9C?=
 =?utf-8?B?cENnY2QxT3pCWE12WlJNTzVDM05vMEN6VWw0QnJGZ0cxcnZWUjY5d09KSTZq?=
 =?utf-8?B?Q09HM2M4cFpzaVBCSVlDMXE4U1lZU2NCamV3WTRKMndma1QyWHNQYkV6WkUz?=
 =?utf-8?B?WXN0R3huY0hWVE1BaUdFc0JpUE51U3lwV1Y5aGJtdWp4R3p0YTJ6S21ZczVS?=
 =?utf-8?B?SEZWMy8rRnlqelptVnMyT2xzdlVaeFFtcktaQ0M2akJZdEQ0R1BlM2tRSFh1?=
 =?utf-8?B?aXFqWTBsZDhtTlcrb295VVpkNWo5Z3NqUzR5VnBzTmp1QzlFQ01Ec3NlbGho?=
 =?utf-8?B?SFdlWm9EaFRDMWY2Q1FNeHVOTHBPWU9SUkpoTW9WOFlVNDFnNjZUQ01GbFNw?=
 =?utf-8?B?azVOcXdBNjNzU2VYYzE0ZDZlSFN6Tjl6T1cyMDF3cTRFTUpRWmFvL3k2eTdD?=
 =?utf-8?B?eDZ4Y0ZYM0tJMnU4TzlKajJYUEorakNPY3RYTzJKTVVBTVE4S2pHZXRkL0hj?=
 =?utf-8?B?ZU5mSzhrQlpTZUkyR0UyT2RPRjl5bjJycnZmWmhXc0NmN1RUbnk0bDlWbnFm?=
 =?utf-8?B?Y2Q5aktOWW5HU1NxOFE3Mk10MkFWUTlMQktZdDYvSUJNY1QzZytnV3k0eVNB?=
 =?utf-8?Q?61axwfM7Y5mZB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:59:40.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2edfe-5577-40eb-7d02-08dc7a8091dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

Hi Eric,


Current xdma driver supports only Memory Mapped (writeback polling is 
off) channel. And it is tested with iommu on. With this configuration, 
the hardware should not generate any writeback.

So, what you are working on is  something like "add stream channel support".

To support stream channel, I would suggest to add "bool stream_mode" in 
struct xdma_chan and set it based on identifer register in 
xdma_alloc_channels().

The C2H writeback allocations and other stream specific operation should 
be based on stream_mode flag.

At last, the wb buf should be per descriptor instead of per channel. And 
the interrupt handler routine should look at the length and EOP in wb 
buf. With stream mode, the C2H desc may partially filled up due to an 
end of packet.


Thanks,

Lizhi

On 5/22/24 05:12, Eric Debief wrote:
> Hi,
>
> We had a "DMAR Error  NO PASID" error reported in the kernel's log
> when the IOMMU was enabled.
>
> This is due to the missing WriteBack area for the C2H stream.
> Below my patch.
> One point : I didn't compile it within the latest kernel's sources'
> tree as it is an extract of our backport of the XDMA support.
> Feel free to contact me on any issue with this.
>
> Hope this helps,
> Eric.
>
> Below my patch (corrected).
>
>  From b8d71851e6a146dcb448b01a671f455afb09ae90 Mon Sep 17 00:00:00 2001
> From: Eric DEBIEF <debief@digigram.com>
> Date: Wed, 22 May 2024 12:33:06 +0200
> Subject: FIX: DMAR Error with IO_MMU enabled.
>
> C2H write-back area was not allocated and set.
> This leads to the DMAR Error.
>
> Add the Writeback structure, allocate and set it as
> the descriptors's Src field.
> Done for all preps functions.
>
> Signed-off-by: Eric DEBIEF <debief@digigram.com>
> ---
>   drivers/dma/xilinx/xdma.c | 44 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 74d4a953b50f..9ae615165cb6 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -51,6 +51,20 @@ struct xdma_desc_block {
>       dma_addr_t    dma_addr;
>   };
>
> +/**
> + * struct xdma_c2h_write_back  - Write back block , written by the XDMA.
> + * @magic_status_bit : magic (0x52B4) once written
> + * @length: effective transfer length (in bytes)
> + * @PADDING to be aligned on 32 bytes
> + * @associated dma address
> + */
> +struct xdma_c2h_write_back {
> +    __le32 magic_status_bit;
> +    __le32 length;
> +    u32 padding_1[6];
> +    dma_addr_t dma_addr;
> +};
> +
>   /**
>    * struct xdma_chan - Driver specific DMA channel structure
>    * @vchan: Virtual channel
> @@ -61,6 +75,8 @@ struct xdma_desc_block {
>    * @dir: Transferring direction of the channel
>    * @cfg: Transferring config of the channel
>    * @irq: IRQ assigned to the channel
> + * @write_back : C2H meta data write back
> +
>    */
>   struct xdma_chan {
>       struct virt_dma_chan        vchan;
> @@ -73,6 +89,7 @@ struct xdma_chan {
>       u32                irq;
>       struct completion        last_interrupt;
>       bool                stop_requested;
> +    struct xdma_c2h_write_back *write_back;
>   };
>
>   /**
> @@ -628,7 +645,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
>           src = &addr;
>           dst = &dev_addr;
>       } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
>           src = &dev_addr;
>           dst = &addr;
>       }
> @@ -705,7 +723,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t address,
>           src = &addr;
>           dst = &dev_addr;
>       } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->write_back->dma_addr;
>           src = &dev_addr;
>           dst = &addr;
>       }
> @@ -803,6 +822,9 @@ static void xdma_free_chan_resources(struct dma_chan *chan)
>       struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>
>       vchan_free_chan_resources(&xdma_chan->vchan);
> +    dma_pool_free(xdma_chan->desc_pool,
> +                xdma_chan->write_back,
> +               xdma_chan->write_back->dma_addr);
>       dma_pool_destroy(xdma_chan->desc_pool);
>       xdma_chan->desc_pool = NULL;
>   }
> @@ -816,6 +838,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>       struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>       struct xdma_device *xdev = xdma_chan->xdev_hdl;
>       struct device *dev = xdev->dma_dev.dev;
> +    dma_addr_t write_back_addr;
>
>       while (dev && !dev_is_pci(dev))
>           dev = dev->parent;
> @@ -824,13 +847,26 @@ static int xdma_alloc_chan_resources(struct
> dma_chan *chan)
>           return -EINVAL;
>       }
>
> -    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
> XDMA_DESC_BLOCK_SIZE,
> -                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
> +    //Allocate the pool WITH the H2C write back
> +    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> +                            dev,
> +                            XDMA_DESC_BLOCK_SIZE +
> +                                sizeof(struct xdma_c2h_write_back),
> +                            XDMA_DESC_BLOCK_ALIGN,
> +                            XDMA_DESC_BLOCK_BOUNDARY);
>       if (!xdma_chan->desc_pool) {
>           xdma_err(xdev, "unable to allocate descriptor pool");
>           return -ENOMEM;
>       }
>
> +    /* Allocate the C2H write back out of the pool*/
> +    xdma_chan->write_back = dma_pool_alloc(xdma_chan->desc_pool,
> GFP_NOWAIT, &write_back_addr);
> +    if (!xdma_chan->write_back) {
> +        xdma_err(xdev, "unable to allocate C2H write back block");
> +        return -ENOMEM;
> +    }
> +    xdma_chan->write_back->dma_addr = write_back_addr;
> +
>       return 0;
>   }
>
> --
> 2.34.1

