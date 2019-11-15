Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23035FD800
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2019 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKOIcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Nov 2019 03:32:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIcF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Nov 2019 03:32:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so4135179plb.4;
        Fri, 15 Nov 2019 00:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCpyp7VlXRWKtfspUgWzs1CQ4X3tbOzNUUacTAQ1h0c=;
        b=LZe+lZUE9hQ0aZNfcLDPsBUDHmfZCHMlwOVbI2C+0igiwcL1MTf0W975poTI0U68eB
         pLruGRp9Rg+UyjBzHaPBZAhlQcY2u3sNvfNc98fDmx+pBAJ4Sjt6MVHCQ0hApcKbE0Uf
         BgF81Q7dq5gh5dxlQTLrWO/jH0lwkpusB3Gq7XW4AWn1QyOGHGrmhNNbacLxDh5uergJ
         DRipIURtIrxwBVvDeWcnZ4sOyn6mF8WzBrWhhPqNRk442OB6JYWxPLjH6GOZkqH2Aa37
         0fiD1SMcsIUYD3RxEdroAnDxKGLbiZLvL5fvnOvzuwGll+AIZPufdYBfIG4IrkWNBN+d
         2bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCpyp7VlXRWKtfspUgWzs1CQ4X3tbOzNUUacTAQ1h0c=;
        b=WsnRKD9qFoRDgJbmEpNbTywCUddaSYV2ZqNACgS7dDO62iDo1lpIFjEl2FAJgi80h6
         Y+uWunsZeiLxHZ8HRl3cDhyByBVVPMUuAssnqapc9LsbG70P8WRyFDH3da1ntARKy3G4
         rsXxxQGZgOPLIkz2to2xFmLLl+JexF6GclG3B1qCC/232lZcdTY4CXGelc1DHMgiVWCK
         cyYbB18vx+E5H8D1exadYF8yjL0OH90PcNIpy6Op7qm0BEYB7OUFZtLfyCSKmNYglE4y
         CdIT2okd5Z7bEElx2JGFo0MIsPAOxM+RsXRWO5dnXlC0+kfLKRT4VFYOIRrcYV1c6f+9
         reww==
X-Gm-Message-State: APjAAAVl2Ud2UMprZQskHDJcGXo1/aREBjJK7OLg5Y49wbmFE4BCOf3U
        dYXEUOgbZEJDAelv+rFdGlw=
X-Google-Smtp-Source: APXvYqzGHHWHf6oK+MCJbGsnVBtLpmAG4XOJZSPBpO9E3gdQsRFrknJkZa+90QJvK9ZIXkeiY3KaiA==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr7023396plr.257.1573806724797;
        Fri, 15 Nov 2019 00:32:04 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id z4sm9190597pfn.80.2019.11.15.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:32:04 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] dmaengine: mmp_pdma: add missed of_dma_controller_free
Date:   Fri, 15 Nov 2019 16:31:53 +0800
Message-Id: <20191115083153.12334-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver calls of_dma_controller_register in probe but does not free
it in remove.
Add the call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/mmp_pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 7fe494fc50d4..ad06f260e907 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -945,6 +945,8 @@ static int mmp_pdma_remove(struct platform_device *op)
 	struct mmp_pdma_phy *phy;
 	int i, irq = 0, irq_num = 0;
 
+	if (op->dev.of_node)
+		of_dma_controller_free(op->dev.of_node);
 
 	for (i = 0; i < pdev->dma_channels; i++) {
 		if (platform_get_irq(op, i) > 0)
-- 
2.24.0

