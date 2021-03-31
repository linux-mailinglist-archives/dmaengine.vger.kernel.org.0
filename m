Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91C3500EF
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhCaNIR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 09:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbhCaNHz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Mar 2021 09:07:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD96160C41;
        Wed, 31 Mar 2021 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617196075;
        bh=yUX1kX8xMn1DiGVpD/pfj9/RqcpPrgOsDiJBGmreC0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMdjDmhDgtpIvJTgvcHJcyyd/hERaqiZylwcwN9wsIG0f+N3DKjGpwdXjJUnV3k9+
         VECiBeQOgDXF2LQ37Quohcqbp5PQGgkRBEwpGjwVJsEwtWyM4SM64cGyLj9pp2GdFv
         kB6xCWhzDhiDEIkGpg6FyHOrg0FT0d1n5PlfkZXLN01ohrWhgKCofifdNJJSNSdWjs
         bDl/Gz7bpGuunnPB3EbPQfXK5Q7efR4eRorwSbaHbGPKjTb6QlTQvIBGH+35c8ve0G
         GgWz9v9oqrzCcGees9I1kwcxJkh/A3YJowJNz1cUEZ+HdxQUGea9FQyTCmJ4SqOTaN
         Gal38kITQHZjg==
Date:   Wed, 31 Mar 2021 18:37:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] dmaengine: k3dma: use the correct HiSilicon copyright
Message-ID: <YGR0JzHnG9mtRg98@vkoul-mobl.Dlink>
References: <1617086684-54834-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617086684-54834-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-03-21, 14:44, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.

Again, dont agree to terms of use. Pls drop that

> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/dma/k3dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index d0b2e60..ecdaada9 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013 - 2015 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>   */
>  #include <linux/sched.h>
>  #include <linux/device.h>
> @@ -1039,6 +1039,6 @@ static struct platform_driver k3_pdma_driver = {
>  
>  module_platform_driver(k3_pdma_driver);
>  
> -MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
> +MODULE_DESCRIPTION("HiSilicon k3 DMA Driver");
>  MODULE_ALIAS("platform:k3dma");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.8.1

-- 
~Vinod
