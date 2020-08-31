Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA423257776
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaKiH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKiF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D14C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so377926pgh.6
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kF+5EmzIgniC513FnlQyviv1/SMov1djoUiBbesv88w=;
        b=eLsXeKCDI0V0cyOpFx3ZzYgcYmcxQ5kSyMvOhCXvABN/XmKDN15X/op2AwonJQvAT/
         JUdhSmfR9JqwdzExHFUToh5zzbBc8Nf+vMoI20w7hTS6IgULA/ruQYVb0yC5/xAcmUnD
         mVCu6l4OGbXRd9d/SchDJRXzKQ3uQTadHJ8iGGFEKP/F+3caRe1pVPWrRQRelTfHSyYN
         8AibhBqqUrwN9cQtT1xMSlNgPnF3aRH62a9smc+Ey7vwZ6TjQl3y6K06AjKZNC04CB8K
         sP72OjqLU5hJ77JHMeLxqXoJn2WgVPcOZG6G1hIH5QC8zXtHd/uTTITvGW1EuPe8nUGE
         Fn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kF+5EmzIgniC513FnlQyviv1/SMov1djoUiBbesv88w=;
        b=NAqFXmrVRATfceD23zrXzhf+untdxYf5eBw1LyErTv8sY5zrfi39Qk/WbZKryWmNLu
         5cq5uqfZJgorClNeKNyTLVVf/4t6zMU57po5FzriX9dgikUT4qXHaCJG0PAmAX6vfd4x
         stB6UZYqxZAPgpbDyMfLbsRX0GBHVH4X7tIbW80C7YMhCxKUqK+4MT5P6QUOjAqNLeY9
         O+msiyMV01aSOmzYxanbqRplVOhwvqO3ld069/jRJSyZUVo+lPThGK2tJRRdAyph934j
         7X28YvVJDqPPiY3q4Us5Yk2DnD1XNIxuC6YEgvc+u2DvIsNZWR5DrlYTFlewmlTlKj99
         HZhg==
X-Gm-Message-State: AOAM530jgv7ZSNS0WO9mW4H99ZeqRATF8WnZi9QKe5mIjTVxtJwWsaVT
        qQ42w8mNXKT2aWnDFRx55uU=
X-Google-Smtp-Source: ABdhPJz74vTVxahk2jNr1WhuNGIT1bMHOzSNHX6Pj7PnkCUF1jvxxOkPok6D6INCGzHrdnvQAZx4+g==
X-Received: by 2002:a63:c904:: with SMTP id o4mr685986pgg.99.1598870283427;
        Mon, 31 Aug 2020 03:38:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:02 -0700 (PDT)
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
Subject: [PATCH v3 23/35] dmaengine: sa11x0: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:30 +0530
Message-Id: <20200831103542.305571-24-allen.lkml@gmail.com>
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
 drivers/dma/sa11x0-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 0fa7f14a65a1..1e918e284fc0 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -323,9 +323,9 @@ static void sa11x0_dma_start_txd(struct sa11x0_dma_chan *c)
 	}
 }
 
-static void sa11x0_dma_tasklet(unsigned long arg)
+static void sa11x0_dma_tasklet(struct tasklet_struct *t)
 {
-	struct sa11x0_dma_dev *d = (struct sa11x0_dma_dev *)arg;
+	struct sa11x0_dma_dev *d = from_tasklet(d, t, task);
 	struct sa11x0_dma_phy *p;
 	struct sa11x0_dma_chan *c;
 	unsigned pch, pch_alloc = 0;
@@ -928,7 +928,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	tasklet_init(&d->task, sa11x0_dma_tasklet, (unsigned long)d);
+	tasklet_setup(&d->task, sa11x0_dma_tasklet);
 
 	for (i = 0; i < NR_PHY_CHAN; i++) {
 		struct sa11x0_dma_phy *p = &d->phy[i];
-- 
2.25.1

