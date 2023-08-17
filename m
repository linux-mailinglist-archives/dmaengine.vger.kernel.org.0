Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C078027D
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356544AbjHRAJp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 20:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356597AbjHRAJT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 20:09:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27FE74
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b0b92e190so263648a91.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692317320; x=1692922120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT5yfa4Cz4QzC/iMXODWK/jT5XcC4ni8TfIgPVQR0nQ=;
        b=itkn5j7gTMv3uvk6CK5XGtZxLhTAsu/BRNKLIHV5Nnpsn0DQcWV/bu/9ci4nn5kqu6
         x/vVLpnevUmcAXCDiwYw6eVp3accunlMdofKtMwNRcr5uMKlvpjrUYi85scz/+E8dzk/
         cjD/8aiEiGvBn0IkoDGWMOkYZKB31rr4FdBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317320; x=1692922120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT5yfa4Cz4QzC/iMXODWK/jT5XcC4ni8TfIgPVQR0nQ=;
        b=kQNzlEcULfMpjbUSX+HfaM+G4ihLwPaR8/++1mpe3FaIhbkjMmF1T7hLbgvJv+p4aw
         PYCsP9M3xQ825Ynl8RO5fT2ZLgwpTi/o4Cd2vyqzmVeCIApXjxX+1b+hkoWjsFyMZJHO
         CikPM92AsgQIUdNyug3hToAESeJuqdDyB3at8/0CXk1DP9ZrHJMa1dFGfc8KQkNLZYye
         U/7iPO/g1LD/WXlXPXemR8VfPLdh39APN4+y1fraS2Tgr1JpR7bx5HFhqUxbQzCvr92P
         WZFSKRdKCsx1DrZqHQwePZ+NnVnTI7nC7aEv5iAmpMqb5ynueHu6IwxfAtOCJcjzC7+i
         dmYA==
X-Gm-Message-State: AOJu0YzYp+pG9pS/zbB0rfb7IzWS/3BhIcNC7hQOCikmnfClF3oDJwSF
        qmHY3TEGAUKhuSceobnbFGKjAg==
X-Google-Smtp-Source: AGHT+IFAdwycmNkiJIGGqs23SxKqdoqgeSyw3+9sSzFc7X4kCoBM12cHThav0cZ1Ffgr5OQWXAzJ6A==
X-Received: by 2002:a17:90b:3908:b0:268:2f6:61c4 with SMTP id ob8-20020a17090b390800b0026802f661c4mr1106012pjb.12.1692317319812;
        Thu, 17 Aug 2023 17:08:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a031b00b00264040322desm384590pje.40.2023.08.17.17.08.35
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
Subject: [PATCH 20/21] dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_device with __counted_by
Date:   Thu, 17 Aug 2023 16:58:57 -0700
Message-Id: <20230817235859.49846-20-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=keescook@chromium.org;
 h=from:subject; bh=TzxuhTylPZttiSXw3eB5K0of3I8ZRlEWmKuAA7ewWgw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRBNlqs1jMDul+rCbPRl5IanBSTAmRt18Urs
 VUPCwAZkBGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 Jj/vEACgKhQ04Z609itYquBNxujyMweJdRbIgh30/21Mgn5/8pqXvn9PamYB94xNq7EuxfsrHgg
 BfrY9XZwI0BbPWqpzOwd13V3w8MNSmWPPxjxbDK18H4lSSrMfdbwG+ZXbR/Mrkm6r+ewkhk5tCX
 LNckCGMOXw5pYdEPiOHxHBPyHRK2OUPaA/D/CswQOYpMtc70xMaDBKK1YwJ1k/5oqKX9JjSO+Qv
 MosoBTfYUdVWAU7lx/OXktaVoj9YReHDBe/lF229xnT/4LXdE7LkpDMD9KUdmVidGycZqslxls2
 j/iTQ2M5MHh3i1MrAzmA8eybFyv8op9MxshEIoFiKLKm8o1t05P9JJb1d7i2YiultKBawX7C50o
 nQ4nKKCNu8+1+RyPbbC3Fj0wfAPgqVavdxGu7EjHK7j+bwOkZbLUutLBYiUS/3fgIUxbKWZU2f7
 /+UF7uJ0homH/xhtQPyRPdVZHyZ3zyCoPNUd39frSPlhNU1UCCJ7NbvUJV47NJz4NUNvSo5xXAs
 QdHUHemFMaxU5rO46ZWO63FDVyUhW5Z5driVbx2ZYQHrlQ1ViGcV4RJ1wM/Us57AMxkrago/s31
 AJzT5I+dXVGnlXFFAtBmqz94NHV4iwpXxj/JWJzCfWer+sF0qKRKEsFFUMtMP9+Z8x+wpbuRERT kZ57NubjvqXhnMQ==
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

As found with Coccinelle[1], add __counted_by for struct uniphier_xdmac_device.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/uniphier-xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index dd51522879a7..3a8ee2b173b5 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -97,7 +97,7 @@ struct uniphier_xdmac_device {
 	struct dma_device ddev;
 	void __iomem *reg_base;
 	int nr_chans;
-	struct uniphier_xdmac_chan channels[];
+	struct uniphier_xdmac_chan channels[] __counted_by(nr_chans);
 };
 
 static struct uniphier_xdmac_chan *
-- 
2.34.1

