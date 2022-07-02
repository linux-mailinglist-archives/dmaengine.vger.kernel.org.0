Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11C563F23
	for <lists+dmaengine@lfdr.de>; Sat,  2 Jul 2022 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiGBItx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 Jul 2022 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiGBItx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 2 Jul 2022 04:49:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79541A061;
        Sat,  2 Jul 2022 01:49:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so4962477wma.4;
        Sat, 02 Jul 2022 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzytIjE57UyjLf5iE8uCuMXiTfnurGpdSiaoc4cIUx8=;
        b=Zn+soKIG6jLILePplWiptlN68bslIlY1l7jNBTAK9UAEKlI7OAwZkT3o7CKgk1ucbW
         r/73trnXdoxyLMq/hZrXPzz/xV+SZF/SYkFGngqyfXx5Sklgv5R0mE1X/Nn1VxR/OH7B
         rQ1L7uHV1w4Nl+2mLsbhlCVYb+lKGueI6CpAvmSyQB/xCacXBY92oiH7yoxar1bRmE+c
         jxdfI/Vfs39RzsgueWQ8g8FalQ/hrWPEeOCSufgEOCnRJb1UMPZ7wwZrVnL79jo2ztz2
         l6f0aSMJBO8F7ra3/Yd7T3/rFKpBg0YGgeX8t7+H/oyg9+lkh2phPsPIhcYTVklTib4y
         K5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzytIjE57UyjLf5iE8uCuMXiTfnurGpdSiaoc4cIUx8=;
        b=PKPRsJPWTLs8zqi32BuAFBISg3DdQ0TyPRCRSzHw02+k76rmmaNJHuyTmQnJPBP1VS
         2wfniTjBEpBXUcGe4OyEz+lZM14bzXF/gJ7KaH7DMI3Lcrc+edqpx1j0i6IpHzlQfKZl
         JE2Cp0j3dq8R5ZPFoVc6mxJ4lSp61gEOUmTlprsZrQzpWOnXkGZ84tyv08Hz+hgPKfXA
         G5lcRPNhaXRBHM+Mq5gp2+AAWm2xZwTTGqAomANZaHNBxkbrN6yOD6vYq5OjFwuFg5Bz
         dmQz80mDhkn9a3P26BPqO5fMGfgOv14EI0xYiLNw/0X/vM/Et/bcfV1r+nhb4KMfPm5O
         svJQ==
X-Gm-Message-State: AJIora83RpXWB30Uheb70MPGuX7HBZi/u2pXcetxnt7rKfL9CIyeDTfd
        KBZJP1/LIROWkX3tfmG4X9E=
X-Google-Smtp-Source: AGRyM1vYexyHDslAdR3Uj1M06vlUti3EEBOSvo+vr6jLnX8vQtjCbcTvfEi7EOARIQG4eONjvWGYCA==
X-Received: by 2002:a1c:2b05:0:b0:3a0:2ae2:5277 with SMTP id r5-20020a1c2b05000000b003a02ae25277mr21097394wmr.30.1656751788410;
        Sat, 02 Jul 2022 01:49:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:1670:c:f4bd:c360:335a:282d:b75f])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b0039c4b518df4sm15904408wmj.5.2022.07.02.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 01:49:48 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix runtime PM underflow
Date:   Sat,  2 Jul 2022 12:48:39 +0400
Message-Id: <20220702084838.13233-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220609195043.1544625-1-caleb.connolly@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yassine Oudjana <yassine.oudjana@gmail.com>

From: Yassine Oudjana <y.oudjana@protonmail.com>

On Thu,  9 Jun 2022 20:50:43 +0100, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
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
> 

Thanks for the fix!

On the Xiaomi Mi Note 2:

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
