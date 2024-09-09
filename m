Return-Path: <dmaengine+bounces-3117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00079719A6
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE67B1C22AFB
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C21B375C;
	Mon,  9 Sep 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HEuqgcEb"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC71B5804
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885611; cv=fail; b=a7MbD+5aiLkCxXsjvtgBcrYTHVQ1c2uwYlTSy0r2hy574gDM3dApSo+kCofOnvH9kcta6iOn9kjw8y1bWb9qggYSrVOt97zChO9Kmi7JOdJdVm/1cqW2Ev8qqRyH+Wrj8YA6mPrwsWkQLSZ1heb506lbBDkj9S3OJ5TbZZm5GJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885611; c=relaxed/simple;
	bh=zGDwdkOzouj9LgvjA2aOnzuJ/Sziu0JRgdRE3m5t0SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXAE+lmgIrh1eJE8S3nnf1V0clRcSdfjdXXhKg7dXu9Vs3m73iiuIpZbCyim0+ld+DBKk1Y3ICUhdD73CU3TDNo2fR/xq5SJv+5O1GAK+CILAJAekaDfypryuP1Y+UdSwWwK4SkfOxDjtcpsTz5cDmh/Zs/wNNcs/YzPVqM3CAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HEuqgcEb; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ6rgUi0sgjZB8pwDXDWPZASTf+wIqEmOGRwInSXTA6PQLTln7aWQq46w3ZnkgsnV0WGiYpuL9J+QZyjDXIqcVdDBjushM5V806/33f+eNmkDt0+pTwPFm4r+OCuQyzJ53SZ2ZfrYJ7x6RNvpjvo2p7t3cV/n9TKM71/WdvamFMhKdYTOmEbJl7amhGm9hBQ7ODIpg4g3LC356qTocBdqoTaw5av2h8aVTEJ09T0xLNLRalwFQ+4kjm92fXAlGKAG5unfQ8HDIU70noYI9L+v2F3rtc0SocREzJhglhj0emR0Fbg6mnoEmrCFG3ceirFcJy6fZUCAdF5T9QwWQ6z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKyUT2PVzdxhVBtzGWV3mxwh8jsXC3nt0EAUKkXOaRk=;
 b=cbpht0Fx7F0zC79Vev8CnkD2rfYXj8V6dfC4AfmlN9MeX+oxndm9UymtIdAkmHae4bE3OPnGpVfspcKI4hKIKFpXLIw/3UNQiJ1oX6K/xQgnTQYL//uh8BhiOCkd/0LDYaNhdqjmmQVP4hCY1mgn4OkXx9kNjc7Wc0vKwJA9y4yZk3UTLRNU/CRCWY83RsC6B3FMvKPzEUvKk7ru2VLt7bBr6+1o+ROJVRTH6unj8+vlfz78FrhMxXNVJ6u456EfubtRhKfuVh59kZPOKrphKQrvFe7xQjDrnNFxC8lmFY+o9Tm+vy5N2Jp6fJwndXPJFz/lqSg1xoljZizSSuLciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKyUT2PVzdxhVBtzGWV3mxwh8jsXC3nt0EAUKkXOaRk=;
 b=HEuqgcEbyYuEmLjovdezg44UZTyBxl3CrW6Owy6jk3A9VGojbw3ipwrUIHXPgkiQ8DTGJGNO++HVBCx3MEkyAsKdlSzxluX8MXcwQJH/mIhf+1csbaYNYHV0bMrD+Ot1IGdUCGegRYxikERxEuG/vIJeJeYQtgJTKrU+TGBxVq4=
Received: from BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 12:40:05 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::51) by BYAPR04CA0015.outlook.office365.com
 (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:01 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 1/6] dmaengine: Move AMD DMA driver to separate directory
Date: Mon, 9 Sep 2024 18:09:36 +0530
Message-ID: <20240909123941.794563-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f92e12-0891-4de1-223d-08dcd0cc8815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMZDKojrhnGaY6He004E0JzReD8fwZxvgyPZXkB7Ez72TQTZ3v2l70YwflHu?=
 =?us-ascii?Q?yp7PQpUqoQoIj05EqfYcOvTAIofP5Z9RN6UX1RhK33f/t+HzoxzfgHYWY1c1?=
 =?us-ascii?Q?1S7+DdqxbqcpOe+S5E5K8nYRdwxZQ3KVvhJZV6fshKuDSZ/radh+gAwOVaRx?=
 =?us-ascii?Q?nvS2IjTMiuRiyLWfHbptCWuYkQAteXKJG5QwNswKGKmrOkSYrhloaYR5ikUj?=
 =?us-ascii?Q?RYU7jEyRghKK0+c2x/98Z1jM711g8VFb7RB4nHb9kOeWhMZDGp6u4cncFGQL?=
 =?us-ascii?Q?B6hY2dT8BbLzRP5WGtm9QH3v/wleWbG2+n0Sj+yT9plNL5QQUfRZ+lNfjxgG?=
 =?us-ascii?Q?ZWCh+/TAdbIWQgsSFH9myndNhI5AepKGTshzifvjujENKSJ94kEIiluoCsfo?=
 =?us-ascii?Q?qJHd1kvZcGfm6jF3nevxgKjUuQjy8oMpmbdfLSZEL9jv2Ln/70Se7xodS+Al?=
 =?us-ascii?Q?jzcOt/5kMYgP+gr2ZPTmUIMfe8JCYhxe22P6hrx7PTbGgXqy8zN/r6x52Jbb?=
 =?us-ascii?Q?xNzk92hp+l+hftsQAb3JtyGxr5P7+pvnRe+mzEfZ0QRvBLlcwlVLFAHp8SCF?=
 =?us-ascii?Q?WQnTvcqIC8KEstpwV05HoUpYcmPAq7mlsSHWs3lHYE3j10KbD6XPRGK3Ap+d?=
 =?us-ascii?Q?3UAQwGR2JPdnR+WRuPCULBLFb4Dz12fl9tSFA9JXHhSvI9pIzzmesteaaQGd?=
 =?us-ascii?Q?LSrTZjBk2PzPcRE4X7zIG0NN9LVri1XScxXQl1mQgzyj6FkB1HV0Red95AJv?=
 =?us-ascii?Q?Y/yULi+IEAw9Fjm9w+1AS9uNo3c6Llu+EP4VPG844exS+OB4GAB/4SalD0/m?=
 =?us-ascii?Q?13yKr9cAmrQX4N6cFQmkYCmAnDCtkmSiWH46xXnACI6u3CTV8L+601DCs9z5?=
 =?us-ascii?Q?TFjuFYAW2jbRfUs7JuEcCP3ylvAkL9j5T83wjnejItTrvDlJe/5YNLLrX7Yt?=
 =?us-ascii?Q?KWqw12r+duI6+TMW33X8XxkxdnN8TxdTwy5kwQdJNzQtkpzsqqE4LszhkiBJ?=
 =?us-ascii?Q?fnlx3abmeEne2prK4SF+HGDTJSylV6mDuSQejyHR+TdT2sxvkGtePDguMuUa?=
 =?us-ascii?Q?/VAywjQJghq4wOgHOla8lpe/yIEXITxuhzzxl6zJZrEyOFwoC1ClD7WX0jhH?=
 =?us-ascii?Q?ndrolHBwDykL9GuiQrnnI5/zj3IY9W1YkTS6TCb9e4u++mwXe0cmZ1SRfNGZ?=
 =?us-ascii?Q?57ZhVQVAKJ9NhKKkGzT/FnFyo7g5NCY/+QzfFQ4Q2CFvByGQoeYImNaecx8C?=
 =?us-ascii?Q?rijnLGqZQyCgKNLmecuuBM5HE5HLfqSQ/P5fZC9582fs0c5GNOZv2AihcY/s?=
 =?us-ascii?Q?kjw/eCI83nVTXxDY3WE0dB2EKOcWIJ2SfO0s9lRwClyDuUjV3hTg3nzvVvyx?=
 =?us-ascii?Q?r4F2vU/9uJro3BdPaOdiPZ7TgSQJArjRXsWuridJUm8oi4LbsKVNClOMO4Ea?=
 =?us-ascii?Q?EkqzYr7xRNuDHwHnI3hiQNy2sOpuyg8h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:05.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f92e12-0891-4de1-223d-08dcd0cc8815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

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
index 10430778c998..a7712e5772e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1126,7 +1126,7 @@ AMD PTDMA DRIVER
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-F:	drivers/dma/ptdma/
+F:	drivers/dma/amd/ptdma/
 
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..7c5aa6caf68d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -716,12 +716,12 @@ config XILINX_ZYNQMP_DPDMA
 	  display driver.
 
 # driver files
+source "drivers/dma/amd/Kconfig"
+
 source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
 
-source "drivers/dma/ptdma/Kconfig"
-
 source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 374ea98faf43..6677c6c97f39 100644
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


