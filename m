Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE147FC7B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhL0MHT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:07:19 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:46457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhL0MHS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:07:18 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mirb8-1mXzoK2zJM-00erHu; Mon, 27 Dec 2021 13:07:04 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 11/11] ARM: dts: bcm2711: add bcm2711-dma node
Date:   Mon, 27 Dec 2021 13:06:52 +0100
Message-Id: <1640606812-11110-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606812-11110-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606812-11110-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:U3nO36HzZGXq40n9R882naHiNjUl4oAFLiWYXZZHkaUh42dvvLS
 burphzCrKM4DScfSiS/mZaIkh+uybGI1l2APtf1yp9EoWu0+1FY/9Ry/OPB2kmcRbGK4WEa
 ndQURDst4PiujCCqJSeJGfu5+BNnHwBVdfuFSMIwLx/YjacYrvvpctnSy4Xpcma2qJ9qrAX
 C6uiZeOtSxYEys3O9MIdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PcMir07Pc54=:bxIJKo2MiIwel1ZhW6jVx5
 e8W38T1FRN+TR0DUfVTqJNCcq4sZ18dUnvBpn0tQz41g4qmNg52LH3/xa4JhgnlF582q6dbYw
 KYX1R8UcQxW85FjugCnqn3AEX9uEk/QDGQx07FDg1UHXITPDlC6AYbVK96A2VNYCw1wqSRoqs
 p3z+1pEi6fYIv0wGedFrsmQXCweu5BoiupAV0UTd3cnCt6yAfQCIGXvXq4SrTywFiosFVi4Hx
 f0LWr2aA4dYS2VZ7xYgkRiZQDlDKQOKLzsS2J9cVWj6ba7rYwnxnsXkyfsz0t+e6AmdXTS96D
 TZlesK47HWeSJ8EWounZTgHaYyd2U6dMWQz6S5kaPVtUTxFRE+6ObJuTLoQ7R+y2xuj+yBYNv
 Ld9Wvo8xegHoa+ws12LL2lKucFn7f0QpQfzO7a+Alr10N/4yYcQtlAiVRk5Tz0CmEu71RMUfb
 j6QQm+Yrtzy57pRI/RPdXb8bZhWuXk/ruZBuocVcnMj4n/hFTQAXXDfmPsBjV4/YgdCXuAHIP
 jsJyXtm0xZHchTSUVxnDujGVRKwUwsCc74ptcEnw07ZRPRezn3vips9TtGupRnkXY4m0Oe3hV
 ImhGcrhEScceH1pa0Q+2ANQ5I4ER+dIQ/SrX2a9SkdCj/aC+if6O5XUG77ClLZoRMvXNlduWi
 WF48MEk8YTZZrqFO/iw3/899Es5JBVzNT340L0fkmr3t/BYAjE/muLJFXdkujchIFqDEpzdaz
 Zlx4qJWgfcsUgkqE
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the full 4GB of memory on a Pi 4. Not sure which adjustments to
the parent node (scb) are required.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 590068b..12f373b 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -536,6 +536,22 @@
 				#size-cells = <0x1>;
 			};
 		};
+
+		dma40: dma-controller@7e007b00 {
+			compatible = "brcm,bcm2711-dma";
+			reg = <0x0 0x7e007b00 0x400>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, /* dma4 11 */
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>, /* dma4 12 */
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>, /* dma4 13 */
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>; /* dma4 14 */
+			interrupt-names = "dma11",
+					  "dma12",
+					  "dma13",
+					  "dma14";
+			#dma-cells = <1>;
+			/* The VPU firmware uses DMA channel 11 for VCHIQ */
+			brcm,dma-channel-mask = <0x7000>;
+		};
 	};
 };
 
-- 
2.7.4

