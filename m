Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DB147484
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgAWXLj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:11:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53253 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgAWXKt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so4370914wmc.3;
        Thu, 23 Jan 2020 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxiPwqrpg97YIQpnnmiKVkwXa7j5aarnOTijl3cNiEE=;
        b=PqNT+1dztXD8+0QAtDUL3L2CcSTzrFIonPzJAPJvVHjiP97fqctFWwWlBF5VxzrUBV
         lMrHegpRFSPPRB0reJ2XSLh3QOBBk824fPucbkM/KzAsKft12Gv6IWCRzVbE64Zkg3ar
         8KpkR8OFdvavyqfS7sdbFTWoATY5cVJtsUvYJttN+KLLQMwAQjTbRix8XttkCX3KKefJ
         G0U5Blwhmr1azKY7LJeWEl4cr9XST641oRDgnHuxvkek1gNTS9gxYjQ+z/uwp8DVwd+G
         e5LUZhomSW140fla9BAmsWWnTCjF6qCHpzt0m74Z/q4SDCyqIfuRBT4vKcjwVS47beWx
         yvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxiPwqrpg97YIQpnnmiKVkwXa7j5aarnOTijl3cNiEE=;
        b=YI+k7tkY4BU4/0upvGcB+3NAM5yLVDWrQo+A9J6DqI0peSaUOMh6ha8oaocmTSB0jF
         unPfYWAkPkOjI6KvXxcrLLWjhgRCVoGT1YxvBtgTZz86Y1C1iXYpJw0G5lPmXJEbS63m
         00Lx30f4PbDgY6jNfY5xH5r8ZaCx31n7EihQbwqnCURYda13JMvhIfjwLgd83p/FwHEk
         1bIsnEDjNuRayZatT/mPL75VdagRn+d3p/8JfZyy8+5riyqteMjwH+CKuXce85VEvFow
         kZs/lgPEyONcVfdG5/B3mZ0XPhgcEKw81ESNgpzJL8ah/gw63nNEn1YL+osN1jI5la1w
         IFBg==
X-Gm-Message-State: APjAAAVKvm5nLesLR4O8kGI8xtLYym91rwsQTh9Lm4Y9J7wXVObDmEas
        wZZeWpKoFDYUoWnBFYiFWTg=
X-Google-Smtp-Source: APXvYqxYe2ONJh2cqACIU9hiNIHGZ12ItUDr/D3dtWsqTbEsjOvl9SVtermYtiNkIz/t/+dIcJM/ug==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr248958wmg.39.1579821047357;
        Thu, 23 Jan 2020 15:10:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/14] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Fri, 24 Jan 2020 02:03:14 +0300
Message-Id: <20200123230325.3037-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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
index 664e9c5df3ba..24ad3a5a04e3 100644
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

