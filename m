Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF9118F36
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLJRoG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 12:44:06 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38038 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfLJRoG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 12:44:06 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iejYJ-0006f9-7f; Tue, 10 Dec 2019 10:44:04 -0700
To:     Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>
References: <20191210002437.2907-1-logang@deltatee.com>
 <20191210002437.2907-4-logang@deltatee.com>
 <d2ecc0c0-21a2-146f-950f-765d3ceee6d2@hygon.cn>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1fcb7d33-c8ac-509d-0962-a50c31f9430c@deltatee.com>
Date:   Tue, 10 Dec 2019 10:44:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2ecc0c0-21a2-146f-950f-765d3ceee6d2@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kchow@gigaio.com, dan.j.williams@intel.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linjiasen@hygon.cn
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI
 driver skeleton
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-12-09 7:33 p.m., Jiasen Lin wrote:
> 
> 
> On 2019/12/10 8:24, Logan Gunthorpe wrote:
>> Some PLX Switches can expose DMA engines via extra PCI functions
>> on the upstream port. Each function will have one DMA channel.
>>
>> This patch is just the core PCI driver skeleton and dma
>> engine registration.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   MAINTAINERS           |   5 ++
>>   drivers/dma/Kconfig   |   9 ++
>>   drivers/dma/Makefile  |   1 +
>>   drivers/dma/plx_dma.c | 197 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 212 insertions(+)
>>   create mode 100644 drivers/dma/plx_dma.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bd5847e802de..76713226f256 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13139,6 +13139,11 @@ S:	Maintained
>>   F:	drivers/iio/chemical/pms7003.c
>>   F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
>>   
>> +PLX DMA DRIVER
>> +M:	Logan Gunthorpe <logang@deltatee.com>
>> +S:	Maintained
>> +F:	drivers/dma/plx_dma.c
>> +
>>   PMBUS HARDWARE MONITORING DRIVERS
>>   M:	Guenter Roeck <linux@roeck-us.net>
>>   L:	linux-hwmon@vger.kernel.org
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 6fa1eba9d477..312a6cc36c78 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -497,6 +497,15 @@ config PXA_DMA
>>   	  16 to 32 channels for peripheral to memory or memory to memory
>>   	  transfers.
>>   
>> +config PLX_DMA
>> +	tristate "PLX ExpressLane PEX Switch DMA Engine Support"
>> +	depends on PCI
>> +	select DMA_ENGINE
>> +	help
>> +	  Some PLX ExpressLane PCI Switches support additional DMA engines.
>> +	  These are exposed via extra functions on the switch's
>> +	  upstream port. Each function exposes one DMA channel.
>> +
>>   config SIRF_DMA
>>   	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
>>   	depends on ARCH_SIRF
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 42d7e2fc64fa..a150d1d792fd 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -59,6 +59,7 @@ obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>>   obj-$(CONFIG_OWL_DMA) += owl-dma.o
>>   obj-$(CONFIG_PCH_DMA) += pch_dma.o
>>   obj-$(CONFIG_PL330_DMA) += pl330.o
>> +obj-$(CONFIG_PLX_DMA) += plx_dma.o
>>   obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
>>   obj-$(CONFIG_PXA_DMA) += pxa_dma.o
>>   obj-$(CONFIG_RENESAS_DMA) += sh/
>> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
>> new file mode 100644
>> index 000000000000..54e13cb92d51
>> --- /dev/null
>> +++ b/drivers/dma/plx_dma.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Microsemi Switchtec(tm) PCIe Management Driver
>> + * Copyright (c) 2019, Logan Gunthorpe <logang@deltatee.com>
>> + * Copyright (c) 2019, GigaIO Networks, Inc
>> + */
>> +
>> +#include "dmaengine.h"
>> +
>> +#include <linux/dmaengine.h>
>> +#include <linux/kref.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +
>> +MODULE_DESCRIPTION("PLX ExpressLane PEX PCI Switch DMA Engine");
>> +MODULE_VERSION("0.1");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Logan Gunthorpe");
>> +
>> +struct plx_dma_dev {
>> +	struct dma_device dma_dev;
>> +	struct dma_chan dma_chan;
>> +	void __iomem *bar;
>> +
>> +	struct kref ref;
>> +	struct work_struct release_work;
>> +};
>> +
>> +static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
>> +{
>> +	return container_of(c, struct plx_dma_dev, dma_chan);
>> +}
>> +
>> +static void plx_dma_release_work(struct work_struct *work)
>> +{
>> +	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
>> +						  release_work);
>> +
>> +	dma_async_device_unregister(&plxdev->dma_dev);
>> +	put_device(plxdev->dma_dev.dev);
>> +	kfree(plxdev);
>> +}
>> +
>> +static void plx_dma_release(struct kref *ref)
>> +{
>> +	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
>> +
>> +	/*
>> +	 * The dmaengine reference counting and locking is a bit of a
>> +	 * mess so we have to work around it a bit here. We might put
>> +	 * the reference while the dmaengine holds the dma_list_mutex
>> +	 * which means we can't call dma_async_device_unregister() directly
>> +	 * here and it must be delayed.
>> +	 */
>> +	schedule_work(&plxdev->release_work);
>> +}
>> +
>> +static void plx_dma_put(struct plx_dma_dev *plxdev)
>> +{
>> +	kref_put(&plxdev->ref, plx_dma_release);
>> +}
>> +
>> +static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>> +
>> +	kref_get(&plxdev->ref);
>> +
>> +	return 0;
>> +}
>> +
>> +static void plx_dma_free_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>> +
>> +	plx_dma_put(plxdev);
>> +}
>> +
>> +static int plx_dma_create(struct pci_dev *pdev)
>> +{
>> +	struct plx_dma_dev *plxdev;
>> +	struct dma_device *dma;
>> +	struct dma_chan *chan;
>> +	int rc;
>> +
>> +	plxdev = kzalloc(sizeof(*plxdev), GFP_KERNEL);
>> +	if (!plxdev)
>> +		return -ENOMEM;
>> +
>> +	kref_init(&plxdev->ref);
>> +	INIT_WORK(&plxdev->release_work, plx_dma_release_work);
>> +
>> +	plxdev->bar = pcim_iomap_table(pdev)[0];
>> +
>> +	dma = &plxdev->dma_dev;
>> +	dma->chancnt = 1;
>> +	INIT_LIST_HEAD(&dma->channels);
>> +	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
>> +	dma->dev = get_device(&pdev->dev);
>> +
>> +	dma->device_alloc_chan_resources = plx_dma_alloc_chan_resources;
>> +	dma->device_free_chan_resources = plx_dma_free_chan_resources;
>> +
>> +	chan = &plxdev->dma_chan;
>> +	chan->device = dma;
>> +	dma_cookie_init(chan);
>> +	list_add_tail(&chan->device_node, &dma->channels);
>> +
>> +	rc = dma_async_device_register(dma);
>> +	if (rc) {
>> +		pci_err(pdev, "Failed to register dma device: %d\n", rc);
>> +		free_irq(pci_irq_vector(pdev, 0),  plxdev);
> 
> Hi Logan
> Failed to register dma device need to call plx_dma_put(plxdev) or 
> kfree(plxdev), otherwise it result in memory leak.

Nice catch! Thanks.

Will fix for v3.

Logan
