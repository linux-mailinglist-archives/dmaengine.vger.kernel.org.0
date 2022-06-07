Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8954024C
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiFGPWY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbiFGPWX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 11:22:23 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20118D02A6
        for <dmaengine@vger.kernel.org>; Tue,  7 Jun 2022 08:22:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8AAE824000C;
        Tue,  7 Jun 2022 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654615339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M/OyxSiNqHSbudragJ27ExREPsyLfkiRXs45HLbqDNI=;
        b=Tn3/46VfKzj0w1CaA0FfCSJxX7i9EFt27h+enB/sNyyO2FzwUPgQEYwCEj7VZ3oUCN2xgG
        oHVTueiYEWvcZRoaziuIIgrolRbp8dxInfOpyYfBbcEiDNCKASO9rU1XmlN92ORp63Iz+H
        QFGmUOG2nA2eMXKOC7GHuqzt4YuPA/0lMb8IFlWEiQp8sPUyyCpvd0XbDi+IRqN2nJAmCs
        FgjsHGH2L6PX/DJXvxfEK3iFYkRDVQ6zuhokJU+8s9vMnNdKcC99YRc2U9hLYqdv5gyy3l
        FUH4Fb4dRZfGKrRMq61CZwzjSKXur4amz1CXqcwWzRMtzwRxF8HUQB1vuiSoqg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 1/2] dmaengine: dw: dmamux: Export the module device table
Date:   Tue,  7 Jun 2022 17:22:14 +0200
Message-Id: <20220607152215.46731-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
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

This is a tristate driver that can be built as a module, as a result,
the OF match table should be exported with MODULE_DEVICE_TABLE().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

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

