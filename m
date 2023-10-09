Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACD37BE954
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbjJISbR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377927AbjJISbQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 14:31:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E6DA;
        Mon,  9 Oct 2023 11:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuSsjhFCwqQNm2J6kHWjKDEVlJIBIun33aM7sWuYfL/wFb1B/HotgyR7MLf1XjIPbdGWUQWuoBVW7//CSjqGEoqg5V9q+pTUmXrFYO55iGjh0bqvzE9xQRhofwEPq0OPoPjDkuFMzoesGfdXX9BxDVDjJZ9TqZ3iL28VvgGL9dE+9b5R8dI3Y6kHlymxtbCfzZpGXe5bxL9+k1z7WXWeZLFUzNWbcdAL84BON4SgUHQ6mIPbsL5um7++An8YCFxbqQ4n8jFVCmeCx60Wvh4PF+ClMq5MkHLk84Bpuo7idUzcfigNTtmL4ke7LzPUUsOuftkcWRhY3jYzlT0YxfN4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DSK77jacCVbvjzgTqjCrObEanae/OF9r111c+gWlC8=;
 b=k9CHcM8nMS8BrGnf5rVtdUHf+DJMA+bniSdyHRAWyvi+6cHy7t/hTeJndSg7YtWQEjgWKzthgs0l64GX0qEaKu4Zvgxv1kK4ML+nCYokqVtHo/8e/Wei6CGfeJ7IS+4FKVfIGLOnXho28At476BoBp8t9Aut4xJBg2CSbm1ITQbpmwn9+53ABmD431TffJAUvJ2JaUdjYwe+KvGaqDCwjQyuKWCb3oiYMTZ+ParcPsvG2TUh6xajzbiQVIXYcTCK6dUhAN9v9my1ralp97JoaXiR1Pdn9omMktO5FG6KI09Soxd0JZR8Xi3GLVGJavRfZCXE8WSPQblPrKgvsZ+82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DSK77jacCVbvjzgTqjCrObEanae/OF9r111c+gWlC8=;
 b=Ph8OAlYyLRZjaiowhvbtrVXhOebKyX8pg8DGZ0ZhFCMVIDDgTcY0eQVH3KVxkBEB7HvGZ0GvNKPaDlNnkww4oWmhjPiT+FRFWw+vO3nwF0MZA4s3DIxJtNY4JL4KpTp1nB+FJa83YVyu1N2S26C9+mI2/GdyP/ffSnr0Il2nOjA=
Received: from MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 18:31:09 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::f0) by MN2PR11CA0010.outlook.office365.com
 (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 18:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:31:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:30:32 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 9 Oct 2023 13:30:28 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V7 1/2] dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
Date:   Mon, 9 Oct 2023 11:21:33 -0700
Message-ID: <1696875694-18245-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696875694-18245-1-git-send-email-lizhi.hou@amd.com>
References: <1696875694-18245-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 20496bd9-3b58-4bce-89c8-08dbc8f5e869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TC+TJO6XwXoXffIdAYal+RKD1fQGFUcT5juMYdYdY52tn3Mt5ZFMm/nptzr9ewj/3LDOC9z5MEm2umPz4pTk7+IyZXKkMKNYpuNHQNkOgep1oRF8O1ODNy97E1RZLhfCBE8gR39TaoS+fO1+8g/3aD9mzKtQRxAo/qNaNHuuTDSOEgrYRLUA0PyF4k90D51Y1Qov4hLbVKiWmkt9OfIHUwLl9EDeTCJ4ve3uBD73Hb9rhH8ly7Su9tD2deiS1fToxIf2kLIpu17zbS/zb/CdIS16CSdZK7t2fLAGq9/aFfYmjjhe3Gd0chFNPQwKTpZg1EPmpjC+kxLgEFXA2FL1thu9zHDruNEeBjbqLRLU6zWupzx87Ww9GxXf8aAOdXXG+z74vk3iAnmEuxq23IDgw/x7HoQLBx6b/qwLutsIinXJpfFwa45SV/YvMpQQlmxKXcm+UcRGJwPezG96QpH24UQDzoPpTXqi3jx9zA6CqVlJmYIzR+sDkoSKEHMXD8b9XIsZ5uO9uQOGj1XHGgfShbfVIqncGRuuYtMilcOdDpTk9SrPjuKjMmTJU/FAvtIkrIXF4SNAQ4c/JETsrqjaWHEQjWziKbkZE3dUmPm3kpw9ME7kWDT1/qUQez7y2fKq2Cd+8Xx6+c3voL3QeqYR5TDC4W56xkQSB1GkAJrggwjSfrwMQmJKc96U0VIRo7JUEk2eem6m8nCy972Tzry1UxT6exBLiXaN/foaCW4ZJl6I1J8yBBQI4Co/Wm/ws8MvsFSqDHcaLhZmP8yxU8exMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(86362001)(36756003)(81166007)(82740400003)(40480700001)(2906002)(478600001)(41300700001)(8676002)(4326008)(5660300002)(44832011)(8936002)(6666004)(336012)(2616005)(426003)(40460700003)(316002)(110136005)(54906003)(70206006)(26005)(70586007)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:31:09.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20496bd9-3b58-4bce-89c8-08dbc8f5e869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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

