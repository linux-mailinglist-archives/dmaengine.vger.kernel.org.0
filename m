Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DA257773
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHaKht (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHaKhs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB8C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so366443pgd.12
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUhAC5YxMZoBlpymep0zvE0KP2mCOGeZ0UjdaDRAwfA=;
        b=OhcaK6N2hlgnk1Q2RrjBmwQZfGYXDSKvCNe8ItIwvle/YB1K3eQ/1ZDkha93CJIBwK
         jzWVbMCPFZd46I7ivlX/k+3Bm7iELyKhayoXe23pbbHB+zHto/j6wXk+XblC3a4z3cvw
         eOpBT1BL81QnJVyPsMcEZKgToWWas72B/ajhIkojImw42XRjgU3FVmnEceynPg6HFCHI
         WaOLy+P0aOdEdkYYsAvLQWmbPYyDe0kNZ0Ua5x3TueRf81Ky4fl5Dp7+eSYOeCHspThx
         D1K7xmkhauI5isockYTtIdrY6gaqK69R8iCvF++n2AWwqoPFQp3Xx9/Ync+RhqNhkUO6
         MRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUhAC5YxMZoBlpymep0zvE0KP2mCOGeZ0UjdaDRAwfA=;
        b=W8paNI5jhIxQVQvb8RiDL18xs1Dw0xK3uvu88BG8hJgOzSPyHN/rmhemyq+lM5MbHo
         EAYObQjlPrAvBiETuq7c0TW0IEmVdSfECpsw7LcV9r+F+lfeuY+SHnK04nKLOfNsrMf7
         naq3cALzS6frWZXBYZC0SPwikAQUBEvtb3F7HBG6fQfbFMT3i9Hth9n4UhXyPRT6aiBG
         2OsvDox5W8HYS5+BP6HSnYh2801DAU7DdbcBY0Ia3tggNfqEPsVKS3gPHbtzW/o6HNFA
         QziNc5XMeSvP45IuFZeSLyXkBBY5QBvqWQnXE01L4CE+OAwO/uKXp6bqZD9t1iy+QX3J
         72NQ==
X-Gm-Message-State: AOAM531e/pIGYQAwYLmGyAyBKE/5NP4fy778N6qwFaNYLHz/UpLXtEI8
        0lQLMb7rUBcK3X5L3sZwIt4=
X-Google-Smtp-Source: ABdhPJzMekwFdMDsENSZ2EmotS3+AWdDzVQdcapISxsO2LfcrowaTtddxmetzle+lvfmbpIVjVhCJw==
X-Received: by 2002:a62:6dc1:: with SMTP id i184mr748687pfc.57.1598870267634;
        Mon, 31 Aug 2020 03:37:47 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:47 -0700 (PDT)
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
Subject: [PATCH v3 20/35] dmaengine: pl330: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:27 +0530
Message-Id: <20200831103542.305571-21-allen.lkml@gmail.com>
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
 drivers/dma/pl330.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 9b69716172a4..1e9a38139aa5 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1576,9 +1576,9 @@ static void dma_pl330_rqcb(struct dma_pl330_desc *desc, enum pl330_op_err err)
 	tasklet_schedule(&pch->task);
 }
 
-static void pl330_dotask(unsigned long data)
+static void pl330_dotask(struct tasklet_struct *t)
 {
-	struct pl330_dmac *pl330 = (struct pl330_dmac *) data;
+	struct pl330_dmac *pl330 = from_tasklet(pl330, t, tasks);
 	unsigned long flags;
 	int i;
 
@@ -1982,7 +1982,7 @@ static int pl330_add(struct pl330_dmac *pl330)
 		return ret;
 	}
 
-	tasklet_init(&pl330->tasks, pl330_dotask, (unsigned long) pl330);
+	tasklet_setup(&pl330->tasks, pl330_dotask);
 
 	pl330->state = INIT;
 
@@ -2065,9 +2065,9 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	}
 }
 
-static void pl330_tasklet(unsigned long data)
+static void pl330_tasklet(struct tasklet_struct *t)
 {
-	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
+	struct dma_pl330_chan *pch = from_tasklet(pch, t, task);
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
 	bool power_down = false;
@@ -2175,7 +2175,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 		return -ENOMEM;
 	}
 
-	tasklet_init(&pch->task, pl330_tasklet, (unsigned long) pch);
+	tasklet_setup(&pch->task, pl330_tasklet);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
 
-- 
2.25.1

