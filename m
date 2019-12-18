Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816B8123C16
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 01:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfLRA5T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 19:57:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:11520 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRA5S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 19:57:18 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Dec 2019 09:57:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 0BE35603AB;
        Wed, 18 Dec 2019 09:57:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 18 Dec 2019 09:57:52 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 5E43A1A0006;
        Wed, 18 Dec 2019 09:57:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
Date:   Wed, 18 Dec 2019 09:56:59 +0900
Message-Id: <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add external DMA controller bindings implemented in Socionext UniPhier
SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/dma/uniphier-xdmac.txt     | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-xdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
new file mode 100644
index 00000000..4e3927f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
@@ -0,0 +1,86 @@
+Socionext UniPhier external DMA controller bindings
+
+This describes the devicetree bindings for an external DMA engine to perform
+memory-to-memory or peripheral-to-memory data transfer, implemented in
+Socionext UniPhier SoCs.
+
+* DMA controller
+
+Required properties:
+- compatible: Should be "socionext,uniphier-xdmac".
+- reg: Specifies offset and length of the register set for the device.
+- interrupts: An interrupt specifier associated with the DMA controller.
+- #dma-cells: Must be <2>. The first cell represents the channel index.
+	The second cell represents the factor for transfer request.
+	This is mentioned in DMA client section.
+- dma-channels : Number of DMA channels supported. Should be 16.
+
+Example:
+	xdmac: dma-controller@5fc10000 {
+		compatible = "socionext,uniphier-xdmac";
+		reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
+		interrupts = <0 188 4>;
+		#dma-cells = <2>;
+		dma-channels = <16>;
+	};
+
+* DMA client
+
+Required properties:
+- dmas: A list of DMA channel requests.
+- dma-names: Names of the requested channels corresponding to dmas.
+
+DMA clients must use the format described in the dma.txt file, using a two cell
+specifier for each channel.
+
+Each DMA request consists of 3 cells:
+ 1. A phandle pointing to the DMA controller
+ 2. Channel index
+ 3. Transfer request factor number, If no transfer factor, use 0.
+	The number is SoC-specific, and this should be specified with relation
+	to the device to use the DMA controller. The list of the factor number
+	can be found below.
+
+	0x0	none
+	0x8	UART ch0 Rx
+	0x9	UART ch0 Tx
+	0xa	UART ch1 Rx
+	0xb	UART ch1 Tx
+	0xc	UART ch2 Rx
+	0xd	UART ch2 Tx
+	0xe	UART ch3 Rx
+	0xf	UART ch3 Tx
+	0x14	SCSSI ch1 Rx
+	0x15	SCSSI ch1 Tx
+	0x16	SCSSI ch0 Rx
+	0x17	SCSSI ch0 Tx
+	0x18	SCSSI ch2 Rx
+	0x19	SCSSI ch2 Tx
+	0x1a	SCSSI ch3 Rx
+	0x1b	SCSSI ch3 Tx
+	0x21	I2C ch0 Rx
+	0x22	I2C ch0 Tx
+	0x23	I2C ch1 Rx
+	0x24	I2C ch1 Tx
+	0x25	I2C ch2 Rx
+	0x26	I2C ch2 Tx
+	0x27	I2C ch3 Rx
+	0x28	I2C ch3 Tx
+	0x29	I2C ch4 Rx
+	0x2a	I2C ch4 Tx
+	0x2b	I2C ch5 Rx
+	0x2c	I2C ch5 Tx
+	0x2d	I2C ch6 Rx
+	0x2e	I2C ch6 Tx
+
+Example:
+	spi3: spi@54006300 {
+		compatible = "socionext,uniphier-scssi";
+		reg = <0x54006300 0x100>;
+		interrupts = <0 39 4>;
+		clocks = <&peri_clk 14>;
+		resets = <&peri_rst 14>;
+
+		dmas = <&xdmac 0 0x1a>, <&xdmac 1 0x1b>;
+		dma-names = "rx", "tx";
+	};
-- 
2.7.4

