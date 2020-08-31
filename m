Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1A25775D
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHaKgW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKgU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9038C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so2828162plr.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrypxtxNCzZ22dGNluZ8L/tSH2Sb1as0JwtAxE7h1tM=;
        b=py7Vau2eIghhsMPCzq+54esfCF/uwJmVXwANmAlwka4v+f78deTKi1hDzvggUVL83I
         H7hXreU3Yv1KxEcRILS9x8o1xpG8BAVQcZIEWMrcyUiHL8I6cjnAFQtZyXqp0FleOeJC
         WAUzMx53bgqPozxR+FDn/woztDAvm1J5HUJVIIT5pE3euSJN+m9pstaKfRFl06/evr9k
         m2olwXX5IQ7QDuW/FVat9rG3RZYOq2BuJv8/w4JtTAAV7VzuU+HfrCcebdQY7z1uOqt2
         HiYGg/wLNzR89YszdMkBcuLTu/ISEYDlBLj0xliwfoIBFI7GriNSPMpC2SoZQlAyNUs1
         CbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrypxtxNCzZ22dGNluZ8L/tSH2Sb1as0JwtAxE7h1tM=;
        b=AHgJNvhXlMSZb7YGyaFlhp+DdpzMbf1gv8OJtcFo+GxMlP3lfedoJy86Y7lE6Rwn4W
         ZHEMxGqBXwe7a0ywZi+ap6lUdGH/eebce57oolCceopagz10r9bJGfHntpydGTFJCLX6
         ahBc7OPKArxkfKAOJHOpywmW/pbcOvNphFY/Iu3+MD00Qsf4yxAjGa0COE50xUxZB+t9
         ucB06n3GeUZHNysBGdidDHuyhTxRvU9s4TIFF/k4PR4OPiDm9IzFaGS6SfihHyVMPbbE
         jTn/pQA/FATN/JL322yyRRWCzkSkK/8BavL4u7dPuhVKf/3M8+njd0uiSAAjxvRwA0tI
         IFkA==
X-Gm-Message-State: AOAM530mvoBC2aBbVUe45XiPMmcxqs2uOVyRBlZ/nsMlkPh6+144HX+7
        hu70ngaaPK29KepaGrobPyg=
X-Google-Smtp-Source: ABdhPJyATjy8+fE/clBgva7xHRKnI90aLJGMdrCyb1YF9jJJ2eu83iCIfp4jfvBhpNUOlAx51GZT3Q==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr799907pjm.12.1598870178455;
        Mon, 31 Aug 2020 03:36:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:17 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 03/35] dmaengine: at_xdmac: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:10 +0530
Message-Id: <20200831103542.305571-4-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.1

