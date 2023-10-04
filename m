Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19787B8243
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjJDO3G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjJDO3G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D3AB;
        Wed,  4 Oct 2023 07:29:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD873C433C7;
        Wed,  4 Oct 2023 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429742;
        bh=KqRNpiCtCs4Rwv/M9eIf6xD9i4BgOO2QeVweWjAAAZU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cWrHN6hpB2LZY+61r8q4V1LqAN7/v6kGoq8Qp6h5JysXarQaoIZ5Dlz8fvA36m9t7
         uY+QJUGrEUZYYgVHwTaSTzG1crp/fXYdlocOnB8U5rbH7T5xFIMeSjH8U60kE87M7Q
         ysSMIIWIjFA/U2AJYsXuZKabaNidhY+rIUVwt1h7F1sXuWESsDen8/PHEsN7JByoXN
         s/mpsCCn404zKlJWnv7YUNV9fnaPAcwDPv5UwvAT/rbNalFQnTC/OLv1eW0Vtsx371
         l+at/pOIM5TeuRx0k2mCmPN6tPsoLQ9LHBJGE5vvziQVAKJlxK8gplKE+xeQN7aGAJ
         qbP3fa7rQzSpg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dmaengine@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20231003232704.work.596-kees@kernel.org>
References: <20231003232704.work.596-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: Annotate struct struct
 fsl_edma_engine with __counted_by
Message-Id: <169642973944.440009.1499623916729788051.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:58:59 +0530
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


On Tue, 03 Oct 2023 16:27:56 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct struct fsl_edma_engine.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: Annotate struct struct fsl_edma_engine with __counted_by
      commit: c223bafdcbd51506df00509088efc62e08ef6c3f

Best regards,
-- 
~Vinod


