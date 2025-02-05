Return-Path: <dmaengine+bounces-4281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0ECA282DD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 04:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830CC3A2582
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 03:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284DB213E79;
	Wed,  5 Feb 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a6AC/zHO"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7D2139A8;
	Wed,  5 Feb 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726321; cv=fail; b=e0VwQ670O1nhGzBaz12E2q9cn6IPtYqZy/qRPFhkZBt2LKlX7OOxQakANcQv0zEUd9WMXahYDjytbsJFZfTFohw6/VB19cq5KHSVknYx24mZx31POBG3/vie1Grz3ZYumcFCb4R0zKz+casXa8+CdTe08V/MLAfUTKZ6buCY4W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726321; c=relaxed/simple;
	bh=3qENRh7J6f04lEKUz+kzvxxRXctO3OzWtkIcLEOG3yQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIYt+s7D+7Tpa1CSv6hbsSoWB27vMzduJB5rE6TBX08yF7uieboosVXj1Jn6KWLmrogVrUYA8h6VLTPGlTTJxRy8Vu6bYjTCLMg2wHCDM7Tl/exeZ6Ez+RmOMNjApxR4lX7mKP9a/LXvTEdv7bMO+1/4tD1GnqEL4Mz4SHhkAXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a6AC/zHO; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWXTOm0TXld/rF5FKgsTqbSr02GF6SrO7TSbLoNbFE0Yf3HIZPudrzzpocaAlH6aLDTn7nhvvFgQ7mzVUQ2atpMe8AaCIpiRMQAORTZpt3sWbv8nbjGMxrlDasqW05sz8Yl72IWnV9uXPbYgE5GQJCKdbOyvV3dExH+pasMcrmar7WYOZ7Ih4z7QuELun8A3HmIKp3T2wL8WDnPdfwHVdq4E3sZIKYMAHQbgd1f8sdirO9L+m946tbplx5iKU5Q0azZq+qAAncWf6xKnV6/j9gvtH6TuRd5w6Dnvjcd2diVy7O4Yu6FndzSfkeiY+BQTDBYuWv9NFr3I7Aav/UT34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh8hOa1NoxhrOyzatYNpDgcT+59sZtDA6h2t4y5WNVU=;
 b=TJejvxT48VZz4XWnZEmr/+8r2EpRzpbFj6G73wChROcORuM0ejb7zT4dP00UZEUkTyHgMkN7ZCpj2ZKcBrOf6KOrUnVCsuw5Kit3/C7+UUYlfjV7Fy6fuykwtx0Da92aEDp5FkavJLwTXyA9nPYWgzULxmTfpZjMv76esaeGN49z0vcQ4k3nSwctGhZkNBk3ea3++3kSwsvu4ZFJsULVG5WFfEgWsKqL3ObVwOqwAZGNkR5meYCocV5EMldD7iiIv9kBF6GsLLzFef6c3V2o1bYvp+5j1S2+eY84JNEKAUOBLZ+h8EgYxQbT6JZhUUNNIxrkGkJiMJ1IFk4Z8nk26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh8hOa1NoxhrOyzatYNpDgcT+59sZtDA6h2t4y5WNVU=;
 b=a6AC/zHO/Sm9BQprq11NABdKZP2HXm8nffRJYN73o+HIrl/FGEvZs44swm49iDOV9/83nDeAFURKwbeUMhDABZEsK1hwCzS6tSXsrTbkBIUxYpQZB+ENX70w6LWX1JKckLlZiLyFeTdnugN4OF7RoUb2FPWMK7nhpzQf/OXv4imxM6d9s8nbFWwClqG9nf8BTc60XU0VrCvFsIMeSWJzXYoUxoyrKg1K21vbctoxlbRUO5kH9FdkuYz8EIkHCL5or/4kr5h2DwpnC7kyuvQ2kCgKN7HvgXemkWEEv7ouf9aIBtuNiic8SG+NXAH9fW59iZtRaJ9tDHColvoEGV3rZQ==
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.23; Wed, 5 Feb 2025 03:31:56 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::81) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 03:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:31:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 19:31:39 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 19:31:39 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Feb 2025 19:31:36 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
Date: Wed, 5 Feb 2025 09:01:30 +0530
Message-ID: <20250205033131.3920801-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205033131.3920801-1-mkumard@nvidia.com>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 282cf25c-7e7c-49aa-569f-08dd4595a402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82RWuSTQV9dHJzfTwu+oG0z14Nk0i1G8w3/mOaXHjwNKb5doBVDDsjZpJuz1?=
 =?us-ascii?Q?fA9okTPEJ8GC/nN6jpQMZGvC8P8tB2qMF1f5v3AUkCTN+IbL3fo29yRZihlA?=
 =?us-ascii?Q?vpnart4farCnllwX25vNDHURRtdg4wO5zmsqMQ5G3quAjSqgvagXU4WpI9Zl?=
 =?us-ascii?Q?Ut6JuQfQnBtY/MgjACRAVkYKY7G4xATNb/vCYtd7t3bRR/dDroUClaSLQn+I?=
 =?us-ascii?Q?obhzsTzqx6YZP+37B7B/POZzMsVQ1lmuVtLjq3gVboTkujH30tb00ZjEUn3S?=
 =?us-ascii?Q?6HH5nJoalPYnF2aX1w7M8ATuQIhAuMDyCbLURJj49c4V5i+a/5VmRGBi/hHe?=
 =?us-ascii?Q?ITLc/MB9rhGmYDlYeR44VXm+T4xwRWU9hQ/nfNtXi4/gbewpK1pQxjUeLTTV?=
 =?us-ascii?Q?Ghu98LYS8rQOREleNA+Xbj4KUl/Hq8x23assYLZ4wiUk30O/tqSm5TI9qwOE?=
 =?us-ascii?Q?GY35xl+tNmi4EJ8cHaVyZd2PVAIH2QvOfc6go6lFWESqY60OMqVTc8e6rPL0?=
 =?us-ascii?Q?+hpcB0S+R0GQQ2l/2LWywy/yZfPRnVKVlJveWlN/E9OaZOIqlc/el0sJU6Un?=
 =?us-ascii?Q?ucdxlblsZ5jPsSkzRSPqFYkJ/okxRbyleeZOTcZPLsVnRdYvtmVG4jG/8YA6?=
 =?us-ascii?Q?Pa8Laf7Gz0/3NVClpYz78xksQSCjSbBOxt3zbHYmyb2xZi+ehDPTtCPsay0d?=
 =?us-ascii?Q?ZE8dgiV61rJBea3cQsWqQtf2aLxXGF6DyrntigyP7kCirHlTr8HFfCnESMAV?=
 =?us-ascii?Q?5dMj0xf67j4x4YMfc6BzLS0HsjoufmP+dVy0TXOR9XCG/Yo7H/wssHO98ltF?=
 =?us-ascii?Q?zcCwiof/2mCne7SROT+u+MuPsXo/aHV26P6WeVGiKQNFNTqlQlVNoBNCiLV5?=
 =?us-ascii?Q?+kg9lYUqa/fPS/23j+SBDJhefVr6orQqQMaYsaYEWtzQbt/D10Xz2DzY484z?=
 =?us-ascii?Q?j2GlTbTgIIZEck8VrNAADY7pleMZPCOZbUmV5pcyzJ/9WD9czI7QdKNh6JF1?=
 =?us-ascii?Q?40NSUTzVPAqE9J1N3Y/LN0paZGKhbZnGdOyVWcawvePJUyn6qqfUSbFLL/Ex?=
 =?us-ascii?Q?8p5/puIoiuGoL692BHxkD7f5EqEDvH4KW2bk7XK7MCYX7IYe8KvcvaIqQQ63?=
 =?us-ascii?Q?PW/Z6U9lJwLBXpF+McubChY3sRITLVBQbcrqsvuUP+FhMH7CgSN9jvsiwnZ5?=
 =?us-ascii?Q?1nF9v8JOLYaEnzvWa48ROusRiWO6lroFhuX5ZPQUUAA1htTaZ9QRfNYjgkeX?=
 =?us-ascii?Q?0YkMmQrroZ4+YCd/8VnuJQ/F6N/nfcltYUzjUX6uVJ58XDTYiy0raplKpDy1?=
 =?us-ascii?Q?kWSKVM2O3G5pd9Cw+yRYaj8joadw6OnsIZ20ou+lU7wVpdVPeemmA/N7QQ6S?=
 =?us-ascii?Q?xTV49kzLU0ZrJAEtZreAhXY+olcnGwv4F6DCFKTwudqfz3Aqq10Nu0cW64Qw?=
 =?us-ascii?Q?O5g856pStnCZ4TcDHTVIXt8YpSqGD+fPgfw9oIy1S6uTK/ihp7NiffOSe4Pi?=
 =?us-ascii?Q?dXVn7CUzNfTwDv8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:31:55.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282cf25c-7e7c-49aa-569f-08dd4595a402
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

Kernel test robot reported the build errors on 32-bit platforms due to
plain 64-by-32 division. Following build erros were reported.

   "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
    ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
    tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"

This can be fixed by using div_u64() for the adma address space

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
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


