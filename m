Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59B544E7D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiFIOPC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiFIOPA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 10:15:00 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28696712FA
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 07:14:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B312C000A;
        Thu,  9 Jun 2022 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654784096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yqqc+sX57VUv6x0xqxtveG3qFJraJsoM6L4mjEa0RTs=;
        b=HiDdskUvqDW9kQBwmII99+Sp3aCP8zKMSqFCcdKvYGRdE2zg9otZjaFDbi2woHP1ZcGw1D
        +oNFSeJ2dle73Z8GQJi042rCaLe4R2QMlI2Al+7G1ttZc1BQ5f0DO044Xgd7uyFvUNGW+e
        3UA8YELJJYpQtLUhuhFyP0FNPqO8JcT1X+NK9GbjYMCyosG4PU/XsaYgoyI/WMXD3Bx+aF
        aIgRpPV1/C98z/S9e/uyWw5cG/1L673GTtLLODJzVQQoeTsVU8pUTc5OTYkud9UgN3fJB4
        9MSWyErpEaA7PdTZngEzhPL/xi1qByV7m4sW3HvM3oSIJgmaA6mM7mVSXaAVHg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ilpo.jarvinen@linux.intel.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/2] dmaengine: dw: dmamux: Export the module device table
Date:   Thu,  9 Jun 2022 16:14:54 +0200
Message-Id: <20220609141455.300879-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is a tristate driver that can be built as a module, as a result,
the OF match table should be exported with MODULE_DEVICE_TABLE().

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v3:
* Added a Fixes tag.

Changes in v2:
* New patch.

 drivers/dma/dw/rzn1-dmamux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 11d254e450b0..0ce4fb58185e 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -140,6 +140,7 @@ static const struct of_device_id rzn1_dmamux_match[] = {
 	{ .compatible = "renesas,rzn1-dmamux" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
 
 static struct platform_driver rzn1_dmamux_driver = {
 	.driver = {
-- 
2.34.1

