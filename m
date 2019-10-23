Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB958E12A1
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbfJWHDC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 03:03:02 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25465 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfJWHDC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 03:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571814163; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KCiBiHYUKwg02M0NGi/PywQmb/1mCTb0rk80P7sUWkPoBfkr1kBzZ7nM+87+hojo7lFSJJAkMJAS4eM4puYqFBUOGnAsoCTTlwQE/qQ9+XXqjx5re6f0UAD19veLwpc3mGruBnw5u+Deku0CD+X9lOFLwJu6E6uxSXyRKtLvQFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571814163; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=3LfvkXpP25PpD+nI8+Onyh93L0MPN93ZWQCuDDun+fs=; 
        b=i96FXHlZp3TgQgWZCf8But43XklqjB4DjYyrsswAQ1wMpXHJRaJbVrOR4TKfWlk7Mah0KP9B9Qy4CmO32fYNZOgA2bYnurSS/Q63SCdC8oqhpERdKEn7LkuLHmouD1wrOptme3FiRQgv9ywzbF44jqYubDEa6eaCT5zWSTZNcSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=WM+X5w5/om/UyhAm1RTDL1BI/PCgdEGxfvrpNmusEhUN2h2/b9taUxfjOVRS7qqA7WiwkjIyaWQU
    zmJjMxgnEtiuZ6QMBhHgJApfl5NKuZgyuTqtjbVB8xotY/1AeX/G  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571814163;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2669; bh=3LfvkXpP25PpD+nI8+Onyh93L0MPN93ZWQCuDDun+fs=;
        b=dIBMIULd3Ic6wT3wRZP7y7fFCjmJlaOWUbO3SKyuaXqA80Ywif7ta47nEKPbIrxI
        5f4AmnglMtY2ZF8PXi9WnGpt7zy3eb30XnMmsKFqLVFs37bfj2rPgTWOhbJkO0qZt6M
        kXXx28pzZDJlix2awVeRS8Qwa/mCCRnAHZxEERAo=
Received: from zhouyanjie-virtual-machine.localdomain (125.71.5.36 [125.71.5.36]) by mx.zohomail.com
        with SMTPS id 1571814162508823.4897078530958; Wed, 23 Oct 2019 00:02:42 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: [PATCH RESEND 1/2] dt-bindings: dmaengine: Add X1000 bindings.
Date:   Wed, 23 Oct 2019 15:02:16 +0800
Message-Id: <1571814137-46002-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 .../devicetree/bindings/dma/jz4780-dma.txt         |  3 +-
 include/dt-bindings/dma/x1000-dma.h                | 40 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/dma/x1000-dma.h

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index 636fcb2..ec89782 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -7,10 +7,11 @@ Required properties:
   * ingenic,jz4725b-dma
   * ingenic,jz4770-dma
   * ingenic,jz4780-dma
+  * ingenic,x1000-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
-- clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
+- clocks: Should contain a clock specifier for the JZ4780/X1000 PDMA clock.
 - #dma-cells: Must be <2>. Number of integer cells in the dmas property of
   DMA clients (see below).
 
diff --git a/include/dt-bindings/dma/x1000-dma.h b/include/dt-bindings/dma/x1000-dma.h
new file mode 100644
index 00000000..401e165
--- /dev/null
+++ b/include/dt-bindings/dma/x1000-dma.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for X1000 DMA bindings.
+ *
+ * Copyright (c) 2019 Zhou Yanjie <zhouyanjie@zoho.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_X1000_DMA_H__
+#define __DT_BINDINGS_DMA_X1000_DMA_H__
+
+/*
+ * Request type numbers for the X1000 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define X1000_DMA_DMIC_RX	0x5
+#define X1000_DMA_I2S0_TX	0x6
+#define X1000_DMA_I2S0_RX	0x7
+#define X1000_DMA_AUTO		0x8
+#define X1000_DMA_UART2_TX	0x10
+#define X1000_DMA_UART2_RX	0x11
+#define X1000_DMA_UART1_TX	0x12
+#define X1000_DMA_UART1_RX	0x13
+#define X1000_DMA_UART0_TX	0x14
+#define X1000_DMA_UART0_RX	0x15
+#define X1000_DMA_SSI0_TX	0x16
+#define X1000_DMA_SSI0_RX	0x17
+#define X1000_DMA_MSC0_TX	0x1a
+#define X1000_DMA_MSC0_RX	0x1b
+#define X1000_DMA_MSC1_TX	0x1c
+#define X1000_DMA_MSC1_RX	0x1d
+#define X1000_DMA_PCM0_TX	0x20
+#define X1000_DMA_PCM0_RX	0x21
+#define X1000_DMA_SMB0_TX	0x24
+#define X1000_DMA_SMB0_RX	0x25
+#define X1000_DMA_SMB1_TX	0x26
+#define X1000_DMA_SMB1_RX	0x27
+#define X1000_DMA_SMB2_TX	0x28
+#define X1000_DMA_SMB2_RX	0x29
+
+#endif /* __DT_BINDINGS_DMA_X1000_DMA_H__ */
-- 
2.7.4


