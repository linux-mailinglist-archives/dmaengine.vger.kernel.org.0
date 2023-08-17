Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27940780216
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356313AbjHQX7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356366AbjHQX7L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9962710
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565e387000fso311504a12.2
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316746; x=1692921546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5fo4SAlFZblqGlj3AOCCnMbC1x74PqOTDSdnlOgmQc=;
        b=Bm5yXs/7C7SrMAj5NYLLnKAg8in4eJxveBbF4DO2ZjTd3wvxKBVyaWbMsbIdgjBk1G
         Hi55+qF7vYuSjUdxaCq3KNt8Tr5loAJ4JV9fNliA5JjgX4O8ToCJfH5hMhlyoJP+XXFu
         Vjs5RDTopNiXlWJl6j/wjh/5LopbcqoukMzus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316746; x=1692921546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5fo4SAlFZblqGlj3AOCCnMbC1x74PqOTDSdnlOgmQc=;
        b=NWeNSXAVDMvxsWfVMIa1cH/xucwtgZCD1lok+MIYCsA/t3fxWAcd26btEyIeU9C2dv
         CBwIN7t0bFsEtyCGAtNOODC9X9r1wlYceiyfaiRdXvwOIDiFapo/yqXHTL4vm5n0ngQH
         D/5r3zjpbYvafz59ifAgS0QWNU5caQZQFLJc4dePW19Hi4HOta0u8sKd9KqNAahQLMlF
         zrbZsZSvg2xiw5oqsWjQBV3dvyGYUwn1EcQ5YyrRwAXDbCvkip15QO7kRiptllca0T6d
         LD1yRWqwncNUyhKdDiWYZnjOC+2Ng33RFt5hd+oSHkaFPs6Lh97ww2VEd62DIomQh7XC
         2/4w==
X-Gm-Message-State: AOJu0Yz18fUi7j6CrBlowrTy1XDaxmZikhlqSI+k8ceQBoDUksJX3ivf
        sWHUei9cJQDIn/WwWNMzxz5bwg==
X-Google-Smtp-Source: AGHT+IEdMYKnrjBUAvE0ru71ZoYllBiARB+b9n/0lQdAuapi28gfRsr/R7sjhWjkmiBp/Woqb8QO3A==
X-Received: by 2002:a05:6a21:78a5:b0:131:a21:9f96 with SMTP id bf37-20020a056a2178a500b001310a219f96mr1649983pzc.6.1692316746157;
        Thu, 17 Aug 2023 16:59:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a62ed10000000b00682669dc19bsm296091pfh.201.2023.08.17.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
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
Subject: [PATCH 05/21] dmaengine: hisilicon: Annotate struct hisi_dma_dev with __counted_by
Date:   Thu, 17 Aug 2023 16:58:42 -0700
Message-Id: <20230817235859.49846-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=keescook@chromium.org; h=from:subject; bh=wAhaXdpkO4UhROqbBEzwnUztv43Z9vPtGenl3m44PI8=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAdafn2BXNub2CVczBzS1nMrcCu/W1l7fmc oQMCeB3hAmJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A JiDKD/jzQjtA/rejP0UfKxnwSb1Bs9ETBWk/rP2eCU65spDyZslCdJJKzJuu7MicgCSEPDfNPg6 xaxgsDv0fnzJthUj1b7GYgIJW4Ev/EFiMgpDPhlkjPeabqKRWZZxyEgFvhJU73k5H4w9d+hkXBe +dTfjZFVsH0hEK2sD9pdYpWoDrGsGfvB969UPwgcSelEYZSrHRb0kyaQWL5oOnurAP5e3KthrFp ll8wy38odnrUKDahwF8NPUamJcVbFBudhg16PZL3IhE3NtZV9tjMQtrMiwy7G2uhHqhd1w6bQXk lXZWrzzAqgpnUayVPMrVptkfVuD0dViVQEwjPjma3woC/B8FZa7ymi5O/geVC/ugDZlVZcu/4XR WddDqRioBq6b2M2HnQDKsyArKe8jj6Lq/WFaQM+xHiUptWNl3rqG2dRzd+ksTdn+fmfPnzhhxr9 cLZFoy8XzDMZ4yU0IBzoZBY0pSrIKPxJjMwsjtTkwmM+fflGR86LOt+ClFW7/FgWk9ZARIt88bj hZgS8SwCeRYEviYdtimOfiDhjAZXaDRYEMzpVonw/x42ays3FO9x405hS5QD/Lfd9z4TB9WJPg/ JBOX/lvE+vJHEnJJFJbpLdY+bOR+uhcTApAmU/ggJr4cRtC8l64Hw5lDostncXilc6oEPpzpmNL OQDT2dm/jOCGN
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct hisi_dma_dev.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Jie Hai <haijie1@huawei.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/hisi_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index c1350a36fddd..4c47bff81064 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -163,7 +163,7 @@ struct hisi_dma_dev {
 	u32 chan_depth;
 	enum hisi_dma_reg_layout reg_layout;
 	void __iomem *queue_base; /* queue region start of register */
-	struct hisi_dma_chan chan[];
+	struct hisi_dma_chan chan[] __counted_by(chan_num);
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.34.1

