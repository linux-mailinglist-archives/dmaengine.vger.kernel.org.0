Return-Path: <dmaengine+bounces-3118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC89719A7
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A042128482F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BD1B375C;
	Mon,  9 Sep 2024 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wh/EhRMs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD31B5804
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885616; cv=fail; b=Q0MH0mYyLmXLRvNJKXR3RAlfdNWAo40ttPGH3OSH8x3/SLlFiOQ542ZiziV6x+93xIJhC7NV9K+6J6hnSc+otH32zIsU4ZuSiNV2y+sqSUr5mzBr2UVhmpFfpJ+5lJ2kJmbXs628dsQOzzarz3bLVzfoOpJ6tuUh/OqT2QqMkR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885616; c=relaxed/simple;
	bh=NMADSrzg/jKKh5bC51O/laJJMT3ONkPwFg4pOD28XEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+5HDwN7W/PJe7Faap+vGTq/x/wKmqrPvc8MK/mIKdKb9CLOo4RzbojuW02aBO/bIS5fTZalz8Be+A0G6stoP9K0pWcM7hUFQnaZTxnI7HyTSj+F4GurZuW0finThhhUV2gM9YU/8N2j4jYvVoo97rxbcTgsP3F00f9MyVhak28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wh/EhRMs; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIE3Nz4vF9g6VahjOOAvLbuaXBYpEA0pfwymCnwOJyyTCQm9DkUwGMKBgTeXzA8sL+HNXLpKfRoc2NE52dyxrCOMUXYOpHmEaicV2ck1HCoRYFkll1a0491fxEo5H6SeRlsjLBVw5Mk3v/87GU+NPd1oNSWfouAAFS82z0ktRP9e/7dCGZgPn2RA2xK6JfvexFisU8aSDNEX0LQCQ2X6u6jdZiAhIg3bj6M1hSudnsCq5aKlzFAqgVGjmCpj2GLrqN9oqmH/abpZKTucPYFIKPFaJo4JxBM491a+q5rogHLE/l12NmmJRVlFgqy3Vah43tDum3v0p3nA8uH6O3VukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqvXrlA9wJ50x16hw9DlFGTHhD8/hANqqlUbIkaImbQ=;
 b=bCSLxvHmfwkTb4y0xQEV8Vgx1tjv12kNoWG0C2/4TmLN9cXsg09n7ejrZsrKIQUnygzccwiMi1sPNqZJqdZnYXl96F7H5JFlPBSTB27QDPco+2ut8Y7kgu6RsOBl5v+cfWPjnYbaGMibN5GGFFvMrwhLJ2Evh31uUmtf57SQz+mbyPVc5BYp7RxkB1Xz31wWnTPxOIcN4rrFif6V9KXv7/Yh3SJdzIIgYN5V1Mm71iZgGOQhSkz4NQ0WR0l4QJvTko0NtVNSOoALn4EgsGejVxFl3X7JDp2gk+AW68xFtigx3OM1HVj2IDgxtwpVUkFRd+Md5xYYL7ZpBBRPGN5mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqvXrlA9wJ50x16hw9DlFGTHhD8/hANqqlUbIkaImbQ=;
 b=Wh/EhRMsZphAQgBqM1g8Ts0eXvRbAjiJ+8UjwswG+q7OiEbcf8IuOczephsqSNDVbMj7z6MCmH32k380hHCbA6vGn6H+JaE85pHmtVAVz48IqG+FJ3BXP9adYbUBIoOTRlgmlDsHaw5NfY9L/zrh3xm7OBs7dnrwIsMNlmYGN0g=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 12:40:08 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::45) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:08 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:04 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 2/6] dmaengine: ae4dma: Add AMD ae4dma controller driver
Date: Mon, 9 Sep 2024 18:09:37 +0530
Message-ID: <20240909123941.794563-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8b8b3a-637c-43f0-a645-08dcd0cc89ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZE1Pp083a0QOx3W/qhN8bBuq1yE4BgjoBGR46qEqkq8WbXzuCdF/bi6HPb/3?=
 =?us-ascii?Q?Aths5zZdh9s4O7xpmKPgYuSVpP+wyaIgVqiw/3EHYWIsf0rNxGYbox+taMrX?=
 =?us-ascii?Q?Qw7Htiyen0LNmCCXQMC9kV+OxMC1UL6IYIvk/x6ObQoRFIoWZvB6EwINL0CG?=
 =?us-ascii?Q?7aBlsbdIoMK/LvL852Fyjm7vv1Wtb5KRzYyCj/rz+wX/ssaDS5RNryMaYVYp?=
 =?us-ascii?Q?42UV/pccGsgIP5+3xO1tsAjvtxDLNZJwSfWd1nbAnBQ8l6N4yWfRnnX8+ohE?=
 =?us-ascii?Q?9ABr5PfIgnflw0u51XAqeJvxD+vi6xKeoq6hidJNjiUo3KeEeZhS9taX24MB?=
 =?us-ascii?Q?feDOjM1CnN9wpkKAh67aQSjyOeMGf5Zd7UvIdvxNP+lKvYY7i6OtHZv2ipUi?=
 =?us-ascii?Q?GtjGn+lLb3vuz371XSTHms4jd5Yd342rqvhLbsi0h0iEf5UnC+DzV1jgXXQa?=
 =?us-ascii?Q?+J/7Bo6TQkN1xTJR2E0ohMc7GEFQy4KnKJH5OFO6SrjVyB2C0oER4cjTAOA3?=
 =?us-ascii?Q?M6FbCM4iAF7+7TbZIk7J1a2PRDjvjbMV0mczb7CUEJ5SFsUeVf6eBQ+eISfg?=
 =?us-ascii?Q?KXxG5L7SO97TMhHz85dHSk2dj4pFBzO4wSghOL6Ko7LbA2Xse/IITFwYnIE1?=
 =?us-ascii?Q?fJblSZu3x5pown9m7Hpjuk/sZXRBPTq4l1f5jcPVhSqT/PSEwO+zzSnhCa8S?=
 =?us-ascii?Q?vbyONIzTcoeexTojXhMTxRe/o0epUYeh15R8vecO1lAE/dJ4+W52PKs+qU6v?=
 =?us-ascii?Q?QlsqB+NUbGlg88KM0LywzI0fr+WOKXfD4RD3Aks3LPSJdUWguwavcctMNPm8?=
 =?us-ascii?Q?2q+LRa6JDbDFPA57yQHAbnRaITYB/QXQ48BrqRd8yQA9sts9IW806M8QEgWj?=
 =?us-ascii?Q?0bGY3Q1I2zavtHiuien5+eUfNdrwPvVq4uE+9XcNYdyJ6A46HDZj2jV3uIBU?=
 =?us-ascii?Q?GoKaY/8FnaWVkboW20PnZ5s5mqoBWd8C83hSIoZ4Ao6+jkUFHFYwwAGDpZNe?=
 =?us-ascii?Q?5lAOMirmIp44gjL2D1ST8CfLFkM7Pqc0Zszed4peqjX8MB2Q5zfqWC+ut0ea?=
 =?us-ascii?Q?aNX+tAX7WTN5JvNQSTu1q4396ps0B0oijKpOD2NaSvtjnCEIQEJOpULl8W4E?=
 =?us-ascii?Q?/Wacf1FDj0Sv5u385QHNuuemV+X91b9RowGE8zPR/gG8X1Eu3qVgpNRArvXm?=
 =?us-ascii?Q?N2aHLtf6b3SzlSxC8DqrJyxZI2hYGLk5tWs5kLUcVj12LxiNieaJOxNjmwHQ?=
 =?us-ascii?Q?3HasTg1wJqnw/hFO4kD46nOQA6GSHOnTFFalRGJTLfHMh5jZf1Us3q7w0gme?=
 =?us-ascii?Q?HTpbH9ad5TPgihLyGv4Q5rLaFMil5VL7rxWhESUy97YJQYfFcPtIgjy0L8nr?=
 =?us-ascii?Q?sFdWLlyjMDJ6xeUpp/bP4Thx5NcvxyMXbcHAWceBHQR0cPOeRLzRNjMJoIOE?=
 =?us-ascii?Q?fna2x6F5DuE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:08.0060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b8b3a-637c-43f0-a645-08dcd0cc89ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

Add support for AMD AE4DMA controller. It performs high-bandwidth
memory to memory and IO copy operation. Device commands are managed
via a circular queue of 'descriptors', each of which specifies source
and destination addresses for copying a single buffer of data.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                         |   6 +
 drivers/dma/amd/Kconfig             |   1 +
 drivers/dma/amd/Makefile            |   1 +
 drivers/dma/amd/ae4dma/Kconfig      |  14 ++
 drivers/dma/amd/ae4dma/Makefile     |  10 ++
 drivers/dma/amd/ae4dma/ae4dma-dev.c | 198 ++++++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c | 157 ++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h     |  95 +++++++++++++
 8 files changed, 482 insertions(+)
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7712e5772e9..059863b35d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -954,6 +954,12 @@ L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/ras/amd/atl/*
 
+AMD AE4DMA DRIVER
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/amd/ae4dma/
+
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
 R:	Thomas Delev <thomas.delev@amd.com>
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
index 8246b463bcf7..8c25a3ed6b94 100644
--- a/drivers/dma/amd/Kconfig
+++ b/drivers/dma/amd/Kconfig
@@ -3,3 +3,4 @@
 # AMD DMA Drivers
 
 source "drivers/dma/amd/ptdma/Kconfig"
+source "drivers/dma/amd/ae4dma/Kconfig"
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
index dd7257ba7e06..8049b06a9ff5 100644
--- a/drivers/dma/amd/Makefile
+++ b/drivers/dma/amd/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_AMD_PTDMA) += ptdma/
+obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
new file mode 100644
index 000000000000..ea8a7fe68df5
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
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
index 000000000000..f0b3a3763adc
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -0,0 +1,198 @@
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
+static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
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
index 000000000000..2a8eddc77f93
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -0,0 +1,95 @@
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
+#endif
-- 
2.25.1


