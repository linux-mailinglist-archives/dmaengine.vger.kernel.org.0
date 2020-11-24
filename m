Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8D2C2E66
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgKXRY0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390790AbgKXRY0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:24:26 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FF020659;
        Tue, 24 Nov 2020 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238665;
        bh=JgXj1MKFJyKl99fg+6JMhh3i8AM0HokBcBhP6TkVBVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1S8Rel7MvBfvebL2TBhR7ljJf1HgZxfaBRe0YcVuZNiHyIafpwxbyOkwn03LFqLxb
         WhfgmIhaEdDk8Vb55sh6hy73XjeK2tXvxThfUlvJOq83ZYSfmCGPRSnvK1Zt+K2kS7
         DcMGvOf/q/hOU5hhqc0qSI+QT0x15WAf/kumdgFY=
Date:   Tue, 24 Nov 2020 22:54:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wang Xiaojun <wangxiaojun11@huawei.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: Fix reference count leaks due to
 pm_runtime_get_sync
Message-ID: <20201124172421.GV8403@vkoul-mobl>
References: <20201123135928.2702845-1-wangxiaojun11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123135928.2702845-1-wangxiaojun11@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-11-20, 21:59, Wang Xiaojun wrote:
> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, should decrement the reference
> count before returning the error. So we fixed it by replacing it
> with pm_runtime_resume_and_get.

Peter?

> 
> Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
> ---
>  drivers/dma/ti/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 35d81bd857f1..38af8b596e1c 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2399,7 +2399,7 @@ static int edma_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, ecc);
>  
>  	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm_runtime_get_sync() failed\n");
>  		pm_runtime_disable(dev);
> -- 
> 2.25.1

-- 
~Vinod
