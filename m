Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A0506F59
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352998AbiDSNsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353182AbiDSNsL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:48:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F816F6A;
        Tue, 19 Apr 2022 06:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 390B8B81986;
        Tue, 19 Apr 2022 13:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C17C385B1;
        Tue, 19 Apr 2022 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375744;
        bh=W3qNGAAX2ECL+9vJh3xisWUOh4fEYqZMZtajKR6sclM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKr7WyMGRCWl7v/bvtIsgn5/V3JSlMflq4Q/DrYtsnDWWlhOP2f/QZz/mAStrQbfv
         OSwRVbecQTirW0bkg8ct8ZX3ZvidG0fdpIIrdb2ikG6e1iNCk3oIpODN2KEsBn4jaL
         iL1TEBzQNkc83ablhzvNcTWLRxSQzhIsMUM2UfvRw82yolwxFIjf4Y+jmK8MZi28dA
         ifEP8JGP4wd2T+YWPd4y4nvn8O71HicpNzx1mj7AHN8SDPpjQNwTaZ+3S7klD2C0Uk
         BJ3IJCwHBlprKwQ/njIgRCNqvECW/GFDYnEeMMMA/9HeNtfHcZKV7YKlqEhQpUs3u3
         p4wr3YRVJnM7w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 38/41] [MERGED] mmc: omap: Make it CCF clk API compatible
Date:   Tue, 19 Apr 2022 15:37:20 +0200
Message-Id: <20220419133723.1394715-39-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419133723.1394715-1-arnd@kernel.org>
References: <20220419133723.1394715-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

The driver, OMAP specific, now omits clk_prepare/unprepare() steps, not
supported by OMAP custom implementation of clock API.  However, non-CCF
stubs of those functions exist for use on such platforms until converted
to CCF.

Update the driver to be compatible with CCF implementation of clock API.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/omap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5e5af34090f1..57d39283924d 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1374,7 +1374,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(host->iclk))
 		return PTR_ERR(host->iclk);
-	clk_enable(host->iclk);
+	clk_prepare_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
@@ -1382,16 +1382,18 @@ static int mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_iclk;
 	}
 
+	ret = clk_prepare(host->fclk);
+	if (ret)
+		goto err_put_fclk;
+
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
 	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR(host->dma_tx)) {
 		ret = PTR_ERR(host->dma_tx);
-		if (ret == -EPROBE_DEFER) {
-			clk_put(host->fclk);
-			goto err_free_iclk;
-		}
+		if (ret == -EPROBE_DEFER)
+			goto err_free_fclk;
 
 		host->dma_tx = NULL;
 		dev_warn(host->dev, "TX DMA channel request failed\n");
@@ -1403,8 +1405,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 		if (ret == -EPROBE_DEFER) {
 			if (host->dma_tx)
 				dma_release_channel(host->dma_tx);
-			clk_put(host->fclk);
-			goto err_free_iclk;
+			goto err_free_fclk;
 		}
 
 		host->dma_rx = NULL;
@@ -1454,9 +1455,12 @@ static int mmc_omap_probe(struct platform_device *pdev)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
+err_free_fclk:
+	clk_unprepare(host->fclk);
+err_put_fclk:
 	clk_put(host->fclk);
 err_free_iclk:
-	clk_disable(host->iclk);
+	clk_disable_unprepare(host->iclk);
 	clk_put(host->iclk);
 	return ret;
 }
@@ -1476,8 +1480,9 @@ static int mmc_omap_remove(struct platform_device *pdev)
 
 	mmc_omap_fclk_enable(host, 0);
 	free_irq(host->irq, host);
+	clk_unprepare(host->fclk);
 	clk_put(host->fclk);
-	clk_disable(host->iclk);
+	clk_disable_unprepare(host->iclk);
 	clk_put(host->iclk);
 
 	if (host->dma_tx)
-- 
2.29.2

