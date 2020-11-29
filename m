Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D52C7A91
	for <lists+dmaengine@lfdr.de>; Sun, 29 Nov 2020 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2SZG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Nov 2020 13:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgK2SZG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Nov 2020 13:25:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FCFC0613CF;
        Sun, 29 Nov 2020 10:24:25 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id m16so12201827edr.3;
        Sun, 29 Nov 2020 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+TaHdEkXgCN7CkQQ251SzNfRN/Dkm6ksvaE3LxK1LzI=;
        b=bh0AQJXBSiA1fclqsj04XWp10nlZW3rQzm2mlHEK+u9ZlMBldHI9IV7PXYBkyWVb7h
         2i8/H4EIcd3GCzU0Xo0NvEOzlGFd5FJWC20SDHDmRDrNenCO0l6RduZ5gOASwPfiVn30
         29C8bGSIO5XiXfvMRfS2wtXww+KVY4sPRvIOeQW/pfsY+o+6MvQ2XyhF8WhLY9dt6316
         FCv3yjyNFu7q8iPE5Ax0nDU+3whXo+72UE8c8jlIBbCVz85I9Xvl7r7gNqh0oJ5kCVVJ
         8TeOuVoZgT3kzDTMOCcUFdjgtTVqjAY1VuvVunwOEj54AdzPzA6ei1EBR1Eu3MDQOjVE
         htaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TaHdEkXgCN7CkQQ251SzNfRN/Dkm6ksvaE3LxK1LzI=;
        b=W9VIRB5gnmFhXmvQtMIsUPsV4Q8l8dI1BoKrf4E6ssS6VxDFEbYVa4Ifjn/wGPn/7u
         tyn6147IFvRUnjs9B/4mE3nxMk9aenv5M2on55E9mXZgEBqcRee2Y99fiLg4wyO7ZIDg
         1B9w027YdluNp6cI/Z045BMdiio1cKjefMEhc6gCmEcDvQsWeA505GxFnEmmt9D5MjHN
         4ftgrQTYCUK+yVwg3ShBibO2UaTDXY5duJIydX27SPNnp5hnuR8wSLLYYRjck4EcRbk+
         ywdck1ZaGA5ye7SJjyUPH4iNKV3ij2vVcnNbThKRrCW4rPE9GQMfqelFneOZVJAiN92l
         5ToA==
X-Gm-Message-State: AOAM5334FVeaPGomldRPGSKcvqtLBzGrQM7nrUfj+dycJPjnlEiCnj4c
        MXvbSoTzd+5aG35ZXbvcuW66FN/Dqvc=
X-Google-Smtp-Source: ABdhPJzQPimJ/g3YVN+L+ev4PqPO1ywE7NRbKa2WC+6fa6XWlkqPDvydKX8AsN3kFf0HE0y8mTOyJQ==
X-Received: by 2002:a50:f082:: with SMTP id v2mr12973840edl.276.1606674264456;
        Sun, 29 Nov 2020 10:24:24 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id s15sm8145744edj.75.2020.11.29.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 10:24:23 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:24:21 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] dmaengine: owl: Add compatible for the Actions
 Semi S500 DMA controller
Message-ID: <20201129182421.GD696261@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <f2e9f718eb8c7279127086795a4ef5047fc186d5.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128073045.GU3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128073045.GU3077@thinkpad>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 28, 2020 at 01:00:45PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:55:59AM +0200, Cristian Ciocaltea wrote:
> > The DMA controller present on the Actions Semi S500 SoC is compatible
> > with the S900 variant, so add it to the list of devices supported by
> > the Actions Semi Owl DMA driver.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> I hope that you have verified both Memcpy and Slave transfers...

I have been using 'dmatest' module as documented in:
https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html

I tested all the available channels and could not find any signs of
possible issues. Bellow is an excerpt from the kernel ring buffer:

[ 2661.884680] dmatest: dma0chan1-copy0: summary 300 tests, 0 failures 1653.48 iops 13249 KB/s (0)
[ 2661.886567] dmatest: dma0chan2-copy0: summary 300 tests, 0 failures 1684.40 iops 12846 KB/s (0)
[ 2661.888448] dmatest: dma0chan3-copy0: summary 300 tests, 0 failures 1730.62 iops 13648 KB/s (0)

Should I perform some additional tests?

Thanks,
Cristi

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/dma/owl-dma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> > index 9fede32641e9..54e509de66e2 100644
> > --- a/drivers/dma/owl-dma.c
> > +++ b/drivers/dma/owl-dma.c
> > @@ -1082,6 +1082,7 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
> >  static const struct of_device_id owl_dma_match[] = {
> >  	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
> >  	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
> > +	{ .compatible = "actions,s500-dma", .data = (void *)S900_DMA,},
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, owl_dma_match);
> > -- 
> > 2.29.2
> > 
