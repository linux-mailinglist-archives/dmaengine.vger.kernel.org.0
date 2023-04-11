Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95C06DD7B7
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDKKSH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKKSG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 06:18:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5939D2D67
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 03:18:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso10380353pjm.3
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681208285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xishqwgXyYhfdvHtZU0pcOZOPc9q3eb4WhVoibR5fD0=;
        b=ZIgwG+osug0iQMZdWCcSaQhwgJjJ7UBhDHJgh7iySX2DUn5Emj4lpC+mQ10UZwAnsB
         0QkIvRYZnEsqQ1/RqW9Dn3hhN+xvm1209jqgOOF3NvmC8RJBz5dYYgM2rKOlq3qEmiWd
         VEekxlqxpm4Gz0i1OXL3zLJ7a/6TLizp8o6KuavfIUtzl4uHmtSLl9ueV/CaO52tOEPE
         vuH2pE1ZIVKS9te0fwxOn5YGgIvQWNWDKuRzi4O7lmHuyVwNkUULKCI+nD44QrTmn+U+
         t9YfE1cfWHdxqv4P8clvHZ4RKxnATEu3cclrMetgQzDQw5yqNtd5i4en68a1SKk3WNpw
         9a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xishqwgXyYhfdvHtZU0pcOZOPc9q3eb4WhVoibR5fD0=;
        b=EWR7XJW5m7e0xUuqwh7FXsc/V7FSQtGCG0rCSv6gX2NCvRg4jjLnrxFnfQwYuJoyLk
         dq1QainHpsL5kpEFDOiGwOoQyf9FKRAHU4gf8GzcIZ4YglxPBcGyxm1uqgxeOqpTZDvf
         t7lUv9HP8nAL8u2e1FAR/rJZYL3AK/UGzjesBADslvO3dDQ7bQZJ5QIUvrD4fnjtqpeh
         FloManmTypSzj9OaNXkckkfx19oDM3WtglI2C4oYBGvXc/Q5Td/9PLEh8H878b+WjR9J
         EOu32XUgmf8KiaCXQWpHHijOC/iBnZlEHFpBNM+MvTmMdfHDFAV/ATUW4b8YTzhHHxx4
         WSVg==
X-Gm-Message-State: AAQBX9f+a6A3hWaDa0npm54IuvwolxYwnDv3P7C3pkWzVa16SqVTHWwO
        0KTIs4szo91N3KdZoVgNlDunKw==
X-Google-Smtp-Source: AKy350YbLhBJRnTxvPCNtIZg6/r3h5r3Fs+wFbUfl5bhUAkC7/VV1yvwvq+KsGil6IqyTt7Oze4ddw==
X-Received: by 2002:a17:902:ecca:b0:19c:f232:21ca with SMTP id a10-20020a170902ecca00b0019cf23221camr17822391plh.3.1681208284833;
        Tue, 11 Apr 2023 03:18:04 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b00195f0fb0c18sm7629794plb.31.2023.04.11.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:18:04 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v2 2/2] dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing
Date:   Tue, 11 Apr 2023 19:17:58 +0900
Message-Id: <20230411101758.438472-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411101758.438472-1-mie@igel.co.jp>
References: <20230411101758.438472-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The issue_pending request is ignored while driver is processing a DMA
request. Fix to issue the pending requests on any dma channel status.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes
v2:
- Rebase to next-20230411

v1: https://lore.kernel.org/dmaengine/20221223022608.550697-2-mie@igel.co.jp/
- Initial patch

 drivers/dma/dw-edma/dw-edma-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 26a395d02f5d..7d2b73ef0872 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -308,9 +308,12 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
+	if (!chan->configured)
+		return;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
-- 
2.25.1

