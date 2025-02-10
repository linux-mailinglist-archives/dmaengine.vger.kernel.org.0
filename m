Return-Path: <dmaengine+bounces-4386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E806BA2EEEC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6907A27E1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3F230D3D;
	Mon, 10 Feb 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9otDRo3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5222F16D;
	Mon, 10 Feb 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195680; cv=fail; b=DvBq3h+0xaCntJgMl7mEMydwZpy6ijGLmNklHqSUm1vM3tpg8I6qPzKeMty255Csa+wkroeZPvRKjHK0gbwsY/YQeSMY6bHIuIIKFMDhS2rskoomEwNjNz/pds/YTm22Ktsu8bPUiHnIVje2MUZ0njSmvqD+fLp2qRgSyipcD3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195680; c=relaxed/simple;
	bh=hDDbcHtYR15CdySJaKFUkp9WkJpkRQT7yI5+iWYfwiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVsWFt7dg39gDB0ybVjD1XmL0QzrFrrbJuGHIyNCIgvTvgMqZPc/I5eOJ41eZva7mGvAW/wSarOUB/LaGhQMSblHqvjJRalVV36HRAzNh5q+h8E5Jfwadb9vBaAnTILxYQUltPdGRGTH30YMDvhdoRu8Iqt94WvHrbcyfv+Nywk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9otDRo3; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJgp8cNM1C6S9CL17U6akfWSrpHXXX5Oy6kbYb7Hkk/4OwW6MHxR/t03bl4TYQkbXs+OODl869fXjoqi+TUNLD6xjY036Ad358NwHKUwSyTkcnO+c1Nd8QSVSS5OhnNR5WTs9SwCkvmEHr8zvJSfcpyv+RsyVn/velvpBIv7gP1ROrScAS7ppNW54YPAVAZkxtg/NSdZUdUCSTg6VvU1WbSU4D2dqFaYlgMraHciCYKJwYEtg59oTJ19pex8gPv5DCDfRA/xOK7sQCqQL5UJkrHKrHRlkc4H4KFghvLcob2Y3KwGhgfntuUywxhulnHxi4xXJfrk1Sn/UUq3fPM7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck3Rhz29Wm2yMyVtn+J7mWc0ftqLV7UATlW4ROoIYz8=;
 b=kPeGm9o7Fk+oxlw9e6LgRStiHSICP4R2cWeSwxgyT4U1tBbW1YBOQNL3azMpiGVI638V2jWzylWLlEm7ulYk3rrjdDIu16KtR0tRFYvGSldUMTYBmJ5YtWIEpulO4xjPXs0lGtH1yhvZiGX6yYijO9acJvsbxg6tI9PfgjbsugUdOrtL9VtvTPry6SwvlFas5Yc3UvtIP/a0S7Gb2lgf2KiftvT8xLcT+CZGfHZmM/meAnriBU7ckOBoqXalqiQv1e/oj9geG0wFLrjMzsfjsP6fhldk6JRe4mdpSyXzpRNpOGlDQW+KWh5/pFs8oXNoVilOmeqovTYCUXJSymFexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck3Rhz29Wm2yMyVtn+J7mWc0ftqLV7UATlW4ROoIYz8=;
 b=U9otDRo35LvpkVikD1G7qI1MGzAgnJaIftOh3W2QMIlFWSMcWkJF9fFe32MEEOTyLKmRKhwlqLXSPGWsy31Q4u9FDRTk3Mo31pThhaflHWpFQzefJQgmNJBOxQV/qQemxQJqXOf03jk0U1OFhVCk3J6FrDvbWhZJhEqZ5+A+LTXSr3zD1+K5Y7zMk70l4aM6NPl61NVcPbyd3sqqJ8R2gbek7AXUYEqa8rSGRxDaxx0hKx6xh8AN0wkSPsv4WKM6kxyVRfs09VLqXYoDWn/Ip6XhDsqg2e5Oq8hbcrrCpFqs0+rizN6fbyzZNMOh0btQfmsJlvWkcSqNRsxazFBtqQ==
Received: from SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) by IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 13:54:31 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::1d) by SN6PR2101CA0023.outlook.office365.com
 (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Mon,
 10 Feb 2025 13:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 13:54:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 05:54:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 05:54:23 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 05:54:20 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, kernel test robot <lkp@intel.com>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v5 1/2] dmaengine: tegra210-adma: Use div_u64 for 64 bit division
Date: Mon, 10 Feb 2025 19:24:12 +0530
Message-ID: <20250210135413.2504272-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210135413.2504272-1-mkumard@nvidia.com>
References: <20250210135413.2504272-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0cea58-0a10-4ebb-aeaf-08dd49da7160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VZRAoyjEwB/Zt9KnKSfnYpayt80kIUfOvDwm5r1otoshw9gA4wTfzOv/pcC?=
 =?us-ascii?Q?bY8aDiZBjnZrVfFVf6jRFtU2XWIsYNLk1JwYHcV8gS6J51WYSUDSw56n98vQ?=
 =?us-ascii?Q?j1+JezzDKszEQAgzzrmTtDdbM/HweWsHB3zY6yz2O+jNftbmEcgFUcvqFaZw?=
 =?us-ascii?Q?fVN6wYS9SRyjnaKT3XDS5ZpPJ5Ez/jttKn+bD7z0kYVhGzHRLg6hOSbiFoJ5?=
 =?us-ascii?Q?acdpEzz6jf2GHPQWLlPYb0TL2e2pQ0HtUjQ519ucDWcayXNZmib0w0BGzFjX?=
 =?us-ascii?Q?55aQHZyK7PktJaf8S57ozKlAflUu9AmiEY9KYmdrgn0Zzvg49ucut+WYQik4?=
 =?us-ascii?Q?yEJ04RtjyWIVTYk0YJRXF0BzsH/qNNDk8i3tC8OtXzcXVrNmT7lX/daC79k4?=
 =?us-ascii?Q?zIKrb0lQX1YNuMHqXmaAucM6qavTGGb8/x/9kOXYebSCJ54jLsNLLmKw8aKq?=
 =?us-ascii?Q?JFKMXmxBo94k8iWqYiaBVHY2tNeIpMMYGozpezIVws4cSwRGnXiFeI4Xly2P?=
 =?us-ascii?Q?Kmvos2ayTeOPD27/RdMnK7Z5EdG4jvwCmzRfYkjr1k3eokVHXMQGs/CZ7qWr?=
 =?us-ascii?Q?CP+PQ63gvabJyctNYUl2hijse0CZVOwBeTZKCHcFhbA3Ue17/gInbMr5XpI9?=
 =?us-ascii?Q?4WzfGdehrMwFdxM9RLSJAfyfWiaqhjip9uG32ElkgXXgNXzFoUhY6wn+GWIB?=
 =?us-ascii?Q?8va/YWFNDpz+y/pOIALGPOdRoxlWbtXBEHb89BRaCOPUM2UgkMyYGelks0BW?=
 =?us-ascii?Q?vrsgTAMJ/hlgT6PuECJej4SxtG4tnhyj9n//BJ9TPGoD2M/hwNUFbrCLlr59?=
 =?us-ascii?Q?JiO1XoZC87aeADo4HzUt2DFtEr4fX2VJ8rC7shREoajojqdGLGGSuUiAkTP4?=
 =?us-ascii?Q?Ni+8LLL5KddPvO6Edeob9pzWb86Dzd3NZvPacBpp+avQFpLWeFFD8lkfH6z0?=
 =?us-ascii?Q?5tUCEciWohCnzOQn5serUAyzWAtbZWk3oqRWhU3dM+BNxB7xcQpo68TjAsQy?=
 =?us-ascii?Q?9oFAcNVcqAVhWjXzz+P3ZvtKCybX5CfwHTya9w+51aKZHxrLNW1vSsymoe0O?=
 =?us-ascii?Q?m8OXywOfju4H6c4ZYDaKb2YNzzWZPcrKFRb9IgeKP4Y7Y2BOq3YioRzSOUQd?=
 =?us-ascii?Q?Y2PMuikPWAcirRm+j9g7n2lXvShTHyLy1aYGzOzw+Apxl3vm1PbyVz7RvZVD?=
 =?us-ascii?Q?1a+Tp3GM0TMSlsRiolyFr1oktpQK9BvxRk9Y40WxR3Gyg7wpv2qEAtqLPTAM?=
 =?us-ascii?Q?GWmVdlzgnwJ/G5Ire2Snrjp+q0CvL9qyC2yOymshIIVjnoyrNvAAQKYQ9ULA?=
 =?us-ascii?Q?fixTAAompLkTUpTWSO5/lsa6botWErMQ1cFihWt1ynrLZettTZEDzLuw0CD1?=
 =?us-ascii?Q?Qah9MfEvTbADO5+mYhyAQb4j5+V/WebZTEgnqgK3dFllICFK1pv0mnHeo0Ce?=
 =?us-ascii?Q?ixwf1VmlybjEbHLQR/o35Zrp6AWM/28xaVFy7C3z8Fwsy0sgdfNJbOykNaA6?=
 =?us-ascii?Q?y2w886xK5XndTJI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:54:30.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0cea58-0a10-4ebb-aeaf-08dd49da7160
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

The ADMA base and page address are represented using a 64-bit variable.
To accurately derive the exact ADMA page number provided from the DT
properties, use the div_u64() to divide the address difference between
adma page and base address by the page offset.

This change fixes the below error
   "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
    ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
    tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 6896da8ac7ef..a0bd4822ed80 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
 	struct resource *res_page, *res_base;
-	int ret, i, page_no;
+	u64 page_no, page_offset;
+	int ret, i;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -914,10 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
 		if (res_base) {
-			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
-			if (page_no <= 0)
+			if (WARN_ON(res_page->start <= res_base->start))
 				return -EINVAL;
-			tdma->ch_page_no = page_no - 1;
+
+			page_offset = res_page->start - res_base->start;
+			page_no = div_u64(page_offset, cdata->ch_base_offset);
+
+			if (WARN_ON(page_no == 0))
+				return -EINVAL;
+
+			tdma->ch_page_no = lower_32_bits(page_no) - 1;
 			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
 			if (IS_ERR(tdma->base_addr))
 				return PTR_ERR(tdma->base_addr);
-- 
2.25.1


