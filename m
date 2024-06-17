Return-Path: <dmaengine+bounces-2386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E49290AAB8
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EBE1C24CBB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F2193064;
	Mon, 17 Jun 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cEdD9cNo"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C118FDAE
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618689; cv=fail; b=uXNpm/ndzTdZmwXm+kB+w44b7o3frn4q5prjEbp+/v8kPB4btcA1bU06/2T+jl+LzH4ckgPuy+31o5bi++crCiGdvg+FA/0uWBecwgIFbjnOVJcwAsRzpSeNkuQeM0+VVjcbeRMOXQJC0ywYK+hh38OdvxUTdC+z2AqcVuG4jGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618689; c=relaxed/simple;
	bh=bTI5OdQwXuD7jcouNu4rR0QyYag2F+br2RVgko+KQJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFUAbH3qn97ZGSbcVL2sY3oNu5zNSqoHUiOJRgwlwqEku1ZqY3MUoVYCeJd6vf01Uah+u1C2cEy7fqRkcJLTNhZvRVBgVXY95F29t4vCoDstccyxUTOfNa6O0t0jWJ96Dz/smAyKSy8+VEtUNn9q6UxcGskvOZp33hoNoSP/a88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cEdD9cNo; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgG8ejEJ+rqYwcALDsZ858J1ObJJFHIyQdlE5KdoflLV0hbQOrfn4xE1hbE90fzsS2L9X7y+FvsFeECNTPWgi350+R39FgcsPv7DoXLVyAzD02FfplEUoJyX1NySW4zx9OeFSvKeV3Gt9wMDFmADKRDE+u5WWLPKpyegVwD34FEna1bRDTCtrt9c5gVrJcdCQFNDOXpelJ++fPQ9fwQP2zawwYjE/YopzH5mI15iD5H9CK7je53ylvUA18qjaV9vItzzU5Ln6OIcieI+YgtqTengeYBsuTWHDBPy3rDkNpY8q4aVrwLILdD8yettM44ckLzsm75vLF4wviXXQp2j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRYm/CPfZXzSFmvHYVr51zHvI4V4z9hRELOZcG9CGaQ=;
 b=AK7XRrkLBGhn3KqzhXt0bIFDWvdWJjJJEi7Pgzr8EtyY7tyRQqFT+v9Q9GnIijAzcxqYFuNUjpaT0qgPgkEb0eisJ40LuQ2tWgvHJNlo3xi9dZZRiz1tgAnMt1ALz17nAQuXuIxJJ/GHsiM2mT/2hyDiXkGNH/uEOwR+tPp2lUVKBRgO4gdGJFBb/FPeNS9NeAa1hxFTQctOm9qnWClMul46CQJlE7uFA1OpvD5/ZXCZSizZPkNl0SGU/tHtlNPCSlZdXYZ1A9xOPFbzo/tk+CYJDn540sK3x2gA067H/iSh6mxxnhyTPXeMR8s4FIQ1svwmMTA3WdY3or0n1IAHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRYm/CPfZXzSFmvHYVr51zHvI4V4z9hRELOZcG9CGaQ=;
 b=cEdD9cNoBAWzJYRh/lzzG79L6esaqzobp0HPbBj4uVGBQVT+jHANySYaax1KgMONA6CJsMOXvadMthNwD8PTjhP9ZfRPYLY5vCZkirUJEuighlwbQTYpIDQWyj0DQ3+b0EB1wpkv/7kQZ7ZDvHD39jZLcr2rQzx3pPxeyjVpHkQ=
Received: from BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::22)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:42 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c4) by BL1P223CA0017.outlook.office365.com
 (2603:10b6:208:2c4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:41 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:36 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
Date: Mon, 17 Jun 2024 15:33:54 +0530
Message-ID: <20240617100359.2550541-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce57dc4-7913-4028-3c83-08dc8eb4e82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aueH9IiS3ZyJ+ZN6T+HZZmYf1TRLf6OhkDVsNZytebPPcXOcp1UbiAlT1G6h?=
 =?us-ascii?Q?d+sMb+liY0/bKYYH76m93MLHYnQ+zFZJHFIh+N1j2OiEE4cm1Hnz0XR/ftOq?=
 =?us-ascii?Q?MEhUJVyvXHE1OODLvMcmHdQuzH3hjffJp9vJStYRfxrxtcfGrpGm4xdwY9b2?=
 =?us-ascii?Q?6Qk5Ywwdz/aj0PzfY6H+FsPoCJUJCb5Gm7Yn7DtZaJreRPNprDzXLaT3ibYh?=
 =?us-ascii?Q?qmfh1wmZYwvQePx/MYdz3Jc688jj1znW90hoskUMGUV7JvLbqu1N4NNtYBhC?=
 =?us-ascii?Q?dolyNQ9A21ZnQUZrhXNDXT2Pv9WifXg2sqK0X/xKslgkUkt04zve7YgqZ7fy?=
 =?us-ascii?Q?FsSiv9BazompzPe7f3eLArZxmbO2amO61NnujnnoM4m3ZxeZ1poJ/BlloVFX?=
 =?us-ascii?Q?bMoTiF4tAoY61D3VTJWZR7TLH8nSMYTpzyxNezN/EBnoHR+Om6PNYxKzDlFH?=
 =?us-ascii?Q?mKvsERyhQXJAPsfQNJqjmdA/s+p2tgkU42JDpr9+DOrF2KO/T38SKujvfRbs?=
 =?us-ascii?Q?s4nrWwPrKwRthdCRDIuuNkPpoC6Kpqw3IH3eyEDc2/U0pfsbWpaqIqaIm/Pn?=
 =?us-ascii?Q?PLeRRmpx0QfLVyhzu9ytoUyW5tpzYfmNXhT4xXUjJKq8UHMX9fwbmzT6VVQk?=
 =?us-ascii?Q?lXp3s2m8o5C3o/MGVXLybNj+/g5hknPkSIRBL9IgXFuLUt/mwiU70EgKlKZw?=
 =?us-ascii?Q?ZXk/nXyQwDsvjl8Y5U4j/tXFBDMcHgsjJXB9oTpfaocMP1VkTb5DVr9RIfWT?=
 =?us-ascii?Q?RulTWryBs/7MD53m5jOn7rttf9TDU5XVmqymwQikH0cXXX905Z4ty9YNs5Pq?=
 =?us-ascii?Q?Stq9EJzIpj4aRu3XdyLrHQbc8b0LMEo5bxHBMfhFAK0Q85j4bFOg8gkjXBtx?=
 =?us-ascii?Q?JPed1KIqioXwMbYc79zQ8QbJGLKsyg3DeaG0Xg5yINSu1zP95PsPDjePe2ZC?=
 =?us-ascii?Q?9oKNW9vCKvnxgZtBmOsK6nDzRO+rmnVJwm5CT1DtdWxLud+zHqy8z9l81pMl?=
 =?us-ascii?Q?WEdgISlWDqPezs5JAxG26eROH0IBmNG7eP9sLDIAYW3v1IDVC8bz/m3zptPe?=
 =?us-ascii?Q?81RBNTKbbHhq0WTWR2Xymg37qPrQvZkUmwEOd065CCH2C5DBmHY+/0mDLo0X?=
 =?us-ascii?Q?lUJH3+aQka912XXe4K76WO1rtQICssBQscwnR8uyZLVQdGAje2s5Rhno76RP?=
 =?us-ascii?Q?+RJTepBuQLLw8X5Z5K1eI06tXM71EM0+p8Wr9cfWWfpSdV8X2J4liZEplOO7?=
 =?us-ascii?Q?H1tIeJnPiuxkNKY2seIjRvL4ah5JvEprCjvMO6Aii1qDMinJStxQBvyFXsq5?=
 =?us-ascii?Q?JMxUosGiKxYR93PucTwFkb3CvznwDe/fUJdMt18jbb+eBtTg4cmsxuYA8gQw?=
 =?us-ascii?Q?B/5dIqjv5MqKn3SaF/d0LPu3ilAWWv/kMMtruV2THLG3UmrX2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:41.9457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce57dc4-7913-4028-3c83-08dc8eb4e82c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Add support for AMD AE4DMA controller. It performs high-bandwidth
memory to memory and IO copy operation. Device commands are managed
via a circular queue of 'descriptors', each of which specifies source
and destination addresses for copying a single buffer of data.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                         |   6 +
 drivers/dma/amd/Kconfig             |   1 +
 drivers/dma/amd/Makefile            |   1 +
 drivers/dma/amd/ae4dma/Kconfig      |  13 ++
 drivers/dma/amd/ae4dma/Makefile     |  10 ++
 drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c | 190 +++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
 drivers/dma/amd/common/amd_dma.h    |  26 ++++
 9 files changed, 530 insertions(+)
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 create mode 100644 drivers/dma/amd/common/amd_dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c500c0567779..0d222d1ca83f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -947,6 +947,12 @@ L:	linux-edac@vger.kernel.org
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
index 000000000000..cf8db4dac98d
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+config AMD_AE4DMA
+	tristate  "AMD AE4DMA Engine"
+	depends on X86_64 && PCI
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
index 000000000000..958bdab8db59
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -0,0 +1,206 @@
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
+	if (e <= 7)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
+	else if (e > 7 && e <= 15)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 15 && e <= 31)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 31 && e <= 63)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	else if (e > 63 && e <= 127)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
+	else if (e > 127 && e <= 255)
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
+	/* Synchronize ordering */
+	dma_rmb();
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
+	u32 cridx, dridx;
+
+	while (true) {
+		wait_event_interruptible(ae4cmd_q->q_w,
+					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
+					   atomic64_read(&ae4cmd_q->intr_cnt)));
+
+		atomic64_inc(&ae4cmd_q->done_cnt);
+
+		mutex_lock(&ae4cmd_q->cmd_lock);
+
+		cridx = readl(cmd_q->reg_control + 0x0C);
+		dridx = atomic_read(&ae4cmd_q->dridx);
+
+		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
+			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
+			list_del(&cmd->entry);
+
+			ae4_check_status_error(ae4cmd_q, dridx);
+			cmd->pt_cmd_callback(cmd->data, cmd->ret);
+
+			atomic64_dec(&ae4cmd_q->q_cmd_count);
+			dridx = (dridx + 1) % CMD_Q_LEN;
+			atomic_set(&ae4cmd_q->dridx, dridx);
+			/* Synchronize ordering */
+			dma_mb();
+
+			complete_all(&ae4cmd_q->cmp);
+		}
+
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
+	wake_up(&ae4cmd_q->q_w);
+
+	status = readl(cmd_q->reg_control + 0x14);
+	if (status & BIT(0)) {
+		status &= GENMASK(31, 1);
+		writel(status, cmd_q->reg_control + 0x14);
+	}
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
+		/* Preset some register values (Q size is 32byte (0x20)) */
+		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
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
+		/* Preset some register values (Q size is 32byte (0x20)) */
+		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
+
+		/* Update the device registers with queue information. */
+		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
+
+		cmd_q->qdma_tail = cmd_q->qbase_dma;
+		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
+		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
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
index 000000000000..ddebf0609c4d
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -0,0 +1,190 @@
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
+static int ae4_get_msi_irq(struct ae4_device *ae4)
+{
+	struct pt_device *pt = &ae4->pt;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev;
+	int ret, i;
+
+	pdev = to_pci_dev(dev);
+	ret = pci_enable_msi(pdev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
+		ae4->ae4_irq[i] = pdev->irq;
+
+	return 0;
+}
+
+static int ae4_get_msix_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix = ae4->ae4_msix;
+	struct pt_device *pt = &ae4->pt;
+	struct device *dev = pt->dev;
+	struct pci_dev *pdev;
+	int v, i, ret;
+
+	pdev = to_pci_dev(dev);
+
+	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
+		ae4_msix->msix_entry[v].entry = v;
+
+	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
+	if (ret < 0)
+		return ret;
+
+	ae4_msix->msix_count = ret;
+
+	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
+		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
+
+	return 0;
+}
+
+static int ae4_get_irqs(struct ae4_device *ae4)
+{
+	struct pt_device *pt = &ae4->pt;
+	struct device *dev = pt->dev;
+	int ret;
+
+	ret = ae4_get_msix_irqs(ae4);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI-X vectors, try MSI */
+	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
+	ret = ae4_get_msi_irq(ae4);
+	if (!ret)
+		return 0;
+
+	/* Couldn't get MSI interrupt */
+	dev_err(dev, "could not enable MSI (%d)\n", ret);
+
+	return ret;
+}
+
+static void ae4_free_irqs(struct ae4_device *ae4)
+{
+	struct ae4_msix *ae4_msix;
+	struct pci_dev *pdev;
+	struct pt_device *pt;
+	struct device *dev;
+	int i;
+
+	if (ae4) {
+		pt = &ae4->pt;
+		dev = pt->dev;
+		pdev = to_pci_dev(dev);
+
+		ae4_msix = ae4->ae4_msix;
+		if (ae4_msix && ae4_msix->msix_count)
+			pci_disable_msix(pdev);
+		else if (pdev->irq)
+			pci_disable_msi(pdev);
+
+		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
+			ae4->ae4_irq[i] = 0;
+	}
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
+	if (ret)
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
index 000000000000..24b1253ad570
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -0,0 +1,77 @@
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
+#include "../common/amd_dma.h"
+
+#define MAX_AE4_HW_QUEUES		16
+
+#define AE4_DESC_COMPLETED		0x3
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
+	atomic64_t q_cmd_count;
+	atomic_t dridx;
+	unsigned int id;
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
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
new file mode 100644
index 000000000000..f9f396cd4371
--- /dev/null
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD DMA Driver common
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#ifndef AMD_DMA_H
+#define AMD_DMA_H
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
+#endif
-- 
2.25.1


