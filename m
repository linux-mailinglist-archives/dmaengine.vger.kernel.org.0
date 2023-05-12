Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09074700A12
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjELOPe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbjELOPZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 10:15:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3DD14924
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56098b41d42so57929767b3.0
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900916; x=1686492916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwCGXSf8iY+/DH2QgsH2WgzsBbqjZwTLYrp1XXczDUM=;
        b=OY9dkKT5GQA0dusKiKaS7jrpoAGc7STMoAC5iq8ZfQ23vIfNvff8zDGgoY30mJ/5tD
         9i5nx/eeF4spSmwJa6idZkSXZNinZO9XvLfzF6UvdZkIqXG9NT4b8J8zNPdj8LzTmHxk
         7REBcii9VONQpxmUV1ZgJuykuVbQPVtAhPWlMybn7UfMyv8CfnQ7ky/YyFRHSkAev3PK
         MeZXSlsVN9NAYV0dajL373J8mY+unWtwU0Y3WI1cw/zYGoJPInHFFssN72jUC6uC7mFG
         TIRG8oqiyD1k+RdxYwV8T1XyV86Lt927tbp7/DrwyLP1upxf9Pd2O0L0eEZ2NhxUSfZf
         BmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900916; x=1686492916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwCGXSf8iY+/DH2QgsH2WgzsBbqjZwTLYrp1XXczDUM=;
        b=PLHurmKPyLTGD1OQXfK06ZQQiI0/xmm8cwryjNzD5hi4tmoHoPgN9HiV6J3V0GN9hl
         V+YmALSFMRRk5Mt+1BEyDB6rfUy2bynpFmsme0AxhpGndTt92NW6D2Al4HhK4aG6AOg0
         LqJNk/DlY4LPllaDpi/GbcX2oVL8qTT9ktMJ19x+HHaoaH/bk6QXvMq0h53azB5RHZWz
         fX55dZNfoOvwl1pqdkYyA+1Nd9eqM+JvzO7hpYE2wk63k614uDHvx3+kfseYK7DNOb1C
         3/MWv0DXcH0oxy9oQVG+Au0vXG4Rfp49ZjtSCSmMD7bg/P3Rcoe4iv15ALLlm1Gcnp9b
         aPdA==
X-Gm-Message-State: AC+VfDwKqa2ccCVMRznqXFqHMEDOQHIeFjmExWEi6ROlCP/fNFLj+lAe
        d3PmAZh/N6vfVK54DOLOI6CCrFbeXe307Q==
X-Google-Smtp-Source: ACHHUZ6vj73ZJJY9u+8pIa7SQmcBCLaiwjS1XLKrddb4JGDp5BRcKH1etJcsBSg/adpZUKOfhQdn8y9RDHibrQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a9c3:0:b0:54c:a67:90b with SMTP id
 g186-20020a81a9c3000000b0054c0a67090bmr16185230ywh.5.1683900915935; Fri, 12
 May 2023 07:15:15 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:42 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-4-joychakr@google.com>
Subject: [PATCH v2 3/6] dmaengine: pl330: Change if-else to switch-case for consistency
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change if-else to switch-case in pl330_prep_slave_sg() function for
consistency with other peripheral transfer functions in the driver.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 39a66ff29e27..746da0bbea92 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2883,16 +2883,21 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		else
 			list_add_tail(&desc->node, &first->node);
 
-		if (direction == DMA_MEM_TO_DEV) {
+		switch (direction) {
+		case DMA_MEM_TO_DEV:
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
 			fill_px(&desc->px, pch->fifo_dma, sg_dma_address(sg),
 				sg_dma_len(sg));
-		} else {
+			break;
+		case DMA_DEV_TO_MEM:
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
 			fill_px(&desc->px, sg_dma_address(sg), pch->fifo_dma,
 				sg_dma_len(sg));
+			break;
+		default:
+			break;
 		}
 
 		desc->rqcfg.src_brst_size = pch->burst_sz;
-- 
2.40.1.606.ga4b1b128d6-goog

