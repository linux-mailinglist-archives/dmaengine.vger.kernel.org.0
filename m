Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5751ED62D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCSeX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCSeW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 14:34:22 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEFDC08C5C0;
        Wed,  3 Jun 2020 11:34:22 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so3383380iop.11;
        Wed, 03 Jun 2020 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=57Tbh/vNYp8Z2Y2yrLwm25NVhHK8l73BmbXVjFnRkLw=;
        b=pUvnbtJgLEQazQZOyd1+rITOwOP5uHA0kod+Y19gDu0JQk7PiZgblEN2KHt/kVaor+
         Xj/rstoCyFcgqvklm8OxJjacZwMeHrWMswXjC2r4F+N0yvvBVwpcaORzBFAcimZhooOj
         uARgG/e0hWj3VjUmyygmuOYpIZZD6ho4pdcy1owLNMG4+LbeRfjIEhaV1AQqbz7KTTgF
         6PmA/7JMKGcU97C5Myle0WSO4sStNv7+9OIoTbp8lt4wH1PDR36cNVy87NVlnNnniQfZ
         GMaKgxDeHjx/HqBuyrXIUFEz6KrG4lieMtIyfGLmAxXjyXLgSOJbA3i3hYrIrbATAZgW
         qkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57Tbh/vNYp8Z2Y2yrLwm25NVhHK8l73BmbXVjFnRkLw=;
        b=MuSmWpUR7JWREqYZ8yyVvx96iwwh6Vzm7B4CmPGWwo2gHz+yBsqXgEpI79n84gDsNI
         Gq61ANjtj/sgp4fs+f2/Y8ImkZBrrE+90RCm2JNh2y5enwv0YZRMFONuOGXzE6ldDfr+
         Dh9U8vf+uFlZWIpYa5O2YCsv03ZtTBqW7BkOTezLyfYcNSwuAHMpd9X2zChY6W2Ex80F
         If5ehXopeCZfwq3+e+owHAv15mP24mBdUmHPuseCmnm+ciE/yLOCEdMhX5ut3ui4KanG
         C4wQKzhDuk7utuOpSUfcrDOVylcFH94LAoY/N1Ndky5QDQ4NRERfV8Va4qVbEJV5ZzXb
         xIfw==
X-Gm-Message-State: AOAM532ODB8vab73SlfLClfGChhxzsi0ibmEmIPyb/zbbOTEd72u8k/0
        rF2vAoK9tSPAydfQW4W7yAc=
X-Google-Smtp-Source: ABdhPJxLIWC1I4Cme7nGbQTtDsJkrK6nxiGSfd+zgYibWXQbzGeLUy/MDQWIW9M67LGwWq1uEyshDQ==
X-Received: by 2002:a5e:8305:: with SMTP id x5mr953041iom.47.1591209262037;
        Wed, 03 Jun 2020 11:34:22 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id y2sm158589ilg.69.2020.06.03.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:34:21 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] engine: stm32-dma: call pm_runtime_put if pm_runtime_get_sync fails
Date:   Wed,  3 Jun 2020 13:34:10 -0500
Message-Id: <20200603183410.76764-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/stm32-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 0ddbaa4b4f0b..0aab86bd97fe 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1169,8 +1169,10 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
 	chan->config_init = false;
 
 	ret = pm_runtime_get_sync(dmadev->ddev.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dmadev->ddev.dev);
 		return ret;
+	}
 
 	ret = stm32_dma_disable_chan(chan);
 	if (ret < 0)
@@ -1439,8 +1441,10 @@ static int stm32_dma_suspend(struct device *dev)
 	int id, ret, scr;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_sync(dev);
 		return ret;
+	}
 
 	for (id = 0; id < STM32_DMA_MAX_CHANNELS; id++) {
 		scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
-- 
2.17.1

