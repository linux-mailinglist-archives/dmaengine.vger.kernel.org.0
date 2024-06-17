Return-Path: <dmaengine+bounces-2384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38390AAB6
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870FA284A94
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B4188CD0;
	Mon, 17 Jun 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5U6uT2Bu"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6318FDAE
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618681; cv=fail; b=sbTbAoh0OIuChe8F76SRxYn4fbg0kLLGWreTmiV2iT5FCYCB6oVB7/KGdoJkeZ7GbxEtjR+Xs5V4LtK8bPKwHgSWtkmknAcMiJT9nR+3XEQBT2dzwIuQej/Od13HzgznHonXs+QtjnJmK5WNwpSpPMkQrukAeA0jG5nlzeFvcX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618681; c=relaxed/simple;
	bh=FReLNjKDrIKMcjD3rH+iuacICf1uyTTymYJGZ9gzFVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdczOoJbd5FXzuzNbt3KsClNOxeagI8QpQo30rPpsjf1YMF4eUquh4v1waJeF+/5vSzq77GsX0V+Ujf/oNErTSso3c+ElRuKKz525LiOb/sMHC43fSOQRNI6Yy6pgtcQXY2PalKR588gqCdxOyS9quA/xn2va7CaqXxmqYACQ7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5U6uT2Bu; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZmSo3y98Ox5J2yG95S8TNvuWHY9wbsTRliZhlTpZ3B630NFi8YD+GEqnOUIos0Ufpefmq6UjmKn+mAd7U1ed61g2V6bvMGCHlgRCiZIZ4gqdV2+EwdUPvSK4WsaHTaWe5cOxIrxay8DH4qtcHKmRRrdMD2+B9mRNDjflCig6hcRgh5B0c56fDxGgLjqOLXKYuAaP78B1PVqSpQJtkmEKyuaHdr0EPj/y1/gczSCgHBcU+Muo3IxJczzAedflSjnNcEXdx4U/pcTGeR3BjwTxad9BkPe/lQ5fs5DtKLBs6wSMvbUWbgGgZC3okEffBDzCKwN3tJTdf4FZdX8pZHguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqHHpNafa3pV0IaSbdtF6gDz0atdqid9p4eg5mEQxXU=;
 b=aNzXW944bw4MVe/bh1fVQCfAbCrdmUCdeiPFUBC3MirYSCh1qEhv9ANhIkuAvrVgwEV0zlWsk5CnR2Tk/gwU9quQLeOWkdh2qpCKmi7HDxeHB+2ZGP2Ym2/2Cb/sT9YUOru6hOOS+vZ6kbJdLPVeIuDEOCClLhwNrHUk6ALW/fQMR12Ue+BGvQnJ2eXDrbAmKBtHEcopdpX+n/+RSAUpDO4MLVcz8G9yygMN2UufnU2OhYd1STJTE+zV/1fUNtan52ohhpCdQc2BuVmmKbUIyJgRxweWPNswacxd0oL5Ket1lmr/HmYkKgpwfntMIv/kxj4M271EnHTOmLYwjf/jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqHHpNafa3pV0IaSbdtF6gDz0atdqid9p4eg5mEQxXU=;
 b=5U6uT2BuE8GNaWwUwl62jPxMog83x4+sTkjY1hvNUrWcF9bNShZ4yiuuu80as3PlBjGEhDDoGMblccEoSiCo8XPa34weLqCSXO8n97A73K258yCDdSE1AUawUVbCinp6OwVFDprWUMncqxNrwm1NLDACCCnx9s3yZtMab5+d1A0=
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:37 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::d8) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:36 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:34 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 1/7] dmaengine: Move AMD DMA driver to separate directory
Date: Mon, 17 Jun 2024 15:33:53 +0530
Message-ID: <20240617100359.2550541-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 968518b7-5388-4f68-6186-08dc8eb4e51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZA7cE6fRjtRMsZSFiwiOc3fR0hn8Yh339ElbzCv1MLewLKgvpMgvHKBdJmBw?=
 =?us-ascii?Q?wRkqAi0p7xqHp7+kxqmpHOCPVCzz4vqA0PKMKe1gWE8KwO9Q+q4x1W0EdP9r?=
 =?us-ascii?Q?tl/0Cx8gT6I90eaqee4O334uZIdrBjMg6SfE8xW33+HOBWjX4e6+f52mD+Mu?=
 =?us-ascii?Q?lFmfYVtuEpgvK8MLDHPqDHTL5C334p32rU26E7h+C1z4f4+2VE4ta6o0sOHO?=
 =?us-ascii?Q?+ef3bZdc8qVs2DLu5nCctyuhSpItya+HKFdiBKyrXpxjHH8/bg7JsBMh9u2p?=
 =?us-ascii?Q?rH/PwuOLyCA7py9EK45DjUgnYG57G9WVy2sNa8/XZnsiocikllyr+eOZNo9l?=
 =?us-ascii?Q?LlaalMXmxLQD4QlZB3UI1X/6jA5zEJYSepD9saAVDmWdkg69RYs5saefxJ+J?=
 =?us-ascii?Q?JdWzP/L+gyv1YejRZrz7507QBpxeg81VKW4tcaKVJbF6M16szYqH46JvXQtq?=
 =?us-ascii?Q?b98q09FiHQYt1Q/X9VmIqoI/gN/Avyjjvs/5yOlik1RSYeoePUCwPJsH53Bf?=
 =?us-ascii?Q?EfoCtD+Qk5eQjhB3vvGcBW/z140I/hHxvkgUsdg9S+7aKozB6dpP/SR1WVnJ?=
 =?us-ascii?Q?ZxwbQiS7zztMu3wjvkVzecH0FOSZgC40VZjIMbDMD2TCO//fTuCE72l0o59c?=
 =?us-ascii?Q?o3HL53Ej07DxL5HabvYrnQBjP9xKDX+yLqSMWxKesbk5jm3i0yYbyCzQxaBs?=
 =?us-ascii?Q?cP9E6LMwOGvKGe60VReDBExAnFBnM/PqUB2qWURc9C6EqImpArkNbGoClYBj?=
 =?us-ascii?Q?hivJN5NmJfrrNYXLTz4uZr8wW2U9cBKIu71hTIlt0tlGBUz7l2vUmwGhfiQk?=
 =?us-ascii?Q?TbcZCatXVVma57pvu2V7fxrSCYZNNc8Cp8mJCl9bww74z0IfdPWLzZBsa52x?=
 =?us-ascii?Q?gZwUlSM3iWMDG/XmOrryQwc2jgGPc1gpb445nZHYI84UeEuTCTJQkppSU3ol?=
 =?us-ascii?Q?H8YZoStjyagFDZwcPC0yTtWhE2aAs8A5qgXWubaWo1SBl9D775Dracmi2VpG?=
 =?us-ascii?Q?CbkuCqKkDOLRSDGo7mT3FIuerHV+1vaeYlknfPLA3+mD9PCQydVx9s9Ym5ZO?=
 =?us-ascii?Q?hpDnF1NLrxhUwGtmMKShYRc3Rf617olGKXkl5ulTw9nQ51367NHhZDQJBtK8?=
 =?us-ascii?Q?G59swVfYZVajLOGFJZo8p7keHM4X5aqRlE61KtqPFSk9XlEnCRu94SEWTRCw?=
 =?us-ascii?Q?ChtANf9rTpipn6LtdrvxTwxHHAOf/YHdxSDrkzIcQE2jn/A9LxPT2xTV89MA?=
 =?us-ascii?Q?+n3BM7xAl6c9P+3cp8kwhArKNwVUCp/mtI1ULZXg5ftnuLLG6WmKSMpvR9eD?=
 =?us-ascii?Q?ibTkU6IQfHrEW+hfHgDMDqJYmWX8DY4rZacIFi8+RoFfKC/OQHvq2IfOt9+5?=
 =?us-ascii?Q?SMlhP0A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:36.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968518b7-5388-4f68-6186-08dc8eb4e51c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

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
index cf9c9221c388..c500c0567779 100644
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


