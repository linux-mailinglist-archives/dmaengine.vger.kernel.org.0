Return-Path: <dmaengine+bounces-6849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCCBDAC1F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B504402F2A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA422F49F8;
	Tue, 14 Oct 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="unEG4D0Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74482C3768;
	Tue, 14 Oct 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462390; cv=fail; b=leoe/ZxYOpvVV5DZyi0EcDtwAOFL4V47gz23vs6WOpuXP3mqu6l5QFmwI9wm9cg6reCiLppcJikCBtBf779EPTdS54fArGjJ68NEjn5mnDSkjSsK5YcghjsDi7SCmBUvoQqe+1ff676qpJk6xHIVAARTQJOfBeDoL5PANuAqZj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462390; c=relaxed/simple;
	bh=JZrRvxDoLvVUbAcl84RRbWQITW+xIQcP1coXYtXRamo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YQUJDVDN2zBKfM9THNDW5cYBbeji7h4ySOWNwB56VHlpG1LvBi0mXtOOtMGApVOMRld3/hcriQ9Vkusax58Xg9fF1C/WyQ6gjCGbKoIVEgypi0Qp4kNs3cnQF3lKZS20ERuzpNLqyeLfXiz4kkNOUiv7e/kCuevjqJNaJYXhmIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=unEG4D0Q; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ2nDfGze8DnRxReU5oyndZ2U8GRx3MuXzNGn3sMq8lZXJVquqSvCmhg/z9nuO+bzkscJdC+2D5QRKEjiMqxaS8ZjfhQN1Y8iYZi6X5y9U/bHbOTLrIYeHfL+zS5YUxUDm5h7unGxDKZGftNwiLV0NYBFR7E8tVGkAsR5657HGVWONtpBu5Zjjy/aqc2RSOdiu16ZnPSM0L534my/pUn3qQpymY6ki06uCOD3AixMUGIE0Hl8VEsdk0rjLDtlvwEV6zx9Qa2pylhmgksuUlXzU1DTNtpIxzMq4bYBc8KrWsCjOwwkR22hisxv3RX9zCoQJl3smiVVB9JTW0J3EZu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bcvAB+5He8MflbuoyZON8kOEYwUFMPDQDn+j2h0ypg=;
 b=I+vxBQRmSVcElSDScVtPNCkleT1bygLfjZa1TTJHtI/Yv8fFAoLyK4zNuYRmfXf4oFreKjq7VQGtlx0XOOT4A4fsG3SDHs4rADIpSIYGQZMheUzfZ8bhYevLUanFuFsFGJ8yXgGb8jI450ApQFH+S6W0amIyLOcHIRdiCuZRCiFcVbozlzUHSbDnP4qszeG+66IrExcP8OObyppgteHPjzLzn5CJz4YbV+VNIG117raApleMmuz3Xw0CNMGEFrhro5NSBKtdmUHOW5q9YOTMqB7xx/pb6Gq1a25//rXw3sXHZQ1jD31uocQGgHPvv/UC40pui+eDnUJckQMD4pwANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bcvAB+5He8MflbuoyZON8kOEYwUFMPDQDn+j2h0ypg=;
 b=unEG4D0Qe/Elv3CFXauMH8Q6fTSg8DyUqDnnZkmIbZZ5k+Kmx65ysdv6AR7lF1OI0xSZGORNEz5r4CWOJF5BXVDq6MKuVGaSZQn1CsuyXv/lFW7+hizFCk0mbXHkOO1XbEPioZ+1nvz+LxKgIE1I55fYTm2AImDUULC51yjSSCE=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 17:19:46 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::6d) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 17:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 17:19:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 10:19:44 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 10:19:44 -0700
Message-ID: <264a9596-b602-19ec-ff63-0e687a818f8d@amd.com>
Date: Tue, 14 Oct 2025 10:19:43 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dmaengine: xilinx: xdma: Add regmap register ranges
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Brian Xu
	<brian.xu@amd.com>, Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, "Vinod
 Koul" <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20251014055034.274596-1-alexander.stein@ew.tq-group.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20251014055034.274596-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2978eb-fb3a-41e3-e53c-08de0b45debf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjIzOUtFWkp2T0tja25kWkQ2WmNXZmtLS2ZYbGtVSXkyWlZYOEdOSnVDUk94?=
 =?utf-8?B?TGQ3YThIYjl0OXp0MFAyeHBpVGFjRFVtYU81Rko5ZnNQQ01iR2pDdHBIZGx6?=
 =?utf-8?B?ZzFQdkllb3JOZXE0SmdZVVlmTkZ0VFhrWnAwRjJISWE1eGUzczJpZ01SNmRu?=
 =?utf-8?B?UDJscFY4Q250QXlBN2VKZHRwN0hpRFBvMXd4czNMOXAvUzZwVXBtMlAzTWRM?=
 =?utf-8?B?cEFmSk5RM1RkNXNsaThLclNEVFY3Uk1EVWo3NEdGUW11eXlZcFNyYkF1NC9s?=
 =?utf-8?B?Qm5RV0dKcXd1d2doTzJ1VHIwU2VzdE9UN2VGajR5L2E0VlBrNitDdGVwR3JL?=
 =?utf-8?B?OTJmNWdvdnFST3I1S0dRSnZUVVJHbEN2U2NWRnlkYktNTE1lakRsYWxpTkNM?=
 =?utf-8?B?Z0Y2UXc2YzFmU0FlQkxxZkFKZm5IbE5JSlEwemVKSFVlZ2R2c1Z4c0VQeURs?=
 =?utf-8?B?OFArdmR3VzVkRWRTTi83anJtcS9BQllqVXRuMUFrd05DVjlsbDlzWDl6aTZV?=
 =?utf-8?B?eEZ0ZFM5alBoYk92R2x4am9uWThwRFlVUTVwSkNqWE9SV0E2dnpJaWJIT2kz?=
 =?utf-8?B?M0gxb2dmMDVMbk9jV0QvYnlBNnBlQlZ4dWRLWmdGUEFKWGFUTCt0b1N6WWVK?=
 =?utf-8?B?TEJOeGdEelFqYjhvcWVkRXltdFVXaG5ka1d2dHlKOUJXaHN4M1dJc3I3MkQw?=
 =?utf-8?B?OEpPMHYyWWl3emgyZlR1a1RRYS9TVmhTSHVoZEJtS1Rrc2pqS1VxZFVUcTdJ?=
 =?utf-8?B?Ri91TWw5YWhFOHlSZEhKTUNGb3lBWjNiamlNN2o2K1FyM282Sk56TXNkVUZ5?=
 =?utf-8?B?NkpEeFh4T1hoMStoNEtJcU5ybXJaa1hxK0tyajErSmNJS0c5MEpzZ2c5QWhQ?=
 =?utf-8?B?eDBJRWd5dFNlUjFyejh2WEZIQ2dTbWlPazB1OXVPQUcraXl4Q21xaExKUDhJ?=
 =?utf-8?B?NUlMcitQR0lnUUZJb1FMQ3hxOUNXd1pXZmlYS1ExTTFLSWU0L2laTi9HM2lM?=
 =?utf-8?B?aDVQZXNXYm1JSWJDODZJQ2xtcjdWWjZHdldyOUI1ZDFBUG9iVnN6elBtdk4v?=
 =?utf-8?B?VXpCeElNN2VWU0VDaStTQ2pPa3YrdGw4VW1Rc1ZqbDgzbkhOVUVwUHI1ekpP?=
 =?utf-8?B?TjRMa2Q4aTBXL3paaGl0bjdvalhWcXVmMkJPOFpQcElOUmJTUUtub2llTFB1?=
 =?utf-8?B?cHlWRldjc29MaktOemRCcnZ5WS9haVphRGpBd2haT0d4OThvejBCS092L1ZV?=
 =?utf-8?B?M3Y0V05kRzhJc085bzBQWk1LY2RVaUMyc3ZHc2gybkRZWkQzOUg2R0JyUFUy?=
 =?utf-8?B?clVzc0hyL1hHcW11eEJnK2FYNU1idXU4U1FUZVRKQXRHUWlyV21QT3dQalMv?=
 =?utf-8?B?RzdjTDJXSHZIM1EvN29OVEZJUFNSdWJRSnhrY05GN2NWMmFZS2FyWWVyV05n?=
 =?utf-8?B?ZzFiNEUwVjBWK2J3U2d5Rlh3V1NFTHNoakhQVDlFT21heHQ0MVdEVW5LSUF5?=
 =?utf-8?B?MTFWWnpVRS84dnBpWkw2bFNvYWlzMU9SeVMxcVNFKy8vUStyMnk2Sjk4UVhI?=
 =?utf-8?B?RWVnV2x6Q01XREM0dW1ibnpWNEE1L0UwRlJxaVRhZUx3WWszUUpUaFg0SU94?=
 =?utf-8?B?eXZYLzZMMG5lNVhQUEszZDlKK3BCcWF1VktQbStscTk5T2pxMmhGZy9BS2M0?=
 =?utf-8?B?K1FDdEZiMHRZSFdDcnRjeCtDOXZKNEg2NzBzc2hDWjQ5eU5rS0hIdGM5L3BV?=
 =?utf-8?B?QXBmMGpZMFU2eStpU3lwRVhWbWxSdDczOTFVQVNveWVybXJoWEt5c2Q2d2p3?=
 =?utf-8?B?elZOYU83M1kya0tZNG8yd1FsTm9Qd2RyRkE1Z2lDMGVmVnZ6Q0wvaHExUHdD?=
 =?utf-8?B?R1oySlQ2QmhnRk52VVJTRkhnd2NHTFhmNW8xb1o5R2dnL1dHTHhVSm1YclhY?=
 =?utf-8?B?SWZXVWVyZlo0cnZTOWUrZTJyem01MUV5NXFndURpQlowVXZTZzZqV211MG9P?=
 =?utf-8?B?NDJJd2xNNTM5bEFCNWVzTE42cFhWSEZ5OUwrcnRQL1NLeXJWZjUrMktnbFQ5?=
 =?utf-8?B?VkgzMlhLbk5vWTcrRjRqdEYwV0RiRlREZDRteldaWXUxdWRiZ255OVFpNkpQ?=
 =?utf-8?Q?wO5E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:19:45.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2978eb-fb3a-41e3-e53c-08de0b45debf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

On 10/13/25 22:50, Alexander Stein wrote:
> The XDMA bar is 64KiB, way too much for debugfs dump. Add register range
> definitions for all defined registers in PG195. As this is PCIe memory
> range all readable registers are marked as volatile.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Although the change itself is independent, this patch context depends on
> [1].
>
> [1] https://lore.kernel.org/all/20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com/
>
>   drivers/dma/xilinx/xdma.c | 89 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 5ecf8223c112e..3d9e92bbc9bb0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -33,12 +33,101 @@
>   #include "../virt-dma.h"
>   #include "xdma-regs.h"
>   
> +static const struct regmap_range xdma_wr_ranges[] = {
> +	/* H2C channel registers */
> +	regmap_reg_range(0x0004, 0x000c),
> +	regmap_reg_range(0x0040, 0x0040),
> +	regmap_reg_range(0x0088, 0x0098),
> +	regmap_reg_range(0x00c0, 0x00c0),
> +	/* C2H channel registers */
> +	regmap_reg_range(0x1004, 0x100c),
> +	regmap_reg_range(0x1040, 0x1040),
> +	regmap_reg_range(0x1088, 0x1098),
> +	regmap_reg_range(0x10c0, 0x10c0),
> +	/* IRQ Block registers */
> +	regmap_reg_range(0x2004, 0x2018),
> +	regmap_reg_range(0x2080, 0x208c),
> +	regmap_reg_range(0x20a0, 0x20a4),
> +	/* Config Block registers */
> +	regmap_reg_range(0x301c, 0x301c),
> +	regmap_reg_range(0x3040, 0x3044),
> +	regmap_reg_range(0x3060, 0x3060),
> +	/* H2C SGDMA registers */
> +	regmap_reg_range(0x4080, 0x408c),
> +	/* C2H SGDMA registers */
> +	regmap_reg_range(0x5080, 0x508c),
> +	/* SGDMA Common registers */
> +	regmap_reg_range(0x6010, 0x6018),
> +	regmap_reg_range(0x6020, 0x6028),
> +	/* MSI-X Vector Table and PBA */
> +	regmap_reg_range(0x8000, 0x81fc),
> +	regmap_reg_range(0x8fe0, 0x8fe0),
> +};
> +static const struct regmap_range xdma_rd_ranges[] = {
> +	/* H2C channel registers */
> +	regmap_reg_range(0x0000, 0x0004),
> +	regmap_reg_range(0x0040, 0x004c),
> +	regmap_reg_range(0x0088, 0x0090),
> +	regmap_reg_range(0x00c0, 0x00d0),
> +	/* C2H channel registers */
> +	regmap_reg_range(0x1000, 0x1004),
> +	regmap_reg_range(0x1040, 0x104c),
> +	regmap_reg_range(0x1088, 0x1090),
> +	regmap_reg_range(0x10c0, 0x10d0),
> +	/* IRQ Block registers */
> +	regmap_reg_range(0x2000, 0x2004),
> +	regmap_reg_range(0x2010, 0x2010),
> +	regmap_reg_range(0x2040, 0x204c),
> +	regmap_reg_range(0x2080, 0x208c),
> +	regmap_reg_range(0x20a0, 0x20a4),
> +	/* Config Block registers */
> +	regmap_reg_range(0x3000, 0x301c),
> +	regmap_reg_range(0x3040, 0x3044),
> +	regmap_reg_range(0x3060, 0x3060),
> +	/* H2C SGDMA registers */
> +	regmap_reg_range(0x4000, 0x4000),
> +	regmap_reg_range(0x4080, 0x408c),
> +	/* C2H SGDMA registers */
> +	regmap_reg_range(0x5000, 0x5000),
> +	regmap_reg_range(0x5080, 0x508c),
> +	/* SGDMA Common registers */
> +	regmap_reg_range(0x6000, 0x6000),
> +	regmap_reg_range(0x6010, 0x6010),
> +	regmap_reg_range(0x6020, 0x6020),
> +	/* MSI-X Vector Table and PBA */
> +	regmap_reg_range(0x8000, 0x81fc),
> +	regmap_reg_range(0x8fe0, 0x8fe0),
> +};
> +static const struct regmap_range xdma_precious_ranges[] = {
> +	/* H2C channel registers */
> +	regmap_reg_range(0x0044, 0x0044),
> +	/* C2H channel registers */
> +	regmap_reg_range(0x1044, 0x1044),
> +};
> +static const struct regmap_access_table xdma_wr_table = {
> +	.yes_ranges = xdma_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(xdma_wr_ranges),
> +};
> +static const struct regmap_access_table xdma_rd_table = {
> +	.yes_ranges = xdma_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(xdma_rd_ranges),
> +};
> +static const struct regmap_access_table xdma_precious_table = {
> +	.yes_ranges = xdma_precious_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(xdma_precious_ranges),
> +};
> +
>   /* mmio regmap config for all XDMA registers */
>   static const struct regmap_config xdma_regmap_config = {
>   	.reg_bits = 32,
>   	.val_bits = 32,
>   	.reg_stride = 4,
>   	.max_register = XDMA_MAX_REG_OFFSET,
> +	.wr_table = &xdma_wr_table,
> +	.rd_table = &xdma_rd_table,
> +	.volatile_table = &xdma_rd_table,
> +	.precious_table = &xdma_precious_table,
> +	.cache_type = REGCACHE_NONE,
>   };
>   
>   /**

