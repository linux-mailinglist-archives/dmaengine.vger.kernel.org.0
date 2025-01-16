Return-Path: <dmaengine+bounces-4141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E1A13F2D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D33A70BC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D722CF28;
	Thu, 16 Jan 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lx5A5m8u"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0322CA11;
	Thu, 16 Jan 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044473; cv=fail; b=edZvxrqMz00tDT4nekLqRWy0kJrd45SRAwnHry/zFzJYNhpXcB2n1WvtcbSyjmxRv5xP4myOKs+tCSVMj//zvdu3ObJVa+d3fTWcB7om9231lUce6YuQrlIfEOD97a/D1kJNsyXwBk3oz79MacGHGtvhm9ttdH5sFTkY9onl7gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044473; c=relaxed/simple;
	bh=J+gV2EvvXirSZQvIpuIJtnAAK5VucfCIH5kdbnHFO6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+mUUyyUnyutDxnCCQzR3X3RC+n2XTEgHKhdX+n8v95TziIOoCp3hvpgP5RrzPjKkAV9TuwbwUcTCKl26jGGkgaGyQk5z4b1XpHgJKxtjJK7F71pMqhc4NLfm+0QQ2uBWXcwiu9LusH2aHD6Ez0UhwN1/UbQhXkzrTx+mvF+Ubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lx5A5m8u; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDBIB5DuMlEOal9Vg1qiyhEh2Wx7PelSO6TbbgseeG+elK/7F4bDT6PvUGatAK5WLDAVocsfyR+l1Jq/clHOdVflRuQDr1lTKYZ6f42HSXwWKix2Vx7b/i6u0sx3oS9nSVWMnerDUkJxVR3fMV6jK6LB6CYhDru3Uvp4Eac4QQEJVeB9Gf07GPM8Q5Wj+n1GTi/zAgqAWyv5KOPnI3mh6FpVzsuWJZDKalVlIkV5TYtnaTsDeDeIiym1L3appIvh0bMUTiBkRZAneBxAyH/ghKzFgZUc1FYkFbSYdHCiLPVUKZ6QOm5Mo8FJ00Z2/7cvQd27qWtFqzETiYu5fn3WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc2xO+uQUwjrtk6Mu8deOkPM7izeY0T1xz4B6A3aKUI=;
 b=e00ARwOXZKPMzvKT6QSdnMVHMnAZ8ZSpEGJhTNpYeiu8Tl5/2JVXfpvJAQbVMeSYOThr1VNYXOTF7bGvFQ0ZipYcTgpG8LehX5S6TGFOGt4Kf0GThy3f02N3stSDI3wTDqbhdkEfho7sE0Z/OcI1sVMDv/SC98TpwQ0B/zJlT6YoT3gzIY7BaW1GWqiIBkTzAVL+38KPhkLF7/5KzL4DEa04Q3hIKn4pkkraWStYQu6OI6Wgt6Kk18KMsor5zs4OhXU3IvuDqgwqxDxvc7QYuv92Q71v2cOu/s6EoVRRm2KGh/LlStHkxijyDp2OXYENumv/ZyvCuFLO7JcF9E/hPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc2xO+uQUwjrtk6Mu8deOkPM7izeY0T1xz4B6A3aKUI=;
 b=Lx5A5m8u9lUF1+ya3aqSYsiQyf/RC/ytnzm4JImOwc1b+qevI1pkEokmCgku8ojfiW6XspJSE7ijQaLO+ZpUiZDD7dI8VYGJal0a+JLhCO7AHBH3bEoX2QcND3d4Gx4bxcta/2qHO01VjSBlhjGGY/ohkcnCIVlRHpx4fF0vl3Yqi8wL6rXdno8r+Gmc8pbnBoWo2U4c70JwTe0eLztmVHXlxvixOwZoWKXgXLY7PqTlxnJL73ScQ+fF2KJ2hszT7RpB5+xoLvtJQnADlgCR+0oadJXbNHwDnQ89s0hqWL4oC0B3zBztau+32RjYZmNA1dfiYDiZPHyv022CctfNZQ==
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 16:21:05 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::4) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 16:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:21:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:41 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 08:20:38 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
Date: Thu, 16 Jan 2025 21:50:32 +0530
Message-ID: <20250116162033.3922252-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116162033.3922252-1-mkumard@nvidia.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a17ade-8da6-4a29-1c71-08dd3649c6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7N+Uf0d07qCExtweaj3OgbL0jGAb31+5msbP0nlwp7CwWC/aA25LDhAOxBc?=
 =?us-ascii?Q?ANh37WkP4fZTh3ehuEhE/IFJoFLJ8pgbfE7UNI8kRcOrCtcWes+Ma71IP1sk?=
 =?us-ascii?Q?u9iU/lKuwi/GmH+7JZ3lBIYWnPGWAgdlE4agtPO3RxEUKgmlgU8YgumFKpZb?=
 =?us-ascii?Q?xu+m4W541C9UvsQnyR5nQng0Zp7Fp6uwxnRAKvcf2vXTD4xMFNC0pDb/yFsq?=
 =?us-ascii?Q?xUI4ZYjEv53nghUnGFdFO+/4txzOTQwoAxfDoF4VlVCqFNMZR8/9yK99EB2O?=
 =?us-ascii?Q?7zxzzp4W/OTHOWNPf2UYO5CBkLm8SIb8fhklBu+ueqfeyAkso69R/Hrbl6Rl?=
 =?us-ascii?Q?Ygi5hBAQ92NZR48l9uXTJeecnX19dPC//KMgf7WEnndAsDtEsYFTpAX01lVn?=
 =?us-ascii?Q?/R7FXHQZHYOCO6dMrnwZo43IFaXHiqzm7/VCEK4FKBsBKHIkwxddSIWeZZXJ?=
 =?us-ascii?Q?/kSCcFtEQrAMogYGkYqdtNsTfVWWe1Y5bIamBg0QDRLolXQsIvqHcf4de3r+?=
 =?us-ascii?Q?zBr6xn+yI7ImWQAhXkeA4Q/b2GgUPR01y0Ns9GRpPfiYFS+N247XP21sICNN?=
 =?us-ascii?Q?IF58WoZEzwwOdzAIdKHLMnNdOV2H74vmochWOLT3VLKZ04eTvFkMxDWi0Y7J?=
 =?us-ascii?Q?r7DItVp/2IAptS5Tnzna6PFdm1fOW1DO38bDSH+EaU2OzxL+TmTXP2Y4W2jR?=
 =?us-ascii?Q?+LvHa8UvaNwYP/GMWJlYQSiDjT1iVY/wN4VfkGcVTyNZoA9FIoeHz8+XQYiX?=
 =?us-ascii?Q?ce9WqFiP7jbfpq2FokRPo/T7rqeJ/1QDZTqjP0TsTwR7ZWpyxW7KXglSPAa1?=
 =?us-ascii?Q?pvMRjbvqxGK6cgCPhEiBmPNzTcVZnpwJRMW++h7vYGBNNqUDznPfXaCIU5rH?=
 =?us-ascii?Q?/DF9bR117/1MX+lsvGIL1tkN5sVHDOiSaPDP5hAI8FnG7u4SlEST4Drz3VCV?=
 =?us-ascii?Q?POuGxYyyM5SKHDvGwreJaVO2+VI03S/lZZRBkhVTOwP07eNDt26x1Qt5F0M1?=
 =?us-ascii?Q?ABxzjTlmQEF843HJ1nJxS2avenWlKlm8wzvVEV9EZdo/W5TdxbcT9ZZMMv47?=
 =?us-ascii?Q?T6oAEAvg38MkKbVzUTAiwDnplHrBztJETKtSXRGHL1oIrtMbd8/4tD5QuKIt?=
 =?us-ascii?Q?rz5ABesmH3NKlBRS4ptpky+bEUUZjv1Nbty9QRx0dI9F+XylgwrGOyhPKyqC?=
 =?us-ascii?Q?LNbKC2hsq8N18bpU0GeM033tygTvUiTOh/+0x6ztKLhLSgETA9cVuloiAovc?=
 =?us-ascii?Q?uRLdgzQEJgh4LAbD61SV0cbrTrvr6wtSO+3sG78M2M2P+AuDHt5MJfDI6LWS?=
 =?us-ascii?Q?aJl5h2CByZYBvQYKroc8PWoqQIX3EDcp56errXNc0QcP+qkWWl3wBeJ3+qHH?=
 =?us-ascii?Q?iLL7IesqCsmE20h/LiRYgsztXsmaAI9gGNIQXNSXuXoTB5Wz2Wv2Zl72PEdm?=
 =?us-ascii?Q?ev2XEksU3X+RphcKmWwpJhnvVJ8OvwcdkxWvJpWi16JSAKHWxhGAeR+KEZeK?=
 =?us-ascii?Q?qLQG5kr0dBdYUyg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:21:05.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a17ade-8da6-4a29-1c71-08dd3649c6e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

Kernel test robot reported the build errors on 32-bit platforms due to
plain 64-by-32 division. Following build erros were reported.

   "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
    ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
    tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"

This can be fixed by using lower_32_bits() for the adma address space as
the offset is constrained to the lower 32 bits

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 6896da8ac7ef..258220c9cb50 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
 	struct resource *res_page, *res_base;
-	int ret, i, page_no;
+	unsigned int page_no, page_offset;
+	int ret, i;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
 		if (res_base) {
-			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
-			if (page_no <= 0)
+			if (WARN_ON(lower_32_bits(res_page->start) <=
+						lower_32_bits(res_base->start)))
+				return -EINVAL;
+
+			page_offset = lower_32_bits(res_page->start) -
+						lower_32_bits(res_base->start);
+			page_no = page_offset / cdata->ch_base_offset;
+			if (page_no == 0)
 				return -EINVAL;
+
 			tdma->ch_page_no = page_no - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
 			if (IS_ERR(tdma->base_addr))
-- 
2.25.1


