Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1323460D2DC
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiJYR5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiJYR5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 13:57:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51817F682B;
        Tue, 25 Oct 2022 10:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ2s1BDmaZDSrOgvvyJu3rFZdfc0GlhvjAVkklAL+U2iAW8IwBNC37rIbmj2/jE99beRZsrVWArSRvynNOCgwZ9o9SK9QZ4z/lU5NppjpmnO+Rw4OiC4ZVu3c3FesQKjc3H9OoNKmMpIc43aJTkV7OcIlvrrwPnAFMhfDnwKy6OhsWg843Q3wS5yQbR7qk/JCQkVAEzC4/m/n3001VuPsNskW6Tg/ikolP3aqQzr7GbNo6sYFZgTuszW+eC+0UVI+qYnJiIa+T38c6jMdJtfeI4WdYrMKzG/Kfw6UStVnKLwEn+oJ81+sv8Jq8VpxUUyJq11sWGPhWu1GsLiGAVT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=664N7wOuvn6e+bqMG60UPws27P8KgZSZf/gw02vHhXk=;
 b=AX5RbwYZvlHAaYxLgUGP0an8YsJczauY3qhStrQF1vgFU3YcvYrSb7wPPff8H8XanA8oN02wohien05S4zoB0E/g0DT6F8eGdN/T5ADoF3V+J8RkVtaFPz3757G7E8r7aVv1keDCbNgeOO6G7cFSBEbxIqA1MKx0VHiJUDbw8SE35TtJnEum4m/lPp/jPJ9lAQdtsWSzD6LNEiNWRf0NgJHTC7qRVRJCU2rQNuijZrVuy1pe2Hsb7MCJnfsWAxuFN4DzmJVkiuVblzv7FCrFO6CMXpr6ESEGC0c4mtDU75Z2QjS+X7PeoNYeJdRystVxyLlbCKjZUxFdmGFqvtRifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=664N7wOuvn6e+bqMG60UPws27P8KgZSZf/gw02vHhXk=;
 b=VxSeQZgJhP7V3VEsBMmgngkzOVVi0QeaqRjEU+nBhHD+VByQhs01VTuLolTV0nhj9r/boTH4jpI0As2zYu1jfiJLvR5O1H7wsCb15r8B/KVJlFxKG4Du+LT4nJFexA4NGJTWvKgPt7KDwRk3BjY+dz4FDig+Exz8r/mQgQXFS1E=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 17:57:46 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::2d) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 17:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 17:57:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:57:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:57:45 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 12:57:44 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V9 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Tue, 25 Oct 2022 10:57:18 -0700
Message-ID: <1666720638-33496-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
References: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: cfccd302-3e62-4d3c-e82a-08dab6b26c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vH/owQfOKn8DIs3qMo5pQUwiHvJRviJ4oRoDIIm8o2WEOeiWEQrKr2NPfhmWUPQHxXSr02egR1TPVg5S5RJigXxB7t/P9+oXi+e8hadLkj9IzPJ/SnnYhmWkanjz7p0wiQmnIdEDNfstNg89Gf6y/OuvS5nBKavoP9YFYQb7G8bJEWuLy7J2/Ybs7KjLJB+r+0SHbZDltbHQky3FJuZDcVy4XqDeYTU0gdtUyn+CuIoMCy5rXyHW+HCQDMaxWFOy+4GYv2prMQwW46CtotMJ75Hc1CPNEuyAyu3MWF06VNnLyXACo97Wr2IMflYigD/ScPC1lpxKw4cJ3ogt93EVBFoirGF47RFbG0qb3J+vgkM1mDJeM8MZ74+nwK0rqUjS/uajF0j9pW5pcF1WryXPfjj6DPXigDRQkhVGKnIb2/nKTworSqif7EFB//9VDDiuzHyMfdefHWV/QFElgm06PQf916XAmw8r9yldtXyPPxVgLSfwMeNjVeuGGEtaeFPPi7EdkklaykBhVMJlgo18ESD2E5XjwZAYKAr/HEGuSx4sZkt1/Dfe4A80telaOg9xNBK4H2kvLPvg/H0/m4CWC3WaHNYYtxReCxL9CHSj03sgfm/ncPSKl488xshsm75miAtPsIq8a8kT6yOW5bQRgobpc0RRXqsOc8GN8gkVu61NVLDRR9MLbQZHUtkthce3XOLjl64Ei7xnlLipLjlp1xenKe84jLxOPeSISe0suu4I3BzUxB1Kl3gSJFjDz7tTgtS7bAmSSTEGh7SXgXG86ShkD/cp1BYcQyvbZq0T8yp2IvwmMasn5AQHP9/4RMHo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(83380400001)(40480700001)(81166007)(6666004)(36860700001)(8676002)(82740400003)(4326008)(36756003)(70206006)(70586007)(40460700003)(5660300002)(86362001)(44832011)(356005)(2906002)(426003)(8936002)(26005)(2616005)(186003)(478600001)(82310400005)(316002)(110136005)(336012)(54906003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 17:57:46.0014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfccd302-3e62-4d3c-e82a-08dab6b26c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 87 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 104 insertions(+)
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
index 85ba306c457e..c3b08b3f131a 100644
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
@@ -746,6 +747,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -788,6 +790,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
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
@@ -815,6 +829,79 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
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

