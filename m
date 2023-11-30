Return-Path: <dmaengine+bounces-335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558537FFB7D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE55B20D7D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59052F66;
	Thu, 30 Nov 2023 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KlQ+x5X+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76120D67;
	Thu, 30 Nov 2023 11:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW63VyiSHKUGpv3dz223rymXpswygVjF2vSHS1pmkd+CVLdjmfDK8uVrL75iMF+MWGrh/x2wE7uHAVTHLuLrLYdJkA+lCt9sOmKRAinDx3B2xosFcnovd7mUgZoMWMpD1XGaIl87oi0sGe5r64ag0v92l+9AI3RNH55R+D1C5d5lYy4FNMauz152wQucKedmmd+9k7psvbJoUnFLmwu+CeHVnaoe+6bYumnSDQ/qEGh1wkuHTe2Wh52pnfafjktzSxtUttTW3I1L/UVsoqVb5fDTdzOI1TUiXdBlZuPNwG6rA9qSmIenuvrvkoNugqkgK+towBfbLyXeCt0HTmTogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36tiSFvd6sblovW4Y+Xuy3DuxH+SQ9VT6wL8YppCBQk=;
 b=Yqc/LtAx1xlxpiFHWMtuW4Ijuub0WLDttr1UFFhJHas01ZK+/qQh4UfSuXaRY0T2ClNOA5aR+neht0ku6pcrnBW2FsOx2k7GoJcX18DqKwf77CTKlW3wsejYpB069XFR6MPCtAkZzSOslTWRIbdL9OIJXYy2u0tQVUrfWqJAg5ILDTJG8C/ZqiORm5Nhh81rIpCrWoxnlkZoM4owl2lfsMzRLsFafTROLMfmfr7rG047bghUp1/oxUdMT8S5fXERMfdUcCVyjIjprsYDnRVV7PnJ29SMScTCqCoxBgJDfx+xWFR1yQW/94NxQ1gqqaKgB79iQTjCZidaAd5S/VG7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36tiSFvd6sblovW4Y+Xuy3DuxH+SQ9VT6wL8YppCBQk=;
 b=KlQ+x5X+06Xis18BZLctBhm/HLW//rV4UFpNzzIMvbalqrgdeaYy2OHWhEYxYReqsaqLb+qBDM6eWnQTf/JiL6nU19PUWg4dk9y4wXoFv6R821PqRl0jTupQomJUfwIpkfkO2gtSiCG01+oqJ4My5m8bZYecQGDmmoW21phhe58=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 19:38:49 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::ee) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 19:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 19:38:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 13:38:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 13:38:47 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 13:38:46 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V8 1/2] dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
Date: Thu, 30 Nov 2023 11:38:22 -0800
Message-ID: <1701373103-67868-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701373103-67868-1-git-send-email-lizhi.hou@amd.com>
References: <1701373103-67868-1-git-send-email-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 491c487d-1131-4eaa-5711-08dbf1dbf971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O2PSnK5WKH1K1Elo+Wtq5D5bD7oUqq66iYO2qqkMd504iEG6ueypNPTZYAddnamlsexmvwuPBw7j9BFxTSop9VFTfVKCO2ITy76+6EE5uBNT91L47seov34AgQTuF2gELFBng48xFcsfZkASPu8MGJ6FjQWdQ+D/wE5TjZCWIMf7DpnpfU5GCyY7u/Hzdc1bIClY5hk8GuJYUisdihRy4Q2m5DYxtnI/nbrKQc8atywRF+wHBYN2RindikAjbHDB4PD65SUETbQYr8DNPiaep+vTetwhOYfkCEsM+0FdzVKRXOTcY+METD8iSTMim9dH0GKipd9ulzPFI/pABecxe2XP2Wr7zIkakV3ZYI7NLwMHJfvwEGMh37Nd0avkno/kkyXjKaGJYKTxMzM7NGh02TPslriXXYTPPcxarIxghtYcQ+FUA2BvJnznHCb3N8AyAkSWcuDHnHrVAmEAcUg6xDFZjq3iFhubhtv6YuRYoGPJ1gQM6OQN8gcCwFPOjCyCbXlBxbgR4JOSTgQA1cjhWOd6v6QcJ6UOaeKzAJRazzS/deNtdDfjYv65Ouj/Douo0POlLF32MxllenPkIcMwsxdYQ0i4DtXPEidoaniPEPoH7cT4RCB0TKBzSSUs1vGohJdxbGOjJtsMEw6/Hc94iWBQiCGjBHJj7GVrE8u1LA+DO6vwUAq/qmCs1Yw2DUCqgZzg8QYiQHCJhUFYMTg9HBbQfIVVFI+VOSFeR9ZzXr1qfHKU9qix/+mbWH8ogV0grWU5WnixCtLiCPNpS/NNzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(2616005)(336012)(47076005)(26005)(6666004)(2906002)(426003)(44832011)(5660300002)(70206006)(70586007)(41300700001)(54906003)(110136005)(316002)(8936002)(8676002)(4326008)(86362001)(356005)(36860700001)(81166007)(82740400003)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 19:38:48.6581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491c487d-1131-4eaa-5711-08dbf1dbf971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

Add amd/ for AMD dmaengine drivers. Create empty Kconfig and Makefile
underneath.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma/Kconfig      | 2 ++
 drivers/dma/Makefile     | 1 +
 drivers/dma/amd/Kconfig  | 1 +
 drivers/dma/amd/Makefile | 4 ++++
 4 files changed, 8 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 70ba506dabab..e047ad6f2925 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -734,6 +734,8 @@ config XILINX_ZYNQMP_DPDMA
 	  display driver.
 
 # driver files
+source "drivers/dma/amd/Kconfig"
+
 source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010..f1b4ce468a9b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
 
+obj-y += amd/
 obj-y += mediatek/
 obj-y += qcom/
 obj-y += ti/
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/drivers/dma/amd/Kconfig
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
new file mode 100644
index 000000000000..47c9577b8cac
--- /dev/null
+++ b/drivers/dma/amd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023, Advanced Micro Devices, Inc.
+#
-- 
2.34.1


