Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00A7B824A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjJDO3M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJDO3M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02EAB;
        Wed,  4 Oct 2023 07:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FF3C43395;
        Wed,  4 Oct 2023 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429748;
        bh=dE+wd+fx3bR2fLrXaHnvGq6sU/3A9Au6dn7p+BhL9ac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bMgMmU+zyhSUHroX0vz4Jjl8UKUURxm6XP4DiBC/XoTBMIbCUEg7K/JFcr3xVYDzQ
         yUJYkdce4INQVwwIX62m/u1ppOYDHv0lg5kPtOAgtGp8ckvJQPb8Rv1oNx2Dr6KmCB
         CClMgWKkh8caTFbqRuJR2V785guuQVBPJlmKCbeSKjHB/C8xZ9cR6SS4h1YHicOZZY
         pA9SpLWV8rpKymzh48BRHxXnaBg8h4neFkLcWwlFaYvypLOz3gxiq89ZWd12B2K+sk
         l+c+1dhFYo46qqh1mY3GS0EeussZPli8Qrcph8dXGFYha3xIT4WaH8k328RrnwEiX4
         U634wpEed6zWg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20230928234334.work.391-kees@kernel.org>
References: <20230928234334.work.391-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: ep93xx_dma: Annotate struct
 ep93xx_dma_engine with __counted_by
Message-Id: <169642974524.440009.16047886580039006208.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 28 Sep 2023 16:43:42 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ep93xx_dma_engine.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ep93xx_dma: Annotate struct ep93xx_dma_engine with __counted_by
      commit: 74d885711c2f619e92f41ef308691948cc63f224

Best regards,
-- 
~Vinod


