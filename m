Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1171D14D5D3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgA3ElS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA3ElP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so2351527wru.3;
        Wed, 29 Jan 2020 20:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=eXSAMmfFk87BiKVYPukim1qMlYTyAfCxj3cafWWF7C798pYTvoIiW1dNpPLau/DzhT
         4ovqtYYxDuT9vvYLKcU4+6fOF55inI6SsYo02XdTZIolsaQZXezrsp95L4IJenag7O5R
         ONmDth9pEY6UDRWPNO6ILHo83X5F4P1yv7rZwDwqEkuudnEuAUwedyMlM8CrmMR8RGbY
         UzLYp5pZhzMJ793y69arBwbkg3MFesYpEzk5IID/ndRt3yzLRngiFDCawqSD4JFhHjhH
         AcVpEjdrgxO2MjZq37owS93u9lf4VWGCUXPptAxU4UWLmSYa5vVVL0bbq76gMBNSgDFR
         jMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=OFkWAo4azDgmjkcW37hC3NwBf2q1e8uKDqwtcEWFreyr95UkKRbbKXBwp+intitVIV
         d5pKFEzueXzE3t2CvL6FH8Gq7W0JSSZmr2eti65rbJwZK2kEzReJlnuaa2QyhkeZawGL
         Fhs0mmKzG5HElrbQuRMAXIORVyX7x1D7W9gt726f+xvVj3jro663v5z/FicP+w3JyKAI
         Azj+STn1V/nnrgp17BJC65SUyghABkotNIHHy7eba+/YVpLE1P6qkqNnhSUmWHZyOypj
         xAAV9JHSJhAEURlCrfNxMoSXPHg87/cuc1lnCnV+wCRNUJG23xiQk+/3pKzqsYckp7HX
         bk3A==
X-Gm-Message-State: APjAAAUSPWQGkwd8AjqU/szOgnOmPitG8x6uIQJT+6gPQp8idjH+Tbba
        ej8dNt9ErRoZOmDfpYehL3HAjS9k
X-Google-Smtp-Source: APXvYqxqfwcb7F/BYCfuV9zHzoCbE3NcSh6SwQs9SSsEHxvQGQkP3V9evrgcLM4oG8H1RvGhvPmA5Q==
X-Received: by 2002:adf:c446:: with SMTP id a6mr2743078wrg.218.1580359273365;
        Wed, 29 Jan 2020 20:41:13 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/16] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Thu, 30 Jan 2020 07:37:50 +0300
Message-Id: <20200130043804.32243-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus, let's disallow descriptor's re-use
until it is fully processed.

Cc: <stable@vger.kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 319f31d27014..4a750e29bfb5 100644
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

