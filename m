Return-Path: <dmaengine+bounces-2916-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8A95756A
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EE4B22968
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EA1DD3B4;
	Mon, 19 Aug 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QAnCbSAt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802D1891D9;
	Mon, 19 Aug 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098310; cv=fail; b=mUolGzUbU9KD67GjwHPSui6sa5wmQU57gpiZL8bCvh3361dFRGjc3vSklnz9Jjy3DXkp7CvVsGoysPCxPOozJZQRnoTDLt2D4x9rf1G/KSoH6/TMRL5HTMXkowjdX3n6/zzCoHTBbk1VejddNKZcN1K4tsi+WpJH9RwseFwFRlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098310; c=relaxed/simple;
	bh=fWggtCUsLPGfk4Kot28wIrSho3TOOl1XcOeaHiAioUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VKxp1S6+ifT5NkvK+Co2Aw5DMgtD//0mRH1YBlneP/icnz77cU6PASdflDspXvuiq29Ox8KuZAalSl4UqwXITXRLwO/pPjQ8/YR6285mqqFMl1CilKeMz/Z1FTdPhhg+vvNwL23aNI+OizITJpZom5ktQXMUN/8nZCG33k6KEII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QAnCbSAt; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR+KFtu2PSEGogC7tc+lgEENcN6m2wFwQnLcw/Zpni1ylbKYkbuPHtbPYpotNV0QjyDPytlYRAoQ0P6x/NTlUs/Sn+6GtfHxZnS75QoIGdRoKl5v9YmEwE0CLNMwu8bQNG/lJFWKFETajm2w+8XQ+aa4Pr2q+7hVn6srKn0nqeGJO5sep6729Yvum9magDJ5tsP0C/FGuQCJuxI2zuEMEu/Vpn3BUYW2UQyujbfDka1B4AbDOWyvU4vahrlI4hx//FCJ1v3kuJTqMtcK39oSQwNSi6tMzlLqWJfuZ46YVe6k3+1rOuJHdlwtGTpY9PhTR5NhXoN/R7A1ZfYyatUlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNBjLhLsXig8GHBoQQ6Ubi3dFtGGvKPwerPNaPkJzbY=;
 b=JjBZg48QChRN6KGiekbj7eR2puEvFcIzGkNlHGkEccgwF1SwLRXCZMxBBhCp9oJcG5uHq6TckIYXUjAilhRspbgLlcACZ2FliEm5V9NQZoro1AxPd17LGHWFo1XL6FE87l0nldap72JoRek4qcjNGZy3iwFs59W+BOTx27p1fAizOawCpY2CbtyddKjVKutWQiW+lkqLDVVDObFyEQlxYxWjXgvoASifVmWjPbLCkG7m2XKVSSVidt/ixY2+xTAw03cBXtiyGedzmzoedvXsWfYJFef6OvzJ9GMtn01qHwCf7DS4PvO7mBSA2JUz2ehMVaFImKtyW3ZXv7MPKOEjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNBjLhLsXig8GHBoQQ6Ubi3dFtGGvKPwerPNaPkJzbY=;
 b=QAnCbSAtxFsg8NYHirkPGKviLaNmO4VeRoYhcwfutwyGwme/HNwtmvKtflMpZM5SVrwMPo6GNMS5wW0PUg2z9TEW3GuRWb8ghu/qISGZ/W+tg5XofcnlQ0rQ5qd7QkQ0KvGBVvn85jbFFQi5XDH6nha3JN1EYJkrcGX39a89Bg4=
Received: from BN9PR03CA0701.namprd03.prod.outlook.com (2603:10b6:408:ef::16)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 20:11:43 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::4b) by BN9PR03CA0701.outlook.office365.com
 (2603:10b6:408:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 20:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 20:11:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 15:11:42 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 Aug 2024 15:11:35 -0500
Message-ID: <040d0e91-1bed-308a-a0fa-96ce4aed7a30@amd.com>
Date: Mon, 19 Aug 2024 13:11:34 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fix IS_ERR() vs NULL bug in
 xdma_probe()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Brian Xu
	<brian.xu@amd.com>, Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, "Vinod
 Koul" <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, Sonal Santan
	<sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>,
	<dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
CC: <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>
References: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5492b391-acdb-4a5a-080d-08dcc08b24f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXRsTXJYTUlsMHVZMnd0SzJuUitia3NmOGwydDc5T0N3cXkzdGJTV2FGMndl?=
 =?utf-8?B?aHVVVW9BUklZa1kzdm9pUVFRaU9FZE1sVTRUK2gybjhpQm1kTlc2NGJIeFV4?=
 =?utf-8?B?MktEKzNqYVZPSFB0dlVXbkpkTStTbTRHZzRhNmd2L3ZyRm5WTUQxTUdWVEIv?=
 =?utf-8?B?YUtyRE1sUE9EWlp3WTBCd2xDSlVETzV2NlJ0ck9aRmlIbDJyTWR1a1IxN0pk?=
 =?utf-8?B?c21Ya3l4ejVtNC9qZk1uRHNuU054NWlJZnN2UWJkWHZYQUFsbGF2SkYzczdu?=
 =?utf-8?B?OG8yclhBUzB0QWVsMGpVL1EwcEpFeDllbWxQWlAzQWhkZ0RsL3d3YWRzZkx0?=
 =?utf-8?B?OC9qSHdyWUhEU2RGZnFsRmdqSElTSG42TE93dkN0VHlNcFRHMXVyNmpJb0d3?=
 =?utf-8?B?Wk1NY2d3NFdHSlZ2ZVFlYUZxWTl2dVg3YXRBUWdrTjQyQUVwYXJBUUVUYXpo?=
 =?utf-8?B?ZmpTVDIzNWpyeTJHbnlKSzByOXdpS0tSdEFnTnowd1kvd3ZMcFU0bmZBNVNn?=
 =?utf-8?B?STF1ekM1cE9OMVJxbytFUWFTRkpaNHArQkowam5jNDF6OWhOd1JkM2trczl2?=
 =?utf-8?B?VTBPVHBKN1hoWEZyQnRtMDFHejd3c2FkTEd5cGlOUFlEaXVpSWNDM2RMRzky?=
 =?utf-8?B?T0I5d01laDRRTnpXV2RzQTBlcXRCZEx3L0Zoc1JKSnM4YUxvR212Slcyc1Ev?=
 =?utf-8?B?bGN1TlFUQUJWQnVQVXl4QmlXQTgwa3hkQlFqVDJJQlYrQzI2RUJGTnZFMEd2?=
 =?utf-8?B?bEhvOFhYamN2ZWp5cUFVNHlmRnhPbmUyOFJWUFJyRFY5TU5xZGhJYkt6R0NC?=
 =?utf-8?B?TEFHNk1layt3WDllNzIzUnZWQlUxckNxN2s4eGZGME90OWtRTFk4Vk42MFRM?=
 =?utf-8?B?cUNMZDdKSnczK0NVMmM5NmNrV1pKRDhPZHgrVVFqNEw2NkpFbzhmalQ1NzFz?=
 =?utf-8?B?UlpuOXUyaHR0ekl6b1B3dFc5RmRyUlhTZjZXeVJ3bkJWWmgwcVM4bmNhQzJM?=
 =?utf-8?B?QW1HdThVRnhQL0lCa3Jid0paMVRnZFdTMmpaUWNqK0RBY1pXRWZ4RWgvZWMw?=
 =?utf-8?B?Qzk0Z0RzZEZENm9tTVFJNzZpV3BqY0VuWkZzWUVBWVlJb2xzSVBkZ1pMY0x6?=
 =?utf-8?B?ZWFzckwyTk0rS3dMVWdvNGlWVVl4V1MwbUhSR2l5bGFOWlRQdk5VbnNQY1FQ?=
 =?utf-8?B?aTRsNnBxME5WQUF6cEwxTFlQVDFoeERPeU1qTjViRkNvUlg1SE1ldGNDY29z?=
 =?utf-8?B?VnlOejAycDh4MkRQNERsN0UrNHFFeWR1eVA0M3hvRTRuZlc0aGpnUjJQUEhW?=
 =?utf-8?B?RkdtanVNeTlUNEZFM0ozQTRvYXJobHYvQ2M2QkJFYzd3UXcyQlhzdjlrK0pi?=
 =?utf-8?B?RHhubjhjUXBhRmlUOUt0R1U3UUY3QityZ1FFMXFCYmlmbkhSN0t1VDJFa3pl?=
 =?utf-8?B?c1pMRWtCQzc0S2VhbmZyNVBkVzM0QlQrNzczNnhmeFJHUUs2WU5rWEJmVjdI?=
 =?utf-8?B?SlB5THpDVTR4R0w5VDhYNFlQaFhKMlZyNFRDUDZ5VkZMZnkvNlQxbWNkaGta?=
 =?utf-8?B?Ujg3bWdQNHl3L24welJ0d2lMQVd5TkJmaDBwZWxTbVUvY2pTMGVkcjhkQ2pp?=
 =?utf-8?B?Ni9ZbnVBZ20zZSthV1dxS1k4UFFWRDBGeVkxWmhXekJwK0JjUkh1L3lBREUv?=
 =?utf-8?B?YitBUUpsZk12SjU1ajRvZU1VUWQ4M0l3UlJIQVNZTXZQVHRwOEphMFdxcFkv?=
 =?utf-8?B?bUVFSTZ5cldPQ1BBd3pDMGpIQzgyeFdhTUpKOCs3bW15QUxBSGZVTmZ0MWhB?=
 =?utf-8?B?ZXBBRjF2N0hjbGVpZ3dGbVFueE1na1pVQ2kzeDcySUlEWnB3blpId0JFMmF0?=
 =?utf-8?B?MXU4V2lPRHgwVEdmMHpXdXZ4SEdOeVNIQy9iY0Y1dmhYSEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:11:43.2273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5492b391-acdb-4a5a-080d-08dcc08b24f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468


It looks a dup of

https://lore.kernel.org/dmaengine/CALYqZ9=pVRtSY=w4hG0R3HEM_Y=bpLba2_jRcvcZX4eLX5Yw-A@mail.gmail.com/


Thanks,

Lizhi

On 8/19/24 12:36, Harshit Mogalapalli wrote:
> devm_regmap_init_mmio() returns error pointers on error, it doesn't
> return NULL. Update the error check.
>
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch, only compile tested.
> ---
>   drivers/dma/xilinx/xdma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 718842fdaf98..44fae351f0a0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)
>   
>   	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
>   					   &xdma_regmap_config);
> -	if (!xdev->rmap) {
> +	if (IS_ERR(xdev->rmap)) {
> +		ret = PTR_ERR(xdev->rmap);
>   		xdma_err(xdev, "config regmap failed: %d", ret);
>   		goto failed;
>   	}

