Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4172C4D869E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Mar 2022 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbiCNOS2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Mar 2022 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiCNOS2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Mar 2022 10:18:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92819C2B
        for <dmaengine@vger.kernel.org>; Mon, 14 Mar 2022 07:17:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVO-00055P-FO; Mon, 14 Mar 2022 15:17:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVO-000f3e-HW; Mon, 14 Mar 2022 15:17:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVM-0097bV-AF; Mon, 14 Mar 2022 15:17:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>, dmaengine@vger.kernel.org
Subject: [PATCH v8 16/16] dmaengine: lgm: Fix error handling
Date:   Mon, 14 Mar 2022 15:16:43 +0100
Message-Id: <20220314141643.22184-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=uwe@kleine-koenig.org; h=from:subject; bh=lnYF+Rp4uQSBPl21vZvNytughSjblSgWjFEEAFtBkUU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiL04fQXumhMT235kSD6N70fAzqtECjOg0TFKxJsoj LkvENvWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYi9OHwAKCRDB/BR4rcrsCeMmB/ 9HLw37+Kw66dEv/fLAWEF9hJfFla6RSk571W/CW/fBH6caBGsM/akyUEWmm+1k6bU4+AljtgP87dD9 vhUL+UdNu56APpY2WXPuYSIS9W4HdfeHrNTMw8wlUvQ4IPqG7J/VUhVvpCJxefSU0fgaxJVkspifIs xG1T/h/g+08/wWJa36SfN5N3ndYN/xA8SnQUjU0rdNb1Cl1RqKSOjybjChvn3Fq39zHBUGoFIp+TFN FAF4JZUVdUs0xUxJ3NZxX4x73cxLBF1Kq9UxmFa0rN9RL+8U3WT7/ifDelFhEqH4O7OhzcC1BL9iQ2 tkyVEG73MiyEsKxMLULhLkPMwNHQCH
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's an invalid approach to use only a single devm cleanup handler for
two resources (without further error handling at least). In this case the
core clk isn't disabled if getting the reset control fails.

This also fixes the problem that the return value of clk_prepare_enable()
wasn't checked before.

Fixes: 32d31c79a1a4 ("dmaengine: Add Intel LGM SoC DMA support.")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/lgm/lgm-dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index efe8bd3a0e2a..f8904cf2d832 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -1463,11 +1463,10 @@ static int ldma_init_v22(struct ldma_dev *d, struct platform_device *pdev)
 	return 0;
 }
 
-static void ldma_clk_disable(void *data)
+static void ldma_reset(void *data)
 {
 	struct ldma_dev *d = data;
 
-	clk_disable_unprepare(d->core_clk);
 	reset_control_assert(d->rst);
 }
 
@@ -1590,17 +1589,16 @@ static int intel_ldma_probe(struct platform_device *pdev)
 		return PTR_ERR(d->base);
 
 	/* Power up and reset the dma engine, some DMAs always on?? */
-	d->core_clk = devm_clk_get_optional(dev, NULL);
+	d->core_clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(d->core_clk))
 		return PTR_ERR(d->core_clk);
-	clk_prepare_enable(d->core_clk);
 
 	d->rst = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(d->rst))
 		return PTR_ERR(d->rst);
 	reset_control_deassert(d->rst);
 
-	ret = devm_add_action_or_reset(dev, ldma_clk_disable, d);
+	ret = devm_add_action_or_reset(dev, ldma_reset, d);
 	if (ret) {
 		dev_err(dev, "Failed to devm_add_action_or_reset, %d\n", ret);
 		return ret;
-- 
2.35.1

