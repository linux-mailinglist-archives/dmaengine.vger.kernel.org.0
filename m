Return-Path: <dmaengine+bounces-7123-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6962C47283
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB4A14E2DAB
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089031281B;
	Mon, 10 Nov 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ur5CKoVd"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB830100C;
	Mon, 10 Nov 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784729; cv=fail; b=cp9sKnDz9c9OrF7mHzBhDnNocLKuiwDzKjLx4kExhpksf8FJwmbKJ6YYPnsRiNgqA0TRj2zCxAW+v274UU47ZCxjm3IhxKLCw35C78qqdTvz8X2OuVHHV3Zcrhnm691GH+8QKM9sYdxm+5T93CcaFGGy8pqt4s0kGE0CPodXino=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784729; c=relaxed/simple;
	bh=4YoqL7zQW3SvNiik575ZMfdvSat6/cTASyilpKzTqLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mxpMuuI/FldgAfEV1TFcwPbdtEz0+P1D+w7VkN7bj3qh29gxKI7BtIjeYveM8GSYI444yZIiHuR/Epf9G/+7M5ubWpAdwzeTO02iENffR0YcJCgWVhP/T/CLZRBzSodNLBEwvk8r2g3xPyR+k1QqZBE+BRlnQY97wu4C0a6jZ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ur5CKoVd; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLFge3FSYXKb1KPhCJVRCA5nykxvNQUPL4o56RWPG5l1YJHK2jFAXt24dv84wacbxcfN/OsJ08z1qVtbOQoYaGQYO8xdWQGIsdG3v6Moaj7iaQI6HWbI6U7sm1OpWBfZqYt8aH4yUoiYEcaLdRR2wI+pLud29oEtDYEmQS2rpDhIw+1l1jwbRuRC32P/sU3FmVuZ8D/DpDZDvVETtgd42/VY93Jm/zHm6KHyoH/VTukMIUbraJvlUD+EPvymjSjJ975qbWUWLtuYZ4qS+qwuArNDgVsoPXK2M59dg7+YZZBfKveNMMAQlHkQQ9AQXUtiBnF246DGyqJ6KXFcGq8rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC7qoZQO6MxqqBSz84y0beFBKn9pV9Oh7XBWVB82NUY=;
 b=DqcHIWABCvm8F9PHjeS/8/zpHM4fkrIdRP60OlpEMaadhY5TifkkDFuPiybVuKRGFop80nj8LkJHQ2XPCxOvVerTyXvhylkxm4nEMkHEyg63vQEWEHEF8+RLqECBTA5j/IPjDyki1hy/nGeknzHQbq+AZ0wyLZKOZXiljDlaNTxMyMyjT9pKjkzEP9h5GJyFYalRTYN5TlhVxPTPRkBvfgx975qhkrKUAM/pMbgcfA9pMtMQClfGrqZ4h8hps6aEoAtAzySspahSt7WB9z9axd1oqisF+Q6N5zJWxFpAW5dUfU1pETL0KptjFG2XxmpZDSk1TG/AJLynXKTySuxm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC7qoZQO6MxqqBSz84y0beFBKn9pV9Oh7XBWVB82NUY=;
 b=ur5CKoVdJ844JW70g77hMt7gd/FWUW2Ho2MMBytR+2ePQBF1eY4AU7+Kgqgdbe98TfYwMiV3+4zfmhLIGP53RCo6ZDxSLYM5ObOynqtIMxUDnqfV11zuvBHgGG3LXn2DhWbt+DzIGyr5fP3QBulsg8xKda/zNd3ZFB3KFAxmvOrRtb3EUmBWgXe6PzJLyRrjmdHDQeA1OPkZ9epKArwyv9dFAHNyHTL5TTmm3wIVItaEVBTXHJwmGgF7/cWB/Qd/illgVldxPRPe0kLHqw1O2QE5NhNQZSd41QYMkM46A5wtREJNlKKQ3tg8YesmONJAnjlKvtkW5mXCVIdsjWnf8w==
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::616) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:25:21 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::2c) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.14 via Frontend Transport; Mon,
 10 Nov 2025 14:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 14:25:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:25:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 10 Nov 2025 06:25:10 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 06:25:08 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>
CC: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sheetal
	<sheetal@nvidia.com>
Subject: [PATCH] dmaengine: tegra-adma: Fix use-after-free
Date: Mon, 10 Nov 2025 19:54:45 +0530
Message-ID: <20251110142445.3842036-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: f40f7c75-aca3-4161-920d-08de2064fac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZT2sjpgg9bTmOjnPJeIW8G3/KPgN8ROvZS+v8PJxhxe7uVBPGwzL9Ydy3pyQ?=
 =?us-ascii?Q?qQZ3idNKd/jJS984BRK5cFJu8JwZXYxldYl75aHRGw8J6vEJqLKBozbmzW73?=
 =?us-ascii?Q?g5Oisn+lBQ2weM2Xgvx7WPl0XG+S8antKmRHBJtCtYePM71hTXbQpdn7640p?=
 =?us-ascii?Q?je3yJoFpk8QX6si5G0MKXf6W4D776PgXLW/CLqJug+y/f/d8kmFrvPJovcGZ?=
 =?us-ascii?Q?lBxlOkB9YhtIY32knpuROr8b9HoP0pR0iR+CGSISVvuEUtrKck2VxuIQQAwp?=
 =?us-ascii?Q?zKswyThCIs71HKBpXqekjKyxbN7ruwL6WBDBV4cCcakCiq9ysxQ1jBsuFhW8?=
 =?us-ascii?Q?2SDQrJXiCu6WtkcwKtfmVYrchebbKJyepSwfOzsm4+P9+JQcv5hzryMF+IEX?=
 =?us-ascii?Q?Ng3MisQOT08uYuSumytO7XKB1geKk7RlkU4oxQ7DkwxKgwvFUwY20rrotF2M?=
 =?us-ascii?Q?3AsxaPKU/uypvQv4BgHW9xYT+YNe4j+jmppKKCGF7j1fwELfrGfx6v/jSJT6?=
 =?us-ascii?Q?twEE2/L5vqtsO+lJ3yc/cqAFFvqyxsMzzFEYlgZtPS2OfpwYP0lDGJCJsMjX?=
 =?us-ascii?Q?RzztxKOPckTYERXJHrOkbfpikCO18Uqp1usQvlfSg0KAc0BRcJe8bLhLM7fJ?=
 =?us-ascii?Q?GWJKXZteXX9aPasnMyEFFzZ2Ckelxm1XU1MWi90wt853u5NmZyo7W5On3oGY?=
 =?us-ascii?Q?dGPFAJ7CHoYYQBzMOi2yo+XgtqKDkwnTqH+vxQikSu/Xlb6+0L0gifBirHCP?=
 =?us-ascii?Q?IYFMYiGa05CSsCo67RAktzdwEfOG34/Hy9kKPUnaXVG1wNGalw4iZvuqQRS6?=
 =?us-ascii?Q?gdPg0kx6XS9Dl518UwLyawWQSTuaMIKKMxODlqVnIgwKJlgIGgmiQpDLSJ7I?=
 =?us-ascii?Q?ARn+onG+KR8+xSwii/8sZbJd/F6Y0UJTOp+ZV7FkggYkw3kVNpwqscEX9kfw?=
 =?us-ascii?Q?8cXA+iWPBYqQmAQEd8JMIEKJ3YCMRk6OjvUBz2kmTjVuma3TOwFmQ2rSezFS?=
 =?us-ascii?Q?OTRn7deEeiOyBz4xxABXoy3sEXQ2vHbH85/D+hdjgQ5clka4mLiGPCHGMejV?=
 =?us-ascii?Q?A2DrEiIdardurniAWXOspFya8Jf2FVMx2hQpx1D83dcno0/aI7YRPydlRv5U?=
 =?us-ascii?Q?1aiBXOuziMqtvtOljccymuXBD7NYrkC6pVK244oewTFd75oXFN++LpHyzj6y?=
 =?us-ascii?Q?nlyGoqHdnKrpWON703NFMXVEqpbcJipgqQEYDcQ16afjxl4gjcdRPaIuqQfZ?=
 =?us-ascii?Q?/LF/2XDP1F2ryRJ8u7E23jnO3JThg54GRP2iWKd4NYVrh0EiyiSZdxgx1vDz?=
 =?us-ascii?Q?Zf50TjjaQv1wng9/lo6ctAsEqdWM8MASyBIAlGZlr5FrMtRQ60V4s0QRW18/?=
 =?us-ascii?Q?bU0ewiN/sXptEhW7BFZcFvTtyWA5Tsqm+aT7caFg1Wb+tomm5Fq6kz8iit0W?=
 =?us-ascii?Q?iqdAgF/J2Yie4IZNBnDU8KunajmJnsMVbwLVuGrKtP8ywRfLDe1nd8ZdlqZg?=
 =?us-ascii?Q?HYMDLfknk2zflVB14UT7H3xkCy38uQGOVTcgufDQIPqkdPHn7chpsPDyALM6?=
 =?us-ascii?Q?9uLtIEi+uAvLatAU4TI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 14:25:20.9124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40f7c75-aca3-4161-920d-08de2064fac7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1

From: Sheetal <sheetal@nvidia.com>

A use-after-free bug exists in the Tegra ADMA driver when audio streams
are terminated, particularly during XRUN conditions. The issue occurs
when the DMA buffer is freed by tegra_adma_terminate_all() before the
vchan completion tasklet finishes accessing it.

The race condition follows this sequence:

  1. DMA transfer completes, triggering an interrupt that schedules the
     completion tasklet (tasklet has not executed yet)
  2. Audio playback stops, calling tegra_adma_terminate_all() which
     frees the DMA buffer memory via kfree()
  3. The scheduled tasklet finally executes, calling vchan_complete()
     which attempts to access the already-freed memory

Since tasklets can execute at any time after being scheduled, there is
no guarantee that the buffer will remain valid when vchan_complete()
runs.

Fix this by properly synchronizing the virtual channel completion:
 - Calling vchan_terminate_vdesc() in tegra_adma_stop() to mark the
   descriptors as terminated instead of freeing the descriptor.
 - Add the callback tegra_adma_synchronize() that calls
   vchan_synchronize() which kills any pending tasklets and frees any
   terminated descriptors.

Crash logs:
[  337.427523] BUG: KASAN: use-after-free in vchan_complete+0x124/0x3b0
[  337.427544] Read of size 8 at addr ffff000132055428 by task swapper/0/0

[  337.427562] Call trace:
[  337.427564]  dump_backtrace+0x0/0x320
[  337.427571]  show_stack+0x20/0x30
[  337.427575]  dump_stack_lvl+0x68/0x84
[  337.427584]  print_address_description.constprop.0+0x74/0x2b8
[  337.427590]  kasan_report+0x1f4/0x210
[  337.427598]  __asan_load8+0xa0/0xd0
[  337.427603]  vchan_complete+0x124/0x3b0
[  337.427609]  tasklet_action_common.constprop.0+0x190/0x1d0
[  337.427617]  tasklet_action+0x30/0x40
[  337.427623]  __do_softirq+0x1a0/0x5c4
[  337.427628]  irq_exit+0x110/0x140
[  337.427633]  handle_domain_irq+0xa4/0xe0
[  337.427640]  gic_handle_irq+0x64/0x160
[  337.427644]  call_on_irq_stack+0x20/0x4c
[  337.427649]  do_interrupt_handler+0x7c/0x90
[  337.427654]  el1_interrupt+0x30/0x80
[  337.427659]  el1h_64_irq_handler+0x18/0x30
[  337.427663]  el1h_64_irq+0x7c/0x80
[  337.427667]  cpuidle_enter_state+0xe4/0x540
[  337.427674]  cpuidle_enter+0x54/0x80
[  337.427679]  do_idle+0x2e0/0x380
[  337.427685]  cpu_startup_entry+0x2c/0x70
[  337.427690]  rest_init+0x114/0x130
[  337.427695]  arch_call_rest_init+0x18/0x24
[  337.427702]  start_kernel+0x380/0x3b4
[  337.427706]  __primary_switched+0xc0/0xc8

Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index fad896ff29a2..812f64569e6d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -429,10 +429,17 @@ static void tegra_adma_stop(struct tegra_adma_chan *tdc)
 		return;
 	}
 
-	kfree(tdc->desc);
+	vchan_terminate_vdesc(&tdc->desc->vd);
 	tdc->desc = NULL;
 }
 
+static void tegra_adma_synchronize(struct dma_chan *dc)
+{
+	struct tegra_adma_chan *tdc = to_tegra_adma_chan(dc);
+
+	vchan_synchronize(&tdc->vc);
+}
+
 static void tegra_adma_start(struct tegra_adma_chan *tdc)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&tdc->vc);
@@ -1155,6 +1162,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_config = tegra_adma_slave_config;
 	tdma->dma_dev.device_tx_status = tegra_adma_tx_status;
 	tdma->dma_dev.device_terminate_all = tegra_adma_terminate_all;
+	tdma->dma_dev.device_synchronize = tegra_adma_synchronize;
 	tdma->dma_dev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-- 
2.34.1


