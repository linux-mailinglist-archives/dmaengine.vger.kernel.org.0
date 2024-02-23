Return-Path: <dmaengine+bounces-1102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99825861889
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4596B2855FE
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A012A140;
	Fri, 23 Feb 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aanajylp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D96FB9;
	Fri, 23 Feb 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707427; cv=fail; b=NuP8bJvZykfEVQ8yiJb+viuBYPyojItcd3UbC5kx3wRwVZSacUeN2KJUqXwzS25YmqIQlKgk2+8q7iAYY9t0KiGp1ToCv6Ab+mht4L2/zPgcYtQBM+wkq2jkIQ0AueTGWFxZp3miHTwIrxMdOcgaQrZsC22mGiinkKEXm0w9HWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707427; c=relaxed/simple;
	bh=MMlb3tlbSzGgwjCVRGv0FGQicfCziARvVNBd8Vfp4S8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4mflQH+D/2cG+4dPbdLGsENY8RqRCLhtBenXzAptQAJK/f0g6cl+WNn/m2qOhJNUuIoXIqhfiGtxXCS/RMOESokvqLseTTPIJGexdlkR6J9XIk+je8xjEGlf2wNcMxO8zz1uNXiodhiDT4Y3lez0Vb74MLdmxOD7M9GNOI15Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aanajylp; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXIPKWzLjFsZ0DZO4pbQpNwcXr5OiSq+dSIHLaisHq59V1Tlq3a3atFOdBBvG4ooiNaSBaLNF1wT4C7k3D4tirtpSzBMa+R9iMqmhDHwHZ9EHw4Pxx5GkDeleKHUrVH2ZBEWZIn9FLN64zJtetYnQaSQX7uVqZpQEPuMbVEoi1yykhCNDa33ezn23Z6YCevsEL0osyYVVV19evWcsYV4rqxNcvmPC3v+dSUFCGPMuhIHheF3CaLrNMaqDXUDVHubE2oqynq/jnGa5HrGZjntWugPYyAd56wwNW+JrWgekw2643U4Rg6GnO5BSV7BAUpgbpcjiqlVsRdO6dSEAl1OpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36tiSFvd6sblovW4Y+Xuy3DuxH+SQ9VT6wL8YppCBQk=;
 b=LCXbZoXc0rOJlpIxt93HLwGCc3eITIahP5HYXsYYV6p5KFvO8IablY0cE4Y2xIdMB7Wuu/MsnIhZPTZA6+hJKvrcAr0hgrQvgMzuyFZ9e5UQAioHhZUN868zmw2f374SRIKO52njVs0ulpIxSAuzBThLq3mZKvGUQk2LVWLsCnq3pKoY2qUMigZTmj3vVVNHbbWnV6TfP2YZPa28SC2nwBoQ/7F+6vOBrDwQQBs7N63ftuG8N5wJItGrn9od7hnHKwHAs0bjQ6fEnqnguRNzGGuym1aVxU7jceuhMdy8Kh+obaXcyqU4lDHOXyNI57pniJc75dFcLJc7KcsaWfNM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36tiSFvd6sblovW4Y+Xuy3DuxH+SQ9VT6wL8YppCBQk=;
 b=aanajylpqkKMXiDXdE5t0gl/rs0IhTQsaAT/UvdQtgzHUb5qVYvx1eL7cIF4CHN/br80fEtP4KL+6YFAj1tBQKnWyBhdEkxJPDGAQM4BpY0ZluwzBK7d5/VYHhQh2m/wvwJ9RAfnD3TuZkWYU+Zr8qx8c1AzZAvRV08/XbgUEhI=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 16:57:03 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::67) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42 via Frontend
 Transport; Fri, 23 Feb 2024 16:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 16:57:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 10:57:01 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 10:57:01 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V8 1/2] dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
Date: Fri, 23 Feb 2024 08:56:42 -0800
Message-ID: <1708707403-47386-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
References: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: e73dc93b-7e17-485c-bef1-08dc3490755b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cz74AQrL1SOLfrrXy5EtEaoEiASEdDmVAj23mpRtNn/zhbrTlsEwexoUn1B8TagK193CykLg+mUZbKci9/4Yrj0s/EtrbpxPw1HOcH8aO8E0+6P3NTbjLB9nTbVV/V5tvWKaMegLjRBb8Nc8LtDVGr1AezxbHugYzPR7PFQ4a5jgB18D87q/dCDyZBoFbbtbLODaDEk+9jQeKqZmBXwpFcutWN1Q7TQdmAsA3clt6kPvadREmrbve3GLnsfFAd7bZzDwjvnBAcMM5Nhszzzwfuj8Ne1HB4cOin0tvmP9WHBObF/+OlV5Hq6Hr3XCWUImL0K+SRZ8Xcx9Qx1K0rp7iwfZCirIXSckWQGgCYCM17/SsgATjHOzIc5omBAT5PB33mgTB2Moo/Vg32aZanm8ojn1GMbhhTHFOAhh/rFFHRwlYinlG0o1PMi7crSEhaKtqclsiZV4LY7MRfVc57O2huktfiYi+L2ttgFhFnWw1b2W0qV9fJ0pMmkrZ+zH7oHunXd1y4zj7QF9zvDiyoS+I46UIzPy3SicM3TzPSMSRDbY0HXPjoetTrslb5rU7x13PSzlrzm+H3x/iwzUuGqHgp3O44qsNZMcwajBY/NOaQ1xZewR0OtYtWPVLba2HuU6Wwco6pQWcTeSkSbXQErk/4/6Vjzr8TNVDjndzPBeTnU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:57:02.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73dc93b-7e17-485c-bef1-08dc3490755b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215

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


