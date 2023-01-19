Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B455673EE7
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjASQcl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Jan 2023 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjASQcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Jan 2023 11:32:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46027521D8;
        Thu, 19 Jan 2023 08:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf1esWT+AaO+2bzECjf5mseRHheaUY4FapejGgN6S8FZLCC7yyDLmWJAcnx2J4DzVFLVe92HUAWWpn/w5eSy+vzpmy+ul4F1dADuJQC2yemS3fmVgG+3cwq8EfRe+c+5dRZpgDoZsL6JwAIfPpPJyB0keEB8gL4NoczeuyPIvq2gJSbnzSn3o7TpkiRz1n4EuHuod/+ofAuX3pyd4pLgl/Yyg5DXxGl6q8SrDaa3s2QD6tewu6rbJxlgwrqQUoywyqMf6JcpEtrH+YDaTgJCA/ptRSaTw/SjNGFeLnGbUWwvSN7CECIxNnwxRELViRxQsSCxJl69KNpAlVYDuTWBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=SSvfoVq/29lT6RfUZNM4Hy/eN1+1cg6VAx+m+ndUmFwVbqHZCQrgn9sUYA9O4Y9FNBdcOuEEgOXkmMadRDD+LRubsmEKml0hdESwZiKOhj4W8fpp5n4O+172g4reVezG34AJH0GECOgmlhig6UaeqaYraxXt/rJnhmV6DTnVrJeaPithkl9cubLf9k5smWHZ8txsG5yVhd02rdjGpvefHBMdG6jryRor9BkFXuzGmxXsi/XDEWZGW3jw8bCqDhcQRaXr3Q6blWfaWdhmSu9khbZV+wVTvx7z8fEBjpyAZUmMZZp7U1ooqYKTYOxdVFHXJcRhH0ZSaxgn9BaW0kseMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=Wywb0kWJtMDKIw69OgRH4B89oMC67JvVu5BcE1Nflo62XoXO/9CS1pbhqtm54dwAzN+QxOIxVufZFoWqxrMZ4Pw7VV/K6tiL6RXQ7egOaxi3zL7IsXBvHFIOuKzMT9/vnyVAashN9/J6ULhh30Tblqz4oPuLhEAUpfbb7qYtalE=
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 16:32:23 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::93) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Thu, 19 Jan 2023 16:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Thu, 19 Jan 2023 16:32:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 10:32:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 08:32:22 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Jan 2023 10:32:21 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V12 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Thu, 19 Jan 2023 08:32:06 -0800
Message-ID: <1674145926-29449-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674145926-29449-1-git-send-email-lizhi.hou@amd.com>
References: <1674145926-29449-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|BL0PR12MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b30a43a-74d9-4b80-03fe-08dafa3abe3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDOx13lP3516cigw+4fSi1QOSaE/1a952+ga+mLBhuoiY7zXgwyD1MwZAHZxh29AZKvXWaQmo0DXGp+X2gb7t+jD1vnX6qupcvv/2s/P2cbGBSG/XPqsgkiKj4/jW3Q4C5zmPzq5pBqQ7DZmhlNu3xb6RerwGhOOMcL5VASVdNAEuAC+MUQ54MNurUmPOGs1TsmBkwYuTyuRdqk8cei3cV3QN1lE2S0CLaIZcQgz4LHxxAGtvJI1L5Y3mu7dYxU9CZGFt6QeByyXsw+HqVhhI36CubLPsff69DS3z2ruh5RcYd2nd1mmSac1ZnnRNA4foQ1CKyUx3PQSZQOH4ckNcX8rsrG1x9gWnqeFc8iK7plE8R+KcJ5ceBXVCepG+5XG2tt07r0FGwSStwiLqV18brWdOqZGzzNiVTLBlOadDu49Wleluxv3ZwbNRKYR3b6ude/G8rsKBXN8VxcKmVRt5iEOfkBn1Jc16w3nJDfb+kRk1cbj0zGaHVQFziONJiid2Hp7rlWvbblzATHaNMij8bP/eCxxTl0/9W04bvRO9k33mn/LCsfhKrxZ5t04W031SN8+ApdFyAANzP4kMPqjnF2hg64/FBQ7uqb5HhTw6C8k8RA41CJLEuQCefTBvUPiwnHUzIDUxKE2xN4i2sScMRSwmPCABLe/k5FS7AzbYnOlwZEulAzH3dRi1etk874kvu+7nMotXhWOyjsPcKmOHR3fngfAuP54MzQyJRl1Tks=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(356005)(82740400003)(81166007)(36860700001)(36756003)(40460700003)(47076005)(426003)(40480700001)(82310400005)(2616005)(54906003)(110136005)(86362001)(316002)(44832011)(41300700001)(5660300002)(70586007)(70206006)(8676002)(4326008)(336012)(83380400001)(6666004)(8936002)(478600001)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:32:23.2529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b30a43a-74d9-4b80-03fe-08dafa3abe3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
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
This patch adds APIs to enable/disable user logic interrupt for a given
interrupt wire index.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
Tested-by: Martin Tuma <tumic@gpxsee.org>
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 81 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 98 insertions(+)
 create mode 100644 include/linux/dma/amd_xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d598c4e23901..eaf6590dda19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22583,6 +22583,7 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/xilinx/xdma-regs.h
 F:	drivers/dma/xilinx/xdma.c
+F:	include/linux/dma/amd_xdma.h
 F:	include/linux/platform_data/amd_xdma.h
 
 XILINX ZYNQMP DPDMA DRIVER
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 48efb75ef9b4..462109c61653 100644
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
@@ -687,6 +688,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -729,6 +731,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
 		goto failed_init_c2h;
 	}
 
+	/* config user IRQ registers if needed */
+	user_irq_start = XDMA_CHAN_NUM(xdev);
+	if (xdev->irq_num > user_irq_start) {
+		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
+					  user_irq_start,
+					  xdev->irq_num - user_irq_start);
+		if (ret) {
+			xdma_err(xdev, "failed to set user vectors: %d", ret);
+			goto failed_init_c2h;
+		}
+	}
+
 	/* enable interrupt */
 	ret = regmap_write(xdev->rmap, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
 	if (ret)
@@ -754,6 +768,73 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
 	return chan_info->dir == xdma_chan->dir;
 }
 
+/**
+ * xdma_disable_user_irq - Disable user interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @irq_num: System IRQ number
+ */
+void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 index;
+
+	index = irq_num - xdev->irq_start;
+	if (index < XDMA_CHAN_NUM(xdev) || index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return;
+	}
+	index -= XDMA_CHAN_NUM(xdev);
+
+	regmap_write(xdev->rmap, XDMA_IRQ_USER_INT_EN_W1C, 1 << index);
+}
+EXPORT_SYMBOL(xdma_disable_user_irq);
+
+/**
+ * xdma_enable_user_irq - Enable user logic interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @irq_num: System IRQ number
+ */
+int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 index;
+	int ret;
+
+	index = irq_num - xdev->irq_start;
+	if (index < XDMA_CHAN_NUM(xdev) || index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return -EINVAL;
+	}
+	index -= XDMA_CHAN_NUM(xdev);
+
+	ret = regmap_write(xdev->rmap, XDMA_IRQ_USER_INT_EN_W1S, 1 << index);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(xdma_enable_user_irq);
+
+/**
+ * xdma_get_user_irq - Get system IRQ number
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User logic IRQ wire index
+ *
+ * Return: The system IRQ number allocated for the given wire index.
+ */
+int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+
+	if (XDMA_CHAN_NUM(xdev) + user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return -EINVAL;
+	}
+
+	return xdev->irq_start + XDMA_CHAN_NUM(xdev) + user_irq_index;
+}
+EXPORT_SYMBOL(xdma_get_user_irq);
+
 /**
  * xdma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
new file mode 100644
index 000000000000..ceba69ed7cb4
--- /dev/null
+++ b/include/linux/dma/amd_xdma.h
@@ -0,0 +1,16 @@
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
+int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
+void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
+int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index);
+
+#endif /* _DMAENGINE_AMD_XDMA_H */
-- 
2.27.0

