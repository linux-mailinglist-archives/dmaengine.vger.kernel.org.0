Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8993625777B
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaKi1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKi0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E6C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so370141pgl.10
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgEwvj7i2+hu2/IIg+Gx7oQ7N3Lu0iixwmIHoLUDGiQ=;
        b=lYEV7b85Kb9M9uvyEXxPlTRU7c0KuRkdP+jDP9rGxBVp/5F8HV+gFnqsXOFL4zUeMd
         4x9WMeunZgTkhpbTeevWZgMTC0J67ZhKke0h1xDO/J7QxY9JIaHOOr62mfRiGjz5DH4b
         5ob4fmFkSGUscHXB8gFYAvsiEKtGxzR4TcA0p027Kzwqa78s91OLhSEq3LfDJL3a7n32
         2OF1ypHNbOiOFE1LANuoJ5fXgACFt8XA+WGICBONO6YXEP7VUTwTfZOT35SmNjp6ln58
         lz1Q/hAYru7BmLm888tiS0QYXTRP/MHDQEFpWiZ3o9Kk3SE2n1LNqMhUSsxl0E6tglQx
         gAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgEwvj7i2+hu2/IIg+Gx7oQ7N3Lu0iixwmIHoLUDGiQ=;
        b=rXdbmTfnR5h4GxQ9XRFcCJ0Wu3yB7G7bHC5BO6uIgYbFPvJU+OoAkeLBr16/hfRE0a
         FyAnpp9e7Zov39nAzGcvC+cdWA1JYCmOe5OUktV7QMH+NeP+uDmc3v3hWENj0weBFyiD
         iemyJ5fO1ZuwIbrvewB2PSi2KOBckqoL8+pUDx6VGyQNui85dn5q96AKANivBfaruzmg
         8LQeCKNKwB9f6292bRCM8mMssvizA0NS3X/ZN6HQ31wwNUsoBfIF43vMcIXG7NRiTsBm
         cnsOEENVxz1S/WJyy0EE7/F6pyv2VqpfSOcZIC/A3ffKunhmxBHFc/UV0q+qU+HSgub0
         iSrg==
X-Gm-Message-State: AOAM532s410zXdS8GffgrWHCelO9X77e46diKeh46f5EnYpNImr+IOmX
        dJ0sxLPyTDEcVwxGTQhB+gs=
X-Google-Smtp-Source: ABdhPJz6j7wuh6O+lVAG5Xabm20UfViYYYcFTBRdCID5pSp4JKqdGN03PTVF5WfpaiYTRPAH7FnslQ==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr744389pgc.147.1598870304605;
        Mon, 31 Aug 2020 03:38:24 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:24 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 27/35] dmaengine: tegra20: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:34 +0530
Message-Id: <20200831103542.305571-28-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 55fc7400f717..71827d9b0aa1 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -644,9 +644,9 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 	}
 }
 
-static void tegra_dma_tasklet(unsigned long data)
+static void tegra_dma_tasklet(struct tasklet_struct *t)
 {
-	struct tegra_dma_channel *tdc = (struct tegra_dma_channel *)data;
+	struct tegra_dma_channel *tdc = from_tasklet(tdc, t, tasklet);
 	struct dmaengine_desc_callback cb;
 	struct tegra_dma_desc *dma_desc;
 	unsigned int cb_count;
@@ -1523,8 +1523,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->id = i;
 		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 
-		tasklet_init(&tdc->tasklet, tegra_dma_tasklet,
-			     (unsigned long)tdc);
+		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
 		spin_lock_init(&tdc->lock);
 		init_waitqueue_head(&tdc->wq);
 
-- 
2.25.1

