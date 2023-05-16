Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEFE7059AC
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEPVh2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPVh1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 17:37:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E846EB1
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=1zc3dpgq23RpKo9pXqJEUb7/JbZrtaDFZTG/20DfirU=; b=ig9ivryUfxsauWha7JVRLVAshj
        yxUz6TtZcBYlUwqeoqiWKAjcNQRO9rrSTDO5JzHnmd13gHxrRt+efgPqxjg8jRqQUv5Mf06ETtJJ0
        90aytNGNchSUth/y35veR81JkK5qrJmj6r+3N3gU10SbUTJO2KldU0K73ahJT6kj2V0BX0WpmPUVk
        KX7Gyj2cXCrvNTjtxoekBWLLhYKX6APyBXPe4GaPMi6qD3fO+vlJejcHnY8aUpVgJ7D2K+wOHrgsT
        Xb4lkPEl1zvNrSXYK4VMP71LV8Qz0Lf1lNBF5QMf7N5lEQvjLgDx/oJHyX28a4tRe96vwaMov8KxH
        YBgzUBxA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pz2Lj-007C86-1s;
        Tue, 16 May 2023 21:36:51 +0000
Message-ID: <0c2f12c6-51fb-8476-d723-efcb10d9431c@infradead.org>
Date:   Tue, 16 May 2023 14:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dmaengine: ti: k3-udma: annotate pm function with
 __maybe_unused
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
References: <20230516174311.117264-1-vkoul@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230516174311.117264-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/16/23 10:43, Vinod Koul wrote:
> We get a warning when PM is not set:
> 
> ../drivers/dma/ti/k3-udma.c:5552:12: warning: 'udma_pm_resume' defined but not used [-Wunused-function]
>  5552 | static int udma_pm_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> ../drivers/dma/ti/k3-udma.c:5530:12: warning: 'udma_pm_suspend' defined but not used [-Wunused-function]
>  5530 | static int udma_pm_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
> 
> Fix this by annotating pm function with __maybe_unused
> 
> Fixes: fbe05149e40b ("dmaengine: ti: k3-udma: Add system suspend/resume support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/dma/ti/k3-udma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index fc3a2a05ab7b..b8329a23728d 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5527,7 +5527,7 @@ static int udma_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int udma_pm_suspend(struct device *dev)
> +static int __maybe_unused udma_pm_suspend(struct device *dev)
>  {
>  	struct udma_dev *ud = dev_get_drvdata(dev);
>  	struct dma_device *dma_dev = &ud->ddev;
> @@ -5549,7 +5549,7 @@ static int udma_pm_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int udma_pm_resume(struct device *dev)
> +static int __maybe_unused udma_pm_resume(struct device *dev)
>  {
>  	struct udma_dev *ud = dev_get_drvdata(dev);
>  	struct dma_device *dma_dev = &ud->ddev;

-- 
~Randy
