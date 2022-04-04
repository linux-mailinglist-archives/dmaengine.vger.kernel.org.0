Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA04F1627
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355893AbiDDNl1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355884AbiDDNl0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 09:41:26 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B407DFD0;
        Mon,  4 Apr 2022 06:39:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7D29DE0004;
        Mon,  4 Apr 2022 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649079566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcS1gM79z1ubwsDkiDMnQBqYcbRumBBw75m5IkrMpwU=;
        b=nD4Y5KNg8sYt0hBmjJJRMVgltelfiF/zU/BfOXCv8tUPEPs90DZ2zScmQ5tVOPaSzbfay9
        IY0bEbAOMPUw4tyfzmxrwsHKeglUsrxkeT0UNuqTBZ0zON4vozxlX1Oa3TWjJDl+FU2GFx
        4oBsP41YAmzWYZ4H3RGl+ALTunUFEZOjjNQL0+L7j9rMs7TiLBuV0X1GjuXplZD0pLIwsd
        gwqWzpe7a3NLNmPibwihqpMfv+mcNq+C9CHjTv22qePkGQzKGMVZggB8EHRd1vnXAYamVu
        AmzrcS69RzVlM3CBQIydbjB+DVByTDG0atQIp7fCkEcmwq1ZB6+JSzal6RHbEA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 6/8] dmaengine: dw: Add RZN1 compatible
Date:   Mon,  4 Apr 2022 15:39:02 +0200
Message-Id: <20220404133904.1296258-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
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

