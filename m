Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD86506F08
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352664AbiDSNs5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353245AbiDSNsN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529F38798;
        Tue, 19 Apr 2022 06:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A982A61726;
        Tue, 19 Apr 2022 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82131C385AF;
        Tue, 19 Apr 2022 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375751;
        bh=VizbppVwzPYdQPDTL7NxrAMjSGA3HHnCFb6Pzlcg7cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewcomR5Y+ebhEER2jEsmmEKS/5FV86pDTEgeOQLxiozH7E0tm578fLHS1YYtVXf6Y
         D9fxFVuX1bjJa3WJD1rU9pxOwPFHjkiSj0XoD3GwlA9L252sd9q8N/PHPkjkvFCtAn
         k9k7I3mGsf29zuf2FaLzo9lrKBip8FJn5AMZkfh+pAPB7jcGBApFAL7YRSSvm96zlr
         UUQxLcM59kgkggbLPetkP6H/llR+WY7zHgb6OvzSaqxVdVRU74hWZ02nmqay1W/nN0
         Z36YNnqN7DBeFOPhQT8ZAba7fOItSy31B3qvefulS0ykv74DV92yrMGAp61HVmMz42
         +DpY44FhKTZZA==
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
Subject: [PATCH 39/41] [MERGED] ASoC: ti: osk5912: Make it CCF clk API compatible
Date:   Tue, 19 Apr 2022 15:37:21 +0200
Message-Id: <20220419133723.1394715-40-arnd@kernel.org>
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

The driver, OMAP1 specific, now omits clk_prepare/unprepare() steps, not
supported by OMAP1 custom implementation of clock API.  However, non-CCF
stubs of those functions exist for use on such platforms until converted
to CCF.

Update the driver to be compatible with CCF implementation of clock API.

v2: use clk_prepare_enable/clk_disable_unprepare() (Peter)

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/osk5912.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/osk5912.c b/sound/soc/ti/osk5912.c
index 40e29dda7e7a..2790c8915f55 100644
--- a/sound/soc/ti/osk5912.c
+++ b/sound/soc/ti/osk5912.c
@@ -27,12 +27,12 @@ static struct clk *tlv320aic23_mclk;
 
 static int osk_startup(struct snd_pcm_substream *substream)
 {
-	return clk_enable(tlv320aic23_mclk);
+	return clk_prepare_enable(tlv320aic23_mclk);
 }
 
 static void osk_shutdown(struct snd_pcm_substream *substream)
 {
-	clk_disable(tlv320aic23_mclk);
+	clk_disable_unprepare(tlv320aic23_mclk);
 }
 
 static int osk_hw_params(struct snd_pcm_substream *substream,
-- 
2.29.2

