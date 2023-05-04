Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0056F6E6F
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjEDO7I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjEDO7D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 10:59:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95F10D8
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 07:58:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559f179cd38so8617117b3.0
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212290; x=1685804290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FA/v04s+rMO6cV89w8yi7EFtwX7zbYFrIK72OYPFMEw=;
        b=FMJmvHZO0oQQ142FoQrFK15pvzpeXL1Lo2mjHlVRciBbfAk63P5FASSKbn0+TctAPZ
         9WnMt+oGJjdflLbJEEShaU6sl2k2KcRxUM5D4yNimLQz+vAMsWCX1PSVlaxoIAkX9yen
         jw+7QzQyL8uQJwb6Cc8wkavUL9Y1N9OFgp2yMwDiBOXBVIp9M90E3G8P+2iGB9XHYJK/
         mcrAQUTuRiiNbcgV4GuYDOpNbDdyANQxTJxpn+AVruKnn4/mG+Zrz6l+a0CKYzFjJVw1
         R/F9OkCp0LXptXNjrM/2oSWTf6t1etVlMi4TtK9SsxiJd6gPu7Uglx7mJC72ZGft99P7
         psPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212290; x=1685804290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA/v04s+rMO6cV89w8yi7EFtwX7zbYFrIK72OYPFMEw=;
        b=euq/HggLM4pLl9M5eoKOj2PLcI/olTby6LZregHebOPR2PHdVzkyaLfWgZ/Rt3LOhK
         SIYLpluUZSvzv0RyOPCyYPvHArAKWoGuAyVia2oKMWo3+DCvmskWBIzpjGwwNKg94TTr
         xKCr0RQdXOMS4d3xy3g9JGrZ/v+8X+JBDLPLhQS3rui0KTh+zIwtNRV+wXszEI5VtamB
         v40J7o83Ik/ZWzRNspO3YHsVN/XF1axYUnfpN6YQH1fQlSBI4YeBzGuPQp37MaOZBSgj
         TckMdElOEhCuyI9EZ/AndYAa+UJ1WRVuy/8IF9Od7NHoJQpK1alKgYlmRdOShMwya+k8
         iHRQ==
X-Gm-Message-State: AC+VfDxSmnuQdqFB1RIQHblAcHmcoRMPEjIHHUpq7miY8AnIH0tT+WxQ
        20dTzpmzD3fBq4+iOXmEMHdVlY26aY2TXQ==
X-Google-Smtp-Source: ACHHUZ4ZHjCWkvdGnfu37SUozBAPIr2xM2xyUC8ahsbgKQ2dlv/U/mQ7lNPYnTFCoer9oo54iv9Ny5b8S7HDoA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:c148:0:b0:559:d8ad:560d with SMTP id
 e8-20020a81c148000000b00559d8ad560dmr1388760ywl.5.1683212290122; Thu, 04 May
 2023 07:58:10 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:32 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-3-joychakr@google.com>
Subject: [PATCH 2/7] dmaengine: pl330: Use FFS to calculate burst size
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

Use __ffs to calculate burst size in pl330_prep_dma_memcpy() for
consistency across the driver as other functions already use __ffs for
the same functionality.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index c006e481b4c5..39a66ff29e27 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2804,10 +2804,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while ((src | dst | len) & (burst - 1))
 		burst /= 2;
 
-	desc->rqcfg.src_brst_size = 0;
-	while (burst != (1 << desc->rqcfg.src_brst_size))
-		desc->rqcfg.src_brst_size++;
-
+	desc->rqcfg.src_brst_size = __ffs(burst);
 	desc->rqcfg.src_brst_len = get_burst_len(desc, len);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
-- 
2.40.1.495.gc816e09b53d-goog

