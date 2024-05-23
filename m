Return-Path: <dmaengine+bounces-2145-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0AB8CD85E
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9269FB214B7
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F917BAA;
	Thu, 23 May 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVTFHSpn"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088517BD9
	for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481531; cv=fail; b=bD9JfjpOM0vEwLBnbqN7ZFWLpjNxo/d8VEcEja89i0dd4hleoMxDW6LnAOIY50JKlMjfxknQK+OOD8JJExF/LgEYBxz/YVXSrJ7beglMF5WKWG8LP0dcfLKY8D7UD96XiRJyvINsYLFB1HTCbGKkn+JFMzmw/hc2ZL4vOTu1KZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481531; c=relaxed/simple;
	bh=esXThe3QR2IYTPSpZnWrH0OnSVXT3aqTZ/o0E4qjGAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UKiKaHPLyUcDcCrR1sKqKD9S8kqtkLwon3PX3Xu4qxIsyUGG1LK6ZEQZPxWfCKll7QSSDutUWjE6P6n+OkwLWyR9Ys6Jz1S1la5sl4CRSzTiW5jYE0PA515G/rOWydp7Azoe5wn5TkGzPmKpkYfWtHj6VB2zRH6yCou1livKX9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVTFHSpn; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az+LIFjarTykZitqd5E97FCKHuYrzgTuuJhrxjHe/ZFfff44N9DqubSEMAvoMEnCUfELncGvQyvv9dQHo5yInXhMVFjXDp1opgGDKo1Rch/tLEnPbXUQnu1InAZI4zlOSqycjxzBO1pEKNz21KQWe4wsEHJr5ljgwriNOG4PuJYr2JdCsWigA0Dz75m5wmSUqNQhc7nhALDeDFbOvHQOjiwRbfAvT5OOQ4KXzL71U3E20NL9lf/qIDLxZuY6iVOWCWzwUOqtt2pCh1uMSkkS1liZOmbqXQlfBQJjXjQCYH34MVMpxik6hTjwVWsb15ESNjbHMitxjbJ5a6SUy65gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDDSeD7eLmhuo96P2Q6RFMNBgxeG/0YIVBt4hO/VJPM=;
 b=JFrgSwY0MUWPXtanVb673iXYWYxIoZx04WzRR38PdIjS21wxO79mza4I5jXiNB0eI1k8MtskMHebwb+28NnvYL7I8XmCNoOxoQtnu5DPbiktl8wc5OsokEcWgPgkBJYpJw4H7ImNByKf29V5HGI+VbaJbGt3Dcrctnx0IX08kj+LjdC5QxugGUBcpu7e4nWPGjt9fDg+cNcNh/j+LBCbDgOS2p/ZUYYIox8rcwS1PYdER0ye7YIlvmL1GK1ZjO69PPEKXkKE0ubb6w0Q2RFMxZSwn1RZ+skZEzlJqwelYKH78+cYaxsgCPCbbSD3dLr8w/Nw6Xzt/nIxtTWgs1DFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=digigram.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDDSeD7eLmhuo96P2Q6RFMNBgxeG/0YIVBt4hO/VJPM=;
 b=lVTFHSpnhJkHCyT4sFYKS4ZauPRtJE0Lag3C1TfwfvUrTN3H0mTE7wKbuz+iQ4Xinl9OJ5jhbODrUe4zKfrsBbzvUsucdPxh4rJmmhxxHOrILoN1WaSOsp6cZ1nEgwqrYP4X1qtV8f7xaxGL+TPuOKneLAlnYVFPzUsyCQy/ks4=
Received: from BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35) by
 PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Thu, 23 May 2024 16:25:26 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::eb) by BL0PR01CA0022.outlook.office365.com
 (2603:10b6:208:71::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 23 May 2024 16:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 16:25:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 11:25:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 11:25:25 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 11:25:25 -0500
Message-ID: <87bc333b-d03b-8d5e-548b-17197de0a796@amd.com>
Date: Thu, 23 May 2024 09:25:25 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] : XDMA's Channel in stream mode initial support
Content-Language: en-US
To: Eric Debief <debief@digigram.com>, <dmaengine@vger.kernel.org>
References: <CALYqZ9mM611vq8k5m33Wx1PCw5WrfNNV9xOvrXef6YK2V+zinw@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CALYqZ9mM611vq8k5m33Wx1PCw5WrfNNV9xOvrXef6YK2V+zinw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fb0f8a-ed37-48bf-3a32-08dc7b44f402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bStTaGgxbDZia01jR0k5eUJZbWxISCtzT1RWaHV3WHN0OGJpdXBERXc5WGZZ?=
 =?utf-8?B?YnBZSHFaaC9EdmJnNlFtQ2FwSDNVZE1EV0w0QUd0bWNPSEFRWFE0QmZiQU9k?=
 =?utf-8?B?WkJkSEFudmhmNEZrcy9oMm5CUURZMXBERnMyakVOZGh0S1BFcGRqekwyM0RX?=
 =?utf-8?B?WC9hZlUzbWtrekdNQ1pneEZZem9nUDJQMFFDTkxZWFE0SWo1VWE2S01EeXNV?=
 =?utf-8?B?djQ2cWpVNzJ1Qjcra1B2V2RmMDV6SFI5aVpuZHVxa3RTSmZjbjFXc25MWUl5?=
 =?utf-8?B?Y2VxMVc1V0orWjhYcTFBZnlJQVpHTDBMd2pIUkwvbkZjZXdiN0U0WEFIWUFh?=
 =?utf-8?B?aXMyOEFoaGRBVzdjMGxvMWRyZzdacTJvWVFLdVpsbllDVUJ4eDhjUk9GVlBN?=
 =?utf-8?B?Qk9HN3lLcnJPZ3A4STR3eXZKOEVvVHlqRU53blo3dCtYYjJKdWNFaTUvSkpz?=
 =?utf-8?B?ZHBxQUhiMGZIdnFKNDNYUE8xTW8rQ2ZYNzFCYkdWWmZqb2dUcUlJUEd6R2U5?=
 =?utf-8?B?NkZNYUdzcGJHY3FoelNFRkxMWGZRQ0p2ZEppamw1Qmg2N3hDWVdCSSt5RGJS?=
 =?utf-8?B?dVQ2OU82NW82NEoxSGh6KzQxWHdBclpVMlcxUWV2VFJVRnZQazZOYzd5Nlg2?=
 =?utf-8?B?RVVmSnlUVmNkcEVjSHFUWS9HaCtqWFA2Nld3RSt6bHZJS0JMeE1IVHhRcCtH?=
 =?utf-8?B?azZBalFvMTVqN3JRUFM3M3NvWDYzcS9XL1lFbWRQWlRvb2l5a0xhQU92RFFv?=
 =?utf-8?B?TThWdk9FM2poRHBRYWYxdE1kWWpsU2ZlVDJyREVZdjhUbWtBMzRkNlphT2x4?=
 =?utf-8?B?dzN0QkQzbDkreFFPU0VyZTgwWDNLWi9sKzVMV3hhSFRnMmJQMjFQaE9RWGo5?=
 =?utf-8?B?eUQ5d2RPNU9NZE5GRi80WjB6ZHptMDZ0eUM0ZndhZHBET0Vidk9BQ3ZCaWs2?=
 =?utf-8?B?Y3JENklqTU1NcEJnTVhyME9mYUtYYURsQ25rWUYxVFhLSWZKeDdRbFpUNElv?=
 =?utf-8?B?Wjc3R0RWbmpSZy9SaDg2M1hFOTRDL243dEJPbTJUa1BrQVMwZTdEMVhoTllU?=
 =?utf-8?B?dHFFaUlZUjV4LysxcnNLUTRxbVZtV3Qrems0dEFNbWFNOTZjdC9JV2tZUytI?=
 =?utf-8?B?Q3dXb2NVSGtJTWVBMFpGdkZ3azNvaVpXSFpSTUpheTVVaEY5SGttMEkxM0lx?=
 =?utf-8?B?b08rZHFtK1l6UTl6ckJpdnhqNWRjSlpiWG5FY0F1dlh1eDdXKy9DeTBNSW5D?=
 =?utf-8?B?RjhKMlMvQUVCeVovREM3WUVjTTcrRkRwTjlXeWZsQjRoUjJvaERWaXRtRFhn?=
 =?utf-8?B?Vk9nNmFXYUtwWUlGYWZQTnQrQ1F2RUJLSU5HTzkxRDQ5ay9DUlhuTTlHcXJw?=
 =?utf-8?B?a0sxTGJ5R0JYaXpkUFF5dmZHdHZjbVc2b2Z0VVRRR2xJZElTY0VFUGF5M3d3?=
 =?utf-8?B?SFVvV2hsZk4wZmtEcmxWYXBUcU5yZGs3Q3drSHdsdUN6VkN5QkY2dGFFTnox?=
 =?utf-8?B?cTVDM2MvTVFvbWMybkRYSkp5SjNRWW1Dcy9OUDkyV0RLV1ZsVTcxblZyd2dC?=
 =?utf-8?B?bDZIRHozaW5PSU5KaUNVY2FaaUZvUll2M3VkU2d6MGoyLysrNHRlSDQrdkdZ?=
 =?utf-8?B?azZGdzU4MVUzUlNrQVhzL3hrMFhnUUJZb1RoNklhR0pJazhPcTdHWDlmd1Rq?=
 =?utf-8?B?cVY2YU91QXhrOGlpaTZ2N3QrWExyV2JrbVl0QWlTNGJtN1BmcE9PL041YVJQ?=
 =?utf-8?B?bTVPcTh5eXRjQXlaYVhsaEY4UVZZUHFaY3NwaHJyT1dwSGdOaHdVWHc2Mk92?=
 =?utf-8?B?a1V5VGYvRlpBbUR5N3ZOQ3Q2UVpnR2U5VWpyZFQyaTlYaVJDUzJvS3ZPc0Nn?=
 =?utf-8?Q?wgP0nGnUpnk87?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 16:25:26.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fb0f8a-ed37-48bf-3a32-08dc7b44f402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019

Hi Eric,


Are you going to work on a patch to support per desc wb and EOP? I 
understand that you can not verify EOP with your hardware. And I think 
at least the code should be ready for that.


Thanks,

Lizhi

On 5/23/24 08:54, Eric Debief wrote:
> Hi,
>
> In order to correct a DMAR NO_PASID Error when IO_MMU is enabled with
> the C2H XDMA's channels in STREAM Mode, I added an initial support of
> the STREAM Mode in the XDMAdriver.
> The error is due to the missing C2H write back structure. So it is now
> allocated for C2H channel working in stream mode.
>
> This is an initial support as it doesn't handle the End of Packet
> condition occurring when the Card closes the stream. In my use, the
> card never closes the stream, so I can't test it.
>
> Hope this helps,
> Regards,
> Eric.
>
> =============================================
>  From ffe05a12ee7d9e9450f24deb54c2b5b901a5eebb Mon Sep 17 00:00:00 2001
> From: Eric DEBIEF <debief@digigram.com>
> Date: Thu, 23 May 2024 17:21:23 +0200
> Subject: XDMA stream mode initial support.
>
> If the Channel is in STREAM Mode, a C2H Write back
> structure is allocated and used.
> This is an initial support as the write back is allocated
> even if the feature is disabled for the Channel.
> The End of Packet condition is not handled yet.
> So, the stream CAN only be correctly closed
> by the host and not the XDMA.
>
> Signed-off-by: Eric DEBIEF <debief@digigram.com>
> ---
>   drivers/dma/xilinx/xdma-regs.h |  5 +++
>   drivers/dma/xilinx/xdma.c      | 64 +++++++++++++++++++++++++++++++---
>   2 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6ad08878e938..780ac3c9d34d 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -95,6 +95,11 @@ struct xdma_hw_desc {
>   #define XDMA_CHAN_CHECK_TARGET(id, target)        \
>       (((u32)(id) >> 16) == XDMA_CHAN_MAGIC + (target))
>
> +/* macro about channel's interface mode */
> +#define XDMA_CHAN_ID_STREAM_BIT        BIT(15)
> +#define XDMA_CHAN_IN_STREAM_MODE(id)    \
> +    (((u32)(id) & XDMA_CHAN_ID_STREAM_BIT) != 0)
> +
>   /* bits of the channel control register */
>   #define CHAN_CTRL_RUN_STOP            BIT(0)
>   #define CHAN_CTRL_IE_DESC_STOPPED        BIT(1)
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index e2c3f629681e..c2a56f8ff1ac 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -51,6 +51,20 @@ struct xdma_desc_block {
>       dma_addr_t    dma_addr;
>   };
>
> +/**
> + * struct xdma_c2h_stream_write_back  - Write back block , written by the XDMA.
> + * @magic_status_bit : magic (0x52B4) once written
> + * @length: effective transfer length (in bytes)
> + * @PADDING to be aligned on 32 bytes
> + * @associated dma address
> + */
> +struct xdma_c2h_stream_write_back {
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
> + * @c2h_wback : Meta data write back only for C2H channels in stream mode
> +
>    */
>   struct xdma_chan {
>       struct virt_dma_chan        vchan;
> @@ -73,6 +89,8 @@ struct xdma_chan {
>       u32                irq;
>       struct completion        last_interrupt;
>       bool                stop_requested;
> +    bool                stream_mode;
> +    struct xdma_c2h_stream_write_back *c2h_wback;
>   };
>
>   /**
> @@ -472,6 +490,8 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
>           xchan->base = base + i * XDMA_CHAN_STRIDE;
>           xchan->dir = dir;
>           xchan->stop_requested = false;
> +        xchan->stream_mode = XDMA_CHAN_IN_STREAM_MODE(identifier);
> +        xchan->c2h_wback = NULL;
>           init_completion(&xchan->last_interrupt);
>
>           ret = xdma_channel_init(xchan);
> @@ -480,6 +500,11 @@ static int xdma_alloc_channels(struct xdma_device *xdev,
>           xchan->vchan.desc_free = xdma_free_desc;
>           vchan_init(&xchan->vchan, &xdev->dma_dev);
>
> +        dev_dbg(&xdev->pdev->dev, "configured channel %s[%d] in %s Interface",
> +            (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H",
> +            j,
> +            (xchan->stream_mode == false) ? "Memory Mapped" : "Stream");
> +
>           j++;
>       }
>
> @@ -628,7 +653,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
>           src = &addr;
>           dst = &dev_addr;
>       } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
>           src = &dev_addr;
>           dst = &addr;
>       }
> @@ -705,7 +731,8 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t address,
>           src = &addr;
>           dst = &dev_addr;
>       } else {
> -        dev_addr = xdma_chan->cfg.src_addr;
> +        dev_addr = xdma_chan->cfg.src_addr ?
> +            xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
>           src = &dev_addr;
>           dst = &addr;
>       }
> @@ -801,8 +828,16 @@ static int xdma_device_config(struct dma_chan *chan,
>   static void xdma_free_chan_resources(struct dma_chan *chan)
>   {
>       struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +    struct xdma_device *xdev = xdma_chan->xdev_hdl;
> +    struct device *dev = xdev->dma_dev.dev;
>
>       vchan_free_chan_resources(&xdma_chan->vchan);
> +    if (xdma_chan->c2h_wback != NULL) {
> +        dev_dbg(dev, "Free C2H write back: %p", xdma_chan->c2h_wback);
> +        dma_pool_free(xdma_chan->desc_pool,
> +                    xdma_chan->c2h_wback,
> +                xdma_chan->c2h_wback->dma_addr);
> +    }
>       dma_pool_destroy(xdma_chan->desc_pool);
>       xdma_chan->desc_pool = NULL;
>   }
> @@ -816,6 +851,7 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>       struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>       struct xdma_device *xdev = xdma_chan->xdev_hdl;
>       struct device *dev = xdev->dma_dev.dev;
> +    dma_addr_t c2h_wback_addr;
>
>       while (dev && !dev_is_pci(dev))
>           dev = dev->parent;
> @@ -824,13 +860,33 @@ static int xdma_alloc_chan_resources(struct
> dma_chan *chan)
>           return -EINVAL;
>       }
>
> -    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
> XDMA_DESC_BLOCK_SIZE,
> -                           XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
> +    //Allocate the pool WITH the C2H write back
> +    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> +                dev,
> +                XDMA_DESC_BLOCK_SIZE +
> +                    sizeof(struct xdma_c2h_stream_write_back),
> +                XDMA_DESC_BLOCK_ALIGN,
> +                XDMA_DESC_BLOCK_BOUNDARY);
>       if (!xdma_chan->desc_pool) {
>           xdma_err(xdev, "unable to allocate descriptor pool");
>           return -ENOMEM;
>       }
>
> +    /* Allocate the C2H write back out of the pool in streaming mode only*/
> +    if ((xdma_chan->dir == DMA_DEV_TO_MEM) &&
> +        (xdma_chan->stream_mode == true)) {
> +        xdma_chan->c2h_wback = dma_pool_alloc(xdma_chan->desc_pool,
> +                              GFP_NOWAIT,
> +                              &c2h_wback_addr);
> +        if (!xdma_chan->c2h_wback) {
> +            xdma_err(xdev, "unable to allocate C2H write back block");
> +            return -ENOMEM;
> +        }
> +        xdma_chan->c2h_wback->dma_addr = c2h_wback_addr;
> +        dev_dbg(dev, "Allocate C2H write back: %p", xdma_chan->c2h_wback);
> +    }
> +
> +
>       return 0;
>   }
>

