Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2882E1ED6F2
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 21:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCTg5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgFCTg5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 15:36:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABBC08C5C0;
        Wed,  3 Jun 2020 12:36:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l6so3749950ilo.2;
        Wed, 03 Jun 2020 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dIAMuCC/A5PYohN0KXICQjv0ipT40UQi12lhKqfFpJg=;
        b=EhDZIgQUvtrVrX2ZzQDg0eOdeeEkvuoFE2dur2qomJ21YzFSR0zSu+QXLEie+QcWcI
         pqtiRkz0H+cuDyQ7YndIF05da+Uys1LWhKYpHa1/BAQkpxvAUQYuqXR2QNg4ST5lkWjU
         9eTM1MGOQQps6R7rkQUn9PJ8RWxhNIUrSXrAvF1Y54VrRe/WxXMjTUA6/eEklUBoJY79
         tDBNgLnsoaVHFh3lWGZIWv1e+ktDp52tXFkcBjGINC6k3FMwLIO9srj7HwNBAG7A44wx
         kZvMrd/1VaWheADlWPfTFeNq/dy3U19Gi2bSjlTSury3yuen+OXHF6ZOmYfpc8FkI66X
         iFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dIAMuCC/A5PYohN0KXICQjv0ipT40UQi12lhKqfFpJg=;
        b=NqpQ59RFnJfaNAba8bFpJpcOkHEa7VZTlXwTDGL8wSD2JaP3p726uJbs4zfiYBWDZh
         mpm+ys+ABW9ecxBuQcxehSsHaf0xudkGl+lR+jyfgbRTWZUvq8RtfGP5KB6V2aMW0Nbi
         xdq8fNmDKs24epK6wnNAbEzv5yeZdM6bmNZpRS3YzvHoWgYM5hHu/7vL2A9peu6dzDVD
         MQUO1ibiixABSk6AlcPoYKT+OfqLdeI2wDhHxydRokgFOaOhuDyPGfyCa++RhUUlRWKN
         6eom8iHj+kmgU8jqLTWg6/0YOQamHGyIHjUWmy6G9g20kgQxzdpVyNKAoIqOBrjh7V/R
         ft7g==
X-Gm-Message-State: AOAM533JLIdrz+uWvrV738ze5EI5rrQz8gnYst0AhdDiJXnfyPleex43
        X4LpAID6jeTiZw93Aip6S6c=
X-Google-Smtp-Source: ABdhPJyXUGwqgUh5G3Ykal7smWbXFaRo45kJz9GNEN8Kg5jD5/5LxA9AaMhMWGkRoSpvtuiq4hihOA==
X-Received: by 2002:a92:9e5a:: with SMTP id q87mr1083431ili.84.1591213016646;
        Wed, 03 Jun 2020 12:36:56 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id s71sm256585ilc.32.2020.06.03.12.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:36:55 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: stm32-dmamux: fix pm_runtime_get_sync fialure cases
Date:   Wed,  3 Jun 2020 14:36:48 -0500
Message-Id: <20200603193648.19190-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put_sync if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/stm32-dmamux.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 12f7637e13a1..ab250d7eed29 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -140,6 +140,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
+		pm_runtime_put_sync(&pdev->dev);
 		goto error;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
@@ -340,8 +341,10 @@ static int stm32_dmamux_suspend(struct device *dev)
 	int i, ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_sync(dev);
 		return ret;
+	}
 
 	for (i = 0; i < stm32_dmamux->dma_requests; i++)
 		stm32_dmamux->ccr[i] = stm32_dmamux_read(stm32_dmamux->iomem,
-- 
2.17.1

