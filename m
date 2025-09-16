Return-Path: <dmaengine+bounces-6576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47083B5A2D5
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338E058623A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8E32F48A;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAEBA1y1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A93294F8;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=WiXkg02pcQirYjETBI1ITRBYyQ3iEHDGHUurD65N++xxEEKYZH//M2/Hy/GpvHIiU7WlIb3acBqf7wIU5Vqv39IdOCw72jfbjAaW4KmnD/FFh7RZndh4UCLGTrNUXQCcBTNmGUwupq2i3QuEX1vAotLa3KntOKJ8kPcxVRRSVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=B44iCTmbdkKyp2fHglpeuA0FgGRACa5ozdrUyEJewhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuEYNpXK7zK/j1FCtwSn5vFVQexyeaypmCZ8p1edvz4DYDUXLM1N6xqIUat/+6JFvO8L//HmMrPCwVhFnjh7SAqxgM0OiGS0GXSCAqo9eQD6v4nKAB9zjAbtbdP2ZqjdqBmIUTAZfEiF3ZTCBRoFDpXhhPR364dTx7/tQTkRynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAEBA1y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A674C4AF09;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=B44iCTmbdkKyp2fHglpeuA0FgGRACa5ozdrUyEJewhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NAEBA1y1K4tD/khRpZK6HkipNJr1YfntYnA1W8a1MzEjPiEZDlIUbUrvu6Vu+pe0p
	 dE4zzG04EM+hdn+JeTZRE7swY4dzT+d3zaZlfXt1w080wMyHCp0vmyNmcQfp1EpRk4
	 +M5cgboJT5xIC7A1o9d3niTws0pIR9ymJ32HRLpSvJHNUrZoq77nijq2oVbdqcCnFX
	 18h9UHBn499TLmGp8F2huiSkDw3kNFZHs2OGD4zQ9TR7ELKLZlLg2bYtnrgFtG4mkE
	 PjuOKrBP49md3posUyZxios2JUQ0yCVcmx4UwALtpQvdrA7nF/kp1Haj/rVzLgd/N6
	 8HwSnuIEXZLzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD7CAC59F;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:15 +0700
Subject: [PATCH 18/25] dt-bindings: dma: Add RDA IFC DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-18-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=2537;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=QY6MPTi+ZEpXp5sbdSrBjaqgS0Xhdu1ZPCH1WF+g14Y=;
 b=f+73zCYT5uq1k6ilgLXi33C+NRy7J+fTOa4N/swr6XCdLJaXbG/yOKqpUhJI3D/PqTqY8XU0k
 QkM4vE+PJ/5Cn0iUPmzJgeqVeko3jz25IKQyFfbLa/CoguJ6psdmMSc
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The Intelligent Flow Controller (IFC) is a scatter/gather DMA
controller.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 Documentation/devicetree/bindings/dma/rda,ifc.yaml | 42 ++++++++++++++++++++++
 include/dt-bindings/dma/rda-ifc.h                  | 28 +++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/rda,ifc.yaml b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3bb5932e8ff9404e3980eaef607efceb6d883bda
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/rda,ifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Intelligent Flow Controller (IFC)
+
+maintainers:
+  - Dang Huynh <dang.huynh@mainlining.org>
+
+description: |
+  RDA IFC is a DMA controller, it only supports scatter/gather lists.
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: rda,8810pl-ifc
+
+  reg:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+    description:
+      The cell corresponding to DMA request ID
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ifc: dma-controller@f0000 {
+      compatible = "rda,8810pl-ifc";
+      reg = <0xf0000 0x1000>;
+      #dma-cells = <1>;
+    };
diff --git a/include/dt-bindings/dma/rda-ifc.h b/include/dt-bindings/dma/rda-ifc.h
new file mode 100644
index 0000000000000000000000000000000000000000..e075fe26158e834d1ae87b6dce61e41fb931add3
--- /dev/null
+++ b/include/dt-bindings/dma/rda-ifc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_DMA_RDA_IFC_H__
+#define __DT_BINDINGS_DMA_RDA_IFC_H__
+
+#define IFC_UART1_TX 0
+#define IFC_UART1_RX 1
+#define IFC_UART2_TX 2
+#define IFC_UART2_RX 3
+#define IFC_SPI1_TX 4
+#define IFC_SPI1_RX 5
+#define IFC_SPI2_TX 6
+#define IFC_SPI2_RX 7
+#define IFC_SPI3_TX 8
+#define IFC_SPI3_RX 9
+#define IFC_SDMMC1_TX 10
+#define IFC_SDMMC1_RX 11
+#define IFC_SDMMC2_TX 12
+#define IFC_SDMMC2_RX 13
+#define IFC_SDMMC3_TX 14
+#define IFC_SDMMC3_RX 15
+#define IFC_NFSC_TX 16
+#define IFC_NFSC_RX 17
+#define IFC_UART3_TX 18
+#define IFC_UART3_RX 19
+#define IFC_NO_REQUEST 20
+
+#endif /* __DT_BINDINGS_DMA_RDA_IFC_H__ */

-- 
2.51.0



