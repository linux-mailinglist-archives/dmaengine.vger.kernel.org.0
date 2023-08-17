Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988C780245
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356396AbjHQX7k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356374AbjHQX7M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD33A9F
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdc243d62bso2838435ad.3
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316747; x=1692921547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBig4ojju35UeR5nYJdcskzCIyszltPP8aM7eZxhMAc=;
        b=CX+q3KLcZFLRq0HGaHxCoLa5L4myxQlB3+uLkExLgTIU/M13dAR+tuImGaMRsXlnIX
         5EiwzNERqO941u1ZgpeILGDAjF+aAXTGTWftiTYrIx49flrdRuPcBwQo92heAoso26aV
         L2seXLXD2MlKm/ksaN6j4O9A14UF3zqIGgNCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316747; x=1692921547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBig4ojju35UeR5nYJdcskzCIyszltPP8aM7eZxhMAc=;
        b=Z6jE91fzvUYOajhFzbDtctfwan2qRDX45ygteBFdsAlX7DBuXBIS7PsvCVrje5OIv2
         v3j1hvN5sjBdlsLeoZCstlxzHpq7WDajQ2Tn2yC/jGwdgS5bV2/v4QBmyS39fTPOHPUT
         V2VGBjOu5Dsg6eUPFgSRRny6ItWOrpubLuChZ9i+mwSRU9smCkPnIaMmINc6nKwAvuXV
         aXuTWrMpUby1b/j33N5MCmTL7HTChfe1wwf8wNmJfrIgeaoybOG4eiUvaCa8VYINfM2c
         BZwgdgKAakGlOhB25ClZilx5kmAlKPRiBKoSC8roIqp5ywaQtdtrctAanSAE+GckyYwg
         eRkQ==
X-Gm-Message-State: AOJu0YxOOrJ3Ts0xnxFrxsgxQM7qbR2Ab30pQNixXeB7l2dhDO5fGUok
        XZvIHNdRudmTyyxYYUiC2pH5uw==
X-Google-Smtp-Source: AGHT+IFtTiKmPIDtGWpZKY6Src1ZWuKVRaDR2AR8ZYsjCDrDdceH4jjvLBuUX2egDZo9GWTtP8NFrw==
X-Received: by 2002:a17:902:dacd:b0:1b8:adea:76d0 with SMTP id q13-20020a170902dacd00b001b8adea76d0mr1012481plx.31.1692316747494;
        Thu, 17 Aug 2023 16:59:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001b9e9f191f2sm342824plg.15.2023.08.17.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, dmaengine@vger.kernel.org,
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
Subject: [PATCH 08/21] dmaengine: sa11x0: Annotate struct sa11x0_dma_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:45 -0700
Message-Id: <20230817235859.49846-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=keescook@chromium.org;
 h=from:subject; bh=xRJQQKdAwogb4vqWXbK3omVk8LQ2U1Kgbhap9AYkMvo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAxAkVjLsoroU7aJkr1WgWWzRBzbsR+tdxD
 lgeTVdiQveJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 JspMD/9uCbBEkWVx4Whm0SjF91ZUEjFm+uw5va5kJYSQaUggli1PUAzEbtIfkqE0tHxpXylvHV6
 MZAMbsTTMc4sB4m4xnYRc0EoTzuMdduuaXj7l/sncv7/LmFSoowcBNgOyqPORRYUM775TWDHeXO
 KeoIqOfRBA1pU2p6SABeK4PvYr9w3rZRX+aZiNFriijmZlDDlbGfeq8v9uQ2Im17NvWmo78uSnB
 OkH0/Si61oGt8YkSxwx3WwhmqB2o702deHwP3SlOa/ZeqfTijE2YZhDmMuKHYx7QeBfC/eMcUiR
 Z5Ir99EHJYfiOQtN+yLXwoR+0SaqDwlthzf36cY91M4+RIxRUpoV7xLXmq2q4GCAdnuZf61znzs
 M6Bidmh9xg6pqyHEGPynCNRRpn/UsrhseCWdJGYMQZLkXP2bP0VJzaHIlfivSURYMQVXc4KQwBd
 DRji9b/iiSnnLi3fSIhaQxYXT5+Ps4Au0oZl5ksmYDaMky5nRGOgwaH8K/PsnaL2g5HvZnClItG
 bdITH1ZZpfW22BCSxjF6WLtrNaQQQACl25/pjzcUllaIN1ntJsfEnFtqBBzeDv+cMihyO6Z99a5
 Kmn4lAvlEhqg16rC1j3EkD7ZrTt+gPUQteXqDvYw1UUclntbSMql5Tik8DK4sYfnwMmbaR4qWIx Q6tm80uQco8mfqw==
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

As found with Coccinelle[1], add __counted_by for struct sa11x0_dma_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/sa11x0-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index a29c13cae716..e5849622f198 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -78,7 +78,7 @@ struct sa11x0_dma_desc {
 	bool			cyclic;
 
 	unsigned		sglen;
-	struct sa11x0_dma_sg	sg[];
+	struct sa11x0_dma_sg	sg[] __counted_by(sglen);
 };
 
 struct sa11x0_dma_phy;
@@ -558,6 +558,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
 		return NULL;
 	}
+	txd->sglen = j;
 
 	j = 0;
 	for_each_sg(sg, sgent, sglen, i) {
@@ -593,7 +594,6 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 
 	txd->ddar = c->ddar;
 	txd->size = size;
-	txd->sglen = j;
 
 	dev_dbg(chan->device->dev, "vchan %p: txd %p: size %zu nr %u\n",
 		&c->vc, &txd->vd, txd->size, txd->sglen);
@@ -628,6 +628,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_dma_cyclic(
 		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
 		return NULL;
 	}
+	txd->sglen = sglen;
 
 	for (i = k = 0; i < size / period; i++) {
 		size_t tlen, len = period;
@@ -653,7 +654,6 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_dma_cyclic(
 
 	txd->ddar = c->ddar;
 	txd->size = size;
-	txd->sglen = sglen;
 	txd->cyclic = 1;
 	txd->period = sgperiod;
 
-- 
2.34.1

