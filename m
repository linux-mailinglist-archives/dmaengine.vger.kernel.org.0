Return-Path: <dmaengine+bounces-2372-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B14909419
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35BAB22D45
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970518755F;
	Fri, 14 Jun 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5DnrgzL"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED09187555;
	Fri, 14 Jun 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403410; cv=fail; b=E7egFBuAm7zXbvUA3momzsFEbR0zB9ocgjcFaRrUh/eC33Q8k+FIbnkZ/mwJfk32POf22brr0wGWUfytBbA6NNyw6vXXfthKJx0XCTmJ4BBu88nWGR1ewpWfueZWqkl2oaRjTnEXhYm4MrhzQ93Bm7b7mOrf5g7bUYRvxBEuK10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403410; c=relaxed/simple;
	bh=NDKgaj6j8Z9NtlUs9nmb+/zvUeG4kejiyvspYfIiOg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiQKhtPzm/uRIyFJH//fXtuyj9KWhAFWLJKx/mDWfyB218m3NEE7MXckBgWsoHgSvPGrufTZuzM1tneJpIuec9OUTMyjcZ7BW8whqV1NLAgMSL0yd+4fCHVtqvheL/WYrG5FcSDpdcmhno6ArWD0FpAwih0VRaPZ+4ShS610i+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5DnrgzL; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnGgeSvVqQa1XMbBz0e+XZChpB7rwuN6O7Lz9uz4nb8/RmTS06WIKrzRXNDVtOrQSmXLZC1iALEEc4tXyVvgE61uhe8orgxiJcjl2NKKOmGAQIIMw3Komeid25RzngWkB7kxisKlHeNu4dZXep6BzEYCp6U7VNB4CfxelL8J+P8q8dcy3mH5xlO4/Y5oJJlE3EXVscoEl0uXKVfddVmn8gFk5o2UI5P+E/2bfFkFmLlOrnGXWH8OQKA2D1xwR1KEeZZiTbNki8B963iTNlBKXYmDsl0acya3e2RZ4/6TpglcGuEbgGqKAQ3FwbOs7nmsUk3F2LKat0IzCXU6WcksKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3kz8g/wKE8lLARLjEBcTfwiVkI/jzdTOFdz7BVJg2o=;
 b=n12daZ6sXyaD+Swh6HjEwACTJQAmJAOhUlCW6j1nspT9WR2PpWGxgOYj8zhkR2xi8apXScznPWOHUA+Ga6n1iLRLo/Q9shIkz5fW+eXhclMBQNG4ffV4mHYlLqnzWWcC0ujoNiflwvaSzaMh9IE7vyDzUe55oyVlqvN+Mlo995ZaV2wFpueT24lisv+OUBMGLxddbUU/74ILiwc6fpEZWgP0FSSYm1gwnSqmHL5m3TTEOSVeHMKnRcDWPPf3Wth5Gsd7KfrsW3XeIkvVAdi3B8anETt9P+ttjwD+X/t4ePbwudmIj6ZcQGG0sHVVLh+/NUyFxTeJaDUGB0Ggd4gSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3kz8g/wKE8lLARLjEBcTfwiVkI/jzdTOFdz7BVJg2o=;
 b=Q5DnrgzL3tY5E/9/5EzXG2OQxiWcJE/HauqevnEcMk4WaYMQGLfODk9hJ+0v1MCmeURfByG7hoBbRSbL9lGhgMYbw4BaoTRwD63PKiHI/i650jfZAgVU7qB4dv8ezLRxKAulWC1M/SlawuoIslBVD853PfO31suHmd1FP1L2VYc=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 22:16:45 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::57) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:45 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:16:37 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>
Subject: [RFC PATCH 5/5] dcbm: add dma core batch migrator for batch page offloading
Date: Sat, 15 Jun 2024 03:45:25 +0530
Message-ID: <20240614221525.19170-6-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614221525.19170-1-shivankg@amd.com>
References: <20240614221525.19170-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6909e38f-cf95-487c-0505-08dc8cbfad5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y7Q7ROrfiMczMSwvi1MacrwDVhLZvbdaqb3Gj3QfVVu7Bzhpg0Tm/zLRIXS0?=
 =?us-ascii?Q?9lko3Tyf9DdKzQLUEqmA4i1QTFjcNPqZlw9vaPMkiSKyHW1jdeesTUXwENjA?=
 =?us-ascii?Q?o+QLP85MU6dQhVkg25E9GxisfZnaLow9PfLewKcjqxGD1yMGDFo/spY7RkSI?=
 =?us-ascii?Q?LxouJwT/JY2yyLRxs92P0qjWkHtV+2JQlB7f/jnxKeMN6OG8FA0HWNgg24+0?=
 =?us-ascii?Q?shIRtCCknXjP5a3UQq67KLZTQE63dPiluuCNKjI9xU3UYTQ/IbNCq12hVxso?=
 =?us-ascii?Q?wUzoagMCZiQxPWS4FQnjlNQAXlHbEznpvhyeSd8+HHN5KAp4NQpg7329gQA+?=
 =?us-ascii?Q?5on5Ok4SJw6gPLMd2+e6HGjH0f6rhVRKi+p8fnsy4sIbGJTNwKLwkAM5RyPh?=
 =?us-ascii?Q?J5e5+lB6U88QwDg7OlIqaEVuvf21Ml23IxUHrxk9IAVpD95h2GKcsCO1bYSD?=
 =?us-ascii?Q?GNFyVY1WBUNPkRE7anYvUtJOH3J7Unug2pWrLuKnmBmaWQp4qTgO8bomwkzQ?=
 =?us-ascii?Q?AF9A6PAUyXS/Fws1HapifrB19EKV+Em0YtAVJI8ByprIYPNAK7Owy/yfvygu?=
 =?us-ascii?Q?txRJHYB57cA+ccdSJkCRU8sI61B3BCObfJjawIVP2JeYhbAlcZRDOrTW1CCc?=
 =?us-ascii?Q?zUaKH1aGK2qAy0axBZeZ5XoXAUBXKSEw5xhBb3W4bNak4yS1bkJfBsraVwXF?=
 =?us-ascii?Q?mwIZWSxD3XlNaadgpL1jIOGNvOrfU2OBZkkcArFATwMF/1lTbSaW/A61ryqV?=
 =?us-ascii?Q?ghlAON9PM9L9QvQuhpZdrPdx+vLeORUrpCuu6A4zhUkuNeTjdiaEpiKkUpvB?=
 =?us-ascii?Q?LsZ+blUZm9wGTw/QjhLA2ZBZXHZDhneUTH+qY4z4zPbbgWadYIDd3MVm/R6M?=
 =?us-ascii?Q?ZqSJEVe2Fs+Jrk1FEX/vapz3+EG/7Kk6k+wkB6Scj599pKwEk4OkGzIIzvb+?=
 =?us-ascii?Q?qKbFxnGf31efkRSBcTyxO77ilcsuTVRcSE73D8rtlYlX/DXA04dRFU/fEpCj?=
 =?us-ascii?Q?BBe/l1Oi/eN7w22wUwXC8hN6jK9inhpnfwc7iK06dV80VC2YHXTwGjz2Vqe7?=
 =?us-ascii?Q?TBDI9ATWmtRwGkAXFTH9ahlCA9Mfr00zeXrI5N9s7+Hge6o8yr5u8KuuQ8Ij?=
 =?us-ascii?Q?bLg+Jc3KjbavB3Hj/SugJcoRF768yk4eZGRqdvX8Lqfs9lLvQaafFYZs4LK5?=
 =?us-ascii?Q?cEPxBR6XvKB2gKwM51IXfHzJrooZu6h0azOiSaeHZoAwAZULxlaz5fiO1zvr?=
 =?us-ascii?Q?wbF3juUpL1JkxmEehUWYB0i8qd+WP39VgMp/QQvijQUG6z6NB0o587E11G4Q?=
 =?us-ascii?Q?htaWNeP1e1WlKoR0rOLkKmc7S3iPB4t0x//y4zfpxdGaCHRdPXn6T6lLREH8?=
 =?us-ascii?Q?88Vk9VYO8/vOFdIz+0NkUsYKIO0oSKOc22Y0vEM7TKzJ8upzag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:45.0967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6909e38f-cf95-487c-0505-08dc8cbfad5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

This commit is example code on how to leverage mm's migrate offload support
for offloading batch page migration. The dcbm (DMA core batch migrator)
provides a generic interface using DMAEngine for end-to-end testing of
the batch page migration offload feature. This facilitates testing and
validation of the functionality.

Enable DCBM offload: echo 1 > /sys/kernel/dcbm/offloading
Disable DCBM offload: echo 0 > /sys/kernel/dcbm/offloading

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/Kconfig       |   2 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/dcbm/Kconfig  |   7 ++
 drivers/dma/dcbm/Makefile |   1 +
 drivers/dma/dcbm/dcbm.c   | 229 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+)
 create mode 100644 drivers/dma/dcbm/Kconfig
 create mode 100644 drivers/dma/dcbm/Makefile
 create mode 100644 drivers/dma/dcbm/dcbm.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e928f2ca0f1e..376bd13d46f8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -750,6 +750,8 @@ config XILINX_ZYNQMP_DPDMA
 # driver files
 source "drivers/dma/bestcomm/Kconfig"
 
+source "drivers/dma/dcbm/Kconfig"
+
 source "drivers/dma/mediatek/Kconfig"
 
 source "drivers/dma/ptdma/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e408..7d67fc29bce2 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
 obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
 obj-$(CONFIG_BCM_SBA_RAID) += bcm-sba-raid.o
+obj-$(CONFIG_DCBM_DMA) += dcbm/
 obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
 obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
diff --git a/drivers/dma/dcbm/Kconfig b/drivers/dma/dcbm/Kconfig
new file mode 100644
index 000000000000..e58eca03fb52
--- /dev/null
+++ b/drivers/dma/dcbm/Kconfig
@@ -0,0 +1,7 @@
+config DCBM_DMA
+	bool "DMA Core Batch Migrator"
+	depends on DMA_ENGINE
+	default n
+	help
+	  Interface driver for batch page migration offloading. Say Y
+	  if you want to try offloading with DMAEngine APIs.
diff --git a/drivers/dma/dcbm/Makefile b/drivers/dma/dcbm/Makefile
new file mode 100644
index 000000000000..56ba47cce0f1
--- /dev/null
+++ b/drivers/dma/dcbm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DCBM_DMA) += dcbm.o
diff --git a/drivers/dma/dcbm/dcbm.c b/drivers/dma/dcbm/dcbm.c
new file mode 100644
index 000000000000..dac87fa55327
--- /dev/null
+++ b/drivers/dma/dcbm/dcbm.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * DMA batch-offlading interface driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+/*
+ * This code exemplifies how to leverage mm layer's migration offload support
+ * for batch page offloading using DMA Engine APIs.
+ * Developers can use this template to write interface for custom hardware
+ * accelerators with specialized capabilities for batch page migration.
+ * This interface driver is end-to-end working and can be used for testing the
+ * patch series without special hardware given DMAEngine support is available.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/migrate.h>
+#include <linux/migrate_dma.h>
+#include <linux/printk.h>
+#include <linux/sysfs.h>
+
+static struct dma_chan *chan;
+static int is_dispatching;
+
+static void folios_copy_dma(struct list_head *dst_list, struct list_head *src_list);
+static bool can_migrate_dma(struct folio *dst, struct folio *src);
+
+static DEFINE_MUTEX(migratecfg_mutex);
+
+/* DMA Core Batch Migrator */
+struct migrator dmigrator = {
+	.name = "DCBM\0",
+	.migrate_dma = folios_copy_dma,
+	.can_migrate_dma = can_migrate_dma,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	int action;
+	dma_cap_mask_t mask;
+
+	ccode = kstrtoint(buf, 0, &action);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+
+	/*
+	 * action is 0: User wants to disable DMA offloading.
+	 * action is 1: User wants to enable DMA offloading.
+	 */
+	switch (action) {
+	case 0:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 1) {
+			stop_offloading();
+			dma_release_channel(chan);
+			is_dispatching = 0;
+		} else
+			pr_debug("migration offloading is already OFF\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	case 1:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 0) {
+			dma_cap_zero(mask);
+			dma_cap_set(DMA_MEMCPY, mask);
+			chan = dma_request_channel(mask, NULL, NULL);
+			if (!chan) {
+				chan = ERR_PTR(-ENODEV);
+				pr_err("Error requesting DMA channel\n");
+				mutex_unlock(&migratecfg_mutex);
+				return -ENODEV;
+			}
+			start_offloading(&dmigrator);
+			is_dispatching = 1;
+		} else
+			pr_debug("migration offloading is already ON\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	default:
+		pr_debug("input should be zero or one, parsed as %d\n", action);
+	}
+	return sizeof(action);
+}
+
+static ssize_t offloading_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", is_dispatching);
+}
+
+static bool can_migrate_dma(struct folio *dst, struct folio *src)
+{
+	if (folio_test_hugetlb(src) || folio_test_hugetlb(dst) ||
+			folio_has_private(src) || folio_has_private(dst) ||
+			(folio_nr_pages(src) != folio_nr_pages(dst)) ||
+			folio_nr_pages(src) != 1)
+		return false;
+	return true;
+}
+
+static void folios_copy_dma(struct list_head *dst_list,
+		struct list_head *src_list)
+{
+	int ret = 0;
+	struct folio *src, *dst;
+	struct dma_device *dev;
+	struct device *dma_dev;
+	static dma_cookie_t cookie;
+	struct dma_async_tx_descriptor *tx;
+	enum dma_status status;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK;
+	dma_addr_t srcdma_handle;
+	dma_addr_t dstdma_handle;
+
+
+	if (!chan) {
+		pr_err("error chan uninitialized\n");
+		goto fail;
+	}
+	dev = chan->device;
+	if (!dev) {
+		pr_err("error dev is NULL\n");
+		goto fail;
+	}
+	dma_dev = dmaengine_get_dma_device(chan);
+	if (!dma_dev) {
+		pr_err("error dma_dev is NULL\n");
+		goto fail;
+	}
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		srcdma_handle = dma_map_page(dma_dev, &src->page, 0, 4096, DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(dma_dev, srcdma_handle);
+		if (ret) {
+			pr_err("src mapping error\n");
+			goto fail1;
+		}
+		dstdma_handle = dma_map_page(dma_dev, &dst->page, 0, 4096, DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(dma_dev, dstdma_handle);
+		if (ret) {
+			pr_err("dst mapping error\n");
+			goto fail2;
+		}
+		tx = dev->device_prep_dma_memcpy(chan, dstdma_handle, srcdma_handle, 4096, flags);
+		if (!tx) {
+			ret = -EBUSY;
+			pr_err("prep_dma_error\n");
+			goto fail3;
+		}
+		cookie = tx->tx_submit(tx);
+		if (dma_submit_error(cookie)) {
+			ret = -EINVAL;
+			pr_err("dma_submit_error\n");
+			goto fail3;
+		}
+		status = dma_sync_wait(chan, cookie);
+		dmaengine_terminate_sync(chan);
+		if (status != DMA_COMPLETE) {
+			ret = -EINVAL;
+			pr_err("error while dma wait\n");
+			goto fail3;
+		}
+fail3:
+		dma_unmap_page(dma_dev, dstdma_handle, 4096, DMA_BIDIRECTIONAL);
+fail2:
+		dma_unmap_page(dma_dev, srcdma_handle, 4096, DMA_BIDIRECTIONAL);
+fail1:
+		if (ret)
+			folio_copy(dst, src);
+
+		dst = list_next_entry(dst, lru);
+	}
+fail:
+	folios_copy(dst_list, src_list);
+}
+
+static struct kobject *kobj_ref;
+static struct kobj_attribute offloading_attribute = __ATTR(offloading, 0664,
+		offloading_show, offloading_set);
+
+static int __init dma_module_init(void)
+{
+	int ret = 0;
+
+	kobj_ref = kobject_create_and_add("dcbm", kernel_kobj);
+	if (!kobj_ref)
+		return -ENOMEM;
+
+	ret = sysfs_create_file(kobj_ref, &offloading_attribute.attr);
+	if (ret)
+		goto out;
+
+	is_dispatching = 0;
+
+	return 0;
+out:
+	kobject_put(kobj_ref);
+	return ret;
+}
+
+static void __exit dma_module_exit(void)
+{
+	/* Stop the DMA offloading to unload the module */
+
+	//sysfs_remove_file(kobj, &offloading_show.attr);
+	kobject_put(kobj_ref);
+}
+
+module_init(dma_module_init);
+module_exit(dma_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shivank Garg");
+MODULE_DESCRIPTION("DCBM"); /* DMA Core Batch Migrator */
-- 
2.34.1


