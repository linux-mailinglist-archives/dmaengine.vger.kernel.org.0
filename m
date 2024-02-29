Return-Path: <dmaengine+bounces-1187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CF86C76E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2811F263A0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7B7A71D;
	Thu, 29 Feb 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aERrXyed"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49E7A706;
	Thu, 29 Feb 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204019; cv=fail; b=f9bSBVgTGWFpq6uJEoyYl4kC4bIQx2vTrnE8vBaR0S2rt+AjAQIaLw0sjYYOtScwB1mdLt7FWGHZFn32beo0nfdB7NK4tqBb1XwCsnIKCvGS7prW2E+gtvPJq3SKuwdQZZml0qENHg78/SXikITc65E5ZhbfFkmAuNRAHcgn0XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204019; c=relaxed/simple;
	bh=vyceub4lE973y0qAWAG4ZKYDEhoVlCW2/8eB2ONuhik=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eK4uHO+A/E09/DwISylDOvwlEgAzAXlmA90US/8MM/kwC9y8cmG8a6ORg5a8+c06VozEjFaNATBI2U2JwAKoa8YOybkowV99G0D/5VLSpEqp53C63Lm8g08xtPCcK8QzDV3mvKY3xW+cJxGF26ghRRmVDHwCwtnNYaFR8y1zTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aERrXyed; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipb5wyg/PCZ6lIZd5ENgRbp31+g0mss9o2NhcIz9B+4eqXy9LNoETjf8igPR2YKXnEm4dY7aI1e8R/ATSl2vrzdc+WFgBoh7nZnjUHG/IihV46l4q7eWrXTyzrsoXwfWEKIv4qsqKtfTPk2v4CxcW/oYx1y9x852/tuJTBK0ErPKQ/DV8eU8zh1YWII9mKvfokmNRVRl0UJLMGKJrN5213F1skSV3zHNk+v2BCsXoxsOxsoh9cmfbqmK5uW1T2gysHmzuCqIkF6rnoiv/1UkLbMgTVNp0RBNnoG/h41UVMGPyeud7VCQFDbskETK7YU9l5jk3DGciZpM/p2JFeMSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U0hJ7CpLPYOegPa5x8Iucie2CNiIqFjY81fdLnY6v8=;
 b=eVqC/QdTU2xUw/8oI75OMPZyDE/qMvf6cUEsSCdK5DePKoWp1GUnY4L8bm0kS9bb5tWMQmzF4dhFNa8BQ7fgS1RejYh5wTFWUWZQ5RVbyWn1hOJ84cFy16E5SM39xpq8M9T4YTrtrj3MQAZTzOJQO2HaX5FvMQw7NnykC6T2/MlhiId8ADXu9sberKaJ58xSOJQ104wFdp9BjYLNCyo5bsLVqb65hmiEsELWr9B/NRbVMEEd+hhy+dXWr/kDXzR/71mf4qwINN6S/bf73vhmyGTs/BL3uNjoX2tZQVfLwwZBMdi9DVkN8ytZVRrsCm3j4BWzukYed5tgTF5e9bf1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U0hJ7CpLPYOegPa5x8Iucie2CNiIqFjY81fdLnY6v8=;
 b=aERrXyedw0PIndMMbgaYA5EjiHq+0kGkjFYbbCgksuBFcygorufCffK+8KlEibwZ23h9jYDvUpPovBEX3L9kHLV9ffP8MqHm71WIDGzCfH2e5oO5OkJkfZfXoZF7+Rfu/XXw5bIBcFD59RTedg26U5Esf8/FhG+MCLfyPw94NQdsmgiz2pougUgP4CeuS9TUz/X2eqjUkScwuYJDbzIOOkgHouV+jXEXljoRgxXw45mgWXVa1FwZ0H65dpzEL0AFNz6Q/GA+ymfcHrVaEAroIHH17MHy/gYlGOz6XsYlx3sIDkd6BsMlpXYHomzsnSYHjlqOBJU77mqPY+qfc36LzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 10:53:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 10:53:33 +0000
Message-ID: <b5bdc455-c0f2-409f-85fb-046ee0406467@nvidia.com>
Date: Thu, 29 Feb 2024 10:53:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: tegra186: Fix residual calculation
Content-Language: en-US
To: Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com, vkoul@kernel.org,
 thierry.reding@gmail.com, digetx@gmail.com, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229065223.7295-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240229065223.7295-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4125689d-9139-4e2b-8aee-08dc3914ac41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePI/d+GxgjGlBpu0+BfuJHcWyvR/WP+Y41BSzkTn6IYZz4zw0fg0/MISDm3nWzmf1RJvI57RuJ+ampUe6SBCiNH8s51IjLPMXqIAOHixsJh+5/C5aPNeem66JernUSjnXNnM59stZ4PVoYzkjWYQacQDf4LiGu5zVlkxpHCfQtgBJRQ9LrMs4o2tJt8Yy4wsjbtjCcwN6IifvsxKth2AAWgwEFIOQv1MpSNL+XfYy8TpnZ9uv2J4eL/r42qmtz7rduX1Zw8310vFYSWCPMWMiP/CklvXC+QhegSrhh351SfS1lbNimx1PYGvFthQ1OPS2X4vU0rsfksY7yHBjU8ELrDbIXoT6miVvtSdel0hpOOpDMjNjRqLT0wX7IvU9+QqOglNyd2Zxp+PdbzUOn3NUZxKZV/nGRZM4+1A7ycmUOrrd0KTmvijjkZsYJ5p29dG0Sed6Di8zIX6eU4dkp6uRQoeAFfSh77R4GaabK8dAj+UKCcZhQo3SalA02WIjwu3OXa2Bz1fxHMtO9mnQPAhlFo2jUhiVv7pA+ZEn5MxuGegwIJe+VYjdtFw40hL2GdPOxKAEezleYz8q/nbpDpVYKc2U7a5VuZLDlFDOJovZGOtOxToqTB4iXMvqGQ2DapD48OhaWYelJs01AiS9Qr/BQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JaM0Iyc29iYVVKMkpBbmF5VW9mM1RHeEovK082MHBRNkI4V05Wb3Vva3VX?=
 =?utf-8?B?WEpVMDVNbWg2M2dkdlZVZnNWa0htM3o0OXFXT1o2Qm5uZlpjOTlzTDlXOGxl?=
 =?utf-8?B?Sms3aHJ6U21VRE81cGQvVzFVZTlQV21EWFd1azNNUEtyRlRjeHZEaS9ZVEJa?=
 =?utf-8?B?RU1JTkRrM21hZHhOV0FZM2tWZlZwZ0s5MFJBcEtyb0gzcW9DN0pwK3JnOSta?=
 =?utf-8?B?WTh5T3IwQ1ZObGRHczRkM29GYzBlNnh2UGp2VmZwMjYyMnB0UndOUytpVHJq?=
 =?utf-8?B?cWt2ekZGWmR4UmhHYU9ZTEgvRmJvRmJPYnFCVGZaSDI5S056SFdxcHpKMHFt?=
 =?utf-8?B?NU1xNUI2amFqajRtam9UeU9Gbko4aUJEMUJIb2tMRk41UEs3NUJkQ29aUDFH?=
 =?utf-8?B?OUNNbWxEdTYwSkpNUHlCb2xYRlJvVmxVZmUrR0hjaElzc3hZVjc0MXA1cHZN?=
 =?utf-8?B?QVlSUGhEOFJVS2RERGRjR0VYajBVaWMxaUZJazZHYXlBOEs3cEZUcXZDMzdX?=
 =?utf-8?B?Uy9xVExFdkhaMTlUUWtnblY5OHowMXlvS1Myelhzdlp0cU41UHcrdkhlS0c1?=
 =?utf-8?B?R3IwMmNPOFhlK0tJeFh3VWJXRE5MSlV2WU02MlZLUkJ0SDUxNzJBbHVPNjh3?=
 =?utf-8?B?UXJBNVRlZUZMa01LQTN6TjljOURFeVREMFRnZnZLZHNFRGMwOUpKYmJ5Wklx?=
 =?utf-8?B?QTkwSDAzSXMyUmk3VEorOWcyNzBjNHJzbld5NktQL3ZINWJRQzI2bWVpdVY0?=
 =?utf-8?B?Sk9qTmlRUWllK3JyK1V6eTE2Z1hNZm1RcXhJTDg4aWM2Sy9McU1rWHFtRVVN?=
 =?utf-8?B?NFhPNVVvbFRKMHdwRmRsZndqOXJxR3hOOXRlQVdxUGFlVG44SnREajNWenBF?=
 =?utf-8?B?SzJuUDdldDhTRUcrY3ZQZndnb2ZuSjdKbHFMQXdDVGp6NytCVGNnbVMxTjlC?=
 =?utf-8?B?UjdSVllrTU1TZFdDc1JaaDJSOE1hSW1vR3pzd0dSc1EvTXMvenl2MkY2OWhl?=
 =?utf-8?B?NnRPT01xS3JMdzI3ZkRDaWFFZWZkeHJjQ2lsVHJtaGRRWEVLMG5qN2JOVnNY?=
 =?utf-8?B?ZUdRL3NLbHh2WGJvQlgzMjRmVnMvM3I5UXRHUnVOTXBnMXY3M3ZkU2xyWWNZ?=
 =?utf-8?B?bHZZZzgzb2t6c0JFaHVYNGVUZnNXdzRtR1lBRW1mWUpZVkNoam1mbVdEK1I4?=
 =?utf-8?B?WHNHTk4zeW1VVmpsUlI4R0pNRFhnK2ZxVUdkQkRTNDR4QjhUNFRoUnJFV2RK?=
 =?utf-8?B?KzZoY0gyY1NaeHZ6eGg2MnVVN2N2SFJHMG1oTWJTV2s0ejQwalkyQWdJYStv?=
 =?utf-8?B?dHhVWnFrOG8rakpKY0RtMjVuaXN3eCtzV2Nhd1VvZzhIM0dOQUxaRmJQMU9a?=
 =?utf-8?B?cEVPUnIxeXp1MHljWmtHOTFmaTIwdTJFR0VMUXJSNUVLU0h3U0ZvNUJEQ3Uw?=
 =?utf-8?B?L1NMeUNDMGlwa09HWXZVMnRHY2twdmM3QUxTK2luMGRBQ0NLOFd4SlhCRmpH?=
 =?utf-8?B?SWpHYVhKUHFCNTZLa3I0TTFabzR1dFZ4VDQvU2FiNTd4WjBTSVhWTjJxam45?=
 =?utf-8?B?VWVsaStvbk5BMGh0QTRsSlNFeXBrMkpDaHNidHJ4dHB3cHVtdkFRVkVHQ2pL?=
 =?utf-8?B?L2tiYWRrWlZNVW8wY2ZhM3lWZzhRTWp2S04vbTJvSDhCK2lDMkFqOU43UEVW?=
 =?utf-8?B?TVVCd2NNRkMyclJhSUdZazF4LzNobGovMlZzV1RwSzAzVUphT1hacy9BSzM1?=
 =?utf-8?B?KzFpa25ldGpzMHdTQ2JUTitJaXFmLytrY3drNmd4c09HRVhTMHJxOEFuQ0ho?=
 =?utf-8?B?MmIrdExmL05OOUJvSm9YdWx3L0hMWTlsRjJPcTRmQi8rUm9sQUQxT0R3TE5F?=
 =?utf-8?B?VU5Cc09hb3Z0QWdKb21uQ3U0ZEdVZDFmajJ2b2poN085eHYybXFRckJkbzBL?=
 =?utf-8?B?WTNiT1dBS3lTUGxQSHlTVlNPMHRtSFJzZmJMc3hJYlN2TkloUEkwWVo5T3ly?=
 =?utf-8?B?aGdGdjFJS3gydU1seXNQRXNqQXp0aG9maE43NU1BbHVlQmVVNmZmaXE1WE5i?=
 =?utf-8?B?bjNYUEFnT3FTMUNnZnAySnVCVUJrVW9MakZFM1hxUTAvZGtwWWgxQUNRUmFw?=
 =?utf-8?Q?7+3xbTNLFin4T271l7NtSQrWe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125689d-9139-4e2b-8aee-08dc3914ac41
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:53:33.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGq/jJNFUSUqQ6jPwZNQlJpHTsQkr0vr94RwNyWyV0nzYj2RnELHxZH2ttmb+6+OsTQQnhDvkIkJU7AF7x/lSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602


On 29/02/2024 06:52, Akhil R wrote:
> The exisiting residual calculation returns an incorrect value when

s/exisiting/existing/

> bytes_xfer == bytes_req. This scenario occurs particularly with
> drivers like UART where DMA is scheduled for maximum number of bytes and
> is terminated when the bytes inflow stops. At higher baud rates, it
> could request the tx_status while there is no bytes left to transfer.
> This will lead to incorrect residual being set. Hence return residual as
> '0' when bytes transferred equals to the bytes requested.
> 
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 88547a23825b..3642508e88bb 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -746,6 +746,9 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
>   	bytes_xfer = dma_desc->bytes_xfer +
>   		     sg_req[dma_desc->sg_idx].len - (wcount * 4);
>   
> +	if (dma_desc->bytes_req == bytes_xfer)
> +		return 0;
> +
>   	residual = dma_desc->bytes_req - (bytes_xfer % dma_desc->bytes_req);
>   
>   	return residual;


Thanks! Apart from the typo, looks good to me ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

