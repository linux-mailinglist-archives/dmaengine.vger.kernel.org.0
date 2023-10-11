Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496D7C5064
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 12:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbjJKKlC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 06:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbjJKKk7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 06:40:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E4A7;
        Wed, 11 Oct 2023 03:40:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5031ccf004cso8105135e87.2;
        Wed, 11 Oct 2023 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697020855; x=1697625655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIwLub0INRRdgrIISIRMpvUCD9eeyw981wkAi0ZsffY=;
        b=b9JHr/l5yZOWbtM0htenDtYya+erZmxpwEjq9V1g09/1HHvq82U9KNuUODldNxXU3Z
         PvWyZfjgmxsFtVsh0r7w5QZ0tbxhvQqi6AtrX9eJSBRkH+GMKZfn2rtL96oYnyOvaDSV
         POHUCkaJRdsrAZaOyCWZ2X5wWslHm0AyqI8IcMYLgrA3FiKR2lNQxRztgWz2aRdk5B1c
         unHVsEPX3SXm+9C6caOhUiQDIJuLIowikR3QpjgKjFgBrAZIh5ITwnpROuY2X/s7WjmX
         K8p/uHdZ+Mj2Z6P9YdEVr2qMDarHfAhjnCsy0jEJ1cKFgI/mHkcjw9adofhRrr9mK7o8
         yKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020855; x=1697625655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIwLub0INRRdgrIISIRMpvUCD9eeyw981wkAi0ZsffY=;
        b=Ex/k4MOqttxsdQ3gHYTa0t4Op4mxNi8aaKzcgac25AnobLE77svpAnClvSYNVa/6Rq
         V30Yyn0mQ2msjQ+7wIw8ieDrxpYvFnaBioYPJdaWh7ohOQnQCfDRlB7Ug8UpSYLHe+xS
         scw3cEKWDJp+Gydjsg6dsZtW2LLJaUZfblAtaqsyXLMc+exSjeVTv/PHzRnbo4vQefHK
         DDnS9NRxgnp2wdQqRCgMv58Av7V5y3J0trCAEpq3a/veb1RdVoI1e/1iYrSLSGAkwQAx
         ATIeA5o0R5wAaZ7XsCgJUJIgRI3JMAR6KuQuubt3EzImWoOF3IWkzaf9cS7dL0soT24N
         owuw==
X-Gm-Message-State: AOJu0YxYpe5axx6+PmTWTDYYQB7ZpkR2EeYn9P6b2KkJK8NW01u91U7K
        HbGBFP4cAIUxyKbGtCEhrW4=
X-Google-Smtp-Source: AGHT+IEoHHRIumi6Qc+UuPZifX5OUKY2Y/hEgTETmsyuhl5/tQcdFXRkyRkdXG0q9gZXcwWgIz1GRQ==
X-Received: by 2002:ac2:5f08:0:b0:503:383c:996d with SMTP id 8-20020ac25f08000000b00503383c996dmr15544417lfq.12.1697020854490;
        Wed, 11 Oct 2023 03:40:54 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p7-20020a19f007000000b004ff8631d6c0sm2190574lfc.278.2023.10.11.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:40:54 -0700 (PDT)
Date:   Wed, 11 Oct 2023 13:40:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v3 1/6] dmaengine: dw-edma: Fix the ch_count hdma callback
Message-ID: <blylz7am3w2yi45aaraunjmzhd3prvpvrnsdseuccuprtj4gcv@fdewoi2n54fk>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
 <20231011-b4-feature_hdma_mainline-v3-1-24ee0c979c6f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-b4-feature_hdma_mainline-v3-1-24ee0c979c6f@bootlin.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 11, 2023 at 10:11:40AM +0200, Kory Maincent wrote:
> The current check of ch_en enabled to know the maximum number of available
> hardware channels is wrong as it check the number of ch_en register set
> but all of them are unset at probe. This register is set at the
> dw_hdma_v0_core_start function which is run lately before a DMA transfer.
> 
> The HDMA IP have no way to know the number of hardware channels available
> like the eDMA IP, then let set it to maximum channels and let the platform
> set the right number of channels.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

So no news from Cai... I guess we can accept it as is then.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> 
> See the following thread mail that talk about this issue:
> https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/
> 
> Changes in v2:
> - Add comment
> 
> Changes in v3:
> - Fix comment style.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 00b735a0202a..1f4cb7db5475 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -65,18 +65,12 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  
>  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> -	u32 num_ch = 0;
> -	int id;
> -
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> -			num_ch++;
> -	}
> -
> -	if (num_ch > HDMA_V0_MAX_NR_CH)
> -		num_ch = HDMA_V0_MAX_NR_CH;
> -
> -	return (u16)num_ch;
> +	/*
> +	 * The HDMA IP have no way to know the number of hardware channels
> +	 * available, we set it to maximum channels and let the platform
> +	 * set the right number of channels.
> +	 */
> +	return HDMA_V0_MAX_NR_CH;
>  }
>  
>  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> 
> -- 
> 2.25.1
> 
