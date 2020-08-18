Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B7248171
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRJIU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJIT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A294C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so9484980pgf.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqznZ0QFtNhvUqAjtholQ/Q+9qOGKPjtIbAySrocxDs=;
        b=Pu0Rc+AoJHTpg+cqQFH4m/G4dnPYr15jM9sjxrsdyR8JsCmzKFGB4O0vTO30e/VpSu
         VmPn6sgciLuZD6au9+ar62cC0w4vrhx7Z+94VaCeZk/HEkdOfejM2Fv6YXuCWe4Z/yZ0
         0nWRdWiQz3++Z1A/9OvwqH5S1oZuclvEIbv5qJw0ac8bslUpn25WH7xF7a12CfcpxjrL
         EWzM7fF/M2TqE04RQ5fwwwUK1AQlBMTBXPil6KBAQT822M2Q/gXffOn8YWOW5uFBLzgV
         YFYzVBgKX6PPZQtPZI/TKxTd5ChuMIk3ULfvAcnMzbQ1Zg4bEoDLUNXOQcroDCdPLatn
         aKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqznZ0QFtNhvUqAjtholQ/Q+9qOGKPjtIbAySrocxDs=;
        b=pavFH10x35iO7uSL8HcQYW/jx3uoEyc9B515LA+3aRTvNLsdFNoNhuSFO1pQv6oUTZ
         9ha+x3/d1D8toqWo3DOlF45E7P2UtPkqZPBvP7A4ldT97Bf3/kZM45NpwyveRI92uzwN
         Q7J5je3cVMXOcyVNJkCb60CKB9coLKK3jIpb6h6eLofnCYji94vNqYQM5T07CapkgKHC
         nf3qLLix8m82+qkVS9NInwy+vbmSwlob5rbX5e5hpjU/BaCj5spKgW2x+lITo6kgaGdV
         48nCi5uQy6qvzB0yVFj2rDQllgx7+HTS3ptjnbZwQgFT84oqtOjbuoavnWZ+A2i5NXrA
         5P5g==
X-Gm-Message-State: AOAM533EpdZPlaeIacV7iwUS0jrDpVi/v7GkQ5XdzS1uxm+Wqk8SLzAa
        lN2tjRQ+DHo+kAYCKGW2lmI=
X-Google-Smtp-Source: ABdhPJw3+uvRai3TQJqquDmkaXgpSwHTd5O29vxb7guZD/O/L/9/IGyDHtacr35Q8A0flPdurBxWvA==
X-Received: by 2002:a62:164a:: with SMTP id 71mr14667069pfw.266.1597741699081;
        Tue, 18 Aug 2020 02:08:19 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:18 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 18/35] dma: nbpfaxi: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:21 +0530
Message-Id: <20200818090638.26362-19-allen.lkml@gmail.com>
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

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/nbpfaxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 74df621402e1..4ef0838840f3 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1113,9 +1113,9 @@ static struct dma_chan *nbpf_of_xlate(struct of_phandle_args *dma_spec,
 	return dchan;
 }
 
-static void nbpf_chan_tasklet(unsigned long data)
+static void nbpf_chan_tasklet(struct tasklet_struct *t)
 {
-	struct nbpf_channel *chan = (struct nbpf_channel *)data;
+	struct nbpf_channel *chan = from_tasklet(chan, t, tasklet);
 	struct nbpf_desc *desc, *tmp;
 	struct dmaengine_desc_callback cb;
 
@@ -1260,7 +1260,7 @@ static int nbpf_chan_probe(struct nbpf_device *nbpf, int n)
 
 	snprintf(chan->name, sizeof(chan->name), "nbpf %d", n);
 
-	tasklet_init(&chan->tasklet, nbpf_chan_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, nbpf_chan_tasklet);
 	ret = devm_request_irq(dma_dev->dev, chan->irq,
 			nbpf_chan_irq, IRQF_SHARED,
 			chan->name, chan);
-- 
2.17.1

