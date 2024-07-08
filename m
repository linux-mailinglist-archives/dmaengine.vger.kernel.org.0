Return-Path: <dmaengine+bounces-2652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B092A4FC
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52921C21118
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750215A5;
	Mon,  8 Jul 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edaEbF3y"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7213C674
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449931; cv=fail; b=MfcDIVIxDdH6tbX1hiTKbTJiPt2Tcw83/10f1olgpZCR6Qq0mWsKPK1qmGgxNZJbDhFTgpY5gYuwQwxSzTgi4d4H0XOY9UADTffiQTYfr6R0w7dilVyY8yTE32pGPX57VVoWHt2Saq4lXXNxyIr62va9WBkT/QqGn8Hft8jmBOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449931; c=relaxed/simple;
	bh=ylJ1aLl0PsADFRh/hQmBeKlWlZTWjZ1hafcKpHukRF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5vjQgjH+wekBtVpe8qXO0sLS3GmU7NiVB2LuL+evX87tPBwqeIVUgqLSsWVmNGjwBHT8uM++JUV4vsxZCpmwsV2OE1cGkgmKriSnlu7wGcUnrtvYxO/ICaj600/461ekYEGjmHITRxfloPDaRxo2GsHZk0g1+V83cuI7uPrKdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edaEbF3y; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E87m8iWv9rZPHjVHtk8OXZPuZ39nwCwooSvnv/m8JmaiDM1jAU4e/8x39/sQRxFuMReb0Xyexqrt3dzKT6+wfQbKUA93ATxDq8DZFnxtFOmAwyUcyymF7aiVATWW+Sowf+r80r+3Y6n6NJhfGWIKkzdI4ykIsRkYntQX7hpelBALERpCA6O/bXRBp2dKfwj6qjzYUEGPOUUvcKLlSQdNZ1IGSdx8OjgUaMzl6zaDOEz1B3OYPF9YGYjupfA/ZOPKoh3EMafCCAfPtxUb6r2Y9kBy6Ewn69OFkHAdMfNBWevA/RaQhLre54z3iB2Px0op7ahXK+9MmrfYDNsq8Zx6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTuh9YVo2leMT/3gkDs5eMS3d9DrTV86ARtU5mMClZw=;
 b=P8Nzng93Y+NMyHT/PL+Tpx8I5brHqEEH9Pro9ONmhA1GBVKmuViW5o5JkSRnarx4a/ogmgkbK4D7phyNpzzJcMNR+AZu2ouooeOaORbSuhDKHtpAH7AH0TyhJq22/ymYCz2/+teh/HPa3hqchRqmLXIlHDVV7bnDkw4/I5Yg0Es4b5ycm7cHp90b8rvoEC4/oTM/K9dO/4n/miewO5xV2RuDPh/DJMBfMWnnNt0gK7LEMNM1PDo1NVz53KM9p+R1/Y8OdpDFn8gw9fsZUN/yY+6Tc3BPyiZnJBMCwHgbc4HoXA9cGV/9OdJoy0oPkXu/V1HhMTYF7AnUk/R3bSGgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTuh9YVo2leMT/3gkDs5eMS3d9DrTV86ARtU5mMClZw=;
 b=edaEbF3y8kj+GtZXyUZ/kTMO1IxIAEeyC82yAg6HXnPAP+HXGnWGKndjqFaiam5FD0lReoClqpUWBkHurxTGt6xW/DzJHAnSV+3/SDmNjZO6sueKPv58lXF34LxFS0RaXORNdl25m8kZsWzM3DP+nGyN4yD+Ov3tb5Ag6aEA6CA=
Received: from BN8PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:94::41)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:45:26 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::4e) by BN8PR03CA0028.outlook.office365.com
 (2603:10b6:408:94::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:25 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:21 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
Date: Mon, 8 Jul 2024 20:14:55 +0530
Message-ID: <20240708144500.1523651-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d342c2-0b55-4dbb-a59b-08dc9f5c9a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbIWFpgj6aed8gvQ7EObSlc4rJH0c+hg739kgnSmqD6uLSnovkUv6XNCs+KM?=
 =?us-ascii?Q?J+0b8X2AJzgDg/EW/us9HpLhJNj3aNKDeK8UczFxEe+0p+tlSMQEL6cN9WbO?=
 =?us-ascii?Q?v6+Jc6+1G46Ike6qln3ybhlwJIZDevKomEFRCTTSMWgdY7LQeM96it9tQM2o?=
 =?us-ascii?Q?rhiMiQD1CdcBw8BFl4sUM/B1CteMFBOxAUeYP3n2Tk5IokavNtlIBtrSFdaU?=
 =?us-ascii?Q?tQfVRX/HhrZBhj/HaislVxZ69j52RZjvos5kMTCaEcx67yX5GzhWkShTxfmK?=
 =?us-ascii?Q?fpmEJ4n8v0HmpzjxCOuCaAyMGH8wRWgrynqUkG8szaedSS/pG5uPzn6IhORr?=
 =?us-ascii?Q?7+kafwd2LF50Alpekt9qsq8gcwBu+2pEZ7kwu4KjY40+gd0IjJ3yHD/Bs1DY?=
 =?us-ascii?Q?LmEEdWzC/hYK6lGIlua4r8Q/GTukQLy3V2hEfV7IxKBSsVr3ZFtlNeRkj2/g?=
 =?us-ascii?Q?ae9fuGQzDibI6EZ7TvH6HOFIDCb7BXApSyy2ZnGOGaIcQXLrQjv/YSB8sqjN?=
 =?us-ascii?Q?B9EE8IMIlviF1omjuxupdMCY9SUGCdhjwrOfEhcfHz2KPXeDiuMzhwK1iUVi?=
 =?us-ascii?Q?ygbZqQVjJ36t1MD2e8Vh3hm5yeA7FveIN0Kh+hixsoCiLHDRAUtrQ5ThuRsn?=
 =?us-ascii?Q?FQHY9ShFB2hawL8t2M6JFRADdgrsUkXgVQGX10xl3BlKIfTwpMWju3nmD6fH?=
 =?us-ascii?Q?WhwJ97xuK1j6tlm7SYiyqQkBj4EVC544vTFZJY19Qq5o4v/PdK3OISs1GRHl?=
 =?us-ascii?Q?ffG4h0KV5lgwiR5SwWwWM+cQA/JXb9/lezwHcv3WliUZAuLXpVhFs2sbbL3n?=
 =?us-ascii?Q?eAPLTp9pAaoHe5aMYRPUVjCQu2xFdTQq//jWH6lS8UabQqVXNJb+XxEy829l?=
 =?us-ascii?Q?o/oMDiT7ZYXKG+IcjLiZ6etyR2Vc9vfAJnNRtbdmUU9B9uVfI36HqOHguNNP?=
 =?us-ascii?Q?xC/JFkYNq4XlqGUmnuj2h+0sahlMnlWwAZ+ZlvG4a59SVf9ry+8BgD2lOeG0?=
 =?us-ascii?Q?e80nw88/m3ACzGVG76SmfCrWhQvSUaMrJU9Gggq1pCYVFBksEBCqazVxtpfF?=
 =?us-ascii?Q?N5lNRk7hGxdX3OjQuaJohXnl8JI0rmFv1m3qAIyluaVRLTvX9jSuklhhigwM?=
 =?us-ascii?Q?LNV38LO4kXBzvUhXYCc1Whouu4Be4V5YLI07Q/VT0UgGMQjEtnhAB0Tu+vSv?=
 =?us-ascii?Q?/zUQ5mpSzjp2wjgaacfHT3xmwyDGd/axdyou1dUEBlM7bqMVJVQLGWM0pL1u?=
 =?us-ascii?Q?o1HyrSLJtr+AV/8Br4sywzbmXvycoXqrLD10gspSjJ/BF+/iZN3gu0PSrMcb?=
 =?us-ascii?Q?/Yt6Wr3BaeyLtNfOB9PZ5KVcvG3gIy+3nKz5OLb/YjQdrANS1qG9OnoF1Bf1?=
 =?us-ascii?Q?HS+qyyRSxz4GVdC4zjgamLKa01uu72Eb0Q8h9/sDNKKNDFtblVjZ+wveBIeL?=
 =?us-ascii?Q?PXMxsNSeYcTfF+XQiPtogQIx20k+4MfG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:25.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d342c2-0b55-4dbb-a59b-08dc9f5c9a7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

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
 drivers/dma/amd/ae4dma/ae4dma.h     |  85 ++++++++++++
 drivers/dma/amd/common/amd_dma.h    |  26 ++++
 9 files changed, 498 insertions(+)
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 create mode 100644 drivers/dma/amd/common/amd_dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 33a1049fd38b..539bf52410de 100644
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
index 000000000000..c38464b96fc6
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
+	wake_up(&ae4cmd_q->q_w);
+
+	status = readl(cmd_q->reg_control + AE4_INTR_STS_OFF);
+	if (status & BIT(0)) {
+		status &= GENMASK(31, 1);
+		writel(status, cmd_q->reg_control + AE4_INTR_STS_OFF);
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
index 000000000000..a63525792080
--- /dev/null
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -0,0 +1,85 @@
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
+#define AE4_DESC_COMPLETED		0x03
+
+#define AE4_MAX_IDX_OFF			0x08
+#define AE4_RD_IDX_OFF			0x0C
+#define AE4_WR_IDX_OFF			0x10
+#define AE4_INTR_STS_OFF		0x14
+#define AE4_Q_BASE_L_OFF		0x18
+#define AE4_Q_BASE_H_OFF		0x1C
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


