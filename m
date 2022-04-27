Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ABF511626
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiD0LCm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiD0LCY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 07:02:24 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8463E3854;
        Wed, 27 Apr 2022 03:40:47 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E9356CC4FE;
        Wed, 27 Apr 2022 09:57:49 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C3909200003;
        Wed, 27 Apr 2022 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651053429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OljYX8T7FsVZPSXMLNUJCohapQMxVrJMDIq7e2J5A4=;
        b=FTv55tITzCMYcQLjzkavslm8rXVNjPrhdKy9Gj5jCHzpJo6UjjgqtdcRRRrp2BCZq3IjqQ
        5ZHGPqtYPBVrzv+cTdFR77MA1ndlr5Tm2Hd8TueDhz+6eE8TDPOLn1pvToUtCtytWoEQ63
        nHDC7AFgm3vymRE/qRYs6jGtIbxusg6D0YWweXPqlZ5WH+McatODhp1NJiYWS00ODn6KXg
        H+A7pm3fiwVNrSnBeI80cKX+kb0LJZE2b8NNqlY/yHJJZJcwoWFoYOHrjwo/rQLym5KDOh
        Et/OZsSlbsCxMsCsGDRyRLlYSQC+Nn1ASU2d0vbx4abd1YA3pkD7p8r7LEEV0Q==
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
Subject: [PATCH v12 6/9] clk: renesas: r9a06g032: Probe possible children
Date:   Wed, 27 Apr 2022 11:56:50 +0200
Message-Id: <20220427095653.91804-7-miquel.raynal@bootlin.com>
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

The clock controller device on r9a06g032 takes all the memory range that
is described as being a system controller. This range contains many
different (unrelated?) registers besides the ones belonging to the clock
controller, that can necessitate to be accessed from other peripherals.

For instance, the dmamux registers are there. The dmamux "device" will
be described as a child node of the clock/system controller node, which
means we need the top device driver (the clock controller driver in this
case) to populate its children manually. In case of error when
populating the children, we do not fail the probe on purpose to keep the
clk driver up and running.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 052d99059981..69c0eb0eabd1 100644
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
@@ -996,6 +997,10 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 
 	sysctrl_priv = clocks;
 
+	error = of_platform_populate(np, NULL, NULL, dev);
+	if (error)
+		dev_err(dev, "Failed to populate children (%d)\n", error);
+
 	return 0;
 }
 
-- 
2.27.0

