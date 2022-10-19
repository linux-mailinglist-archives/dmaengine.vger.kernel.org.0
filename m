Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B58604DC2
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJSQuQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJSQuO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:50:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB5143A6E;
        Wed, 19 Oct 2022 09:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C95AB824C7;
        Wed, 19 Oct 2022 16:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5D5C433C1;
        Wed, 19 Oct 2022 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198210;
        bh=kcgFf4x+wh7v7BVY6QOlT8b5olyWXNSV4e6UOkRCa/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JncByFxeqpiBF5GhyBvFP3yCDvHQ+aCAEswXMaW/U2W79xSoYNtCy/Fwef7lyKI4d
         xcn4yFHvJJtxrdMhSqiKfmiiUWdlDzT2Mgr6ZNvhquhpzjrRE5c1J6PNZuSGNH0rqP
         VDPCEnf1pmjea5IorkIb3jmL+eHEFnBmBhvxhvDW/DvGr9kIP+IzAJKyLPiWeo7Ozs
         /mqzlc9bQV4SCqUilH0gqimrrslVa3tLbYglzp5xJyEWHahLjYJ+oEKgI7z0YcBGeI
         z6XCGe3T6uSpEzHtVqxYf3RVb0W9tLOqXpK84T0IomuYHu5Aowm/Xy4TXj4toXX7HX
         4Yci8n+FT6m1g==
Date:   Wed, 19 Oct 2022 22:20:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     peda@axentia.se, du@axentia.se, regressions@leemhuis.info,
        ludovic.desroches@microchip.com, maciej.sosnowski@intel.com,
        dan.j.williams@intel.com, nicolas.ferre@microchip.com,
        mripard@kernel.org, torfl6749@gmail.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@gmail.com>
Subject: Re: [PATCH 31/33] dmaengine: at_hdmac: Use pm_ptr()
Message-ID: <Y1AqvN1gn/wyAf55@matsya>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
 <20220820125717.588722-32-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820125717.588722-32-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-08-22, 15:57, Tudor Ambarus wrote:
> From: Tudor Ambarus <tudor.ambarus@gmail.com>
> 
> Use pm_ptr() macro to fill at_xdmac_driver.driver.pm. In case CONFIG_PM is
> not enabled, the macro will return NULL.

You annotated at_dma_dev_pm_ops with __maybe_unused which is a correct
thing to do, but should be explained here

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@gmail.com>
> ---
>  drivers/dma/at_hdmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 0b473e6d161d..e35b4b325452 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2524,7 +2524,7 @@ static int at_dma_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops at_dma_dev_pm_ops = {
> +static const struct dev_pm_ops __maybe_unused at_dma_dev_pm_ops = {
>  	.prepare = at_dma_prepare,
>  	.suspend_noirq = at_dma_suspend_noirq,
>  	.resume_noirq = at_dma_resume_noirq,
> @@ -2536,7 +2536,7 @@ static struct platform_driver at_dma_driver = {
>  	.id_table	= atdma_devtypes,
>  	.driver = {
>  		.name	= "at_hdmac",
> -		.pm	= &at_dma_dev_pm_ops,
> +		.pm	= pm_ptr(&at_dma_dev_pm_ops),
>  		.of_match_table	= of_match_ptr(atmel_dma_dt_ids),
>  	},
>  };
> -- 
> 2.25.1

-- 
~Vinod
