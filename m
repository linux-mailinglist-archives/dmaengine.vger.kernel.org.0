Return-Path: <dmaengine+bounces-2607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787791E599
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24C21F22BEB
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C916E883;
	Mon,  1 Jul 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lkTQ6bNc"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800016DC35
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852182; cv=fail; b=EDU8Dmqp2ACEH8RtdGdl+Ke3cKkPd4MwzObk9C7jfi4AAP2qoS341lPref93/8HolxWsM8EysP/bhYFhRGOCXpL0T7N2C6dM68uJeBRBv3IdGRgLqVnh77/6433CCupA/bNPVfxA5zEt0b0CLSEoIG2AeUDUL05OeNz+sZ5SKqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852182; c=relaxed/simple;
	bh=5025hjnXenPw7l2P2fk/phiAiOvx1EEWjkpH4kPaoZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upST0QfmLrihzJ4j4bYimcf8vSYtPiuK6hIxH9GfgVjzcRlsYkpjUfhAllljEei/h4OJAtpqyjeu09PmEiU1kEZ1lkEImdzZyRv4KvODOguBMBICwt/B45EHLxLVLdo8dcPi+WZlZS/HQklhjPcfCWWi4i82bxRo5uNUed9SHb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lkTQ6bNc; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKuXXWJmvxIXyEqQiaMypa0xqgmQzrPymq5Rq7LoYANg/DXrBPDxiwv1i53Uf6NtUi9DNeLZbVnWixP/GyK1zXfocsqtJSLBIitHY8aQLcUtmtOBukpf8Cen0zMSMMpZfTzsP7+OBULj1qFvqPH6a5ButH9pWzybKkJafhi57e72SDWjNQAKijCZ9e9qbsMmsichVG7qvG0sMfY80eVUBD7bhFmhIi591NAr/LSL6Y2Qip2LPnLmOLRYExItyKDjPbTknHpS/twtTaVeZWYwkJhMPtufxKaIlpTOsANK2RDbXgSZlzYDr70nJ5a6ebsJ5RJ5afaBhf4pfd95SHAjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOUE3h+2rIK5NUQFW8GSRGnqVITrHEKzR776mRW7q4s=;
 b=WLcXpZFYhcCPZs5FcFp1nob5aHmRnFwB2VJ7raTnyRQs4lwOQBu3YZF5GHQINDDplESOEGwexqfKLUNjV3p6jOSLfWqkltPVIPGBqkIyXxf36a+HjoLutBibS6HEEK7QWEIF7JuPRvV9ANQZ9XTVyv0VrvRY8paUMxFC9HNiSlm6qBDaq+3vtqLhWBRuG3SZ6yj2HAfiWAc7SkYTwQjLH2+W/acD0lq2bwrLpxGMz9Q3eHhqIDDBVS0agEfpPBX/Z1pi+jb8UJnKvuE63eNtbVMaTJAJLS3+pPj9qSvkJRhwlaj9tVU0qz8fjNMKv93cKINFUsv2vvuWBRJ+BBztcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOUE3h+2rIK5NUQFW8GSRGnqVITrHEKzR776mRW7q4s=;
 b=lkTQ6bNcxXv38pnSqh2BzpJLQphlhppANjUlFgsq0p40qF0qNiEUOKfQ3RxtNsNkGwc/dxISHo2Y6JvixRWQDMaf0w/qPZd6gZjogTDjN7VgcRXPJyHEQfhUcBu6h55Z7GtI8tucffI89ch3CB9pVYmI9Nt1FgbIz3+3MxRKXY8=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:42:57 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::d9) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 16:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:42:57 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:42:54 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 1/7] dmaengine: Move AMD DMA driver to separate directory
Date: Mon, 1 Jul 2024 22:12:27 +0530
Message-ID: <20240701164233.2563221-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed600bc-f178-4dd2-944e-08dc99ecdcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdNPoCbpXu45VX6HUBKsyIulzoBXLWDSyPg1SjgrI8poW7cKCtrTbQ8V+G33?=
 =?us-ascii?Q?KpNV09C47PV5kadwBCenJXQ9oA04G73/v8qMvTSPW5IwB7Z56ILIMdPKROS7?=
 =?us-ascii?Q?DOWq9TNUKbs/w5j/LeoCufZhi/lQYW2YXXLT1XofgFQj17tdpkTGGXv/KBIs?=
 =?us-ascii?Q?SnYA+5iCpxqqK30nD9jfRnF5+w5XXOhC+5cNQeIYIIeFzKrr6d7iWwscCsqz?=
 =?us-ascii?Q?W/xd9P8JSR+LIJmNgf+4mrcBoafQVDWv/mW9IIRhflhWppZM2AktrU3vngqY?=
 =?us-ascii?Q?J/O7W5w7vsjexy71NsApWQLNZ3GyFMBbtF9EuU2O8qZixGESXq/wAMj40rb3?=
 =?us-ascii?Q?usnDK0Z50I77Y3AtOWpd/t4hhORYNaeSzRIhuyN/tha+1/OwoVkCvyFmhCDQ?=
 =?us-ascii?Q?wcsVe6KJk9dOnARDgk6onxR4qzue4w7q3tza2O0QBSDob2T3vY2YXk+jl7bE?=
 =?us-ascii?Q?IXwPrTJHlKDUvAA/NqOHhAqzlqImITBgkv59IlCg2xhs6sHMVGfbXRfPEbVu?=
 =?us-ascii?Q?SvH21RcYwgW7zmt9gMyiZAMrvDr3lPBrKZG8iB/yoNSoRsI50QZuRPwFx6hN?=
 =?us-ascii?Q?fIKSYD6StHjR9x3O+z9566rByopbYP4Um7iXs2Uxo/D29ByZ8/SGzqRwssqF?=
 =?us-ascii?Q?ZYughBhzGYM9yFujW/rj5hFmQio/cXfzMJuOEouJW4v9vOa7ebD/MemMPKSd?=
 =?us-ascii?Q?S/3tONLAAamqmYTN0k/shqYAe+DIbWcLhyh+KkzSnlWzhSNFYHakfqZvOHZ+?=
 =?us-ascii?Q?Zwc8FDQ1jDO8WhfLKsjFNnjk5bgF0CtRsLaoeDwALPk+i5rASFe7Ri27lnvY?=
 =?us-ascii?Q?e/8+OtY0GKiHXg8WqRv3T4OFa1L7ykc5nSdeBGMUZ68mpt2mCfUkQuhLtgAL?=
 =?us-ascii?Q?2aI3rPcZVkbaZXWPij6nTrn5yFwikb2C82OopcFxDlQGFXublH6okaXT20V4?=
 =?us-ascii?Q?oMAr781MiYqFHnlx6rvrrE6N/5EiHZTvI1jvpsqlfEWH4lh9wI1KNUZfZbTK?=
 =?us-ascii?Q?6SLhTvGLuiAD6AJ37looaLBL2pCUubWGWWQv/oef//VRrEfnJjGmKi3Uvl8V?=
 =?us-ascii?Q?+N5Fquud9QxFqFi9Rf/ji4dYWXjmSqh1TR6OYz7zGet/QNnHimhmoCCIndux?=
 =?us-ascii?Q?Q8s81iZoWF9/tFXfYtzaZogS68h58jICC9gAaAK+VIukC8T6oK6QpLFQ0vKS?=
 =?us-ascii?Q?n6k1Wi5dBk25L22sn9MOaIhKl+MxEdLmw7OpPpDmZxt5fB3GoRqTRaL74iqb?=
 =?us-ascii?Q?LsKk4sA+ZUGYgyYwvBnCywv/YTXy7OWUbijEgTfRZ7hLQc4tYldUQF+n1aiE?=
 =?us-ascii?Q?NtaN5bnSVDtlWcOIQkPEvrcs570HR+fjV8hSwuNWkdAS40Vsyup5oqUBQ8pH?=
 =?us-ascii?Q?AAWxVH44o7ErEk0CGszVavPItgvUOOlbR5/UvouDOa4UL4UJ4l+hsEb+u3WV?=
 =?us-ascii?Q?js2VHN0hUFuRKtdYpcHN7WEVJt/X47Y2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:42:57.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed600bc-f178-4dd2-944e-08dc99ecdcea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

Currently, AMD PTDMA driver is single DMA driver supported and newer AMD
platforms supports newer DMA engine. Hence move the current drivers to
separate directory. This would also mean the newer driver submissions to
AMD DMA driver in the future will also land in AMD specific directory.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                                   | 2 +-
 drivers/dma/Kconfig                           | 4 ++--
 drivers/dma/Makefile                          | 2 +-
 drivers/dma/amd/Kconfig                       | 5 +++++
 drivers/dma/amd/Makefile                      | 6 ++++++
 drivers/dma/{ => amd}/ptdma/Kconfig           | 0
 drivers/dma/{ => amd}/ptdma/Makefile          | 0
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   | 0
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       | 0
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 3 +--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       | 0
 drivers/dma/{ => amd}/ptdma/ptdma.h           | 2 +-
 12 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 rename drivers/dma/{ => amd}/ptdma/Kconfig (100%)
 rename drivers/dma/{ => amd}/ptdma/Makefile (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (99%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9..c00558c0150d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1113,7 +1113,7 @@ AMD PTDMA DRIVER
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-F:	drivers/dma/ptdma/
+F:	drivers/dma/amd/ptdma/
 
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 9fc99cfbef08..e4e424ebdac4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -752,8 +752,6 @@ source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
 
-source "drivers/dma/ptdma/Kconfig"
-
 source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
@@ -772,6 +770,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/amd/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 802ca916f05f..c59948a0dc7c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
-obj-$(CONFIG_AMD_PTDMA) += ptdma/
+obj-y += amd/
 obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
new file mode 100644
index 000000000000..8246b463bcf7
--- /dev/null
+++ b/drivers/dma/amd/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD DMA Drivers
+
+source "drivers/dma/amd/ptdma/Kconfig"
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
new file mode 100644
index 000000000000..dd7257ba7e06
--- /dev/null
+++ b/drivers/dma/amd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD DMA drivers
+#
+
+obj-$(CONFIG_AMD_PTDMA) += ptdma/
diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/amd/ptdma/Kconfig
similarity index 100%
rename from drivers/dma/ptdma/Kconfig
rename to drivers/dma/amd/ptdma/Kconfig
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/amd/ptdma/Makefile
similarity index 100%
rename from drivers/dma/ptdma/Makefile
rename to drivers/dma/amd/ptdma/Makefile
diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
similarity index 100%
rename from drivers/dma/ptdma/ptdma-debugfs.c
rename to drivers/dma/amd/ptdma/ptdma-debugfs.c
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/amd/ptdma/ptdma-dev.c
similarity index 100%
rename from drivers/dma/ptdma/ptdma-dev.c
rename to drivers/dma/amd/ptdma/ptdma-dev.c
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
similarity index 99%
rename from drivers/dma/ptdma/ptdma-dmaengine.c
rename to drivers/dma/amd/ptdma/ptdma-dmaengine.c
index f79240734807..a2e7c2cec15e 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -10,8 +10,7 @@
  */
 
 #include "ptdma.h"
-#include "../dmaengine.h"
-#include "../virt-dma.h"
+#include "../../dmaengine.h"
 
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
 {
diff --git a/drivers/dma/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
similarity index 100%
rename from drivers/dma/ptdma/ptdma-pci.c
rename to drivers/dma/amd/ptdma/ptdma-pci.c
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
similarity index 99%
rename from drivers/dma/ptdma/ptdma.h
rename to drivers/dma/amd/ptdma/ptdma.h
index 21b4bf895200..2690a32fc7cb 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -22,7 +22,7 @@
 #include <linux/wait.h>
 #include <linux/dmapool.h>
 
-#include "../virt-dma.h"
+#include "../../virt-dma.h"
 
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
-- 
2.25.1


