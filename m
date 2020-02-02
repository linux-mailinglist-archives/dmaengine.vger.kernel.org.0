Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6514FFB0
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBBWaZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43155 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgBBWaD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so8338520lfq.10;
        Sun, 02 Feb 2020 14:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNJyMXICFd8y4YXTQRsGlsU//nAmuF2hHmBllvy2XVc=;
        b=s6ej2B0Q0D8KFLNOUJqvAcWJ0X6xJT9wkIaGy1fCGX1hfbq8PR9yNDXmp7q9DXfhWj
         ot4PCfzzf6akB98TjVN+lXdxYda+8FZWLRkBazeNtv25esRV2FHEwWEbfLBbsK8IvN+r
         kOKu3Z5bGKYw11YGTtn8HnnxBIQA8eNhkowBc4gDhcqt8NyBuDlvU33vL/+8jHBC3qm1
         TAfELSJ6QoUiUVRDj6+pMBPUIomMVOEE5AINmqNYpdvCoa/z1+u7Aw4qiBSB0fpi2UeY
         XDQ4yq3AGeO4jJxFAp06ZfKYduJYPvmWTu8bNeYE5gZvORW1grXg0kcC6pRjlkkGqm8G
         rEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNJyMXICFd8y4YXTQRsGlsU//nAmuF2hHmBllvy2XVc=;
        b=N00cgsB0CMbYfzs/NQ3hRu7Vz/0GZPbdbH6GHk7KBc+8pmfbMIbvC+f5dZ/HR2kSKE
         pl62rqY+RcD9G7rd2VQ1hF/xd3QRMfw+/1KiJpwNQfFw8pw4eUHyZQju1mTqJ/HIJGwR
         GuZ2R5/tcdPqXGO9HgLdrxcHjNpAwEQgDPR2MMEpy/o5RSO0Kiu2MEPUoBqdWf2dfUJf
         +S2Uw4YOUgv6CTRnrJ8ubt7gBtXoIau97sMD60gLcFcXNrNU6QO6fuFBw5T5H5OmY4Uj
         Xsv41O1Pl+w7zu/UIBlEOOFyPAjI7YMr1YqSl5cGADqfPwad2ZRUcqDWV7dhZh9CNB+d
         0C/A==
X-Gm-Message-State: APjAAAUPj6t98oC/PldmejZgoJiIvv6D5yDDleryvUjAAMtmapvqZ90L
        qABj46gveB5bCbQ/SMzbAZ8=
X-Google-Smtp-Source: APXvYqzaxDrsS1AoBFj/pdbJXJyUtiKqya888AEKUXPD1rDESikYiIpCKiXQ7eowxiWucnaZvqYekw==
X-Received: by 2002:a19:6449:: with SMTP id b9mr10478816lfj.5.1580682600916;
        Sun, 02 Feb 2020 14:30:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/19] dmaengine: tegra-apb: Don't stop cyclic DMA in a case of error condition
Date:   Mon,  3 Feb 2020 01:28:48 +0300
Message-Id: <20200202222854.18409-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no harm in keeping DMA active in the case of error condition,
which should never happen in practice anyways. This will become useful
for the next patch, which will keep RPM enabled only during of DMA
transfer, and thus, it will be much nicer if cyclic DMA handler could
not touch the DMA-enable state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index c7dc27ef1856..50abce608318 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -571,9 +571,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 	 */
 	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
 	if (!hsgreq->configured) {
-		tegra_dma_stop(tdc);
-		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
-		tegra_dma_abort_all(tdc);
+		dev_err_ratelimited(tdc2dev(tdc), "Error in DMA transfer\n");
 		return false;
 	}
 
@@ -772,7 +770,10 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	if (!list_empty(&tdc->pending_sg_req) && was_busy) {
 		sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq),
 					 node);
-		sgreq->dma_desc->bytes_transferred +=
+		dma_desc = sgreq->dma_desc;
+
+		if (dma_desc->dma_status != DMA_ERROR)
+			dma_desc->bytes_transferred +=
 				get_current_xferred_count(tdc, sgreq, wcount);
 	}
 	tegra_dma_resume(tdc);
-- 
2.24.0

