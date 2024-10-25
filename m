Return-Path: <dmaengine+bounces-3569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0599AFF59
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85781F22B82
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1C1D90A2;
	Fri, 25 Oct 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SiroUPhm"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC61D4359
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850443; cv=fail; b=mwMiI/Wx4kdtJZx8djrub2K5HVHZFDeFz0voNobTUromiDXKVWO5rfPq6a5dsKfh69J9ga/u7PeDHkyMKqp6jGBf47bF3+w27LrRjqoQ4g2g3ajeGxqjohtrl22aL5b/DO1W9uPEn+yLwTTXsWHzLgLks8Lv256q16ompkp+Hz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850443; c=relaxed/simple;
	bh=PGMTrp3Rs1oRR3cltCPMp7ajS7ZBWoVCIb6jvnxoF4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oItaFjylpL6sFTQvxMtAVN6QoyZRQU4SPWzHnIQNo+bmVHKxiKtCRS4cXVPxq1oVStfEeacAG2M7VzwbeNM+X/LIyhtXNrdxLIYCy0M6oXYtG54qwiPUgkZJf+az+Vy2YJppZS89+9RHvy3i/BpCMsj8ljQkdmC6WM4AC3CzFi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SiroUPhm; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8kPQoiynW56wsYe3qbpE+3coSvBI71HBTPt9nrS6sBGO2BMniDqPkfxCEyE4xdq2NfT0O+uIevpXuVu+TDYfmKlZkw+M5maqQicioIa3wsZnjtIUPX9Rag7lcoJ7wnifWEnS9wPPizFikWvGfCDnjsalYfRvOShCbGgQ4aeTNnFRZh6i4YPoB95wsdaTwcG1FHsdRsDLTPF+fV4a8Mw/fifGr5q3cqXXAiSCSGS7GwprlShiksn/wfenr9Kha06kEOZTXSZhsfSTuSAqieLYbot9FOOQ+mKYaNQXTrvelgO3Rp+RPzIXITgie25oeqNiYFqQD2pRR3GZBHeF5NC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1CiifwjZ8RD0pQKnqrkoXfIy6IQTg8+RKlSq3gSqVw=;
 b=eQdbHqSkUlf5+5bYd2GyvBW5ANaMR9LtGOmrf8UlaRzRspqWZodPWYFe5rxFUwDcRJ74rJLM3Id7LefH5nyj3xNQjrZLj6WLaso3/1ZhReEtW/wiw5yPuYYBj7C8vMp+UpVOUFueO0FnS0llSM/z1IOCEdX0QvASGV/PBEPiwAyX/XENG9xpX6VqePK5dDeek9v60VG7pWk69OqArSTQusrVVyIhS6ISd5wiCsN1cDSpDSBJX8uyYVVn+JEXG6yyEAhAIHBJFLqFOSSZdHc1OGGzxk14VJQhC7JByj8YsF4S5yOruJ73S8hZicwndNUYI3eGACUUI10WbAzx7f4UuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1CiifwjZ8RD0pQKnqrkoXfIy6IQTg8+RKlSq3gSqVw=;
 b=SiroUPhmNY13pOrwgZlbFJ/0YaxaHdjiqJbyMh/vm4riJI8/emp5uju61lQzaOXgEU4TtgHqBjFyyTARVIfEW0y5A/hTmGNl88PH1o1Oqcc+GG+kpVdzUfqH4RNl6cFbesSpWuww6AdK/yg6fZJ1UENFj0HECY0STs9cJWsjdXE=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 10:00:38 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::6c) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:37 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:34 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 1/6] dmaengine: Move AMD PTDMA driver to amd directory
Date: Fri, 25 Oct 2024 15:29:26 +0530
Message-ID: <20241025095931.726018-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: c41898dc-e00e-4d01-6d24-08dcf4dbe073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOfdgw/lKLqevyv12pifC/AtOiX3cVGAgo5IAEV/OVQ63pQGahLJnO5XodfP?=
 =?us-ascii?Q?y7VTuPWl7rhEEKNyaoH7+lwxlAAj6b36zaLO79nRGjeCFWlawAIxfQqCwLX6?=
 =?us-ascii?Q?ZkoexyW8JSUtW6W/0qdW2QCt5DzBpgKGthwiJ48ix8pFy97ulGwfvc9y9A4E?=
 =?us-ascii?Q?/6hFSHGodM4fvqMMsElm4/JbJQ0knJScn906BFHiyhGKWzZUvXNza/vVhipi?=
 =?us-ascii?Q?VFuHEUmTOFKvLBGEloBBrePVreiMKLPTdfkHm2uoVMllieZoYW2biqrG+Nkh?=
 =?us-ascii?Q?xlMNCsLB8n9J/MRAy6scLRI4BK6qMccVLWIkmASDeNb7OJ8QAZZ3pdVeB5I2?=
 =?us-ascii?Q?sGX7UjMv4TkkSqUIq4UbyYCmtZ196vmeR84cxTA1THCdIAzadMLpTiHH+hgu?=
 =?us-ascii?Q?OhEkX+EmkyGAsOgI+t89fqGeg50p5psl0mDcZ6+hGq+sqPxsmhZukHfKfCKO?=
 =?us-ascii?Q?Eck+p2XKnxMTld5UgcxLeymhEked6Nm/K8tPX6jqe11HVZEcM/mgGpQPTvA2?=
 =?us-ascii?Q?05nKpfQYKgbAWqs/XVAVQL/QwoFOYBbJI2ZNqnh45n+XGs52EBxI16RJx66J?=
 =?us-ascii?Q?WVdoUqy9MuhwP1f0E3r7CkvtzVzhVhaqD/i/aipjHvbA4zw0S2JFZE1aEWSf?=
 =?us-ascii?Q?WdpyxRv8bAzysypJTL1I73XxAwPYoiQ9xTYnjrS2lrD9Tnpyu+NqrLRifqhP?=
 =?us-ascii?Q?vatD2wtZO0P77ABZuxlvIa7T02Gp751cJ6bsmA+bTzjhlclntSBeUB7koIbo?=
 =?us-ascii?Q?B8EQoZkdIyqyMwOY4jwmMO+LeDpkrJl+Syx1LnWJB5EokTekXujco/WF+JPJ?=
 =?us-ascii?Q?hR5qjCyQtL82LMktWS9oytyzrCR1b0r3MaX5pfrO5NfwthIs/DeiZ4jROV+F?=
 =?us-ascii?Q?kdPC66r5OYVli3CtO/uifeL4BPOcGhUo5yMrMhYauNRfBRyii4pnKYBKE/7g?=
 =?us-ascii?Q?D7DRVCHHFlmEHynbE1hA+IrckDVMSPbavXQRw6yUxELoAq3vthiyg4q0ew7s?=
 =?us-ascii?Q?uMWoyURglpNms4tDiCRwkykUDMbonyu5csumWCVOFDHCXP2OZQOtg9z7daXe?=
 =?us-ascii?Q?XrZ8wbq948lROhsybAHUlH1HV6EBAan1ABVL+CJJCKNLWh/lwDWEthEr4CYu?=
 =?us-ascii?Q?NpM4ifmW4iIv+jeZT0VAKGpRmD4O9lz8EdCcvTSeT3E1PjpFNqYS6jrUxHrw?=
 =?us-ascii?Q?FCrbe0oCvAyD3kcxEKrQJbQKDl0O841N9zyh63tlpXUwQzvsFSe7n63/7MaK?=
 =?us-ascii?Q?fbQ51mZz2RAPCAhYgJQeldnoAOg7CL9aN8PCc06pI+sEJjisvV3TVLBA0je8?=
 =?us-ascii?Q?33DEkkBEg626ZYiJjr+bdTegoRt37svxj4fZnJaYKwkZ0RLzd0sG+gyjNMHK?=
 =?us-ascii?Q?4YQ4sJG7H0XqbIQsXldCqwtEC2LRe5EDlCjWAIBlA5yxBSuHRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:37.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41898dc-e00e-4d01-6d24-08dcf4dbe073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

PTDMA driver is the AMD DMA driver, and newer AMD platforms support newer
DMA engines. Hence, move the current drivers to the AMD directory. This
would also mean that future driver submissions to the AMD DMA driver will
also land in the AMD-specific directory.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                                   |  4 ++--
 drivers/dma/Kconfig                           |  2 --
 drivers/dma/Makefile                          |  1 -
 drivers/dma/amd/Kconfig                       | 13 +++++++++++++
 drivers/dma/amd/Makefile                      |  1 +
 drivers/dma/{ => amd}/ptdma/Makefile          |  0
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  0
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |  0
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c |  3 +--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |  0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |  2 +-
 drivers/dma/ptdma/Kconfig                     | 13 -------------
 12 files changed, 18 insertions(+), 21 deletions(-)
 rename drivers/dma/{ => amd}/ptdma/Makefile (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (99%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (99%)
 delete mode 100644 drivers/dma/ptdma/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 6880a8fac74c..1d9f5a5c471f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1149,8 +1149,8 @@ F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 AMD PTDMA DRIVER
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
-S:	Maintained
-F:	drivers/dma/ptdma/
+S:	Supported
+F:	drivers/dma/amd/ptdma/
 
 AMD QDMA DRIVER
 M:	Nishad Saraf <nishads@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d9ec1e69e428..7852f8f78567 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -740,8 +740,6 @@ source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
 
-source "drivers/dma/ptdma/Kconfig"
-
 source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index ad6a03c052ec..a0bcfeef0e7e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_DMATEST) += dmatest.o
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
-obj-$(CONFIG_AMD_PTDMA) += ptdma/
 obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
index 7d1f51d69675..a09517d51449 100644
--- a/drivers/dma/amd/Kconfig
+++ b/drivers/dma/amd/Kconfig
@@ -1,4 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
+config AMD_PTDMA
+	tristate  "AMD PassThru DMA Engine"
+	depends on X86_64 && PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for the AMD PTDMA controller. This controller
+	  provides DMA capabilities to perform high bandwidth memory to
+	  memory and IO copy operations. It performs DMA transfer through
+	  queue-based descriptor management. This DMA controller is intended
+	  to be used with AMD Non-Transparent Bridge devices and not for
+	  general purpose peripheral DMA.
 
 config AMD_QDMA
 	tristate "AMD Queue-based DMA"
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
index 37212be9364f..fb12f2f9e7b7 100644
--- a/drivers/dma/amd/Makefile
+++ b/drivers/dma/amd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_AMD_PTDMA) += ptdma/
 obj-$(CONFIG_AMD_QDMA) += qdma/
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
index 39bc37268235..7a8ca8e239e0 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -22,7 +22,7 @@
 #include <linux/wait.h>
 #include <linux/dmapool.h>
 
-#include "../virt-dma.h"
+#include "../../virt-dma.h"
 
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
deleted file mode 100644
index b430edd709f9..000000000000
--- a/drivers/dma/ptdma/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config AMD_PTDMA
-	tristate  "AMD PassThru DMA Engine"
-	depends on X86_64 && PCI
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  Enable support for the AMD PTDMA controller. This controller
-	  provides DMA capabilities to perform high bandwidth memory to
-	  memory and IO copy operations. It performs DMA transfer through
-	  queue-based descriptor management. This DMA controller is intended
-	  to be used with AMD Non-Transparent Bridge devices and not for
-	  general purpose peripheral DMA.
-- 
2.25.1


