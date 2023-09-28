Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F07B28F2
	for <lists+dmaengine@lfdr.de>; Fri, 29 Sep 2023 01:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjI1Xns (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1Xnr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 19:43:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0FD19F
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 16:43:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so102346325ad.0
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695944625; x=1696549425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNHH+1qhuM2be0FNxraZa2k964UVjBr3da8cdiKRngw=;
        b=Sy1qrqyWxjWf+WyGsozkx32322B0DYBkvwFZER87pdVzcNV/cugNLl7M2HVu3Id8wy
         ERRRlCOX2YAY3RHcV+ZcuTACBHNDMra7WDiN2NDRA6MVpbkl2R45j5Qrq3lx/wwbbfmL
         dI6/sb5rjwNXMlDbeoUO46Q6SL6U/J8Ldl814=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695944625; x=1696549425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNHH+1qhuM2be0FNxraZa2k964UVjBr3da8cdiKRngw=;
        b=pEsQBDLkxXO3EZO8OTA/ukCiqtsb2xv2UAZW11HxmEoPm/CvSjdH4+pVbGqprzObtK
         dTA6XUDorqhD2Nu0bAgXELwndxWi8lcQD4Gji8o0Pex3xg72XCJNl8jwUY+fHjaLqfa5
         ItHtqP+g7p0CzrPI3faSCu0Rmahh39xr2y+GIgHTt3i3FrI56SeSQYVM0MD+T1atg7Nu
         qN0SV2E7g5SyRHuCq4y3Pcx8iYIhfGZoiSVBl1YdZwlj+eWLzHkc6Dobw0rYKKEaCpxG
         ahsQA91l/finXudpSdXaxnkCajNrsZxJFyhC3uvF1d9VW7PCeV/zOE4C6nyD671F8yuw
         jM7w==
X-Gm-Message-State: AOJu0Yy9zGjyJyby6vt1qIu/qiIdkfGYpMkRr9xr3uEyxx3yYFMYO9OH
        D7XjE1tGwIbe5deoM9IsyK+GotF7gFXKwgDzZkM=
X-Google-Smtp-Source: AGHT+IE3aB3bki1h2nzKeq4Hvu7L23o/LNCvJSwxc21wrOMfa6r6KlHZeiE4hugYWpH4RLmgxSLGuA==
X-Received: by 2002:a17:903:1c1:b0:1c4:638:fff4 with SMTP id e1-20020a17090301c100b001c40638fff4mr2370744plh.17.1695944624781;
        Thu, 28 Sep 2023 16:43:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b895336435sm4068006plg.21.2023.09.28.16.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 16:43:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] dmaengine: ep93xx_dma: Annotate struct ep93xx_dma_engine with __counted_by
Date:   Thu, 28 Sep 2023 16:43:42 -0700
Message-Id: <20230928234334.work.391-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305; i=keescook@chromium.org;
 h=from:subject:message-id; bh=THP69OmSOtOGZgovd3irCbWFIq76IMb1Eo9RFIZ3FIQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFg+uQsbjWwI6QLDwpDQxEemOjDuINJD24mwrU
 /jndnL6pPuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRYPrgAKCRCJcvTf3G3A
 JjzbD/9786EPnb+KEovN2A394u+CjRE5feFbV0OH2nJ+hoicNA0BmpvVK6QsaJqscUhY5SzZnIh
 bJD/VopZIUjwI4FITPqd3Yd03UZG5en7eTcobbpl13XYpOvvHfGmu5sAK7daO4UvRki9YbY/N58
 m+5TiNXLb8SwuOLA1TcJ67oPCf1N+kRUMewPGQzE3BrzjsrmC4nzBzItDiBFJaSmSUv/QI5TA5h
 A+RxcOH11WeE7S4GGhN0EMcTv+w0/K04pncSa6lEdKHKZUL6I94j5oiRsDNdUNih71JGsyM4sp3
 Xfg1nHufCoyp/18ig9FZ12Qg4gulxu5dRUqfzDV3HA6QoazyJInWvQizQKTT5hnVX3cTSo2pjN5
 aeKyS51Yt2Ie3NIsUgexXgNaU70uD3yqBTWTdK8aPYOBW9/0zJF6Oa3c29hUAB6fqhV6a72H3P+
 M8Hm9ZD9HyYzV49KpOi1i8kzL+d/EqbRdTlSnRkyr4rdGzCk16Bvh02vXWZ56G9V09qWS0cJHXn
 fk74+F+zDDMUPD74z66DuOExRi9n5LzWvhnNfjql7GYDcnKJFwTM9oyTgNnpqvleA22e68tC3eQ
 oiGIO/BQrniVpKwWJG6melsLUr2tQIeN+Pj4Gh8KP1Myz/9WxSxu7Sqyn502tYFCrQq2lxwXbwm
 NkdSZdM Y4Zio4YA==
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
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ep93xx_dma_engine.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: dmaengine@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/ep93xx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 5c4a448a1254..d6c60635e90d 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -213,7 +213,7 @@ struct ep93xx_dma_engine {
 #define INTERRUPT_NEXT_BUFFER	2
 
 	size_t			num_channels;
-	struct ep93xx_dma_chan	channels[];
+	struct ep93xx_dma_chan	channels[] __counted_by(num_channels);
 };
 
 static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
-- 
2.34.1

