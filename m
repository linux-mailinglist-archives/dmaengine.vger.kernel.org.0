Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07DBBCA50
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbfIXOgD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 10:36:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441388AbfIXOgC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Sep 2019 10:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FAF2KEuVywTXvUEC+UnNSL/cvqImCgZf29SUY3mXs9I=; b=l0zfszDIfgH2fYk+8StPK4gy9
        i3QEb7JKY9NGYQIc2td3Abje5qJna0y8DA7sqMNbackVPyEVkUkSnaY9V+Dmt9ZW86AyFVkySTLN1
        CvSiGGth5ZK5/YO9hBFCZY5DhPL1mep4PzqYCm6EyY9U9TsOoMVIvAYQPUbtxf9iLYAh0z1Igmlad
        OQ9IZlIErdOEvUrqnPBZqtGJb+XEUYWOC2S9xtvgBgFt+ulLRm3FuXPI2NP4vvzFMwC+YXY9pwbO1
        aLnjxakWeD84PJ7KFzGPqbH8+syR7Bm5cVa01HjF2nofuogQYnMCC7U47U+nI0UK2yod00tY50Ubp
        DoGABfyVQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iClv4-00040z-Nc; Tue, 24 Sep 2019 14:35:58 +0000
Subject: Re: [PATCH 1/4] dma: Add PTDMA Engine driver support
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <064f3abe-7d6c-0ab3-1362-61ba6b09840e@infradead.org>
Date:   Tue, 24 Sep 2019 07:35:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/24/19 12:31 AM, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This is the driver for the AMD passthrough DMA Engine
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Rajesh Kumar <Rajesh1.Kumar@amd.com>
> ---

> diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
> new file mode 100644
> index 0000000..a373431
> --- /dev/null
> +++ b/drivers/dma/ptdma/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_PTDMA
> +	tristate  "AMD Passthru DMA Engine"
> +	default m

Can you justify "default m"?  Most likely it should not be here.


> +	depends on X86_64 && PCI
> +	help
> +	  Provides the support for AMD Passthru DMA engine.


-- 
~Randy
