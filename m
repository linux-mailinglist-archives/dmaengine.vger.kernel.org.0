Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766C505029
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiDRMWJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiDRMVb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 08:21:31 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591E1D0DB;
        Mon, 18 Apr 2022 05:17:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bj36so10709323ljb.13;
        Mon, 18 Apr 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kHnbLPTYEwVnYoF1eArZeQYH5Pj76/3G5SiYikVll9w=;
        b=jbpqdZoqwR4D4r4fMKzxzhrBt/Wqgr2sbvztY0dWatowOIRCrjg9R3NdU/WmdFuziD
         EPV8lzAk1E91kiXFQSwW4A/8TaarCt2a7rLv3RRjIQNIjCZRxx0pLMpiRPQ49PYad7Ft
         vdrzmozuDZNDm4wzbIudn/1Fv//fsqBxwSUezyrXVHyRRtwkT/Jdd7L4ZBqphvkQTFXk
         qHGfsfnj9nfgqICnTlQwSg0LpVjTnLSciMjKxjOEhARZvQnps2FuOy6Wx91cL07D0sMy
         lCYDkrLxsSzt4g3tvr8cHW2sATtwaGZYxCtByDEc8vAD0tCq79JWPLgOmeNhJXAks+j1
         meHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHnbLPTYEwVnYoF1eArZeQYH5Pj76/3G5SiYikVll9w=;
        b=KJW8k1QWdgjsq6wwtlon2V+Fhi/yzjdQvRgP+a7YYDrVAnbYq/7bvV+JhbxJW2SeKD
         lB2ycLi3xPdj4s0SwSwMsAumcswESL7zHBGL3wVv6+dA4I78/XtogQ5OkHXQR5cJfp/1
         KGOcH6XtmcP5QdC73eSCPAHRJUZaWPKCkYmKKNNKTMO8M+9WrOkMok6neuV4QjhKHsRB
         42ec0iB1WHBpcnV10+Zh5kju7zR29ChMMVty2+eq2wrL9IG0WfTN1OkaRMBKFp6/IHzR
         wOZXQdOAu3kbbtYMFigCMz9q2/MgkaheSP9zm+EUu2i7kIs16PgCbpO6AZQ0Hfc5c2Bb
         d4Hw==
X-Gm-Message-State: AOAM533W/AcQzeB2lFwyAkINPNza8LJ4Mrenj90RlZo6MggXb6P0j2j9
        xaFLYvOkhdHG0vIzGt7d9Lk=
X-Google-Smtp-Source: ABdhPJwFqvtH3vF5qgEO8VCRMK6W6mZpdiK3/Fns3+bt9EuI/0T5o4DWUcvmcWh5lCU6fMV6W8YuIw==
X-Received: by 2002:a2e:302:0:b0:24a:c997:d34c with SMTP id 2-20020a2e0302000000b0024ac997d34cmr7107060ljd.445.1650284250575;
        Mon, 18 Apr 2022 05:17:30 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id u19-20020a197913000000b00448a1f20261sm1199338lfc.34.2022.04.18.05.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:17:29 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:17:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/25] dmaengine: dw-edma: Replace chip ID number with
 device name
Message-ID: <20220418121727.ct6pyx6jdq46uvq7@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-23-Sergey.Semin@baikalelectronics.ru>
 <20220325100204.GJ4675@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325100204.GJ4675@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 03:32:04PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:33AM +0300, Serge Semin wrote:
> > Using some abstract number as the DW eDMA chip identifier isn't really
> > practical. First of all there can be more than one DW eDMA controller on
> > the platform some of them can be detected as the PCIe end-points, some of
> > them can be embedded into the DW PCIe Root Port/End-point controllers.
> > Seeing some abstract number in for instance IRQ handlers list doesn't give
> > a notion regarding their reference to the particular DMA controller.
> > Secondly current DW eDMA chip id implementation doesn't provide the
> > multi-eDMA platforms support for same reason of possibly having eDMA
> > detected on different system buses. At the same time re-implementing
> > something ida-based won't give much benefits especially seeing the DW eDMA
> > chip ID is only used in the IRQ request procedure. So to speak in order to
> > preserve the code simplicity and get to have the multi-eDMA platforms
> > support let's just use the parental device name to create the DW eDMA
> > controller name.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
> >  drivers/dma/dw-edma/dw-edma-core.h | 2 +-
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
> >  include/linux/dma/edma.h           | 1 -
> >  4 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index dbe1119fd1d2..72a51970bfba 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -970,7 +970,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  	if (!dw->chan)
> >  		return -ENOMEM;
> >  
> > -	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
> > +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
> > +		 dev_name(chip->dev));
> >  
> >  	/* Disable eDMA, only to establish the ideal initial conditions */
> >  	dw_edma_v0_core_off(dw);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 980adb079182..dc25798d4ba9 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -96,7 +96,7 @@ struct dw_edma_irq {
> >  };
> >  
> >  struct dw_edma {
> > -	char				name[20];
> > +	char				name[30];
> 

> I'm not sure if this length is sufficient. Other than this,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

My calculations were based on the prefix+pci-device-name length. For
instance, for the case of the remote eDMA the name length would be
strlen("dw-edma-core:0000:00:00.0") = 25 + 1 (for '\0'). There's even
some room left. Seeing the prefix is always used in the string there
will be at most 16 chars for the unique part of the name. If you
predict it to be greater than that I'll extend the length as you say.

-Sergey

> 
> Thanks,
> Mani
> 
> >  
> >  	struct dma_device		dma;
> >  
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index f530bacfd716..3f9dadc73854 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -222,7 +222,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  
> >  	/* Data structure initialization */
> >  	chip->dev = dev;
> > -	chip->id = pdev->devfn;
> >  
> >  	chip->mf = vsec_data.mf;
> >  	chip->nr_irqs = nr_irqs;
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 5cc87cfdd685..241c5a97ddf4 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -73,7 +73,6 @@ enum dw_edma_map_format {
> >   */
> >  struct dw_edma_chip {
> >  	struct device		*dev;
> > -	int			id;
> >  	int			nr_irqs;
> >  	const struct dw_edma_core_ops   *ops;
> >  	u32			flags;
> > -- 
> > 2.35.1
> > 
