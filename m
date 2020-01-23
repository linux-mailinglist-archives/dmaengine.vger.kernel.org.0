Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9E147481
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgAWXLi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:11:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgAWXKu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so5192389wrt.6;
        Thu, 23 Jan 2020 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HLc3OL0GnoXw5khnAyT/yqV6VIfAbT2GF3DMXd7ekc=;
        b=LbJIua8Hoj7e5c421cMcRUIu6N1XxSqg3W0eBhUJWwdVJzKbK9mT9jPoEU+olaMEBK
         DztywQFA/QMuxmVzzcpKhIFEiJZIR8CUIzCxCKfcWG/JuPNIrN68zrbMF5vj+NNK3dN/
         Lm3G9nCyFpa8DjKHOlh7b53NAe+i8lCcMOwSS7eGY45mR4ltY207Yw6XBVPbs72Mbw2x
         Ft1OIrcqlVVCNzd5tivw6h8cVCDm2un0AmyveEX6/rwD4qZiaCUjjKNpt6Buao6uDJqr
         BrTncE2qnNI+BbXBu+Pt+463ow0wrldiSt3RWOocmskZpY49JxTrf6tXBe5LJioWpeZs
         7BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HLc3OL0GnoXw5khnAyT/yqV6VIfAbT2GF3DMXd7ekc=;
        b=A2b6+3oCksaPGM1yWYvDst+i/OpPwLDeTOJdcV4Ds6CsK62GNf1zIw/5il8CdMnJDx
         U63rKFKML0zLuicf62XnoEhpY4vsxYFzX1GQgL23BL6ZXbPemymmatUfmXsQfzIMR36w
         zOwg0dnQWRFZUnPy7VzQmpzis/99WXl3nWINEkEm0aTaTskCqQOqqCB4B/IewogoNnG1
         VmRM6wOHyMUQDuyy2w+rozwHH0xEQA6X7txdKmzFs9ZSpO8Cn0QiPw6GVR6Y3srNhqaH
         /2tehA3j3glcoIeQ0qG+bcl+4TtcihtcEM2FiF6JwuawLV5N0fBfTr5AElDU9NWqmyc3
         mqhQ==
X-Gm-Message-State: APjAAAWhPzLTiFVxmJfdBmtrsrMaqV0bkzHBc6PlMDjqnep74QKBVTLV
        4QFNX7gEgDIc9nAi5VgXwrk=
X-Google-Smtp-Source: APXvYqz78pbsO+RPBMG3UVZ7svyekL0Y06mKjTdJPrPCcIHHUb/q/RwG5Z8ZI7tGlrJyJtmexykunA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr425567wri.47.1579821048615;
        Thu, 23 Jan 2020 15:10:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/14] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Fri, 24 Jan 2020 02:03:15 +0300
Message-Id: <20200123230325.3037-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to kill tasklet when driver's probe fails because tasklet
can't be scheduled at this time. It is also cleaner to kill tasklet on
channel's freeing rather than to kill it on driver's removal, otherwise
tasklet could perform a dummy execution after channel's releasing, which
isn't very nice.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 24ad3a5a04e3..1b8a11804962 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1287,7 +1287,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	struct tegra_dma_sg_req *sg_req;
 	struct list_head dma_desc_list;
 	struct list_head sg_req_list;
-	unsigned long flags;
 
 	INIT_LIST_HEAD(&dma_desc_list);
 	INIT_LIST_HEAD(&sg_req_list);
@@ -1295,15 +1294,14 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
 	tegra_dma_terminate_all(dc);
+	tasklet_kill(&tdc->tasklet);
 
-	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
 	list_splice_init(&tdc->free_sg_req, &sg_req_list);
 	list_splice_init(&tdc->free_dma_desc, &dma_desc_list);
 	INIT_LIST_HEAD(&tdc->cb_desc);
 	tdc->config_init = false;
 	tdc->isr_handler = NULL;
-	spin_unlock_irqrestore(&tdc->lock, flags);
 
 	while (!list_empty(&dma_desc_list)) {
 		dma_desc = list_first_entry(&dma_desc_list,
@@ -1542,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
@@ -1562,7 +1559,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
 		tdc = &tdma->channels[i];
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.24.0

