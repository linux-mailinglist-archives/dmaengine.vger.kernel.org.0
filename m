Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6A122DC7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfLQN7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 08:59:42 -0500
Received: from out28-51.mail.aliyun.com ([115.124.28.51]:36487 "EHLO
        out28-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfLQN7l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 08:59:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5030352|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.125786-0.00881845-0.865395;DS=CONTINUE|ham_regular_dialog|0.00918173-0.000436435-0.990382;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.GJ3eyQr_1576591147;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GJ3eyQr_1576591147)
          by smtp.aliyun-inc.com(10.147.41.137);
          Tue, 17 Dec 2019 21:59:33 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com,
        paul@crapouillou.net, vkoul@kernel.org, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 2374286503@qq.com
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add X1830 bindings.
Date:   Tue, 17 Dec 2019 21:58:59 +0800
Message-Id: <1576591140-125668-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the X1830 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 .../devicetree/bindings/dma/jz4780-dma.txt         |  6 ++--
 include/dt-bindings/dma/x1830-dma.h                | 39 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/dma/x1830-dma.h

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index ec89782..3459e77 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -1,4 +1,4 @@
-* Ingenic JZ4780 DMA Controller
+* Ingenic XBurst DMA Controller
 
 Required properties:
 
@@ -8,10 +8,12 @@ Required properties:
   * ingenic,jz4770-dma
   * ingenic,jz4780-dma
   * ingenic,x1000-dma
+  * ingenic,x1830-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
-- clocks: Should contain a clock specifier for the JZ4780/X1000 PDMA clock.
+- clocks: Should contain a clock specifier for the JZ4780/X1000/X1830 PDMA
+  clock.
 - #dma-cells: Must be <2>. Number of integer cells in the dmas property of
   DMA clients (see below).
 
diff --git a/include/dt-bindings/dma/x1830-dma.h b/include/dt-bindings/dma/x1830-dma.h
new file mode 100644
index 00000000..35bcb89
--- /dev/null
+++ b/include/dt-bindings/dma/x1830-dma.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for X1830 DMA bindings.
+ *
+ * Copyright (c) 2019 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_X1830_DMA_H__
+#define __DT_BINDINGS_DMA_X1830_DMA_H__
+
+/*
+ * Request type numbers for the X1830 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define X1830_DMA_I2S0_TX	0x6
+#define X1830_DMA_I2S0_RX	0x7
+#define X1830_DMA_AUTO		0x8
+#define X1830_DMA_SADC_RX	0x9
+#define X1830_DMA_UART1_TX	0x12
+#define X1830_DMA_UART1_RX	0x13
+#define X1830_DMA_UART0_TX	0x14
+#define X1830_DMA_UART0_RX	0x15
+#define X1830_DMA_SSI0_TX	0x16
+#define X1830_DMA_SSI0_RX	0x17
+#define X1830_DMA_SSI1_TX	0x18
+#define X1830_DMA_SSI1_RX	0x19
+#define X1830_DMA_MSC0_TX	0x1a
+#define X1830_DMA_MSC0_RX	0x1b
+#define X1830_DMA_MSC1_TX	0x1c
+#define X1830_DMA_MSC1_RX	0x1d
+#define X1830_DMA_DMIC_RX	0x21
+#define X1830_DMA_SMB0_TX	0x24
+#define X1830_DMA_SMB0_RX	0x25
+#define X1830_DMA_SMB1_TX	0x26
+#define X1830_DMA_SMB1_RX	0x27
+#define X1830_DMA_DES_TX	0x2e
+#define X1830_DMA_DES_RX	0x2f
+
+#endif /* __DT_BINDINGS_DMA_X1830_DMA_H__ */
-- 
2.7.4

