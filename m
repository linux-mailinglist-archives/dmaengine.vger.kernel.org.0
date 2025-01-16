Return-Path: <dmaengine+bounces-4134-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F77A13E3A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FFA3AD687
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3205722C9FD;
	Thu, 16 Jan 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5Ki2WVU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214E22A80B;
	Thu, 16 Jan 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042800; cv=fail; b=uronyzmorsPnkO3bJUnu0/ll3sq0XQazLpzTEX6A64zvr+mXDXSERtsDmw4o/idNvjDk0UlAmQBWRi6Wn1jHutjdM7S4jyxoMFgbKgl7X6lvz9szxd8+VmDG5RjzcK+OtKNSTA2I5ePrC3mxBeOFwaQLH39KWk8HL+l9D6agF9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042800; c=relaxed/simple;
	bh=J+gV2EvvXirSZQvIpuIJtnAAK5VucfCIH5kdbnHFO6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojy0d7NUiEyi7LpJSIlZxwtnpXAX9hB+nLFHA8Kno86/1vhlvOAgM4ZCbOBX0VEhfTYds5vG+AgCMfhS9iOrBvtncueY1LDCUDyB9Q2LzDy5TW1eBt1p7Hpzf2NWMskjcp/RUiDJc90pwFzqLyqjABi5z2qXakC3DjB7nZI2lk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5Ki2WVU; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhHx9HZAwSaL1IZf3BmKnmibjWT1WIMicQ87yJ1WI9m2QWV6YokxWXogR9Z6G5Er+5FWYZQxj/VSqzDXDDSMcIINk1AbeqrPqxSbWd8m1IxU2iqzLldWoUhqflDOgSw/+mvnKrzykJXuiqFQje/EwKvM9SlDIPHXQUERRyJ6yO10d9eN5t8kxj+lauS86cWjk98HsYgnMwkMklshkA3/eXpn3qrGU6QkwKpWf7BcFYmb5f7qKHaXDA8dpLZA9R9kxWw47pWUzGsb5DPXP6U7YahReaNjqvoXnQ3Ky5H5WY7WWin0y3qiP7UOTHgJLp1Q5+nDYCF49koP/yfPzbftsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc2xO+uQUwjrtk6Mu8deOkPM7izeY0T1xz4B6A3aKUI=;
 b=pD1kgDVngbslspr+j9hDLEV2d0xnRDOsCDiLpTgYawiu0gk54c5FFGa08cISnh/K0WkN7EbtessrflE3n3JdVwvP9Gz0+WB2uDvXRgKtKP67AKaEGwfOJ3AMIerwtODHbiU0Wbm+dPbI337B620Pv5O0UUDCKaU1/NXojEsrJrq2fnHVdjTvBMLP52DJXU/2LyCTxx9Lry/LDK8HDiKPM9MidRamrL/BoA0xELTLfia1PgjlKc/QiN1eLkM8uFkcX3p2lvGg0famBoBlpsEbjMobxpHsEMmhPHIBrCrlPateES85U7nhtO4EpK2Pe+sO0RlWy5cuZ9j/hKVCjW6qLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc2xO+uQUwjrtk6Mu8deOkPM7izeY0T1xz4B6A3aKUI=;
 b=W5Ki2WVUYWGihEiTfzAWETQ81bDim765kcrWCL8cccfOyHHkBUAuSe/kPFyopOW1LwbpBPvaJI/Enwkvha7EtYVqJj8DnF/hGkT9hEuJGS8QSu1CQGn18BVo48BFYd90E2XvysoGZqVVlEPq97qXQlxEhN2CcmyYOLhQEO8uhHJnnXGWtFpaNZpuV/Ea7lwy56CQMTeAbV8CaTL73DGiDa2bk1nEeL2MbrbQ0HfqKQ9UAd5lONsbCP4cWJnwXMUPS0JMPwQ7xnlNxVTOn/ZUBnuZZNrbdov28kvwg8yUpaShGZrngGuKQbhK5ab8rX493zELxDXpVo4Y6AJaDze+Ag==
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:53:14 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::fe) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Thu,
 16 Jan 2025 15:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:53:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:52:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:52:57 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:52:55 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
Date: Thu, 16 Jan 2025 21:22:19 +0530
Message-ID: <20250116155220.3896947-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116155220.3896947-1-mkumard@nvidia.com>
References: <20250116155220.3896947-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de803d3-cace-46e8-b8d7-08dd3645e26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+jJ5NUxCkTv8eZIYP5O+r2Du2YPlc3hV1XqJ6TXTt6jks72aOkelC4Y6rMX?=
 =?us-ascii?Q?eNHzK2/UFRRRp6lgTZ2qvOQAKDh/EuhTPkhWbZZgYrY+kJq7q0Oq933707fZ?=
 =?us-ascii?Q?tF+mlv3yNMZsObxV5WVBVdeP836SUn3ASRDaHhAcuDWdu1yf74WjGK3lelQa?=
 =?us-ascii?Q?YnabGSuzqW/hqeA6vHgIBnquTdb6BFUmi3Fj/SP4wO2XlwPvi9ZbWwq90ujC?=
 =?us-ascii?Q?h/wrb0YdzPgF2BuGs7/ueGP65VAlAsfUgM1pFFV/SdT04uVrZ31WkVitgijr?=
 =?us-ascii?Q?WTUeIQK9PEiGSP33VkTJj3DYZIzCwKPGSJEaIh2UPVIi2WFxXlO48O27QPdG?=
 =?us-ascii?Q?irQWxTPXI3zFV+nh+0jDdYL6cB/uv5KPZifTh+ojgekHRXKTnatWgg/rW9CS?=
 =?us-ascii?Q?YDP4mR1vqbnyGPVBUZNdPWggQk9zG2Lj02hqiZ0Ls3d+eVarAtpqqEv/asu6?=
 =?us-ascii?Q?pq4UiqyOKoEP2PEb4O+P/t8Bx8bNhZig4zg4pekfMCdU3oLGCHOMB4AoGPTY?=
 =?us-ascii?Q?H9c4eJgXTXQoKtjLNx8dPpjIOdxFOZQ+VZs2THRqBzYRi3O92Mzg1QqfFMww?=
 =?us-ascii?Q?aUxaai7dp8+eXx3osRDbco2L4vtKFkjBpSYH2AMD4vGljGeO1+IXCq9rR3KK?=
 =?us-ascii?Q?3+fl47OiFPTivf/4k+sn6c4jU/Sr6SG766TtfigK3TnfrF7aXcCaVDkz8Xl2?=
 =?us-ascii?Q?Fzg+OMcNSpllgDWsgRUuNHC/pqY8zEPaLm/6A1JxdwBf8yOwC0GpYYjQVkyK?=
 =?us-ascii?Q?LvFxsxOvIVmjhTP0bafguiFXkHtKKZSy8WuFGNMwLwCvcdNLpWCfWztMuNEz?=
 =?us-ascii?Q?hECbL1XDLPq5alFfph1zamPJpMdzXhtnb4PXN1WrmqkfOXcxaMd0FHI34Elo?=
 =?us-ascii?Q?k/C7Cy5W5lk03MeED60Rcd7Ijxp4p9MBBxBXr9yx6ooEAfFkavG8zKaWBMC1?=
 =?us-ascii?Q?e0t7/LOcnzo0XxLe9QLkBVtPPHxpGRwUNpTfjur3rLH/cj648Uan3x5XUdNG?=
 =?us-ascii?Q?jJjPBaGLo1iYxOJk7dnPAASK1PnebMehe1955ZwY1iaMu5ozBlqfeg25hIum?=
 =?us-ascii?Q?YTuRGAdyfvPnEFE0VaKIIKNKxm6rM2xiIWGbocVz2bEx/epkL5cExcaOZpWy?=
 =?us-ascii?Q?UgwEZhnNztQFUgxOUla2VFp+hm+qdBUnGoRDtccBJ5Y/U/JHNnfbNuggUQ+m?=
 =?us-ascii?Q?2XKF2J92hRaWi76WdoedaEBWAZ5OPoh+CF1QNI+Ythx30au5QZSYeExHV+aX?=
 =?us-ascii?Q?wB5ms7xparSt6PrTE45MtrOPrBsrT0903QiITJ/oisiL3Uu7wVTv/aYFNXtg?=
 =?us-ascii?Q?+GCGijBjP0u7zb5n/LYzXbPSxjI3ESikzCX2kShzvNel2V0o8pcWAOLhDrgJ?=
 =?us-ascii?Q?8sRIjaNQZjNn8WW5SGHxukl0u+vyvGi6rnNULT8PBjDPOpFeby6f+KJbqsTc?=
 =?us-ascii?Q?DpSueSe55DpLCD1wVNZWk6P6Q2JwXIF4bM0B14eNTkmLYmO0Zm1V9JP4j+GS?=
 =?us-ascii?Q?+eRhFqXu0TgqdXs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:53:13.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de803d3-cace-46e8-b8d7-08dd3645e26d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

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


