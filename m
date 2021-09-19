Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074FE410C02
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhISOpr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhISOpi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:45:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089CC06175F;
        Sun, 19 Sep 2021 07:44:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m21-20020a17090a859500b00197688449c4so10865127pjn.0;
        Sun, 19 Sep 2021 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsaGsJCStsTHiEfpVj6BO+eliZRcGPVjXTabPxhQ32M=;
        b=Oh0Cvrt3pwdG3s8tr8fkA5wY0ema/NIKhX8pnLDiQy5cBpbqATM+2PL244BxuH0Ye6
         f1/7TQXBSohKwH/HVQPkVFLUFhYnpSDqPz5j86PHqYPTW4wyc8s3jjqC+vT1CamdKybi
         bre4/VFbOkTPoualRBNeZ1El/ji/0TZFKFrOrPxfxLIAJdtj6FmueC69MZ7+Ta4xmQ3l
         wJvS8DQZJwnljck3GzUwz6wAGVqqzjA8qzbWj+Sapc/02BeNsGz3B9c228uHpLXgzKaW
         FC+qcZ/JSsp52NiOQBW446/Fwi6visVBiK3Rcb9zcLwPxfniSpctwrxBM39WMRWzDo65
         bHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsaGsJCStsTHiEfpVj6BO+eliZRcGPVjXTabPxhQ32M=;
        b=z4hqMzhB2HoldEZkNqWLjYqRZEZB9PyXMODLxltCjGe/9Xf2ozA7eqoo6v1wCpCjzx
         4j29Y9PXA2nhmmdOeG/eXkl4qXH2i5ud+uWAHTOFRdtssy8hArIZVbqdQ/DovSTMqq6p
         qDrejrEqjvblD+tOhKQGy9ykG/Gvx5+y1Aivcl0dfz8df0zqG/lsbEtr6GAI4nYUu1Du
         15Anfex3AOC8EgWdoDq98y1FdHhd7/lofAnIHZVGtrE3ua4grFPYkgCPNyUZtu1WXX/R
         0NZgvDkrZJUBPukPwR0Bywg1suxcJlFyOENCUyfyvC96bctVlT9MUUU9rAgGCVRmCkx3
         a4yA==
X-Gm-Message-State: AOAM5322IhzYnRt7JMHVHIMkTnCtFb8Wfxrkk48X9OT3WQKNNjVIIvcd
        SBVvOYPdjphBWOPvbqu/xXR78DtHYahtESkJ
X-Google-Smtp-Source: ABdhPJzFD+U2I7ogcmy2H6Wc5RDD5XT2+HtTQk0+5YtP+kgixknv68+Q5okesAhCuibJWO/eiQtFnQ==
X-Received: by 2002:a17:90b:f08:: with SMTP id br8mr24166702pjb.119.1632062651612;
        Sun, 19 Sep 2021 07:44:11 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id c9sm16270427pjg.2.2021.09.19.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:44:11 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/3] dmaengine: Add support for immediate commands in the client API
Date:   Sun, 19 Sep 2021 20:13:20 +0530
Message-Id: <20210919144322.31977-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919144322.31977-1-sireeshkodali1@gmail.com>
References: <20210919144322.31977-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Immediate commands are needed by the IPA network driver, so that it can
send commands via BAM to the microcontroller

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 include/linux/dmaengine.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e5c2c9e71bf1..9bac959b34a8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -190,6 +190,9 @@ struct dma_interleaved_template {
  *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
  *  to never be processed and stay in the issued queue forever. The flag is
  *  ignored if the previous transaction is not a repeated transaction.
+ *  @DMA_PREP_IMM_CMD: tell the driver that the data passed to the DMA API is
+ *  immediate command data and the descriptor should be in a different format
+ *  from the normal data and descriptor
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -202,6 +205,7 @@ enum dma_ctrl_flags {
 	DMA_PREP_CMD = (1 << 7),
 	DMA_PREP_REPEAT = (1 << 8),
 	DMA_PREP_LOAD_EOT = (1 << 9),
+	DMA_PREP_IMM_CMD = (1 << 10),
 };
 
 /**
-- 
2.33.0

