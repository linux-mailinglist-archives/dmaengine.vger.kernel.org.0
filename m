Return-Path: <dmaengine+bounces-3571-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5E9AFF5B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1902A1F21829
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9FE1D63F6;
	Fri, 25 Oct 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RabLzWIF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BE1D54F7
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850446; cv=fail; b=QccmyPAGoxVPvXl3wPGM5c7HLE4o89GEWxoZeU+4+TSD3yX3bveUhBbQjAq+Z59SCRvpwma2ay4lZ4BltS1jbni7C5HkixB7dY+Vsq+BWm5QDmPPmA3F09nMEmTEj08H8YmoKuwVWuDSazRaMOf3fDU6B0HvAlk9z3EQ7nS5LZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850446; c=relaxed/simple;
	bh=RrHFAqfbmYUPphZJ0u0bxKzVrCph4MQSUFrGHskS7mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQPL+bEEYqbqzm9BIAw9t/rHWE385y3W7I4Hq0vSfEactJK1OoXANINBBreNwcus6VcN9ri5ScJ2sPEg3RttacVMCSKGNOgXrMOpFFsXDlxpUe6+Y/oi7q9eQ1ha0aUEdKsWlilr83REEvOR3LKZD9/2XJJrr106ufnIdvZ/NNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RabLzWIF; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtC7Gpszd4cbvD8a6LIONSWguikAFfv2OOfLPoyGclSHyIzdHRCnVoegt1afhURArCrijwZ1fOaYFR/4k2ACkwc1JPOcsvjNDcZhJkfDyoUdUUo1VdN+xjGq17pQ3zNPDFFCCFJaxoGR8m32ThLeh+auio8bFiOfrgb/dWoQ8cjTGJaSAI37NxFpJmiskojfhebkxuRimYiK7JfoPHx2BD8ntMd41EEDk9x6o5zMk1UakDpvLJ2vlwlyd8IG9GefwTwKU3nHkAbv4cQdpl68dvNm0QQ6hkKnWWPu9EzVVFTP7mozkF3O2Ni+rJRqg3B5cyPUFlm4g3e1QkbuZzD51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74URZEukGNvKlEtLKfW1S8MpU9zZUwOYPUYRVDDLHLk=;
 b=SAfetn+4Xf4U7ak35xv2lZ7Yqn5n2Lg5EpvQmDLqbrONbUz/hkmcTk5L2Gu503ELXKuUtpbv8tFF9O57wf2B47K72L6/YEw6+/WTE72aU1B3pvPvN0cY/TJhYy0/oL++Hk0xWaGd7khqleb+k4lBxa5eqBaVHSZ3hasW0dlat3skpI9JxGGKZ2OqLWZnAhiG8Eo/y6Gzq115mckZn6T4XafFne6a5fwxcNZ0fz0yi4tqavUXJoQJQZARNia6fLgjt6v3rf47rIHVV/aWSgheBDaG2yvrZgHLasww6GcSqipvNEQ9MMh3BcXHoQrOjU7/xYTh5uyZ8dEs7Pr2//nN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74URZEukGNvKlEtLKfW1S8MpU9zZUwOYPUYRVDDLHLk=;
 b=RabLzWIFgJ7O668ouZ6iCX9HhoFp7j10evB7MrhZwEFqL33aUDMRV9f/Gb8t4+kzTTK0mQZMG/QAqUA+CXXA6JYaeEfY0FCjCKEb3XkUFEUSDxIfA/HBUr3CkNMxCDC7/1ghdCekTwpKvsX92qZMFX5m+auOW6vWjldi1U+W120=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 10:00:40 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::69) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:37 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 2/6] dmaengine: ae4dma: Add AMD ae4dma controller driver
Date: Fri, 25 Oct 2024 15:29:27 +0530
Message-ID: <20241025095931.726018-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 50654e28-4763-46dd-ace2-08dcf4dbe1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+SS9jTLfsrfBHArkTFhfuIPT8NfCGm1i9A9Pgrr4BrSncUO5PMFN5gND4SPk?=
 =?us-ascii?Q?B1j/EyEGp8e3erTa1qJcSBLkjUJ54Ulgr1Abgm5SjU8XkBMPYM+spYatmZu+?=
 =?us-ascii?Q?+lTwIHM+UwGBdTuz4YOXgCsucCwLWl8hfFJstcPCg/BvN1+Z5QLE6CRQiRdA?=
 =?us-ascii?Q?oZb/zEkZwGPlA9uKT09uhIH9plW54tmssaNdiKEdgE9faO3je94GyfpwqX2B?=
 =?us-ascii?Q?hzk5e3WpwE0XATvk9o3P7+mUcPICV4SUky1Ma8i9Ip8pv/IvazBmNsAGU3Ss?=
 =?us-ascii?Q?6HIaaSJJtqJl3U4jpL3WrOhh+lIrl1FLPTXKtB9E4TL6uqapRMRjQ13Z7s89?=
 =?us-ascii?Q?zqLi+P5eU2k04wYUtNBFqeQE/Qd6S7gaoAs4SWVGER5VwO+7k/dWw0bn+0rm?=
 =?us-ascii?Q?seEJCnp7aIpWwu1atMyBjKiIzgPcbUiaAZ77/WynWmYswi6ZEm6tazTKez6t?=
 =?us-ascii?Q?DMwBqnfFZjL8r0A97ekL4pM4JnYB5zOsH9+cfbX9rXek1soT+9SgS6AOSOxF?=
 =?us-ascii?Q?A8CyCcLYowbozbP8ZyPxHTxPOtgQiKu/R4rNJo6QaIXHp8XCY/Ur9Aqk2DIc?=
 =?us-ascii?Q?qg4sFtAelmTWlBwp2UgPHLpKLNIL4P4lrbK72+EiPCCEt6mrVAmcLSZHZRad?=
 =?us-ascii?Q?t7+chQdC4CYDM7kWx/NRuZ/Fg9bSp+mfmIxVnFBgwAwI1Lh8vfRkwCk6b68Q?=
 =?us-ascii?Q?pNmeSqHlDU5CYyZnICtICbtJpG4xQlw7fSJnw0Uct657bBKa1yeMMvezfjfK?=
 =?us-ascii?Q?DYYWE4CBCsxk2wTCbqGVFdkyM5iUTMUt2VsHrwB+JXWLn+bGRTporKqn0nLh?=
 =?us-ascii?Q?xY2jjS+J9pg3/0fVka4AaT5BrKmlfGqkmcBjhmy9oszFdSg+PeJPw9JoWoOW?=
 =?us-ascii?Q?rj7hEeiAI7cjB0Mmqim5BaAhU+gSF2NNb8Ry1aXdfXK4i4XQhgoReONn9BuU?=
 =?us-ascii?Q?KP0WaT8xjJnoE04oFU3kcIAZMLsJWVdW4L9xaHxljgcW/iVifgo1XbNYNH6S?=
 =?us-ascii?Q?pxFLx67Fg4gOFrr5A/EyWHOmtl9mYgoLMxg4UTDQTIeJkqTy1P9ast7xAAAp?=
 =?us-ascii?Q?4m9XUZrmJlf3HdCCAz874O+Jq743h38PEC32cd8NYFFQvbZ3Kc0U5Fb30elp?=
 =?us-ascii?Q?cBPo8wFtxzt7k2fwrl9aoA+uJvKjGouIv4vM3oNMRmRo+jScLTV77Jk634WR?=
 =?us-ascii?Q?fICdfShJ4cSDePpxkFJNNcbEtLmxWqEI5fKJFyKKuCVduEbohgDr52Zu83B6?=
 =?us-ascii?Q?V6HlIeRfERrz6CifgzkTKKUg+WqlkRcIzNJMMHWJPG268P6ZfwH1z8yWMyfA?=
 =?us-ascii?Q?YN7ssHHcSECKom0gsqC7D9VSQraBaw6LoJWfWDnq0Xj3/D9t2bZoso+xcnVL?=
 =?us-ascii?Q?UrD1Kjb6QXC9vg8JwmXtTD8MMmAMxPazanXFRaJk+Ph1FQi/2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:40.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50654e28-4763-46dd-ace2-08dcf4dbe1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

Add support for AMD AE4DMA controller. It performs high-bandwidth
memory to memory and IO copy operation. Device commands are managed
via a circular queue of 'descriptors', each of which specifies source
and destination addresses for copying a single buffer of data.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                             |   6 +
 drivers/dma/amd/Kconfig                 |  15 +++
 drivers/dma/amd/Makefile                |   1 +
 drivers/dma/amd/ae4dma/Makefile         |  10 ++
 drivers/dma/amd/ae4dma/ae4dma-dev.c     | 151 +++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     | 157 ++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h         |  96 +++++++++++++++
 drivers/dma/amd/ptdma/ptdma-dmaengine.c |  49 ++++++++
 8 files changed, 485 insertions(+)
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d9f5a5c471f..f096dadf2e28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -971,6 +971,12 @@ L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/ras/amd/atl/*
 
+AMD AE4DMA DRIVER
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/amd/ae4dma/
+
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
 R:	Thomas Delev <thomas.delev@amd.com>
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
index a09517d51449..00d874872a8f 100644
--- a/drivers/dma/amd/Kconfig
+++ b/drivers/dma/amd/Kconfig
@@ -1,5 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
+
+config AMD_AE4DMA
+	tristate  "AMD AE4DMA Engine"
+	depends on (X86_64 || COMPILE_TEST) && PCI
+	depends on AMD_PTDMA
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for the AMD AE4DMA controller. This controller
+	  provides DMA capabilities to perform high bandwidth memory to
+	  memory and IO copy operations. It performs DMA transfer through
+	  queue-based descriptor management. This DMA controller is intended
+	  to be used with AMD Non-Transparent Bridge devices and not for
+	  general purpose peripheral DMA.
+
 config AMD_PTDMA
 	tristate  "AMD PassThru DMA Engine"
 	depends on X86_64 && PCI
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
index fb12f2f9e7b7..11278c06374d 100644
--- a/drivers/dma/amd/Makefile
+++ b/drivers/dma/amd/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
 obj-$(CONFIG_AMD_PTDMA) += ptdma/
 obj-$(CONFIG_AMD_QDMA) += qdma/
diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
new file mode 100644
index 000000000000..e918f85a80ec
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD AE4DMA driver
+#
+
+obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
+
+ae4dma-objs := ae4dma-dev.o
+
+ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
new file mode 100644
index 000000000000..7cbef9e79f38
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AE4DMA driver
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#include "ae4dma.h"
+
+static unsigned int max_hw_q = 1;
+module_param(max_hw_q, uint, 0444);
+MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
+
+static void ae4_pending_work(struct work_struct *work)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+	struct pt_cmd *cmd;
+	u32 cridx;
+
+	for (;;) {
+		wait_event_interruptible(ae4cmd_q->q_w,
+					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
+					   atomic64_read(&ae4cmd_q->intr_cnt)));
+
+		atomic64_inc(&ae4cmd_q->done_cnt);
+
+		mutex_lock(&ae4cmd_q->cmd_lock);
+		cridx = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
+		while ((ae4cmd_q->dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
+			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
+			list_del(&cmd->entry);
+
+			ae4_check_status_error(ae4cmd_q, ae4cmd_q->dridx);
+			cmd->pt_cmd_callback(cmd->data, cmd->ret);
+
+			ae4cmd_q->q_cmd_count--;
+			ae4cmd_q->dridx = (ae4cmd_q->dridx + 1) % CMD_Q_LEN;
+
+			complete_all(&ae4cmd_q->cmp);
+		}
+		mutex_unlock(&ae4cmd_q->cmd_lock);
+	}
+}
+
+static irqreturn_t ae4_core_irq_handler(int irq, void *data)
+{
+	struct ae4_cmd_queue *ae4cmd_q = data;
+	struct pt_cmd_queue *cmd_q;
+	struct pt_device *pt;
+	u32 status;
+
+	cmd_q = &ae4cmd_q->cmd_q;
+	pt = cmd_q->pt;
+
+	pt->total_interrupts++;
+	atomic64_inc(&ae4cmd_q->intr_cnt);
+
+	status = readl(cmd_q->reg_control + AE4_INTR_STS_OFF);
+	if (status & BIT(0)) {
+		status &= GENMASK(31, 1);
+		writel(status, cmd_q->reg_control + AE4_INTR_STS_OFF);
+	}
+
+	wake_up(&ae4cmd_q->q_w);
+
+	return IRQ_HANDLED;
+}
+
+void ae4_destroy_work(struct ae4_device *ae4)
+{
+	struct ae4_cmd_queue *ae4cmd_q;
+	int i;
+
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		ae4cmd_q = &ae4->ae4cmd_q[i];
+
+		if (!ae4cmd_q->pws)
+			break;
+
+		cancel_delayed_work_sync(&ae4cmd_q->p_work);
+		destroy_workqueue(ae4cmd_q->pws);
+	}
+}
+
+int ae4_core_init(struct ae4_device *ae4)
+{
+	struct pt_device *pt = &ae4->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
+	struct device *dev = pt->dev;
+	struct pt_cmd_queue *cmd_q;
+	int i, ret = 0;
+
+	writel(max_hw_q, pt->io_regs);
+
+	for (i = 0; i < max_hw_q; i++) {
+		ae4cmd_q = &ae4->ae4cmd_q[i];
+		ae4cmd_q->id = ae4->cmd_q_count;
+		ae4->cmd_q_count++;
+
+		cmd_q = &ae4cmd_q->cmd_q;
+		cmd_q->pt = pt;
+
+		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
+
+		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
+				       dev_name(pt->dev), ae4cmd_q);
+		if (ret)
+			return ret;
+
+		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
+
+		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
+						   GFP_KERNEL);
+		if (!cmd_q->qbase)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		ae4cmd_q = &ae4->ae4cmd_q[i];
+
+		cmd_q = &ae4cmd_q->cmd_q;
+
+		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
+
+		/* Update the device registers with queue information. */
+		writel(CMD_Q_LEN, cmd_q->reg_control + AE4_MAX_IDX_OFF);
+
+		cmd_q->qdma_tail = cmd_q->qbase_dma;
+		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_L_OFF);
+		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_H_OFF);
+
+		INIT_LIST_HEAD(&ae4cmd_q->cmd);
+		init_waitqueue_head(&ae4cmd_q->q_w);
+
+		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
+		if (!ae4cmd_q->pws) {
+			ae4_destroy_work(ae4);
+			return -ENOMEM;
+		}
+		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
+		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
+
+		init_completion(&ae4cmd_q->cmp);
+	}
+
+	return ret;
+}
diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
new file mode 100644
index 000000000000..43d36e9d1efb
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD AE4DMA driver
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#include "ae4dma.h"
+
+static int ae4_get_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix = ae4->ae4_msix;
+	struct pt_device *pt = &ae4->pt;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev;
+	int i, v, ret;
+
+	pdev = to_pci_dev(dev);
+
+	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
+		ae4_msix->msix_entry[v].entry = v;
+
+	ret = pci_alloc_irq_vectors(pdev, v, v, PCI_IRQ_MSIX);
+	if (ret != v) {
+		if (ret > 0)
+			pci_free_irq_vectors(pdev);
+
+		dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+		if (ret < 0) {
+			dev_err(dev, "could not enable MSI (%d)\n", ret);
+			return ret;
+		}
+
+		ret = pci_irq_vector(pdev, 0);
+		if (ret < 0) {
+			pci_free_irq_vectors(pdev);
+			return ret;
+		}
+
+		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
+			ae4->ae4_irq[i] = ret;
+
+	} else {
+		ae4_msix->msix_count = ret;
+		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
+			ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
+	}
+
+	return ret;
+}
+
+static void ae4_free_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix = ae4->ae4_msix;
+	struct pt_device *pt = &ae4->pt;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+
+	if (ae4_msix && (ae4_msix->msix_count || ae4->ae4_irq[MAX_AE4_HW_QUEUES - 1]))
+		pci_free_irq_vectors(pdev);
+}
+
+static void ae4_deinit(struct ae4_device *ae4)
+{
+	ae4_free_irqs(ae4);
+}
+
+static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct ae4_device *ae4;
+	struct pt_device *pt;
+	int bar_mask;
+	int ret = 0;
+
+	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
+	if (!ae4)
+		return -ENOMEM;
+
+	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
+	if (!ae4->ae4_msix)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		goto ae4_error;
+
+	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
+	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
+	if (ret)
+		goto ae4_error;
+
+	pt = &ae4->pt;
+	pt->dev = dev;
+
+	pt->io_regs = pcim_iomap_table(pdev)[0];
+	if (!pt->io_regs) {
+		ret = -ENOMEM;
+		goto ae4_error;
+	}
+
+	ret = ae4_get_irqs(ae4);
+	if (ret < 0)
+		goto ae4_error;
+
+	pci_set_master(pdev);
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+
+	dev_set_drvdata(dev, ae4);
+
+	ret = ae4_core_init(ae4);
+	if (ret)
+		goto ae4_error;
+
+	return 0;
+
+ae4_error:
+	ae4_deinit(ae4);
+
+	return ret;
+}
+
+static void ae4_pci_remove(struct pci_dev *pdev)
+{
+	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
+
+	ae4_destroy_work(ae4);
+	ae4_deinit(ae4);
+}
+
+static const struct pci_device_id ae4_pci_table[] = {
+	{ PCI_VDEVICE(AMD, 0x14C8), },
+	{ PCI_VDEVICE(AMD, 0x14DC), },
+	{ PCI_VDEVICE(AMD, 0x149B), },
+	/* Last entry must be zero */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ae4_pci_table);
+
+static struct pci_driver ae4_pci_driver = {
+	.name = "ae4dma",
+	.id_table = ae4_pci_table,
+	.probe = ae4_pci_probe,
+	.remove = ae4_pci_remove,
+};
+
+module_pci_driver(ae4_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD AE4DMA driver");
diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
new file mode 100644
index 000000000000..4a1dfcf620c1
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD AE4DMA driver
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+#ifndef __AE4DMA_H__
+#define __AE4DMA_H__
+
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include "../ptdma/ptdma.h"
+#include "../../virt-dma.h"
+
+#define MAX_AE4_HW_QUEUES		16
+
+#define AE4_DESC_COMPLETED		0x03
+
+#define AE4_MAX_IDX_OFF			0x08
+#define AE4_RD_IDX_OFF			0x0c
+#define AE4_WR_IDX_OFF			0x10
+#define AE4_INTR_STS_OFF		0x14
+#define AE4_Q_BASE_L_OFF		0x18
+#define AE4_Q_BASE_H_OFF		0x1c
+#define AE4_Q_SZ			0x20
+
+struct ae4_msix {
+	int msix_count;
+	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
+};
+
+struct ae4_cmd_queue {
+	struct ae4_device *ae4;
+	struct pt_cmd_queue cmd_q;
+	struct list_head cmd;
+	/* protect command operations */
+	struct mutex cmd_lock;
+	struct delayed_work p_work;
+	struct workqueue_struct *pws;
+	struct completion cmp;
+	wait_queue_head_t q_w;
+	atomic64_t intr_cnt;
+	atomic64_t done_cnt;
+	u64 q_cmd_count;
+	u32 dridx;
+	u32 id;
+};
+
+union dwou {
+	u32 dw0;
+	struct dword0 {
+	u8	byte0;
+	u8	byte1;
+	u16	timestamp;
+	} dws;
+};
+
+struct dword1 {
+	u8	status;
+	u8	err_code;
+	u16	desc_id;
+};
+
+struct ae4dma_desc {
+	union dwou dwouv;
+	struct dword1 dw1;
+	u32 length;
+	u32 rsvd;
+	u32 src_hi;
+	u32 src_lo;
+	u32 dst_hi;
+	u32 dst_lo;
+};
+
+struct ae4_device {
+	struct pt_device pt;
+	struct ae4_msix *ae4_msix;
+	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
+	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
+	unsigned int cmd_q_count;
+};
+
+int ae4_core_init(struct ae4_device *ae4);
+void ae4_destroy_work(struct ae4_device *ae4);
+void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx);
+#endif
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index a2e7c2cec15e..77fe709fb327 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -10,8 +10,57 @@
  */
 
 #include "ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../dmaengine.h"
 
+static char *ae4_error_codes[] = {
+	"",
+	"ERR 01: INVALID HEADER DW0",
+	"ERR 02: INVALID STATUS",
+	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
+	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
+	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
+	"ERR 06: INVALID ALIGNMENT",
+	"ERR 07: INVALID DESCRIPTOR",
+};
+
+static void ae4_log_error(struct pt_device *d, int e)
+{
+	/* ERR 01 - 07 represents Invalid AE4 errors */
+	if (e <= 7)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
+	/* ERR 08 - 15 represents Invalid Descriptor errors */
+	else if (e > 7 && e <= 15)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	/* ERR 16 - 31 represents Firmware errors */
+	else if (e > 15 && e <= 31)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
+	/* ERR 32 - 63 represents Fatal errors */
+	else if (e > 31 && e <= 63)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
+	/* ERR 64 - 255 represents PTE errors */
+	else if (e > 63 && e <= 255)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
+	else
+		dev_info(d->dev, "Unknown AE4DMA error");
+}
+
+void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
+{
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+	struct ae4dma_desc desc;
+	u8 status;
+
+	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
+	status = desc.dw1.status;
+	if (status && status != AE4_DESC_COMPLETED) {
+		cmd_q->cmd_error = desc.dw1.err_code;
+		if (cmd_q->cmd_error)
+			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
+	}
+}
+EXPORT_SYMBOL_GPL(ae4_check_status_error);
+
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
 {
 	return container_of(dma_chan, struct pt_dma_chan, vc.chan);
-- 
2.25.1


