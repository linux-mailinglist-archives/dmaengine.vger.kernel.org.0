Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AD78023C
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356390AbjHQX7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356327AbjHQX7E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B23A8D
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26b67b38b61so288787a91.0
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316742; x=1692921542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IIJznhYZqet29caE60ZbA2pqDUDYoC2Ni193sUkBvY=;
        b=lfMuDWZkxFbnsbKKPqOUzD1QUbR6DkcVXQOk5J3buEXsWhNksf1iNd/44SHWaESHDl
         j+hryvuSMYcAsCnshdpn8g7l690Dju9CViGdao/7iFYQDsHrXDRk3T+86i+QcOSUH9RM
         5AHRTVcWEztYIcVzyPlCMdNzqMi555hFHkeoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316742; x=1692921542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IIJznhYZqet29caE60ZbA2pqDUDYoC2Ni193sUkBvY=;
        b=JjawM1+k+9yBoULNcEkn7aQiR4CTMdyZj5642904gLn2y87kJq4rqd6RMKDT3NYo9w
         OMyXtIHg9ngO+aHt8KXSgZcjppdzMOBwnSCT633j2iota4qgDbZyzV0wAz7nkrbrm3YA
         fFPWzjd3oP4j10utswC1Tuk6ObWuHeNhq4CIX7ve8vprWjCLe30tXIJUS2MxkXJt3HNh
         xiP6WdA0+OmjkaX7NQ6ybKtyfZ0dfJ6a0ldfRz4YRaNJH4pjfkpFfYERTHcgQ2AT3CCJ
         O367xNKNcmw5nOUTx5dh9sWks96XBZ5ZuxU5JhsUd1jyUCqv8tHYfK2dV59maluvhbBZ
         4eUw==
X-Gm-Message-State: AOJu0YwkV+tdXvzugU+qCBVocuQNs1cUmbrZ9L+I8avBySeZo8mAceU2
        gB0TWrvT1uIteFyQh8ZtMUE3Ig==
X-Google-Smtp-Source: AGHT+IE65dJQjfZK41wRT3vTQIMQrQ1msHGo0xfJJM2cHVIfGc5VRcslgbukfOm/ii0qD36iiH5rJg==
X-Received: by 2002:a17:90a:ff05:b0:26d:ae3:f6a7 with SMTP id ce5-20020a17090aff0500b0026d0ae3f6a7mr935986pjb.21.1692316742244;
        Thu, 17 Aug 2023 16:59:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bt11-20020a17090af00b00b002680ef05c40sm334830pjb.55.2023.08.17.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 03/21] dmaengine: axi-dmac: Annotate struct axi_dmac_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:40 -0700
Message-Id: <20230817235859.49846-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=keescook@chromium.org;
 h=from:subject; bh=5nTriTvU6hERX/iI4Nl8dL1Ec/4B+oHOGqi2OU9g6Qg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rQ/kvuY7+Gn5tKJWg/r4cXZIgImGLVHbUCZB
 DFLPZ2NhGWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60PwAKCRCJcvTf3G3A
 JhvpD/wNYxu2CIOowdUv5/Gwd94bn/HKEspBIm29MnOZtnaUtavl0IWVwMhW1P/8HQl9woaPfLG
 6Aq1zIhFa0dMdc/NApNTy4232MZ5m0W2yU1vsE4DoahHlSo99Wb5IXEpmYQoW3Ogcru8iTI6RWE
 X+O5eTwn/TrdoEplK1g6rsrSovVWaEWuKQPOdUcN0zVf0YFUcRqB5ErOnPXhT+eeEQosMKckapy
 xAlbAopfCGNa55AO8pK6DeF9558RwA8t+1v8gtPAtBrx0xl98gWhKtK4YNcorE0C/IQnmvzBmtM
 E5wFOLjYn9E36ScSEdLRXdOLC0TOh1hT2mgx4IlClvnnj6ejHDSwQKih3mT+CnD0ir9WDUWyX9C
 bGjxWt4DBLFpP42ZKN1lFVD3p1UsDwQf1sVM/JJZZWUREKtwdy/Jm8jzHw9j/hLep56o7cJQuzK
 COT8j10NMt/uMFOu3Th8H23KqtaUnz7XDdZv2DXz4gkrLBWqttX9OJsyxN0brY84f6Lmu+2P50E
 la+wH9n2H1f6jFY8wmjqrrLqTCvhPaXHM7/yl9TlA3zM2OgrLbARzLsJcM3sEBnJTMszTBziErj
 Bn7kZG3N8z1rIg4yzutknyAVMFixUdrTgZ968m671TSetEtKj/KknSzomKzfesrG9oL7QZZRtXi zZtgQ/94fa+v75Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct axi_dmac_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/dma-axi-dmac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index fc7cdad37161..b9f85cb20d3e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -117,7 +117,7 @@ struct axi_dmac_desc {
 	unsigned int num_submitted;
 	unsigned int num_completed;
 	unsigned int num_sgs;
-	struct axi_dmac_sg sg[];
+	struct axi_dmac_sg sg[] __counted_by(num_sgs);
 };
 
 struct axi_dmac_chan {
@@ -484,12 +484,11 @@ static struct axi_dmac_desc *axi_dmac_alloc_desc(unsigned int num_sgs)
 	desc = kzalloc(struct_size(desc, sg, num_sgs), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
+	desc->num_sgs = num_sgs;
 
 	for (i = 0; i < num_sgs; i++)
 		desc->sg[i].id = AXI_DMAC_SG_UNUSED;
 
-	desc->num_sgs = num_sgs;
-
 	return desc;
 }
 
-- 
2.34.1

