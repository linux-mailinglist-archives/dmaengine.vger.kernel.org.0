Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311ED78023B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbjHQX7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356390AbjHQX7P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:15 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309683AB2
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7ca8720a0so230016b6e.2
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316749; x=1692921549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFfpOm3BUPwNUFmD6NhnAMbQ/2S0ir/QqXgwBqevnLk=;
        b=EqYcViRLy+hIr+dGw8oMOHY5NdZUL3VGgCCB1DCYkyJCtv9U0YnPuWHnP6ypMyMFrr
         Vk0YDZNsPMj8eHr69pt/3dPEPWWe0DnNmDTipbpAdcFo51ZUD3H+79JZFkylV+sVqmZL
         fM7pL/eKGfT2nw6+cn3duAt/BNduGqjmY/D3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316749; x=1692921549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFfpOm3BUPwNUFmD6NhnAMbQ/2S0ir/QqXgwBqevnLk=;
        b=CjuDB1gdXsoFukJRwoRnq5hJJqDCmXBBx+E2341oqWqTB8npD0WB2UbyTr9KWVQu93
         7PxU9Fr2txOe49qpewOjyTZxxv2lAAkNrVcab1r7umZ/JtPTvSfvO9eCK+GdyKHYu3We
         nvQjZshtgZvRa3oFfAbW7IvulypKZDb3imOR8741gAvab/Y1oCsg2jMkwFgB6+8D670T
         VeXiQDpK3/K9Dbdil7cN0kZXA8s1UtCSoKd6FMV/NStfE4Ih+UrV20sH5h8MMlpYdaOI
         f4xsBf2zQOsRgi0C8hgKfPGBsArwddQ1ITyfwMhh7op2Duxvfmx5cF2yTLSTH8VFtxM/
         J6Cw==
X-Gm-Message-State: AOJu0YzJ/69MaWzYzOPlw0PXtwfWzoZqkeDXtUcN6lUGDVBcaQJ/7wbw
        SBI5mng5aWDhtdS8/9C3Pbh5Jg==
X-Google-Smtp-Source: AGHT+IHtstSGrCASuEyhbAzUFkHex296TETFK9xFy7uimzuBnpJ+27CsVn7a16vwqiJacwvtpQrDaw==
X-Received: by 2002:a54:4098:0:b0:3a7:7bd3:7a7d with SMTP id i24-20020a544098000000b003a77bd37a7dmr1133716oii.23.1692316749254;
        Thu, 17 Aug 2023 16:59:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a6543c7000000b005658d3a46d7sm195752pgp.84.2023.08.17.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
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
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 12/21] dmaengine: stm32-dma: Annotate struct stm32_dma_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:49 -0700
Message-Id: <20230817235859.49846-12-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=keescook@chromium.org;
 h=from:subject; bh=4L1vW+SexsLQ4jAjdxhKOyEQSjWuUKIs12iHtuVmifc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAY4GtRmAVHf6Ya9dY+gshf8QSkUD7pnmTh
 rHHqQiA5g2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 JkvpEACe4GyFK86EwP8rAzGWpbQmF4TLiOHpR/Sq37SBWAGhApzKHiufbeypSkbGVsc9zm8k6ox
 HqRPculRTXgBz6x5KLRagVnv6DvDL7Iz/CpcJo2cWK4ar0q8QnmYHWS6srfDmg7X2FS+zXcbV9b
 NgSTHPpW+Nm4j438UvFT7/zD5q5vDmD6KhRNDdvoJHlRVEuZHZTntNyzawnhyTbnhLQtndJ8D9B
 2XWAvz31M9/B7kXy3mdeWDAHS93cup09V731uJhDp2vl18OV2uu4ADKpwql478KUkL1/YQCXlqu
 MkwLExvrtT9pHo/FT6Kc4jg20iN0lHgOECgTK+knaJzWdKkTP30N0xQY+/BLEURfiZ3zccqfGJ3
 UQZSWxAWNhoDuwTvXMKczoJuCdQXuiM3LXEAkmQ7On812q7pqXHbwB4kiy6pWOMgbjmdeb+R//J
 xfTexss8BN1pf/RxPxWh7Chb4ZJ8NdVrkZBCHYaIRyq5auYyZthjKwR79bj1hXOk7XzTHzpxnx1
 rGYLSr63iThlFrUS+YwRldwE0xr7Kr7jgLVJkxC1tWSMA6e6tTOT1sOgg1SW0m13ukSAD3EK1FP
 faU8ba7KBOiO+J/s1i9j8OuxVMhUyNOYgZ8J667chD62Kn6PLWJan8xTbP4Dp3W/LZotOBsL30w oFDolQxdjzT8sBQ==
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

As found with Coccinelle[1], add __counted_by for struct stm32_dma_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/stm32-dma.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5c36811aa134..a732b3807b11 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -191,7 +191,7 @@ struct stm32_dma_desc {
 	struct virt_dma_desc vdesc;
 	bool cyclic;
 	u32 num_sgs;
-	struct stm32_dma_sg_req sg_req[];
+	struct stm32_dma_sg_req sg_req[] __counted_by(num_sgs);
 };
 
 /**
@@ -1105,6 +1105,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 	desc = kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
+	desc->num_sgs = sg_len;
 
 	/* Set peripheral flow controller */
 	if (chan->dma_sconfig.device_fc)
@@ -1141,8 +1142,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 			desc->sg_req[i].chan_reg.dma_sm1ar += sg_dma_len(sg);
 		desc->sg_req[i].chan_reg.dma_sndtr = nb_data_items;
 	}
-
-	desc->num_sgs = sg_len;
 	desc->cyclic = false;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
@@ -1216,6 +1215,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	desc = kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
+	desc->num_sgs = num_periods;
 
 	for (i = 0; i < num_periods; i++) {
 		desc->sg_req[i].len = period_len;
@@ -1232,8 +1232,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		if (!chan->trig_mdma)
 			buf_addr += period_len;
 	}
-
-	desc->num_sgs = num_periods;
 	desc->cyclic = true;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
@@ -1254,6 +1252,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	desc = kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
+	desc->num_sgs = num_sgs;
 
 	threshold = chan->threshold;
 
@@ -1283,8 +1282,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 		desc->sg_req[i].chan_reg.dma_sndtr = xfer_count;
 		desc->sg_req[i].len = xfer_count;
 	}
-
-	desc->num_sgs = num_sgs;
 	desc->cyclic = false;
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
-- 
2.34.1

