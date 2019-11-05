Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB753F0398
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfKEQ7T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 11:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfKEQ7S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Nov 2019 11:59:18 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D34021A4A;
        Tue,  5 Nov 2019 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973158;
        bh=itwzwaA2ErwVFDiuv4xl5wSZcNBirWKCcH6Avyv9N4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDUDBCjsItEUpV5Gqb29mUUO5bG1m8ZfXTJp3VzatnORLr8ABr+EiIKbBSckn5Cxn
         5rgrW0vvyGqbV92OeJVZ05R70IMP46UAC5KV2Cm6goJyMcIO9ZZNYoNkxsnvjPWa8f
         ew+q4NkTJylfxWZ5JOcDcM+0py0xE3dqA3YBTueE=
Date:   Tue, 5 Nov 2019 22:29:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/mediatek-hs/probe: Fixed a memory leak when
 devm_request_irq fails
Message-ID: <20191105165914.GD952516@vkoul-mobl>
References: <20191024044320.1097-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024044320.1097-1-sst2005@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-10-19, 10:13, Satendra Singh Thakur wrote:
> When devm_request_irq fails, currently, the function
> dma_async_device_unregister gets called. This doesn't free
> the resources allocated by of_dma_controller_register.
> Therefore, we have called of_dma_controller_free for this purpose.

Please revise this one as well!

> 
> Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
> ---
>  drivers/dma/mediatek/mtk-hsdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
> index 1a2028e1c29e..4c58da742143 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -997,7 +997,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"request_irq failed with err %d\n", err);
> -		goto err_unregister;
> +		goto err_free;
>  	}
>  
>  	platform_set_drvdata(pdev, hsdma);
> @@ -1006,6 +1006,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_free:
> +	of_dma_controller_free(pdev->dev.of_node);
>  err_unregister:
>  	dma_async_device_unregister(dd);
>  
> -- 
> 2.17.1

-- 
~Vinod
