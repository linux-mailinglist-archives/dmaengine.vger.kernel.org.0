Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324DD248173
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRJI1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJIZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89BC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i10so3928750pgk.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBdUK8kTW7LlD2iWbT6JIJ3+2TeLAftGafICpZAEwWI=;
        b=t7UjYDAPfunsDK/cTmXO08KI13m8mKRg12EZ/WupBLRKqSPuD/lBDh0FON0+mTcKjO
         4NsO0k/bTHdET3d5sDAY53UiHoxvn9XZAjD4wWcRKwlRuvOkBKYItW5zbIEJD+betLBg
         0brJgYNwnhIcg9ZHqtkxfO9vb4n4ujVtLXzv6M3Ojzt0oPXSjJ0QNcN5UgKhNzPxOXfZ
         rRtHCtYvZcLTHe2LnGk3vtK/BNcBnhKIBbgEjflkYBSx2iWBl+jFTVe608XpSIecso7o
         8QgS4EnihzyZQuA19Oh5MeZgqe2y/RDIeXl3I5T2a/GTKuKqi6g+uuXzmsjA/V45k/fJ
         m8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBdUK8kTW7LlD2iWbT6JIJ3+2TeLAftGafICpZAEwWI=;
        b=djDKQNgKP3sxH2SekC5q1OPDrRt3md/APNM+XQz47M7hIjvHB/kYMH1WZPgYa8cLyG
         vxFAtvl+8AceTEEXTchBSuVcxqwow3W7Ymx6M3K7/ei1kIEixBZ8HiniBbLXvfFFisMJ
         HHrjzaQjD6FEi9A/KPbIMiyCdKQnixMQLJ/UIRDp101ld55pRLLk7C+2TPh9AuaXHePO
         n22u+OeZ4Ginj+PyCxPTrNFBsuzcfEI0nEXjFOvrqLbKSViYeD7ESQWwW+ruV1J5t9+9
         yPOqUXOGSIEQjzqP/+vqSY6X/dG8mleKNpv4QLB1PVH/KSBgnYybCYgauIecoSpsplg/
         NwLg==
X-Gm-Message-State: AOAM5310nN+UquhfCNiQDq4X6Gtwq7MK8G/wY28RndvkIFF1udSjcID6
        ln4Y6PRlEQbyZSdHbKYj/fs=
X-Google-Smtp-Source: ABdhPJyS2Is2C6RxaV3PWAwrtLFLZidsMeNQkkPaWS3t6FHTeNdbvnWa1N9TraTSw0sZC/1sMR6MsQ==
X-Received: by 2002:aa7:8a50:: with SMTP id n16mr14554894pfa.81.1597741704108;
        Tue, 18 Aug 2020 02:08:24 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:23 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 19/35] dma: pch_dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:22 +0530
Message-Id: <20200818090638.26362-20-allen.lkml@gmail.com>
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
 drivers/dma/pch_dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index a3b0b4c56a19..0cd0311e6e87 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -670,9 +670,9 @@ static int pd_device_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void pdc_tasklet(unsigned long data)
+static void pdc_tasklet(struct tasklet_struct *t)
 {
-	struct pch_dma_chan *pd_chan = (struct pch_dma_chan *)data;
+	struct pch_dma_chan *pd_chan = from_tasklet(pd_chan, t, tasklet);
 	unsigned long flags;
 
 	if (!pdc_is_idle(pd_chan)) {
@@ -898,8 +898,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		INIT_LIST_HEAD(&pd_chan->queue);
 		INIT_LIST_HEAD(&pd_chan->free_list);
 
-		tasklet_init(&pd_chan->tasklet, pdc_tasklet,
-			     (unsigned long)pd_chan);
+		tasklet_setup(&pd_chan->tasklet, pdc_tasklet);
 		list_add_tail(&pd_chan->chan.device_node, &pd->dma.channels);
 	}
 
-- 
2.17.1

