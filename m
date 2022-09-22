Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276C5E6B18
	for <lists+dmaengine@lfdr.de>; Thu, 22 Sep 2022 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiIVSiv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIVSiu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 14:38:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD4D2D74;
        Thu, 22 Sep 2022 11:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW5YAsIwezGNJKnRImBTB3eY4RzL4/UDxEYtpoEsy/0gQF8OOxcWqtEWbn9+U9MJwVSuK/Plp9x6r610Djufyk7ZwFX2Psu0D6kQznd/CE864PH2Ub4q2DQ49Z0CN6+tPDNooKci+/DtBdjL3hh7SCbzscvyCxvg1n0X4xkL7WGeajTmihb9xy/tKHC231mO4b/qDFxWBOEIvM49kDJKV5pVMlBUXJqfWnsjDBnjCTtKNQqJ2MkqQD4ZfP0MzrBQO6yKx3L5ZrUAeQZ/TiflgBFaogQcj40SmK503+fD5no96oVsilG5XFt8fBh/NeUeJJ/p34vupiLOSPJ7uBGjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUZKBYS/d9bnueBRAku/Gf6poZ/NiG6fuztiexh4NEI=;
 b=Pv0faWE4GG1AtE5DctEDR06JVXfmZ+1bi/BcbeN+fZzV2CI4lL/0p8xGONyhzz58fXFJuY1P/T2vfPtTuJ0I4z5nr0QzXThQXkVkkfN4VGLrZFHLRCbkgQSMrDJ6bC3eiP0NyCMfBUtxwfp3RArL04r+My3Qv09lTWaSJdMVEfbEpQkJqNszz7dSFaBQCevu4gxQkBx+VtmGOMupORbq5T7jrEWiKpYBMrL/id+95sUtgUUErnBsN7q7g9t2LKFxrBTe1wN905YJujlSJeKvRljH+Ude7Ad0AggQ+SyshYrTKswGpefApDoBhrOAG5ta08nqdBvqW2kkhKb89PAVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUZKBYS/d9bnueBRAku/Gf6poZ/NiG6fuztiexh4NEI=;
 b=YAJktoCfSaqh9pUWrRdMdHnH+KT+kazd+x3fSVQ2fHNUwsuIiUVOOG6SgThvfLE6x+499ChnlfchWqPQOWAhR2lHUzkHpA4QpbXvNTJuf0tRvRsAiTC7toYaswgf+fofINniwOuPzwTwOJvdJ0tPlMBc4yBqhxbVq1bbydDWOzQ=
Received: from DS7PR03CA0286.namprd03.prod.outlook.com (2603:10b6:5:3ad::21)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 18:38:41 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::57) by DS7PR03CA0286.outlook.office365.com
 (2603:10b6:5:3ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 18:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 18:38:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 13:38:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 13:38:40 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 22 Sep 2022 13:38:39 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Thu, 22 Sep 2022 11:38:25 -0700
Message-ID: <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 98da87f0-b12e-4f1c-67c7-08da9cc9abbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjtQmLNnmGnV8cZ5HBvu+Acv6hyMPbINOknd4mqhkD/pRUd2Q1d1I80Lb/bBz0Cii0s6puY1UZRepkP3qwhGsQD7TwJ5tcnJGbe8Sp69UCONMpyRzaYg2cNhUR8+8DQhK4T14QkN1vwY/PK0Onmjxc3iSUOtDwyl9d/eUoVOZMc4HszQPNlpa5/GI88EZTIrmtzcO5iI/YPS2oiovt2ZPJZv7do/L/x6/lyAkpv/D+oz4nFBSFUVoDiCsniJk+IKnbnjEcaazWTZ7pTSPV2f2sBeN4vXk0M/VlqZ2qxVwpyyY3jW1xigt4gTUrsCQvbbASAvrdnLvCk5r7U8iXt2xr+fcLjNH4DHcw4hZLW1xc1Gg9i06ULW9pYMXlYk+T7SFSQ4dPudAYGjQx+x5PorYoKP3ebI47C82h1epdj/RQYXS271qCfoPvuyw/hEvwpCMz8yC2FHIvnjGwXxKoVGtHgl1nCTUgT3KxqBn4khhP6mXTfbm8TjMxKfo7fDGPPzoJ6t12vPkwVTCPjXTc4K0ewUG+I5oHHJJfgCeltyL8bNX7fb8pZIPYkGBW01BjlD6aLnVdBWFiE8lbXD2+qzkL61VTeZNwH+/IW3bERqD6X9gJ6fHuocoRlDCt3Cp3kGkibOO70pQ3q+uQaXUbCRfcqAsMPxAxhIRAGES0LyM7mHp0g+zx2T8CJO0FT9+OBBGXGN3gSRT8X+5pVLC55Mmy2iASnAKgNO0EDoj/wYMoZ2cERgxV8JsXYALxYBfJLL4vYOeQFXwEHL5kKVTWk568CqczdhgPTS4RsXa/AJ36Tv48CySY04aNahryoqlvn3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(186003)(47076005)(2616005)(336012)(426003)(2906002)(36756003)(8676002)(4326008)(5660300002)(6666004)(44832011)(26005)(41300700001)(82740400003)(8936002)(356005)(81166007)(86362001)(82310400005)(83380400001)(36860700001)(40480700001)(40460700003)(316002)(110136005)(54906003)(478600001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:38:40.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98da87f0-b12e-4f1c-67c7-08da9cc9abbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
interrupt wires to user logic that generate interrupts to the host.
This patch adds APIs to register/unregister interrupt handler for a given
interrupt wire index.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 80 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 17 ++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 include/linux/dma/amd_xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c1be0b2e378a..019d84b2b086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21691,6 +21691,7 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/xilinx/xdma-regs.h
 F:	drivers/dma/xilinx/xdma.c
+F:	include/linux/dma/amd_xdma.h
 F:	include/linux/platform_data/amd_xdma.h
 
 XILINX ZYNQMP DPDMA DRIVER
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 58a57e03bef5..884942cd2a37 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -25,6 +25,7 @@
 #include <linux/dmapool.h>
 #include <linux/regmap.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/amd_xdma.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/amd_xdma.h>
 #include <linux/dma-mapping.h>
@@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
 		goto failed;
 	}
 
+	/* config user IRQ registers if needed */
+	user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
+	if (xdev->irq_num > user_irq_start) {
+		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
+					  user_irq_start,
+					  xdev->irq_num - user_irq_start);
+		if (ret) {
+			xdma_err(xdev, "failed to set user vectors: %d", ret);
+			goto failed;
+		}
+	}
+
 	/* enable interrupt */
 	ret = xdma_enable_intr(xdev);
 	if (ret) {
@@ -816,6 +830,72 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
 	return true;
 }
 
+/**
+ * xdma_free_user_irq - Free user interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User IRQ index
+ * @arg: User interrupt cookie
+ */
+void xdma_free_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			void *arg)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 user_irq;
+
+	user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index;
+	if (user_irq >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return;
+	}
+	user_irq += xdev->irq_start;
+
+	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
+		       (1 << user_irq_index));
+
+	free_irq(user_irq, arg);
+}
+EXPORT_SYMBOL(xdma_free_user_irq);
+
+/**
+ * xdma_request_user_irq - Register user interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User IRQ index
+ * @flags: Handling flags
+ * @handler: User interrupt handler
+ * @arg: User interrupt cookie
+ */
+int xdma_request_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			  irq_handler_t handler, void *arg, ulong flags)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 user_irq;
+	int ret;
+
+	user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index;
+	if (user_irq >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return -EINVAL;
+	}
+	user_irq += xdev->irq_start;
+
+	ret = request_irq(user_irq, handler, flags, "xdma-user", arg);
+	if (ret) {
+		xdma_err(xdev, "request irq failed, %d", ret);
+		return ret;
+	}
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
+			     (1 << user_irq_index));
+	if (ret) {
+		xdma_err(xdev, "set user irq mask failed, %d", ret);
+		free_irq(user_irq, arg);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(xdma_request_user_irq);
+
 /**
  * xdma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
new file mode 100644
index 000000000000..b70486121ca6
--- /dev/null
+++ b/include/linux/dma/amd_xdma.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _DMAENGINE_AMD_XDMA_H
+#define _DMAENGINE_AMD_XDMA_H
+
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+int xdma_request_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			  irq_handler_t handler, void *arg, ulong flags);
+void xdma_free_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			void *arg);
+
+#endif /* _DMAENGINE_AMD_XDMA_H */
-- 
2.27.0

