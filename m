Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B244763F9
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfGZLAE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jul 2019 07:00:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42844 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZLAE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jul 2019 07:00:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so24673271plb.9;
        Fri, 26 Jul 2019 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GZk1YBh8K1nF7b/BG0aJDKLlYWK7vgDFFQWFrUTZFzA=;
        b=c6gTe21NfZlHeMmzBg1Z75RsvgsPNWl9dWqZyeki1vTtEStPyxBnNCiGiMBiDP0xWu
         KjxYYQyZujbishNMkirEBOjr/FJ5NObejW3xu/FLWt72aMHSXN38DE0AK7Nj3ywn0sc2
         M7QupNSZVxzNUTBnTqKgXWZwfPGyFqHqCW++ZTZ+IuayQ3byxx7dzA8MnDFrlBSNGVpx
         ICtTcxqWNXy/0k9pv7mJXiTB7mYuqtlEQTplUuJTiCYjB831EiXxGrucawDOa3KiA6fB
         pyEEQYPipeh3XJ7JCFuJepY8vv9Ru8Tq2Bq08Ana1vSiy8lVwTzyguTF1zpk2NH5Rwkn
         V6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GZk1YBh8K1nF7b/BG0aJDKLlYWK7vgDFFQWFrUTZFzA=;
        b=Z1VhsZC04UPeOzYPb+DUCBDOazcpFDbjDWC2+qVIF69ZqO/ojhtZaK52HHQT0Dk411
         uRXdYtzNgKS9Ko3eQHYjNC1OPy3GCvn8yW2h3u6Xhq3yQD729k1bUnxTWND/9spHgKhU
         M9DuhkvZ296Q3wQlhhgVNhwWgqu0TOAnv/iNHdRp4D3PlQuSdRkMsELh96wpl3AXHzac
         XNHi0AcBNgXU/FUT04IKCl5NBtDTplWGLn9FHTKqdXdLMVMsbq18vZ/kgIlte+AArBB+
         cOhTExHyMOjsRV6Em9idxiDQ308v6BRAmO4x9X4UP3irqU3tw3S58AsmEUXV5WOOMNT3
         kSag==
X-Gm-Message-State: APjAAAUOtrB7lu6Bn9qcINpR3tKpL0+Cop7xju5+vJY+JPPcgH1afuLH
        N//e/7xRLcyp1Nbyqfqqsj0=
X-Google-Smtp-Source: APXvYqztCs7PmCw0xLyCRDhnZ13GR6eat7Pm3QNuFtZtK9/gtnOOCYbuMTEOukIOh01EGkwcc9cl/g==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr95803057plp.221.1564138803975;
        Fri, 26 Jul 2019 04:00:03 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t10sm51967367pjr.13.2019.07.26.04.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 04:00:03 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] dmaengine: pl330: use the same attributes when freeing pl330->mcode_cpu
Date:   Fri, 26 Jul 2019 18:59:47 +0800
Message-Id: <20190726105947.25342-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In function dmac_alloc_resources(), pl330->mcode_cpu is allocated using
dma_alloc_attrs() but freed with dma_free_coherent().
Use the correct dma_free_attrs() function to free pl330->mcode_cpu.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/dma/pl330.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 1163af2ba4a3..6cce9ef61b29 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1922,9 +1922,10 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
 	if (ret) {
 		dev_err(pl330->ddma.dev, "%s:%d Can't to create channels for DMAC!\n",
 			__func__, __LINE__);
-		dma_free_coherent(pl330->ddma.dev,
+		dma_free_attrs(pl330->ddma.dev,
 				chans * pl330->mcbufsz,
-				pl330->mcode_cpu, pl330->mcode_bus);
+				pl330->mcode_cpu, pl330->mcode_bus,
+				DMA_ATTR_PRIVILEGED);
 		return ret;
 	}
 
@@ -2003,9 +2004,9 @@ static void pl330_del(struct pl330_dmac *pl330)
 	/* Free DMAC resources */
 	dmac_free_threads(pl330);
 
-	dma_free_coherent(pl330->ddma.dev,
+	dma_free_attrs(pl330->ddma.dev,
 		pl330->pcfg.num_chan * pl330->mcbufsz, pl330->mcode_cpu,
-		pl330->mcode_bus);
+		pl330->mcode_bus, DMA_ATTR_PRIVILEGED);
 }
 
 /* forward declaration */
-- 
2.11.0

