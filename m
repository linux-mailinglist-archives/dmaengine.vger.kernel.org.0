Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D8257772
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaKho (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHaKhm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3ECC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so2740125pjr.4
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KOhGV1Rna4c8s/7Lc6zFb2hqJM7f3JOucj0osRX2mU=;
        b=FP1XLmh49SKsQdgFA/KV/CVEf1OMK0D64hIO2OIAWerQLl6IbiHaUdqR6LDjLS7sF2
         fEiD0RFk+SKc6tbN1SQ3ykOyNetgpepnp+Rr4fRp0Y67e9xyr0cz2GkeGDHrCvYGMK7A
         VtPbkKMgqn6Ucq4ZwDDfyw+ox4CHsbqz6O2RNm80ryepITEW57TUIcd/OyJdtW5Cj10x
         u/gfUZ5i7w+8amOjOu+Ocd6fK9oUGPZ0P0//L+8O1yc25VvagJsj1/NnLAtCG0Vaq2J/
         wvqG0GJP3XdNqKPjwLmpENNTbwsD5URQFpYp3GMORmX0yiZkw9nXiIdbrm9PzbVhxy/5
         yK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KOhGV1Rna4c8s/7Lc6zFb2hqJM7f3JOucj0osRX2mU=;
        b=JzhiDpfkg/rtZfP4ct7Xs+QaEbYe1gKPtUNLtVg43E5BaETFHQlUj2VNNxbrSTtOfN
         tY0KvAYr/euYfaM81DaoN2BL0bPfTuQgPewE31GmJKkGZnbObdaLThZyXSQmaEwudq+D
         NCgYB1SvHhimNJEWryWTkm/ZaJdXclaJTWTMIfLf++HJ/5S3gEvjtlWom4HB81C7WABQ
         /OI8jopwyYP3PF+mYdhuRxubLFyY70BALdKX1SQjXrDOlZSdSpzGxSOuLpiT8pGCCgex
         8PoZxk/NdkBH/ZwLCwyC9ofx5aPaNqvMYnp504jIya0jBDvzwZgpikLKhcedDMgG2CtN
         A/LA==
X-Gm-Message-State: AOAM53069oftgEox+9lC4O1WWSOiCqYmE2lldaaZcThNCeXhK0YTd+pT
        f9T1rzRAlBJl6Rh9Yyl2akU=
X-Google-Smtp-Source: ABdhPJxsHA3TH3WFQh7A7mGufWk+zLjdcdhEGZYQpBF0PlbwRz94R7je6suPipG4l63CJxRZ1++zKA==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr851901pjr.164.1598870262330;
        Mon, 31 Aug 2020 03:37:42 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:41 -0700 (PDT)
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
Subject: [PATCH v3 19/35] dmaengine: pch_dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:26 +0530
Message-Id: <20200831103542.305571-20-allen.lkml@gmail.com>
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
 drivers/dma/pch_dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index a3b0b4c56a19..0cd0311e6e87 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -670,9 +670,9 @@ static int pd_device_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void pdc_tasklet(unsigned long data)
+static void pdc_tasklet(struct tasklet_struct *t)
 {
-	struct pch_dma_chan *pd_chan = (struct pch_dma_chan *)data;
+	struct pch_dma_chan *pd_chan = from_tasklet(pd_chan, t, tasklet);
 	unsigned long flags;
 
 	if (!pdc_is_idle(pd_chan)) {
@@ -898,8 +898,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		INIT_LIST_HEAD(&pd_chan->queue);
 		INIT_LIST_HEAD(&pd_chan->free_list);
 
-		tasklet_init(&pd_chan->tasklet, pdc_tasklet,
-			     (unsigned long)pd_chan);
+		tasklet_setup(&pd_chan->tasklet, pdc_tasklet);
 		list_add_tail(&pd_chan->chan.device_node, &pd->dma.channels);
 	}
 
-- 
2.25.1

