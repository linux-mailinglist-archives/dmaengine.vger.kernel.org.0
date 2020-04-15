Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C321AACCE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410087AbgDOQCY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410085AbgDOQCV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:02:21 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F9A21582;
        Wed, 15 Apr 2020 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966540;
        bh=e3d4LUjp8nYLchPlf9MGqps5m3topJNlB0bFbA2lpoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0teLUfV64vmTzBzSuqWQrtjIleMYu4aKKQaY7nH+Dle1urcf3gjhUaqvaaO+0Akwu
         22j8/YCtvQqVbBbZOCYgnNo6n+R9CCrezf1p54hbCerhAs4jnb6DbI6VnOHruF3nNf
         K47Jkdq1hxgAp52gsPMGfdi4IDMG/3cP8RQBDJZw=
Date:   Wed, 15 Apr 2020 21:32:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: hisilicon: fix PCI_MSI dependency
Message-ID: <20200415160212.GW72691@vkoul-mobl>
References: <20200408200559.4124238-1-arnd@arndb.de>
 <5E8E8104.5060307@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E8E8104.5060307@hisilicon.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-04-20, 09:57, Zhou Wang wrote:
> On 2020/4/9 4:05, Arnd Bergmann wrote:
> > The dependency is phrased incorrectly, so on arm64, it is possible
> > to build with CONFIG_PCI disabled, resulting a build failure:
> > 
> > drivers/dma/hisi_dma.c: In function 'hisi_dma_free_irq_vectors':
> > drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'pci_alloc_irq_vectors'? [-Werror=implicit-function-declaration]
> >   138 |  pci_free_irq_vectors(data);
> >       |  ^~~~~~~~~~~~~~~~~~~~
> >       |  pci_alloc_irq_vectors
> > drivers/dma/hisi_dma.c: At top level:
> > drivers/dma/hisi_dma.c:605:1: warning: data definition has no type or storage class
> >   605 | module_pci_driver(hisi_dma_pci_driver);
> >       | ^~~~~~~~~~~~~~~~~
> > drivers/dma/hisi_dma.c:605:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
> > drivers/dma/hisi_dma.c:605:1: warning: parameter names (without types) in function declaration
> > drivers/dma/hisi_dma.c:599:26: error: 'hisi_dma_pci_driver' defined but not used [-Werror=unused-variable]
> >   599 | static struct pci_driver hisi_dma_pci_driver = {
> > 
> > Change it so we always depend on PCI_MSI, even on ARM64
> > 
> > Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/dma/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 98ae15c82a30..c19e25b140c5 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -241,7 +241,8 @@ config FSL_RAID
> >  
> >  config HISI_DMA
> >  	tristate "HiSilicon DMA Engine support"
> > -	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
> > +	depends on ARM64 || COMPILE_TEST
> > +	depends on PCI_MSI
> >  	select DMA_ENGINE
> >  	select DMA_VIRTUAL_CHANNELS
> >  	help
> > 
> 
> Hi Arnd,
> 
> There was a fix from Haibing: https://lkml.org/lkml/2020/3/28/158
> Maybe Vinod will review and take it later :)

It should be in -next tomorrow :)


-- 
~Vinod
