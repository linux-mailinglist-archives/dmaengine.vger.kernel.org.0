Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102AA505C17
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346056AbiDRP7b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiDRP70 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 11:59:26 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267242E7;
        Mon, 18 Apr 2022 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=vC0Ih9le+ufoyxFprP99+GQ0JyIb9kJyMO1mXKJWmYQ=; b=O7SWBeNJrTuZVjyru9nyZRnBOe
        22lwd7QeTzfHJA2QCmrdsDoma3MD9W/MoeQSd+uvgy6Xr484pvDd0tl3ualGpFtux1LAjYD76p02m
        3ntUCfY3URytlDVrXSIKtpKrt9YpYfsAStJh/3L3BJrhZbg7W+hlDyEoHTIfqxPqny6qACytsYxgs
        daN82zJzOqLoeOvrWU28bzXA3Lk0FlwvhCkbi0UZ0Gf2A6Fbn4b5ZlQ5n2hZu3uLz7TZl/3SZJIix
        QwKgzC8H1UtmZnhxB+0zciw2LmBLKhbqt7IHcoEWIHDzHusSTRzzVSjgGjYAyPHSc0/pPOvTQ7+ot
        H9y5yYEA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ngThm-00Aldv-Sx; Mon, 18 Apr 2022 09:54:25 -0600
Message-ID: <f66e3fc3-ddf8-3223-f94c-dd98e1648a56@deltatee.com>
Date:   Mon, 18 Apr 2022 09:54:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Yunbo Yu <yuyunbo519@gmail.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220418142021.1241558-1-yuyunbo519@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220418142021.1241558-1-yuyunbo519@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yuyunbo519@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2022-04-18 08:20, Yunbo Yu wrote:
> It is unnecessary to call spin_lock_bh() for you are already in a tasklet.
> 
> Signed-off-by: Yunbo Yu <yuyunbo519@gmail.com>

Ah, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/dma/plx_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 1ffcb5ca9788..12725fa1655f 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -137,7 +137,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
>  	struct plx_dma_desc *desc;
>  	u32 flags;
>  
> -	spin_lock_bh(&plxdev->ring_lock);
> +	spin_lock(&plxdev->ring_lock);
>  
>  	while (plxdev->tail != plxdev->head) {
>  		desc = plx_dma_get_desc(plxdev, plxdev->tail);
> @@ -165,7 +165,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
>  		plxdev->tail++;
>  	}
>  
> -	spin_unlock_bh(&plxdev->ring_lock);
> +	spin_unlock(&plxdev->ring_lock);
>  }
>  
>  static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
