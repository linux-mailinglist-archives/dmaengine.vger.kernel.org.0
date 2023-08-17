Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE5780271
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356510AbjHRAJN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356655AbjHRAJJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 20:09:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6A3C18
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68876bbecb6so310361b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692317316; x=1692922116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw3mq684+whK6uKOynb1W+N9Akg0MMK/g1IkFySIc8I=;
        b=U1Ql9EGHlOBTPrW5bL2Ok4+erX+CbKhnNGfZphwdeK5/sSer+Dv9zaDdyL99t5kQSD
         oVVYPsE4KZXAOvConcm32MRJdr18Bx9PwBisXAgii1AKUSf7mEWmJ+3ZGyjcMvcSMRK+
         uuJgcdJJkESYr89h3AGNPJ1b01jI5wOOP77Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317316; x=1692922116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw3mq684+whK6uKOynb1W+N9Akg0MMK/g1IkFySIc8I=;
        b=aGN/W8jOjV0ndq2GmiicR+sciKvsbT3JLBdcPT/TjjVNoO204rFEaR+FmfVVnR9qjC
         9YEhQhsPVZNO68rc21AeRg8pY8qCWE9p/bxdQ9mYdGisPJRoJuzb6H8JQBqlQsDdm2UD
         J5Oixb/KxmLwE8swNK6G1rokNE95jIHPryOfuz9cCECjLBmu0bcyZkoMEp4OgPfa0FKn
         uZRuneVCWJeNVmX6PZ8r7Qwi3i5VXoDB7CoQhMN0Wi3hyPf7RnZp7v/Qb97d+6fxCPE6
         LYW+3ePh4wircDxRM2h6Z+621YF7vObF2emu6HpDqSLT96AD37w+NHhsu1C9kowbmVN1
         F11w==
X-Gm-Message-State: AOJu0YyGF1D88vWDZK8kUAyDnwCrCN7UKJ4QT9yvtogjtRRhX1fZ6cEe
        VVy4VQKBgIAiOFolk1B180uxdg==
X-Google-Smtp-Source: AGHT+IHs/L0G5amaCA6JJvfdUyFtovSh7NJ6wrF/mSJ+6v8gdiNumAUBZr2Hy1k5HkwEvQ967UeD3A==
X-Received: by 2002:a05:6a20:918e:b0:133:dc0a:37e7 with SMTP id v14-20020a056a20918e00b00133dc0a37e7mr1594302pzd.13.1692317316564;
        Thu, 17 Aug 2023 17:08:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b00668652b020bsm310893pff.105.2023.08.17.17.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 17:08:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 19/21] dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:56 -0700
Message-Id: <20230817235859.49846-19-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=keescook@chromium.org;
 h=from:subject; bh=AE+OvfT0s300zRyT6pnn5fqCwqKs6HIWCRot0z9HVXA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRB/ew2pKHEDjNWiMjUEkVHoBeF+LXb+IA+s
 sw25qoUIoeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 JqUtD/91YehcWz89AmH98AF0WrOTo+7zKXTqrpyb8J4sUjzplNMCBnoCco1YnWhZK6JWGDLN1EE
 pV+KRXiq9MncbKUBvGywN0tgGReJzs+A5h2m2GRO9nKR2ekBhcqpEQ5He2meGS3a9rvGILgHXtv
 TRYaXqPj4AWrssGgI7BtTL6qU/foPm/Qc8lR7OrARzU1ZsNTpa6T90H9kO40R+g6FkQfGYeQwVx
 iUXUXgrAuOHBYj2R6+HBLGwt9rRQkDf8uhaV5XRcCY0c0fT7TrZaVc/NYJMrK2zFDA/42t1Adh3
 VXMCVg3fxnbq3zcIZApWW4N7yXaE0IGZjHRGvE7LFr67gAnEU3VIPIiIgb1PCKLNvAXi2getgwe
 eDPKhEakbXWktO609WuTG/lkuyyawB5TzDSpQqUb7bHH0auPSjlUXfNteZmtzmsH1YTzdioqyk4
 OuW8nu7Rnyi4cxff+p3euk4CHAEz8lSgQKaXIXc1PrWyQF6+8BEYniE2/RLVCQSAX9GlPiqE23j
 N6OoJ07N3r8RehkixcRLo6N32zj+7s0dEgD/p7PcyrwkN1PyFd8nUS96suh/GD3XeIYaZlBjV6v
 I0TNfQooRO6OKoBKJkKR96wShMcB+sIyWtQ+o8PW350Bjb1yxVtRpHxGGsYiqubsKmCGtKx8KH/ +wD9cAC0PmcL+uw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct uniphier_xdmac_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/uniphier-xdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index 290836b7e1be..dd51522879a7 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -80,7 +80,7 @@ struct uniphier_xdmac_desc {
 	unsigned int nr_node;
 	unsigned int cur_node;
 	enum dma_transfer_direction dir;
-	struct uniphier_xdmac_desc_node nodes[];
+	struct uniphier_xdmac_desc_node nodes[] __counted_by(nr_node);
 };
 
 struct uniphier_xdmac_chan {
@@ -295,6 +295,7 @@ uniphier_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	xd = kzalloc(struct_size(xd, nodes, nr), GFP_NOWAIT);
 	if (!xd)
 		return NULL;
+	xd->nr_node = nr;
 
 	for (i = 0; i < nr; i++) {
 		burst_size = min_t(size_t, len, XDMAC_MAX_WORD_SIZE);
@@ -309,7 +310,6 @@ uniphier_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	}
 
 	xd->dir = DMA_MEM_TO_MEM;
-	xd->nr_node = nr;
 	xd->cur_node = 0;
 
 	return vchan_tx_prep(vc, &xd->vd, flags);
@@ -351,6 +351,7 @@ uniphier_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	xd = kzalloc(struct_size(xd, nodes, sg_len), GFP_NOWAIT);
 	if (!xd)
 		return NULL;
+	xd->nr_node = sg_len;
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		xd->nodes[i].src = (direction == DMA_DEV_TO_MEM)
@@ -385,7 +386,6 @@ uniphier_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	xd->dir = direction;
-	xd->nr_node = sg_len;
 	xd->cur_node = 0;
 
 	return vchan_tx_prep(vc, &xd->vd, flags);
-- 
2.34.1

