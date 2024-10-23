Return-Path: <dmaengine+bounces-3435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78489ACA19
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64360282C50
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B551AB539;
	Wed, 23 Oct 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d4QG7yEH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0141AB51E
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687007; cv=fail; b=a+P0/jq6sEVKlHBz5KfJdceIYbHciLquyxEgOVKLCTDYH3ivYcHw9SUVKV8GHUrbzxQ88XIZKc5EYCH3X0/+t13c2iMsVmxAT5U2vFlD2s98T+S+fj7GUA8e50nEH27kXUWsSElsVzb/Q+VbI0ECsi7jjGWjTCUSQ9tU8vcdR3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687007; c=relaxed/simple;
	bh=kWEwdzJeH1wk2ANuIufgv8OS3wh6K+0+7qb2CoX79TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpPJEyEKL27TgBn5297yXR/Din7Uk14CiJ0wZaYgUus2wzTVmo1yT66hLs7L66vYcKHQwiaXqrH8NZLtFK5rZt7SogFVCf6d/on3Z/DKmH8szNGWx426inkOqGQZ1LXF6mTSFRoaqwtWr+r6WRoW0abTcohmW8ZG95/+RS4tsp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d4QG7yEH; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUTyMsacEujaHiEdTRSbv37VoQIrh1q5vOms6ldzt0Re05py8j279pfv8LzxV90Kmsuq3iOEgPL8bqppixaF78bPHwLPatV11OfOAFrnx5CiDYq5EFC8WbKyPB53PM60ldOQWjUCd6HJvSaSc30SOkGQkVwaRtYDiGGW9qvieiZVPC9+c3bqagU5QRtWfh+G2bKjHUgjCsvGMyLX1QPgK0fomqMEXrgyDAsMNEwkU0/rsKm1ZqP1lnyAyYTCnal16lmo2feyjD7BJPJRZe/jIR3jOfWl2FhW7kFDcNv1b9iE7hkGTq134j1CnGHs2Z8WVuCgvAa006cCRNbsXMoxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qdtB88kGmaHVjsUfegPd7uWKYgpQrETd0sB+no3qO4=;
 b=yjCipffta6kwN1gWR1TRsXOhJzIF2QmHpIH+b+VHBnLvbevDajtGQhuycEealO7X4L933SN2DxVIVjdyej9jMGOVNmXjBieu/4a6Q5DNumnRuhUSZXLhvv03EyNYAuyKmaEta+c3PeoUlrh2RfNTBI7Ja4KP8Kq6qna0/e6pEDTv8ycSuJswO+yRC1Ifh5IKZhLRiYQYBWCU00wgCvFk7AgGkQXdFkWWAs/v3d7Nb86I8DEtVOMdx1EfoUxqAQOClJjoloDQgxAzIxW+9Tt3X1yv5c0c/4/df1DSvNFTf52ykq5b8wr9zodAdHOymEv1oeNNT52wwOOVyZslORB2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qdtB88kGmaHVjsUfegPd7uWKYgpQrETd0sB+no3qO4=;
 b=d4QG7yEHjb22Pudfo3LZQDi+8rNgZDp3HnDjQx+mAWhpRr2gxXOjECj+smtsv26n71ugSAelgpgqhsKpA97RbkMsW+jKgInHdzCXrN1jsaz1za+xQbw9WURP2VUR+z4HqYynrwn40fCrS9Lhu62L4LqeXX35xiCP6mslicQ6/og=
Received: from BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 12:36:42 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::13) by BL1P223CA0028.outlook.office365.com
 (2603:10b6:208:2c4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:41 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:39 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 1/6] dmaengine: Move AMD PTDMA driver to amd directory
Date: Wed, 23 Oct 2024 18:06:08 +0530
Message-ID: <20241023123613.710671-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
References: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db20af1-405a-4032-33f7-08dcf35f58ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IKfKSz4rE5BXSwbjk3PMVj99y5VPjd/LS8w7ya+694w8Ys62t+5cwM+MpVEV?=
 =?us-ascii?Q?ldOLy0zIaii02WAxjug4rwraDipdur7fraq5j3bvSvlRF3e27fE45T4EOstQ?=
 =?us-ascii?Q?O0fFH5FoPLvBeYnjfL+v4H8/p1q57W/4YPM7K+FZ3z3ufTIqxNLNMp50kaek?=
 =?us-ascii?Q?a5WS6s0Iprrs9jzQ0yOteh2iB2adiEZy91Amaph9daYDnGC790gvFdEp+UXG?=
 =?us-ascii?Q?AgS7xMYZaNa2LZXjer9kqnZs/9yyZPRRNI/HxFVb4NQW9tD7AmOqOfoczzd/?=
 =?us-ascii?Q?XTOf5VcDg/YPh4p8Lj5/oShBBu2XmAMaIsv5L01gLjOySC3hBbZOMJpoKRP4?=
 =?us-ascii?Q?VB32tnnS94Hlgwl8CAWEn0Cr+CMXDHiDtqGgjfwzMAkR24AW9RmSiKRvq5pE?=
 =?us-ascii?Q?JI0HtrgmJ5zz+BW16U2aBEdzAXPyk/yPykmnE9WHyDrKtF0C5f8Z0Ub9UrX3?=
 =?us-ascii?Q?Ck0yQwgWGnt/ih9ClE/LaqjOV1cta32+ZRSQP6UYKlJI6OFqijaDmmzbhNbY?=
 =?us-ascii?Q?+2fL1yOzbpCmiFNKsreK2MFwCwwKm/9OeMgdZwUYZJaCPslMfG6WoqmIw8/7?=
 =?us-ascii?Q?ccGrjgbZ4qjNKG9mTi3eDYi3OEddP8YA0W5ulcDaypAt6YSBTWsZR0QNItrl?=
 =?us-ascii?Q?UxoVGNeJgkE/t9Yean0T2HoABOgOJdz0sz1MFsbm5erexva3XKjTZOuO4A3e?=
 =?us-ascii?Q?BurYTvhr9JZjIUiVg7Lfyt+HB9wOpmAbzEOIyc2Ofyc3li+ndc4yzr7UnidT?=
 =?us-ascii?Q?mjDojAveGzpKHvG56wQ6wYtu6S5pcjz1Dms2K+9US3IlsqwrTx8SP32asGG7?=
 =?us-ascii?Q?XSVVWLk+xEuyS+V7Y/I/MRArGiMKOXn/MyKeHk5ZjqQW7SqSYMYY1tdt/N0J?=
 =?us-ascii?Q?PKDozJNfX2QYJoIaRy2ltgVOCRq+5DOenWjvNF7Kc+yT9Liul1Rfpx96nWXr?=
 =?us-ascii?Q?NWq7j8AbTMC3qGR23CVENv0GgydSAMVf18zkWYVCd/bgZtRXgceI+aVBE76Q?=
 =?us-ascii?Q?6gR8Xo4D1nDFP3K5S6BIlEdgDJ2X5I9Mxsw4E8bUl21uakRRaRMpce3oW2Sg?=
 =?us-ascii?Q?4WznXXcxEDea5dTx5IIxyOu/CAUZC7pNsPIPnTKOXAf1MDW1SqVamwUfnlfH?=
 =?us-ascii?Q?tKsP5WwoPb9EXD1qGDcz5rAoquRAh2i01InXvO6HyYQx1U9dj37SueTI9Fpg?=
 =?us-ascii?Q?QRm8GpCMZnCpiZGKX+t8n2aZL6qiPlhjAmw5bIIbs/OwnkptxD+HXzW/QLLZ?=
 =?us-ascii?Q?zLzrzIbcGzyVjWriiGcMpTqfz7LYcpyNvqOvu97DR9X4rsyBPSiEiSE3sRvu?=
 =?us-ascii?Q?kGQGq4x4+dxBVVmy98Ee8q2ajWWBBNtK9bVq7j3m7dtYCEpjqWs+OokX5CKE?=
 =?us-ascii?Q?drPOZeBzPb3vp0u12o9JFSSg8h3fhTm3wc+nOxs+oyJqHt5iqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:41.8460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db20af1-405a-4032-33f7-08dcf35f58ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

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
index e9659a5a7fb3..6a0177b852df 100644
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


