Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F874AAA1
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 07:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGGFh4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGFhy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 01:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2261BC3;
        Thu,  6 Jul 2023 22:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8736173C;
        Fri,  7 Jul 2023 05:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5010C433C7;
        Fri,  7 Jul 2023 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688708272;
        bh=6W39rcO0mo+MX7jP0Rws3FAS7SxpwgwiBILDqfm4DBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9IOERvYN7BRwEBDVq/vqnzvKVtsFGl6S5ganEQmziXK8TORpqQOF9LZFRfN1/sWn
         9amCjXxZc0nheITnMkVqkDrhQNZHeh4e2e+rc6KC4tSqODoT8nhiQtcA0O9LyC2W53
         fz+omtSeQOi4INedOPP+cwGPhORe1z03xcu7cMZbrhABNScuTf92fv/nf8V/Dbhsyi
         G+/DzfBra1+fClMKJ6TKxiXnShb4xEDs+AI2EdiWs1auGOvadxGYrcaNFZRDdCRxIV
         kInlF8hx/ikhfVukuJaQFi/tNC9UkmNvlVbGAmifp4Uy8+OxyRvuYT0/YJJkSvzsta
         7MpZR7fPPm1FQ==
Date:   Fri, 7 Jul 2023 11:07:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, joy.zou@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev
Subject: Re: [PATCH v9 01/13] dmaengine: fsl-edma: fix build error when arch
 is s390
Message-ID: <ZKekrGdWWNOXNg0M@matsya>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <20230620201221.2580428-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201221.2580428-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-23, 16:12, Frank Li wrote:
> fixed build error reported by kernel test robot.
> 
> >> s390-linux-ld: fsl-edma-main.c:(.text+0xf4c): undefined reference to `devm_platform_ioremap_resource'
>    s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306210131.zaHVasxz-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 644c188d6a11..c1065c444cde 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -210,7 +210,7 @@ config FSL_DMA
>  
>  config FSL_EDMA
>  	tristate "Freescale eDMA engine support"
> -	depends on OF
> +	depends on ARCH_NXP

That is not really a fix! you are masking this by making the driver
build only on NXP

I think better fix is to depend on HAS_IOMEM

>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> -- 
> 2.34.1

-- 
~Vinod
