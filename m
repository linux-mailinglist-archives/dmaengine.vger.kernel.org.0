Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C101414FFC8
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBBW3y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:29:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47036 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgBBW3y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so12554779ljd.13;
        Sun, 02 Feb 2020 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=Foz5rILVXxvGYBMBZLrVoGtWArCXNaGGwQ6xHp1AzJMc9crUGa2ucphj3ibX0DovEw
         mriYWnlneCYIIAflakMGGPTTI+2icDh6V8XZqJvpQTAPZk31yHAOamprgbgPe2CJUrp9
         zoW5bbGA3v6nhenmjeGBu7zK5Cwt17OP8ZTgfOSh2ZiVsiEheAA/oifiCEmvcQSElDbm
         sWbR9Ab+VmcXaFKXr5TCsCIa3xlvP2ULMlSFX7X80X2Cl0CCZLLOjETaEiV1/AOBUXyR
         /i09JuIkxzURaG8Oo51ZXoXZ94LCbFlKBoeDqv/v1sTvxZTwj623oeMKgYxLxixbuvDB
         vupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=hbNiIFhbhbrIcNJR6YpMyXPtG1AMoVMUmA/UJ/fOGXjejTeVS9EdhvwOQ5KPyJYTYM
         lpH4NwavI8oRE2rjKUSB8oOENgOSmO5gS0bF0dA6qciK3MeyiFoqS2WffIygoXFHLIXK
         rtbREut/dgYigWFX9kWouK3VLYG/IY6xLiumPV9XZyU2l84fICCYoxbZh7PoYMmZIErI
         nMrAjgCsuE3zPCE08P8KgO30LM7SUVZj2j5PCcRN8J5QU5RKTtvGQVosOVcV3QzaiuzC
         fKhSDQN8jdmNPLg0Hfv79T6Kfnl2wH8WXQoPt9CT/LfZ5lxfnPiKPArYCBPRUffnhrmE
         HqHg==
X-Gm-Message-State: APjAAAWl60wygNT4U9wYsCENiKPm+kyUadasizj+O5vOpYO304g7kjjK
        tt7P0G4fB4WYH1XUDRsT/rxbOQPt
X-Google-Smtp-Source: APXvYqzRCGNXj+IOjPjeU03a0TzNCfEW4cu1YI3DZXwXaGg8TKKygCW7AJVzHhjJgyWzM5GUUJvbmg==
X-Received: by 2002:a2e:574d:: with SMTP id r13mr11918813ljd.63.1580682592154;
        Sun, 02 Feb 2020 14:29:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/19] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Mon,  3 Feb 2020 01:28:39 +0300
Message-Id: <20200202222854.18409-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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

