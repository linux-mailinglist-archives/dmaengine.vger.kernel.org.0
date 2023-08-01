Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F176BC83
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHASaV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHASaT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2D26B5;
        Tue,  1 Aug 2023 11:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AADD61681;
        Tue,  1 Aug 2023 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD1C433C9;
        Tue,  1 Aug 2023 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690914607;
        bh=zMedVEKXskRnojh63v+kh5e9VTTzTRLLizMpxX3Tln8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+MCm5hvKY0MnaRjT7BjW/3PkdRkgtsfMgUtsl2kkPfCe23te/jF7atv6o6ShZg+z
         qBreYVScDed023a4JAbeiraQNAahtenkBTFq2sDSVURYTuqIUw+k6JBirKyw7ZXYc1
         XXps3ZS1sJyqpI0mVWTqlSyJl/KzNyarsyWSJukPyMkA4AMh0LpxLaL0tL2X46JRUk
         xYCU8vyVt2TBjl0v4TmHIdEDFgaPKKiEyGQlnEwA+Z5Ry7jsOAnBHH+vTNqXl88oxG
         UuEUowwjsKiFadKEN34qThmaq6M2cMlWZo7aXzTGeSnzqYO3GL4K8VXRKVMiKe3R5o
         Vw55lkA6JVRNw==
Date:   Wed, 2 Aug 2023 00:00:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     hanyu001@208suo.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: at_hdmac: "(foo*)" should be "(foo *)"
Message-ID: <ZMlPKwvyBO22aOdp@matsya>
References: <tencent_0348568B118A57A1F34115B6FB1D12F38008@qq.com>
 <902c5769afd77f600c9bef24da0da34f@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902c5769afd77f600c9bef24da0da34f@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-07-23, 16:48, hanyu001@208suo.com wrote:
> This patch fixes the checkpatch.pl error:
> 
> ./drivers/dma/at_hdmac.c:1119: ERROR: "(foo*)" should be "(foo *)"
> 
> Signed-off-by: Yu Han <hanyu001@208suo.com>

Thanks for the patch, the From for this patch should match the
signed-off name, pls fix and resend

> ---
>  drivers/dma/at_hdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index ee3a219..af747a7 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1116,7 +1116,7 @@ static int atdma_create_memset_lli(struct dma_chan
> *chan,
>      /* Only the first byte of value is to be used according to dmaengine */
>      fill_pattern = (char)value;
> 
> -    *(u32*)vaddr = (fill_pattern << 24) |
> +    *(u32 *)vaddr = (fill_pattern << 24) |
>                 (fill_pattern << 16) |
>                 (fill_pattern << 8) |
>                 fill_pattern;

-- 
~Vinod
