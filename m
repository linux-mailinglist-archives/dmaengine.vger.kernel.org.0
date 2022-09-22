Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9780B5E58A5
	for <lists+dmaengine@lfdr.de>; Thu, 22 Sep 2022 04:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIVCiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Sep 2022 22:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVCiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Sep 2022 22:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5EAC25B;
        Wed, 21 Sep 2022 19:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E881763145;
        Thu, 22 Sep 2022 02:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A36C433D6;
        Thu, 22 Sep 2022 02:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663814297;
        bh=MOtwl9mtwhtHTWDeXYdNcwvXQVIElYFyIDDemYh6RtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twmF+KMsN6Awv35vKFSKmpcxIR9EJ/rmGSpB1v+r1o1Q4xXjCNi8Zdmv44LIDZsTu
         /qREctSOI92mNJI03HKwsbvummXIha6buUJLJCVbM5J3938Yd6lB2ukaZ71KWYCRT2
         4XUSqL99aNvOIdWODuqKAdfYgwZZUywPHNEarGPMd3OsSRk8SuA4DiDxofSaTn3cs9
         AcQTp0jHWmuvV5QDnvvmkPzGl/uoEejgYBrZrO9TnDLPDFvpU4wYcWJV5A3/JEarmI
         2euJ+VWZLrutaD4s7aim7XbmQaTHZTLtSYz0qBRqbeXRF9kDndnAZ3K0Oc+Ic4P19R
         RV4t6khNZM3mA==
Date:   Thu, 22 Sep 2022 08:08:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     dmaengine@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize
 interconnect path
Message-ID: <YyvKlWgaPVV3su8f@matsya>
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
 <20220921030649.1436434-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921030649.1436434-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-22, 08:36, Bhupesh Sharma wrote:
> From: Thara Gopinath <thara.gopinath@gmail.com>
> 
> BAM dma engine associated with certain hardware blocks could require
> relevant interconnect pieces be initialized prior to the dma engine
> initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
> is passed on to the bam dma driver from dt via the "interconnects"
> property. Add support in bam_dma driver to check whether the interconnect
> path is accessible/enabled prior to attempting driver intializations.
> 
> If interconnects are not yet setup, defer the BAM DMA driver probe().
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> [Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
> ---
>  drivers/dma/qcom/bam_dma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 2ff787df513e..a5b0cf28ffb7 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> +#include <linux/interconnect.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -394,6 +395,7 @@ struct bam_device {
>  	const struct reg_offset_data *layout;
>  
>  	struct clk *bamclk;
> +	struct icc_path *mem_path;
>  	int irq;
>  
>  	/* dma start transaction tasklet */
> @@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (IS_ERR(bdev->bamclk))
>  		return PTR_ERR(bdev->bamclk);
>  
> +	/* Ensure that interconnects are initialized */
> +	bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
> +	if (IS_ERR(bdev->mem_path)) {
> +		ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
> +				    "failed to acquire icc path\n");
> +		return ret;
> +	}

So this makes us fail on older DT where icc path may not be present.
Should this not be an optional thing?

> +
>  	ret = clk_prepare_enable(bdev->bamclk);
>  	if (ret) {
>  		dev_err(bdev->dev, "failed to prepare/enable clock\n");
> -- 
> 2.37.1

-- 
~Vinod
