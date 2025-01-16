Return-Path: <dmaengine+bounces-4131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D21A13E18
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4F16B1FD
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179822C9F5;
	Thu, 16 Jan 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHR5vIaV"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6022BACB;
	Thu, 16 Jan 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042310; cv=fail; b=Tuq5OTB38+CaaKNtFpAVLnzHFguzDAuRtA7itoPR2lXUnoWwz9EfGvjyxAtbh6HSIrmjrc1LYvv3FFQzDP6YGlxXx5gkZDufnqL3MggecGMhj/OBz83q13CRiX1q7BH+LfBByhV+8UIxp2mlrDhFBgP+zltfeDzdrg6NaVEYjvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042310; c=relaxed/simple;
	bh=xb4//gi84SlmMkWIUWrnEl5d4+LeehOrC14LiCNgJmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ne6ITeLHVVTZbTp5T1ilT3o5q7Eu1kkBWoKYzRjA6VVXL9HklujNhaFgeWVqEK0U39WffeVynqxxSVX3sSFviSgUg86+J25KxYsoYSKPz0B2eacdZss7XFMEV2y542sU66Rwi+2x6R6yXUjJZ2hcrdkCk69bMJCIKDc5S4JSlk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHR5vIaV; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZbJfxvK4sai7lRxierRI3sB9+RI7BKRzQGNOmB/gl3JGV4VKeuVHt0GhDcZvlJKqU3thLtzgvZ6UbU54ai7HRbcSQQRgLyBJvMi7/s+rR9lkUin+iiRtZ8GQccciEgNEM369vztSKvhVHpxeGFE2JqWOBxbQbcm4UsjM8KnDyOqsgctEbg3HsTXqzE1uCIy67oaPba6PyA7rr5xS14O9c4MRc+LtTOUMuQuwLO6m2XzNQ3HDBH9KjCZbrcPVnyb3b2pa/kCN4S9pToacp8NVreRDjzXOhmElKAZ+dPbcyfojlgkBRxPlfuhOOP1AUfPyRKv8aplkCb6dv6+4QLjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8FakzpyaekUCTn/2IHrN//Y6TWj1M8M1Rwf88xZQ0A=;
 b=gXnlQDIkqFux785gFwxxyt6ZdVRG4d5qQTBzW2cznfovCS2i7HUpQ2d9aLmAQ2L3B6ZbHZl6qttoZXHJ+p3GyFiMmgGodl3CFEeypJYNEDAl5S6EZNiCDIqcgz5CgRDR7CiI8YxRwjwUB/dpya/vvlra2Q3S+/I8lUDJy+elWPuIlKdZpo4qu3LvE9cMKlOo/H5X7TM/sCfnBcvLW/tfiV8SDae0Z9CwdxBYTVoq7j+eHoxEnImDpKAjJAqxr4+W1HFYGVW1njxSanEm2eChWOnAAv7d9E87gk2UKkRoXouoFzcLPNGLpVLEkLH2SMalTap/MfnHjqqQoMw23j3NLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8FakzpyaekUCTn/2IHrN//Y6TWj1M8M1Rwf88xZQ0A=;
 b=fHR5vIaVYWoZf7ZMK5r0AVpVJke10/XtKWkQy8FgJbXhCit90G2sBfPs4VzFxtDSWLMoC4sdLPXaZ5hAWIXoNDAqAC/TnTYjnLohH7VV71D2raQNBX8e4GJ3vissY0SOhGx+Kyrk4c4/2CP4BAbnDmQeL6KrKjoqiTtHVbWEVzsArTydjb/keAuhcbmWes6dEnDVIxBSSLjzzIjNO8q4cDoNPP4DwOaVHCkE/9tsAe/HAStrT3ZGrZ603bzCWXXm1Y2iNj4M9nSdkRu17VYu6/ehIOdr/+FZ2JrisyRJ/VwspVMdsa7co8MoymtPMTvTQmIqGlupIIP4TnOV0IDJGg==
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:45:03 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::70) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Thu,
 16 Jan 2025 15:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:45:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:44:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 07:44:57 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:44:54 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
Date: Thu, 16 Jan 2025 21:14:38 +0530
Message-ID: <20250116154439.3889536-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116154439.3889536-1-mkumard@nvidia.com>
References: <20250116154439.3889536-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5ef55c-f0e1-43e8-7ccf-08dd3644be1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rLKdr5HqFMCkMc5ED/JLqzdABM2+W4eTKJinz4M/nZctP4Ek26kWLjzRnntD?=
 =?us-ascii?Q?usBEBSiQ7uRaW3gb45m1Pp/Dhg21Tv+W5SnSXeaV24Gbiti0o2mbi6oFsICh?=
 =?us-ascii?Q?D2QhvVQU7hxKwfqXH/Gb4RnJ3dtLW8LH0RXqr8BWEvq/rzT68fsgpQ//TlRE?=
 =?us-ascii?Q?zGdOMKb3Splm4AOCtwcp3EUIKkJL3OBtEXMLsVITaUFnuWwZWqlp6+NpXbes?=
 =?us-ascii?Q?5X6pdv4QCAGHkf5sNNJlMVST1ge6gNU2tpb30e1rSYmIUIWk7mIMuYBcRH1k?=
 =?us-ascii?Q?RB8euH7uJDSC4QoKQjLXcwSHTqEm8eIP5zP1NL0qHM6rY74BertVAHvNZ2Z9?=
 =?us-ascii?Q?ZOLuMdOe0a1KOKyWycHg1+Mi/wE6Y4ZeJxrmS3ArrflErTMt7xePokaG6Uu/?=
 =?us-ascii?Q?bWnwn4M04iBtOBlx9EYLS+ml3QgUdNHShTi86YKhLLWlPE4QdEVX7R0nw0oi?=
 =?us-ascii?Q?W5/x2zLocXR2raI2CPG5QMdOYLpvsG7NXOUhSvCZJxFJy0GIpyJzx+7riqo1?=
 =?us-ascii?Q?QVnzlF5kMBwvoD02Nh4n3MgKsTIcr3uXdt4YuMilCDZSop6MycLj0fzpAW8D?=
 =?us-ascii?Q?sB3hfTWyO6NUM40J+Y4ukwacFWO6pIDhpPtNGQI2icoyX5ekpusR3uZt5W4K?=
 =?us-ascii?Q?ONaK+6/8G7qRxioGtb0m2nOLMujdzP5U1Jk4wLVcFUYbCq9Ic46iFIJE+NYG?=
 =?us-ascii?Q?FopE0MkBcyPHsyoVHV3DGjBh2eXiDMaspRxSKKaXIX4qlCA+9omNIcJrSUsn?=
 =?us-ascii?Q?Sz/YEFHp3tMMyXP4MVCVPi9mPxj+A45mTUedRdwPLfiM4cSLVhXGrFnH0vUF?=
 =?us-ascii?Q?SSvyIv6qOnN6KsqOvjR3iZkHTGb/zjpu8KELrgzlbI9tLYycs9MmuCW7ktqD?=
 =?us-ascii?Q?+0IctbrQDgY1qAA9F6fTB9p5Ak/wWa8vXD5YkgrJHhW8OQbgSz5tvIdzO9Ve?=
 =?us-ascii?Q?PySXVWapGQD7faVEFDYcUg4gYh1mhWGoZju/h10BawD7F/VQq7LsI1Lueyqf?=
 =?us-ascii?Q?iB4OMZhq3BIW48L1Op0bsaPhDlNAne8758Jbtgm3ul1asaK0eyv/4w4D3+ow?=
 =?us-ascii?Q?/8Zorjbzmelhh97OixYgCSE5Tn1JM/SqkHmG4wGyu/rxoofr88JgFaFL4DFm?=
 =?us-ascii?Q?5RUAzxlJIxKwbP8O4PZC5TaVzH5TKDH7ZHu16bMRpRrLG6d1WyGf8vzXSnFR?=
 =?us-ascii?Q?Kx0+FFnLvVUXvWGTVwpmW0Du2KfstMXdQTPmfdHxu6waQONAKNaYyqja9rFs?=
 =?us-ascii?Q?1VPV9Zs/AgjfnU7lKKDIwNYDj7+alknnTb27reZnw5t5B+k5j+4k61Hvr4xa?=
 =?us-ascii?Q?4y9ZSgbDKAh9btBVeBFMLqXU3mauRtQQjEVy5cxe9EfjBxk9v4WLDLh+eovk?=
 =?us-ascii?Q?QJkKRp00H0BVLJwd7lhM4GEE8orkk8/Np71x7einYzDul4SvXmNm9vwWc0mq?=
 =?us-ascii?Q?mVykPXYwE5L3UAe8zcB8HrOR4+awKpoHZQLzHHrT2uWkqI391p16xJNohZWZ?=
 =?us-ascii?Q?Hni7mCxKjmW33cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:45:03.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ef55c-f0e1-43e8-7ccf-08dd3644be1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

Kernel test robot reported the build errors on 32-bit platforms due to
plain 64-by-32 division. Following build erros were reported.

   "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
    ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
    tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"

This can be fixed by using lower_32_bits() for the adma address space as
the offset is constrained to the lower 32 bits

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
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


