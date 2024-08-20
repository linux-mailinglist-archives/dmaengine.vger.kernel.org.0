Return-Path: <dmaengine+bounces-2921-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A5958B2B
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B441C20DF6
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F441192B80;
	Tue, 20 Aug 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4nFxawo4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30662192B6D;
	Tue, 20 Aug 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167527; cv=fail; b=o4uJAG0Z0qJcQx3LPczUQK9ZF21S8qq+xoL7gmNvsYpzfSBbYNEXJlk/CoR0FjEHPL26UrpjoQQcbM7vJ2MnNV1RqFeiM2YT4My5yD6chk6vhudkgSZBpnx1coRRoD4A2AV7zEP3hAVSWSdq/wP1DHk0ae6Qq0kUDXzMnZXrnDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167527; c=relaxed/simple;
	bh=tJ7x2H6uLS576w1kTrAiKutIZwFeQvXj0blKf0MI/uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UtU2reBq27v7GuwEAQ07Se4EekotA5zlJIOR5hBUZBEhFsbjPm/OI/m73faP9CfDbN776WHE6kyN5/eUq0wrhmE7VJVvRYoWZN4aPDoxv59zrmzm+FawLJk4bK+Z1g5jN802Le5iV/vGzF4Q3+WR4siccd5p4cLFfhSCRy0KtBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4nFxawo4; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgksb0k40NrEJc2VAm9cKSLjtI2zCQvrc+3XtH1cjw9VlnJ5iWT31AUG5k7GrkXSQD/HP6JTGlEwq+aKNsQJWjj3o2iZQY/Wm32RuYAYuJ17Z8r9UgCSGKe9cl3d/s4MFduw/XBSQrINzN/JNOsmkUrGOVjV9Poi1Hpo0Yh/CcGYq+LQO8UygpgzllPJAFLoCD83TzEWylYwG5+UVdIVVzwFSUJOeuMXDkLfch9A2D0HoQO+ysAKn0whfJRAUGHaoOvt44/lZuxXal8Po580JWY4xRqvV9kHnysnL8cWfypUFNhRroe9tC9FpLQKiD7dQdyJqzUBh0PDt2BY8RYmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llqad0cFFvQc7sKDp/bsjtDLIvcOk4axwDcubIFxzqM=;
 b=iT05k2U/BCAf3bpPaj7vC4YHn4H529fLTh86aPPAR8rN2H2l62cODIqNIUDIZpjZXXRK6ziWSunbbueEeIarfkC8t4YeePLjBOSQtb0JMSa4Bt5ddHjqAu5k8vinMThPyw9LUFcw8d08qnwhUpk7RgRWXth+5FHaVo1FJcXmIEQ1EonKccoegxH9VM7mCm8OQrTKsnUHa077314yXrf9Su91C+he22Z71QTIvsbDM6dhQuS+5bjdwWsXit1Q2O++U0wKaHqlvOHLo9hyzQyuFhmiep1JbwuoGdAlpwUkwJsVdARrAJn63dRTqFJxOulSmCdKcPThw2m9xkaODdOq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llqad0cFFvQc7sKDp/bsjtDLIvcOk4axwDcubIFxzqM=;
 b=4nFxawo4SJsVDqNV1cOESoZ4o4GK5WGcmYLrpE4Wt3KKivOAxlVmGfSijmXL/wIzw/0uNoebo7HDva8UKbctfn8+RdXQziudCjNizrfvQGbKRVai4pR28kJWf8SoKTyRqzVtGh7ybE1dHvwvDGp7Rip3V3GWdnq5pW/HWo4DGKU=
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 15:25:19 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::d2) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 15:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 15:25:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 10:25:18 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 20 Aug 2024 10:25:17 -0500
Message-ID: <9ff03528-b416-182f-6404-ff66f67087a9@amd.com>
Date: Tue, 20 Aug 2024 08:25:16 -0700
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
	<linux-kernel@vger.kernel.org>
CC: <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>
References: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f279e9-6b13-4a40-e817-08dcc12c4ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHlKZ1NZUURWSjFpTDljL0dzaEpkMUJKZ0ZNNTNMaXBEeUxqN2MyMUtnMTJy?=
 =?utf-8?B?M1drYVhMYWxyNjZNL1R1SzE0MHpSSjBjOEwxWUsyeFB1eUdWRjliMnBlWnJS?=
 =?utf-8?B?VURneFE1V1ZhNlBob0hKVXhxNWlEaS9OR3dRWTJNeEZrdDhEV0tScm1sQ0xI?=
 =?utf-8?B?UHAxajloclNmL01tWTZsN1Zaa0xCZldRbE10d2xpK3ZnNTZvOGk5U0lTK2R6?=
 =?utf-8?B?WmlqVDlRanRWS1hoclZPMTdiZmhsdERaYmpGbzcvdjAxZTJDcGZHMEpMY2Uz?=
 =?utf-8?B?eUo0NEVIZUd2eEpucEs0ZVh3NytwZjVjbUNMU3dhVWNGT0xVTlE1dUR1ejNv?=
 =?utf-8?B?UXBJa2lLb3hHVWpLdU01cUNuaUVXbmFRNEp0ajZOaVZ2eGk4eEg1Z0xib2xD?=
 =?utf-8?B?MlZ6THFsRERxN1ZTVkVNZ0Z4OTg4VXZlbWo0RUMwTFp5SnpSYmUxZ0VFeWdn?=
 =?utf-8?B?azI4YU1RbTNLL3VteFd4ZUx2OEtuRUw5WGZvMTIwTE8vMi9qdnJmSUwxM1hu?=
 =?utf-8?B?aUY0WjRDM0xyMk80ck1aMjdvSnN3YjJxdGxaT1p1ZW9mSG5EY1dIb1FpeUtz?=
 =?utf-8?B?alFMc0RSZk8zc1lreHIwL204MkNNMTBpbmFVNm5memgzME11S1VrTGJVcmJT?=
 =?utf-8?B?S093ZXJYQlFiam9PVXJsbDJvQVA0Z0wxYnc5aFFmcEJLT0U2VUJQSEx2WmRW?=
 =?utf-8?B?VnE0UTBYVVFPYzhXM2hUZVBzVnFhNEQvTkpCRUlWbThvMDNaV1VIWnkwRHFC?=
 =?utf-8?B?WkducVgvMDd2YmxsVHNTMXd3REJpTGdQQjBKTTdOM0hGemlGcDlLZ3d5enpy?=
 =?utf-8?B?czJ3R3FUNDNuNnVSR2hzOHpTSitqTkZDRGJkTXNpdHFXV2taM1JjeERaRlBH?=
 =?utf-8?B?eGdqNUxjNTdGc2dIRnBLclpjb05NSVdIVVYxVHY5c3BNaFBrVHBGRU0vQzhs?=
 =?utf-8?B?M1hXSkRCZ2plcnUzN3JyZUp3RVJUSGRQUWRDblZQYno5b2xVR0xjMkdFVERy?=
 =?utf-8?B?YTBkY2daYWd2Q2VlTjRpSjdoL3c0RHd1YmJmaHFwMDlZc3g5c0FjZTh4cStI?=
 =?utf-8?B?em5Zb0VVbWR5d1k1dDMzbkk2NUN0dmJrS0ZIY0dDRCtvaWtLditiUVQ2YXBH?=
 =?utf-8?B?UTQ5OEFDYU5VTnBVV3l0aE5ocEpONGNDcTNKZWlBTzAveFlxNSsrOWZLdXJ4?=
 =?utf-8?B?cTVjUEE4UU1pamp4ODVObW5xWkxkL0t5YmVOd3M5dysxdm9kWVRqSGR3bFBG?=
 =?utf-8?B?TFVFT0R0YWtJY2JzWnlhSGhicFR5UGMvSmJVT3B4TnFDditIRXF0cHBBMmpH?=
 =?utf-8?B?eWUxanJJZ0NYck9McDl3UktpaFdka3ZzeHdSUHdPMThwZkkzNHJDYStDQ2Ry?=
 =?utf-8?B?eFJQcFdMejZ0dUk3aDVveTZDaHB0RTIrZlBPL1NTSWlIUlBmZFFKZEdlLy9y?=
 =?utf-8?B?NUFrRzRQRTR3NjkvdEFlR2VzcUhpSFlEM0JrWDJES2dDQmIwSWVuempQN1VF?=
 =?utf-8?B?T0JCRzRmd0poWk5EZmMwb3I3ZjVXc0h6amR4ZHlHODJJNUpWV2VSNlU0cTZz?=
 =?utf-8?B?eCtOL3d3V0lhRTBTcE43OGh4Tmk4Ym1pUTNIaEU1SHhkTFRlQkhBei95Wmw3?=
 =?utf-8?B?Wll0WmxYQ0tBU29pS0xlTzlCU3NRbi9LTjV3ZndaTGg4UVA3SDNHeU8rUVB2?=
 =?utf-8?B?Qkgzdk43WDh6QXQyZ1JrY1RITldLUXA3cU9kU2JCLzYzeUZZNjk2Q1B1Zkw2?=
 =?utf-8?B?Z0ltbW9BQXRWMW5jOVVMenlpRU1LMGtjQit4TUkrSDczNzhPazlKeWpHUUlv?=
 =?utf-8?B?eWwvTGF3YnMxdGpabVNYQVRIL2ZxSy93L0RBeXFreW1SUVl2VVc0VTVDTXVV?=
 =?utf-8?B?aHdvU0RJL0xjc0V0R0ZmRHROV2NMZ1BxUW5GUWR6UHBNZ1NpVmE3TjBhZVhP?=
 =?utf-8?B?d0Q4Zzg2NVA4WWRrUXVDZXBLbUVONW5USmRKNUhlNHNTTmJVQW1Zb2Vpb0ZC?=
 =?utf-8?B?TjAwVE0ybE1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:25:19.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f279e9-6b13-4a40-e817-08dcc12c4ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567


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
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   		xdma_err(xdev, "config regmap failed: %d", ret);
>   		goto failed;
>   	}

