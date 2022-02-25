Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C64C435F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 12:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiBYLYz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 06:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiBYLYx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 06:24:53 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7D222193;
        Fri, 25 Feb 2022 03:24:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F1C3FF804;
        Fri, 25 Feb 2022 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645788257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcS1gM79z1ubwsDkiDMnQBqYcbRumBBw75m5IkrMpwU=;
        b=Kt94FyWCqQ16uTYQO6xJWn5Em91SXfjN6J/2KdGZ/wsMpWtpcOrkvpiNeD1XvIz7MOnT7O
        Y4OpdnpsmK0KN7NntQkOfnsWlVcSEZfyT1DMSZWKoztX7utQ0eYuFCF20KLyOF3rnCM2Qw
        AYceKjlJC53vt8Y6FbqX6y9KiJyHGxLhoOmR/jsB/abM1YhddQM0QtnLNSR2od6EUBatg2
        yF2bNLqRlM+Yp16+OD4H0byOpvkGjtakHJ6WeBvqX5J0nky+lbWr+2ZZ+evJIFklKGFGvu
        lbwFPRmhmxqyWBgQgoyn1DQOt9UzrP58Qa5eCotcmZivWAeOXOHu6lYJqsvsOg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 5/7] dma: dw: Add RZN1 compatible
Date:   Fri, 25 Feb 2022 12:24:00 +0100
Message-Id: <20220225112403.505562-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220225112403.505562-1-miquel.raynal@bootlin.com>
References: <20220225112403.505562-1-miquel.raynal@bootlin.com>
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

The Renesas RZN1 DMA IP is very close to the original DW DMA IP, a DMA
router has been introduced to handle the wiring options that have been
added.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

