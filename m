Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2A3C7DDB
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 07:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhGNFRG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 01:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFRF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 01:17:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CD3A6135A;
        Wed, 14 Jul 2021 05:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626239654;
        bh=jtXrPZtnhFp3WeqAcCQKGGtv9buAZ3NfPu0e41omTlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bP3jL7ogA43v4oY4sTOWS3QgkQ399hpOORgBQbK7WDufFFxokyBnDBmpAggEXaVCc
         hwsI0FhvDblGrZtxhTVX6Se9mWkQBr8UiLIjsOJ8c/iaHS6ADRNV0j6NnOVikATz6p
         uyVsmM40sfTOfE8193Za72z+P9csRDq4ELfk+lhywxtzF+qmU23OfxcRjUSLKSXOLz
         mfZN2NHKosy5VKrleiu2BTT0NBleXJ9El5UifK/YAs780MSPRlbUrk9cpxghUV7Xgi
         Qa2MlLAf5MROd6WhGBPPi2LPEjhXMP5HQ6SnY0ja2K0BbcrsorgFpfsesEJuFKzA+C
         8w/1uuieTv7Yw==
Date:   Wed, 14 Jul 2021 10:44:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YO5yo8v/tRZLGEdo@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704153314.6995-1-keguang.zhang@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-07-21, 23:33, Keguang Zhang wrote:

> +static struct platform_driver ls1x_dma_driver = {
> +	.probe	= ls1x_dma_probe,
> +	.remove	= ls1x_dma_remove,
> +	.driver	= {
> +		.name	= "ls1x-dma",
> +	},
> +};
> +
> +module_platform_driver(ls1x_dma_driver);

so my comment was left unanswered, who creates this device!

-- 
~Vinod
