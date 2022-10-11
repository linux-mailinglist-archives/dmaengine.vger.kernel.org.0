Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538005FB781
	for <lists+dmaengine@lfdr.de>; Tue, 11 Oct 2022 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJKPmO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Oct 2022 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJKPlk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Oct 2022 11:41:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1A537F0;
        Tue, 11 Oct 2022 08:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGBSCEPsPNfuoPBLuxmvizsKYa0O6/MgvPS8mETzvzmsiT2jUJpvHHdxAknEx0ByOHb66IvzvA/pDXHM5Y+OwY9zVM22jbJqbbCXPTW/RfpUoRrxc6ZCn7cfjky39+tR5CudkcBczNw+E8Jzqg2KnezOToDqg2VWDeFoov6R2PPbnlMPJz2fCnxTvPnyeCwD97HLJQE6scJKa4XZ/he48zPKFBlbMPv4F1dT6may4dPBJV3QFTUQ+fJWFZ4djhokvj2kbpiMnGpbwHJWGUT5x9mZLdmOMRbA1eoTu1PVV4YLbFxhTNMPC2MpoHpRlvWBEcuZTRbJrLG6uWxx7P60NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbsfG+QTPTMp0BsgpWz+VmPMZJolGaSG03J8w5wDJgY=;
 b=FZFISpoVXtw0x9STlDK0y8vFBEUaZjO53TLfaVv1kZ+pjSw6aI6Bk9SURMrREWQxX9bZuNPa3WUY8hLSdiRAVE84vezNWPdtAISUdRuhRLDjCzcwyssnGjIGmseW3QBuxw9rvHuK+IZdRgj6ablkvt1Fm1oHfY999YZNbQ1DjbaBmp6T/9MpcXJq1imyZ7unh3WDN4f2rqA83bJZzJuYSfTp+i5t95wn7fvW07UcVPwTO/xfZW8ch8cFUvFAIW/rqxCMzauk2+5gZaLLPIQ/k9jbBZYIiX93PwnF0ONcT8xxOzXGqB0u206nP5cwr8xrPK4kVUmpAqiIGy59MRutKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbsfG+QTPTMp0BsgpWz+VmPMZJolGaSG03J8w5wDJgY=;
 b=mnNrkz/IoLGF9JksynnFMIHvdOG9X94Y7Usd0jfhzkPb6e1vkNJZO6Emlbf9xSvY4nxB+zVMM169yNp2B1mvT1Di6OG5MZ4uQlDWrIVKuj/5jwbFo8JSwlmmlE22qm09/+eXxVGdldVKlUM7866Ck03+75VeP954+35s00ug2bE=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 15:31:08 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::cd) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.15 via Frontend
 Transport; Tue, 11 Oct 2022 15:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 15:31:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 10:31:08 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 10:31:07 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V7 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Tue, 11 Oct 2022 08:31:02 -0700
Message-ID: <1665502262-4246-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665502262-4246-1-git-send-email-lizhi.hou@amd.com>
References: <1665502262-4246-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: acf27c71-991d-4fb1-6885-08daab9d9ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw1uos0FPkDln+bjdezrXLwvSSwEADaXO7fMyOwkzQsRhQKFy1tDKhI8cBV/P1JLIWmaiQ5YfYS6Q/91KRW7pe1ZWCFAio0juzIU8Lynjnek96SY8ztVGZ3REJuMNYE9XV7Y3lDo0cEjBzGsjibzkYMtl41OrSiiEjL0WRv41+G9bab06gCB3si7QjIWllUq49bLAVMPkSQOAqg3z/5qGFRoJwj7zi+ggY3XyPaAiPJ4dpQCXiX5bqfYveYexkjtAot5iVMLRQLR8TveKyt8omz1McN8qNmsEnaPUzPxgl5cUtJObhw8X7F7jdwbB1UpeUeKCav/K6BofCnnQR0YDGKqiEKDPYtYA/WkrIWG8tMt4IGMHSurzuS0CiOme2YP9fVhpMlxHn2UQ8LoMdIX6LVQ1Jb7VSMKDG4dC+Y3v2lQLSkq5dFNta7x54wWdUz6PzVxyZ9Wu/MJ3ACW/kpBIvEKI38VTTBRLA46NDVnorTZ6n940FzC+bCKl4cfHwKIvk/jw9wAyTBCA3lnli73Zlqiyp2JY5+TdkAMbImZYEVOQw5tP9IYIkUzeFcQ4g4FcKX+iET0mv2rNEZKDxJDwqCKteCbK5QYVYXRJ/ev3LtSYZuO+LFOURCsDr3obpcxIIdFyaKKaUkIGwjqGvmWvlQwK1K/ilUWCdYtNcBGiLxIFDJ5MAJb1oGi+tQYNLx5+AwkaOjwOZ+C89JcNja6EUG1n0waamhVAeuls3ZPGdYXxKsTb2UJYHhsd8mQo8Fbp2WVBXTXqSEpDKv4p/RyVYgQD1Bqpqk1oKceAhHniEiqpD8+VYSJeLM0cgvakEUB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(356005)(336012)(81166007)(83380400001)(186003)(426003)(82740400003)(36860700001)(82310400005)(47076005)(44832011)(2616005)(26005)(2906002)(41300700001)(54906003)(8676002)(40460700003)(40480700001)(8936002)(6666004)(110136005)(4326008)(478600001)(70586007)(70206006)(5660300002)(316002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:31:08.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf27c71-991d-4fb1-6885-08daab9d9ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 87 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 104 insertions(+)
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
index c78871f821d3..ed2715ab2ed9 100644
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
@@ -739,6 +740,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -781,6 +783,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
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
 	ret = xdma_enable_intr(xdev);
 	if (ret) {
@@ -808,6 +822,79 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
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
+	u32 user_irq_index;
+
+	user_irq_index = irq_num - xdev->irq_start;
+	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
+	    user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return;
+	}
+	user_irq_index -= XDMA_CHAN_NUM(xdev);
+
+	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
+		       (1 << user_irq_index));
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
+	u32 user_irq_index;
+	int ret;
+
+	user_irq_index = irq_num - xdev->irq_start;
+	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
+	    user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return -EINVAL;
+	}
+	user_irq_index -= XDMA_CHAN_NUM(xdev);
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
+			     (1 << user_irq_index));
+	if (ret) {
+		xdma_err(xdev, "set user irq mask failed, %d", ret);
+		return ret;
+	}
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

