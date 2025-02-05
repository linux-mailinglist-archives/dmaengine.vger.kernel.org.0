Return-Path: <dmaengine+bounces-4282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B8A282E1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 04:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45572163E84
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C00214221;
	Wed,  5 Feb 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXu65nsq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135B214226;
	Wed,  5 Feb 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726326; cv=fail; b=XUbD8JEnqHuveuRK/J8dNkhf7rgNymW6DWfhbNQnpg7hgJ4YGbm25smBSIoAA75uW7hWWf3LvePn2vWbF/3TRSqCGXI4eA+PEkRheox/oWRMFtetawyIg5EBRL1hCCBAYOA2GZLP0EpBXEEHHdnakcQVf/BOfizRpiiCRmYW8nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726326; c=relaxed/simple;
	bh=60k5VW81N9TJ1FFk4Q6WpVOZZArnzMNe9+lWZNgHSqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQWj4M/MK+//Xc08f6G4F7mGfLj5NIVQBgK2iAhM3DD/+OX8TXrpZBp1VsWmEN+vqktb4Ws4cjIT+Sw9h3a3wRJ3FdOll4khMhmd7mW+qlJ1LMbXhw6uf0LdmwmLWoHM1hK0ShDarA2bsD9Pa5dAntVwWIrbP/VZPpJ6VhUBPN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXu65nsq; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGav/tl2++DGQepl5eOO9FK39taYuANQPidcuwd8hONor7zd/GN3MCAao5rh7cCyrmKJYbz7+T6KMDhcKtspX6BVMh56sqAdDDEvJXqLj/1WHqktb/aZYMG8+FyKnmvpGJNzP4RmikJffoy31o4XwvU0Xf9IjwX3FBgxLr3pJ9Um/Bim0F/G/TU/n9OcKzZINhUuTFcH/yJosSXWvRUNDFQCZQ9mfh4vUL27aZyst4yAtS6n+X7VURpV7U2Cv1qTIO9q18rgOLuhMKiJI2x5l+6fOS5t0QnahbNsYAbwPg+RJElHvnH33qHmvhnYkiceUBWa8RS7xJP6OFfg/TysBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gZA/n8/TatjV3Pk9FrL15YlKUuLt5mxCQmrvi3yEw8=;
 b=fdI2XaGy7vqSN1TfEtka9TH/TpBR+jUVPbJXyQHQeLHcgItIo23rStqFcQgjazJergZAVA4oO7qjVYJLE07RhCG19KDDFzsESVA6+E5joKBTdacFOcTpxTw9u2M5oAfq4sLK2vdpDB6rQ3YFZPZ5n2nq3nOZVwMesJ47yd+qzf22q9iz7MWOqPMBzKOSrFMKLJmpO18HOseHvH9tCMCgMuQFC5nucFrmmD4VTXAbnM/xsj/v1+M6WSZsVopWtailzh3ETG+SimX0oXTj5ksF3FljAXQFa1LyTRAV5aFPWgkjvB/B4SLAWWOWNovp2H2ZwsqLKMkjUJbY2deSzs0pcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gZA/n8/TatjV3Pk9FrL15YlKUuLt5mxCQmrvi3yEw8=;
 b=hXu65nsq2RcsNo1DuLHA8zI5riUXOcvezHa4Fo5L/TAwdICWB31SoL0Tssln5ZiPAXstA+7msV0CzmHXQxm/vbVjVqICPaAw05DydDz4bNMUrpl0rwEE+PCFjYsYLDdvBRklB2OBBCrls1F2T/db87uEkuzUtLPBVxAgrIZtKCmECutfhQV2OywMs3i+lYncdNEYa4YNYWOB0ZBG1h0tpr6lEBKNndJCRY6jsK0mfhUGC5QThl17XJI+6yVp58ym/BVVcSfLuRrTFDdXXnIQDDz5ylbakxquKSZDVHKinwZNtih4FzAc6UFr2QJtKezhsoKS6eXhZRmvJOdfmzyViQ==
Received: from PH7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::9)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:31:59 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::1) by PH7P222CA0010.outlook.office365.com
 (2603:10b6:510:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 03:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:31:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 19:31:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 19:31:42 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Feb 2025 19:31:40 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
Date: Wed, 5 Feb 2025 09:01:31 +0530
Message-ID: <20250205033131.3920801-3-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 007ec9b4-bc3e-4a3a-a457-08dd4595a61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZF7M7ISDpYzqih+u4I33Vvziw+dr167DJYBdo4KwRL0p4zu8QYO150vCPxJJ?=
 =?us-ascii?Q?EQrlzog6XPeG2d57yahy/IPliBwXxMtvfgoBOBvmUVwM3mwoUBkHgJlKQbYS?=
 =?us-ascii?Q?UI2d1p469YajCrtks69yEMYt6vU1DKduJ/pivdtYLaQeg/lTuoD/NAIkdIb1?=
 =?us-ascii?Q?RphbOsXMXyHpq0QCUOhl50mJA18iMC0BOYk52rIAwWYjCDFxojTEYnrqHePK?=
 =?us-ascii?Q?/Jjepu2KV49786vKL/m60/nXVd64vhD7FwSoogbf+L8bUXLdNmdMwVw5thqh?=
 =?us-ascii?Q?/Vh0ayUiFeXGJHDZL8TzWdIsrXoDa994CmI/KlclQf/SHcSFOgNR6IYAGEMZ?=
 =?us-ascii?Q?9Q1499B93760A7DKDEQY+1GA6bxgfN59BSnxMq7UeNd1C8DbP4G0wIJ2i4hy?=
 =?us-ascii?Q?8LOKHSof11hTTUgCed8UmJ7Ma3iEvje53m1n05ATsLCN2f90LaAWp1gl+Ao4?=
 =?us-ascii?Q?CaQ7umXF2y19lpMe0AaOgfZ2NaV7FMLX8cAikuF+7Gtbs+3E59LRU5q9sXhe?=
 =?us-ascii?Q?1hSpFxTV4acRrgKfrXlFA0RZcDCGAbjR9tFsEoGTc+ub6tS9sp2CtasoI6z9?=
 =?us-ascii?Q?JZhmQ0VX6D2uMK35wR79p5VUslgVakTD/dkY8z3/KdMX6U4fIOse6O4wHYCk?=
 =?us-ascii?Q?63hnjva/Wl2jHstlWZgQ5fhgWI5zy768hRSWROgTba3e6SPJqsI1OJt6q51d?=
 =?us-ascii?Q?510+tkieT9yr8CplaAujsWuStLjTkieGWFxFShFaTlyb/uHK8BUHN0b9HDdy?=
 =?us-ascii?Q?HHwV/SSRCm5PlRLXbSJ6rs49CmQmTlGDs7QrDMxoCYSWK2nFRvbYcFyHsA7/?=
 =?us-ascii?Q?CDoYlR5juYitaOEQbC4lJCL44m7XZv7Y7uT0NCffCbmHmE9g4fzJxf+DvxZV?=
 =?us-ascii?Q?ng3siVbC4e/iSvlMCJnJIZ0tGqq3G38pWkZU+RE68f0B/xELIMYt9zG4ol7J?=
 =?us-ascii?Q?687ctto4UL7mqzqtaFqT+HlP9NYBeNIXX7hRNmElz/fnxA9zUvvclfXKerMc?=
 =?us-ascii?Q?GagtzSq/6SEyQkZYHMP14vs41mjMqN9kFi1xwLVdQ/gz/qIrxgqgk3qJfmVA?=
 =?us-ascii?Q?NaUEnsIgbJsXn2eO0E+zP94vXg5VV/ZSt9LX85RwHGXcalJaIPGBnnVmLJ8X?=
 =?us-ascii?Q?4AdjuyXYIeHTq32fGLhSL2gqYRmGeCIQyt+3bMMeQpQ2wAF11IXeRDW8HQoF?=
 =?us-ascii?Q?ZnqVL6z7I0x3+fNwTKBFIehGTRljnUOWCSHYceIc3dvrU0pCIg4PMM4uSY3X?=
 =?us-ascii?Q?jkyryEZhPGY0e/f/EXX1FjKrYv+qdgpsB5xZUAfQNm9Pm1zzIAUAZfystwl+?=
 =?us-ascii?Q?SPgOH8ZPWhEhG4lB1GXDELwqn5sxBnsDfsG2Xtna+1F+G2m2bEqEq4zD+ywy?=
 =?us-ascii?Q?45rMHoXuuxRiiMWJ4U+kakZ/kCSNuov8a/FaLfjxipGVrIX4hCsVA1v8r5v0?=
 =?us-ascii?Q?iH7cz9R5zzKpT9Yf5cN3ShWrCq9TeDn6/LPSVIYY9MOqVzMrFNtpjE2evYQW?=
 =?us-ascii?Q?z4q5xvsqfxswCp8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:31:59.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007ec9b4-bc3e-4a3a-a457-08dd4595a61a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

Have additional check for max channel page during the probe
to cover if any offset overshoot happens due to wrong DT
configuration.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index a0bd4822ed80..801740ad8e0d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -83,7 +83,9 @@ struct tegra_adma;
  * @nr_channels: Number of DMA channels available.
  * @ch_fifo_size_mask: Mask for FIFO size field.
  * @sreq_index_offset: Slave channel index offset.
+ * @max_page: Maximum ADMA Channel Page.
  * @has_outstanding_reqs: If DMA channel can have outstanding requests.
+ * @set_global_pg_config: Global page programming.
  */
 struct tegra_adma_chip_data {
 	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
@@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
 	unsigned int nr_channels;
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
+	unsigned int max_page;
 	bool has_outstanding_reqs;
 	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
@@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.nr_channels		= 22,
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
+	.max_page		= 0,
 	.has_outstanding_reqs	= false,
 	.set_global_pg_config	= NULL,
 };
@@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.nr_channels		= 32,
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
+	.max_page		= 4,
 	.has_outstanding_reqs	= true,
 	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
@@ -921,7 +926,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			page_offset = res_page->start - res_base->start;
 			page_no = div_u64(page_offset, cdata->ch_base_offset);
 
-			if (WARN_ON(page_no == 0))
+			if (WARN_ON(page_no == 0 || page_no > cdata->max_page))
 				return -EINVAL;
 
 			tdma->ch_page_no = lower_32_bits(page_no) - 1;
-- 
2.25.1


