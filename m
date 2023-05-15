Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D02702A7E
	for <lists+dmaengine@lfdr.de>; Mon, 15 May 2023 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjEOKcb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbjEOKc2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 06:32:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B7109
        for <dmaengine@vger.kernel.org>; Mon, 15 May 2023 03:32:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f450815d02so38755405e9.0
        for <dmaengine@vger.kernel.org>; Mon, 15 May 2023 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684146741; x=1686738741;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1uXgLj8iPGCwduhIKMsuLtvmuyqdXZ/CxPIhn1qFmA=;
        b=pi0y4lOzq4/450RClq+BDvTeDV2t6iajtGmlSRRzcHbUFRnSJKdnNRe42swrRqrggr
         VMMlPpxQfU37gmCrqqK0mxVVKRnn2wn/a1Fj7f5dwRoYIuPfnbXSqV+nBUiWhvE14zMn
         CKsW9LQ67RGazioVNP+eG2vHwNDQkGCUcGSeYGb8SL9gCIr5sOrFJ3wuWEWVDh9b+LGF
         tneEVrb3D6ybO78mZkTPm+CZ1B83YffNX3FyY9M4FjvpNanTTlZX+W6jMlLbbNX5owRA
         xEmnqho9yNirij+G+N7pzE3TSHqcABzxWdrri5XisclKIFmhtPonkGQ+ZNGlcAdhZi2M
         EjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684146741; x=1686738741;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1uXgLj8iPGCwduhIKMsuLtvmuyqdXZ/CxPIhn1qFmA=;
        b=h1LWc22LsDKMfCM0rZFCDuVqNcn6qENZn0q9BHnWyjzpu/rGzkkzu8e92EC+QhPA2U
         GLGJqXhC+V0SoZfRAmzVoPMScY1bTyeYuKhgZEf/4wk8O2VS+lPjNd0+FNRI4hN+O7DL
         UO/asRkynzo1V7pnRNsTgP/PPsNrz8IDfqp+KWfPArjsTAWgYqiUA6uYblN1DQvvogW5
         cRboVxJ2QPgXh3QBeXRxCGoS0ZtCLo5V0xKP0gEg3XQTV2sEHdfLl8Ma4moQ6XbXc6jq
         /kDVxhG0wQ52TVgxM/mJAhSpu+p0BQpULsdx5lO8nJUiLPLhII+n/ZDqi3oqEqKX01l5
         uzfg==
X-Gm-Message-State: AC+VfDySW3CimFloyIbZu6JiR2+dm17+8ZsBhhYhr1DqOLbWgK85qje4
        MCSpH1fOCukAdrklQPlEa6Xqow==
X-Google-Smtp-Source: ACHHUZ5Jw/e3Q3oIgdeZwGiSB3oKjSwO/pjQ8SVjBamplOMGoa89M2zcwYYWJZQS5Hcf+E8LSKosCA==
X-Received: by 2002:a7b:cb89:0:b0:3f4:2174:b29b with SMTP id m9-20020a7bcb89000000b003f42174b29bmr19495202wmi.2.1684146741618;
        Mon, 15 May 2023 03:32:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003f1738d0d13sm27867104wms.1.2023.05.15.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:32:19 -0700 (PDT)
Date:   Mon, 15 May 2023 13:32:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: fix potential Oops in
 at_xdmac_prep_interleaved()
Message-ID: <21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are two place if the at_xdmac_interleaved_queue_desc() fails which
could lead to a NULL dereference where "first" is NULL and we call
list_add_tail(&first->desc_node, ...).  In the first caller, the return
is not checked so add a check for that.  In the next caller, the return
is checked but if it fails on the first iteration through the loop then
it will lead to a NULL pointer dereference.

Fixes: 4e5385784e69 ("dmaengine: at_xdmac: handle numf > 1")
Fixes: 62b5cb757f1d ("dmaengine: at_xdmac: fix memory leak in interleaved mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/at_xdmac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7da6d9b6098e..c3b37168b21f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1102,6 +1102,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							NULL,
 							src_addr, dst_addr,
 							xt, xt->sgl);
+		if (!first)
+			return NULL;
 
 		/* Length of the block is (BLEN+1) microblocks. */
 		for (i = 0; i < xt->numf - 1; i++)
@@ -1132,8 +1134,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_tail_init(&first->descs_list,
-						      &atchan->free_descs_list);
+				if (first)
+					list_splice_tail_init(&first->descs_list,
+							      &atchan->free_descs_list);
 				return NULL;
 			}
 
-- 
2.39.2

