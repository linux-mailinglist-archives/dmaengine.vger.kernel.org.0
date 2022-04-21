Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B6509B4C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386990AbiDUIy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386977AbiDUIy0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 04:54:26 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8701DA72;
        Thu, 21 Apr 2022 01:51:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE06460007;
        Thu, 21 Apr 2022 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650531095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wvra6RNRuCu2P8jLSDcUUkmJcWIau45cFl07/k1NsZM=;
        b=X9Ujtf16lHjSNseNkFmDakFQLihk8giRrDco4U0MTL+dJalGgiT7bScvLjT+NLn9TKPnzr
        sX4dtaIWHuvBkqUxvDuovxqQHtxxD8ND3mmM33tdToY8TBGtQillWaf6l+2MpncV6pMEP/
        ixy9L17IqcnI+XUJz0BcQmGhDWWLd5+O988nzl7yIcf3gMn3iZX/JfbiE/dT7vWjeA1Fkm
        WcLlYEnsPO+WEYLEfJ2y/F/RUKsS+kbMN7Ab4L+GAS7sGgbopH37sHHCftlYo/ZuE+SEdr
        I+ksr7dgKc0b8YiDqRxYgcfvF1Un7iUfIrU6KjGl2VTTlJl8SwuAedT7xltlsA==
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
Subject: [PATCH v11 7/9] dmaengine: dw: Add RZN1 compatible
Date:   Thu, 21 Apr 2022 10:51:10 +0200
Message-Id: <20220421085112.78858-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220421085112.78858-1-miquel.raynal@bootlin.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
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

The Renesas RZN1 DMA IP is very close to the original DW DMA IP, a DMA
router has been introduced to handle the wiring options that have been
added.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vkoul@kernel.org>
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

