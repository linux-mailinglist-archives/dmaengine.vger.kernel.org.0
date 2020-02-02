Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286BB14FFCA
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBBW3x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:29:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46173 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgBBW3x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id z26so8310337lfg.13;
        Sun, 02 Feb 2020 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=EM0X7sgbng3x4dktJbQeFp9yA7QcvBQcMnHhoD6kgwIh+gjOG47z1HOOHO2Z0TjMJI
         YLwYWOsktgo7+EvwnqMmrOUaTeXcRAWW+aZksSc2tyd3Uw53NdGiPzWjDb1xILxuxdkK
         3M+//YX0coXAt6iiVSctJ2f2pLwlaQ+u06cQepSsvvgAiqcy+tMim/QJW5WFklrjCESz
         2TKfbDykDVxFdYlV7tV3CBEkfEvNU57CnJJqSOMmuZcqm3tdjy4ejmAFAduou/kg+HBu
         Oq2Y+t3w8DIhW8Ei+O0qWRSJ5e+Au0StYoJdVaP4d8PHSPcD8o+uRyR315U70VLszFKf
         dZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=k0UMdaM/As2C06xYHNk5Pcob9UA32PqUvs+RSVTXA8K1MjvlTzNfDlVghwmOtd/Eem
         qN2SzTsh5xonECfScbAAI2Jy5wuy/mAIDBCgv4Cjb/hjGqXDg7PbDOR0ELAfTaGWsPx6
         IDj6rjblFbXFFNdmtXcEq7mKT8v9V42usDRy3fxIM0wFvUYZzwGPrmjO/sj098Ah5wTS
         GffXlz/M7Oeo2LsGbH/tie6QFjzpHAx9C070FBSmdU2rriM48wf59nFA+QMv4r1mZNir
         Bi88FsQF1ZsYabQY7739DYmmCBAO+4th/BW5n3J5tCCXtUXLsswOYopet1A7VJYsMh+u
         NIDQ==
X-Gm-Message-State: APjAAAXCAU4St2ec/7WDIpWAveVKFCbYXPqwHwG0nqMZbWlpMU+uuILN
        tySZRED/nyxqHmjV1AwYPUw=
X-Google-Smtp-Source: APXvYqzZZIRAWD1QW/C1T/vkHQgSiYk/SsKeBvJduu/OlQALoN1xg6VXm+h6JeCSgOvE+erAc866iw==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr10571236lfl.178.1580682590369;
        Sun, 02 Feb 2020 14:29:50 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/19] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Mon,  3 Feb 2020 01:28:37 +0300
Message-Id: <20200202222854.18409-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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

