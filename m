Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F05141CC
	for <lists+dmaengine@lfdr.de>; Sun,  5 May 2019 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEESPR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 May 2019 14:15:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42228 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfEESPR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 May 2019 14:15:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id y10so2684249lji.9;
        Sun, 05 May 2019 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJTdj68AX8XR91X53wIUO5fTIgKG5aH64DtycYbKgjs=;
        b=XB7irQfpOf47d2cF8NMxp/UBxlEUBEKZcOlVY3J3m5iUCGB7Prb/N5Gi34ksXJtJ8j
         EefJQpRheGwfk/u4zSQtBqhcYq7qYAh/fx4z77NOMeaTb21WZ/OWgJJgpuYYBD+KsDAy
         8vZveQedfv5xbQz6D0t8Z255PrzArrL7EPXyV5HeAl1qgtKBsZv18YJJEs8scB8nMmBQ
         QdDqRmDFqht+QMC/xOB13KQxD3EdSglar7Guo9/SkeUvqauCHDpAU0NxyM0Wvwcxwrlr
         Fgw7mQoxe/laHw15VEUGbY//hFHOWi2yLpSu4EhCSkB8FIrRRSlqkw3TCZPIyAF9aSBZ
         3g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJTdj68AX8XR91X53wIUO5fTIgKG5aH64DtycYbKgjs=;
        b=IiXG8+k/H7zXgAPqHgchbOw68QzVp9B+uUiuXLqgZG+59pbjpQQxBNLIuaYlO4Bel/
         3+5j90SNCpY2wathBlJGMEj9Bu2tYIpqLSsDVGyswlL+SBaVyC1JRBmmkyWHcYvLCsu2
         DVz/P+02YpaJ5bBmaxT1HRSXzG/Icvu5yBNO3gc82YIlsvmFGwAP6arDHkRPzveQMpvU
         IU7psUbQV6pnDEFn0eGpOQaDvaZ6q5JQHBugNpkZY+Wx8GqYwaidXhjn5OgIxYOSpk4u
         pIwSdCWX9Yrrzz1gFI4Vlf1dPZWaQ/6nlnOWWjR4l1MBkVjYdKb99cNxuXfiQmhvcjFe
         lGJg==
X-Gm-Message-State: APjAAAUc8YIuHgwJ9dAPgCazsOYE9+upN9jXKEIqu28g22oDAfNdL+hZ
        Mowg7NkvbIRI0iDQG+wqU3U=
X-Google-Smtp-Source: APXvYqxivTnYsW+r+l52S92wmJ/MK51g6QTS5X8M376mSNk0V66QKMVEsuxVib/9nXB7KSib4lpMnQ==
X-Received: by 2002:a05:651c:155:: with SMTP id c21mr11517731ljd.10.1557080114204;
        Sun, 05 May 2019 11:15:14 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id a3sm788218ljk.28.2019.05.05.11.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 11:15:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: tegra-apb: Handle DMA_PREP_INTERRUPT flag properly
Date:   Sun,  5 May 2019 21:12:35 +0300
Message-Id: <20190505181235.14798-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA_PREP_INTERRUPT flag means that descriptor's callback should be
invoked upon transfer completion and that's it. For some reason driver
completely disables the hardware interrupt handling, leaving channel in
unusable state if transfer is issued with the flag being unset. Note
that there are no occurrences in the relevant drivers that do not set
the flag, hence this patch doesn't fix any actual bug and merely fixes
potential problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 41 ++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cf462b1abc0b..29d972b7546f 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -561,6 +561,9 @@ static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
 			dma_desc->dma_status = DMA_ERROR;
 			list_add_tail(&dma_desc->node, &tdc->free_dma_desc);
 
+			if (dma_desc->cb_count < 0)
+				continue;
+
 			/* Add in cb list if it is not there. */
 			if (!dma_desc->cb_count)
 				list_add_tail(&dma_desc->cb_node,
@@ -616,9 +619,13 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
 	if (sgreq->last_sg) {
 		dma_desc->dma_status = DMA_COMPLETE;
 		dma_cookie_complete(&dma_desc->txd);
-		if (!dma_desc->cb_count)
-			list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
-		dma_desc->cb_count++;
+		if (dma_desc->cb_count >= 0) {
+			if (!dma_desc->cb_count)
+				list_add_tail(&dma_desc->cb_node,
+					      &tdc->cb_desc);
+
+			dma_desc->cb_count++;
+		}
 		list_add_tail(&dma_desc->node, &tdc->free_dma_desc);
 	}
 	list_add_tail(&sgreq->node, &tdc->free_sg_req);
@@ -645,9 +652,11 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 		dma_desc->bytes_requested;
 
 	/* Callback need to be call */
-	if (!dma_desc->cb_count)
-		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
-	dma_desc->cb_count++;
+	if (dma_desc->cb_count >= 0) {
+		if (!dma_desc->cb_count)
+			list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
+		dma_desc->cb_count++;
+	}
 
 	/* If not last req then put at end of pending list */
 	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
@@ -802,7 +811,7 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 		dma_desc  = list_first_entry(&tdc->cb_desc,
 					typeof(*dma_desc), cb_node);
 		list_del(&dma_desc->cb_node);
-		dma_desc->cb_count = 0;
+		dma_desc->cb_count = -1;
 	}
 	spin_unlock_irqrestore(&tdc->lock, flags);
 	return 0;
@@ -988,8 +997,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
 		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
-		csr |= TEGRA_APBDMA_CSR_IE_EOC;
+	csr |= TEGRA_APBDMA_CSR_IE_EOC;
 
 	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
 
@@ -1000,11 +1008,15 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
 	}
 	INIT_LIST_HEAD(&dma_desc->tx_list);
 	INIT_LIST_HEAD(&dma_desc->cb_node);
-	dma_desc->cb_count = 0;
 	dma_desc->bytes_requested = 0;
 	dma_desc->bytes_transferred = 0;
 	dma_desc->dma_status = DMA_IN_PROGRESS;
 
+	if (flags & DMA_PREP_INTERRUPT)
+		dma_desc->cb_count = 0;
+	else
+		dma_desc->cb_count = -1;
+
 	/* Make transfer requests */
 	for_each_sg(sgl, sg, sg_len, i) {
 		u32 len, mem;
@@ -1131,8 +1143,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
 		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
-		csr |= TEGRA_APBDMA_CSR_IE_EOC;
+	csr |= TEGRA_APBDMA_CSR_IE_EOC;
 
 	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
 
@@ -1144,7 +1155,11 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
 
 	INIT_LIST_HEAD(&dma_desc->tx_list);
 	INIT_LIST_HEAD(&dma_desc->cb_node);
-	dma_desc->cb_count = 0;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		dma_desc->cb_count = 0;
+	else
+		dma_desc->cb_count = -1;
 
 	dma_desc->bytes_transferred = 0;
 	dma_desc->bytes_requested = buf_len;
-- 
2.21.0

