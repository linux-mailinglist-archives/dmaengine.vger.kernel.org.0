Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE247FC69
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhL0MGb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:31 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:39783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhL0MG3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:29 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbAYi-1mQH5p0GU4-00bYZk; Mon, 27 Dec 2021 13:06:13 +0100
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
Subject: [PATCH RFC 01/11] ARM: dts: bcm283x: Update DMA node name per DT schema
Date:   Mon, 27 Dec 2021 13:05:35 +0100
Message-Id: <1640606743-10993-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:QsLR+z93AKo6AfD9jM0srmnL0tQKImMhzR3cNKAgAGjForfGuod
 Yg9gBdi2W4vHIE2ALR3JukzB3jfl1GxHz53lydrHC6+rJk34XUpTOuITgJz2AfMkYXYCzp7
 CGZ9a1DqSVHL9Vuf38XBU4PE6PQuJIKCqJ+SVYelDkG14dgZNpSpa9n8TnjHsXtmatHg+VB
 46o6u53LAZJdEB3wZaPVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nj9JkdBgdtU=:xKmKl0NaHCN79XXy53psHL
 84Gy/AARBkADNSPwprmulHXGe8yhsF/PUQt8aJm2gW6xRXNsbAFbjG1FOmH6m0xu/ObbRFebR
 cvLkKGZXD0i/cwekMWegTqhniXJ7gwQI22Ln3HafnV7NCMqiaeYmIGyrAxc3pG1FZM06sqTKd
 +FDy26NdAA150zZWB2GvDieJxhf/a8Mf9FvOxhwWi8xZKM8T7CYWwwk/V+Z8BGNis/AYBkgpv
 GDUoLvih3ALW+Nwxumxuq/wQ6m4m8iqgLl2XDx0UvHaZlMx0bzI8RYMdHwcjAveFy4yqdCs6L
 5GDKzByp09MRFeEgYn+bO70UfZECiF5vpgtw3uqphDO5YT+EiamxUQ19TSldUVgRMyYRNa/oo
 /zc/fFH67o1nyG3ixGOiwdd2T69Ai5gEUvgj8WRMxQazVqzhIDYw827jpNciIQDFMjzOYtFG8
 mEGGKjjfOEuuLAbH9b1wSOXA502ZIT6cPBi+RVRvaNxtLDPjk7oRp2r4ct7EgrQ3DwF12Pv6B
 PCpaVb5XB+0WsOwcBzTNXzofwIXSCCp+ORnVO8HAlsTKhBp4T4szOMZTrJNppJAK55Qz6MB9S
 Qp4Ga/Lq2i52wvofouNGkg+z4uUAqgCUmDqaQvsLL3ByKOl7s7IeWJezpGe6NwqE6evSeBgu8
 c2WM+WUz3F7IGVmOL8583lKoshBeTO86PVuO+c+dGQVDnn5sz2Hwf8JETQev5dSyQYf5X/ir0
 OZPmezhMe0UaQF21
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Follow dma-controller.yaml schema to use 'dma-controller' as node name
for BCM2835 DMA controller.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi        | 2 +-
 arch/arm/boot/dts/bcm2835-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index b8a4096..590068b 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -76,7 +76,7 @@
 			};
 		};
 
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xb00>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
index 4119271..f540140 100644
--- a/arch/arm/boot/dts/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -8,7 +8,7 @@
 	interrupt-parent = <&intc>;
 
 	soc {
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xf00>;
 			interrupts = <1 16>,
-- 
2.7.4

