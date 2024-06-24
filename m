Return-Path: <dmaengine+bounces-2519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A679914400
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0501F22812
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C8487BE;
	Mon, 24 Jun 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h7AV5bEC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994E481C4
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215807; cv=fail; b=QhJw1sWhP4RkqmwbRw45qVwnehwoBOtokaHx8ev1ZW3nZ2cFq+DcLiTwMe2yJSEtriYhlHbMSJ9wNwpAD2XN73o/4pEB+GIC0bqqg5kB1oDk/Ovf7XxhHqzd8uZCYYcxR3bftoB0bpHNHYNoQ4mQ7pCnszea3+whE9Uk43RaZpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215807; c=relaxed/simple;
	bh=yD7rqa4sbFfUqRBwe41kZMwNWXA9d0POJy9n6wNQGX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXVlat+bNF3vSyHuay1BrADjMRMHKN+vSMlzevoB6UFE24EQH2ybBPDkmivrIhZY5IY8FyKTbvPZ7C2r4eKJsqFdmSvQe4xlUGoWVl4x31tlo3GEQgfI6fzinTOuTSxLbyRuxWCDViNXHae/W4yi9y7IE7cVF102FPKQ3+FjRRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h7AV5bEC; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVlUq2uHJtlaqHNV3DY9a+zGUztHmWk2jQQMhn/FbtW+Nf9jmbI+ahGMmIel8wtDOBleGQuKC/ZsurRQgHzILIMiA+/8Jn2pLIrqUtxtGbUh2G74cR67PrnAW6Ual7p6VNVR14hvhlxhfa5IHYxR5pYwuYQ94Bu61aRDoEMDigOZkHNYrjAuu3yjavYT5kJa5kRbjXRrbhWFi1rl7A6CwHGkXzjnd0gCLO1fejpMJZezvNpHPr2DfdKl6degZB/0qW34qWJZvLNJ5K5qyHlza48+8WB5XRfOInzIvPw4p5B9llW8W8o14Od+qQgYlo28lLEJ4zv2Gd9dF1N0uhDgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edbqYjfXFmnw9Pr5WyN9OBAvDwe2JYwiGitt2fwQM5M=;
 b=VsFHSbcWvJqdxjqXb1Pd3s1ShIEb+2aMIhT0lwUJO4AwM1jHl/6ZSCcHM8NhN0KT1TzllyhSZax3HZ9cQoqXjIj5Dx1kTwxtPPekXHvYL+SKJL1075fkHK0gHziY9DMj2VDaHYCgo3eIXn+Tncb4Px11pLRCbfmOzi1AWvixgiSpa8RYDfxCogRVM6Z4myIoE8lnKIcSmWLnK6a4igCS233G08kg2yurPiNrBUagOMIbhVDNL5eNHB+eM8jlxDQWvkhuYoxQ5cRbPe7F2G2LVIQUPKbSeMeBEy0rVCF2TJdZ3ebu9A0XFgqJEh45DmKt+Q1L6Mkz3B/8er4Q8IWuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edbqYjfXFmnw9Pr5WyN9OBAvDwe2JYwiGitt2fwQM5M=;
 b=h7AV5bECmNsRxLoH7gWa8eCpSirIQPw3qco9k1t4ZxaQ7c/5ho1J9jWtEQSg2XjYJ3HCvHEPxZiNrlUI+hz7erixT/g4v7sR49tgn4GljPdNdDtnDH/mZzXxBAyGQ6LcVN/Oi+5ASz2Ih4QPaJPeqdvlIjJua31eO9aGG3Pn+lM=
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:56:38 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::c1) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:37 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:35 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 3/7] dmaengine: ptdma: Move common functions to common code
Date: Mon, 24 Jun 2024 13:26:06 +0530
Message-ID: <20240624075610.1659502-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6c31af-89c8-4d5a-9885-08dc94232d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkdTsaP/poyGlZJ2TyhCFKqc9JjASfYh0Kr21iyRAz+7nEVBhNG8ngE2CCiB?=
 =?us-ascii?Q?gwWYnxreV9m0K0/pI8fwUpkM9QE2QQ4TL5taFW9FJXId8pSifsvKsrHnf57p?=
 =?us-ascii?Q?rgyJG19cip6SpzoRmkszwuRpmmvZChUE+qjqbu8SN72UuEAG49pnArisYfia?=
 =?us-ascii?Q?VJtj/mFGkImiAWkNd9E6iEM8VhTt8Iad9VAfawL0L9xYbInz3k+pVyuMPIRF?=
 =?us-ascii?Q?suUkzaIVNbCGoEpRGS9wngxjfdBXQyyi3FFGChnTjEZLIyx3r5TSKUJDWRPY?=
 =?us-ascii?Q?wzWdxM5KgBDUfHFdlzAtGLNUn+27BNEEwumwO3wbZB9h7HS0BDqZ3+9p8aQ9?=
 =?us-ascii?Q?A4ZTvICGofO/BGVW+oe4xTC47702pvw9/b10p6NkzYaFIDF5v7fuhwPXpdzI?=
 =?us-ascii?Q?KD7noWLhm8bYiVYXfaNpGeOk4hc7mOCXZdUN8YsGeW2dvVaCfqohxk/lKIge?=
 =?us-ascii?Q?bawUYH2gE3GWb+IvkE3ezLhrtt1H9t+Su2aCOJxu617MwTOqPzumaDWEdvao?=
 =?us-ascii?Q?khFC1sFXX5edKDqgSbnhgCOowYL5w6tpIySxZjLL1lEE0vd2WC33H3Igqm5g?=
 =?us-ascii?Q?BDAvhIJmR4vMypkiJrqQK0ua6RGRAriatkXtCFoa74QLVe8AOinB4ERqVdWz?=
 =?us-ascii?Q?mlenVw9lM4lrkYOdD4rtfu/0N8NqsFsX4+LDgNqKqx1HvvoafDkuU+ODLXdr?=
 =?us-ascii?Q?di1nyHieAkgtPRjlXrEfQ6cDwbvuvaLihsxXEf8fBGwnoqSoTRH3si4P3UxV?=
 =?us-ascii?Q?ueBi/3tb8igyNLStJLmbWYACRfWw7Qu84RGeARrmkASXylngbu/nqHiAweBb?=
 =?us-ascii?Q?AM4ykwVim1u/nzH8iKk62jDBcioDXJxM+FTklf5L5WG+HWsCs9OBHwg25pEh?=
 =?us-ascii?Q?8xMFgGHmv0D4dXyia9L+ANdXHW10BndSGBTiL2idAe/R/o293ucjDJmEjjQi?=
 =?us-ascii?Q?G/OAXn/mqouYDIV2l9VFtoxz4O0+d14SIzu4BKdbCyEuMXeW8NWk07yvtakg?=
 =?us-ascii?Q?HP7oxlu2W7rzilDMaYd7YxyDxtXmQYUsgIL9tGQ7cLLxfsjenKaGK+o/1Oe6?=
 =?us-ascii?Q?yrF2XlS7OfYBzQAufPMSN3O7gT8iDCJ2J5rw8pHgBlSTLejouxiGJB2jlIYM?=
 =?us-ascii?Q?c1zKL/3PCmpYlt1/W58BB6h1wgmn9j4t8pKiPS7GZ1sC2vEws2/5QMaC8byA?=
 =?us-ascii?Q?tH7nZ1a0oz3+3IBbLPfICJi1VrHuBL+sDjoRna4w0LK3MSjHucmdnW4E0gGC?=
 =?us-ascii?Q?SEZsmwYsqwHPfOLu4p6UouzNp09I5w7lzh878552Xp4GKkjOoqYBxikZVugj?=
 =?us-ascii?Q?mYKVR6H28GXBktaoEsaV2oSevYZZZLCqKaqqdNI8S0iq3wO1zzvghO97k9cV?=
 =?us-ascii?Q?UW0FBTARbxncju2I+qQkKc/U2ENDk1rm+LAf1olaxuG9l/wqbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:37.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6c31af-89c8-4d5a-9885-08dc94232d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

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
index 42436e1cf1e2..f5c255ede973 100644
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


