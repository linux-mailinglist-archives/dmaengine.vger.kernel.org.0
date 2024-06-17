Return-Path: <dmaengine+bounces-2385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1390AAB7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F083284C11
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32219047F;
	Mon, 17 Jun 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sscLI2eD"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE418C326
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618687; cv=fail; b=iT2KX4/nve0lgc5M8pWHreV4x1tSO//YpdyTvd/rVoN3JbBdRyCRI1KkXAdS+aaVaSWpwT7ZJ6xx+W07eA2JH7Uunft0zuR0ayWzuL91oUViy7ar7dZONdJVc1AN+b7gc12sxTz4/N/HJp0O4nZ7JkiXFq1wkEnZ9sKebSt0Wk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618687; c=relaxed/simple;
	bh=4XvKQapPEUF5pkSLTb1aWLP0kMNLu60W44TNQQeWDDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fao4ZHX9RiTBCrBossvbgxgg5jUDhu8PM4oPOQvGFDV9fWMOp24/52KF1i6LtewO+gIRwwELwLJm8wpr6OUVPWhSNXULraC1FAAuKbCxuABG/VlIOzOpuUqrcRgKsdFXORQNpMX0s65zRAca7f++xcsnveVoNFjjNIFPmKYcMjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sscLI2eD; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBs/W9RPLlQlnL1JM36STeZWybMX5PfzQN/wKnl9TI1iSDK0N4UiGNQMuXO5q0uRnVKpH5D+ruPPOuTw5zIsZVDzthnbn+PVQTXbE6hhjAKR8bPx6mcI2OJe1xVqp1sRXTec5VbJzn+0MzZRpkEcMS/SukBzS2WqZYWNPS3c3nHY0CLUTtX5KMAoCfBipl9+ahKbueKx/AIuPk06ATLgqcXVg1W+0LsQIq/OgLGkf9AblwMAbqTKZHtYKkXTFur5n0PGMx6izON6uIb9J/3Jnftbo/1bhCzhSWUNgeLlKW7E3SKxJ7+dJMYgoEeCyol7miXtuC+RJtNHDo+Y0FVa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbQXzQE3n8D8KEX3AtDQ2WMnNc3I3YLOo/iaQhTrQ/I=;
 b=b/lkk7Nq6QCSLdJ/4hDGwwR9SDtxOwQuziK5g4TVbrKZo/lChSvrh62VQ6KeSFfGxrst4yoiPqfCOWytElUw6w7bPZtMPuIuplud6hOeohs5u3pbiI/KspDPHJuVaytL3ZQn+WvTDDAJULwnzg/RnfbOAsFx0cTf7z6ub7B1+xxq86xGSomYS6CS7UYMzQoyWuHuJOZFt5ufQZDCCM5byEUvP56yuSdNKPEDYurP/fjmRSgbKBldyZjCjgWrBX+AlT4vwwT2+r2N+s5AhjLh8IddZ2X0yOyVA8yhvcs8jBOBW1+X61Pa4uPEqSytLpXy1/T9BxQ2H49IZFayUNSujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbQXzQE3n8D8KEX3AtDQ2WMnNc3I3YLOo/iaQhTrQ/I=;
 b=sscLI2eDaanBXHE9wDjaflb3cLQ3X4VYuNJMKobKicqYzmaPM5bumEP0EGqNe0GLEKTOJUbw3N5wp9Q9/ih0zfqdnPxo0S87ErIPHFerPADlbpslBHJGQmQ7SftA+QT1w9x28MD6l0qhoR6QJgXWIFjfgPH61w0eZ5rkelJ9ztg=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:43 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::4f) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:43 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:38 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 3/7] dmaengine: ptdma: Move common functions to common code
Date: Mon, 17 Jun 2024 15:33:55 +0530
Message-ID: <20240617100359.2550541-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: c3abc2b4-ca0d-4f42-5c22-08dc8eb4e8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKNONxJ5vW5p35a34VhFrhs1Td+hIgSgIIMEeZvC5ZapAJYl2N06N7wVEVWs?=
 =?us-ascii?Q?83AUEtfr6sxxyQU6IVWqxA48NyziQtNjg2zi7kWatYbN8rkwvH52OsmUXw8N?=
 =?us-ascii?Q?ZCk/rUjglMPLqDln/BE95VawQ3tBhLkb0lCV8QLqkYz77nH79wC7XW2bPZPv?=
 =?us-ascii?Q?AFTYsXrCuBo7RUmLC7cjL2kRqSDcUCBFksOaTK6dfCrvmAx5H6WnYRU//78+?=
 =?us-ascii?Q?OspnpVjH7ifj59bKurNvt53pm5DRh4EDSLU03sS4LjZsRb5fQB+a75+Eu1ZC?=
 =?us-ascii?Q?XW9YxkpLMXA7CGJ6gJa9+uLb83qK75pWwMphdolgVzP5ecx/zUhW0AUTebRk?=
 =?us-ascii?Q?T29laJ8ueZtFGgvXG8bAkTuz2RDn8Suj54n0Yap8Q4nKK/L7T1O10AeoD4t0?=
 =?us-ascii?Q?Q0CkukOf/D0v5KW15A87U77UfBABXOm7wQguL/+XshfjQZXj5WYFUl24ttdm?=
 =?us-ascii?Q?ycXRr9Y+0kpoS2Dx7TZi8CikOIzzjQOOqT6POjKlco9OpyS2TXBAVGxnKxCq?=
 =?us-ascii?Q?dyFs5CrUunLmxINP0CQxPqsIGP23j4k9h/nD35QPGOKf/lQAWmuR9vZh7ZeF?=
 =?us-ascii?Q?as9Jnh1Pru2LPoa6znusN4dgLU2syGDw8rwUiOPqfeJMeL/9lCiOrzQzyrTW?=
 =?us-ascii?Q?PaU/UtuOXZUuplHHYvTm7AobJLw5FnsTjVLfX8co5mrVtUw8k239YYEjtliV?=
 =?us-ascii?Q?VkypTYjgpRGqPZZ7RiWynrgJKcs11mFPVYdugVPPtcACchukdwg9VAsdJIC/?=
 =?us-ascii?Q?ELX3zYbh1v3ZcnyDqcr2ZOuqtMjQbxY9RlKRe4gItenv1mr40gSTtXAit7Kw?=
 =?us-ascii?Q?/hG5cLOkZpjzMfpQE/RCYewodaLmxyHBRk2QD51pKy9wdguMFueXi+J6iw/w?=
 =?us-ascii?Q?eCP/uAybYG+waFm6FISRqk8yGzMxzkMCPPQd3uDqu4DGTmGt4isGnxd7gaCO?=
 =?us-ascii?Q?uMSQoFUfdIhtTwiy5mxRGlrWkMgnEuTZXgthzsyph6D87GNxtypiaxcjBbj2?=
 =?us-ascii?Q?YnNf7A41Xt9kxFvpvKQCvVKgZTn+hs4P3GEj/WTIT8NNGwMMbVGlQyMxHFf6?=
 =?us-ascii?Q?ckozRlJiDXLSUtzxLMHCDWQhK0udSoKYpy+ZKXTAP4Ep6mSwgUHsZqplBotH?=
 =?us-ascii?Q?HKeDm825urRU/GBOh1eNmuFaAaw/nfKt/8cZFMGsu/XD3rxsLRjXXXeVnZGS?=
 =?us-ascii?Q?dMaamx4muv6NFXrdeVqwIeam9dB1PMGFBKaB4HuEhGsGJTk9mqXeblWkaHqv?=
 =?us-ascii?Q?bWJCaGuFECZ5v4+YoNDx2bUJX20DP9sOu0nfrLjp0Bec2AEVhrLLJms9NmHV?=
 =?us-ascii?Q?/+nkAEKrtyveN1xCuezcszFZMlTfsXOTu6x76zsBa3G6sRkY9d2CaZkezHxG?=
 =?us-ascii?Q?CatsqIuT8Oz2GJZfBt5wI+mNwuS1oV8sNIFQO/SqSiI/rI0hxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:43.0082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3abc2b4-ca0d-4f42-5c22-08dc8eb4e8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

To focus on reusability of ptdma code across modules extract common
functions into reusable modules.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                             |  1 +
 drivers/dma/amd/common/amd_dma.c        | 23 +++++++++++++++++++++++
 drivers/dma/amd/common/amd_dma.h        |  3 +++
 drivers/dma/amd/ptdma/Makefile          |  2 +-
 drivers/dma/amd/ptdma/ptdma-dev.c       | 14 +-------------
 drivers/dma/amd/ptdma/ptdma-dmaengine.c |  3 +--
 drivers/dma/amd/ptdma/ptdma.h           |  2 --
 7 files changed, 30 insertions(+), 18 deletions(-)
 create mode 100644 drivers/dma/amd/common/amd_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d222d1ca83f..3000ea780db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -952,6 +952,7 @@ M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/amd/ae4dma/
+F:	drivers/dma/amd/common/
 
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
diff --git a/drivers/dma/amd/common/amd_dma.c b/drivers/dma/amd/common/amd_dma.c
new file mode 100644
index 000000000000..3552d36fa8b9
--- /dev/null
+++ b/drivers/dma/amd/common/amd_dma.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD DMA Driver common
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#include "../common/amd_dma.h"
+
+void pt_start_queue(struct pt_cmd_queue *cmd_q)
+{
+	/* Turn on the run bit */
+	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
+}
+
+void pt_stop_queue(struct pt_cmd_queue *cmd_q)
+{
+	/* Turn off the run bit */
+	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
+}
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index f9f396cd4371..44251918f157 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -23,4 +23,7 @@
 #include "../ptdma/ptdma.h"
 #include "../../virt-dma.h"
 
+void pt_start_queue(struct pt_cmd_queue *cmd_q);
+void pt_stop_queue(struct pt_cmd_queue *cmd_q);
+
 #endif
diff --git a/drivers/dma/amd/ptdma/Makefile b/drivers/dma/amd/ptdma/Makefile
index ce5410268a9a..42606d7302e6 100644
--- a/drivers/dma/amd/ptdma/Makefile
+++ b/drivers/dma/amd/ptdma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_PTDMA) += ptdma.o
 
-ptdma-objs := ptdma-dev.o ptdma-dmaengine.o ptdma-debugfs.o
+ptdma-objs := ptdma-dev.o ptdma-dmaengine.o ptdma-debugfs.o ../common/amd_dma.o
 
 ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/amd/ptdma/ptdma-dev.c b/drivers/dma/amd/ptdma/ptdma-dev.c
index a2bf13ff18b6..506b3dfca549 100644
--- a/drivers/dma/amd/ptdma/ptdma-dev.c
+++ b/drivers/dma/amd/ptdma/ptdma-dev.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include "ptdma.h"
+#include "../common/amd_dma.h"
 
 /* Human-readable error strings */
 static char *pt_error_codes[] = {
@@ -54,18 +54,6 @@ static void pt_log_error(struct pt_device *d, int e)
 	dev_err(d->dev, "PTDMA error: %s (0x%x)\n", pt_error_codes[e], e);
 }
 
-void pt_start_queue(struct pt_cmd_queue *cmd_q)
-{
-	/* Turn on the run bit */
-	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
-}
-
-void pt_stop_queue(struct pt_cmd_queue *cmd_q)
-{
-	/* Turn off the run bit */
-	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
-}
-
 static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd_q)
 {
 	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index a2e7c2cec15e..66ea10499643 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -9,8 +9,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
-#include "ptdma.h"
-#include "../../dmaengine.h"
+#include "../common/amd_dma.h"
 
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
 {
diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
index 2690a32fc7cb..b4f9ee83b074 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -322,8 +322,6 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 			     struct pt_passthru_engine *pt_engine);
 
 void pt_check_status_trans(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
-void pt_start_queue(struct pt_cmd_queue *cmd_q);
-void pt_stop_queue(struct pt_cmd_queue *cmd_q);
 
 static inline void pt_core_disable_queue_interrupts(struct pt_device *pt)
 {
-- 
2.25.1


