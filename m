Return-Path: <dmaengine+bounces-2016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304278C1F9C
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0FE282F40
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8114901F;
	Fri, 10 May 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykrTOj9z"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6501C136
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329301; cv=fail; b=HTd0M/ASrNyr2mztsGVZDZc2iFyEf6gx6L8zmAnNruW5PumbViGTc5q4OZVrTs4k+eyISJujOXNDfXS8ZpqYzq3g8Kw4kSHzE9Dqo05T5mGKM2DX6CMgAtrGGz9U/kuE6zccYsJ39FwO68WNFzz10JNTp9JoZRlOpOFtdaQRiiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329301; c=relaxed/simple;
	bh=bODVH4GyruJugOVuz5wKwMG+kfWViJ+14WImIcfaxA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4uhCpFlK3E2Wwvdwd0rrx6qxZk3KAfjDEhoSdwn45SpZD3XnPpFUAKwTNGJVkyrRvYQ4MUOcFn0vpZHR+d6xy8OeIX9AiMFAf5rvqcziCqIS/O+nxOPGDqjuwD9Pqz3nSw0FlDqbKcM3Qg1UYO9NNeVcl8w6k8qCxeMoPuwfL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykrTOj9z; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPx2opYXRtGkB6QISFbs9NIIaMubhVXUbNAvcfjMV703C2h0usZcoPUYb8Mi6rRoRAf2UAayZWePTVWxg3t2+7F+Zf9NaMzh/ve2Y6ZEC6CWFoWFsG4STWecaeI5iAhQ8p+z/VXnGPrLcdrVP5spxaCe596i+Gy2dHjRfyCHc+9HRcP3KByd+Zqa8UZGsZBZjlncKdV+XyPMvQ1U7Bz3XVATVFAYMhojJbBvnXJm2vUKYIVQ2lAB5dG6ulE/GVgVwNvj/kOZ54SnM5hKKJ9oXqArQEwS3V5xxci4j+xemabGIlDJyPaDAgIMiBp3xv1RcZkn3rkZgiM24331X+VV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XDmgxS8cUH73dmR0RdtiO73D7g0lSIwkEuUQ7rCmAg=;
 b=K0Dse2em2Om/VjSoLI+QCx9maD2+Hr+YaEH5UTwTNF5kcZAzBhScgmxzQFUd1OEq9yJt/YVWMFTtklk6iIQPdT9ixTqIpC04gSjh/E2LvKK01i4HHHDZDP+/fN0kNQB8ycj2lyBOL1F//mSlj814b5AVcm+b3TrvjXqcR4g2CZD0SlJ1D8XqggA1kn5GvLQil4CpzBhEmf7RckwfTC+gvrbUh83HaDuL3BE2IPRq2Uvo2HdSF3kHZ2q0J7w8T7cAt11sksxrXv0oUV33Qlez0ZtgBFJuctKa7T9/ONs36FJ1x77TcbQy04ebUlqZOWOCjfh3k0eI6JT/yDseE5JdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XDmgxS8cUH73dmR0RdtiO73D7g0lSIwkEuUQ7rCmAg=;
 b=ykrTOj9zHTB0npN1v08Lj+S8RY6h3MbjlwDViYHRg0WxZ3F+xfo+HvI4Y5+X5AhGx9S8FFR0ZnIAKM5LIZhU0MNiNaa9RuEMsQdHYt4SUVBtG2jGXnCP3udVy+4Al6oMgIV/ukaQT1iHvadfvIZtWkhxf87YkHEoGrgALXzKMw0=
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:21:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::60) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 08:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:32 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 3/7] dmaengine: ptdma: Move common functions to common code
Date: Fri, 10 May 2024 13:50:49 +0530
Message-ID: <20240510082053.875923-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a32333-46dc-4cd3-5bf8-08dc70ca3436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOE/wscYrVswJ5xsTTnai0FvmQUtAwHEikOO2zqJ89CNFa24GkK6kZZGNLSn?=
 =?us-ascii?Q?CEO7kjH2Krh9qSPoHsq0S9+RpFJmx/C+ytHH1e3dl4wGrX+2XA+dRPnyFj3m?=
 =?us-ascii?Q?mK24eTv+M4lgrFZUcV+DJTslAkL7warTSg41vipdgUJ4EQi6a1kaTI9NO3s0?=
 =?us-ascii?Q?Ovk3N0yWR0ZnKO4p9aOF52VdyXVz9L8fEG2dfghNHYIXvdqRrNHgsg5f2vVH?=
 =?us-ascii?Q?uiqAt290KEwpE/CCLBPSrr/8ytC4HSJf6159OBrdC04ac2dHaBxU4YaK4RaH?=
 =?us-ascii?Q?PZINvXGt6kET4FdPG3dUvW2kksFEE5OrmSUkpLkvCOb2KI9f+ijij+ILAEou?=
 =?us-ascii?Q?Ro+0d15hPL4CuTI7qF8zQW3pchsakmpO2pk1Y5OdsC6Bnoo2rOr85Yyhlksg?=
 =?us-ascii?Q?mUcqSaF7ZO8u2c38nUPejRSf14cqc/yGKGUBIhT18c/Vj0zrb6wPaiIIIiFp?=
 =?us-ascii?Q?C/YXoJgNnRB++jgGU6ryK/rTgzkttRUqJbNh6i6XWlZk/jpSNKo0X2zip/Do?=
 =?us-ascii?Q?7IkMeQaCQut0jBWkimwZmzOlE4ben4UyEQDKjOoL48rb1zdqnEJlpbed43zW?=
 =?us-ascii?Q?2BkWG5QCEVWPOw/tiWIZ9ElVtdwRUQD1u19qazA3A/g1l27Mm5uMAYyO4wgs?=
 =?us-ascii?Q?kIngqoflZKPrNCbWIj85vRmn87sXjRrXKJZyWTYIWB9mtJYVWd2E+4Oi6ZY0?=
 =?us-ascii?Q?koCjgtkPVp/6lU7PhySmfxuROsmYGraK4nJGDGkbjqz/dKH1chTVC7N9/sx6?=
 =?us-ascii?Q?3aeAz11HNUdIAAJzIIPzzQE3IyTEN+olwIe+dYF03W4mqoN6ER0cOOYWXfxz?=
 =?us-ascii?Q?IXB1Yl1p+G8eqz1/rlrz5dMr/P5DChcnMhJz59MHtR1UDTjbMtZaVSAiiKfZ?=
 =?us-ascii?Q?RA3Fs2bx+fXV1GrPTKAPQSuc8Z3H9vGlLERumWSHcu9MBtl+n7dr2vjTYiFw?=
 =?us-ascii?Q?SMLaV/A88HHR55pux3sIafGIjZBLj/rOopBMjGABYyC/b4NEOMNyzih3MwOk?=
 =?us-ascii?Q?czaUiBZ9vj7Dt3briYHG4/hq/dRJKY51sb1mk3Y9XpwMxYMLP4ucs7uZI4fJ?=
 =?us-ascii?Q?42sjaAd619wrUkTFFOmFH5zq0VAF3W/m6JtWUgc+36PHyYeALj3Hms8ObnO6?=
 =?us-ascii?Q?hXb6AF8/W6KRk91HgJNDEco/GjjEBZVyciqRnEAYF0tkcyTE/TnNw/6HPkXy?=
 =?us-ascii?Q?xVDFqqzbennyM9wcuKfoPlVoNB3bDZs7tL7ljicqBiqmpk2r51scDCbQvVX1?=
 =?us-ascii?Q?LFAioKeIIqaKk89BJzp4U6E8gTsJry6H5cdK2qoaH2/xolua9qCMTf41xfpf?=
 =?us-ascii?Q?n1IhVGaOhhaej8XWT7U9+7UnNFkocv1REWW7BBANmpP+OK95hffg8xeIbZpi?=
 =?us-ascii?Q?sFH/xxU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:34.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a32333-46dc-4cd3-5bf8-08dc70ca3436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

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
index 45f2140093b6..177445348f4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -914,6 +914,7 @@ M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
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
index 31c35b3bc94b..c216a03b5161 100644
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


