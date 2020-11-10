Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2862ACE17
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgKJEGy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:06:54 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53880 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387513AbgKJEG3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 23:06:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1478366|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0231434-0.00763199-0.969225;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IulFdj5_1604981159;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IulFdj5_1604981159)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 12:06:22 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, ulf.hansson@linaro.org, kishon@ti.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        dan.j.williams@intel.com, linus.walleij@linaro.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, colin.king@canonical.com, rdunlap@infradead.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, megous@megous.com,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 06/19] arm64: allwinner: a100: Add device node for DMA controller
Date:   Tue, 10 Nov 2020 12:05:40 +0800
Message-Id: <20201110040553.1381-7-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110040553.1381-1-frank@allwinnertech.com>
References: <20201110040553.1381-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The A100 SoC has a DMA controller that supports 8 DMA channels
to and from various peripherals.

Add a device node for it.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index cc321c04f121..c34ed8045363 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -101,6 +101,18 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-a100-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <8>;
+			dma-requests = <51>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		gic: interrupt-controller@3021000 {
 			compatible = "arm,gic-400";
 			reg = <0x03021000 0x1000>, <0x03022000 0x2000>,
-- 
2.28.0

