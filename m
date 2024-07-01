Return-Path: <dmaengine+bounces-2609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125B91E59B
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3977C1C21A2C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E716DC12;
	Mon,  1 Jul 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APZ+Nv0U"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261716DC24
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852190; cv=fail; b=OgwjGZKmUk7gBp4jf1bFzlelOlIUqA9RY/QMDcHB3TkisrBEnwg6sx0ukXt0Kx7D88jmD+qN71rBmtwBwgYPu0HqQSGz2+1N8JdQcEGaFKnZu03qTcaydwUKGcyORDNrgX1K+jzbDmH1tPJqTy9A4S2NDv3EEQZI2RKaKTTA+i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852190; c=relaxed/simple;
	bh=5Tk7JSbDOUAghY1I1UWZd76BhZQR75/+/njfJBKxCuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRDGsNhGkZZvjewHlaYE5Jiu4ok0EDIOjritq54/A5EdTaNpgSJGpOPNZCaCFa6fLxLYWl3mC0GHynU3gGwMlaTy28OdgNZUnmjNUi3TGK8fiMDbODp9Jiq3v4T8NCKNMX11h02dEIaoasXiRRRUzkfiWTw8EprMVmpyGoCq0a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APZ+Nv0U; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj5PqZr0QRVis4w3ZWWEg11/2ABAS/qnnIH+EqF2NXeMKz175XNucciM55Gdd6XIEXx9/vefOVA/N1zlvEKklG+ZtYEgQBdyDfLpoEux9akIMxkJvRPNbC1kVTIMQNnFfPcEPuM7DWZfrUUKqrDqdOgAD8ethiI98KfOVUKcX8NkCkNlXZWzK8wdRdNzkbgs0NMf2OD64Sly3SYEPIAUdy93+Ceh4hniUMQDEoV+e4FUW5wPuGpOss29tOaJHxPCVjvm7/s/iQGZAF+KwOLjpikwtPIOJtVLDOqrngasCtkFr419MqDyJtKtmUGezNbhTN5PNftxfwNcQ+icLeumAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlDSbivbAY07eP0fzFajGziLM7VZZJ0ttzSt0YY/ICM=;
 b=RYpjrurb3Q5CJKjrY1rop9yXQDOsuTdhXXFc6seTyBvNrk63AAlF6tVSim50lCNyflH384KjIzltVvihRM/2+H2PNCbzsP9nLNqcoRq5RzdVV0BkrKV6YWWtJoRkKhdwLxTRM/ibE2m046mKAw2VrIpGnUXv+fyJ++HeKxsQNx9VQ8irJxyvah8B2L/gC7EhuUgHfrTUlQdIISeOHBmHaoTFwyfgUYNQlXyc+6BTZ0I/N3jRBZNP1ju5s3hnVvTVSA1tpx+bMDcJ4W6U2s5eIOItUEn6AiC/laiXBlUrtf5KF87addTSMCyMRmM6HRomGgcgyLe4PYp5TWN8JNPTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlDSbivbAY07eP0fzFajGziLM7VZZJ0ttzSt0YY/ICM=;
 b=APZ+Nv0U/IPjKqRJMELP7A3lINjkUn2dtPOAtLaPXGpaqE6NwnsZ51cy4Mo8ZIcoalUHxIwYmltxikgxMeXXB2uBPKD1SQWSd0D9/SYgKPRKMI7MjSSMuzYqXRBF1lIWmZ5yP18/pyliO2A7KJ3oe/n/IRBXXdx0T5C704Aq1MU=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Mon, 1 Jul 2024 16:43:02 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::56) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 16:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:43:02 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:42:59 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 3/7] dmaengine: ptdma: Move common functions to common code
Date: Mon, 1 Jul 2024 22:12:29 +0530
Message-ID: <20240701164233.2563221-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
References: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 541e228b-f583-4cc3-fcc5-08dc99ecdf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIFO++6/AHDk3lKLRbe6eEHmav5wbtk0LD/1NwnE5K1/jcoQLlTZsRLfWgtn?=
 =?us-ascii?Q?72rZAi1Ek1mbi7kDJEpgKQD0qek5NUxdyj81aFfdrbwVioQd2fTfdJ9JxrRQ?=
 =?us-ascii?Q?SS8ax+7RNZrRO+xF0GhAssFbAnQR/98keKu4BEoRkM+9oK4X49UZcCdBA2bi?=
 =?us-ascii?Q?wtEXuXRfOOhJJVKT0A6dnchI5l2wBpJEzgKDBb4Cq+FKbhK7V2iJsP8JxqMu?=
 =?us-ascii?Q?5ed/IV2I9Rx8csHxB/QZNUDMKKJXnh0n4jAcyHqOGXjWRsfYPvDERTPfA/7B?=
 =?us-ascii?Q?MMOsJoOy4BtvTglEAXMfYWdQlWOxsauPCG7hpbT6nuJgVJ5ux7lZQPER6U0q?=
 =?us-ascii?Q?zXaILRTWJDqyLHbpFvQLxiMzwyxwpwxij5oG8U4JE7aQG7atkqDXPx4rLPkK?=
 =?us-ascii?Q?ASZI0qLNwKH4UgKgOSjFSywK8xvLYrcg6lLbZJ7eK0HwoVhXcFN9eLEG04R4?=
 =?us-ascii?Q?FL5sp/0pYlNJ/uVGcITEpJNPVwnWQ2YBT8SOOajW9tz9+2+CEYVRZsEkN2T6?=
 =?us-ascii?Q?nrIHys7big1uNHqL1Yh3YfFV/NWao89YkZdU3ETQ/U/dbodLJlT9fDtpE9nE?=
 =?us-ascii?Q?7lLIOShS+pdwlwIQIEg1i2z/OSNKWjxVQGO/WrA92tPc+4fukn7wCbitXLA3?=
 =?us-ascii?Q?iS9Yu+dzjIaoaFZZ9ZRa+STy7M9NqHADJjyxMfOEw8oQOg+6ZRLBZoX2WuWd?=
 =?us-ascii?Q?oIy7JH0/ymRcaQHzRfp/tLduyjx0JISNdamz564iobRCkeGndE7sQRu32G/6?=
 =?us-ascii?Q?I+UXZzXU6oLxXEiAHbWbqmhW+5ScgvFdx2O45fqzYcufZVnX5MXyDvUQzGXG?=
 =?us-ascii?Q?QlRhXtjdvhIKck3cDWY8B4VKYH/8yqHx0n4yReKhN2GNOfxHeanW2gvk5X4t?=
 =?us-ascii?Q?kX795c70Th3xkeC/l6bFcGmF1VQv9psQVgypeglAQSiY8wjjnWePgFwu0Q14?=
 =?us-ascii?Q?eC/FtmdNxIdKSHRZ+NhWpeQFWxCxKL4e0v2hE14Y/5LJkmbS1/G9cH+RpL4v?=
 =?us-ascii?Q?JFjnAj6dBq1JiIFEXeYGyygL7w7XKaPitXEg0k0GXy5ReFRKTytojJ74ozxK?=
 =?us-ascii?Q?RmZFFysvhqXZB1bsxxXH58200MHpJIiwVctbeUvGhjePQ91h9g6GiOP8wexs?=
 =?us-ascii?Q?OdOuiekN0qQ030XDzEvo0t5u0wLfhBhNIVn9DqeclyTHBRCxJwL7hAxsrtgU?=
 =?us-ascii?Q?2eIaM3cpeK60CKTBK99fNPd2HCOR2WHObCU/9mppEQCAVlxkBwd7Qki/dYrO?=
 =?us-ascii?Q?/T/fjd8EVzvzh+MaRKCN2K9nFiXfGaN3jxMcfmmRioUU+fLk62mfdtlIre16?=
 =?us-ascii?Q?9C4gLEY/midW25seJ3/Z2RDjZ7JyvGruJpLW9sCXGzgaIa3k2RDbjQQCfQUU?=
 =?us-ascii?Q?+rqcA4EbVC8GzO4QJ3zvKPlFEOwvubAFQ0gym36QQ2C82tO3X27DFI1esTyH?=
 =?us-ascii?Q?B8jgSQzQVgg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:02.1366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541e228b-f583-4cc3-fcc5-08dc99ecdf9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

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
index 3d4c2c21a503..6ddd94363ab6 100644
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


