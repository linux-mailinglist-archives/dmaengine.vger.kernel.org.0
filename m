Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776AF780239
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356386AbjHQX7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356396AbjHQX7Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 19:59:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1A3A93
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686be3cbea0so1070512b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316751; x=1692921551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y2Eh4/WKRjvBkeOEfQI129skaNYk4SyGprhYtjFhak=;
        b=SzUW2GrAVSjYkhX+pusIUEOM+KNuQmK1FASSRRo4qO8aZqzl/n/O9lDGtPK2t65ly2
         aR/6/Z55DpooK0hj1hBnzvmaxOGaMFCvnXYiGBjR9+03xK0pMUQjNqa3GJWDJNBe3qiF
         jT3v6MwHJmiAXg1SI/wTDZTvSnHlP95OYuJHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316751; x=1692921551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y2Eh4/WKRjvBkeOEfQI129skaNYk4SyGprhYtjFhak=;
        b=aIFhRdkUvCndxynowoeM/YErSuexOnPCyiKql/NwFAGcwwHtMR299iB+s2Bh0rjUZU
         4Zcuctj5MRWdeDMVxSRFmf1wqLcch2oyrqJliuHAlXmKYq6AQGqvQeMmLQ2weWSywiVw
         NpLMZAFsKL1oL+PEmKaNUNkNlO8sbdHGKjgk3TSF9F1SYTykcQdxSg1nMNriBiCQJmpf
         /okOcfG+RrCJXUX7o01CV1ZInGpnDTrsxIgdAKr5uRyq+ZyZoCRXBTMsScu8lucEWMn+
         YC/I/m2dsu5GMeZ8P4sIqFzN2yNkZskdns0ffPB9nd1wpy2yk6VUTECftftbolPHQzjH
         2vug==
X-Gm-Message-State: AOJu0YySl2rcXXr8CjM6VN2IhWrm8DnZVXNi89T5HeT9hbjPIy0W1u4b
        WLaSaMZHORVRnL6qJdZE4zcJ/Q==
X-Google-Smtp-Source: AGHT+IHFr30RcRjlqiQJEr6xWEDOZp1+abHFVC9+OhQwpQoJHgk9ThDktq6OxUXsC0D8f6pR31KY3Q==
X-Received: by 2002:a05:6a00:2d10:b0:687:ffac:c62e with SMTP id fa16-20020a056a002d1000b00687ffacc62emr5083101pfb.3.1692316751240;
        Thu, 17 Aug 2023 16:59:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0064378c52398sm313422pff.25.2023.08.17.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
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
Subject: [PATCH 11/21] dmaengine: st_fdma: Annotate struct st_fdma_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:48 -0700
Message-Id: <20230817235859.49846-11-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=keescook@chromium.org;
 h=from:subject; bh=/eh3gjVXUNLSKs9JrCYa1PazNmJDO3vyJIq0hWQiyZ8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAuXQI4DpuGM5iOlcO51tj0uf03Jt7vDRoW
 1Ii4cUpYx6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 Ju+5D/0YrvVo8rjhZaCcPFDgAshvwzk+u6v2Fw/4/dfJ+OS6ryJ+sJav8pUCdDNGIv2zNyAWlil
 adBNzQRmJl6gNY6faZUcd9pPz7Gcis004eQUoFbl8BnE3oJTlAxq+mvH7rqyIItvnZz+pJcjY0X
 tRJ+2EQIAhNV2+IAdF39L4hFVZgH9n07Un8gQljl3C6GL4SZ6ydxuNARV0yuzj7ksYtQmbUZWiM
 sjzN3ijHcW4y90VnWlisCuyiH85rwJD5v81mw4D4T0bIk/KVW/XzQElanZGyhFShZ7NB0xecSaW
 4yskOrN45ih97E4wcfYbmX583qeuDF3+HIspWg4vx1Esg/JpzBGhZDGKmgjJgdKbiQeqPxJWziN
 rIPjrRxb64nMV1bvGZRAdGM9OEb7BpcPqDTHrYmHTuWlt8smEvhSGFIE1oonrgwP+V9dNpFIRUU
 dy5znG3aae+m869/A13/KcStCYb4q5v49KTf2ABP9XaGOsiow4VEg3WjkTcdDlCo0YX2VF5IgpY
 73r7xslhvy5W4iRgnCw24jT+VAqyVI1tlBfB/8qckc7VndWWdkYtBmoiY4dhiAGxPg/PYcpwrrT
 NffAKTMZbkpcLpaBKi/B2Ah9kKVH82HTlRPVZ+JlStUZiw4juxxp/4t9OqnZmR3hLyQCVVpYhna yy/imOVfvaQKlqQ==
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

As found with Coccinelle[1], add __counted_by for struct st_fdma_desc.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/st_fdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index fa15b97a3bab..f296412e96b6 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -97,7 +97,7 @@ struct st_fdma_desc {
 	struct st_fdma_chan *fchan;
 	bool iscyclic;
 	unsigned int n_nodes;
-	struct st_fdma_sw_node node[];
+	struct st_fdma_sw_node node[] __counted_by(n_nodes);
 };
 
 enum st_fdma_type {
-- 
2.34.1

