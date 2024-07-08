Return-Path: <dmaengine+bounces-2657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF4E92A501
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F8C1F219B3
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E013E3FD;
	Mon,  8 Jul 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JrK2IkYe"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2913D275
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449942; cv=fail; b=lA0Jn+JOIlqjJieR94Uwe7iU5etXDf4l2S+9FDb3t0XFevYjpYrwWX/mQJsGpdUznaf6fhIR6ALPO5s1GOgoprVnbkkx63zKaeMMwXq4b0g1WxKcpwPBoYIgUmbSsVzDEcKLn63u/VOz0rBKOO+QRCYeT9XTPGS7Q8YUMr4tQKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449942; c=relaxed/simple;
	bh=Y5L7iTAK/bHUrXmnkRJNzkgeMZQO4S6z6R763cHvj58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6E/12wI3m8iVEARnTZayDJjDPRvGPqF0Y+Wi7UVVRG7gr5zrYlqhDLyJRzdi4xIVuUi83aGy8Znp33G3+xEEe1HLUipQYcM/lqFG8juDm0TJoIr0s/IvsvRgp9EWqt0hXwq2jwZEmGkCJnwT0cHw75L13qogt7zvTgQHDskuxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JrK2IkYe; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcurZCkDQ10lhUAN48t5oEvSNhw2vClCSsLJXpYKtAnwRqGmQtIqJzJ6Sz5fknE3Eb+VT2w+RU2gMDzYFVLSzLcus1LhqWCggURZc4Izp4UTdP1qKdU/nj/k570+nr2xm9RZ2K6WrLMyca7xs78ti1DYhH/O1sIl13AsUixHm1IrMpQk55FToTtBn5AvIYFqfM0Rli7AsOu00qaSfK5xtE6AXrMQ+ald9sVGHiQ1TwIrBtRBbix2ToGYmXBGZas0e+HJJaXvKZzdCvId7A+Xl0cXujBkWKbCLQcVQE9N8nzYadghswsG9G6BuwL21lKftukSZ7aVX9NhMlpRQLq5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiaPAa+mHtfxPRpTS9zx/psseinDRhITf1KuqbQv5yg=;
 b=hsBHzCd/cB2vFKGv1t38piP8baEb1K0SJ1lKrfwYKeiZLP/wKG0uciJuG7XTsvF93mq5Mzl+f7LUtJGZYdr2pMRJNdP828f3S6q676JKvRxSUQ4kZQ6awHC0VgjdIoIimyoNNBBe6FK6ZvrZN7Jk2I+sqli1e8SOM6DK8SXSUxTW26NUHvYcoUFjzz7TuhxFfVGE0npSU/6LWE8eGjJoRnF2MZiH0nras6+9oIjGWtQPXjzRdIyvix8EOs8z01Ej1XRlZZH7n6vB2QZ13TR6z+NrESEG2QmtUVv79QNVxQhXYF1dJbBO67Et7OJa9STJyTtjU1xeOkjSYWtRZzf4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiaPAa+mHtfxPRpTS9zx/psseinDRhITf1KuqbQv5yg=;
 b=JrK2IkYesulkWZbRYrCLByyPaLFnz/J59tQ51/wza7k+8wk5luB18/E0XxrZ3raMY6r8SO5xoJE7sOh4oUnREK89hR4GCIf64WBqALzPWGusKop/fhMHxLeik0tS5EZTqv7WybYTLpOX0oPL23ZyAWyKCLIkgZD05zqyqzocuvY=
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 14:45:38 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::d) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:38 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:33 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 7/7] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Mon, 8 Jul 2024 20:15:00 +0530
Message-ID: <20240708144500.1523651-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 604f53a6-3e04-4d07-8526-08dc9f5ca209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Il2iBfMRr8gqjrYEynnp6RuX3Rq23cIkjvrEBITeOwKUso7p6jOBfQ80TIo?=
 =?us-ascii?Q?VLY9biCudjdTq+JvBzrVFaS9hddk3uqlKrunzgtgRD5NkMholXFf11qm3aS6?=
 =?us-ascii?Q?Zj43zzD3aNeDMmafQT7smMNp2VmGGI86K4g1zZrh3MtsixvMrwkymXHkGn36?=
 =?us-ascii?Q?UVB/U0QGSedF9u4qJuRMqmPUc/4dQr5uCB9sQ9d0G+LWYBIfaZSymfSmU9nT?=
 =?us-ascii?Q?doxvjo0kVNrAr4caIqq48FED0lKV0hpYQcfHffizpY2/s7LVIN2lZ7SEZCNt?=
 =?us-ascii?Q?9aWJwBMdQvwm+/P6EmpbAewFa08Pjy6Uci2wFJBnZ4Vc/MhsZDzW93L+9Prf?=
 =?us-ascii?Q?XuxnzA/UeiJo9iBCC0CaHtDqkY1pBWqNqMfFa/OOTd6ZtHjcPeSzZR1hV6v9?=
 =?us-ascii?Q?wDz0jn2n5z32BCyLD2JdTok2nbeekVFn94QOdks9H65TckuMtNGzNhSgsiNc?=
 =?us-ascii?Q?9CfTfufSXH2ar1NQ/Kv3C52ydGWEJSI/tV7kLET1PBghfvT7D5ngkaortMWv?=
 =?us-ascii?Q?wAqPq63YFwUEPeyrUxnnc7UcieaF04jZLgMUoBsiZZhpnmukvKJ7ci4q6VkX?=
 =?us-ascii?Q?OBv9DFvk7tqiaTWCeZPGF8wVPErRpT7oiA4q0nNqZ5F1+Kdsw3Fqmt+onItV?=
 =?us-ascii?Q?oIaOtPwYFB0cZG+jLjuAFjO/3KkK9WNtDdy5uC+F9/AMOjgsK9YS8TKaeHrL?=
 =?us-ascii?Q?o2VGOREnmytTDJpjXqTvowXPibdDSqk7bZQvsvLvXOZ/SnpscgW4ysoMCdRY?=
 =?us-ascii?Q?w+bMZOkSeU2au4QGugyPAoMhEgGqnsCU3iHpV1bi74zWqu7Hr13md8e/Z/ka?=
 =?us-ascii?Q?3lRCQZKxyGl9lb/tijwm33PLOtDMg57VOdl83gNrc/s2kKNc8uckiA+AHiX7?=
 =?us-ascii?Q?9wEDKJpMUV2axyt8ugssXuTAaSDuKjHgo3BhvYWFUj8coT7uX8ubuos049hI?=
 =?us-ascii?Q?OYBCbjJo8Za2ltBmcqKyXSMhOEnjt7PTAum8YKNEzbhP0ONtZXo+czh+cT8A?=
 =?us-ascii?Q?zN9gD18l8DYsad44zkhUpEDfnWoc2Dz32+UItwj62B54n+sKIRzAU0bB/DQW?=
 =?us-ascii?Q?yDvwbjyreuW6KKE2rrdCBzKdZieCp8azumN8BuzywJnVxul2aN1Nt1ydHBQZ?=
 =?us-ascii?Q?PQXUscuRJs2x+EOffSJioEVdhjskesyriezCGqLPhevjcHh2fFhmjp4sFWyt?=
 =?us-ascii?Q?1uXnCz9LcdmvqLd5rczBsKzgDzxdZ1LzNCu3UHELctFUIMqinEoemGaGe/cW?=
 =?us-ascii?Q?KwPYaYH05WbNj5NUYByGEfPzHGb76y0bwAUZJ2ZHWi8EwZ8qyff1bGBMsAHh?=
 =?us-ascii?Q?5LtGElDQ8mCiPCwSJWfDVgdmhfWehivrBa52fCYmaAodYrsNIpEeYI/4YqRu?=
 =?us-ascii?Q?UgQbrs3FatjHkaPHv70sih6C8Gpk01P+DW8lo3MQpe2ZTEc35S+nXL6i6BP3?=
 =?us-ascii?Q?D1c7d9atKBsW80oT889/uiEcSEk7bmg9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:38.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604f53a6-3e04-4d07-8526-08dc9f5ca209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828

Use the ptdma_debugfs_setup function to register debugfs for AE4DMA DMA
engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c   | 2 ++
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 248abf794aff..3ff3573fd2b7 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -254,6 +254,8 @@ int ae4_core_init(struct ae4_device *ae4)
 	ret = pt_dmaengine_register(pt);
 	if (ret)
 		ae4_destroy_work(ae4);
+	else
+		ptdma_debugfs_setup(pt);
 
 	return ret;
 }
diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index 25654799077b..0d1133ec1919 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -139,3 +139,4 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 				    &pt_debugfs_queue_fops);
 	}
 }
+EXPORT_SYMBOL_GPL(ptdma_debugfs_setup);
-- 
2.25.1


