Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA70A117DD3
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 03:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLJChP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 21:37:15 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:54612 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfLJChO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 21:37:14 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id xBA2aApp054391;
        Tue, 10 Dec 2019 10:36:10 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xBA2a5tZ054070;
        Tue, 10 Dec 2019 10:36:05 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 10 Dec
 2019 10:36:06 +0800
Subject: Re: [PATCH v2 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI
 driver skeleton
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>
References: <20191210002437.2907-1-logang@deltatee.com>
 <20191210002437.2907-4-logang@deltatee.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <d2ecc0c0-21a2-146f-950f-765d3ceee6d2@hygon.cn>
Date:   Tue, 10 Dec 2019 10:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210002437.2907-4-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xBA2aApp054391
X-DNSRBL: 
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019/12/10 8:24, Logan Gunthorpe wrote:
> Some PLX Switches can expose DMA engines via extra PCI functions
> on the upstream port. Each function will have one DMA channel.
> 
> This patch is just the core PCI driver skeleton and dma
> engine registration.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   MAINTAINERS           |   5 ++
>   drivers/dma/Kconfig   |   9 ++
>   drivers/dma/Makefile  |   1 +
>   drivers/dma/plx_dma.c | 197 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 212 insertions(+)
>   create mode 100644 drivers/dma/plx_dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd5847e802de..76713226f256 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13139,6 +13139,11 @@ S:	Maintained
>   F:	drivers/iio/chemical/pms7003.c
>   F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
>   
> +PLX DMA DRIVER
> +M:	Logan Gunthorpe <logang@deltatee.com>
> +S:	Maintained
> +F:	drivers/dma/plx_dma.c
> +
>   PMBUS HARDWARE MONITORING DRIVERS
>   M:	Guenter Roeck <linux@roeck-us.net>
>   L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6fa1eba9d477..312a6cc36c78 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -497,6 +497,15 @@ config PXA_DMA
>   	  16 to 32 channels for peripheral to memory or memory to memory
>   	  transfers.
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
>   config SIRF_DMA
>   	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
>   	depends on ARCH_SIRF
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 42d7e2fc64fa..a150d1d792fd 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>   obj-$(CONFIG_OWL_DMA) += owl-dma.o
>   obj-$(CONFIG_PCH_DMA) += pch_dma.o
>   obj-$(CONFIG_PL330_DMA) += pl330.o
> +obj-$(CONFIG_PLX_DMA) += plx_dma.o
>   obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
>   obj-$(CONFIG_PXA_DMA) += pxa_dma.o
>   obj-$(CONFIG_RENESAS_DMA) += sh/
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> new file mode 100644
> index 000000000000..54e13cb92d51
> --- /dev/null
> +++ b/drivers/dma/plx_dma.c
> @@ -0,0 +1,197 @@
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

Hi Logan
Failed to register dma device need to call plx_dma_put(plxdev) or 
kfree(plxdev), otherwise it result in memory leak.

Thanks
Jiasen Lin

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
> +		.class_mask	= 0xFFFFFFFF,
> +	},
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, plx_dma_pci_tbl);
> +
> +static struct pci_driver plx_dma_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = plx_dma_pci_tbl,
> +	.probe          = plx_dma_probe,
> +	.remove		= plx_dma_remove,
> +};
> +module_pci_driver(plx_dma_pci_driver);
> 
