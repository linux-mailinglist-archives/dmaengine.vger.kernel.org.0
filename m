Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF2657314
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiL1GPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiL1GPF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:15:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9FEBE1;
        Tue, 27 Dec 2022 22:14:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0570D612FD;
        Wed, 28 Dec 2022 06:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A66C433EF;
        Wed, 28 Dec 2022 06:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672208092;
        bh=m7XMZiCYvhKtjCP5GP+uw+KpZUYgrdFPktygGn+NBGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKOUlLEac3i8Sfzg4EPYDJY6xMITsWH25unBvRhDHTVQHdajpTYn9qORwSGpdUn9N
         lWSKIbARxxLqUeX3oovS2urJWzQYz7DeIGfn9y41v0s7eEqtQvSSL1Y+Lb26HFSfNW
         KxgRBR1n90qQCmnGzWqJTYpu/btqwPn147lLiwNNLYLf7Nzi490prX44Q5bqPNvPN3
         py/NHDqqpswYm/dwntC2gaCCg+JVjINKBaNISZymAIpSGAMN+AXsX0i41EX18IYnwW
         Y3+6crDYJwbBvvaaPDYN6upyDGGoPf+hO2R+eaa5vziP1bg8RtTer/8b9vMAkwXz9G
         K1nAmPzPXB5zw==
Date:   Wed, 28 Dec 2022 11:44:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix global intr clear
Message-ID: <Y6ve2MUrG+/DtjbG@matsya>
References: <20221226065153.5558-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226065153.5558-1-mkumard@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-12-22, 12:21, Mohan Kumar wrote:
> The current global interrupt clear programming register offset
> was not correct. Fix the programming with right offset
> 
> fixes: 'commit ded1f3db4cd6
> 	("dmaengine: tegra210-adma: prepare for supporting newer Tegra chips")'

Ugh, this is not the format for fixes tag, see Documentation/process/5.Posting.rst
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>

Why did you CC stable for this email? Again read the process!

> ---
>  drivers/dma/tegra210-adma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index ae39b52012b2..487f8fb411b5 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -221,7 +221,9 @@ static int tegra_adma_init(struct tegra_adma *tdma)
>  	int ret;
>  
>  	/* Clear any interrupts */
> -	tdma_write(tdma, tdma->cdata->global_int_clear, 0x1);
> +	tdma_write(tdma,
> +		   tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear,
> +		   0x1);

This looks _very_ ugly, one line should look and read better:
        tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
We are no longer 80 char limited!

-- 
~Vinod
