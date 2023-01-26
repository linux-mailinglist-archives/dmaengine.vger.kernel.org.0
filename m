Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAB67D527
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAZTNF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Jan 2023 14:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAZTND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Jan 2023 14:13:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358446A60;
        Thu, 26 Jan 2023 11:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot1QBH9EbAAV9HSiR0g1m0tp5ZD+kC4aMV2nOTLl1WG/BiIiTToEUfNl0mdysKj8yuo/mLN7A/aUAIONA3IQZNA+cVZlEN8dgMFUZ8rXV2eCstSafk14O+OgtiSIU4T8uCG6+NbeepNG0IxgmyZ0evPFFmfg2UIl8NY3VMacjpCRKrdT8H8/+qcTgL5aNNg55CA5dw8aQM9kbhDI0hWoByguo1w920lR2TEvky14ipCYGFtXEn4sVaJbM77Mj30sV1PF7SlTMAylUE2IrzfxJDwff77Y0681vJTztqdnrzpcTZQuDwXOYa7RItmMmquCFKNsooZKcsvEu2nATa3lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=Wz76rDI5uOSzWSm+3FR66FGA4I8tsjr+pn0iHnPtmP/hYDLMzc05fPqYflPY4/1s3Bn8AFfXMJH6NP6pGo3i4gfmJc+g5b+zlVQRHNlt7JILOfh6bFF2RrcoEN3nZ9pEfypykVDSNmjZbyt0rJ2jtfCnsY/9DqhihL7IV1SdL1JNy3UtkOZAKbs7A47fblJHYSajrtafqK8kYCr/YZPK3w2XuIcE7NWHiFUupznANrtxXIB/CvQ3WTmdKqnAxpAseOTjJDD/7q/VvoMS1QB5sF6sgzG6MGmOWVTLy9+ySDVAj5EdazwOKeEmF8OkY8GRvJNuTI9iGw93bIcRzAosbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H09tGKyQXMqI0MRj5s0yXOQclDD20NlbGcWEfay9KTA=;
 b=ovH2Xt/GTALvad6IbXVfq3WR8xFLHqTMw8KelwtR4tTtM2+7LUVIABswRlnVDDcRLyQR1qQUnouQgD7iApBp7xNpwGjpXO1WMWvirFm4uXSZ/YUc3jsoiYvrORl++fFdGs9xXbHCjU/xyduKaIbyOnpJJ5xHJPIJINcT/YzbEKQ=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21; Thu, 26 Jan 2023 19:13:00 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::f) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 19:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 26 Jan 2023 19:13:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 13:12:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 11:12:59 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 13:12:58 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V12 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Thu, 26 Jan 2023 11:12:55 -0800
Message-ID: <1674760375-72911-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674760375-72911-1-git-send-email-lizhi.hou@amd.com>
References: <1674760375-72911-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e65b41-8ddd-4594-c145-08daffd1573d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8LGczW03xnehbqm7HUYjxpAQx1iaak0p2GDjwkMqpG12btgtaXhk0inSGTpJSFpDdYAnI9fAjZF7OvArY7IiqK+z/GLD4TGIodxWlzViPVLI60Vp9mhbAp7ihY/jnNAEIL1Mwe4o+iFUMtQAnlA3vMBpj7xmgD0C6GyydZV3kJB4R4bs1LSoV99/9sIO9uyaiUK+6XepOsyX2eXFA3JXjEAoGCjyYfbGiqCf5TIupqDQyBAbvxoAIn6YcIM/VO/xv6SHqQkheLAbM4ka/RS/DqcoVu6w5kl1oYujYky9lCUDgkDLtbuFmEaldPCMg+QqbnRF/mySYoapVFhKbDaU+fYZMYApEjHCLJkqFHeVB1KVfx+0DHgjpTGN+vkMquuzLELlCCZLZ+0bvs6Us2+ba2RoFF/y0qrqaJdhvsP2qTcTOHmUrRwsx26vSL3dYmU3gifn7rNqCVHHcZUsz/G+v58yYmo+VAslvUd1yq5e+2Ku+75PBTxDYHatLVzybmyn1+uPIRyz719r0fKPV2nyUT3tPcWyi4Violudj66mm206LgBh68HzI5IMe6D1zldOdfA3NDrupuulBQBWRH6yCRscvyRNki8iAKEeRajimcQoojsLdwzSJAYaqwSR6hFbvN1TpcDsPdq9Z6e8gdvONNgdEhH72T7fe+0gOembSiuSU9JyLEDFTU3A+s6SbMjcqzeYxW+30D+uS4aiihZlNq+gXnFtHlJcnmBs8Uom4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(47076005)(44832011)(82310400005)(86362001)(40460700003)(40480700001)(81166007)(36756003)(356005)(36860700001)(54906003)(82740400003)(110136005)(2906002)(41300700001)(8936002)(70206006)(8676002)(4326008)(70586007)(186003)(5660300002)(2616005)(316002)(26005)(426003)(83380400001)(478600001)(6666004)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:13:00.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e65b41-8ddd-4594-c145-08daffd1573d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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

