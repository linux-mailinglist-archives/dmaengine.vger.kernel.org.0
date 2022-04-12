Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9314FE8E9
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358919AbiDLTnV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359060AbiDLTmQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 15:42:16 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968433B56F;
        Tue, 12 Apr 2022 12:39:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 00F1E200007;
        Tue, 12 Apr 2022 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649792391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAtIbUPsxkJ2Vkxs0B9jhzXSzY5HA+HvzfhgI4EksRw=;
        b=Z5yEfUP2u6zl+zMupNYCcdj6Ryn3dn6jNqtFyLiYbPb5m0QjwwYzGe5GhyzV+/0KQwRGHd
        iMSe3Uv2GxpK2mIl8+XklvWnrjnxhZPTBAHQYSE1gKldBx3NdDZo5NqYH/UYlmj2dHIWUg
        8hjB1gSxplulHMXzHBjGHJ1J2Gr6fAO1dBjBN4aI9U1m0tZQdM8zV2tbhDJp6VNgDA96OA
        HMB43kV1FmTZ1n4XHUi6P1zBB5HozT9iFKXT3tqcuOKktVVlK5XdBmd0H5CqfytSyk4rfO
        MOflkpGKQZNps1wOnZqRdxrZSSu5UYZ0cd+IXhPX9e3Kh1+5oTVXjy5+3sLzTg==
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v10 6/9] clk: renesas: r9a06g032: Probe possible children
Date:   Tue, 12 Apr 2022 21:39:33 +0200
Message-Id: <20220412193936.63355-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412193936.63355-1-miquel.raynal@bootlin.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
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

