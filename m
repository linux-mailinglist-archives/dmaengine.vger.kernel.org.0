Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF40B156B78
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBIQla (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46670 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBIQl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so4360072ljd.13;
        Sun, 09 Feb 2020 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X64N4SU/Yt4mVyeDVnM/9MzvzedFawu3400zz/AaEiU=;
        b=LZAApRVZMTSGEaQluA6CnfccmXulDLOd5U9P+lP4pxpCXqa9rC0W3HSL3iyj+sS3Ha
         PhNFN/hEZGHtB96baYchsbPtXZubLWmIGL6VwS9dqI5TDAKexvi52BgM2AjMQQThgIFD
         1qm/I2zibii+yKUnwBGZ9yv/2mTu5Qz//opFm6kHcRORqfG498ZvqynqjVqxOiHmXrW1
         iVKAU+PwiOvqgX3TOZ/Vnj5Et8RDjTLKr34ZVWGxQDGCVivJ89BNiVKBdkCjUkhMR/9i
         tynpWetmkMomVhrYpMQP5TlnrQh4+W/0G0EWH/xewZJteONSUPQUhcBcUrnyVYsNboib
         a+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X64N4SU/Yt4mVyeDVnM/9MzvzedFawu3400zz/AaEiU=;
        b=jrILI/53cdvxzCbm2UbpxgBgpPMcstUc+wYArBtMjwk7aF67rKQuEEJezipMCaFwGr
         HnvAl8jQIRgLVIQQtRlNXXDvTzOS+nVmVX8uNgls2nHsSxaH61k+5PoomZ0ywsZqZUKC
         oF5vDLOqzCbvSg9gM8c91GLTg72h1b9heRidkMDOahXwfRs/rp/wnAsQkwqqgQLDOaGZ
         9tlgltuGZ/86e7ATqGr1qSO574BjpDjFtWSJNV/lR4jClRWEnnymgrxCK+cSekt2d7jA
         QMwKZGWPtbX8BrC1fC1Ja9VrUubtspgso3eH2O7NUuvfgmNQZw2h/2NLOtJCDwV/7m8e
         vXbw==
X-Gm-Message-State: APjAAAXYwPUxhN4Q9OqFB5B2qvSLc2q3kl6/wCwXsiKD8KOPZoCPJ0Gd
        b9s88Pjw0yfWkgyvTEl5Kn0=
X-Google-Smtp-Source: APXvYqzaOXUqt7Z/hlpuB0/97sagVUR4FDuuIdOjiPp+VRjs+yyydAj1K0LRCeQALpG4uwGtuAIEbA==
X-Received: by 2002:a2e:90f:: with SMTP id 15mr5310961ljj.120.1581266487164;
        Sun, 09 Feb 2020 08:41:27 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/19] dmaengine: tegra-apb: Remove duplicated pending_sg_req checks
Date:   Sun,  9 Feb 2020 19:33:48 +0300
Message-Id: <20200209163356.6439-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are few place in the code which check whether pending_sg_req list is
empty despite of the check already being done. Let's remove the duplicated
checks to keep code clean.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 22b88ccff05d..049e98ae1240 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -504,9 +504,6 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_sg_req *sg_req;
 
-	if (list_empty(&tdc->pending_sg_req))
-		return;
-
 	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
 	tegra_dma_start(tdc, sg_req);
 	sg_req->configured = true;
@@ -518,9 +515,6 @@ static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_sg_req *hsgreq, *hnsgreq;
 
-	if (list_empty(&tdc->pending_sg_req))
-		return;
-
 	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
 	if (!list_is_last(&hsgreq->node, &tdc->pending_sg_req)) {
 		hnsgreq = list_first_entry(&hsgreq->node, typeof(*hnsgreq),
@@ -567,12 +561,6 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 {
 	struct tegra_dma_sg_req *hsgreq;
 
-	if (list_empty(&tdc->pending_sg_req)) {
-		dev_err(tdc2dev(tdc), "DMA is running without req\n");
-		tegra_dma_stop(tdc);
-		return false;
-	}
-
 	/*
 	 * Check that head req on list should be in flight.
 	 * If it is not in flight then abort transfer as
-- 
2.24.0

