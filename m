Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFD4F686A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiDFR6Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiDFR5w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:57:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4B329275;
        Wed,  6 Apr 2022 09:19:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 559752001A;
        Wed,  6 Apr 2022 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649261956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIaJzlhcitEDdJTHuh7eIv4TamuZ7pCdIgFe1rezCFs=;
        b=doinac0WGXG8xI6pTwPTz1t0yLvaXQ5oTDbhvagMNywaeyc2Ocp+CJX8FzDFFt5cyeLy22
        adUVT6EjMxq49AAxAO/vsNFQvivLey4tAOCw2nYMxQnHVstxfvPjnjTDDueAs3qzzBZ3g0
        SzjWzFbQz7/sNzSAei8QPlIhgBGpWXG4JMAGZrUPTLE/2LfXwRXJTzvVJl6TP0l72ij3HH
        gLFOdpw6eyyxKLZCmDrfuPnpt7M1S4rL1DnLZlBV5PGZ3lWufNMQssjI2ZcXbRYmVzi7tW
        kdu5ZFXLVfzXH/nPGlFw1e0gSzjq+HaiXosI/70ZaWed7WevG1OM0QGKOPCkAg==
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
Subject: [PATCH v8 7/9] dmaengine: dw: Add RZN1 compatible
Date:   Wed,  6 Apr 2022 18:18:54 +0200
Message-Id: <20220406161856.1669069-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Renesas RZN1 DMA IP is very close to the original DW DMA IP, a DMA
router has been introduced to handle the wiring options that have been
added.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 246118955877..47f2292dba98 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -137,6 +137,7 @@ static void dw_shutdown(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{ .compatible = "snps,dma-spear1340", .data = &dw_dma_chip_pdata },
+	{ .compatible = "renesas,rzn1-dma", .data = &dw_dma_chip_pdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
-- 
2.27.0

