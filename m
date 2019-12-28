Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F30B12BF3B
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfL1Uri (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Dec 2019 15:47:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40097 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfL1Urh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Dec 2019 15:47:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so22919377lfo.7;
        Sat, 28 Dec 2019 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rypt1/kYJGAf6C/Gog1EznwTiuR8sj2lcgKvtqgbT8=;
        b=AP8ExzohCEnt6ixOQz3oP0/J0CIopikiRt/lLzjGiBEEIu6fbUniS8K0NQUnVAzp+V
         LNmbKyZGOvRKgFKR/g3A3d1jOmunanQHiDGbTJ8VOP2bnsBdVd9RFFsLG0LPBN3OSgJA
         fGTS/IejndFLg0dt7b5pv3i7T2EfWLw7iFJ15vyWiA9IwAe4roxKRqAjuNdnroroT9vW
         7o/E4G+qL9XR2jSROlut089gMLRQtRP1PQcMMPnmH1yJa34AApBP+bv6WncWuA6ocK0M
         ZR4/JyzRtGEd7Eqec13N5vc235QWP9pG1Z5julOQObnl2elpeckQphxLhEMTSFNBhdLO
         Vy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rypt1/kYJGAf6C/Gog1EznwTiuR8sj2lcgKvtqgbT8=;
        b=Rc3vYxXRKFSakIHyzmkvS1L9anIigbUz2GejZFp37sLGTC0qu1FotBlFGxGsSo1feL
         ahcRzPwx92QAu5l6muudrla1umWzjBdqMkK4iZPQdXfDEPkfykK69HVkvroQ3lSwdnum
         lYDc+u7sGlr9ijVHBYs3UyaTjVaLeFQOP0e7d45UM7XAOrZ1iN24x2nGHqJMdW8oZjyw
         u0hI3ZGJThUFFPyGRLrzdeBXJNNsbCv8FSmh3IbyBs+AZuEyNu+MfczNLHX5rfUJK+JE
         skvZ48ryR7+ZgFpQyQ/MvNId0B8BNs+w6x+UuDR1xX5QNSsoIYINiS1zZuBHA5/7qSSr
         6Usw==
X-Gm-Message-State: APjAAAVqpErvpEN4U/2WzvhJwU/U+/H/RLdJdoDrJyHuJsCH3yM2+RyS
        V9m9JbemezomTBo6q4i+1Fg=
X-Google-Smtp-Source: APXvYqwDxEgv3gZMoxYttDIeu0SlE6IZqJdvibegz+aqs+kK9yabvUEsisYIaAUwGEvhDe9eUHj8uA==
X-Received: by 2002:a19:5f58:: with SMTP id a24mr33623852lfj.9.1577566055538;
        Sat, 28 Dec 2019 12:47:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Sat, 28 Dec 2019 23:46:37 +0300
Message-Id: <20191228204640.25163-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus let's disallow descriptor's re-use
until it is fully processed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 28aff0b9763e..740b0ceec7ec 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
 
 	/* Do not allocate if desc are waiting for ack */
 	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
-		if (async_tx_test_ack(&dma_desc->txd)) {
+		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
 			list_del(&dma_desc->node);
 			spin_unlock_irqrestore(&tdc->lock, flags);
 			dma_desc->txd.flags = 0;
-- 
2.24.0

