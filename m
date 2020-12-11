Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A459F2D76AA
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgLKNgI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 08:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgLKNf4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 08:35:56 -0500
Date:   Fri, 11 Dec 2020 19:05:11 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607693715;
        bh=H2HDn/4ODMQ7N3rADQe9snH03Jqg99rVKMRq8H5MqVc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIJs96x2TRHoGyF6ygLdIXuAcL2k9Yio1o4fZsCyAe0SXuQv17vq4Re2znBGyiNFf
         4M6MFVDcP1IGSPYAvKwc6b2Y1eOSy5VJK2bTgmcpilb79HXJNE+U0aoWdRA4l+ZZ8G
         10x7shR+H3l6FOnFrdf/okMlSPAkJpx/mqRDwr1Z0YSi+8TKEo+8iiuO+0L4ttSmas
         PoAOSSNAjWaOIvDWE424vDN1mWIxH/l+1kmXE+BY85IvGeKPUCHdxPtgW36DjMuk4k
         oKWAJtofIRHoePSOw4mnWvB0bRGOwufcXcrqvAXspYsyTE5ao8Lp+L1o6vksok4TC3
         xsWQ1gL44CtTg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Wang Xiaojun <wangxiaojun11@huawei.com>, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: Fix reference count leaks due to
 pm_runtime_get_sync
Message-ID: <20201211133511.GT8403@vkoul-mobl>
References: <20201123135928.2702845-1-wangxiaojun11@huawei.com>
 <20201124172421.GV8403@vkoul-mobl>
 <a8ccf849-35f3-87c2-96bc-c3e3b6e76a11@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8ccf849-35f3-87c2-96bc-c3e3b6e76a11@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-11-20, 08:36, Peter Ujfalusi wrote:
> 
> 
> On 24/11/2020 19.24, Vinod Koul wrote:
> > On 23-11-20, 21:59, Wang Xiaojun wrote:
> >> On calling pm_runtime_get_sync() the reference count of the device
> >> is incremented. In case of failure, should decrement the reference
> >> count before returning the error. So we fixed it by replacing it
> >> with pm_runtime_resume_and_get.
> > 
> > Peter?
> 
> Looks good.
> 
> fwiw, the pm_runtime_resume_and_get() landed in mainline with v5.10-rc5,
> so it is fresh, but what it does is legit.

So I cant apply this patch, please rebase and resend after -rc1, with
Peter's ack

> 
> Wang: thank you for the patch.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> > 
> >>
> >> Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
> >> ---
> >>  drivers/dma/ti/edma.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> >> index 35d81bd857f1..38af8b596e1c 100644
> >> --- a/drivers/dma/ti/edma.c
> >> +++ b/drivers/dma/ti/edma.c
> >> @@ -2399,7 +2399,7 @@ static int edma_probe(struct platform_device *pdev)
> >>  	platform_set_drvdata(pdev, ecc);
> >>  
> >>  	pm_runtime_enable(dev);
> >> -	ret = pm_runtime_get_sync(dev);
> >> +	ret = pm_runtime_resume_and_get(dev);
> >>  	if (ret < 0) {
> >>  		dev_err(dev, "pm_runtime_get_sync() failed\n");
> >>  		pm_runtime_disable(dev);
> >> -- 
> >> 2.25.1
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
