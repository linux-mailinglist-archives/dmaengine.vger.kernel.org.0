Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210B314EDD
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 13:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBIMWO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 07:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBIMWN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 07:22:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9AC061788;
        Tue,  9 Feb 2021 04:21:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v5so25814348lft.13;
        Tue, 09 Feb 2021 04:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZUrnRm9ByTdlWXbkTDbS0P8AFModswyW8/LsEbzkus=;
        b=eaTCAlytmFWgic1C1oLhMBo/YQ7FVrnxh+IeJXxXNz0VJ/oaEUFPhLwCMo70nHOkTk
         h4HjtSGLYcAlY6YKI+jasC77dp7Hpxfx2R8qbXAUy4DxqTnT+KHetVp4hHkKAEFq74Ru
         m/5muDrP5XBtQ9Qjixs2HtcRn/fn3UIJKOjwwYrZO2pcodumNefkfTgO/7/ouGpnEa7J
         qaB55zsWFcSQiOpY/lsTx0xdSlzHfjiUAmRLSpCjjWeUC3/UPSNwccRs8njmcfFFdEHM
         cRF3L9KyGYQIkRNtvHAFXw+uPOEa2ix/lBBt8C3Sh3+g+ryKNT4mZsQrN1ZWW4+YQjWi
         wQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZUrnRm9ByTdlWXbkTDbS0P8AFModswyW8/LsEbzkus=;
        b=p6iRi4UVXoBjmjRshxtdWYGlXqx3N9qL85jeFLo2o7MBYyyoqaP4RhmOAZJL+Ak+iH
         gRsN8kJB6meriy0g+OdzuqOAz4J2oC/YxI54Ke1H1G+AQ2fjb6LEWOm6U/Gca2ljP6O7
         pykyXhT8jStdwdJmiOh8qZ5RHa60OTeioPXZimAKqpNuKhwlv9b4l3EuLPYu7Vk9BsN2
         35nbsK5tujYYD/Gs7gK1teSIm7u5lo65/1OxgMfxX2t/jkEKdy2k9HgTuKp8p0dVMajZ
         8WiThYyjM3FO4kb8QhGlsj/Xk6pwLqOE7rr0mvokUuVOvYfqXHbmLtU7gujhdH3M2arX
         aIlA==
X-Gm-Message-State: AOAM533vnDYWIPwgJFNM2qGn1mpTCVXnLZTGPox+SpzdaTP/qtONgz7D
        E/auraJ1cStAU4eGn4nyAnrQS7IZUKZ4pyOU
X-Google-Smtp-Source: ABdhPJygkihgdAQYaFff8iAgAIL1XqWwQiLsQ2+5StD5fqP4NuHagL9GSgVJpgWUIWKUiJve0O50og==
X-Received: by 2002:ac2:4ecc:: with SMTP id p12mr5754480lfr.373.1612873291395;
        Tue, 09 Feb 2021 04:21:31 -0800 (PST)
Received: from [10.0.0.127] (91-157-86-155.elisa-laajakaista.fi. [91.157.86.155])
        by smtp.gmail.com with ESMTPSA id f1sm517889ljj.124.2021.02.09.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 04:21:30 -0800 (PST)
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210209090036.30832-1-kishon@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error
Message-ID: <19488154-22d5-33b4-06a1-17e9a896ae04@gmail.com>
Date:   Tue, 9 Feb 2021 14:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209090036.30832-1-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kishon,

On 2/9/21 11:00 AM, Kishon Vijay Abraham I wrote:
> bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
> already allocated by checking if it has a NON NULL value. For the
> error cases, bchan/rchan/tchan/rflow will have error value
> and bcdma_get_*() and udma_get_*() considers this as already allocated
> (PASS) since the error values are NON NULL. This results in
> NULL pointer dereference error while de-referencing
> bchan/rchan/tchan/rflow.

I think this can happen when a channel request fails and we get a second
request coming and faces with the not cleanup up tchan/rchan/bchan/rflow
from the previous failure.
Interesting that I have not faced with this, but it is a valid oversight
from me.

> Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
> actually fails.
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")

Will this patch apply at any of these?
25dcb5dd7b7c does not have BCDMA (bchan)
017794739702 does not contain PKTDMA (tflow)

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 298460438bb4..aa4ef583ff83 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1330,6 +1330,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
>  	enum udma_tp_level tpl;
> +	int ret;
>  
>  	if (uc->bchan) {
>  		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
> @@ -1347,8 +1348,11 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>  		tpl = ud->bchan_tpl.levels - 1;
>  
>  	uc->bchan = __udma_reserve_bchan(ud, tpl, -1);
> -	if (IS_ERR(uc->bchan))
> -		return PTR_ERR(uc->bchan);
> +	if (IS_ERR(uc->bchan)) {
> +		ret = PTR_ERR(uc->bchan);
> +		uc->bchan = NULL;
> +		return ret;
> +	}
>  
>  	uc->tchan = uc->bchan;
>  
> @@ -1358,6 +1362,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>  static int udma_get_tchan(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
> +	int ret;
>  
>  	if (uc->tchan) {
>  		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
> @@ -1372,8 +1377,11 @@ static int udma_get_tchan(struct udma_chan *uc)
>  	 */
>  	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
>  					 uc->config.mapped_channel_id);
> -	if (IS_ERR(uc->tchan))
> -		return PTR_ERR(uc->tchan);
> +	if (IS_ERR(uc->tchan)) {
> +		ret = PTR_ERR(uc->tchan);
> +		uc->tchan = NULL;
> +		return ret;
> +	}
>  
>  	if (ud->tflow_cnt) {
>  		int tflow_id;
> @@ -1403,6 +1411,7 @@ static int udma_get_tchan(struct udma_chan *uc)
>  static int udma_get_rchan(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
> +	int ret;
>  
>  	if (uc->rchan) {
>  		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
> @@ -1417,8 +1426,13 @@ static int udma_get_rchan(struct udma_chan *uc)
>  	 */
>  	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
>  					 uc->config.mapped_channel_id);
> +	if (IS_ERR(uc->rchan)) {
> +		ret = PTR_ERR(uc->rchan);
> +		uc->rchan = NULL;
> +		return ret;
> +	}
>  
> -	return PTR_ERR_OR_ZERO(uc->rchan);
> +	return 0;
>  }
>  
>  static int udma_get_chan_pair(struct udma_chan *uc)
> @@ -1472,6 +1486,7 @@ static int udma_get_chan_pair(struct udma_chan *uc)
>  static int udma_get_rflow(struct udma_chan *uc, int flow_id)
>  {
>  	struct udma_dev *ud = uc->ud;
> +	int ret;
>  
>  	if (!uc->rchan) {
>  		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
> @@ -1485,6 +1500,11 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
>  	}
>  
>  	uc->rflow = __udma_get_rflow(ud, flow_id);
> +	if (IS_ERR(uc->rflow)) {
> +		ret = PTR_ERR(uc->rflow);
> +		uc->rflow = NULL;
> +		return ret;
> +	}
>  
>  	return PTR_ERR_OR_ZERO(uc->rflow);

return 0;

>  }
> 

-- 
Péter
