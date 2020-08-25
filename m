Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C0251644
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgHYKJP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 06:09:15 -0400
Received: from mailoutvs19.siol.net ([185.57.226.210]:45124 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729514AbgHYKJP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 06:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id CC189523242;
        Tue, 25 Aug 2020 12:00:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X9cgmXFZk2qR; Tue, 25 Aug 2020 12:00:40 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 718DC52315A;
        Tue, 25 Aug 2020 12:00:40 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 25648523242;
        Tue, 25 Aug 2020 12:00:38 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 2/2] ARM: dts: sun8i: r40: Add DMA node
Date:   Tue, 25 Aug 2020 12:00:30 +0200
Message-Id: <20200825100030.1145356-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825100030.1145356-1-jernej.skrabec@siol.net>
References: <20200825100030.1145356-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allwinner R40 SoC has DMA with 16 channels and 31 request sources.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
index b82031b19893..d481fe7989b8 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -198,6 +198,18 @@ nmi_intc: interrupt-controller@1c00030 {
 			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
=20
+		dma: dma-controller@1c02000 {
+			compatible =3D "allwinner,sun8i-r40-dma",
+				     "allwinner,sun50i-a64-dma";
+			reg =3D <0x01c02000 0x1000>;
+			interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&ccu CLK_BUS_DMA>;
+			dma-channels =3D <16>;
+			dma-requests =3D <31>;
+			resets =3D <&ccu RST_BUS_DMA>;
+			#dma-cells =3D <1>;
+		};
+
 		spi0: spi@1c05000 {
 			compatible =3D "allwinner,sun8i-r40-spi",
 				     "allwinner,sun8i-h3-spi";
--=20
2.28.0

