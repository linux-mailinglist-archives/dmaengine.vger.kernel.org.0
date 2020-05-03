Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A246A1C2FC4
	for <lists+dmaengine@lfdr.de>; Sun,  3 May 2020 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgECVrs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 May 2020 17:47:48 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:12329 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729287AbgECVrr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 May 2020 17:47:47 -0400
X-IronPort-AV: E=Sophos;i="5.73,349,1583161200"; 
   d="scan'208";a="46232121"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2020 06:47:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E222A40083D1;
        Mon,  4 May 2020 06:47:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 09/10] ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H Qseven SOM
Date:   Sun,  3 May 2020 22:46:53 +0100
Message-Id: <1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for iWave RZ/G1H Qseven System On Module.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21m.dtsi

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
new file mode 100644
index 000000000000..3d22de47f337
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave RZ/G1H Qseven SOM
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a7742.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "iwave,g21m", "renesas,r8a7742";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory@200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x20000000>;
+	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&pfc {
+	mmc1_pins: mmc1 {
+		groups = "mmc1_data4", "mmc1_ctrl";
+		function = "mmc1";
+	};
+};
+
+&mmcif1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
-- 
2.17.1

