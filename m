Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553C924817D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHRJJD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHRJJD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAAC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so8913733plr.9
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqFQaMaVlN4v+XRE6EAAx4lkt2C6k9NLYs6BovvOyBc=;
        b=UZr4UZatqrKO0ubHbKVjVPTklfLD7eRdgYeLoDEY8XiqtxxuLF5MlbTmTAnlvKIuur
         qisvk1crWeSNSbWp7UbB7SAaIBBGDCZ6g0kU2sUKlYzFUTBWNv4AL2g8JUvXc4m7aKYJ
         b0dEBbcahNhPX1/mq0evrOdgJ6dSor0XWQHVyfVWIfT9/d+BrCEmy6WjnGlw7BBVEaLL
         FRQf+G70KEaZInnduuaLwoSKcZ1T33uCzUyTbGcI5mfCdLWOS/yBL64hgYQvgAy5cVSg
         Z3+RawF3qRfwElFnmPjJbHBaDbZjTMw562O58qulXuwe2vwhxc/N7jOEyQhLydUbxblY
         JJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqFQaMaVlN4v+XRE6EAAx4lkt2C6k9NLYs6BovvOyBc=;
        b=V8wMYyEOQIPNxMrroFIl667jkKCarII9bk4fOq/JnRYt+p3Wu2Xl5uIJFqG2bTJSgO
         o+5VuE2O5j/ZhXN2/EZUw4hP3zWbv8b7SwrZu0hnzBP68AVVDepn3Q8fxLX35vuNQerq
         YlmCLAxJGSWwajVPzHlaJvBUhzwjaxWIlXSiAxYvB4f5A8liBzv0PS6L6PfEPx4W4BE4
         NU2Ssiz0bAaifJoNHx/ZMPOHm22WInQlpSkAzW53T2H0zJP6BtJ4nQVSPNyPxl+T+oeL
         bIiDE2pLflU8JkC/ft9F5U5BFyc/RR9tvR/vOlfqQhhS/OYRr4qgdDKCONXb5HeaThoO
         JqGQ==
X-Gm-Message-State: AOAM531Iey47WyUYZjmmBhpYo1kWcqXNLiSkbAvZ4JKQs33rWO1Sk0ah
        s6eEgi8oyGWCJ3QwpmMoucY=
X-Google-Smtp-Source: ABdhPJxKJM40J5sx4r4o+WkzMEBYJDOkH3btUxfBgjlZp4lLIUCztC+khbtlgw5/iKD37y5HRi4qSw==
X-Received: by 2002:a17:90a:c7:: with SMTP id v7mr16031880pjd.139.1597741741564;
        Tue, 18 Aug 2020 02:09:01 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:01 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 27/35] dma: tegra20: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:30 +0530
Message-Id: <20200818090638.26362-28-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
2.17.1

