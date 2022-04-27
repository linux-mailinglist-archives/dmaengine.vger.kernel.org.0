Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574955114FB
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiD0Khw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiD0Khv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 06:37:51 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BC438EE0;
        Wed, 27 Apr 2022 03:16:06 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5C7B3CC51C;
        Wed, 27 Apr 2022 09:57:57 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 13C56200019;
        Wed, 27 Apr 2022 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651053437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxzMEOqhe0N5yp6GmaQi9cglbTWdIMVSkvcspvfYAsA=;
        b=WtY8Rp/wzqRTZj3Sfbvox6ilJE6pxreJnw4mczmp6V6fZzYr+mZifk+JPUSh4WW+bkGIvx
        yxeSLhqTZu1k7+Ab52/DGhPZ+EclGHG5pZvOhiuMeo6zFy59ducknxROc/PB5vdzlAApKR
        uH6RUAYTaZBgy91RDHgGmYM5X/xYSftk9LT0e8HNDG7iQpYyO5mXYSJCUAMFea4S5KUj69
        C7iHIKlbt5xZOWaoFr9wM8yxAGr6auzqOqlTJBT0vVvRahuaBulRsl30KgXhtGky0LZcuE
        EO5Pwm/5JDl7A20zghrZPymdSjNuh7UKtQcMR6EwGZXOUXI4YRtGrgJN+AH81A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v12 9/9] ARM: dts: r9a06g032: Describe the DMA router
Date:   Wed, 27 Apr 2022 11:56:53 +0200
Message-Id: <20220427095653.91804-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427095653.91804-1-miquel.raynal@bootlin.com>
References: <20220427095653.91804-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is a dmamux on this SoC which allows picking two different sources
for a single DMA request.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 1e90bfc76417..37c2eb7bbb7f 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -91,6 +91,16 @@ sysctrl: system-controller@4000c000 {
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

