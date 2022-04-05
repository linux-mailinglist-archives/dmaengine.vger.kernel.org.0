Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7064F2D50
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiDEI0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbiDEIV5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 04:21:57 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83657AE53;
        Tue,  5 Apr 2022 01:19:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F39D54000A;
        Tue,  5 Apr 2022 08:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649146767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAtIbUPsxkJ2Vkxs0B9jhzXSzY5HA+HvzfhgI4EksRw=;
        b=Ouj1SGQVM0/KLHiCRdO9fJenz5aZCgBtpexeVONQD/1X6Fc5NWkhg1fyRf8aBtpI/ZDCD8
        5rqV/3j7Q6aXo069RKYoaEi61exVsqTOa3db01CFBxxm/r6jefyQwSLThWMxaeSELyzhR+
        DC5oWgisp3t9h/aESogLM5ogII7aDMLWndQclm24HNVPhLGePH0y8NnEHW0l1gVQgeif25
        Mk4/ObDp7xzy/1SoS9DrS25VSe5+SUtR9Pyw+nmUQSFgYbnlW4WfFfjFiSHsIUGn4AthfM
        n2EHC7ku1MCQHtlsLozj8oDNthwGmivGAFEql1m3wZMd8UDUBx1u9R3faYobFQ==
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 6/9] clk: renesas: r9a06g032: Probe possible children
Date:   Tue,  5 Apr 2022 10:19:08 +0200
Message-Id: <20220405081911.1349563-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The clock controller device on r9a06g032 takes all the memory range that
is described as being a system controller. This range contains many
different (unrelated?) registers besides the ones belonging to the clock
controller, that can necessitate to be accessed from other peripherals.

For instance, the dmamux registers are there. The dmamux "device" will
be described as a child node of the clock/system controller node, which
means we need the top device driver (the clock controller driver in this
case) to populate its children manually.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 052d99059981..1df56d7ab3e1 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -16,6 +16,7 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
@@ -996,7 +997,7 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 
 	sysctrl_priv = clocks;
 
-	return 0;
+	return of_platform_populate(np, NULL, NULL, dev);
 }
 
 static const struct of_device_id r9a06g032_match[] = {
-- 
2.27.0

