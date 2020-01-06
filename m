Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45AD130B67
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAFBR2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:17:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34213 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgAFBR1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so44469156ljg.1;
        Sun, 05 Jan 2020 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZYwRmQjEuEhcnI0jgHwdUL+48TsLbPTNE42sZnH8KA=;
        b=iYfurDC+4LnXEIJp+HtC5iMq3ZWbYdun4NcEAYHPcn0iHrHLNVOq58rgnYALsqukzN
         qJxXCarMT+q/i91kHYkHG4p+KHz28fqrTN0XPCqDgDLqcl6GaInhaXXPqCFxLqKTC35m
         DVGTB3Lzu7oB1TO0epMjnIIMjxANiTIvDNJyxGxgFAb+uqY30EFOB8OCMo5wWpEqV5uq
         ExiRvPMIlgqGK10qdYQtX1GYguVEKPCE8p1LspPupRglQhVopcirQpkxYUFE7OBcH7Bt
         7Jm8/z9om5QivhZXQaFnq7ggF6e5PJ95Ol10lKg5hSNsBE2FCjTbz7mQttYb3Q1oa0g1
         a+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZYwRmQjEuEhcnI0jgHwdUL+48TsLbPTNE42sZnH8KA=;
        b=AROo6GDp9WiHsXMwydu2bLKnQa9En3Ir70p8YFCQTrXFSJdIKQD/mrCi9sVoD2fFa8
         A97vxsdin/fJhd46mQoehP8CuVR9nAxmkobClQOSwkJy8IRp8PT6FJqfGN+T12X7x+MD
         Qmajd8QB28Sag4Vm8etPI+HN153xUgVIl91Ugu3Am8lpy0thSxy+tSjtFEnIvW0MwZSK
         YdHIqijNLiVIUeJPKfgZf8E83ehrhp+F/o589tauyLnpmMtwY/d55JbyEU6BsrB0dt+1
         bu0Ns4MXQsyrDt537CsO2mQvMSlr2sUcH10d1/Cg54iOLSHwAG/m/6CHrdrta6bh4CkY
         0mLw==
X-Gm-Message-State: APjAAAX4EhQWzPbNd4Mig+cGeoNvNqlf7mMI1S7f7NmJsukadInzrwqk
        20du6VMqcwtgT3owc5CWziI=
X-Google-Smtp-Source: APXvYqxl/QrcxfoUVFXnSQoW4fuvf5RTKybtvq1KJ3GMF/49AyDIsJpn8p8lZjn1alLOUy1/8kdn6A==
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr58706047ljm.68.1578273445057;
        Sun, 05 Jan 2020 17:17:25 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Mon,  6 Jan 2020 04:16:59 +0300
Message-Id: <20200106011708.7463-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
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

