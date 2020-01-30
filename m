Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9162D14D5D8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgA3EmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:42:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37335 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgA3ElS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2583760wmf.2;
        Wed, 29 Jan 2020 20:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=tAXPvMTCrcqvRg6DMs4qAACn1NEWJid5v0kQH5SF5VgGTN/xj3GGOaQ8kvUKHayg2v
         De9yU6DvJ3iePTh39yziabf0/fHH+s9zKgE+wP6txQ5xH10buVKbLVcRLieCM408An83
         4BdlXbJFzZpNpevaGS1y3bWO2eaiRbp+0WPp1iTxXEtM9+XrVoeyVYpwExb+MImP5XSQ
         8qLBfn5CslXP7bMLUeoayjukOdgtgGvVKBETYa3AU7yACh8CdPuvcd1cZ7D8wZ5CkD4t
         glH2eXYayRge+OuW6culmBAJS+opwF70p1WA+6rwcg6OE5vFTGH8dB+rsDZf79lJ4a2q
         QNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP2sBFBGkO5bsS7Y1zFf5pSNHFa7vlci0txeV2iOQs8=;
        b=cBmLCQVQtaqlJUHqRbMgmmd6Zge9JSRYUNOjFUxCd4aqXZ6Sj0bnLxVvkNABoDTmsH
         IwRXpkBjwnBqG9NvA5ajab+shppaBR3jXLhItolpi6v8FZDY7GGpKeGDOmdkiC8gIYop
         Knd/xr/mASzsxviSDpLIWyMyUK+7XftTWMCGpxBpv1EvVIPXoRozmVJukUlHPyRj2gvR
         CJYQSvJS5jxsLt98ahWec7tu4Q4doCPHIHnk683iWS/sRUM5xWCSHN+pN0PPORcP40u7
         HDewPrh8CVI+an9XO+5vX22nF93wIfFSbvF2GUz3N0l7yuRLc3ZMiARwpjZLamXs0AkO
         v2Dw==
X-Gm-Message-State: APjAAAXJGkOjLbXUjRHbqwOoGRHBxnEtTuvyZgVYSPpAPXkB2jD8tlg/
        L9uCpObjcna/3BGKP6liiLeikbJ/
X-Google-Smtp-Source: APXvYqxjG7C8ZCuesf3lZQJXPgxsRAJzh4HtA8uJJsu8/cX1SnVRf98iVX9ukNflN1geDJrkRKTGxQ==
X-Received: by 2002:a1c:a381:: with SMTP id m123mr2876157wme.158.1580359275874;
        Wed, 29 Jan 2020 20:41:15 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/16] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Thu, 30 Jan 2020 07:37:52 +0300
Message-Id: <20200130043804.32243-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
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

