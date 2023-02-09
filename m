Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8766910EC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Feb 2023 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBITFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBITF2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 14:05:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB746A31D;
        Thu,  9 Feb 2023 11:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFr0p+D1/MWkuiqMyHx2d9ulpgjgg95A6lDvmGxGo82eGVVARU5/KvK0lUCcH8MhQ858Fru8+osUjgK+2DcDrK539yBvmoyfVpwbe22hyvMr9SmyNl4vWD6d3Ck0t10sBOw+gWKa7zTBkSVamhXQPBed/wQUc/d3n/d7dsDKxUzz1rs7t14HYTSwYQmwHoBR2w4O3SxF5peOSElj06UDx/SCyj6hIllC5RmrDr5yG0RXOTMPzgZaVj1YIDPLNcYRu2QlVZI7htWSzxvu5gp5VbIC1cmB2P9WSDnP/zcy5LOygwshZl0BZVgTFu+WbvwuIsnRwkZIdcb6fYBm+d0oUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=Ckq+M0ke/7o1XvWJXQ+Gu4ERcegV9nec3qDxIR6fRnQYKgQO4YsVwJfnGzV6WowZLJPJBNNzhf19citpjuDtig8/dHYf+lwUt95nUbfAn9DqwbOL1vKhahO4hOPDPGczNN1nqMi64JP18cH/BfHyZFSg4hFHvqXUFcxl+SxSMxuYVRNvKfgPdhC6E5YZ1TNSExCZCZtdC2YzNOkn5K7qyXhioo7c8yslAEmSo8Ky1yErgfqhAiEiYtUo6VtOKdGUSRjyINr9aC2rfE1kNdh1JZouS1q289Yop2eZljaAKLLwrYOHmBwUEKqYep+qmUBbsNudbMK/NleNOCNS1a2chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=E9uXlfmoEPi9zOXZird+mghtOru91NF6ni5YvvfC3bJVYOi3krdzj1c1CTXj+r5LRit74EvC7CJcGQSXYQ66tymfh2BhSqJwWbgIlekodbvDhcvlmudtokE3fTg3I4psdS9eyuaW5rV5UcP6kpiKL5meTrbC4+h8TgLjsLS1jlI=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 19:05:25 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::2a) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 19:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 19:05:24 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 13:05:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 11:05:19 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 9 Feb 2023 13:05:18 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V12 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Thu, 9 Feb 2023 11:05:14 -0800
Message-ID: <1675969514-3137-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c47b5b-19a4-4398-5d55-08db0ad099a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RUrv84Nu6OocPb293Rof93lE+2px+FQBmOswfiUv6TYIZ5SgFTfqjdg4cEYajm/tbPkDdhOpJN2HJ0GAhl4JkOAsm4aERG/m3qglLOIVR5ZRi0Anrc7unts9xctOZqd5As6kvCcCJ5TNfILGg4C/0AqlAAWU4/bPhqHUg8vO6vNzc5YO2L4uUr3KBVwy9bIWuIdnhxVmVjEVRVql0GmL26fbtf6SDSoLhzAYGvwf9w7y/HpPj21pNDOckNODBuAT5khgFToQRxWzWI8sJXKRgIIBJ2uk9Lcqs9SlDAstZS1+pRVS240vpDVEFekoygySQ6e1irq4T2BFCYHi/NTg5AxsBm0VBbLr5uZJasRzla9t7mo0BuJm9cC07EUogLbIduQfFaULqOQppEzvKlOoujXUwcrzB/gYG21nWXY/ZrFayu0ekEWTWN0XCWBg0yMUqxZKWm/17LH8Bf9rU3NWUzac5ZtcG/0KGkmpBdsSQVuQ2IPRyJC6rOZeKT9qrDNS6ffRPGIH+E+NDX6Wr5iflxzr+x1JVp84z7nBi5d7mB23e5DSw5bEgEZByB6KkAgS6U23y61Zvvn4S+jSX8/6IQwWkzLGIKZ5545xedXFEnPwbnI3cjy1mHDCgQVoHNVtLc4+/esGCNQfhE4ELBGN1QZ/+gjKyWeq/JFqvMNanNvqEEjrYn1AKZuTEasrvPw7rSMe40B3o2aNDwJruqQHdXfFzvyDLAvoz9nUFIauGo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(86362001)(2906002)(8936002)(41300700001)(8676002)(40480700001)(70206006)(4326008)(426003)(70586007)(36756003)(83380400001)(336012)(47076005)(6666004)(40460700003)(26005)(478600001)(186003)(2616005)(110136005)(81166007)(316002)(36860700001)(54906003)(82740400003)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:05:24.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c47b5b-19a4-4398-5d55-08db0ad099a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

