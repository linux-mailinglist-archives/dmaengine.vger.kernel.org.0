Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63AB147465
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgAWXKw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgAWXKv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so5188798wrn.7;
        Thu, 23 Jan 2020 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TN3Aq9biuh1Hk4JoQDeAp7VLhhgR3QH0ii3GwHrM2/8=;
        b=QU22ArdAc0hImwOzo1G/Bn3Q0m0bAPw5X2TMexZ/jmO2FoLfDcc8lQiGQuAT6Fwigc
         zAbnTx3z+SGU3rHzNbikqe/XSj/YSA6+hOMtu1/2yfod3tUHWtyW2HZsKtI4iwa6uW3F
         C2IMEshfTh6BGAlAQ41pmNMcMP/WSKSzB1V25uyMDEdwG6ha3laIF2d3fQ7IkOYSssMg
         yGCvPYzpdkJzpE/ISk00GNPxzajh4JmeKtdgv0l8zSWnCb9d7rHYw0uRZpU3+8pSrHwx
         ZR59g/ftC6ho9o4rS6D/R1AcXHpegzae6J/sQu4s8z51ItzitSapXbRw6AzsJGqo4psM
         Jevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TN3Aq9biuh1Hk4JoQDeAp7VLhhgR3QH0ii3GwHrM2/8=;
        b=jzHg6DVPOc5UFpm2DTF9BduayWWoCiiTgZ+ag4ke4wDeLTi/uimQiZwoTn7/r+myJu
         v6ojOS7Vum0y+NzI+z9jLSUbf2CnaHx7KWdBSSnYhugt384zUgyiT5K+UrbhhGmQtm7z
         irxGeZ7jACkwo14lh6sfT217ntxIMX/zMsBclOv/PLNUsM9SccaCaqDiSr9Jb+wPom0h
         obrVyS1E6YafcUxs9g3Ifhc/yDqNXew3AGFy/tzSWU1rQBRH+z1Zsi68aRkka2EjjCCY
         s9abjrgEF6+95L+H+h9NAsdjpI0DNk2tu6tVSjJISJg3Z27yO3jpPDYcxcEPeqya459k
         kzZA==
X-Gm-Message-State: APjAAAW2Xyixjm1+8YOsuSyskWIcfcboVs6YeLzZvgkdsTZ8Iwtu7uKU
        dX1lxWj96k/7DMPZXAq+3eM=
X-Google-Smtp-Source: APXvYqyXcG0WQl47qaYlaDh2lIxzeONymSjOWQbc5/AiaZVx++ziEgD9efjytX2rB0mpSgX/NigpmA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr479368wrn.29.1579821049856;
        Thu, 23 Jan 2020 15:10:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Fri, 24 Jan 2020 02:03:16 +0300
Message-Id: <20200123230325.3037-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 1b8a11804962..aafad50d075e 100644
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

