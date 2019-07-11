Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADE6506D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 05:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfGKDKk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 23:10:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDKj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Jul 2019 23:10:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so2024324pfg.10;
        Wed, 10 Jul 2019 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zpbomds83eKGH676yLKqCCW5MqIqLtjKcYpM/+tbDr0=;
        b=IJnWvONwVnZGohDdhtjmhBKs9vfW197GtuREVR7T+OLN0Qp6yJht+eJ5QIC2ynArly
         4rbUKfUx1QqzxUxsk6PNS+SLoMIMJggtxcktut1Nm39FiAIWWHwhxAeO1QegLEIxs88i
         bU5W1lasXrtkfyfvHX0wjIriVm6/4MtFGNZ3GogUhrvmN0NRBUeosbTFAJSev6oMmdls
         0X3tTh5WaPJbRk9qRxcRl7cOq5Ez3m270vpobef+QsMchsZAiaSK/tfty/H2kYz7evZ6
         5+4Uz4hE1OrPmAZjqlNbUCncwXbhSK5p981Rt1TUrlcPuREr+btHXswEpEqWgnxN0kH6
         6qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zpbomds83eKGH676yLKqCCW5MqIqLtjKcYpM/+tbDr0=;
        b=Womn7hT+yA18ZnblRjV5uwKrv6GbwZe+/wgwn834H91zm+9gWck9UlLvz+5iV/NjZF
         k/BXz50yvhhODTSYiXZEsoOqUH9egv9ktI9CXPJC87IUR6nGI1Glv/hy3bCTjEeIHVjh
         GIMpbB8gm/vlxW5LZNdjcbHMQA52QJJ3qUQkX2VxxnAL0KwPkXYA85FwgzWx/6dewJ2A
         0QiS8Z6MGbIy0L8euL+ccUgn4zJgfCQL6CsDa7lb6G/Bmw9iG2Ub9EfhJqwpa5t613Xg
         hA9QijhHRcXegJsJduWRKjSzqRK+Mku7VVrlrtdZeniOqWUtab66ftM8nF1G72uktb+w
         BMEw==
X-Gm-Message-State: APjAAAXpkfE5tLnU4iUs1jLA6LP3Sv3S1Tg6eJgpx9Ajt+uRsjmT8xQG
        4PjuDCTDCAxYHAvk8mSIqmOaFTQKotc=
X-Google-Smtp-Source: APXvYqxJMOOX5pzW2SkgB5Jw0yk7MWvd1qsQJTyPiyIkjGwvQIKyRH12UMBGRnVXyYu7FXXirtNRRw==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr2084162pje.130.1562814638642;
        Wed, 10 Jul 2019 20:10:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id l124sm3710309pgl.54.2019.07.10.20.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:10:38 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 2/2] dmaengine: pl330: use the same attriobutes when freeing pl330->mcode_cpu
Date:   Thu, 11 Jul 2019 11:10:31 +0800
Message-Id: <20190711031031.23558-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In function dmac_alloc_recources(), pl330->mcode_cpu is allocated using
dma_alloc_attrs() but freed with dma_free_coherent().
Use the correct dma_free_attrs() function to free pl330->mcode_cpu.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/dma/pl330.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 56f9fabc99c4..d9c6ae0732c6 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1918,9 +1918,10 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
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
 
@@ -1999,9 +2000,9 @@ static void pl330_del(struct pl330_dmac *pl330)
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

