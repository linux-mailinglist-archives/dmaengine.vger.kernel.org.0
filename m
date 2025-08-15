Return-Path: <dmaengine+bounces-6049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E796B28663
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 21:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19EA3A37F1
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716622F75C;
	Fri, 15 Aug 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GN+9SwNV"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FF27464F;
	Fri, 15 Aug 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286019; cv=fail; b=jFZ8i41larGAhiTwXK/3ZEGP5evXcuvgOtpQLLeEuoBT4Y3cg+WtVz6Uz/wwMsBduQ1l2dWMrAJvCS+Nr449htUnFRR4BfvYquQ4VkdWZbT2ICYjlzcqYPVjRZopYTb6Ae3vupOnd4Tdx68Uz6paD+blXf8htj5LQpunlThgaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286019; c=relaxed/simple;
	bh=Y3sVVDU4azLiNbwBqCMG/BHTvj76AxavXO/rxROZZ7E=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AW78xEPDjINLpmYrZTZ8E8dQRcQOaIYJZXR4+zxeOzjxiLy3aa8j8gAHG0WTy5g5Z9SsoSDSsnlfMy1mC5TRRG54lbpRC1D+VYVgjDCjLABM2n0K8FgLCP4tu0pzi5BrvqPYx52SL+crVBoFsheCB3GyzFhgD4QvzMULBps+bvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GN+9SwNV; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRZuXlo8KLzgHKY0oulC6AUq+PaA6zsAjQQeeN3w5Egu1M0CGHcKeq8cVBDT7yKeTP5PDzjsTwIIFnMgO4DVOZINyoUeIXu2RHXdJ8aYBsT8mNAvD0P/KYv649FQiW7Gs0Up75OmpUSoDkOio2BjpnPjmrYUtU9ByJ72cATlXwa6R+3Pr7JJONVUXGXqaaNo/MxKCXLnuarCsWYK6I3ddAN+pQslYiCUPVV4/QlQB4y7twIOp0p4hVmvC6E02TFGTA9yEh56KsQRxI8kkZ81oNK7qarF5tfLwKKE2uPm/wOGt/U4j+AfUkGyFY5F3SqsqnP9QFYpbAyITdKOCUUS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiG80x6t96YwuXHgBtnPxG136W8uCoryWaxKRtpkBRs=;
 b=i83Vp3vHUeLoYhit9eFkUzrhxn3K+Y6eaM4VWNJl7dFF5KM22eidD/NmexaqU9BIdxaE+6+9hWSfRUN2C9hopOCATGrtCaT17dx5CnfNM7KMHkPToP2ChTQC+w61boc+rMU3gz/F3ZEfpEz/CAFfPQz63+jZ1ZvAWNUW6bVodC/rpxdh8vyx6/fPs3KfU5ly9taMDlbn8bkvkM7DZbwtHa8MfgrifgBKDd/2dVNj1oR0sEXdN8oTCza5Qt8kG7/Do0SucsceqncpAynHowclWJQUi8tt/Fw2MwH0zpsERq9fvSVc+eI/iy0J8DpBJsmCZVGAlq96gZFhyA68ZHMxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiG80x6t96YwuXHgBtnPxG136W8uCoryWaxKRtpkBRs=;
 b=GN+9SwNV3Y5iEU9HCV5x3ms7FNBAOCwPlPsaJ2YI8Qika3xPUP9leVvKN/tg+rB6WZUHln3shWEQAnr0Xnx/SUbMa0CF2V1iPNb6XsxWM3CNTkn6Egay8jaEW3SVtXvW7gTlGMcjG4iZJZIzNZZb+xWpACD6fRIelceTUsdZbp0=
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 19:26:55 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::6a) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 19:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 19:26:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Aug
 2025 14:26:54 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] dmaengine: idxd: Fix possible invalid memory access
 after FLR
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
Date: Fri, 15 Aug 2025 14:26:53 -0500
Message-ID: <87349sgzcy.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 64255a14-fbbe-4cce-9b5b-08dddc31b1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sz9rxBoJroFKxQ8QVjrQfb8a9LZOByDL4xhNyfAoSN/CmhlkMHdj6ndhLbns?=
 =?us-ascii?Q?u1q0k4HzpCFp4QfHRB0IoRvdvFjdtMPY/Yo/L7Z1qiqhUOTuIVJz89BD+SbN?=
 =?us-ascii?Q?/CX/liWBYZY75j/3APBjhhlBPqmaOqzqtewwvHPZwVZ2nC2vdRX9n2gTkYHl?=
 =?us-ascii?Q?zL4gCOLPCZJWUv3hrYkBGrMmfmuMQ5r474SZVsRFSGUsT2mbv59+tr+0xr/P?=
 =?us-ascii?Q?8cKDFrQGFAHqyVs8+c8Wwe+kcERQ7BbqWHIrOCbiFBD8nc+6a/WszDVH1Yrq?=
 =?us-ascii?Q?gLFvrzm61phUyC3kveFfKmuOltFhrwJwvwnTfVAObnY5njgXO4288ykDHXW7?=
 =?us-ascii?Q?D09rylQMjBofUtMUo2L3FnocVLbLNHikDhg+Nj9wgXkZZt0n5Cxg/k5b2edR?=
 =?us-ascii?Q?qWMK29LoHYS84aJyO8fCtcNhvL+dhnv+o7e8aNpfnepGOKjBrL82HRRGbTRf?=
 =?us-ascii?Q?/1aZT6S4HZiERh/HAZEP8mxdfOYkXB7/ZhEjZntbDW1rO/I5GCfBCwnVK2WM?=
 =?us-ascii?Q?Q7ooUxOOdYiA4jgtfV7vPLXBmyzVnOHZ0Ol3rG0z8Mnl0Rk83Of2kS1efb+i?=
 =?us-ascii?Q?ti9Gcan0ahTZ9MN80LP/+kdyUEUHPzXWwKINJfPK82m+A4jIRMwq9AT4mtHr?=
 =?us-ascii?Q?pWK7ztLnFyaE1giwMpHJZ1gdvT93g/uXviSoigJjRIWeHf+S2lYXQh1r+n8V?=
 =?us-ascii?Q?aE6EA0h0KhSpOXCccitHnAoZ/dzBF1PzInG3RCzS9KBJ8m49TEYnidX4j1Ox?=
 =?us-ascii?Q?9wjK3SBDETwvn0M0OiEK9A9ATrNZjexuEUHJ80YsAmNDUHG7ymrtzpKb1YGZ?=
 =?us-ascii?Q?MTcwZjcjyEr2JrSyRhl88l+oUNZvzvwKjc6xWXFx6rFyi3hIM9nK2tXN+Pbn?=
 =?us-ascii?Q?GhQCPROuKcC63JX27lo+E8WiBSH1mwth0t92shyOQTeMHqAhYSiN5w6hUjcT?=
 =?us-ascii?Q?kpiIXArG6LVzwe51bSpLUlCcxbwXgdZs8mvFSQGSzINmCfMG14gmQRsm8FSQ?=
 =?us-ascii?Q?PcOwY0PU/yu/aRcXZ9wvXNd7Dk5Pp95b2FZd2kHKXRx65W+BwbWeH9WoOx8B?=
 =?us-ascii?Q?samvSfsQ+MndYZyiY2yaR3ELr86Uo4WyVIvH0IjfPKuFuT4pa7O3Tfn439pW?=
 =?us-ascii?Q?+03klujtZtzMXCvc/0dsvadmWPrE4gjp+8ooAB/AtBqcdPRlDh8UKMpsLk4R?=
 =?us-ascii?Q?dRMimZ0Ok1ofnfkPvYITI4ER4hwCHomEtjxeN3Km/xrwnYFWwUjREBWZJVR0?=
 =?us-ascii?Q?3bLDvIKTyEGkqfuQIeswhAOwEt0fBeuDu004OCiwNaXXJ6x7SXyJManeY1I2?=
 =?us-ascii?Q?cbfA+h1J83SD4BbIgArALr5QyXgmquVKCZT0Blol1N94pT9EW8FTVQE2K8JD?=
 =?us-ascii?Q?8sLuBu5oKNYuAYJeT1B6MvpvvVPItGY8q4lyzZl6wUnIB0spgslNMv3P+EeG?=
 =?us-ascii?Q?QkKIBqraWKz9TSMiCzl3VVhWj/1jGSN/BveYQR7D1yheR1ptUfMC2I31sfIB?=
 =?us-ascii?Q?bXZetfv5CF6rBWRaS4ttoMU+iIK97H0uaDzJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:26:55.1388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64255a14-fbbe-4cce-9b5b-08dddc31b1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> In the case that the first Field Level Reset (FLR) concludes

I think you mean Function Level Reset? (here and in other changes in the
series)


> correctly, but in the second FLR the scratch area for the saved
> configuration cannot be allocated, it's possible for a invalid memory
> access to happen.
>
> Always set the deallocated scratch area to NULL after FLR completes.
>
> Fixes: 98d187a98903 ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/dma/idxd/init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a58b8cdbfa60ba9f00b91a737df01517885bc41a..31e00af136a7e13887d3ffd00efbb05864712a80 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1136,6 +1136,7 @@ static void idxd_reset_done(struct pci_dev *pdev)
>  	}
>  out:
>  	kfree(idxd->idxd_saved);
> +	idxd->idxd_saved = NULL;
>  }
>  
>  static const struct pci_error_handlers idxd_error_handler = {
>
> -- 
> 2.50.1

