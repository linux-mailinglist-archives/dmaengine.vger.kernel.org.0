Return-Path: <dmaengine+bounces-2651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2232492A4FB
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972611F21B6A
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA213E3FD;
	Mon,  8 Jul 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQwrQbeG"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86E15A5
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449930; cv=fail; b=hhncpaMiI0Ow/bTBPujLrPLrb85NAjiqPEMXDt7XHtUdOH3EVHISYAIqKyo9Ca52ORDhICH8xebp1ftapPYawXeThCo3Di+6nbeswdixg4P1AWjopMBl8hFBPFXYpKtMn5Z4VvJiuRSks0oawvwiU16xbKaPd+b7WYdmGBly8Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449930; c=relaxed/simple;
	bh=fwRddPg505G3YDdAa0GEwhgVH59sJl2GqzEqdl3sP8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twtsnRfihAqQjEU+VZxXrN0PtT35JMb8QaxIHuGKuGii+JLGzumzxvrkfQPdsEdDIthC9PQ6tMu36AICVEOvMi53dbC8UW6zfs8rAFBrhABvBRUQGjGKhMqE5D+Pnl4WLzl9TfRbu5sbK/lij7NKbWfsmDmh7wCsHaVCQiyaNVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQwrQbeG; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPu/TN7D/HxxgqaYCgqNasb/wb1UgE2K1XssTwQGmVeN9V7woz2GMb0PfZ9HQUJ2la9vvn3AGnd1MbnKVMghI0bu92D44H7O1zgDnGYIXfVoVv0jMyVZ9ThXktlxZvSj6VWQXtS23hotkJoPVIwBFhkVecadQ1vkBAewjz90xJEpg7sPKhzBmPrAMbnbpmLOREQltmUYp9TvSYeHZssEMh2upkx+s/mtuEPnp6iQZVK1evnRtXLPEvlWax/jMqKqFj/xTQSMlZZsCZk4e/UdKp40rHgXkTXPP8VAq2WxxAV9mR2LJI6dvVOXPY8g5URdTp333624R1d42ewVDZba3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzD2wiAwElfAXESdCMCnYjQZGU/3uP0KPVrOyeE0Mnc=;
 b=Nph4R1AeYPjhSu8hcvNOHuGULrhvaJJdnHJpETLJd0UWYltPosoMga3QupnCpO65VcLx/4+Hz2lM1WEA5YRjdE3mLFa5gyqncq5sThuY0yTPmUZ6IIMpReTD+hU9qSIj3bTZVoxBBM2JSOacxGfB2g9eBbECPngbVkuUGhfr5LxN7y1Z++MW0TSemXPmOATKjrDkBB1KesQrFq94qoRifkFdaU42Sl54ULzPucEDuvo8ttMdVvYN2V7jUcIj5VzPNobWFSz+shC76FxYlU9t4MKtgGMc+NwaKnyHhKeYezBK+WZi0cPLL33vGsh3gX9r81YJoNkhWWdapRs0NpNmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzD2wiAwElfAXESdCMCnYjQZGU/3uP0KPVrOyeE0Mnc=;
 b=RQwrQbeG2L0iqfdEFikoSHBAlPYNpkTjc4larTHX0MViciDYfcp260Ux3z9hjr60+lzeNRPbztUA+/TI5B1Ng1VihCYL3gva5wbAGLdchugO88blJ3J8UBmwjAF1gCXO/Ppo4spAEUIGUNHobxGXdHJ0iL6/Gm2eOIX7UeOSVNI=
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 14:45:23 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::d6) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:22 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:18 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 1/7] dmaengine: Move AMD DMA driver to separate directory
Date: Mon, 8 Jul 2024 20:14:54 +0530
Message-ID: <20240708144500.1523651-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dfa9f0-a920-4ddf-a330-08dc9f5c98f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uxj2uuCAUZNEmCJUdzfTLa9ql9pNnnPmP0vNCztiZ2TQYWQqvko7rNb9nNfA?=
 =?us-ascii?Q?gYIeL/4J6Q5ArbADPKGA/OjH7Bo+CCh9T9FiWWsYPEZLF/plO1IeigtETY7a?=
 =?us-ascii?Q?QpixPbirn0pYtLr8YjGd34NiNxPSB1KcM6XEI9bYzFC9Pxwp4tD3JMty8qsO?=
 =?us-ascii?Q?wMi6sVSYfQ4okq/ODmw3Z5RJZE9k2vV0t23iYhOddsXBfPnPdhBE6sGumkh4?=
 =?us-ascii?Q?mOYYYss58kj3gXNF7xI4j6kAdcCdaRQiNcMC9P4yzuRm8XAJxC8tfL8mPrXY?=
 =?us-ascii?Q?e49bXYmYc+mwegQ9v9wwhItUmSyzkRWi3kEjBb2lX5E+unvY8fDUYBZyLCAA?=
 =?us-ascii?Q?c/70qi8n6BtABqUP82SebIkilEPdbltxMSwGKouYSTlQ4Md238mln6SRS9Hr?=
 =?us-ascii?Q?WXaSFlaoVCO02qthaMBg1pcRmy92RZLsZ+FrhFCTCOybsav+8ijCiO67AeY5?=
 =?us-ascii?Q?NkWpuaDG1NQW+B209gzKAhvxu3ibK7bqKUUqEp5Vp8G/XI5VoDiYtRBy+401?=
 =?us-ascii?Q?2OajexN8TkOY0KqpeeoARt/fpvsRVW9rvYaQcws8k+43jZQBWz4y9cyjIzSE?=
 =?us-ascii?Q?gro5qxbEnZ1INLpiy0M/aSdP29q8/bhQZ8bTdWYa82pvfC+4ZarqMssap12v?=
 =?us-ascii?Q?fDw4Elk5AhCDXPcyxR5Skb6W40+gYq0Z+h/uaclN/311SxFwIU7aHDYq+N7F?=
 =?us-ascii?Q?xAY6jO41Q8KDmFQ5Q8hGncqq+JCEGme4Oc8KaATGecdnJq09KnXv2nH3Jmhz?=
 =?us-ascii?Q?/U2LMi9c4ayRBqPnsGhYjkPDffubPaxS/tKkm6femU9SGCLiJzL1nYniHDj2?=
 =?us-ascii?Q?i0OEGJh+lTkeZyZSPGq3Jel89/UgorHcTG1KowFtgP85d1DCf4gAxltqOWEa?=
 =?us-ascii?Q?mWcMUUjeQP+GvZB9WcnXu1uuQfWVETYON2repnKH1LSq9BLBjsSeT9z/oeVU?=
 =?us-ascii?Q?oH6DHLEq0duCBMvzDpZ3cSpaN+mS2e6BO/sHvSW/cyiBTWzG+yjI5xj4Nyc3?=
 =?us-ascii?Q?/sd1dGe31wBPUI0f3WmwqlOZc8ksBJZtgs2TMyr+QKoQ0SgscsmuCZ6WqsGI?=
 =?us-ascii?Q?JXRdgUwVLdRftBBirEsUmXYYWBUZbiQexvPJoJzTp+xFD28IsgfyW0k84B6A?=
 =?us-ascii?Q?WHF1TaV+Puz+kmqbe3RdvBafg0LmjkzKYNnJyEVdKci/k590ChPKIZO2hsye?=
 =?us-ascii?Q?pYabJVWvZt2x0zkpqZ+bNSUIm97Q0eF6lPE4lAXk8skdoSrNLWuTsvXNVmqo?=
 =?us-ascii?Q?z8hPcLWoYZRlCFaMADcOq6W4It3yW/jnO+Sf0U1I3V0fly9gU0Hf9zhj6Vka?=
 =?us-ascii?Q?LuQRpp6XgPM+sgn13J0TisxGsaxOMop+H+nn7DyAVIl+qUKXk3dnbSccX5CI?=
 =?us-ascii?Q?rjpPeChpWNyYbJc2LhA3xTkFm9fNHcgHl9pfzsA/u8Sfpm2P2GEjKEPkWKg8?=
 =?us-ascii?Q?BOfx/GyQlxQ1OYQrJrFK6PwmXVU03t3s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:22.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dfa9f0-a920-4ddf-a330-08dc9f5c98f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

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
index da5352dbd4f3..33a1049fd38b 100644
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


