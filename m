Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741A54E2CC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377440AbiFPOAo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377558AbiFPOAZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D34D603;
        Thu, 16 Jun 2022 07:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B645061D26;
        Thu, 16 Jun 2022 14:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2EDC34114;
        Thu, 16 Jun 2022 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655388016;
        bh=EOBTGfp+WecxBEz7UGRzVbgD64FRU7Gj/cdVrBEXhuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPDRxWt7a62G2lTNJQ4aJL8Dyc/IqZz5GsZIeDZDjaRN4Rm5okpad1HqY+LlsDBfS
         a6ZNQFeN9v1vPQgivrfTw/rDjJgOG6XYL9gmxdFq6JW/Rb4NFboo0XROwJU5xc9Lf8
         RshVGGda59/PfYuRtW8qKwIxXLnJeVfrjSfOTlTrSXHjI5snpk053AP8fJ0R6OeS7k
         G8Qu3VqHcNMGEnGlD/qhsclVQAd5X5D0fb2QuJbf0qwm5/YpnBNTZd5AQDp5t2yf6C
         H1FRVaQxt0flzbDsefabSJEeKhvENpjPmIQ9LUU//W6yp6fUIKbHmU5556dPjOgCx9
         5ALKkFHUpZgpA==
Date:   Thu, 16 Jun 2022 07:00:15 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix runtime PM underflow
Message-ID: <Yqs3bypHiAgkg4dp@matsya>
References: <20220609195043.1544625-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609195043.1544625-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-06-22, 20:50, Caleb Connolly wrote:
> When PM runtime is disabled, pm_runtime_get() isn't called, but
> pm_runtime_put() still is. Fix this by creating a matching wrapper
> on pm_runtime_put_autosuspend().
> 
> Fixes: dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 87f6ca1541cf..a36dedee262e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -566,6 +566,14 @@ static int bam_pm_runtime_get_sync(struct device *dev)
>  	return 0;
>  }
>  
> +static int bam_pm_runtime_put_autosuspend(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		return pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}

should we really do a wrapper to fix this ;-) I would think dropping the
get wrapper and calling pm_runtime_get() unconditionally would be
better..?

> +
>  /**
>   * bam_free_chan - Frees dma resources associated with specific channel
>   * @chan: specified channel
> @@ -617,7 +625,7 @@ static void bam_free_chan(struct dma_chan *chan)
>  
>  err:
>  	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>  }
>  
>  /**
> @@ -793,7 +801,7 @@ static int bam_pause(struct dma_chan *chan)
>  	bchan->paused = 1;
>  	spin_unlock_irqrestore(&bchan->vc.lock, flag);
>  	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>  
>  	return 0;
>  }
> @@ -819,7 +827,7 @@ static int bam_resume(struct dma_chan *chan)
>  	bchan->paused = 0;
>  	spin_unlock_irqrestore(&bchan->vc.lock, flag);
>  	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>  
>  	return 0;
>  }
> @@ -936,7 +944,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>  	}
>  
>  	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1111,7 +1119,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>  			bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
>  
>  	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>  }
>  
>  /**
> -- 
> 2.36.1

-- 
~Vinod
