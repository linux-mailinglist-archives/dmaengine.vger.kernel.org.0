Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CFC156B8C
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBIQl7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44892 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBIQlg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so4365049ljj.11;
        Sun, 09 Feb 2020 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/WTniiOO2X2m80SkKX+NZuwJfpEeKG/rQODBJmhOvY=;
        b=vZ11QHCvSNIXXBRKgbQ0LSMg2i6m04zUnJamAofATaKXc1HArN/MVt/URNU8vJiV9t
         JxVKQbSWif8YXxLDlzjBZlRqHT65vs/YpT9Xtcxykd8wYMdjSVC8Odft9VPUH0nTjXBz
         wBQWjpENBhHt/94gz0k+OVnsoWh83lds7+Dbem9iT1G6hA1mbVKF0z83RuBmtS37yM86
         XjnT/u8EIONuPeLrpIZrGvwbD3qcqkepPqL5Ssj/WjrG/4ahueveLIKA//JFLWscMgpz
         EoPHn/ogNli6PMczX98AooXL/OjtjAuyPTv+StuIyDeUafGxUfy43np68J6a6gWVkHFY
         GGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/WTniiOO2X2m80SkKX+NZuwJfpEeKG/rQODBJmhOvY=;
        b=cDFTJnn+C/y6STeWgKBZDat/XG900t/rGlxF9Tkw18HfgfR0k/GIEDsYTPnjb3nPD2
         F/Vn1oB8IiGxs4ukYIcBhPG8uoI3HiQESfFqosbPbOgAV4eJRFQb/PuoXLjpzMaGGGvX
         GKhT1lVKgLqizznOO6rr+AmsJqIR+n936Lp+AJJBtth0tiHlziEYP2bcFT3g+XoE6RLn
         ipKx8rYSMqcdndQbTJu7RSCgmgrvBGh1rAE6q2OxARXcePU28f1r/ygKDGlyX+QORbIc
         wW3IWpluxcHg+HMmvkRjca4Yv3lTyGaHug7kCAzpJLIeER4pDfeloslLEnuMUJQt8hUZ
         y92w==
X-Gm-Message-State: APjAAAXqohijns2ULDAC7KS8N7EHBB+ksGmkJ/wq+ep2eicOwiBYxZdZ
        NraDH42xfx7FTt4aivYWJf+WDChx
X-Google-Smtp-Source: APXvYqyaK/Y9BG1jYe4IAZUAIekomo8Q7PtGNmf3DZv4gSVGBdZwzPO00Sdwk5eYpnQHuGWZeS2yZQ==
X-Received: by 2002:a2e:7315:: with SMTP id o21mr5546306ljc.276.1581266494150;
        Sun, 09 Feb 2020 08:41:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 18/19] dmaengine: tegra-apb: Remove unused function argument
Date:   Sun,  9 Feb 2020 19:33:55 +0300
Message-Id: <20200209163356.6439-19-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove unused function argument from handle_continuous_head_request().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7b9d59bbd2c1..3e0373b89195 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -553,7 +553,6 @@ static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
 }
 
 static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
-					   struct tegra_dma_sg_req *last_sg_req,
 					   bool to_terminate)
 {
 	struct tegra_dma_sg_req *hsgreq;
@@ -638,7 +637,7 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
 		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
 		sgreq->configured = false;
-		st = handle_continuous_head_request(tdc, sgreq, to_terminate);
+		st = handle_continuous_head_request(tdc, to_terminate);
 		if (!st)
 			dma_desc->dma_status = DMA_ERROR;
 	}
-- 
2.24.0

