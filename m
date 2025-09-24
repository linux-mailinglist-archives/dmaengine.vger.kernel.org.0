Return-Path: <dmaengine+bounces-6701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9FB9AE9C
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DF1B27F52
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754BB313522;
	Wed, 24 Sep 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzds492R"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72E2848A9;
	Wed, 24 Sep 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732480; cv=fail; b=kku2QmxrA28v0wx8nYWsj9KcvGT0yyM6MgjWi04YRFzABWi6wEBRhbkYpBSzroIZhsYj9AnnJPDqbUQhCYVq4hnHmHau5XjMtfl5tFbBlfeWwPEmNmFX4ANwMIyEkOOVzIMBYZhNVg7Vn3m0IWGAcsN2XEUQWrJrrRBwemYfHyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732480; c=relaxed/simple;
	bh=Ioxrm7ze/4gMcac3YRZBai1ckywjcL+ZzTNIRHztFkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L8ugnDssNFhVFWD3EVClEY7z4JPvttraasT6v7bGrZ76DmrtazKtjxRb3oONsHIG2vlLRTSQil/UHeMMoa4ExjARE9A7CUM68cz3G33tzFqCkb3+pWU7WWj+i8YIVw4YfxmzmYZtKLBLDl3tk0Uq6wpN4o9Cf0veYL8wYgeCOSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzds492R; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKbUTQ8EqKa/MXii+1SWGifDMok2ZKudLmkcp3OPyqM08Bgz09/kKAsXOXZWAfSl6HAnOq1PaSZAf1wfEXBOui3CRgyS+XtvK9Sj78Ov5KdWJkjBt92x6rKvvnZsnUxsCXi1fifxZmctJ1lKbJXtLpAPN6cPwWgaF3x3stYfJ2aIp4XOZYbovI3lTwZdWBigTFyBnEUJMJQWxHaYsjIyObhVnws9zQbP01FtPswLyDlMrbdGjvoRf19VmySvFYYx2+K00druAWwh+hOhfwFQQBoY8zS8CtyCmMEqH1mWfk4RFCXhzkhOVBwXI19z5JHYRLd3vVJ2im9Y0ME52pmYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN4FHxaE/2q+2Xoj6uOnrPGiZEXt84RZFqv1rfZXayg=;
 b=jjWak2+qEqDcaT+V3rqEACZ/Xb0tI/40ho7wxaDXh3z6B2o4HXs+VAVV2hsTvX784qnqjegf9HsXWIp44Fo9vvsNA3/CWtXFD7Mg+Gzk/3+uxDK8NIb4XgsgSjZRaFh6aX40LzVEBV6xNViRg+b8kjdlfpsvGm4ApPK2/YF/It/ajkHg92dthilmaU6Ijhm64YV2V6DWhracUi1uPpDwzHlMobVqCHJD1Wl9SEPVPK8fd1ggmqSeJ8nmhmMA5CPc07GJXxV5ghdO04mCpyQYvW6nhgCcvYZXaXPXypd6BzIWyl2sGPwgRqs1+y+3vwzRIHWVD3W4KXQnx8Yzlm8ZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN4FHxaE/2q+2Xoj6uOnrPGiZEXt84RZFqv1rfZXayg=;
 b=yzds492Rom44uSp9hvhWDluq0sk0aaU1ZCHe2Md1r9qQ2xW1wQr2oOGmhoUEiWn7pEpT6/yKFxo/l1HJg/OoaSuibz3rCvXlib+bv5xlRAckgT6f0cGivL1zEL7oWDL5PaOKsLNwY+fd5+X+Oq5x3BZ/S8Rwla2Gfs+PmtdKkFE=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:47:53 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::84) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 16:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 24 Sep 2025 16:47:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 09:47:51 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 09:47:51 -0700
Message-ID: <bee82ccd-9cd6-295f-839d-b17228212bc4@amd.com>
Date: Wed, 24 Sep 2025 09:47:45 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap's max_register
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Brian Xu
	<brian.xu@amd.com>, Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, "Vinod
 Koul" <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, Sonal Santan
	<sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250924125941.742020-1-alexander.stein@ew.tq-group.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250924125941.742020-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: dff4cbd8-a4d1-410b-245c-08ddfb8a1aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi9WS1RVTlRZQ09ZL2NSTkNhejROQ3Z5UzlIQXhVd1REbFM5cjE3YTBHY000?=
 =?utf-8?B?WHFVNzlVVGNIWlVpeGYyZlN0cWVGejBtb1lPdkRPUzB0SlZGVTFFL2NwUkxU?=
 =?utf-8?B?aHFBOEhKQTJ3cUhyTVBVS2I1eXJGOG1ZWkVlcUt1WkZiaGc4RWNGVWcrVW1D?=
 =?utf-8?B?Q1NIRjJFbnJYdUt2WDlEUi9qcEgyOWloZ0Zac2EvSEdGd2s2OFc0akJwRjZU?=
 =?utf-8?B?aS9ZSWlRWTlOZEExQjd2cTBtME5HZFhIS3lNUUpJTXJvNEd5bjdSSU9Qb0Nq?=
 =?utf-8?B?QmIvTHpmaWhZb3gwVHVBcjNkRkpHc1J5WlR3bk9Fc1ppVVMxdDI5cUU3cVlZ?=
 =?utf-8?B?QWx6RnViVFlWeHh0ZXhWYkRBcS8zTWhKUWtvdFhMRjF3ZUJReCtBeUUxS1Jp?=
 =?utf-8?B?M2pFdGcyOHhTb2dVdGlOVVNnd2h0MmNPdzlUUWgyS3pteEhjQnBhZ20vYVAw?=
 =?utf-8?B?aGQyWE1FT0laNkdwVkM3d0FHdGhUYjJKRmx6YnptUzRzajZhc0FuMEwwYVRJ?=
 =?utf-8?B?ZE8rK1VZWVJNU25RL0VlU0IrejBCQk81SWJBcUtNZTVEMVdlUHNTQ3pLbkNV?=
 =?utf-8?B?d21nZXVLOHRQaVRHSVZpQnlTamxUTkE2VkVzM1lzbE9QcE9NYmhJTkVoNkQr?=
 =?utf-8?B?SlNkdWU1OWI1ZS9PQzNqMXdqcDJ0ZkNUUWt3Vk9BMFE3NkQzV2ZiUSthRXhP?=
 =?utf-8?B?aUlzZFJkMmdWRUQ4WXlWQ01QMC9LWmJMa2xiY2loWURqeXQzZk1tTEViZldZ?=
 =?utf-8?B?L2JSZWIrakljblBhZXd0M0NlZEV6RStMd0pKWFliUU4wZWI5aUhPa0Q2azEy?=
 =?utf-8?B?ZzhrRXEvQzd4blZkdHVOdHc3MG9sYmZyanhXeGhhYlJNbEE4dmJhU2M5SWtP?=
 =?utf-8?B?TmwrTjdSZEtaT2crc2tpU1p3aGxMQnZVMkR4VGplcFRvNTBuWGJ2bFFEUENX?=
 =?utf-8?B?bFludnhFMHhNeGk0aFRXVWxDUGQ0OUw4MXZQNDArOTVvRVZXUUdFeUxxTjI3?=
 =?utf-8?B?SVdzclBYckpSRVpaTk12RGIwL1AxbDFTQVdBNjQ1M3hqRis2amZUbSt6aENx?=
 =?utf-8?B?ZGpxZHYyeisxYS9CSDIvallpem5tL2xmNHRrWHo3aTZEMXF0NTllbW9EZm1L?=
 =?utf-8?B?OVJiSEhFRU1GUEdHblFtUWpxS0t6akhlZlFOa0JSM1lHNzZIcFlRTFVYaUFa?=
 =?utf-8?B?TzJhSWdYWGV5ZzhTaEdLNWVYa0NPcnF3cjF5MVFCNEg3ckRpUm96NWFOK1ky?=
 =?utf-8?B?TjFIYVpIZm5Nb1I3T25sb25YdW9TWERUS0xhSEtJemJuelFQU0Y5NHVmbXpS?=
 =?utf-8?B?alBsdytMZXBUS0ZhbFpDZjEwTGJ5VkFTYVR4czJVMzRCWG40d1VZc0lCQnFs?=
 =?utf-8?B?UlNhWDcvTHJjeHZSODMwWXJ5c0Z1WEx0MlphRGYxSlRvV2I0RXV2NTA2VDR5?=
 =?utf-8?B?L0ltYVRRTWx4dVMyeEMxbWU5VTB4cEhVbi9iNlA2Rnk3WWV2WmVQdFJTWklp?=
 =?utf-8?B?ckhJYWpETnBnY20xMkMzamw1TmxyRmJPejlLMU4rRWRvNnYrS1dGQlRFekpQ?=
 =?utf-8?B?R291RXFmRjgyVzE3VWRMM204Q3c5SC9zUXhKZUY5ZEhKa254bFBLVVprVlph?=
 =?utf-8?B?TXVPSU8rUVVydXkydjQyaFluL3U0NXdoNXZRUDg4bWcxZERnaFZwNmJhY08y?=
 =?utf-8?B?c2c4bVd5Y3VLRy9lbS93akVvQUhRM3B1VlFMQ3BNTCtxd3lDVElodVVqSFZW?=
 =?utf-8?B?bUtVREVTbk42SVE0YzJjR1NkVUN6YmZSUDZPN0pUek80VnVNWXNselJzZnc5?=
 =?utf-8?B?TFo5ZWNzM09UOEdMWlFZblNUQzhuVEtHUGF4L1N4bG16VEtldEVuVXZFcElY?=
 =?utf-8?B?Rlhha2YrOWlVcW8yU01xS0tNVzNPcU52NkRNYVBBRkcrUngvU0tFdXgya0dU?=
 =?utf-8?B?S2c2R094Wk5CVkVLUjNGY1M1UHp6MTJIR1ExKzJGUXZoMzhvRFJQeGl6bzNP?=
 =?utf-8?B?VFhGSmFIcU5Wa0VvWU9xVlppamF5aGtwQ1VGZXJFVzB1SE5NNk9jN3FPdVNM?=
 =?utf-8?B?eDl1Slhyb2pkazF6OWw5REcvSjhmQkFvUTFhdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:47:52.6865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff4cbd8-a4d1-410b-245c-08ddfb8a1aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562

There is a patch for this.

https://lore.kernel.org/dmaengine/20250903-xdma-max-reg-v4-1-894721175025@amarulasolutions.com/


Thanks,
Lizhi
On 9/24/25 05:59, Alexander Stein wrote:
> max_register specifies the last valid register address. As the BAR is only
> 64kiB in size, 65536 aka 0x10000 is too big. Restrict the XDMA register
> space to be actually 64kiB.
>
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   drivers/dma/xilinx/xdma-regs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6ad08878e9386..c6ef198ef7627 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -8,7 +8,7 @@
>   #define __DMA_XDMA_REGS_H
>   
>   /* The length of register space exposed to host */
> -#define XDMA_REG_SPACE_LEN	65536
> +#define XDMA_REG_SPACE_LEN	0xffff
>   
>   /*
>    * maximum number of DMA channels for each direction:

