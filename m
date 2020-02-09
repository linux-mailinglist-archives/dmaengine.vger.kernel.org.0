Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F09156B66
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBIQlX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36434 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBIQlW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so2495346lfh.3;
        Sun, 09 Feb 2020 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=kUA1LK8YTQINod4T6ro54YvGWCZ+jO8dhfh9ab4pGEV11HEa+yOWp8AJOQXGricipx
         3nUIIhi2VxD5U2SYONzITD8fIANQ5m0tUQm4X9RyDQTUbP4+3luQDjHTJeAERtkxnKKJ
         Z/F7Vo/Rwi1qE5WvSJ1RerlscAnHjZEV/4L003HbO8EtN+5wXcd1+Ryj2+0supp7GZK4
         8r2eWvBsvVNb0766hzI+/LcRWxfAfv0L0aIeOxzvD0iwWrMfnnUOeKy8N6tsrrW3+XoL
         NXFv7atfCq4A4A86z50OxbKylihBwuwCe8Vfxt/DKP86/6Lc0NZUcIitkFJtkQKwb+0M
         jSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=XzAUa2G8ul4UjraU2OaITHvoCqdCPpxcBMCsnDA3nq7e2Kwjgh/2crzyBuWwqiHXIH
         fniKE2kS2p+FS2BEwRvEaT8w1AxQtZswyY+w8t7VCMBl/ny+qgZWYQhvKSE7Zd8y6uQw
         kdPlZUfnyIU8Up5U6sTpgbfoKyCTfNpUT7c/VJ1gKxeKPImRAwgvu9tWxpl233WgMLsY
         nx3U0E9Mg/2Cigzuuxdo0nq03FOq0tu4Sv2+kRzYLv5vF1PBpYjqXrSQiVkL+h1Cilko
         rwTkdFcj0oBnVeVekDsorrBwnRHumoXYqzPr8qRgKXG1/AV/4sqLPV6/a0Mq6mDY7NOd
         KViw==
X-Gm-Message-State: APjAAAU0M1wL9kaCsLSmIP8u9f37kpIkAurXX75nDGqF9hXloQImqFuJ
        l4DXy36Puxnb1EPD+WTTFAs=
X-Google-Smtp-Source: APXvYqzFWPpJ5ifahg8dzNxPuHjrLyHeDXGD96A9dFNCrXhgxkzygr0vn/zYraMdxaNJsZce7626Zg==
X-Received: by 2002:ac2:5f02:: with SMTP id 2mr4177081lfq.170.1581266480370;
        Sun, 09 Feb 2020 08:41:20 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/19] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Sun,  9 Feb 2020 19:33:41 +0300
Message-Id: <20200209163356.6439-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's incorrect to check the channel's "busy" state without taking a lock.
That shouldn't cause any real troubles, nevertheless it's always better
not to have any race conditions in the code.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index f56881500a23..766c2c9eac8e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1294,8 +1294,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
-	if (tdc->busy)
-		tegra_dma_terminate_all(dc);
+	tegra_dma_terminate_all(dc);
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
-- 
2.24.0

