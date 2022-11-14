Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BAC62863E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Nov 2022 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNQ53 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Nov 2022 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiKNQ4h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Nov 2022 11:56:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722F3056C;
        Mon, 14 Nov 2022 08:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFi6Je05QUJq17a2CyEGGP1IB4smgXrES022b4PzGy0ScAFsBp8gjQ/1UtSYnujr4Y9ph6Z5Xpjc3RTaYXTRBOR9UbpvxKtabfAPE3x0nM01gczssTkm80IDKoJllHgxHcp2qEmUw4JZL2rxxwfrzR2pIpLTj63x4b83aYKUqM9Bv4UDQziOSEfno1AQtg9zw4Tgeub4YomjIpsoO0gTTAPcPN+Wu/QEE8XfNQFC2GRspuXioqr8OtC4p26EdormzC5P/NMOVFUFw3cCEfqgwiq6YSt/UOBrmDZjMsPDHCPhba8WiKnzADmZPvDpLuI1z46C5ma7kOpDo+HQu9A7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeDdJSJEF3gYwnHHfex6ipJ59QrEbcoDhj/sCah0PHM=;
 b=I/HDfi5EI+Jgk63zv/c/dhmTOInWQbdCknmDd64jw2n5hE5mveXtQ9m5Dvz6T533xIJmYu2xcdSs5/pitX1EWRKjh3UBzq/NXtTIU65ISFlYh/yISk73bTo9EtEn+udU9yMK6lPv5eI2lkaG1SpoRFuOHtRyYsIAl6Hk7J7p2B/TTN/wDGpApB+czfpDgAxRvrYigGTDhrfKFRDi5C3EemPAQP7T4vFaUw9spXFgsMpMvC7nYKaHncHnpQ2K+XGgAcGPgkcBswaeEZdZMVajoR5iC34L63VnxlGjsQXrTxRWnJq/itzzz+88OP7XmWT/mYCidFShozy/kuQR02hzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeDdJSJEF3gYwnHHfex6ipJ59QrEbcoDhj/sCah0PHM=;
 b=iDr+RLKOtzEcRDrWLzDDGUfeXHu27K4RmWzwZ5JdpE8/HkKLRzjqmxd6loGDE8UX164/OjoE/j1LWBT53eDtVR5Rsq/WTd2oT+WrQdf/IgrN6Brx/v+MuLDLL6DDFGXR2ehoidUf5vAwwG5U0SUn6zBCGxT31NTj9EF3P7Yg7jI=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 16:56:09 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::64) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 16:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 16:56:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 10:56:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 08:56:07 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 10:56:07 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V10 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Mon, 14 Nov 2022 08:55:52 -0800
Message-ID: <1668444952-20947-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668444952-20947-1-git-send-email-lizhi.hou@amd.com>
References: <1668444952-20947-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6678e39b-400e-4777-c824-08dac66120db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24p0DFNfkIbh99R16bD2MKG5et8xfw9JwFRF9vWZj1ckciKDDFaRFQMrADF8CLQJDX4nRqPvKix5uD1mihksdYZjg/z8Z+mcWkdb/AZYuGVP+tobUbrKdPKVM2KuaMDBvFWF/K1S740oE9N0x+HqrmabHlmvlrfE4q1wFXy+RpaW+L0uj6HfrEjB7dYcVUlPM/vDvLKkRuvgmfCaCsTv1HM2OdBZbITJSBqCCYJxPXaTRNXoXMV8t1ctZAazgHSkYyEs7CSyHaufUKDTenkQDyxQMqgiJ3sFmWwSXkx2avlL2Tn9SLXRKbFzWSsfA+ntjQEy+XwW/lNmQPWr78AK3/P+QUGwtTn52BUrvUAZkHm4PArrPMvAynXwRlFu05Ki85OvGPv4yF6A+nycjk4xPpHCQV20REsygbcxEAeIlINZZ4EIPkdExJ/wtWk5aZ2YYUgd4crBwikmAk2PE9tOVopdfRZ3YKHkmM94yBOMQcXfV5lZIUa4x6VVGpzniUGKGAqEnIUApkBMYZEviefVgdZVFmWRfdyakPx/QG/vkIl/VDLT9jgcyBKzsjDbhp/xcZwityYfy0ek/EXOjO0AWvFDl6lrPj0htxLVxhUD68wMmoz+qRvLdPCEJTKVgABcFBw16lBcN0215IHPsmU5u8mnWxJIgEtNWhxY/mN46x3yfjwrrgyjPZgpsKImUsgIgeYYSPg9+8P8vn5Yu5N5hJ0uXoneQUO0mwa9WZtAqNAgqlxQhBQG/USQjCjfCMKBffYcL8uX60KoVpgeMRSw9fPUEXMXpW7kOMlOLGn0jzCNX8jZRNbx/+PWIe2FEnY7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(2906002)(82740400003)(36860700001)(44832011)(8936002)(356005)(83380400001)(81166007)(426003)(336012)(47076005)(2616005)(186003)(110136005)(54906003)(316002)(478600001)(82310400005)(40480700001)(40460700003)(8676002)(70586007)(5660300002)(41300700001)(70206006)(4326008)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:56:09.0967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678e39b-400e-4777-c824-08dac66120db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
 drivers/dma/xilinx/xdma.c    | 85 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 102 insertions(+)
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
index 118528295fb7..846f10317bba 100644
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
@@ -713,6 +714,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -755,6 +757,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
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
 	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
 	if (ret)
@@ -780,6 +794,77 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
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

