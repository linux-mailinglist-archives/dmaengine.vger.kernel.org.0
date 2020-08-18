Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10A248189
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHRJJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgHRJJe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF8C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so9471756pgb.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FY/yCtkR8zuQxnB1ct+rZA02HMp31w5fOwHETAQ8JTM=;
        b=rj4ZGI1JCL4odafsDi5ENbD1vLGXA2gbioOqXLmEM2rWs+g8oMBqp5EbmODY2fXog0
         3WqMzpqp9HIOTBon8RDiJp3E3dwLCrvoJK3+NqBaK86CJ8Zx62zPQyLVWS0s17vmXeLL
         t7sTPjp1niZ1soRO8Bhb69oeEUH5hqOg0NmjSyB0G/QE/3Sv7mA0GPRRj3E3UhSw7qg8
         RikNN1gtlHEpCpciz+GQraYFxKBQlvDNYLX0ZUY4OLzlg9ZDlH5ry905gpGVULNn47Mh
         A38+dS4D3V/g0s6Q1+lkpb5cGBGxiIbaXU0bBdSMTECBROtDjGbTeqIQNLTCzcb+4YgR
         Q1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FY/yCtkR8zuQxnB1ct+rZA02HMp31w5fOwHETAQ8JTM=;
        b=HlYGu7ZrX6DlrsG3EZzl9UqSHVOVYKDZP68q1zfwne1/PDLTK1rsycJyshb1scKEyY
         LAbeBIHpZwlBsLOfmEDOfcf9OxiKch6eynUunxnNIKo/iWk6qGszlpH0YxYlO8UttC7i
         VrmIz3yb+RHMylvumDFlYC7A8tn+g48xjLPmVDqgppLy8sXKG9rlo2KbEUzNzCuxwbUN
         nSo75ujtGV1zMOY93PIm1MAf9+wu9yXO/QNsHI2IB1ODpCW/ANUFou3knVyZfQO+HZ01
         aCgYYBNwsiaQ0wFle0CfKmAPWUodm81IiieQE1DXUVqqaiEYRu7KfvnAqDfi/demnyZo
         iIcg==
X-Gm-Message-State: AOAM533PXQYPPpdcxttbGHOk71GrzyVeeirjjsu7fHNYsZNhLocaS+t1
        2pL+eQj3eOsXJTsAemhX60I=
X-Google-Smtp-Source: ABdhPJxaTt4V0Si7E1alYegUBokW/M6dtm+g6oBvkKsnz2vPv3FNtR7Q36vy0Il8qrc6yu26GKVGuw==
X-Received: by 2002:aa7:8285:: with SMTP id s5mr11290815pfm.226.1597741774238;
        Tue, 18 Aug 2020 02:09:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:33 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 34/35] dma: sf-pdma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:37 +0530
Message-Id: <20200818090638.26362-35-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6e530dca6d9e..a2d91074bc6f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -281,9 +281,9 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 	desc->in_use = false;
 }
 
-static void sf_pdma_donebh_tasklet(unsigned long arg)
+static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -298,9 +298,9 @@ static void sf_pdma_donebh_tasklet(unsigned long arg)
 	dmaengine_desc_get_callback_invoke(desc->async_tx, NULL);
 }
 
-static void sf_pdma_errbh_tasklet(unsigned long arg)
+static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -476,10 +476,8 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 
 		writel(PDMA_CLEAR_CTRL, chan->regs.ctrl);
 
-		tasklet_init(&chan->done_tasklet,
-			     sf_pdma_donebh_tasklet, (unsigned long)chan);
-		tasklet_init(&chan->err_tasklet,
-			     sf_pdma_errbh_tasklet, (unsigned long)chan);
+		tasklet_setup(&chan->done_tasklet, sf_pdma_donebh_tasklet);
+		tasklet_setup(&chan->err_tasklet, sf_pdma_errbh_tasklet);
 	}
 }
 
-- 
2.17.1

