Return-Path: <dmaengine+bounces-6333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3BB40AE0
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C423A72CF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35272765E3;
	Tue,  2 Sep 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wg8dBJfF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7542E0922;
	Tue,  2 Sep 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831378; cv=fail; b=d7+F0DKAU9vospXJOszWCPeIGs67XO9Z6cbmnCrlPTXvp6Wq7a06glNWBPV55QvZkbGvlHmxPD+ND2wpkHh/N5wZOqzPwsyPcDfkpeS1XMJ3rD7ViV4TNDlL2wWKS6Ms2d+rhrb8PH77mbAOlv/kag+TvA1BQO8WcCFuMAr562A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831378; c=relaxed/simple;
	bh=dREZtTlr/Txl96Al4uaDTaumZH0avMgaoqSl0khBMJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pfC8Ej+71dy1qp0JgV8yyiapnioL0VS2VIqqkjxQn4y0V+paJLJ8VPtdQdLp6v55Z3RxOgceYuglRzn1zZiRDugeD3lFKLYaEI1UwKG2fksIVlRipQ4syoD1EuQDcnssXa8qQvn5UpAhY4Ry/dTAR+I+/6PFL4YktuuIoudwwzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wg8dBJfF; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm/WarTe8VhCIU+EeVOTS4ofL26q9Zr/1mbsny74LA5h6br+x77Y/s/As5r6YMoQ9ubBASDxRLCWMs8wo5iH80QZiukmFwikQysBq1bgIMwBz09nFxKUoNirrwEf5cuXEaLAon65UrcqGL3WLwZYGnEG9abmyAklqGGPOA7ATaKaWTxLW+ngeFZccZ1uWldBayZlOeXqWlLSOU/bPkUhGcygbdkxKD6eqEnrVOPjpFvutJ7VEU3ruQJoSZSjr07ORB4EivGQLhm650oXPPRdAZTvhlpqsAw+Co3TjQBLRjp3NnfYFGYSRnUMBrCIDeYS3Sy/dOjsMKqScCqd0TM2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ZPk7pHhe9CS5wxuHRIkvDpa/m/8S6/lQZG225TEss=;
 b=FjfwWzvxgWG6SQfI7/zE9ox1qNmLEF1sI9lVZxjDH+7AzgE3QjizVMdnDgWtSW5mDrZ0cnZtKpjWKEZBechFyC/q3Ls+wZs0Lp/d4FMpLdvifaIGe6HpzJZ7VYWgqT0/wFXoAQlHMtLk1qTmeH3dJ9mALiovWb4zCQKFxxLProHlps3QgfVLN2XSH0K3Envph+HrTY4zCDcYRa42WRUDPzn3jP2t9IKkxJQVYEWcERUsWFYNjtAQx7FW7TFFuZTIA9LLnC1sqFXY4LsNH5PYfKzHpHE878G7q/mYnSqlrY+yQkqCa1qa6dokYW/9M0YKbm2+P6JNWBwTntrCmsy7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ZPk7pHhe9CS5wxuHRIkvDpa/m/8S6/lQZG225TEss=;
 b=Wg8dBJfFtv1gFCcnRFbm8iwVWovYQUtzlAZA86WkylRBzY/ZRnrVIU+lwmgg1lZSBwAhtBZNgBlJ4aA4sH8Pn3ftB8hosSyw3QppEmDkRH286qONwN3K4/OW3AsZCBlzJ4QM23yqEgC8OVRpSV048y0GK1231B8H7EaACTT8TOA=
Received: from CH2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:610:58::14)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 16:42:53 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::af) by CH2PR20CA0004.outlook.office365.com
 (2603:10b6:610:58::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.29 via Frontend Transport; Tue,
 2 Sep 2025 16:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Tue, 2 Sep 2025 16:42:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 11:42:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 09:42:52 -0700
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 11:42:52 -0500
Message-ID: <423ef4b3-d92b-8833-e21e-88ac4153c87e@amd.com>
Date: Tue, 2 Sep 2025 09:42:51 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix regmap max_register
Content-Language: en-US
To: <anthony@amarulasolutions.com>, Brian Xu <brian.xu@amd.com>, "Raj Kumar
 Rampelli" <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>, Michal
 Simek <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250901-xdma-max-reg-v2-1-fa3723a718cd@amarulasolutions.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250901-xdma-max-reg-v2-1-fa3723a718cd@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 2141bff9-cb01-4e1c-1823-08ddea3fc32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTFLdW5Tb3NRYmJQeWpPRi92RFVOKzJ3ZWwvVTBaaVNjT05PVUdWTjlJUVhj?=
 =?utf-8?B?VlptSVBaRC9sYlFXaUpVVzZHTklvaEZCY213R0dDUjJ3M0VLSmVHdW10MjZr?=
 =?utf-8?B?UjlQZmRlTXdiSVlQY3czOWtQRXhHZnZFakRFcUJ0S08weGUvdmpFTXVpNjNL?=
 =?utf-8?B?eWVWMFR1NVRPRlJRck1uOVJuVHlBeU5aZVBwTjkyUFY4SG94WnpvVHQ1eGJ0?=
 =?utf-8?B?YWlSSEd5YnQxVzFTMld5aWg0ZGJNTGJnanVGVzFWb2RjdHJQVzE3aldxUE5E?=
 =?utf-8?B?cjBPL1JGNmZHbkhkQmU1Ylk2bDZPbTJjdzJzOC9iTnR5T3pMRSt4c3ErSExE?=
 =?utf-8?B?WTQ1TkNnekJ2dWNWTVBSYW5jSEt0MHNVZE9nNHpIVEFuYUlVQVVDSG9mZ2Nr?=
 =?utf-8?B?QnBibXZBQ2V5cnZsMnI5WG5LdW05TWZQUDZ5OTVIbXpTdXlQVFFlczJVQXRv?=
 =?utf-8?B?UmZXQzVWK2MvaGVEbVJ2cnQ5OVNJWkU2QmIyVkF6LzFQeU9kTW45cnZCWmdo?=
 =?utf-8?B?MnlyaHJiK0pXYnpZeWZhNGJ6dWpSK0t5OEFtWStEM0NhTU5wNEVNUmxHV1Rq?=
 =?utf-8?B?MlZ0M3FjRTU3dUl6M0NRQUZ4V1dibmxnUlAwZmpuQmQwdWd6VkJMTy9vLzkx?=
 =?utf-8?B?MVBUUnE5NGxYTzVjc01KcUZhVXBVYkxiWml0UE5RN0M2WXJDclRsbVdEeGZu?=
 =?utf-8?B?MHJTZm4vTk9naFZIbEM3aVhLN2RLSEwxMGZXZFBZaFU4eGtEVUltNDNOdmRE?=
 =?utf-8?B?b0YvaS9uVlVMYmw0UndQbzF0YkpKWFoyZ1VQUGhmWW93RlkrakQ4NDZlTXF4?=
 =?utf-8?B?TU9WVzQvTU16YUdNd3FXUFR5dWZ1bWFWcG43dTIrNjBVR3pnRStBTmw2VkVj?=
 =?utf-8?B?a0t3SUlSY3V3UW5nZDkwU3NsL0RKVjdWSlFnN0hvSWlheEJ4cHNMSFJBejdI?=
 =?utf-8?B?VEtFR2xScGwwRmZtSFJMNDdCN2JhMVFDN1pUVXhsUSsxVkNZZFhtcW1mUysz?=
 =?utf-8?B?a2lGTXdDbUc0VkNhSHdiQVhEUkNKZXJoOTRQWmZMS3BiOGw2T01FSVBYcE13?=
 =?utf-8?B?Y2lwSTV0NWl3UFRrZTcveHg0K2I0VlA0VW5iN3NzdXpTOU5BNlgvS2s2OG90?=
 =?utf-8?B?S2NvNVVJM2QrYU5raDNEWk5QMUZQNkVPblk3ZkhQZXA2TU5RemIzUnFjb1M3?=
 =?utf-8?B?dWZCeFZLMFd3SjhXaTM0bFZ1WlFQYk5Db3p6R3p3K3kwM0tJRFBQVnI0c1My?=
 =?utf-8?B?RFRnRXMweVhJQndRUThkQ0dMRXdmT1hNSG9BK3hBaWVkN3JJMFFOSVRHUVc5?=
 =?utf-8?B?S3RxUi96L1oxZ2p3Y1BVTGhHZ3UvU1k5OG9jZWdyTzMxSDZSdXZ0UytwNnJ6?=
 =?utf-8?B?TTUrVTNia2Z5TVRBclE4SHdIQUVkNGpDZk4wU3ZqMVZvRjJoSUtsLzVkSk81?=
 =?utf-8?B?R3gxYURtNnVjMldycnlqakZCZEhJSHlGdnVFWnE2bVlDSW1PQ2oySlBKVE11?=
 =?utf-8?B?UzZUOXc5VGsxRVpjRk94ZmloOXJrekh1a3pwM1JKejhTbGEwOHdFSEdXNVph?=
 =?utf-8?B?ekIvSytPVjcvdjVwSVplaVhmM215L1ZqSHBiMCtYMWtyMmxEOW5pdDN0M1FI?=
 =?utf-8?B?anBtLytKWjdGclRyeWVLU1lhSUtOd0lNQjJtTHVEbk9uOGZiZWwyMDRSR3Js?=
 =?utf-8?B?ZGRHZ3lDYVF3UWhkZjh1OWEwTjhySmJmSmdZZjZXd1hPbW0rcG1qQmlMbGlF?=
 =?utf-8?B?TWpXWXB5emNRVCsvUDd4dEhReXpxTFliQXNaMExKNVc4MmxCZWdPQ0w1b1Z6?=
 =?utf-8?B?Rmh6TjhxR2RzUTcxT0ltUXZ3U1NwZmZBZnkzclY1VzBxamFlcVYySXpCVFJx?=
 =?utf-8?B?VGhMSlpCV2N1bGxJSnJWeVdyN21lTzJQWXRVdkVtZWcxMHB4L1RUYjMzSjV2?=
 =?utf-8?B?YlhuNTdEaDBJbWtzYjlzWklwenJZL011S2lvb2hNcEJZZ2RUaUhGTEo1UU9v?=
 =?utf-8?B?dDA1Sm1CY3dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:42:53.4407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141bff9-cb01-4e1c-1823-08ddea3fc32f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

On 9/1/25 14:30, Anthony Brandon via B4 Relay wrote:
> From: Anthony Brandon <anthony@amarulasolutions.com>
>
> The max_register field is assigned the size of the register memory
> region instead of the offset of the last register.
> The result is that reading from the regmap via debugfs can cause
> a segmentation fault:
>
> tail /sys/kernel/debug/regmap/xdma.1.auto/registers
> Unable to handle kernel paging request at virtual address ffff800082f70000
> Mem abort info:
>    ESR = 0x0000000096000007
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x07: level 3 translation fault
> [...]
> Call trace:
>   regmap_mmio_read32le+0x10/0x30
>   _regmap_bus_reg_read+0x74/0xc0
>   _regmap_read+0x68/0x198
>   regmap_read+0x54/0x88
>   regmap_read_debugfs+0x140/0x380
>   regmap_map_read_file+0x30/0x48
>   full_proxy_read+0x68/0xc8
>   vfs_read+0xcc/0x310
>   ksys_read+0x7c/0x120
>   __arm64_sys_read+0x24/0x40
>   invoke_syscall.constprop.0+0x64/0x108
>   do_el0_svc+0xb0/0xd8
>   el0_svc+0x38/0x130
>   el0t_64_sync_handler+0x120/0x138
>   el0t_64_sync+0x194/0x198
> Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
> ---[ end trace 0000000000000000 ]---
> note: tail[1217] exited with irqs disabled
> note: tail[1217] exited with preempt_count 1
> Segmentation fault
>
> Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
> ---
> Changes in v2:
> - Define new constant XDMA_MAX_REG_OFFSET and use that.
> - Link to v1: https://lore.kernel.org/r/20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com
> ---
>   drivers/dma/xilinx/xdma-regs.h | 1 +
>   drivers/dma/xilinx/xdma.c      | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6ad08878e93862b770febb71b8bc85e66813428e..70bca92621aa41b0367d1e236b3e276344a26320 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -9,6 +9,7 @@
>   
>   /* The length of register space exposed to host */
>   #define XDMA_REG_SPACE_LEN	65536
> +#define XDMA_MAX_REG_OFFSET	(XDMA_REG_SPACE_LEN - 4)
>   
>   /*
>    * maximum number of DMA channels for each direction:
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 0d88b1a670e142dac90d09c515809faa2476a816..5ecf8223c112e468c79ce635398ba393a535b9e0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -38,7 +38,7 @@ static const struct regmap_config xdma_regmap_config = {
>   	.reg_bits = 32,
>   	.val_bits = 32,
>   	.reg_stride = 4,
> -	.max_register = XDMA_REG_SPACE_LEN,
> +	.max_register = XDMA_MAX_REG_OFFSET,
>   };
>   
>   /**
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250901-xdma-max-reg-1649c6459358
>
> Best regards,

