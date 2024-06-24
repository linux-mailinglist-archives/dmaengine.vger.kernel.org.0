Return-Path: <dmaengine+bounces-2517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FE79143FD
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330201F21D6E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10230482E9;
	Mon, 24 Jun 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c1CMuNZE"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166A47F5F
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215803; cv=fail; b=QyVc9EQMIcjVj08SQAiQrZzlfO75HyqLb0NlYavgCT2uIpjF1q3lJkyPeJkLRz/Sk1Y5Mko4/a+P1oGW1er86HjJLJ9l6cpuPzdQyFbN0Q+dvb6EVx/VHDkPOi2+7bAnjKA60FejcSV1s8rw7bKsVa8ow2hk7AKL//GNXx91fFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215803; c=relaxed/simple;
	bh=zJaVLIAzQ01kaelodJ2uJFpYMbNEhX2Is3TqL1cCkYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyQOd4S83wxWVPxiF4s5MI05b7mCv8T8EqPFQyVBb1er/aoRnbuxvmpl+CAIpXkFeIwFLzsK8lYM1a65sn0FNaqoi7PKMHYoTvBeMpCxWoMnU+5LWfHRV14hwRNpKH1x+OjbLSjptU5USYfPJCAzJ2G2KPKoe5pXfVYvtvxKaP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c1CMuNZE; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtaTzBaaYFJn7n463XMW6lDTvV7HsbyEzrawtDPc72Qi/8Fwd8D5HxOtBjBOYP24j1aMx5091IIHg2qqa889F9b4edk4ct5Kh5UC2eetrm2Cnue98k/wEqtosVa5bhMwMR8yKl7ac+bps8DHgBOu36zGrAnFebjlJE9dF3epCTBDpluY2rNrFog3srOcZ/qnh/oRM/4jrFkvebLw+ptIR2jLsw1ClP+yma5E9RwagJiYMHL6iKcqq1Wd8BGjXYV6q8bUC52RgvysehdH8fcduKj9+DFwwyboXEJZXyfLd3LRVxniuW4K2u2bRBaFGOob5Sa22Nf0op5y4vpfIlW/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnEZgJHUzd3DqeK2wwYYrMRXM6y3rnEf4ji14tEjgr0=;
 b=ZpBHEy7DKdrUmUlRR1VFGTT5qx/ZrPAXaxWP0U6aZro/WZKG7ebFhB8LxvW+vR36B/YAMbajOStD+pUGmZyK1183nKjiw/LSmNhRuLOVK7KmIMtGjM1/HmIibh7X6J5V7QdNJEFv0d1udHVs7PNbQMA5ap2I7mFg6i8tpmzJVLaGUGdttqTyJYumyHGtanOxoeCDY+lizBWazYAPP7FjoDuVzKwWBcpY21GnTUV8VPklxlXdKZJz/pIBk724YJoqp/tkVEI0V7NoBTSo5Y9yom4/5WeKGnp+deiO21oFijTG8Z3O8Zhlj8pi99nhd/khHbenvh5mKcmVDvyUvgVkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnEZgJHUzd3DqeK2wwYYrMRXM6y3rnEf4ji14tEjgr0=;
 b=c1CMuNZEnqs6/bRApuXOdF2aXweTVNpJ/QYiNNneoCEJBjPZhnxuUWbWE6fMtLCp4wljho30yk2ONOW9ix85RFL46iaOWRTbJgfiCopfK/+1WmKL0MB+2P0rWXStAdCk9MqVUINsUbusy+SdE2Wmq/ItWP4+05IGtS8SYiaFy20=
Received: from CH0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:610:74::25)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 07:56:33 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::bd) by CH0PR04CA0080.outlook.office365.com
 (2603:10b6:610:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:30 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 1/7] dmaengine: Move AMD DMA driver to separate directory
Date: Mon, 24 Jun 2024 13:26:04 +0530
Message-ID: <20240624075610.1659502-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a1cd2b-4ecf-4c64-b1c1-08dc94232a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0j1RSvAhrcnGkGVHMe5J6rGASVd8qGwRzgSK3WLz1itPLzOWSL6adXo+tP6Q?=
 =?us-ascii?Q?yio7vpPMsdvzCbY8XSx00nuf+GhHdmcYrbS3apsQxTmv0yqsW+ScXkUg/AiO?=
 =?us-ascii?Q?ZFpNJvQe7Uh7dm4brzKUDBkSVmTGBVk/zfW3J7Pyb35JpTjWdgNTxauH3gLV?=
 =?us-ascii?Q?TWJMDPjSiKY1UYVUS2L3XzpvQwkbGgwZqWjUFTARFKQfRDJOeOLbvsHXpdx9?=
 =?us-ascii?Q?YmIX1CWqdxLiGT2raYqwfIZKgyfIO3BUq71o+7s7Fz9o9KzPEDjyl2uheomu?=
 =?us-ascii?Q?x/18x7nlCk8Xslgdtg1X4w6B4gpNP095T576pkqbu7zQuSoC8zwqQd7DrBXz?=
 =?us-ascii?Q?+op594h4x9URFIrRQ7t7JH/fpxMpK63gp5qqTZu8h/zXXreN8U2FonM2hovQ?=
 =?us-ascii?Q?EIhHKvEQygahRNz44Fi72abQvBabLIK5zuX5akwbvT0j2nimtpA3O7H8+7KY?=
 =?us-ascii?Q?KDGSGpAf6qI4lwAqKTqHB5R0vae9Y6vE42p6HVlEY1E3ltGsMVlBXBcAv6SC?=
 =?us-ascii?Q?XX/O36UXLJbDJPbaq0lwgPyU75olcTwWKtX3G2dqeCBq9ywkj8LQbKGvyIDI?=
 =?us-ascii?Q?qAMMKcJcyj4cLOIO5NlHorvu+ArWW9XH0JxjEHs/3YPlJ8PgA3PifdJ5Z/uG?=
 =?us-ascii?Q?lrEwSOQxh2C+qqrHdHbP30c8vRP2QPWHm48eXlFPBYtmw05SQ7tz+6W7PUuP?=
 =?us-ascii?Q?egrU8Lweviq5FkN1ci8fjeJ57vzpxN+y0R5kpWJj6zV33Bc4QT5rpVkFuGC8?=
 =?us-ascii?Q?Y+OCzLg/8vRvDGwIrrmQhpvSl75zqpl/7auQxOkAdLXIkhIh35cUOCJeNqmr?=
 =?us-ascii?Q?rZlKePHAN+5S4OQ+nN3YV3SlNkgP7Lt//cjbD1FMfbwBOc+xjwbRR8Hk6zqm?=
 =?us-ascii?Q?SsZsKPsgc0NDmESgtpyEdF1Ka4L0JdWXVKrIwYSfCw9Agy1queyr5G8NHo7d?=
 =?us-ascii?Q?8yjnBrwSrD4lfXznbW4SM4RMnyvklGEOhFMqqFVzGVeTvxcPsNVb9+H4KPzc?=
 =?us-ascii?Q?VRLAfvKw8PeNnWrH0ck5b/winYL1FvTjSusR4CKsTh2NDH/7M4V6YftbGLeu?=
 =?us-ascii?Q?5tEY6AZzCrGddT4lM2vrB84YuRc2Y8JwAHXI6BzAthJlJJGZs70dvpjWmki3?=
 =?us-ascii?Q?XnotgiWkxNus9ZS3ZaMs7hc/dLY0zi/z+onq8/QLdXV20sD8YxTzCAb36ljI?=
 =?us-ascii?Q?iu1eLX4fLUwaQsH/9p+Qracq7g3RLtXnujhjmo3Jy1uNL+4HS+Mh8lngcrvI?=
 =?us-ascii?Q?Is07nBrFv4ucGPQ4mnqugvLmw/8so7Tkgk/f/4StUlahJ8kONJyDaTTMfCGp?=
 =?us-ascii?Q?ZXMLXLEqEeEc3YgRtT0xXpBsgBxmPFXdAFV43rSUi/JCgaSKGAtTwBhFcbvC?=
 =?us-ascii?Q?E4gMICt5mdEdTb/Bjy0zaCQLB1EP68SUEUgVhiZ6fUEYAZMY1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:32.9333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a1cd2b-4ecf-4c64-b1c1-08dc94232a10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

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
index 2ca8f35dfe03..537964afef55 100644
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


