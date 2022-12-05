Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A7642E18
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiLERBj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 12:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLERBi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 12:01:38 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A92DF53;
        Mon,  5 Dec 2022 09:01:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg+uK3+56/0wPKVHvcU7BxNa7Sd4Fulki+VzmAxGRvJlKcL6TzQHOWUqSRQ6bnBDSNfrSbG5FduKBK0gEFpWoRTTGU7BywuOx+zN42WmirAOGojl8YcR2twSekrtldo9irsC919VMIWO/F+QoBbaynefvVcw0RFNpjCaPWbW8Gk377wHqO7xmJ7PQxePh/AGozRFjts56U/vS6+BgT2IsFmeCi3QIPwCkPeWaUZ/11m1zb0kwiQcKJmWYTCA5ycFDfZ1aD1bAvprU5WCVc8eECe6kC+VAi7pUIkg2ZKzl2V07ooN28cYq8Qu1RSeUaam1S8CEDrENZ4JaY5Db0ZOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeDdJSJEF3gYwnHHfex6ipJ59QrEbcoDhj/sCah0PHM=;
 b=YbcSDlVeY4XjQ6fqj+rHAuCd/mxAjNSgLdoakFhIiX4u9yTYswZlzJNIOUl28t1iOWz8glfZGOJ2Z56Q6k0Aq/YQwTezAbbmMxadVw5w9P6J1H9CP27VqgNaN35o5xDB4EH2E1XDb7d0+i3coTn+pnfn/BFXhhIFTlm6LBJ+HKWRw8vdQBS6cM/iz9qD/lSd4iQNNsGeaJEyu0jPWFAhYOrSJ1CYYXe4SfFbRSBVL4/vOXXDmVDKKACRpBlM/SJ2IfNZl3bDH/yiUGm1s0S+BbLXOxuWtjBT+5c907B9aJvBX5rZbU8/NmlKVDAviBhzMF7h9OtTQi29taOXsvuFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeDdJSJEF3gYwnHHfex6ipJ59QrEbcoDhj/sCah0PHM=;
 b=tjkxZpF53Nc6keO9KkkdSQuAeu4g3O77n4dRaZHg7JQkIs8aBtW62jtsx2CpUrWtxB4eCEPZmL5lud5dhjavVNob7AFL+adbYFxD+36AaTgCgka4+0Es/giyRtJ1lh6Hmm6iicY+QHkymXSCqfV6S4IHXWaOO207f9VujIdRLHo=
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Mon, 5 Dec 2022 17:01:34 +0000
Received: from DS1PEPF0000E63E.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::be) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 17:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63E.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Mon, 5 Dec 2022 17:01:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 11:00:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 11:00:40 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Dec 2022 11:00:39 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V10 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Mon, 5 Dec 2022 09:00:26 -0800
Message-ID: <1670259626-54430-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670259626-54430-1-git-send-email-lizhi.hou@amd.com>
References: <1670259626-54430-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5adf4e-5cad-48ce-f809-08dad6e25d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vc0kHAaOAeFfS9hU1BYYVyK+EqW9PJmzWOAqjtKoi7lgHhOHR1njHhzfiIOEXTW7U1Fd1yaiNm8OokMIq4mHbMdf6Iy5B/7pfdeFloRbqeZKV1dFqgMrZLfj6/cgfrZKa7/Ag5292k6wtMbWD3qZPWyjiU4tjz395s6x9VWYTltwxPEYcEO+i3tcOH45RgDhxzj+6AjbxgmCXyFCfyv6M/lV8iMwU1U1F6tO+Z9wmtGZwX34nIsUCg3YNYSJD8wy28WIJ3YRw2pSTz9pmDt0+iIVgdk2n5ChsR5eo2IthECj1JpkKZ/3C+to7chR05BUE+gYeieNKJwODJyR0PPEaWbuhkLWqh1bgsZ6VuOByPQiztIK0dV4sCn/iGo3N8xZsd4aZIKqHThr/1feBkyO+0DofA8zX1diLkw+PRgqcsqlIdZZPUsJMz3aK7+6rGSxkBT1t05CZqA0hH0YM3mDOLLz+5dYcW7Lridl3oHAnt6yep2MnvgQGaJt2K3QO86gm5nWI+8S+/3qO9FHXIfh/TA9MA9oXu3GHvymehGI2AYWZ0OGawo8l+1lObcBuxAt2LS8JjxnhTfGPTSu6FzvU5qF7s3VeaArvwiDFe69jdNJfXGyhzgd9SBTW7CkKhMUWQH/t7eCFZruIp8h1q/7xmdMULEhdSHjux0ls0EWvsYnupHrMXNpgo9JgCkhskFrQ4v99EBWz22eDo966rWGT2UNXds3LV5auMxrEWjT1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(478600001)(26005)(4326008)(8676002)(110136005)(316002)(54906003)(86362001)(70206006)(70586007)(81166007)(82740400003)(186003)(2616005)(356005)(336012)(41300700001)(40460700003)(5660300002)(8936002)(44832011)(6666004)(83380400001)(82310400005)(36860700001)(47076005)(426003)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:01:34.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5adf4e-5cad-48ce-f809-08dad6e25d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

