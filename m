Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4B25775C
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHaKgP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKgO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B352C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g6so2748417pjl.0
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTuqGydsLjCuiYOr0kdtMvVN8c3zKMVJf/5YH2LpKyw=;
        b=IVJAEmUq+LOciB2x676YkDyPKLszYWKVMgGx9bHF2JVbhg4ylw0hh/XiI/MyV4ms+6
         78oaxzmyjNr7uURby8spcUPui2UssM4MeUq6G7hjXjV+1tjUnug2OSUcvk7DR1603iDw
         fjXSdoBc3YRJacTF0Xh3sSIWk95NiXEzYWi0roEl0pwibVi4eQq3cs+5PWT21ej3CfZ2
         xiXyScJF5VI70EkYq9kZMy+0Wkbt2w9ZG8uga47ZP10FCouOAmbkokYtdKwFRgpLVziw
         l42gqFkSGlwb566FQLMnGSm2XCzlzgC3XaG+HbOtONN+ZPGjZ26iZnBJtIzkV9uSMtZI
         zfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTuqGydsLjCuiYOr0kdtMvVN8c3zKMVJf/5YH2LpKyw=;
        b=WCvM5UQa3yUMdA/MiNToR/HujIJv+dKyF8eGP1A20bdTe41KN/jJOOM6p5pLWvnwyv
         oLX9Svz6UFw5cxnZm0TQOvMqlyVW2tbOkckgSH7JjVBm8mWkoSKqQcYDNHygRDzvFHpV
         qcDfPlI6ynjigxEtK1sg/UX47t0VMkHOd+39ijXvY3FBv4EskOsYe5JlkQG2/1uK6bDY
         cn7bOuO5r1S31fE6muVzlxGwo5IrhnzwXvGsvmPm31jX908tuz9KWf+vUKG5j4C959eC
         v4NPl4WXbcshg+/hi/3BsT6iMfaLz09jABKMgywBpGxtZyyU45UKXaglRiuCW2dYCUrz
         fNrA==
X-Gm-Message-State: AOAM530OYDFWRVS4sm7eXE0OxmeMEUYu+I+pEgY6vsqKBELHthTxzYbv
        WinLn/qNsEZxk8/VfFnSJXM=
X-Google-Smtp-Source: ABdhPJwWs1TaeZptDBNq+I0CH5fJ1zZtTF1avr4rwgFesSK46dFFy0fRoc0a0ydm+NQw5XdtIRNUzQ==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr582507plz.105.1598870172755;
        Mon, 31 Aug 2020 03:36:12 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:12 -0700 (PDT)
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
Subject: [PATCH v3 02/35] dmaengine: at_hdmac: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:09 +0530
Message-Id: <20200831103542.305571-3-allen.lkml@gmail.com>
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
 drivers/dma/at_hdmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 45bbcd6146fd..4162c9a177e0 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -598,9 +598,9 @@ static void atc_handle_cyclic(struct at_dma_chan *atchan)
 
 /*--  IRQ & Tasklet  ---------------------------------------------------*/
 
-static void atc_tasklet(unsigned long data)
+static void atc_tasklet(struct tasklet_struct *t)
 {
-	struct at_dma_chan *atchan = (struct at_dma_chan *)data;
+	struct at_dma_chan *atchan = from_tasklet(atchan, t, tasklet);
 
 	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
 		return atc_handle_error(atchan);
@@ -1885,8 +1885,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&atchan->queue);
 		INIT_LIST_HEAD(&atchan->free_list);
 
-		tasklet_init(&atchan->tasklet, atc_tasklet,
-				(unsigned long)atchan);
+		tasklet_setup(&atchan->tasklet, atc_tasklet);
 		atc_enable_chan_irq(atdma, i);
 	}
 
-- 
2.25.1

