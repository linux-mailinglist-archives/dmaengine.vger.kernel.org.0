Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD23052CD
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 07:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA0GFQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 01:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhA0Fe1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 00:34:27 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B7C061573
        for <dmaengine@vger.kernel.org>; Tue, 26 Jan 2021 21:33:42 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f6so590605ots.9
        for <dmaengine@vger.kernel.org>; Tue, 26 Jan 2021 21:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXTjp2O+kLbB9CTCJxJt0SD+zZK5wsiYg7svDRD619A=;
        b=dOn1TON+07GhKGJIoyayMjmuy9BWh8V5ii5n4VTX82icYwL/TZwbySdeoTGe3zAzC7
         oSuVT+QQQ33v+XleMivKtoG2pI8n2OuZ9WN0bVODaUZ1UVzMKaFDoNYW6SEGK0pCKGKQ
         oWxYyv3zdNrU3Ep7X6AREUC29Rlo8lcyt4qvfUGVJ+VMNTx5UuJgcjV0rAxgRI/6Bk/K
         0i+FrH5GAbdXLc9mePC17FZ9ip41xi53D0APB/iDZlFNapeDRcpz5BD2WXJpdKPZBOIJ
         MnfwfXayWeimpxJ4hLheuNTqOC1Bq0ahgp4WJngILzzvK0tC/Jj3ClVY+bA4mPvdkw79
         6Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXTjp2O+kLbB9CTCJxJt0SD+zZK5wsiYg7svDRD619A=;
        b=Xxwk2Go8a2iMzqWEeUsb60BCVz57BHn4yGLJdc1XiRYv7mk1v1CQdSgwDEPfQwiDjl
         4L00/grQuGUkbbbKI5qgN35YDgO+ia26FM+GHs52XbclR8MqkcSVmLP36Fk4ipE9NQut
         d3xOpuqpc6thEM7rGbjHeJTUdSO2WK80N2nzrm/c3POerTjnOl2DSEa2QFzr3Tm4FgG5
         d3dU4DNnfKBRQICDl3UBzOvMOrIjD1ylkkBoW5y1SwvpW3X/mUExR9iyI/n7hYHuB+hT
         AMc1Hm+sXaEzxrEz8E5ywsEQh9AMHgaXF6Zn1OSfYKX2M13grVKdITvmXSyMAM2xZbnG
         fLHQ==
X-Gm-Message-State: AOAM532dOeUzJW891AsKZcD3I5/8qX5xP9LTRdttPglyPvcMEFt03p0Z
        xMwGcNDQljBsZBUcGQaVwkysEA==
X-Google-Smtp-Source: ABdhPJw+Yk3fYOO7ud+1dReFka/e+p0BzGgE33P9Oxdtl8BwVzczBeoJnHajCPDXBfylS3T2qXrRLA==
X-Received: by 2002:a9d:37a6:: with SMTP id x35mr6665900otb.275.1611725621367;
        Tue, 26 Jan 2021 21:33:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y66sm260747oia.20.2021.01.26.21.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 21:33:40 -0800 (PST)
Date:   Tue, 26 Jan 2021 23:33:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, dan.j.williams@intel.com, vkoul@kernel.org,
        shawn.guo@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
Message-ID: <YBD7Mhh1MowRDMBF@builder.lan>
References: <20210126211859.790892-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211859.790892-1-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue 26 Jan 15:18 CST 2021, Thara Gopinath wrote:

> When bam dma is "controlled remotely", thus far clocks were not controlled
> from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
> driver and not doing any clock management in suspend/resume hooks.
> 
> With introduction of crypto engine bam dma, the clock is a rpmh resource
> that can be controlled from both Linux and TZ/remote side.  Now bam dma
> clock is getting enabled during probe even though the bam dma can be
> "controlled remotely". But due to clocks not being handled properly,
> bam_suspend generates a unbalanced clk_unprepare warning during system
> suspend.
> 
> To fix the above issue and to enable proper clock-management, this patch
> enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
> the clock node is present irrespective of controlled_remotely property.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


And from John on IRC:

Tested-by: John Stultz <john.stultz@linaro.org>

Regards,
Bjorn

> ---
> 
> v1->v2:
> 	- As per Shawn's suggestion, use devm_clk_get_optional to get the
> 	  bam clock if the "controlled_remotely" property is set so that
> 	  the clock code takes care of setting the bam clock to NULL if
> 	  not specified by dt. 
> 	- Remove the check for "controlled_remotely" property in
> 	  bam_dma_resume now that clock enable / disable is based on
> 	  whether bamclk is NULL or not.
> 	- Rebased to v5.11-rc5
> 
>  drivers/dma/qcom/bam_dma.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 88579857ca1d..c8a77b428b52 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1270,13 +1270,13 @@ static int bam_dma_probe(struct platform_device *pdev)
>  			dev_err(bdev->dev, "num-ees unspecified in dt\n");
>  	}
>  
> -	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> -	if (IS_ERR(bdev->bamclk)) {
> -		if (!bdev->controlled_remotely)
> -			return PTR_ERR(bdev->bamclk);
> +	if (bdev->controlled_remotely)
> +		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
> +	else
> +		bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
>  
> -		bdev->bamclk = NULL;
> -	}
> +	if (IS_ERR(bdev->bamclk))
> +		return PTR_ERR(bdev->bamclk);
>  
>  	ret = clk_prepare_enable(bdev->bamclk);
>  	if (ret) {
> @@ -1350,7 +1350,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_dma;
>  
> -	if (bdev->controlled_remotely) {
> +	if (!bdev->bamclk) {
>  		pm_runtime_disable(&pdev->dev);
>  		return 0;
>  	}
> @@ -1438,10 +1438,10 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
>  {
>  	struct bam_device *bdev = dev_get_drvdata(dev);
>  
> -	if (!bdev->controlled_remotely)
> +	if (bdev->bamclk) {
>  		pm_runtime_force_suspend(dev);
> -
> -	clk_unprepare(bdev->bamclk);
> +		clk_unprepare(bdev->bamclk);
> +	}
>  
>  	return 0;
>  }
> @@ -1451,12 +1451,13 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
>  	struct bam_device *bdev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = clk_prepare(bdev->bamclk);
> -	if (ret)
> -		return ret;
> +	if (bdev->bamclk) {
> +		ret = clk_prepare(bdev->bamclk);
> +		if (ret)
> +			return ret;
>  
> -	if (!bdev->controlled_remotely)
>  		pm_runtime_force_resume(dev);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
