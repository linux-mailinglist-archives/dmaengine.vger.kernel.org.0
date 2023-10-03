Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6307B74DE
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjJCX2H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 19:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjJCX2H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 19:28:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67932AF
        for <dmaengine@vger.kernel.org>; Tue,  3 Oct 2023 16:28:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af6bd48093so989028b6e.3
        for <dmaengine@vger.kernel.org>; Tue, 03 Oct 2023 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375682; x=1696980482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1cocEZekiORqignw5iQ3QnO8ZAEe34D0CJMf8KTzIs=;
        b=kmkt1mjeshnqomFJXrb9VPO9h7KiUu+pNppPH5zsgOlumyN2gSxB2gN8n834+FlHas
         YyV+8ljv2oQrTAlAmNmy4xvuyeXbCDJMlJpGGmtHdRHgnersE0+gfz2D9bHXGHw2hVn6
         FgtGoph3zItdFwAWwEIK+bNESIOC8wA+XtlFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375682; x=1696980482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1cocEZekiORqignw5iQ3QnO8ZAEe34D0CJMf8KTzIs=;
        b=VVmCRAr1rBC7vX5R0DpI78czBhkHKnCJKSxE4U2BEEE4QeVXdMG3HSXIQzNuX2YT72
         dyIPveefKzO/FUaV9iwJ0LigJ6zRomHagl//pZsuMOy9BWoH9M2alESevdmhvRzPnYT9
         zEiHxyyjdKC+4RWasee7AxC+tfE7Bi4/0NzJX2cYT2++CdsErXRQUIEOuVx6LeGtXy65
         2+QIgtB9d4wToKbVPeMbvTlu8toG4Bcxq8kaqvJYVUIlIxRSYRQh6zqsKu2tmhjPyszw
         xxV/1GIW9uoVQiO1I/BXcXuuoxxLYxvzO2ZKO2EMciOrCNBiVvIlFOvaoq4RaE1nBDR2
         wb0Q==
X-Gm-Message-State: AOJu0YwVDSC3qLmdA27gLv4hV5Tohm+bc1JejPHDKTh51sxiiyf61BL1
        TfDCQa6F/Z7qe2Yj5it1DqvHeQ==
X-Google-Smtp-Source: AGHT+IGcDZsz8I7q8HeOw+zAOiVjTbrdYbyOyLeLVe3dMszaNS4gWaQkf5NPvjAd8b8Ijnz9eccivg==
X-Received: by 2002:a05:6808:1386:b0:3ab:83fe:e18f with SMTP id c6-20020a056808138600b003ab83fee18fmr1040629oiw.35.1696375682763;
        Tue, 03 Oct 2023 16:28:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b2-20020a63a102000000b005637030d00csm1917249pgf.30.2023.10.03.16.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:28:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, dmaengine@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] dmaengine: fsl-edma: Annotate struct struct fsl_edma_engine with __counted_by
Date:   Tue,  3 Oct 2023 16:27:56 -0700
Message-Id: <20231003232704.work.596-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=keescook@chromium.org;
 h=from:subject:message-id; bh=s8UpsNSdXXPa2sG80VKv45a8RFcNlzZa7z4+aE1gKZA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKN8cBMJPNyzXXuGAC8pBAjZvNoG6NrfePoLd
 C9D5gSb26qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyjfAAKCRCJcvTf3G3A
 JuEJD/9v/LCGJzv4Rw87JT1vYJVt0ykGcqLmnwnqOBGGZsqevqD+b7qp14+O1Q8lnIkI4W33lG2
 WbeXUWN6tcTbe2U5IZqKbtksxWFE9qY5jG44U0LWuYDitzIy3zpXoUzf9KKtH0MFHEZgbdcWT+v
 advfP2YT7lRageoZr5YdGugHBpNZ/jaZEB75Sbmm6rfce8egfMISd/JvRWzu5Vk1EszldbP1i9b
 X0VVdfiA4Ip9o7U//FK/Qhh+dHVNCeAxH8tjonoTn8VmX9dVq9kEIIlNdqdakhQ0cqotn8K+UUz
 TEg4oOAtEvyQFwLSSFJOWWrbwtEsZt/hyQKAZg0s7KrNXDkaRw2QJ+HfpOmnWnrZIEIcSeVSYxl
 ZG7UCCXQkpA+wJQ7/w/j53k+5e+LHjmnZgv9fkU9QVQs/NUCWMvaldXHJnVsUBfJ2Wsl464Pd6Q
 VDhJzr/ZMMATrkL4cRoZCmPBuJHtTFPoUDIiMmnFlZab82OB2xZ02UKYagv77ZurGq/O9vmzYdl
 6D8O7BYvb1dlOYv/uEpQHR3PaTu2k+nq1RXhNk3opBHUl1hrke7gJEcsFF6ehvPQY2fvHgESw04
 RR7Lmu9tmg7ilcDwH1bO92ixNm7NP1P8B30siaG24HjWBbalKHnxhHyQaO60ldjhBdlBVJ0wRGl
 /fnpHhl RpJmix4Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

As found with Coccinelle[1], add __counted_by for struct struct fsl_edma_engine.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 40d50cc3d75a..bb5221158a77 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -225,7 +225,7 @@ struct fsl_edma_engine {
 	bool			big_endian;
 	struct edma_regs	regs;
 	u64			chan_masked;
-	struct fsl_edma_chan	chans[];
+	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
 #define edma_read_tcdreg(chan, __name)				\
-- 
2.34.1

