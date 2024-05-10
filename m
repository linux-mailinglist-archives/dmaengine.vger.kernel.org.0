Return-Path: <dmaengine+bounces-2014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E68C1F9A
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C56283048
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E061FA4;
	Fri, 10 May 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svdLIMbU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427D14901F
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329295; cv=fail; b=j9+JcDmm5SxLa8PWaULogJTVAWoVv/za51BK2wUwvEgYbeAuZh7/ZIaKuPhxJksnnarkWdcpwSeQl3x7uPWJs1jx3Qt+gOnHQvkANCYKb4ohk2TWV5gdypR38x/byZJVyQgHV+Ec9I4tTblfnD3HzgU6/TOl+5c/X0Kq5LN+sBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329295; c=relaxed/simple;
	bh=dLwWywugYOu6loPPj63TVuFV+fEAc9pfpQ4CWkW3E9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbkAMM3vQUw7Ha2GWSAaBV7zlYASUy25z1LBs0PEGaT3L1wj3VD6LRMeDWgTb1QNIJUMs0qaNzSjbhSw9SGLNq54dqZlAJH32hGNMaR5MoxEwptjfNI5J5Of0Bk4WFF1JPmMljuU9CvzRjgWecJ9QwbfHlTlUQ3FiraFdFoOnvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svdLIMbU; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7FSz4aMyftKN+rUEQhgwbX6+LZ3gsb6BhD1dPfBeYblP68OjQKBKuDYl8YGANh+2D/L539eixrgzAb30DjrFgsKCt4nwRxtpzSS+ZvAhG3w+9C8ItsXXknv3/IGBRPBhWrMo98hhKHz97IhxLJ9em8+r8ajlyPXXAYiaG/U+hadjRFMuTLXX0R5tRQ0u16k+FjGLzdeppVQduushmxz1rN4ySDlfG1BqITqynyF8r81DtZE5x9ewfjkGOFA243MwH7WivIzArSAoor5jEbGsmVZ1LYNIjVHHFRTK0uObZosDjnQWqEBFUso21+Kaev4dPiKCJdzJDGmhrBPKEfCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqnGeLXFm6C5wXDym4WGwEdQGuIrzUJfoIMmcim7Suw=;
 b=n6Eo/FE2Y6DiQSFmp9w1LLCO4LMuH9yZc/YR8C4dqYBJc+niasAqico2EikBL++0Xi+BJdvrEoxmlLKAYr+w4eCrCueSUCSS9QkmLZJbv805wzJSSnZkO3e+3EeB54vKT0qR21XFku5jJnP8B5WwZHbHwBcJpBjJKx288ZHRjsSyWQxJ4xpcmjwTxBMVrRfKZxsCI7koy2iGhIUloALtsMp4rJ5vBWNe/pAYw7PnZXzzJ5WMDasMv6vYvXehpF/CYWJe5E9AG/N804zKcYOct+qhGGf+TLy2wBKaq7rbl81tMHs0CvHYwlMNHimN8YwcyhJcSH+eQrKsusoOXrIOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqnGeLXFm6C5wXDym4WGwEdQGuIrzUJfoIMmcim7Suw=;
 b=svdLIMbUAz2qLvaXAGyPVIprlcTOC2am23/rj0JU7uEGXDRlPNSKN2Ow/Ks2UvQZWBpSXSVNy5vHHFq8bA3OuVO01CcpleNcoS7bvgyjYPMATcS+sRS6TKnT3O+2JsFu5s57PNt1mnUHVT2UlsCCOYsffiResbqiNI9v+rU+OII=
Received: from CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19) by
 MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 08:21:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::6f) by CH2PR05CA0006.outlook.office365.com
 (2603:10b6:610::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.14 via Frontend
 Transport; Fri, 10 May 2024 08:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:30 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:27 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/7] dmaengine: Move AMD DMA driver to separate directory
Date: Fri, 10 May 2024 13:50:47 +0530
Message-ID: <20240510082053.875923-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 938a4862-5110-44fe-2739-08dc70ca321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1Nie1NK85dRIVjFnoIrwlmoxez0ewn0AQ+aWAJQkWK2ZRbrL/XyEnmLqwmc?=
 =?us-ascii?Q?EgQyv3R9K83N1THQvMzwOdT/NTS3s24im/i7x7CoK4IJFQmbOumEQIbTa0Ng?=
 =?us-ascii?Q?0ZqDSjTcysZRpPvqmvvQrgpI+jcBuW4ZFwmfMneiRptEp6+pYSSKzLLnzRgl?=
 =?us-ascii?Q?JoyQJPGZqmlZPZSTdZlqjbz5VDIQhech3m5rZQYihVGuyhw60HDHoG0HRktD?=
 =?us-ascii?Q?gCMmGIV3HUkteFmXbWSHIGwB9T/rhbrkPRsAhB3NNQvYuzsXYmqwnGXzSxLe?=
 =?us-ascii?Q?NXYZ6UUnzhfSCcrn2gJ2pYJhKVK1eUUthrHfSsrnChL2V1gYUYMUJBi0jvhq?=
 =?us-ascii?Q?BFlORokUoFPJKrt6/qB4UIFVH0b3/YI9oZhEtf5auZdha6xspMhEtTOpLI26?=
 =?us-ascii?Q?JPFQbP05kkQLjn0L+OVteed6S0JJqKb7IATW30ybVARjPivVAYDuqHfMakPo?=
 =?us-ascii?Q?kmpCElBGGV3ADC3BzhrEigKNworC0L7j2wMxUcABLJ5jIFg+lKPL5AixN3KR?=
 =?us-ascii?Q?1pJmjWqS3oMTa3WM5IvNTm9aWGd9h0i1ChqbTVG/R1sCDclnbr/u/O3LI0ND?=
 =?us-ascii?Q?OOKQpCXUi5Q0FP5kmdDU5xmP/BpKuSGQR9AmtNfetX+wG7zykFp06tUh3Wha?=
 =?us-ascii?Q?SvTkxCmA5O8LrCslN1/o0O4u5U9N/BA4/SSYjYlvYVQyRWZL229FsQO10Wf7?=
 =?us-ascii?Q?i05Tkox013TWD5J/sFa0t9vWqi4d4JsVYVdbVEUepGwtrt8ogeaqy4Ku6458?=
 =?us-ascii?Q?gxBJ8aXFbP3Qqso4qg5IPBJRfNRcJdFfiY7Z/PN/OilQJz4qUdxJotZNxi2a?=
 =?us-ascii?Q?/YXBIiKpNm99PqJ5nCPkLcLGPdAuQTA+bbenFyxwy4bbnYo9fgzz9XWAKrWr?=
 =?us-ascii?Q?Uj743gpsB/RbaFN/wUZkzTgY8/ZYw+lc57BQAQwyqdIzk3H9uG9lbSl2zJ6r?=
 =?us-ascii?Q?yKKVsPxCNLAcOIcbQsjoljOKgaLkm27jG2qsNUkSTOryfjDpfiaRo5UFPafH?=
 =?us-ascii?Q?OHLH99LX60s3l/JY7A019V0T0OPW8Epju2wQRqBd5Din3/I6FFE/PNCqZz4T?=
 =?us-ascii?Q?g4bdTbIOu7EgEM1ZdltjTxIDTN4eiK6srN1dCck+17GBl5mRs+xo9X0nC9pG?=
 =?us-ascii?Q?zim6xFxOHzSaSJzIu08TkKTE9kUTmBru7n9ZhdIADDBdXLGiM+pTnVoprtGj?=
 =?us-ascii?Q?k0dYDy7pORypoHWuGn9TzxSSX2suGmEXJIIiH02/JNv2QWs8Q5PODFGQ18vT?=
 =?us-ascii?Q?902jPthI6hwXh+P1qvhUQOH2TcK1mJwj67MFCGaJsnoSoPeLY6+JJ752Qjq/?=
 =?us-ascii?Q?ztfz42hfCJa8ICGk2WwpH/7eqxbyavjJHVUQCjIwuEuAHtL5VNm9S1waRGtQ?=
 =?us-ascii?Q?DXuUQ/Fe9b0EGzW/okTt6drVFm8h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:30.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938a4862-5110-44fe-2739-08dc70ca321a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

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
index 05720fcc95cb..b190efda33ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1073,7 +1073,7 @@ AMD PTDMA DRIVER
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-F:	drivers/dma/ptdma/
+F:	drivers/dma/amd/ptdma/
 
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..ac6e9d3828b7 100644
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
index dfd40d14e408..41239304d21d 100644
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


