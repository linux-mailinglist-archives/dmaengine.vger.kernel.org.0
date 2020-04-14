Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68B91A725E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2020 06:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbgDNESY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Apr 2020 00:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405149AbgDNESX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Apr 2020 00:18:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E70C0A3BDC;
        Mon, 13 Apr 2020 21:18:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so378797plo.7;
        Mon, 13 Apr 2020 21:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xcEG33EjZw/LrE9HUefk/4aqk4uWI4YbQ1ppYifMxQ=;
        b=bJNNYYSu2+okRxcogXY4Y6Mt80VD42NQX8DnoADvAreT9VLW/HkbVBErMRlDi9GItv
         SApNFY5KNNe2bJ/cRN/XZtRa9zibZlOLKu9LfEujzunzjyxXwHLEGQzOy5PEyIS3F/gj
         P1KXvfAIU3y/23yp8pmFsq9hPPDm/T/r5QtPUlp9uRito14FJtVg2HpwEHeNbJqUsBGU
         u7CZd/6rhIkEHF8iJw/fuq8+9WuidTSuaH18GlayTmOs3cypu976JRiXsXMCcBjz7dkN
         WNBvZzXU8tNb+3C9aYWyGD5SeExdbnTDjAROdvYoYaTZcrRXuuAwzALxH/s28J8qbbf4
         pr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xcEG33EjZw/LrE9HUefk/4aqk4uWI4YbQ1ppYifMxQ=;
        b=NERyEZMi+DLs49tjuQMk6GieEmZuTXGJllIlnWCbrG4TaL68//l+B23mG9hpBkGXJe
         X3pCNUTXojQ1Q9aIIeYqsC5bJzOhEAvA8HAPjM9I5IUNKmhc8enKojfFl3nnuePikpZh
         5LgBrJ7+ZFFg+449y38DfnF6PPXcZ2sJQkvwxiHaYzxTAxDdK5R+GRY7QVq/mRcVvA9F
         Ii+hrv9vXTFVn5uIPJrBjT17eBN0IBk9DL16ICn1ZELn6z8fHcCpJEs9X56bqEyhnN5k
         EO65t1/xh/qji29M/4AT5tcEf0nG0d1gNjpXVIUGpNM5J1gDDvQauHLScq4WIPp4ijDG
         C34g==
X-Gm-Message-State: AGi0Pubk4004q3rxughHIAfIAVfy2kOkiwuBYV05pgSTReIrpg+rhTDb
        P792MAB+RSaNgaIUWDrG6Lc=
X-Google-Smtp-Source: APiQypKuSyu00FmXhbJYSusoKPKJUDFO7cmxWS0GS6JihlkrNj5XZmR8P7/jpgJ0Xoqz5gD7hUchPw==
X-Received: by 2002:a17:90b:f13:: with SMTP id br19mr11533283pjb.153.1586837902552;
        Mon, 13 Apr 2020 21:18:22 -0700 (PDT)
Received: from osboxes.am.sony.com (ip68-225-228-191.oc.oc.cox.net. [68.225.228.191])
        by smtp.gmail.com with ESMTPSA id v94sm1021202pjb.39.2020.04.13.21.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:18:21 -0700 (PDT)
From:   Maciej Grochowski <maciek.grochowski@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Maciej Grochowski <maciej.grochowski@pm.me>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/dmaengine: Typos fixes in API documentation
Date:   Tue, 14 Apr 2020 00:17:03 -0400
Message-Id: <20200414041703.6661-1-maciek.grochowski@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Maciej Grochowski <maciej.grochowski@pm.me>

Signed-off-by: Maciej Grochowski <maciej.grochowski@pm.me>
---
 include/linux/dmaengine.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 21065c04c4ac..31e58ec9f741 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -83,9 +83,9 @@ enum dma_transfer_direction {
 /**
  * Interleaved Transfer Request
  * ----------------------------
- * A chunk is collection of contiguous bytes to be transfered.
+ * A chunk is collection of contiguous bytes to be transferred.
  * The gap(in bytes) between two chunks is called inter-chunk-gap(ICG).
- * ICGs may or maynot change between chunks.
+ * ICGs may or may not change between chunks.
  * A FRAME is the smallest series of contiguous {chunk,icg} pairs,
  *  that when repeated an integral number of times, specifies the transfer.
  * A transfer template is specification of a Frame, the number of times
@@ -1069,7 +1069,7 @@ static inline int dmaengine_terminate_all(struct dma_chan *chan)
  * dmaengine_synchronize() needs to be called before it is safe to free
  * any memory that is accessed by previously submitted descriptors or before
  * freeing any resources accessed from within the completion callback of any
- * perviously submitted descriptors.
+ * previously submitted descriptors.
  *
  * This function can be called from atomic context as well as from within a
  * complete callback of a descriptor submitted on the same channel.
@@ -1091,7 +1091,7 @@ static inline int dmaengine_terminate_async(struct dma_chan *chan)
  *
  * Synchronizes to the DMA channel termination to the current context. When this
  * function returns it is guaranteed that all transfers for previously issued
- * descriptors have stopped and and it is safe to free the memory assoicated
+ * descriptors have stopped and it is safe to free the memory associated
  * with them. Furthermore it is guaranteed that all complete callback functions
  * for a previously submitted descriptor have finished running and it is safe to
  * free resources accessed from within the complete callbacks.
-- 
2.20.1

