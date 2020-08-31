Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF46F25775F
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgHaKgb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaKg3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2DC061575
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n12so370804pgj.9
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMv70IDUEMQUzl056A1NNcLWNKMQwzUiTFHNxBzdUH4=;
        b=mxSEz49Psv3VicLizI6aM+uQCHlFi0MF5j/ERdm5sGHe1DzyRFwThQ+0BdZeTPM3Eu
         z+aUNWfPR+m5koI7e5pPVDLMctw+P86dChuQWMu+oBCJ900eC5zXmtSEO+Ea+SEhpjWH
         R3gtC5+zlUpfNukKZjP2euy+egubmWOFkA2LjpHzYvatLnatbLyvjkwYWB5BqvdkMPeI
         jIRQVmkV40AKwGiAX2c8lyTPOGDtqDcD/FCLugkqtVi7VKQuquAz+9yS1nwrCsU6R6Rd
         UJd23GlgEjZHZ/fbjXROvLXpVJln7cYDVYD4xqudhECF99RuL23uFZ0xO/o+aPJEk4vr
         dQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMv70IDUEMQUzl056A1NNcLWNKMQwzUiTFHNxBzdUH4=;
        b=a3F9rl1fQFAa+nVyTZBzoc4WcAP4b4iuy71n+rhnWTX/G2w0VALzuxdzqr1d5oEc6T
         TYp9Glj5L7Ym9awyvTJXCOEJPkL2smCP8YeY1a07q8QG2lQ0hzmYcjkgxjW2j9K4T3oM
         rV3cAW5R+3sAb5VUIzvkpEwSeiXPFP/qrSq5e+McVLFAcMe+jv/yr5LzQVVtDmrHHpPM
         a/NEOzCinlas6d7MvY9rN4p3+sUuj/lOH1eKxToIorTQt+UtUv4uIZm+1/pG+iqTXMQv
         QAPGQyPm9pujM5sn/HYZQO1uJqADnOie3FkuNHX+G36IggEiYWcH1JrRxK/h+Dj7uT4t
         JJEA==
X-Gm-Message-State: AOAM532mdjFmrezj+cRzpz0PpW7ubAsU03FUKh1aXFVTBaDq7Z8Bzlo8
        oWKRiukn9Dm1mAcrLWyDI2I=
X-Google-Smtp-Source: ABdhPJyqCVXaAIrvRWmMbakWoHG7Y7+5RSu8ZvRpmVAlX9bS3v4Gzxq6kXzS2J3ABMxg8Tjt2mfTtA==
X-Received: by 2002:a63:4443:: with SMTP id t3mr780100pgk.9.1598870189197;
        Mon, 31 Aug 2020 03:36:29 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:28 -0700 (PDT)
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
Subject: [PATCH v3 05/35] dmaengine: dw: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:12 +0530
Message-Id: <20200831103542.305571-6-allen.lkml@gmail.com>
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
 drivers/dma/dw/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 4700f2e87a62..022ddc4d3af5 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -463,9 +463,9 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_descriptor_complete(dwc, bad_desc, true);
 }
 
-static void dw_dma_tasklet(unsigned long data)
+static void dw_dma_tasklet(struct tasklet_struct *t)
 {
-	struct dw_dma *dw = (struct dw_dma *)data;
+	struct dw_dma *dw = from_tasklet(dw, t, tasklet);
 	struct dw_dma_chan *dwc;
 	u32 status_xfer;
 	u32 status_err;
@@ -1138,7 +1138,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 		goto err_pdata;
 	}
 
-	tasklet_init(&dw->tasklet, dw_dma_tasklet, (unsigned long)dw);
+	tasklet_setup(&dw->tasklet, dw_dma_tasklet);
 
 	err = request_irq(chip->irq, dw_dma_interrupt, IRQF_SHARED,
 			  dw->name, dw);
-- 
2.25.1

