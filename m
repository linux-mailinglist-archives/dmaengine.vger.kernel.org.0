Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1F5F8CF9
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJISPT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJISOk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C227B38;
        Sun,  9 Oct 2022 11:14:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003c1e11f54d2so4085273wmb.2;
        Sun, 09 Oct 2022 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPcH8XLgYo97PzQXFtpwVWSfZRsC44f58GQxeG6ib0I=;
        b=hveY9X6fVgK8vgULKzBvaI0i7YZyvK+LsJKNz+UwLxo0zTkq+2pJ8YYVJK2vAwpFpd
         ln+KSsIg4gPq4RkzQeFJzjCNmo2n/IgmZc1u1neT04cZ/ibRCCfR9SpIkF2I6D7ZQ4d9
         UHf0MAskrHAq+UcQ4rizNNek/3RYuD4OYyL1xA6r4ZV6cZ+hMlLu65goT3eXKH7MCj3F
         kolAyqncmGWobuAMeHEpXaufp+96+Esu4noatAKItlRpXzryY6HajrRhIzyZbiMSR79X
         uHhUpWmsJNpuwN3i9CdQehCbI+QCvQ2ivg4T2wZ8R+v5xbEg47gjBCv5mQe/EPXm9N61
         R8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPcH8XLgYo97PzQXFtpwVWSfZRsC44f58GQxeG6ib0I=;
        b=esQo0I16D19uY4edk/n+124EWSbkcL41IzW7M5C3i0MvDwrVKyKzEo9P/lIpvPuy5c
         O6RovshysId+BaC7FpaA+leCj+sEj09bOmgGM92Y4Bv1KxmXafS4a0Vj3sAbd7Mvd17B
         fmhiM88RimgOpV3lp+VNceKl4NU/ytn7dXnHuOn/Sq0oHjY81GXvs0QUpmImifL745AK
         oQwwLnuX6gP5dlVc/6SJCbJquggXDMlpG4AJAsceGY1DO4EUywlBw8Xqr6JX9zbKKXNW
         /sWWOpu1ElAynJO4pmjVJOjomMscZw20a7gtZ/yzwIrVx5FBmyxPhVItwx0wtuJBi2Wm
         B9yQ==
X-Gm-Message-State: ACrzQf266xTpcM02Noqh0bk1MZWJWfIfRhYC3mRIVUTN//CyeJB+eTcJ
        L6Kf+cyfUplGUAYaJAUjuBA=
X-Google-Smtp-Source: AMsMyM47EiytB9HzkrV6vSyhEHN1+zmsPNAc4IhXeuL35QtRv39Lzvcj4LllqDnFpD/p8fh8OxGs1g==
X-Received: by 2002:a05:600c:4849:b0:3c6:7e82:a9d7 with SMTP id j9-20020a05600c484900b003c67e82a9d7mr1631928wmo.75.1665339270638;
        Sun, 09 Oct 2022 11:14:30 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:30 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 7/8] serial: 8250/ingenic: Add support for the JZ4750/JZ4755 SoCs
Date:   Sun,  9 Oct 2022 21:13:36 +0300
Message-Id: <20221009181338.2896660-8-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221009181338.2896660-1-lis8215@gmail.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

These SoCs are close to others but they have a clock divisor /2 for low
clock peripherals, thus to set up a proper baud rate we need to take
this into account.

The divisor bit is located in CGU area, unfortunately the clk framework
can't be used at early boot steps, so it's checked by direct readl()
call.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 39 ++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 2b2f5d8d2..f2662720d 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -70,7 +70,8 @@ static void ingenic_early_console_write(struct console *console,
 			   ingenic_early_console_putc);
 }
 
-static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev)
+static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev,
+						     int clkdiv)
 {
 	void *fdt = initial_boot_params;
 	const __be32 *prop;
@@ -84,11 +85,11 @@ static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev
 	if (!prop)
 		return;
 
-	dev->port.uartclk = be32_to_cpup(prop);
+	dev->port.uartclk = be32_to_cpup(prop) / clkdiv;
 }
 
-static int __init ingenic_early_console_setup(struct earlycon_device *dev,
-					      const char *opt)
+static int __init ingenic_earlycon_setup_common(struct earlycon_device *dev,
+						const char *opt, int clkdiv)
 {
 	struct uart_port *port = &dev->port;
 	unsigned int divisor;
@@ -103,7 +104,7 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 		uart_parse_options(opt, &baud, &parity, &bits, &flow);
 	}
 
-	ingenic_early_console_setup_clock(dev);
+	ingenic_early_console_setup_clock(dev, clkdiv);
 
 	if (dev->baud)
 		baud = dev->baud;
@@ -129,9 +130,31 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 
+static int __init ingenic_early_console_setup(struct earlycon_device *dev,
+					      const char *opt)
+{
+	return ingenic_earlycon_setup_common(dev, opt, 1);
+}
+
+static int __init jz4750_early_console_setup(struct earlycon_device *dev,
+					     const char *opt)
+{
+#define CGU_REG_CPCCR	((void *)CKSEG1ADDR(0x10000000))
+#define CPCCR_ECS	BIT(30)
+	u32 cpccr = readl(CGU_REG_CPCCR);
+	int clk_div = (cpccr & CPCCR_ECS) ? 2 : 1;
+#undef CGU_REG_CPCCR
+#undef CPCCR_ECS
+
+	return ingenic_earlycon_setup_common(dev, opt, clk_div);
+}
+
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+OF_EARLYCON_DECLARE(jz4750_uart, "ingenic,jz4750-uart",
+		    jz4750_early_console_setup);
+
 OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
 		    ingenic_early_console_setup);
 
@@ -311,6 +334,11 @@ static const struct ingenic_uart_config jz4740_uart_config = {
 	.fifosize = 16,
 };
 
+static const struct ingenic_uart_config jz4750_uart_config = {
+	.tx_loadsz = 16,
+	.fifosize = 32,
+};
+
 static const struct ingenic_uart_config jz4760_uart_config = {
 	.tx_loadsz = 16,
 	.fifosize = 32,
@@ -328,6 +356,7 @@ static const struct ingenic_uart_config x1000_uart_config = {
 
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
+	{ .compatible = "ingenic,jz4750-uart", .data = &jz4750_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
-- 
2.36.1

