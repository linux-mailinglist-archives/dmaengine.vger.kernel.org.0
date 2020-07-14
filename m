Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6589121EF0C
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGNLTQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLQq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F0C08C5F6
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so20899529wru.6
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLIjy5aQCoym5Mm/hCfDKR0dFhPfvd31LPr0bmAaNkI=;
        b=lnvYu/8jdk95UwX9IoDefntQmNZ+TclIUQ6X2+ECk2EmyNfMBSnJ+i5mPNOqb7kmeM
         fLy4ysPmpsGjO8sriBthSrL7udGqmt9/nuZ5l7zKTopOVTfaks9NXyO0gV74aG5K40sk
         x5bxKd00883pryu8HmCJch6RB7XfgGh5Ne39TcCPPFPZ84VnYZOnl3F9aFfqj45OnhBl
         zh+xG9CZrFaicAU4SyVU3j3xTIGosE7bPvvrO4l7S71upbFK2rurlyQHcVSY14RqCI4Q
         E+qz9npM2rYERwSBflKs0s8CrvBk5r0P8pPmgAnq/cKLuvv/eO8TGROqdG4/raMbpw5k
         hYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLIjy5aQCoym5Mm/hCfDKR0dFhPfvd31LPr0bmAaNkI=;
        b=XGZmLUSiTLccFH4hw4NxkWOCwAxHsZnca5nsiQt2kfyclm5ZXCgRqQslNQYfm/QZ+n
         MdDWmgoazhxw46sLgsliRuEatQHtS6ZH7BwQCG/wfajn/HMP1luvwCbwjiAbN+WiVsu8
         QIixcny3nfpDUcO7nppz8OZtlsoMyBhcKrciVZ8bo9Y/oc+5luCJliRM1S0iVJt5TxPn
         VLAlHeA1uxQWwgwCj2GUGO4uPBbezcRrcUHVk5C46cfpdr1T8FdtVoi0dTi5tPUdyXAy
         97QRqFdKS3+tBb9TjrqQOrITa23i+rcV67+1w9f/97hhpjxsrzv1iUN/g3V99FJgjjgP
         U2cg==
X-Gm-Message-State: AOAM533KoFP38Py6Q8In4X86HDHCtQZGF02Qa9JKMiur3keVDFKIMJpM
        vQ9a0YqbAWShCaDNXxgK2jKQkA==
X-Google-Smtp-Source: ABdhPJyPj59yNtEMPOQ/nf0KvMrMzW5MAG6d1mHgCW2Smzjhseeu55XTnni31ER4NoiwLyYXa+7vOw==
X-Received: by 2002:adf:b190:: with SMTP id q16mr4666971wra.356.1594725358605;
        Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 08/17] dma: at_hdmac: Repair parameter misspelling and demote non-kerneldoc headers
Date:   Tue, 14 Jul 2020 12:15:37 +0100
Message-Id: <20200714111546.1755231-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/at_hdmac.c:666: warning: Function parameter or member 'tx' not described in 'atc_tx_submit'
 drivers/dma/at_hdmac.c:666: warning: Excess function parameter 'desc' description in 'atc_tx_submit'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'reg_width' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'buf_addr' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'period_len' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'chan' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'desc' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'period_index' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'buf_addr' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'reg_width' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'period_len' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'direction' not described in 'atc_dma_cyclic_fill_desc'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 73a20780744bf..45bbcd6146fd2 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -656,7 +656,7 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 
 /**
  * atc_tx_submit - set the prepared descriptor(s) to be executed by the engine
- * @desc: descriptor at the head of the transaction chain
+ * @tx: descriptor at the head of the transaction chain
  *
  * Queue chain if DMA engine is working already
  *
@@ -1196,7 +1196,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return NULL;
 }
 
-/**
+/*
  * atc_dma_cyclic_check_values
  * Check for too big/unaligned periods and unaligned DMA buffer
  */
@@ -1217,7 +1217,7 @@ atc_dma_cyclic_check_values(unsigned int reg_width, dma_addr_t buf_addr,
 	return -EINVAL;
 }
 
-/**
+/*
  * atc_dma_cyclic_fill_desc - Fill one period descriptor
  */
 static int
-- 
2.25.1

