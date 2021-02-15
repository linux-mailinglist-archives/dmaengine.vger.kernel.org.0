Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCE31B99D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Feb 2021 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBOMrH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Feb 2021 07:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBOMqv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Feb 2021 07:46:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DAC061574;
        Mon, 15 Feb 2021 04:46:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so3861212pjs.4;
        Mon, 15 Feb 2021 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tpKOjECKpOtHme7hTyZ6AoF7zfRzL7XWvnsYJ50h+DQ=;
        b=PcuhtkMmvknOCma1yUD3fy4Z7ELVzKFqe3kH4V3qJKZgXprT2zQ4kVw2/EVzofsQsR
         E6rZSZqbPM0GYsU4nYcmxe3cSiYl7nosd8Bsi89EJV9CGqDQqLV2nXi3KLHhMh3EXaBr
         T35bmtHK/1u59qohsnfvAdoslE5ZbiG4uEGzdX6iaEGg77ndEt1jdZhoBqdiRErkStwu
         fu0WLZnLNkTTwKP2nxtdA5iEkXAPpxcFMId0e5AC1M3Lw/AjMw1TPwQXR3abLAPKOlx9
         vB181nL6DhfkFf0CcqMMdNXYs+8M8HfBZLPFPEv9aLLJDuaZx3C91uDYbpba2jC/XCbY
         Go/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpKOjECKpOtHme7hTyZ6AoF7zfRzL7XWvnsYJ50h+DQ=;
        b=dx50QO5NFdsGwenyU4LyDfpC6BC97EjqAztk8Aor09S4r9oIKDaNzfmoCrBKnEVaIa
         aDrc++hi9sDrEhgBj0xBP48qXhB7aWyvaIfYv9jElNymfB/cBSmghNKHvvgGC6Sbbx2a
         iHFk3RPJdn1NpbAleom5S5TaUCxNLcn4WMy7tfTkGQOloQVZ3de4p9lcSaixWursGGsy
         wf0lPzAPekZqSczkiW4l5Yt1PcVx1u/+JGvAYX9ex33vHWjbFszMAUxmQRLSG5QnDGBd
         bt9tVH7hwMxgwIxxl4oSpCyQ1UudwxDsGJBRNYbYi4hldzET9gi6UnFb9QwYfF274qop
         DF9w==
X-Gm-Message-State: AOAM533khG0BJVmy/5Db9uwbDtmNW1x3WTocYOKygZaOmFnFOufnLegV
        BGHmagEN9EywOseWJNzw6kA=
X-Google-Smtp-Source: ABdhPJwtDvV64bvx/ndy1IPs3xAFXlf5VvxXLYQOQcgv8A4YMVndF4nFZAtTjLpxU1MnRJODDd4hFg==
X-Received: by 2002:a17:903:230f:b029:dc:9b7f:bd0e with SMTP id d15-20020a170903230fb02900dc9b7fbd0emr15132847plh.47.1613393169564;
        Mon, 15 Feb 2021 04:46:09 -0800 (PST)
Received: from localhost (89.208.244.53.16clouds.com. [89.208.244.53])
        by smtp.gmail.com with ESMTPSA id q196sm19863561pfc.162.2021.02.15.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:46:09 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:46:06 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "ftoth@exalondelft.nl" <ftoth@exalondelft.nl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dmaengine: dw-edma: Add missing call to
 'pci_free_irq_vectors()' in probe function
Message-ID: <20210215124606.GC618076@nuc8i5>
References: <20210214132153.575350-1-zhengdejin5@gmail.com>
 <20210214132153.575350-3-zhengdejin5@gmail.com>
 <DM5PR12MB18357590D1A8C22A1E7287BCDA889@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18357590D1A8C22A1E7287BCDA889@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 15, 2021 at 09:45:07AM +0000, Gustavo Pimentel wrote:
> On Sun, Feb 14, 2021 at 13:21:52, Dejin Zheng <zhengdejin5@gmail.com> 
> wrote:
> 
> > Call to 'pci_free_irq_vectors()' is missing in the error handling path
> > of the probe function, So add it.
> > 
> > Fixes: 41aaff2a2ac01c5 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 1eafc602e17e..c1e796bd3ee9 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -185,24 +185,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	/* Validating if PCI interrupts were enabled */
> >  	if (!pci_dev_msi_enabled(pdev)) {
> >  		pci_err(pdev, "enable interrupt failed\n");
> > -		return -EPERM;
> > +		err = -EPERM;
> > +		goto err_free_irq;
> >  	}
> >  
> >  	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> > -	if (!dw->irq)
> > -		return -ENOMEM;
> > +	if (!dw->irq) {
> > +		err = -ENOMEM;
> > +		goto err_free_irq;
> > +	}
> >  
> >  	/* Starting eDMA driver */
> >  	err = dw_edma_probe(chip);
> >  	if (err) {
> >  		pci_err(pdev, "eDMA probe failed\n");
> > -		return err;
> > +		goto err_free_irq;
> >  	}
> >  
> >  	/* Saving data structure reference */
> >  	pci_set_drvdata(pdev, chip);
> >  
> >  	return 0;
> > +
> > +err_free_irq:
> > +	pci_free_irq_vectors(pdev);
> > +	return err;
> >  }
> >  
> >  static void dw_edma_pcie_remove(struct pci_dev *pdev)
> > -- 
> > 2.25.0
> 
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
>
Gustavo, Thanks!

Dejin
