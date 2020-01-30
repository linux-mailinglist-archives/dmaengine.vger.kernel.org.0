Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666C614D5AE
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA3ElT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45018 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgA3ElT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so2279757wrx.11;
        Wed, 29 Jan 2020 20:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=ewBvbUsh6esZiVClIKP2egCsZsrz3+8h1EcFKmAPpx1WlYE0/IJtZ4OlQ9cehlwJg5
         PkDnrq70f9N1TJS8sxAYScfrdlfPXw5LKprbRcUEwndLb48wZvCp8gRMZrELS2Su/Fy8
         /0+QSbUPWl0aXtaD01BJN91zJwp7j8kzm2CxH0Az8kLDXyArNXKqP9tG+gEzy8ZSSOlM
         QCXZNIhS3WUcZeolhNoNpaIhc7kJnvWnqAwalpuIHpGsjGUxy6Sn+0kAnlVbbmcpvmLb
         lZqlAWzr3mbpU867haELoC2xBmH3f/27lvj3ZoxLOypL9iC4JjQCkfduBGBVDSI9yATe
         w1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=hggYi03XdwlzjZsUFQ4dwzj1NCkG6zVgXbccZNSvgFyXZKNRCMCbXwb1MmwuCqqH4h
         hTQvn7MMpm0r8COGezFgDdurlXBGr9WHVFGYAu4HuLa/eFfuFg9fLk3OQxOTQaDB/+MS
         VPns0+DdjLPeUOGMz+KW6brrAsnOf4jFQ8NFo0BkBPRclwdxokwWtcNStipP/wVTvTv2
         C4VjXwayK4l4pZRm8xHzM5t3LYzdgaj33JQv3BrB1ddElLPF5zpkobFnwIXYEEUma1zb
         0OQ/ueJxA8FuVrK9fJ/LzjwdBWDythEcgyPsM11jIOgVPh+Wx2e9IlZomv7HeAqp7VIQ
         Wkxg==
X-Gm-Message-State: APjAAAWopFNJkuViDNvwXeS7szVUpGBA/YtnKHMwPApmV34JgN0dTRVx
        oJ0bEugswrOLJzgVI4HxpoU=
X-Google-Smtp-Source: APXvYqz0K/W4fTigErh3b2DhGlMMyLWfPLfPpb+snnUboxZDO4MJMrVzZ0cF4MdGahfx8lC05hX0jQ==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr2824848wrs.187.1580359277055;
        Wed, 29 Jan 2020 20:41:17 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/16] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Thu, 30 Jan 2020 07:37:53 +0300
Message-Id: <20200130043804.32243-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
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
index 766c2c9eac8e..aafad50d075e 100644
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

