Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4123F78024B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356465AbjHQX7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356316AbjHQX7D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1F3A87
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbff6b2679so2932965ad.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316741; x=1692921541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+4HJW/auB8x+AovPy4uQhBNpjkEktdOQK2m0h4AvuQ=;
        b=eiykHx+JWRc6V1EMoURv4Pruh3yvt/5U9kHVNC/yDiAxrBjjEDDp38/MD5KT5FJ4OI
         T0KZ42eQSSQOV87BRUoerWO94YBZUpTXO1SYtIJxvNnV29FDmNohyLmIdRl8qGrfR0SD
         nVUb3XzyHuEyqPA7KTctf2yPKMGT3EN1r6XWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316741; x=1692921541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+4HJW/auB8x+AovPy4uQhBNpjkEktdOQK2m0h4AvuQ=;
        b=Dziiul+u7t+8b3IjIoTzq5VAZRg7Ft54r+W4S2qbZvbY8j4D8cRnlodnglMJR+geeT
         cpq8B5d5ME5k9LoIH/pI00t73JDshXWhKYBKEViEatJX8niPqEPC5nZ3UEUDUxeA7ou3
         fnws932PHSaoucNuKq7AMDj0jPT5CcgbOZxUuHJ61Q6dEg/3lq3KfiJLnQ6yPcJK5W4z
         WE2YZSYgPI+u8Ro8jSAEbdLMVWlGTCNYKfX0yoCwqAWOtnFw3DjIgYc83j6mMlLGMwp/
         RPCE7xxce4FKO29StLyt+2ZbRtFbK9vYMiXEKeuzYtaFdvEvE9SscRUoAZM79l8Sw3hT
         7KKA==
X-Gm-Message-State: AOJu0YzDqBani0HNcrTZJ7j1vTpYQzKuSReatow6MAFBBNaTYNh3nkNF
        zILVahRmDnwQ4fEK1BPTqcHIaw==
X-Google-Smtp-Source: AGHT+IFGebGbp3k+CsL24twD0UTAlVu1JVsiqk9PaprDkh+IXCI1B/Cjd7zbL5GtfH68tzrzNT6Sfg==
X-Received: by 2002:a17:903:22c3:b0:1b9:c207:1802 with SMTP id y3-20020a17090322c300b001b9c2071802mr1209204plg.0.1692316741166;
        Thu, 17 Aug 2023 16:59:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001b80d411e5bsm321679plx.253.2023.08.17.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
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
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 02/21] dmaengine: at_hdmac: Annotate struct at_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:39 -0700
Message-Id: <20230817235859.49846-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=keescook@chromium.org;
 h=from:subject; bh=SO00/SVjajGCjMuuFq3x36eZ74YbXa362Z0gVVwiDDw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rQ/kwZ89vekQ7nYJW/uV4J4wjHF2gtaDeshJ
 sKago9defuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60PwAKCRCJcvTf3G3A
 JupcD/9gAzNiJxWx0uRQfD8T+IaYgnkOkhA4OeFx0IvrNeaLb+tCwUyZvaX4ej/wqzimsKMVdqN
 CZ7pm1PRURyuu8lT0h7rMGwnNlSY/Fen1jGDiML3J8cWz8KNQRJ51BExzo+6AT5p0bMm+MVN/II
 HE0/LhRNnfMXBsO5G3lvR9n6ztqEMfvBemm6L6Ez3Z7GFjJOsIlsDsSkhh8X6iQ/6HIajeJHyqj
 YvBYLRhif3iT0VlhntKObmx24rvGafjzDG2R2gjbTqeo88HSSizrbRwRfHivP3nbfmfohE2L6zn
 05qPcvXimafgX5XNsUoCKx6oZ676UVrb2Sz0On9nXxipvtx+CNc4qmXay7LEg99oYchShYD5rby
 XbfSNVh1byswNNiD4YUbANAh4lqhvoGZE7sv59b7Dh1q+qz9O4CfSpKswtIL/MQI+97t+xjrFlo
 XqNhdhiedIKgCFWsEcs2qAUbEhNB3fWfmt/fbuiz2e9pKuxIDuRxWhdcw/mry12LuNrHYERNQx2
 4B7UtAX+oTPF7O+ZImJkKGxpAg9QBwY8EmtDZ3B0Cz8BOmD4nAPSjbLQOfrFeNqnrPqO+EavE+n
 CR+pldV/gAtaU9XLFVNZcbJ3gPMcPG2oyaFK7y+26z4RP63O6+Si8YIQTl7TvMnoAYkDuWawIBl n8BIWx5jtvwp0JQ==
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

As found with Coccinelle[1], add __counted_by for struct at_desc.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index b2876f67471f..b66c7f416881 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -239,7 +239,7 @@ struct at_desc {
 	bool				memset_buffer;
 	dma_addr_t			memset_paddr;
 	int				*memset_vaddr;
-	struct atdma_sg			sg[];
+	struct atdma_sg			sg[] __counted_by(sglen);
 };
 
 /*--  Channels  --------------------------------------------------------*/
-- 
2.34.1

