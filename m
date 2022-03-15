Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DA4DA31F
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 20:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbiCOTOh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351286AbiCOTOg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 15:14:36 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117182654;
        Tue, 15 Mar 2022 12:13:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A8FF4C0006;
        Tue, 15 Mar 2022 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647371597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy3xMiCeqQ87JLlqai2jsXrx2//qDPrOCXzM+XIFa1E=;
        b=VXuaan7RALAUBzcPyyROWJWjmftO5vvY5TUahdAh7TNtb7Qpo6IN9+A5Md5qat1oI+OZa8
        S+M88wO/DEWvsD2Cca9bjp+2B5BE+Pd2hKLg1AXuEi02dMyxdGF+SU7i8QxtLjFuVD/zDN
        +9zxRMdiO+nBEl9KOR5epxL1a99jVnaX5wS8h2CJi0p29Vimzn/wWiJGxvd/vWUkYrgVwM
        z6wMwFP5pm78xCBtE7aUjJC95mk/Rli8rqs89J1/ppdcBHJgAYqc1TeE6522eLB2oxFD9H
        X2fEtbaTk78q0FvoThIPq1GSasOURBPXVe+5q924hzMeS7zjw6OghLxr+z4eEw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 8/8] ARM: dts: r9a06g032: Describe the DMA router
Date:   Tue, 15 Mar 2022 20:12:55 +0100
Message-Id: <20220315191255.221473-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220315191255.221473-1-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is a dmamux on this SoC which allows picking two different sources
for a single DMA request.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 640c3eb4bbcd..804f2d6f416f 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -75,6 +75,16 @@ sysctrl: system-controller@4000c000 {
 			clocks = <&ext_mclk>, <&ext_rtc_clk>,
 					<&ext_jtag_clk>, <&ext_rgmii_ref>;
 			clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			dmamux: dma-router@a0 {
+				compatible = "renesas,rzn1-dmamux";
+				reg = <0xa0 4>;
+				#dma-cells = <6>;
+				dma-requests = <32>;
+				dma-masters = <&dma0 &dma1>;
+			};
 		};
 
 		uart0: serial@40060000 {
-- 
2.27.0

