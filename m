Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A980D78022A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356408AbjHQX7g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356377AbjHQX7N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988DE3A94
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1052832b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316748; x=1692921548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0kK2+3d+yiGwIKod7tAy7TFaHWZ7E5+177fueAct/8=;
        b=hsCjUwllgjqgnFtDBr302edLntwmqFMb2tjxSM0F2KLywUR1T2qWiokFqCgsixWScn
         vr+ifD5w6Aj4JONDrH0M5DZoCakUeGfmHHiWsWaup/P9GeC1F9prcku9j8zWYsPcEqe0
         0BL4rkzR3ZXfDE82c9HgH/7iPg1ZBtp/rPUaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316748; x=1692921548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0kK2+3d+yiGwIKod7tAy7TFaHWZ7E5+177fueAct/8=;
        b=ce8spYxL55qEK4Xa3echZcg1KbqVtq/dhGQDynH1IWTVIcjYdsL6fpT0OLdHLu/EIV
         sJA+YKsZnDAJOxx4wqbC1ZSEzJHrbaD7Pv0SkSYFbd1yiAwQdRwofPZFoE1fnphxVOya
         eReAhbyCq+LRhaduX15/jrdERuZ7aaz2GkZL39yv3KWeQZW+973VrZigbkbxCljyT3XK
         uOOWgFm0ccte8SSknbT/K3yw41k6kcuOdFfuQvkdzC3Vb/GGMqwLtm/IM2Bbi7xpUK6a
         HsO2+W+DsxAWYO6bV3M8bygyqokioEuW2k7MjL+Vr2M71LHgXKTtMjQnBu/nLLqjz9WE
         IdzQ==
X-Gm-Message-State: AOJu0YwajvP/K4Vmu3imZiV9vUozfpjs2oXDh4naoB6hr/eTEt8GgPpc
        VQ9VVPYWzd14e6dfNYwfVoA6Tw==
X-Google-Smtp-Source: AGHT+IH/IPZEu2hD4vXoHg+QeGyl/JNpbC5Ce8fholtE5OspKAUfjQ5VF5f7w3cDph9sQgTbEz2k+w==
X-Received: by 2002:a05:6a00:138c:b0:688:79c6:1c13 with SMTP id t12-20020a056a00138c00b0068879c61c13mr1187966pfg.9.1692316747963;
        Thu, 17 Aug 2023 16:59:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78701000000b0068895d26b79sm330575pfo.10.2023.08.17.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Green Wan <green.wan@sifive.com>,
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
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 07/21] dmaengine: qcom: bam_dma: Annotate struct bam_async_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:44 -0700
Message-Id: <20230817235859.49846-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=keescook@chromium.org;
 h=from:subject; bh=EQ7cpalnAKUyzLqTacn9WNqARa63ulJkEyu4D2Ryyyc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAitRrc5HSuDDp9nSRHlzoamdndhZaOduWN
 UM/7/lcEfqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 JqFGEACsptEBgA3lauCtB5TOKqtQKh3P+mbX/mtGO8a9W0CiYk5jSkW8FeW+uEEu9jqPlOe2zp6
 VSn60+wScZZEY+K3j1v/qMyWWXD45XjY50dVtFHtTJRPTWyVPBQ26JpXBlcUIxJWVXE+qEqu8xs
 nM9fAd0Q4raL9j6gTyl4Q/H57pFGmekGp6X011FxYjG06ztC8X1kYIpW+n5spozri+LKhexD5l+
 7n6syLTt5CG3eI4MTbgFf8b9KsEIvIWoY1Xf5nTs2KenjD0o0oNK4KkAX788uTSFtpS3uXYjuXU
 cUTm2k9PIAJsA1uPnVdTPyJwq3oFeBvteGhQS+eNCYOjz7Q8uncrDTyrjgfhAx5cgVXDD9iXEPW
 14ufmJkFuOH7MBsTRhtKaPqnoDu8zW+Cxh7oaKTqN3nGiXHq9Dx0kckpHyQNC+Tr/NsEfp+KGA7
 iZgUEQZJRnMlRXZUj7gHdrvhU2nXB4JCmDY2wDoJBkNJzMCKFpGtaCDFxsaS9VOyd8o6SdV+ek4
 gQxjEcG6VcYNhBec8cPzkPHJRX52CUyMWCs9+V/DOtst7ojlX1ZxoNbO+fFYC9vpV3qMFhsDshK
 xwSv51OKzq3KOFZdMPD0yf7xcDItQXPgtLzfS2NeB6hSlD07ZusYdvsF/hh2k9j9TYtPAgKyHl+ /onf0nURDF25ejQ==
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

As found with Coccinelle[1], add __counted_by for struct bam_async_desc.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/qcom/bam_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 4c3eb972039d..65b89bb7a56b 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -74,7 +74,7 @@ struct bam_async_desc {
 	struct list_head desc_node;
 	enum dma_transfer_direction dir;
 	size_t length;
-	struct bam_desc_hw desc[];
+	struct bam_desc_hw desc[] __counted_by(num_desc);
 };
 
 enum bam_reg {
-- 
2.34.1

