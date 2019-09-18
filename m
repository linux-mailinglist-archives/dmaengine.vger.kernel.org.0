Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC82B616B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfIRK2Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 06:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfIRK2Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Sep 2019 06:28:24 -0400
Received: from localhost (unknown [122.178.229.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295DB205F4;
        Wed, 18 Sep 2019 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568802503;
        bh=NU/XZq0YjEUS1CaZjiEgjV/Mv/zFt98RSp0oEKn6bpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlpbDhJc/XVCrrvg80yx1mZCdGbXBOUYMa6om5ZKj5YNXWraiyble4+RQQF+k50ac
         Fivo3B1hhAenmy4QvJ2sGPlVggOT300c09DPVsaXnDC51oj3rHZCq1BaRSqn6mJyGJ
         fwADBKoOoMi18cBYp4pLnmel2LVxaTHjcDaV/P6U=
Date:   Wed, 18 Sep 2019 15:57:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     dan.j.williams@intel.com, jun.nie@linaro.org, shawnguo@kernel.org,
        agross@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, wens@csie.org, lars@metafoo.de,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, satendrasingh.thakur@hcl.com
Subject: Re: [PATCH 0/9] added helper macros to remove duplicate code from
 probe functions of the platform drivers
Message-ID: <20190918102715.GO4392@vkoul-mobl>
References: <20190915070003.21260-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915070003.21260-1-sst2005@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-19, 12:30, Satendra Singh Thakur wrote:
> 1. For most of the platform drivers's probe include following steps
> 
> -memory allocation for driver's private structure
> -getting io resources
> -io remapping resources
> -getting irq number
> -registering irq
> -setting driver's private data
> -getting clock
> -preparing and enabling clock

And we have perfect set of APIs for these tasks!

> 2. We have defined a set of macros to combine some or all of
> the above mentioned steps. This will remove redundant/duplicate
> code in drivers' probe functions of platform drivers.

Why, how does it help and you do realize it also introduces bugs

> devm_platform_probe_helper(pdev, priv, clk_name);
> devm_platform_probe_helper_clk(pdev, priv, clk_name);
> devm_platform_probe_helper_irq(pdev, priv, clk_name,
> irq_hndlr, irq_flags, irq_name, irq_devid);
> devm_platform_probe_helper_all(pdev, priv, clk_name,
> irq_hndlr, irq_flags, irq_name, irq_devid);
> devm_platform_probe_helper_all_data(pdev, priv, clk_name,
> irq_hndlr, irq_flags, irq_name, irq_devid);
> 
> 3. Code is made devres compatible (wherever required)
> The functions: clk_get, request_irq, kzalloc, platform_get_resource
> are replaced with their devm_* counterparts.

We already have devres APIs for people to use!
> 
> 4. Few bugs are also fixed.

Which ones..?

> 
> Satendra Singh Thakur (9):
>   probe/dma : added helper macros to remove redundant/duplicate code
>     from probe functions of the dma controller drivers
>   probe/dma/jz4740: removed redundant code from jz4740 dma controller's 
>        probe function
>   probe/dma/zx: removed redundant code from zx dma controller's probe
>     function
>   probe/dma/qcom-bam: removed redundant code from qcom bam dma
>     controller's probe function
>   probe/dma/mtk-hs: removed redundant code from mediatek hs dma
>     controller's probe function
>   probe/dma/sun6i: removed redundant code from sun6i dma controller's
>     probe function
>   probe/dma/sun4i: removed redundant code from sun4i dma controller's
>     probe function
>   probe/dma/axi: removed redundant code from axi dma controller's probe
>     function
>   probe/dma/owl: removed redundant code from owl dma controller's probe
>     function
> 
>  drivers/dma/dma-axi-dmac.c       |  28 ++---
>  drivers/dma/dma-jz4740.c         |  33 +++---
>  drivers/dma/mediatek/mtk-hsdma.c |  38 +++----
>  drivers/dma/owl-dma.c            |  29 ++---
>  drivers/dma/qcom/bam_dma.c       |  71 +++++-------
>  drivers/dma/sun4i-dma.c          |  30 ++----
>  drivers/dma/sun6i-dma.c          |  30 ++----
>  drivers/dma/zx_dma.c             |  35 ++----
>  include/linux/probe-helper.h     | 179 +++++++++++++++++++++++++++++++
>  9 files changed, 280 insertions(+), 193 deletions(-)
>  create mode 100644 include/linux/probe-helper.h
> 
> -- 
> 2.17.1

-- 
~Vinod
