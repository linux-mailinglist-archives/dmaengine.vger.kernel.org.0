Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE778022C
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356427AbjHQX7i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356399AbjHQX7Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0A3A96
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso308705a12.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316751; x=1692921551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPIu4p5LokRgX8D90uVV1XnYO5Ym/ms7iXgxGBeHR9Y=;
        b=M6wL6hWwGDRmISDltc37KS8ptBiEf3Qr48SdCfCb6p+ByGHD+wOnNkD0wIphUGF/ZN
         QSMjqs4TY0WneT0GQRWA8wiQRqDyIYf0YH5LQgPa35FwvVwnvz1IZEWWuvicKx2kp/EG
         vF4AVAPFwe9UZRviz3FVkuSBzJGWyenINNoI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316751; x=1692921551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPIu4p5LokRgX8D90uVV1XnYO5Ym/ms7iXgxGBeHR9Y=;
        b=XKSLqkrH3rvC6q1GaWOTDUcC8ULXCcrp8P+/R2LM8pOkTak8/Fh8PO+Z68dv6wPrMM
         u5BC9jyOnottQav776S10GRcncbPhkUuPcD60vPe+WL+NjLzxBSaeV3A/DKZ2InqpKwS
         wzTIpqebs8yQcY8XjAe6GMLYeFXAQ9X3U1Nn2IV0D10AV9bqvLonMRdByXAOulNIFKJz
         8+DIPMNo/x+3EtpL2Xo9KHJeFwJhU+1s2Jupvn1iNyLvrkVXDaZDrf3KbQhphs8S/+Ww
         v+qKaLYynPioA7ww/L/+VHPsti877ZC8fG0BHdxeajAWTqwqvztUvcNIQnv8ymJ5f0f4
         FRgw==
X-Gm-Message-State: AOJu0Yw56v6mMUUU+Bz5IPIExGdIzRbyNJpUWid0P7BdXj0kIPIFaC8I
        WM7aZKPy8e+EOkuRpxri6jLLtQ==
X-Google-Smtp-Source: AGHT+IEp9NsNs5bP5Txz/M6Zf1bH84aBR/zLrx+4UwkkfuWiGVH3ef0DKY/ohXremovjTUpPNjANyw==
X-Received: by 2002:a05:6a21:999a:b0:129:d944:2e65 with SMTP id ve26-20020a056a21999a00b00129d9442e65mr1690595pzb.13.1692316751709;
        Thu, 17 Aug 2023 16:59:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b00682a8e600f0sm317127pfn.35.2023.08.17.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
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
Subject: [PATCH 13/21] dmaengine: stm32-mdma: Annotate struct stm32_mdma_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:50 -0700
Message-Id: <20230817235859.49846-13-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=keescook@chromium.org;
 h=from:subject; bh=qxPmilAAIkLoOYICjRkX4cjKcAjqE7CQu+wWoaP3kts=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRBiikOng0Pfopo+sTAW7rtw4RZgr55AKvYH
 ziP0G2svk6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 JkzQEACx/KvF+wEb76F6NHodgtyBW5Bo96EDbaR+uzQ1M+6MkoJ+z5QX375uyUt/2CSiohYitZE
 3k9R5DImexGGnDErX1pyh0O54lVFZh4trqFmrjlIRP5MN1o00A+aPOY5fBOappLuZYEvZPIImN/
 bkNgwNZlVFH5giEHSpJo3q24BT/VtqNjlOT6gb4ZATrfFUS7m5trL8xe0bW/JduIhqBt0u2Ce61
 +P1AkdS0k/0ZmbnTf84lcr3/BMXf0orJ6GdhIIhxq6Ee2MTFmWQbQvsi8r/LlmKlwXfWtwsnuNW
 7XH33IQQiKv7pTeV31N6Vn+Gz9G8rv0DMiS4KbLN451Vn+KQrXTljf7wE/hPct5E+yWNpKk83L/
 YHOWq9nvagB+yvrBBa0rcA3Gc8nEckvDx6pTmtntal/BEcG+ZLwjf9s7Gj7I6V2qKtdfHXMhHv8
 PX7jTwRf+V+jIJs3dTWZDmLWvRY1ydelSG4tFuR9LL+XMPV6tRJ4czS5VhRYZ3YCYi44H1w7jPl
 REwibv6UXxwafopUJ2UvHkguL07fha0L/4qVQI/RYIhUf2IXo9AdRcsgnXBaHA2eyY+wj2YEqqD
 hplXqLsFgvg+xjjNJ4/LWnRcqYy/nyVPy0WQNubxImH9dS2lT0g+cZu5wOL9gLZyxvZGJ5p3frE 3FY7s8aJWg4iKHg==
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

As found with Coccinelle[1], add __counted_by for struct stm32_mdma_desc.
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
 drivers/dma/stm32-mdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 0de234022c6d..926d6ecf1274 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -224,7 +224,7 @@ struct stm32_mdma_desc {
 	u32 ccr;
 	bool cyclic;
 	u32 count;
-	struct stm32_mdma_desc_node node[];
+	struct stm32_mdma_desc_node node[] __counted_by(count);
 };
 
 struct stm32_mdma_dma_config {
@@ -321,6 +321,7 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
 	desc = kzalloc(struct_size(desc, node, count), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
+	desc->count = count;
 
 	for (i = 0; i < count; i++) {
 		desc->node[i].hwdesc =
@@ -330,8 +331,6 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
 			goto err;
 	}
 
-	desc->count = count;
-
 	return desc;
 
 err:
-- 
2.34.1

