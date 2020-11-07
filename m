Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA322AA4FC
	for <lists+dmaengine@lfdr.de>; Sat,  7 Nov 2020 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKGMWH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Nov 2020 07:22:07 -0500
Received: from out28-3.mail.aliyun.com ([115.124.28.3]:55769 "EHLO
        out28-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgKGMVp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Nov 2020 07:21:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07864539|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0348511-0.000799826-0.964349;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.ItnhwiJ_1604751644;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.ItnhwiJ_1604751644)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sat, 07 Nov 2020 20:20:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     Zubair.Kakakhel@imgtec.com, vkoul@kernel.org, paul@crapouillou.net,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH RESEND 1/2] dt-bindings: dmaengine: Add JZ4775 bindings.
Date:   Sat,  7 Nov 2020 20:20:15 +0800
Message-Id: <20201107122016.89859-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the JZ4775 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/dma/jz4775-dma.h | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4775-dma.h

diff --git a/include/dt-bindings/dma/jz4775-dma.h b/include/dt-bindings/dma/jz4775-dma.h
new file mode 100644
index 000000000000..8d27e2c69dca
--- /dev/null
+++ b/include/dt-bindings/dma/jz4775-dma.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for JZ4775 DMA bindings.
+ *
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_JZ4775_DMA_H__
+#define __DT_BINDINGS_DMA_JZ4775_DMA_H__
+
+/*
+ * Request type numbers for the JZ4775 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define JZ4775_DMA_I2S0_TX	0x6
+#define JZ4775_DMA_I2S0_RX	0x7
+#define JZ4775_DMA_AUTO		0x8
+#define JZ4775_DMA_SADC_RX	0x9
+#define JZ4775_DMA_UART3_TX	0x0e
+#define JZ4775_DMA_UART3_RX	0x0f
+#define JZ4775_DMA_UART2_TX	0x10
+#define JZ4775_DMA_UART2_RX	0x11
+#define JZ4775_DMA_UART1_TX	0x12
+#define JZ4775_DMA_UART1_RX	0x13
+#define JZ4775_DMA_UART0_TX	0x14
+#define JZ4775_DMA_UART0_RX	0x15
+#define JZ4775_DMA_SSI0_TX	0x16
+#define JZ4775_DMA_SSI0_RX	0x17
+#define JZ4775_DMA_MSC0_TX	0x1a
+#define JZ4775_DMA_MSC0_RX	0x1b
+#define JZ4775_DMA_MSC1_TX	0x1c
+#define JZ4775_DMA_MSC1_RX	0x1d
+#define JZ4775_DMA_MSC2_TX	0x1e
+#define JZ4775_DMA_MSC2_RX	0x1f
+#define JZ4775_DMA_PCM0_TX	0x20
+#define JZ4775_DMA_PCM0_RX	0x21
+#define JZ4775_DMA_SMB0_TX	0x24
+#define JZ4775_DMA_SMB0_RX	0x25
+#define JZ4775_DMA_SMB1_TX	0x26
+#define JZ4775_DMA_SMB1_RX	0x27
+#define JZ4775_DMA_SMB2_TX	0x28
+#define JZ4775_DMA_SMB2_RX	0x29
+
+#endif /* __DT_BINDINGS_DMA_JZ4775_DMA_H__ */
-- 
2.11.0

