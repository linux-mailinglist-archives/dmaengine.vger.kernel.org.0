Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBF316332
	for <lists+dmaengine@lfdr.de>; Wed, 10 Feb 2021 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBJKGw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 05:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBJKEn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Feb 2021 05:04:43 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03167C061574;
        Wed, 10 Feb 2021 02:03:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b16so1969631lji.13;
        Wed, 10 Feb 2021 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3VLWuGcumJIEYKUve4p4pLDNfyXwCRFQtYj4mS1ZhQ=;
        b=JTC9D+RS8RWP8xzzk189NhTMy5iYBi8w+xVNHNxgYaSez/yf2tj9ENTuGExTiKfik8
         5Dfckra3TVX02yB1CnFaZV4fOjpXDVeowHvPUd5okdLqZ5LSqZe+dB/UfB5vjsjxmmW7
         Mli+T37MXc2X8cuUtoqwOgGjXGGmrjC+4IdchIh6zud6NCdMWtx1OZmkKb+yB1xsXz5d
         1ntW7hy9trHUsBo726d2YZ6oq4ekBDwCuGz9/sdLs9rfdm2hDOyGYwgD2F3y/BtVmIda
         0oiNPAyl98jbE+ouEk/PCayU2KUyLtdZrUSi7RHxRsW0jjXPkTYQhim+Rad5FMymsKiR
         6ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3VLWuGcumJIEYKUve4p4pLDNfyXwCRFQtYj4mS1ZhQ=;
        b=E4S2790xVLHKXRu0aYdAC3dYYUhDqp5mZNS9y723QC3b5PwxnGfDat+xcMJ9LXxqcE
         lqmyHqWzGBEYwwdSK9iuFkYPusRPj5gTdbid9iWbLX+cM2zyjUx1xZWcjV1taAfN75OX
         EMuGC1ZmXldABlBvS++QKmLYz6N0CBvPqUP+4S90S79BCjfnxi1QnKoMsTwUmWRwPjHK
         b1BkVnSbbrWhew63GcU6Rie2JtQ6bU4v/SKZ5KNIsF9JE1BpdnIwGkRqHqzJsi4q3EYl
         9EC9PeVTe8NwbdRVSUg9Ix5//TwvpLUGSknYMy35lEiJtKwi1/YNuI43r1xRlVHp3Wag
         Ek+g==
X-Gm-Message-State: AOAM533TqhOwIvG1qC96YBgaGOz/CRazJvIW/E6opT43fLgk4R8Ak3jp
        YLD6ay7ZWWbEbBfDgAGGHPOd15ZseRMk0PWh
X-Google-Smtp-Source: ABdhPJw3GV4FNMwPYd+v5CB31qUBankNHe+HMk4Y0qlLAnmC0RSHl4PeQUI7iny9yapHi9lj83M0bg==
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr1489543ljn.279.1612951431037;
        Wed, 10 Feb 2021 02:03:51 -0800 (PST)
Received: from [10.0.0.42] (91-157-86-155.elisa-laajakaista.fi. [91.157.86.155])
        by smtp.gmail.com with ESMTPSA id j20sm242986lfu.94.2021.02.10.02.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 02:03:50 -0800 (PST)
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210209120238.9476-1-kishon@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <8e9954cd-53fa-2c7e-2019-9821e5f9d45a@gmail.com>
Date:   Wed, 10 Feb 2021 12:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209120238.9476-1-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kishon,

On 2/9/21 2:02 PM, Kishon Vijay Abraham I wrote:
> bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
> already allocated by checking if it has a NON NULL value. For the
> error cases, bchan/rchan/tchan/rflow will have error value
> and bcdma_get_*() and udma_get_*() considers this as already allocated
> (PASS) since the error values are NON NULL. This results in
> NULL pointer dereference error while de-referencing
> bchan/rchan/tchan/rflow.
> 
> Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
> actually fails.
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Is this the same patch as the other with the similar subject?

-- 
Péter

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
>  }
> 

