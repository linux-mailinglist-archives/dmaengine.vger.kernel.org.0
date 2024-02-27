Return-Path: <dmaengine+bounces-1132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575E869D30
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62B21C23868
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C44D9E9;
	Tue, 27 Feb 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZezWvCM"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47373D541;
	Tue, 27 Feb 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053731; cv=fail; b=WtsK3DD5B3Po8MTXVMUOVexcq2lSg212n3USNuFzZAkwVoS2PVmK9CbsO/omNY+zxc4kltoKPbHd2xLVylRKRwnwsjlMeaTdDiumw6Opz/oJN4Kuy8mkMoQGMvgg4V/jzzJ9ohaCx+pzdQLEqzFPkiJDvrL44rRAj0MkTtiPef0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053731; c=relaxed/simple;
	bh=zzh5m49QmUErVTaNnJ/zQfAozOP/rm6UIruyZAeM4w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t14zPcIF5GzrIeGN1/CXIXaW1yqUXc+HYKyYjONRjiJIxUl8eA1lHKPZXBG5H//EsHSOTSbI3+zGZbgZ3F9X0mU+o588pu513PJaXpL3BgixlPAO+zXnzmaf9mJodt+5kaAUSBGXard1crbcJAZEsL3x7L2dL21mDfQlQ521Bwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZezWvCM; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZvvWZcrqcnXSKc9mFFCEXKr3UDu3/ppJGC+H7vcz5bgTMad8GJ/xGmsREpu6roaEBdNqR+0hlwMpUz3+FGTToCeZGeQvT7ztEmTFAMyrmqJV6kfs57hQG/9g8l2sjuQ+hqHCv2ub+4PDdhN9frOUYHi4uSmjEVsEjgz4a636EoRWXMGWGO7svbqIOIAkfHlFGlv+KP6PpmS3I8hLs722Xog41H2jGA7DbGapjGvfXW+RXlM04mhnnYYisHrS8uBKybRkN1arWRf90uVO3Z+vAMMk2r/qTv0sHzP2UhPsaqUwFHjPMZkSGSmJyMGh+uITZjybQnU8Btz56tzK1Odcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSyFG4vLi/zTEUq8Cj/AXA8jyFxaTrxw7/u1tUYT/Hs=;
 b=jtTWdMwv+cXAzyN6twDB2/0cHFTVqwQMFKu3JWWSLT+INgm1ffP+AljtnhDIBAD7u+8jHEAoR2fAG2fjEMjbD3S8g6PS+pmzPiYwzuvn/lQHhkZRw9mJGiUbG3DU7iIGYeRjpl+QZ0hk8XWLmoguqvaAItBRDg+xx8jsPZ9P4tCPRLn9Q2cukyrNnOPlmijpLZLujfAw0LlyVjVWM7xv00SXu4NtBHMPGC/2FFzK1+sHOBREZtldhZvRundhnPgPUjj2HTtEqfsV/f7JX0RtO0qrv2woKoOx7g0H6GGT8KKItkY7eIA015Sp3uebUWVQqaov477SypnPb9N+//SXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSyFG4vLi/zTEUq8Cj/AXA8jyFxaTrxw7/u1tUYT/Hs=;
 b=NZezWvCMhvXuBEDCSAhmVENQwMumb4C9L+vuMtRgArOe8aepmcBsxHrlNfbDY7EJ0hUmd7iJ52sH27pmDy+GvYlh5emI+g/IN3XzRWJB8fuDO6GwyhhNEbCkgmOiUeni5fOHEmofizr4aOYokiR04l4YMdYxOFgJDgzLbtPwHLA=
Received: from MN2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:c0::22)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 17:08:45 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::96) by MN2PR05CA0009.outlook.office365.com
 (2603:10b6:208:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25 via Frontend
 Transport; Tue, 27 Feb 2024 17:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 17:08:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 11:08:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 11:08:44 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 11:08:43 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishads@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
Subject: [PATCH V9 1/2] dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
Date: Tue, 27 Feb 2024 09:08:28 -0800
Message-ID: <1709053709-33742-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709053709-33742-1-git-send-email-lizhi.hou@amd.com>
References: <1709053709-33742-1-git-send-email-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 486cc0bd-12e7-4e75-a4e8-08dc37b6c171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9om4CcDLY3q4RpqcO6F/6pYsKwDvGZqszT459cN6IOsRLDzOI7R4u4zHLb9csS3IK22/obnmUR52NPEqGu6++tJ0vM1wdApiMZdsKyJlECMd3dq7TbIH0KImEWyrWD3cGEVW4YWGlgFo7AytTf5jZq9l5ixUSrKTP8L6eZ9pOBSUJOWsH/aN6CZDQ6eIkzoW6Ryhi+VDNkdumH089g/dVVXp/HKcFLWumIFWJ2sJZzaMncVC+wRoqLhpeDYC3zuOg2RWoqm4C+oSVdkbrBhQvwNHG7qM+iRd3bd/Ci/k8i3Vnq1TqjZBsiTd8iiAEVRbuOdE5s0dqyGRN97hfpxj229YfqEBLdb6QYy1MLaUQRTzXoXfUi6jGDgFp8tRibIqwcAOzrEKQLmJrU6xpxPIkihRxvytcyebDXSGz3n4TAOt66OrhrVFz/hqk/PWWKQy1wPsvVPAeHhw/GPD61lXe28mBRswn11tlXFNRnnjGxcxMjSFD9iXhAnLBS4UsbKgknnII++Wzl9Qm3ZNxgDj4kA95lOzeF0iXEzf6KGIg4GPz3xm19QdwJ9Vx1g6oUQJn0ISeIhqfmPIHIfxesyQVUXbhoRkBPy3jz8+vLSBOKZ2omxJ039qZ8gwrS7ULh9Um1FTcuAfSD4hZ8KBcthg/N60Y9w8pDCvTkP4F6TvTylZSPsJ91usAlF38U+n/wzNNejq50Jp2ZfhyH1SXnls4opGQPzpzaNojYL7GZ9eILJlHcKOfrHgtlbOsWDYPFx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:08:44.8325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486cc0bd-12e7-4e75-a4e8-08dc37b6c171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

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
index e928f2ca0f1e..62d09090b94d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -748,6 +748,8 @@ config XILINX_ZYNQMP_DPDMA
 	  display driver.
 
 # driver files
+source "drivers/dma/amd/Kconfig"
+
 source "drivers/dma/bestcomm/Kconfig"
 
 source "drivers/dma/mediatek/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e408..f2c614fcf2a4 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_ST_FDMA) += st_fdma.o
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


