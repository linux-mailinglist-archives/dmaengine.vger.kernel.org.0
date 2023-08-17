Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3ED780277
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356530AbjHRAJN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356658AbjHRAJK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 20:09:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969F3C17
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bca66e6c44so383045a34.0
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692317317; x=1692922117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJAStmqEWJCV11M3alF7g0EvIWbhKJ8cHn0i1bzIQ+w=;
        b=G9dQNpeCDU6vSJDa21UY/Mw8p61U6Pa3T/VNTD0N6eKEN/xkSyFSPxwZJMlrumbxF2
         yxFdU1Mqtc9PVDPeUdJTTI/byEwzyL9clggs4DITweNemWAvyD4OqipRB0RiiEHV+Yrn
         46u3CyfTS3MTL8L9LrHEhkvbP1CddmUGW3Su4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317317; x=1692922117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJAStmqEWJCV11M3alF7g0EvIWbhKJ8cHn0i1bzIQ+w=;
        b=WKzeftr/gt4sF+HE9D6M6nIfBqdh9L4CFdN2g5w2JaUU26FHuShiTWsyg883+p1W5n
         Elyte8TZrLGtW+9vr3Fkxul9f+gyZXeHvV9tPpd4NuX80t9RVdKvhv4ReFPTIIuMsIE7
         vVr6BY9Mh7642rYhpLnnk6hUdE1e0doJx5PtQxOf33LcVFm2JteF/+GmcS7a3O48osYR
         +BxkY2lKU7vyjGlWRo96PING0Pf760QHtTuiDFqG3P+q7mGi6vXnI6C1O2Yi62s3h1Vx
         7Zbl5m9IsUMvo6hZ1gABJOSaZVhhu8QrtldVGiYbefyWkD0xC+VbwaeLEVep1Xx93uke
         Yiog==
X-Gm-Message-State: AOJu0YwHxICK9ioH5b4U6qKCb8KgTNp++Y20IMFrfogxqEn+cMY30Ru+
        Yqy7vskPnszhEsSSxat2ZMAnpg==
X-Google-Smtp-Source: AGHT+IFkVSQqkmXL975Xr4Tk7VbbfLZbWMUu/vztJf9RRnyAzWDuQtXtUyT8v9C9jYYePa2KPNQ1rw==
X-Received: by 2002:a05:6870:9127:b0:1bc:d479:ed70 with SMTP id o39-20020a056870912700b001bcd479ed70mr1130390oae.25.1692317317112;
        Thu, 17 Aug 2023 17:08:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a17090a670a00b0025c1cfdb93esm349211pjj.13.2023.08.17.17.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 17:08:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
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
Subject: [PATCH 18/21] dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:55 -0700
Message-Id: <20230817235859.49846-18-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=keescook@chromium.org;
 h=from:subject; bh=KkqTKiy8rqvFYl8aW58GCbimShLAkaRsCHzcvcCWSRw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRBNQrQGSxUXSXTSL+LF23xeHTG1HiHDx+NZ
 DxNL9D2ClaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 JstED/45VAohOEERN7C2lIV4zZVuC4OumCYP+mNrRtNtNzgTirqKjGCFbY5TkcbFBX9k7DrLDgS
 O13YhKpbYpdvbWnGSeyb3uF+VGAi5gnoUyIqwH/qwyDHFXcWuO48mXo+cu/8YLZeJxa5E+W/SNR
 Dg83cQ0lXZmMqd8yYOc4SRNUpXBQGklpsswWwAaTe5TXdvq0b4jFPboIw88TEncJSXUKgmOajZC
 Bw259+NR+DyoqUms3n4xhOKHZYZcE/pVrnWV0dydmbg9C0arCn5GLThkZD05+PV5iKgN1AJmxTc
 hCzGYVh8UU74S3XB0OAIRRum0P/QVS65aFVd5ncstN3ivfSpgvS3F5wZh3bfEBY7rlt+meDWGNO
 kHm+TZ6D/Tru1vy3ISGD5DeUovqDen5gLBUN20wYUyEKCSWKzd5LzRAu1W3uoHXFz6HpdEaa3jn
 LIxAZTHuCeJ+sKoxAbf5nBMCfqUXZ/KB7jP7yzf/c2SB3hVND2jeQLo3WiaoMLsvBRHb2/D36dp
 h3JI9oFzJ0Oqo+tpdhBFiAGpUPqnLYk7MVqaIGrgT8DlN7QB/i/hzHQFmk85WOkneZu/WYLZL3w
 iLBlUGubkbGblD5s2sp0LMWS0T/r9yUD8u8ndim38nSwUlyLw9CObnOXtj+udrDiMzpNOcZW/OL v3VOa7tcLzm25MQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct omap_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/ti/omap-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index cf96cf915c0c..11ac3fc0a52a 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -124,7 +124,7 @@ struct omap_desc {
 	uint32_t csdp;		/* CSDP value */
 
 	unsigned sglen;
-	struct omap_sg sg[];
+	struct omap_sg sg[] __counted_by(sglen);
 };
 
 enum {
@@ -1005,6 +1005,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d = kzalloc(struct_size(d, sg, sglen), GFP_ATOMIC);
 	if (!d)
 		return NULL;
+	d->sglen = sglen;
 
 	d->dir = dir;
 	d->dev_addr = dev_addr;
@@ -1120,8 +1121,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		}
 	}
 
-	d->sglen = sglen;
-
 	/* Release the dma_pool entries if one allocation failed */
 	if (ll_failed) {
 		for (i = 0; i < d->sglen; i++) {
-- 
2.34.1

