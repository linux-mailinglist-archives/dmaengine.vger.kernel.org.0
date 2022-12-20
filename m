Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA76524AB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Dec 2022 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiLTQft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Dec 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTQfs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Dec 2022 11:35:48 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416ECE2;
        Tue, 20 Dec 2022 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=X0gMC66yAM1WCttF9nywv1Rf8Fk/yP6MzkrnIjOEB1A=; b=nAFnTlbuGJayuJui/tlPii109S
        mBQEJHVd87OVAyvlvx0AO3vUgwBKAhb9y2tbuzpsLh1ZrbL+mjNhKCbTJ02NQenzGWUQviLSsm4nZ
        LgJ5CQxikz0/XZFigfwtPbf0zS+APceZ9JPD1EZbHp+6JFhWjABOPO4FkKQ4f3pS22s10ueFpFW4P
        cuivc6JhZdQWnY2O93v3I8kcj0pHce0+45MjfdyThbQSjzDha0E5SaSyOe7ucqoiBEPKQIjYhBAmv
        sEdBmMdTgELgtafmPsmRAFyKbtv7cbbVLnhk2EYxHaAHeusrnr0xtEibjcN9XhPIcgQag8sW4RQLB
        Ck9Zp6vQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p7fad-00D1UD-Qh; Tue, 20 Dec 2022 09:35:40 -0700
Message-ID: <31659f35-453e-2a5a-2f93-e35ef1395ad7@deltatee.com>
Date:   Tue, 20 Dec 2022 09:35:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To:     Miaoqian Lin <linmq006@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221220061752.1120381-1-linmq006@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221220061752.1120381-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linmq006@gmail.com, vkoul@kernel.org, error27@gmail.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential double free in
 plx_dma_create
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2022-12-19 23:17, Miaoqian Lin wrote:
> When all references are dropped, callback function plx_dma_release()
> for put_device() will call kfree(plxdev) to release memory.
> Fix the error path to fix the possible double free.
>
> Fixes: 07503e6aefe4 ("dmaengine: plx_dma: add a missing put_device() on error path")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Please correct me if I make mistakes, thanks for your review.
> ---
>  drivers/dma/plx_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 12725fa1655f..bce724ff4e16 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -546,8 +546,9 @@ static int plx_dma_create(struct pci_dev *pdev)
>  	return 0;
>  
>  put_device:
> -	put_device(&pdev->dev);
>  	free_irq(pci_irq_vector(pdev, 0),  plxdev);
> +	put_device(&pdev->dev);
> +	return rc;
>  free_plx:
>  	kfree(plxdev);
>  


Sorry, after reviewing, I don't think this patch is correct.

plx_dma_release() is called from dma_async_device_unregister() which
won't be called if dma_async_device_register() fails. It does not get
freed when the pci device is put. So I don't think this is a possible
double free.

Logan

