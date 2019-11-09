Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA1F60B8
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2019 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfKIRfS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Nov 2019 12:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfKIRfR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 9 Nov 2019 12:35:17 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E5C214E0;
        Sat,  9 Nov 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573320916;
        bh=gL/KQPz+gQmcS/VMXT/LpaDh+/VadbWGI073t1v+E3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtSxM+2lpCf6P3un7pa5zq5Oh6YK7IdtYz1sAtvifBADJaMmZilFPtrKa/zBiIVKJ
         oQ730Qa7WjFulOU00pyCFzbpAmdTmSG3rUOI47Mo8IstZFOoKqp5s65NGyy4LHU9Hy
         0M5hlFXnWVo7VVVrqjWFFZ3J+NbHNTtx/wjSF3kA=
Date:   Sat, 9 Nov 2019 23:05:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI
 driver skeleton
Message-ID: <20191109173510.GG952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022214616.7943-4-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-10-19, 15:46, Logan Gunthorpe wrote:
> Some PLX Switches can expose DMA engines via extra PCI functions
> on the upstream port. Each function will have one DMA channel.
> 
> This patch is just the core PCI driver skeleton and dma
> engine registration.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS           |   5 +
>  drivers/dma/Kconfig   |   9 ++
>  drivers/dma/Makefile  |   1 +
>  drivers/dma/plx_dma.c | 209 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/dma/plx_dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e51a68bf8ca8..07edc1ead75d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12952,6 +12952,11 @@ S:	Maintained
>  F:	drivers/iio/chemical/pms7003.c
>  F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
>  
> +PLX DMA DRIVER
> +M:	Logan Gunthorpe <logang@deltatee.com>
> +S:	Maintained
> +F:	drivers/dma/plx_dma.c
> +
>  PMBUS HARDWARE MONITORING DRIVERS
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 7af874b69ffb..156f6e8f61f1 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -477,6 +477,15 @@ config PXA_DMA
>  	  16 to 32 channels for peripheral to memory or memory to memory
>  	  transfers.
>  
> +config PLX_DMA
> +	tristate "PLX ExpressLane PEX Switch DMA Engine Support"
> +	depends on PCI
> +	select DMA_ENGINE
> +	help
> +	  Some PLX ExpressLane PCI Switches support additional DMA engines.
> +	  These are exposed via extra functions on the switch's
> +	  upstream port. Each function exposes one DMA channel.
> +
>  config SIRF_DMA
>  	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
>  	depends on ARCH_SIRF
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f5ce8665e944..ce03135c47fd 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>  obj-$(CONFIG_OWL_DMA) += owl-dma.o
>  obj-$(CONFIG_PCH_DMA) += pch_dma.o
>  obj-$(CONFIG_PL330_DMA) += pl330.o
> +obj-$(CONFIG_PLX_DMA) += plx_dma.o
>  obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
>  obj-$(CONFIG_PXA_DMA) += pxa_dma.o
>  obj-$(CONFIG_RENESAS_DMA) += sh/
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> new file mode 100644
> index 000000000000..8668dad790b6
> --- /dev/null
> +++ b/drivers/dma/plx_dma.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microsemi Switchtec(tm) PCIe Management Driver
> + * Copyright (c) 2019, Logan Gunthorpe <logang@deltatee.com>
> + * Copyright (c) 2019, GigaIO Networks, Inc
> + */
> +
> +#include "dmaengine.h"
> +
> +#include <linux/dmaengine.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +MODULE_DESCRIPTION("PLX ExpressLane PEX PCI Switch DMA Engine");
> +MODULE_VERSION("0.1");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Logan Gunthorpe");
> +
> +struct plx_dma_dev {
> +	struct dma_device dma_dev;
> +	struct dma_chan dma_chan;
> +	void __iomem *bar;
> +
> +	struct kref ref;
> +	struct work_struct release_work;
> +};
> +
> +static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
> +{
> +	return container_of(c, struct plx_dma_dev, dma_chan);
> +}
> +
> +static irqreturn_t plx_dma_isr(int irq, void *devid)
> +{
> +	return IRQ_HANDLED;

??

> +}
> +
> +static void plx_dma_release_work(struct work_struct *work)
> +{
> +	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
> +						  release_work);
> +
> +	dma_async_device_unregister(&plxdev->dma_dev);
> +	put_device(plxdev->dma_dev.dev);
> +	kfree(plxdev);
> +}
> +
> +static void plx_dma_release(struct kref *ref)
> +{
> +	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
> +
> +	/*
> +	 * The dmaengine reference counting and locking is a bit of a
> +	 * mess so we have to work around it a bit here. We might put
> +	 * the reference while the dmaengine holds the dma_list_mutex
> +	 * which means we can't call dma_async_device_unregister() directly
> +	 * here and it must be delayed.

why is that, i have not heard any complaints about locking, can you
elaborate on why you need to do this?

> +	 */
> +	schedule_work(&plxdev->release_work);
> +}
> +
> +static void plx_dma_put(struct plx_dma_dev *plxdev)
> +{
> +	kref_put(&plxdev->ref, plx_dma_release);
> +}
> +
> +static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
> +
> +	kref_get(&plxdev->ref);

why do you need to do this?

> +
> +	return 0;
> +}
> +
> +static void plx_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
> +
> +	plx_dma_put(plxdev);
> +}
> +
> +static int plx_dma_create(struct pci_dev *pdev)
> +{
> +	struct plx_dma_dev *plxdev;
> +	struct dma_device *dma;
> +	struct dma_chan *chan;
> +	int rc;
> +
> +	plxdev = kzalloc(sizeof(*plxdev), GFP_KERNEL);
> +	if (!plxdev)
> +		return -ENOMEM;
> +
> +	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> +			 KBUILD_MODNAME, plxdev);
> +	if (rc) {
> +		kfree(plxdev);
> +		return rc;
> +	}
> +
> +	kref_init(&plxdev->ref);
> +	INIT_WORK(&plxdev->release_work, plx_dma_release_work);
> +
> +	plxdev->bar = pcim_iomap_table(pdev)[0];
> +
> +	dma = &plxdev->dma_dev;
> +	dma->chancnt = 1;
> +	INIT_LIST_HEAD(&dma->channels);
> +	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
> +	dma->dev = get_device(&pdev->dev);
> +
> +	dma->device_alloc_chan_resources = plx_dma_alloc_chan_resources;
> +	dma->device_free_chan_resources = plx_dma_free_chan_resources;
> +
> +	chan = &plxdev->dma_chan;
> +	chan->device = dma;
> +	dma_cookie_init(chan);
> +	list_add_tail(&chan->device_node, &dma->channels);
> +
> +	rc = dma_async_device_register(dma);
> +	if (rc) {
> +		pci_err(pdev, "Failed to register dma device: %d\n", rc);
> +		free_irq(pci_irq_vector(pdev, 0),  plxdev);
> +		return rc;
> +	}
> +
> +	pci_set_drvdata(pdev, plxdev);
> +
> +	return 0;
> +}
> +
> +static int plx_dma_probe(struct pci_dev *pdev,
> +			 const struct pci_device_id *id)
> +{
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
> +	if (rc)
> +		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
> +	if (rc)
> +		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> +	if (rc)
> +		return rc;
> +
> +	rc = pcim_iomap_regions(pdev, 1, KBUILD_MODNAME);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (rc <= 0)
> +		return rc;
> +
> +	pci_set_master(pdev);
> +
> +	rc = plx_dma_create(pdev);
> +	if (rc)
> +		goto err_free_irq_vectors;
> +
> +	pci_info(pdev, "PLX DMA Channel Registered\n");
> +
> +	return 0;
> +
> +err_free_irq_vectors:
> +	pci_free_irq_vectors(pdev);
> +	return rc;
> +}
> +
> +static void plx_dma_remove(struct pci_dev *pdev)
> +{
> +	struct plx_dma_dev *plxdev = pci_get_drvdata(pdev);
> +
> +	free_irq(pci_irq_vector(pdev, 0),  plxdev);
> +
> +	plxdev->bar = NULL;
> +	plx_dma_put(plxdev);
> +
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static const struct pci_device_id plx_dma_pci_tbl[] = {
> +	{
> +		.vendor		= PCI_VENDOR_ID_PLX,
> +		.device		= 0x87D0,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.class		= PCI_CLASS_SYSTEM_OTHER << 8,

can you explain this

> +		.class_mask	= 0xFFFFFFFF,
> +	},

-- 
~Vinod
