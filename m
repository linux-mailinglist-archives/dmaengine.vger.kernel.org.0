Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929F32AA4F5
	for <lists+dmaengine@lfdr.de>; Sat,  7 Nov 2020 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKGMWH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Nov 2020 07:22:07 -0500
Received: from out28-98.mail.aliyun.com ([115.124.28.98]:42510 "EHLO
        out28-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgKGMVo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Nov 2020 07:21:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07986468|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0399064-0.000837473-0.959256;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.ItnhwiJ_1604751644;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.ItnhwiJ_1604751644)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sat, 07 Nov 2020 20:20:53 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     Zubair.Kakakhel@imgtec.com, vkoul@kernel.org, paul@crapouillou.net,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH RESEND 2/2] dt-bindings: dmaengine: Add X2000 bindings.
Date:   Sat,  7 Nov 2020 20:20:16 +0800
Message-Id: <20201107122016.89859-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the X2000 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/dma/x2000-dma.h | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 include/dt-bindings/dma/x2000-dma.h

diff --git a/include/dt-bindings/dma/x2000-dma.h b/include/dt-bindings/dma/x2000-dma.h
new file mode 100644
index 000000000000..db2cd4830b00
--- /dev/null
+++ b/include/dt-bindings/dma/x2000-dma.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for X2000 DMA bindings.
+ *
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_X2000_DMA_H__
+#define __DT_BINDINGS_DMA_X2000_DMA_H__
+
+/*
+ * Request type numbers for the X2000 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define X2000_DMA_AUTO		0x8
+#define X2000_DMA_UART5_TX	0xa
+#define X2000_DMA_UART5_RX	0xb
+#define X2000_DMA_UART4_TX	0xc
+#define X2000_DMA_UART4_RX	0xd
+#define X2000_DMA_UART3_TX	0xe
+#define X2000_DMA_UART3_RX	0xf
+#define X2000_DMA_UART2_TX	0x10
+#define X2000_DMA_UART2_RX	0x11
+#define X2000_DMA_UART1_TX	0x12
+#define X2000_DMA_UART1_RX	0x13
+#define X2000_DMA_UART0_TX	0x14
+#define X2000_DMA_UART0_RX	0x15
+#define X2000_DMA_SSI0_TX	0x16
+#define X2000_DMA_SSI0_RX	0x17
+#define X2000_DMA_SSI1_TX	0x18
+#define X2000_DMA_SSI1_RX	0x19
+#define X2000_DMA_I2C0_TX	0x24
+#define X2000_DMA_I2C0_RX	0x25
+#define X2000_DMA_I2C1_TX	0x26
+#define X2000_DMA_I2C1_RX	0x27
+#define X2000_DMA_I2C2_TX	0x28
+#define X2000_DMA_I2C2_RX	0x29
+#define X2000_DMA_I2C3_TX	0x2a
+#define X2000_DMA_I2C3_RX	0x2b
+#define X2000_DMA_I2C4_TX	0x2c
+#define X2000_DMA_I2C4_RX	0x2d
+#define X2000_DMA_I2C5_TX	0x2e
+#define X2000_DMA_I2C5_RX	0x2f
+#define X2000_DMA_UART6_TX	0x30
+#define X2000_DMA_UART6_RX	0x31
+#define X2000_DMA_UART7_TX	0x32
+#define X2000_DMA_UART7_RX	0x33
+#define X2000_DMA_UART8_TX	0x34
+#define X2000_DMA_UART8_RX	0x35
+#define X2000_DMA_UART9_TX	0x36
+#define X2000_DMA_UART9_RX	0x37
+#define X2000_DMA_SADC_RX	0x38
+
+#endif /* __DT_BINDINGS_DMA_X2000_DMA_H__ */
-- 
2.11.0

