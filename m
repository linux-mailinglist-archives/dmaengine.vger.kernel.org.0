Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B842B248160
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRJHU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E73C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so8959466pjb.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=McUFqZfFTy7mHwbw8y2LjePaGU9tqMqaDH3Woad5dgY=;
        b=quNcD+REfHJUFKr1UWIDaKLWMjbfeaClExyKApE6diSHw9g3sLeJ0e1QtbrpzfSvNB
         VxE/kfzViOqrRaiEpuxL/wptS2hykDn7TsfrRhgNvjq3P6XCcB1K+nTHiqpHheSZJP4z
         SpPAKzSRRWD9fudar2YsEgwvj0YDoLC1mGZrbCeMcrIuj/sBYv7XySnnth2vdD8gSanw
         Ly/ieR8FT1+ZGXj1yvrhBz2zqIQMO14JMDpdfgnkcQnfaLDZ9qJshZdKACnO2bGoMYlg
         ZeNhNuREZQsZqsKml/UO4cBdtGDV1bq/yr+oIO78+/gJcfS/FSJET5HklkO/l5lBGADh
         N++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=McUFqZfFTy7mHwbw8y2LjePaGU9tqMqaDH3Woad5dgY=;
        b=lttSeonbkAiCRCg5OmafR2ekOXaCpHnYvR4CPPzZzr+fQJjqxPw+SOLJes1KntMGYg
         lP0PEQGz+yHlqjIEHq9I1UbrhI0HYB+37fCjfVuNCTC+YC/Pvkw4OHuU2/Jd/O8mO5im
         iPgjf//nVRLhHS9WLDriL2cyMS7z7yBW057J7baLuDHj6lZm5PnXiTUhr4KqT3svKQBa
         CJYw7mTmGYSFfsUeKD0FmxaLkHzx1MoJmuXm+K/QRzEWl8CKIIbULMvd3WjQIcF9nmLm
         xYnP/2xbW+G+N5ll2lN++l3oaf+dFIiT8j4yg9HYDytgTVFlDtorakrNB7xOZukk0FGR
         QBvg==
X-Gm-Message-State: AOAM533i4LnCPONUs9Ry470U1ciJw1RhNj6kdeoNxEbSPZOa5gBRy2uG
        vosY1tJvhGELg0kPgWSwRSIQNols+Hy4JQ==
X-Google-Smtp-Source: ABdhPJyZE7x4dcA/z+FxL1FbWSqlcbvgk8DSy8tNHw3q7FrBsXW0sFAw2IApNRHmrJ3msU/8XEoUHQ==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr15970074pjp.143.1597741637715;
        Tue, 18 Aug 2020 02:07:17 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:17 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 05/35] dma: dw: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:08 +0530
Message-Id: <20200818090638.26362-6-allen.lkml@gmail.com>
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
2.17.1

