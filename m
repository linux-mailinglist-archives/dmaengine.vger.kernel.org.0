Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42DB24815E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgHRJHJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054EC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so9469124pgb.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ifR/DJf1sGgqzTHJotiPifvWfvzD2Us8XuU7ypDnNLg=;
        b=PGF9+nfIPadCuNajipdHndIvD/2MwAaof+yvbCunWAFH8GH5hDjRLUqZvS4EjCnty6
         h9UGLjeDKGi6sjyxa6yXqipgELx45w3Wu8xzIx1FAWTaUZ84mQaXDTRIEPX7A3PahhyM
         ufwL3lpi3cPQDa3o01mlLpNWKDNnldX7tMi8ReqR8P8OMHDUt0OOTxwOva1IYTvU9rDU
         CQkK14K9voD1lp9WYaASY4HM7VWAtnW3/9UWsZUMnzuFwbxpa8cXCmBzDTfAbUJiBlrP
         v+rRMmTpfO6QM7rRA4u0nRhoMDB/1RLXDv3TH6XoBzSCrzVPvbkvkvtLDhdzlIsqeRp3
         Ht+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ifR/DJf1sGgqzTHJotiPifvWfvzD2Us8XuU7ypDnNLg=;
        b=T2lUfsVHo8F8iz5XRjp2sK2JTX8Mslt/IRraHdFCBS67SJQ15qmVdDUQ7kdS7mLSBF
         D19h3kbvrZmp3mFvjHsM0ZHHxY7veh4tASV0ddBdypvXyDmLdLO2cDFhq4NFrkl0PdQB
         4D0Zl3ZPcJeU9GYOJbOmuZYEjBU7pfFOKjia3yK4mxPTQg8FSAIZO2Q/TM+C5M78Yuwm
         HNXYdfAgPy6CUZnQOReVvKUGHp0jyzCRHENzojL2QvR1qcjzaEDCBovgqB1GNBgRfom5
         sqzeXC3HTP6f4SDRZ2IVCZj+KJ/zIh5rsvEqu8RMLj1qefK4tDF6ghIhZLwtd4Nuycw2
         8IjQ==
X-Gm-Message-State: AOAM531eCi1grXX9/dQPGJLdX0PXlnMiK8WzSeYu1pKxqk9cWc12x0pw
        2vP+7jFkkyEE53YSJXnqaxw=
X-Google-Smtp-Source: ABdhPJyMQEsN5t3ipJpI48Rf3boBFpAj2XBT9pTcgP/UhMbsHUu4McKGgoSrAoMHQsNdaJiM42MAvw==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr13045019pgp.105.1597741628360;
        Tue, 18 Aug 2020 02:07:08 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:07 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 03/35] dma: at_xdmac: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:06 +0530
Message-Id: <20200818090638.26362-4-allen.lkml@gmail.com>
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
 drivers/dma/at_xdmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fd92f048c491..3b53115db268 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1613,9 +1613,9 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 	/* Then continue with usual descriptor management */
 }
 
-static void at_xdmac_tasklet(unsigned long data)
+static void at_xdmac_tasklet(struct tasklet_struct *t)
 {
-	struct at_xdmac_chan	*atchan = (struct at_xdmac_chan *)data;
+	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
 
@@ -2063,8 +2063,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		spin_lock_init(&atchan->lock);
 		INIT_LIST_HEAD(&atchan->xfers_list);
 		INIT_LIST_HEAD(&atchan->free_descs_list);
-		tasklet_init(&atchan->tasklet, at_xdmac_tasklet,
-			     (unsigned long)atchan);
+		tasklet_setup(&atchan->tasklet, at_xdmac_tasklet);
 
 		/* Clear pending interrupts. */
 		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
-- 
2.17.1

