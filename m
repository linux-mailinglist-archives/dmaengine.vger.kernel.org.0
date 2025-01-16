Return-Path: <dmaengine+bounces-4133-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045BEA13E21
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00496188C2D9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F922CA1F;
	Thu, 16 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M5t8Ac+3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2C22BAB8;
	Thu, 16 Jan 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042313; cv=fail; b=AjrWQvf8ja9LUZyqaHqtgqS7ckbWrGT9JDJ378mybnBKpaCXS+vCrXQwdQ/gngKh6jTzJH+/Js/75qrbCNoAJSHNAP3+TiKBsjPQbBngbGsFG8/4IuWzm2bb4keA5VyBCX9GnMMLg57x/M6cp+cKGgt0FcCSGivzfDSdHch72w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042313; c=relaxed/simple;
	bh=D82bjHEZREEQejzzRBk0tbpbkvQk5EAi+EayR/B6YPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/1bMRk+LqLwfmZBs/aHAs8py8h1MTlwz52RuYUc2httubodejJtsTd7PImqx8Kf3z9SMILExCe/kvylfxMn8ElnDSutf6Ss2A5ROZ7g2cY8H0mb9zH6dKb2p5DtUBfhhy8Gd2dboGRBqV7PjdXjxSXhoeLO2jrHsG0inALu0BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M5t8Ac+3; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFZzNhlXYmTYuaO2McNCYkt+zgY+u0Ikd7TQrFx8w0JConcAcennZ3roJZtV0XHxpluD4oqatOknAvzV7ri/fcpoFP0G7rv5GF+Wx92oInqtKVl1pCncrzGq1JCNdgfUBWAlx3xPN5H4Uoop4AhsKUPFXd3kjxNuCBqi1e+2Dgpz1JNo03B7TKnmGIZEhZJeCNAQ0s8Cu37X0zc9SuYEmIVfPtjRv7c88hlgDhFu0wPH1E/Fiyv0RPT3foCU3MxFGYRk1jHtWvNSDTwDiwiVfo3oEvQI/9LfaMme7layUsCaA2AkmPvknCt3qX1crbRdq+UyRhNidhYbjYvZEwHHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDpkWBJDMMrvEkfIXlA8Sgjfpnsdt3VikUZ92WwE+Pw=;
 b=Uhwe2sG2zipR78lGLTFGjHfVg+gICtrPwsYFmEbzOZtgHjwgN1tfLN4uWM/Uzr5PSNkG1sP9IfQyz4ZZd5HX6pw7fBPJx+/y92/vFPwaCjm5ZkhNm9r1OyoJydRZ7p2ntOTlxDsPHj7+FC4haRMeJ3Yi06sX1xT5oXvmv0DHiUFjfX6ONrbiIUA4O3FDk6MUSxTfxBZ67N7Xeq2hk0VsU10rQjd1pBXl01eGRUmdTQf4qH/Z+dUxm2s8OoYGxVXO3g0AXvkSIgXZovZQuTlodPoDuYuvVhD3zepkVL5Rb7lS1wTUX8aXq5OsJZ+cNfe66BFBjXXDYrLzG4bgObG9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDpkWBJDMMrvEkfIXlA8Sgjfpnsdt3VikUZ92WwE+Pw=;
 b=M5t8Ac+3bwoqjRlbVnX8tP4QARvga2Kupw8DhwbHf5xpypZbsjAMRp6hcBOj0jMc+bUwndKpAeslF2DupkxG/TH4w6qTIJewNzD1iHKg2ehXgIP0iEX/3Bg889zhkiJo87Pwtg5VKPqC6CWuM8yYq/NI5SgQMB6yBae+4b11apr+UIaAb9LNuVqVABqBViIwY0q0u8l1PvSHesV8iKc8ZCt6Safn6C0wzEYwSNlSkts9axhjV3J0xHlXPYRbEivEgB0upt7zKUp90YAjl/gW4vqSubB7VqVMlitzWRsvJzjRdx8koMvu7yQtrCcHgllC4CNjJVsIHXCxMKnqOAZd5Q==
Received: from CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 15:45:07 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::a) by CH0PR04CA0105.outlook.office365.com
 (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 15:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:45:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:45:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 07:44:59 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:44:57 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH 2/2] dmaengine: tegra210-adma: check for adma max page
Date: Thu, 16 Jan 2025 21:14:39 +0530
Message-ID: <20250116154439.3889536-3-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aea5b3-1f61-4c4b-2424-08dd3644c0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KbnpLfLfbqOGiBAhr/13vBKhk73rQBY6H6xMhaXIZ0bGBMB37/OQgoQUWMwA?=
 =?us-ascii?Q?UzUcCu5b8gjqvIjifFGuek43Rd3LtS5gyEv+pjOoYUT1sF7hWPXKQCfXMQAo?=
 =?us-ascii?Q?U5FUWyyfW4ROCATFoM30alwh12oXlpl7f5O4droUl/PcTRmF5q5vQFJ7ecbd?=
 =?us-ascii?Q?P0z9nBjPtRjTos2yOjcrO5WtukEXL69I+Ucl5mifpvud6nEEtp7Qvv2V/jhw?=
 =?us-ascii?Q?LXLL1Jr6Fb55pVqE6Qm+/v3YSHe/TFk1HW27e2nJozYkzDvebWqGaPvozBD/?=
 =?us-ascii?Q?BCElkfPNIDyFhMnV1FcIWpOfsMNeoct+9sc1LkwEYpVBKL00hbw/L7XDpuCG?=
 =?us-ascii?Q?JEt8BnJiQoCrzZ8JTf4053nKL1PeiCpuGmNNKTr8jK/TDqN+ylzjgAz4KggL?=
 =?us-ascii?Q?lrz3V0VAAIICv46T6sIN94ZeJE6acXDN1QBas57k4k3yv58pJZg3QsQnViE5?=
 =?us-ascii?Q?L6RI97GhxEk8NKPlWyAhFUjo8LWlNDJ/cXhxxsL0BwOJ0ouB5BP5/Nm2UQow?=
 =?us-ascii?Q?babPnCBpWI2mclnGcj5vjhmlhOZBCXq7PfdKu9co/t5/mSePlCCnDksoABy3?=
 =?us-ascii?Q?HXonPaX0LzGf/l1Wc4uqR54SMgzhKr03XI/ukCwKWIp1KtaMt0lrnEZcwV+s?=
 =?us-ascii?Q?POADzYvTBarFdy+1r7UNT2NSMk8RoGWRmviYBJNTUrKnR8AK9mHdHaVMUDIF?=
 =?us-ascii?Q?UXx+nQQzZ9069R8SxQFqox+QeGlh8Q8t+f7BoCKSYI7x9PfgDSqSaTv3ztRB?=
 =?us-ascii?Q?9PRqt1FUPV51lD3Vh/b7j99FwSCM84bf8Q/r1BWnvMmKCdrsKLiO2TLUbjtp?=
 =?us-ascii?Q?JcWUyi5Wo4dK0s5fyfRjDMTL/gm5W1YHvyctHcL3Cqn7FPzMRzQ75fwy2zzV?=
 =?us-ascii?Q?948kox1OlcNfkFO2+daWv11VlZTZ7MLGSiXQbdim50O2A1r+6qLYDevP/9Oo?=
 =?us-ascii?Q?8LF4dv1/v3FoDFnqkGWbt13zFG1r9YAVws0TjfYFhH3Dvh5TUyGDc1jZM4Wd?=
 =?us-ascii?Q?8xETo5NnYvGCp+dm6waz8qHbbVWpA5BiwE+C4KSMkXigMOZeRYAww/Ert2Qs?=
 =?us-ascii?Q?0l311q07Wx4D0tklR9Zs5dwmuQfRa7svxtBq/jK7a+E6KtH1jFq41ZlfESIZ?=
 =?us-ascii?Q?FtjWr7HVF2caWd4dIlL61vqap0zK1RYcB4aCHQb/H1p+eS3LbxHGrmoq0iMK?=
 =?us-ascii?Q?GT7NN9dpITQsqzmrT2/DAxx4/8TkjNg+ympwMhH261F4WZ/DpF57iQN8hbVP?=
 =?us-ascii?Q?3BhW2jFRiJaDjS6xTcADlYWNmwj65Z35jVsvj4RjbvjzzMIPrVihmHf3POMs?=
 =?us-ascii?Q?mLM8foabvW9uHrJ+DkfQbLAYuobF9+9rLKxaEJiCNLqQvGY1WsYcw/+jPqO+?=
 =?us-ascii?Q?963wZ18oNrnZvfSsb2xpy5zMFfnJ4iZQCLdwQm7i61VlH6C6F8EA9A+ZG9j9?=
 =?us-ascii?Q?Dxp4o1eVV1xcn50gHZF5X9nfnDTj89AVBKGecBEEvUutWHsDDmT86VQlBcLs?=
 =?us-ascii?Q?qRzqTdPDD+ZGTZU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:45:07.5851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aea5b3-1f61-4c4b-2424-08dd3644c0d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980

Have additional check for max channel page during the probe
to cover if any offset overshoot happens due to wrong DT
configuration.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 258220c9cb50..393e8a8a5bc1 100644
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
@@ -922,7 +927,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			page_offset = lower_32_bits(res_page->start) -
 						lower_32_bits(res_base->start);
 			page_no = page_offset / cdata->ch_base_offset;
-			if (page_no == 0)
+			if (page_no == 0 || page_no > cdata->max_page)
 				return -EINVAL;
 
 			tdma->ch_page_no = page_no - 1;
-- 
2.25.1


