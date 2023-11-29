Return-Path: <dmaengine+bounces-313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B27FDE0A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DCC282794
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AC3C087;
	Wed, 29 Nov 2023 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bpbqQa3S"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F9BC;
	Wed, 29 Nov 2023 09:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apYvRvRDsSbveylk3N34LLaT0vURY2DfAuk5ULAzCxJMNK6ATckgTxVnbWTL/ccmDHnJ0cEqSEOWAojevCD3JXJbxHU0C2w+LB4zKqqVHTwUdErUZOBwZ9tScKp6qBo239nbaG9GOpXgyn4aXwL7fQfvF160QdSAaJxBQOEl/SN/UFjjvQVDCVwI1yhCsVCSLo/avNUTYcq//WdoxlLvQ838bzP5DZxcr27Uqii9OoWxFCTiZVabTBkEyZiUm/uSEMy432t45hi/chPVXUawZvUNPIbJ9yqj5OAtrEnRWiZnyDmNb6QKiCKe6JlhyDt2waanuVAfTFxjcvl87caAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DSK77jacCVbvjzgTqjCrObEanae/OF9r111c+gWlC8=;
 b=InJYiBEF8wXLs07+Ao2AZ5SU++JT2xaMCKQn1N+zzUgAybKWVQStUJ011GXsHuKmNqrUy0caI1BcRHzkdYpyWYnK31vJdrbuQnw0IJVNnaoYxGarm24B4Nz25jJi6S/yTNr2ZPrNNgSKzGBpEunTXqFgsia+aUf1HKILvZbMatfmQCiUB4mHlIovJPOC+0gzmgcyRkROOjbZ61sfm6vM/QOJpOoCHbkswfdMMcg6EvFHALBPo1aak+jynA6YSPNnNBBX6fnGuT1mUf/B3Pk71JfViNzsaxfYL6IvShEHrXZN8QemFaMORa7MRj9Qu6s0IvmNSjlgnAHMzthP1iNjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DSK77jacCVbvjzgTqjCrObEanae/OF9r111c+gWlC8=;
 b=bpbqQa3SuRrQZiDib7XjmIU4E3T4Wjp/fKonD7KZq8uSd5CBnbjXCxq23DvcGIDee9V5cDemBFMZbkZPRRFw7d1k6ygmprynlCUoOyw3Wc4gmT1YlwEsAxp+OCe/HcmzPh/t0dZAhGsVGXcqXTiOus7jidtGi2NZtfjGUsv9FQI=
Received: from CYZPR14CA0025.namprd14.prod.outlook.com (2603:10b6:930:a0::27)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 17:12:57 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::f0) by CYZPR14CA0025.outlook.office365.com
 (2603:10b6:930:a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 17:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 17:12:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 11:12:55 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 11:12:54 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V7 1/2] dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
Date: Wed, 29 Nov 2023 09:12:19 -0800
Message-ID: <1701277940-25645-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701277940-25645-1-git-send-email-lizhi.hou@amd.com>
References: <1701277940-25645-1-git-send-email-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: d070c8e8-2859-4d51-c7fe-08dbf0fe6eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cfmd+TrLuAX/m5xgjqQhf4LqQKWPihmDboqfVA6sSNktwubE7kBXh/qxcRuBQsmiIj/x6bPZIoJqISREU9ZbTWopqNqHGpEW+8phK53RZkmxgkoXTOUVviPt6nYCG26Jc99WZMEDxEZoyOEnPolhCLy/7iHqKLnNPowoa3zlX+IW2avuWmrMlmT79ZUaWWRjrlCMQrTValQoM3LjdKwIPYsJEsF8caRGoXlEGPsMb4Nm951FQIqRueTl7j/lEuUfobV4yWYLtynX/pk91m6EarFvASAZJBZkR5IUFp0gzWODZt6qz0expEBIxBBx8dsxG0vPqZ9xPtnUYfcT9VC+J8+xaPV8189Lf8TdBd3PKaUNKRCMsEKUgYc1BcYVATa7ckPxQRzzRTmtUX8j0JXnEorFyJI+z/iwUMB/O94tDUw8vgh7nWmbE+TBl28ew1ciT9WH3dFtIrYtNyfAQg+DLIuMEGLKyWLXxJjZ1je+BG1QD/GPC5LJRz+gXrflRUA0Qk7PRQzV03DDvBSGF9DfdQg6UH8yvAna30jyomFgF6XB+ODcOq4c9KQZx8JuL7zlo1Nq6XnGsyGKT3dhnoTYF3baQVn5Z0OfilH2ZPIq3u1TX/JVCLWEOBUo6YFEKkddOJT+8eD6m7Rk7CRZvQ5/EiqtCtWCKjp+3tdIbklKqcw0Bg9NVGuiUQWWKQRm5uQvSpM1/6ySVnBi0M+c7jMEu0OqD50zWfbYi5/RZjEYbnsAfxYY9vleJg0lHjSdcPPmD0TwVzErak8SG6G5lvdkRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(316002)(110136005)(70206006)(54906003)(70586007)(26005)(6666004)(336012)(2616005)(356005)(478600001)(36860700001)(82740400003)(81166007)(86362001)(426003)(36756003)(47076005)(40480700001)(44832011)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:12:57.5465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d070c8e8-2859-4d51-c7fe-08dbf0fe6eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722

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
index 4ccae1a3b884..9ef432fca4d7 100644
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


