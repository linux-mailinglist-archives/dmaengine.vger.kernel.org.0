Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6850CA66
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiDWNNp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiDWNNg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 09:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8614718E08
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650719438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wij39qJ9HWPhVr791bjyPrFYtgEnPWODJDqQF2hE5C4=;
        b=F6zybXuFZzCU9Wbn1qd9JdcuCXcWAlEeSGRbl7nRr9EO0dk4FRc9iYOrsdGxiPgLTexH9W
        nKabGsdTBdgTonBMqmWO1kulGhkcGk+tExjo2iKLy8p03rYzfN+Tsl4V10iPca3WhX1Bjr
        5ZzrB+MvuGGQHnPQ4Bc/webG3o2reZA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-ZbXhfK13NVyUDS93maqMTA-1; Sat, 23 Apr 2022 09:10:35 -0400
X-MC-Unique: ZbXhfK13NVyUDS93maqMTA-1
Received: by mail-qv1-f70.google.com with SMTP id b8-20020a056214002800b0044666054d36so8809174qvr.12
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 06:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wij39qJ9HWPhVr791bjyPrFYtgEnPWODJDqQF2hE5C4=;
        b=SnQEdmJYDxcXxK2w4P3h941NKz+HtkTraNQYT96TEtD0sf9pIIy/NNjAX7ewKrlIPk
         ydLOKt8EI/jc6UFmgivo6TivYWudnpYb3EElwPH0z5NZ1Nhg2eFsC1whRo7HxoKXMCZm
         QHq/B/cCSpleYvV30vKWTimEQLBLOcNRAN4lf85kIt8EA1kCSDzjIqWqD07fubkt6n4v
         I8YgGcUHJHLpbq7gLWj4vVFPkcnK3ca7pWKWNJdYYnsR0PNBMPEdeLwQ4p7AAquCPueC
         U42rb2L0ZbX5VF45Yr+puf8q7izKQVgRt3z55MJt5GN2n+CQT4kFki7PJVZTJTdmwa3C
         HPHQ==
X-Gm-Message-State: AOAM530D95tSAjiztMAdSsg6Pd9I/YapyAJ/P/wj4LGexduyMnFS7XGM
        UwK0IHd9bOeJ9IMgG1hBb6RGq0pyktclRExnWL9/LMU5IGuEz0B9TI6Dk0hLfdbQHGQICXkUSB5
        XpzIkuPDbHSLFvqWoryxa
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr6726390qvh.106.1650719434909;
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWqrYzu4Si5AwvbGKg7LWrjxMSKeUOHEcrlmxnE8PbfEereCgweyLbtYiOzUEYXONTVCdpLA==
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr6726378qvh.106.1650719434758;
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm2261137qkf.128.2022.04.23.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sanju.mehta@amd.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: ptdma: change pt_tx_status to static
Date:   Sat, 23 Apr 2022 09:10:26 -0400
Message-Id: <20220423131026.798269-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sparse reports thise issue
ptdma-dmaengine.c:262:1: warning: symbol 'pt_tx_status' was not declared. Should it be static?

pt_tx_status, like other pt_* functions in ptdam-dmaengine.c, is assigned
to a function pointer and is not used directly outside of this file.
So change its storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index ea07cc42f4d0..cc22d162ce25 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -258,7 +258,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
-enum dma_status
+static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-- 
2.27.0

