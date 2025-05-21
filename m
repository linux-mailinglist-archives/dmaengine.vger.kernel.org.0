Return-Path: <dmaengine+bounces-5234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D198ABF79E
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA533A1FAD
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECF1A0BE0;
	Wed, 21 May 2025 14:20:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8611519BA;
	Wed, 21 May 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837221; cv=none; b=FYam5bUD6cO/HUREiteZXVW/huhrX2KwB9UhVeJP5E6/Rxk5RLyIJqXL6+pywKUuhsX5/goaUZzppw/Fcd65WMglP8sAXbKhKMFBtyVSwWxGlYPGlhmZLQa6+I5ls3MVqaPl0qvfWcjDGYXvTWD3PElWnp7GMxbZdqC25z8K6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837221; c=relaxed/simple;
	bh=enOgTFsj4qfmHpApxbYk9plf8UNjdopTlRa1o7klXu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxaiAEbFLnZtiWLAEYjVYPA8HS0qo/CtoJFeTa/Fl+a865lSV+Q6isleEIaJO/duAfTTALTYejHStCnoY9RBTx33EJYEWysx++xtLPj55ZG8N3vaaldAPmmMZtmvi71De37js0c1IkSjiNcmFOO9MdjFRi9gjeaaC9HQodzlnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF11E1515;
	Wed, 21 May 2025 07:20:01 -0700 (PDT)
Received: from [10.57.64.80] (unknown [10.57.64.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 522EC3F5A1;
	Wed, 21 May 2025 07:20:13 -0700 (PDT)
Message-ID: <e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>
Date: Wed, 21 May 2025 15:20:11 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
 chenxiang66@hisilicon.com, m.szyprowski@samsung.com, leon@kernel.org,
 jgg@nvidia.com, alex.williamson@redhat.com, joel.granados@kernel.org
Cc: iommu@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-2-mcgrof@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250520223913.3407136-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> Today on x86_64 q35 guests we can't easily test some of the DMA API
> with the dmatest out of the box because we lack a DMA engine as the
> current qemu intel IOT patches are out of tree. This implements a basic
> dma engine to let us use the dmatest API to expand on it and leverage
> it on q35 guests.

What does doing so ultimately achieve though? It's clearly not very 
meaningful to test the performance or functionality of this "dmaengine" 
itself, which is the main purpose of dmatest. Nor would it be useful for 
using dmatest as a memory stressor *alongside* a CPU workload, since 
nobody needs a kernel driver to make another CPU thrash memory. All this 
fake implementation can really provide is the side-effect of dmatest 
exercising calls to the DMA mapping API the same way that 
dma_map_benchmark already does, and, well, dma_map_benchmark is 
dedicated to exactly that purpose so why not just use it? If there are 
certain interesting mapping patterns that dmatest happens to do that 
dma_map_benchmark doesn't, let's improve dma_map_benchmark; if there's a 
real need for a fake device because some systems have no spare physical 
devices that are practical to unbind, there's no reason 
dma_map_benchmark couldn't trivially provide its own either...

We clearly cannot validate much actual DMA API functionality without a 
real DMA device reading/writing data through the mapping itself. All we 
can do in software at the kernel level is make the calls and maybe check 
that they return expected values based on assumptions about the backend 
- at best this could cover SWIOTLB bouncing of data as well (at least in 
the case of a non-remapped SWIOTLB buffer such that phys_to_virt() on 
the DMA address doesn't go horribly wrong), but that's effectively still 
in the CPU domain anyway. Beyond that, there is obviously no value in 
spending effort on new ways to confirm that a CPU can read data that a 
CPU has written - we already have a comprehensive test suite for that, 
it's called "Linux". The fact that an API call returns a DMA address 
does not and cannot prove that cache coherency management, IOMMU 
configuration, etc. has all been done correctly, unless it's done for a 
real device which is then capable of actually observing all those 
effects by accessing that DMA address itself. A CPU access fundamentally 
cannot do that.

Thanks,
Robin.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/dma/Kconfig    |  11 +
>   drivers/dma/Makefile   |   1 +
>   drivers/dma/fake-dma.c | 718 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 730 insertions(+)
>   create mode 100644 drivers/dma/fake-dma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index df2d2dc00a05..716531f2c7e2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -140,6 +140,17 @@ config DMA_BCM2835
>   	select DMA_ENGINE
>   	select DMA_VIRTUAL_CHANNELS
>   
> +config DMA_FAKE
> +	tristate "Fake DMA Engine"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This implements a fake DMA engine. Useful for testing the DMA API
> +	  without any hardware requirements, on any architecture which just
> +	  supporst the DMA engine. Enable this if you want to easily run custom
> +	  tests on the DMA API without a real DMA engine or the requirement for
> +	  things like qemu to virtualize it for you.
> +
>   config DMA_JZ4780
>   	tristate "JZ4780 DMA support"
>   	depends on MIPS || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 19ba465011a6..c75e4b7ad9f2 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
>   obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
>   obj-$(CONFIG_BCM_SBA_RAID) += bcm-sba-raid.o
>   obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
> +obj-$(CONFIG_DMA_FAKE) += fake-dma.o
>   obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
>   obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
>   obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
> diff --git a/drivers/dma/fake-dma.c b/drivers/dma/fake-dma.c
> new file mode 100644
> index 000000000000..ee1d788a2b83
> --- /dev/null
> +++ b/drivers/dma/fake-dma.c
> @@ -0,0 +1,718 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> +/*
> + * Fake DMA engine test module. This allows us to test DMA engines
> + * without leveraging virtualization.
> + *
> + * Copyright (C) 2025 Luis Chamberlain <mcgrof@kernel.org>
> + *
> + * This driver provides an interface to trigger and test the kernel's
> + * module loader through a series of configurations and a few triggers.
> + * To test this driver use the following script as root:
> + *
> + * tools/testing/selftests/dma/fake.sh --help
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/freezer.h>
> +#include <linux/init.h>
> +#include <linux/kthread.h>
> +#include <linux/sched/task.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/debugfs.h>
> +#include <linux/platform_device.h>
> +#include "dmaengine.h"
> +
> +#define FAKE_MAX_DMA_CHANNELS 20
> +
> +static unsigned int num_channels = FAKE_MAX_DMA_CHANNELS;
> +module_param(num_channels, uint, 0644);
> +MODULE_PARM_DESC(num_channels, "Number of channels to support (default: 20)");
> +
> +struct fake_dma_desc {
> +	struct dma_async_tx_descriptor txd;
> +	dma_addr_t src;
> +	dma_addr_t dst;
> +	size_t len;
> +	enum dma_transaction_type type;
> +	int memset_value;
> +	/* For XOR/PQ operations */
> +	dma_addr_t *src_list; /* Array of source addresses */
> +	unsigned int src_cnt; /* Number of sources */
> +	dma_addr_t *dst_list; /* Array of destination addresses (for PQ) */
> +	unsigned char *pq_coef; /* P+Q coefficients */
> +	struct list_head node;
> +};
> +
> +struct fake_dma_chan {
> +	struct dma_chan chan;
> +	struct list_head active_list;
> +	struct list_head queue;
> +	struct work_struct work;
> +	spinlock_t lock;
> +	bool running;
> +};
> +
> +struct fake_dma_device {
> +	struct platform_device *pdev;
> +	struct dma_device dma_dev;
> +	struct fake_dma_chan *channels;
> +};
> +
> +struct fake_dma_device *single_fake_dma;
> +
> +static struct platform_driver fake_dma_engine_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,
> +        },
> +};
> +
> +static int fake_dma_create_platform_device(struct fake_dma_device *fake_dma)
> +{
> +	fake_dma->pdev = platform_device_register_simple("fake-dma-engine", -1, NULL, 0);
> +	if (IS_ERR(fake_dma->pdev))
> +		return -ENODEV;
> +
> +	pr_info("Fake DMA platform device created: %s\n",
> +		dev_name(&fake_dma->pdev->dev));
> +
> +	return 0;
> +}
> +
> +static void fake_dma_destroy_platform_device(struct fake_dma_device  *fake_dma)
> +{
> +	if (!fake_dma->pdev)
> +		return;
> +
> +	pr_info("Destroying fake DMA platform device: %s ...\n",
> +		dev_name(&fake_dma->pdev->dev));
> +	platform_device_unregister(fake_dma->pdev);
> +}
> +
> +static inline struct fake_dma_chan *to_fake_dma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct fake_dma_chan, chan);
> +}
> +
> +static inline struct fake_dma_desc *to_fake_dma_desc(struct dma_async_tx_descriptor *txd)
> +{
> +	return container_of(txd, struct fake_dma_desc, txd);
> +}
> +
> +/* Galois Field multiplication for P+Q operations */
> +static unsigned char gf_mul(unsigned char a, unsigned char b)
> +{
> +	unsigned char result = 0;
> +	unsigned char high_bit_set;
> +	int i;
> +
> +	for (i = 0; i < 8; i++) {
> +		if (b & 1)
> +			result ^= a;
> +		high_bit_set = a & 0x80;
> +		a <<= 1;
> +		if (high_bit_set)
> +			a ^= 0x1b; /* x^8 + x^4 + x^3 + x + 1 */
> +		b >>= 1;
> +	}
> +
> +	return result;
> +}
> +
> +/* Processes pending transfers */
> +static void fake_dma_work_func(struct work_struct *work)
> +{
> +	struct fake_dma_chan *vchan = container_of(work, struct fake_dma_chan, work);
> +	struct fake_dma_desc *vdesc;
> +	struct dmaengine_desc_callback cb;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vchan->lock, flags);
> +
> +	if (list_empty(&vchan->queue)) {
> +		vchan->running = false;
> +		spin_unlock_irqrestore(&vchan->lock, flags);
> +		return;
> +	}
> +
> +	vdesc = list_first_entry(&vchan->queue, struct fake_dma_desc, node);
> +	list_del(&vdesc->node);
> +	list_add_tail(&vdesc->node, &vchan->active_list);
> +
> +	spin_unlock_irqrestore(&vchan->lock, flags);
> +
> +	/* Actually perform the DMA transfer for memcpy operations */
> +	if (vdesc->len) {
> +		void *src_virt, *dst_virt;
> +		void *p_virt, *q_virt;
> +		unsigned char *p_bytes, *q_bytes;
> +		unsigned int i, j;
> +		unsigned char *dst_bytes;
> +
> +		switch (vdesc->type) {
> +		case DMA_MEMCPY:
> +			/* Convert DMA addresses to virtual addresses and perform the copy */
> +			src_virt = phys_to_virt(vdesc->src);
> +			dst_virt = phys_to_virt(vdesc->dst);
> +
> +			memcpy(dst_virt, src_virt, vdesc->len);
> +			break;
> +		case DMA_MEMSET:
> +			dst_virt = phys_to_virt(vdesc->dst);
> +			memset(dst_virt, vdesc->memset_value, vdesc->len);
> +			break;
> +		case DMA_XOR:
> +			dst_virt = phys_to_virt(vdesc->dst);
> +			dst_bytes = (unsigned char *)dst_virt;
> +
> +			memset(dst_virt, 0, vdesc->len);
> +
> +			/* XOR all sources into destination */
> +			for (i = 0; i < vdesc->src_cnt; i++) {
> +				void *src_virt = phys_to_virt(vdesc->src_list[i]);
> +				unsigned char *src_bytes = (unsigned char *)src_virt;
> +
> +				for (j = 0; j < vdesc->len; j++)
> +					dst_bytes[j] ^= src_bytes[j];
> +			}
> +			break;
> +		case DMA_PQ:
> +			p_virt = phys_to_virt(vdesc->dst_list[0]);
> +			q_virt = phys_to_virt(vdesc->dst_list[1]);
> +			p_bytes = (unsigned char *)p_virt;
> +			q_bytes = (unsigned char *)q_virt;
> +
> +			/* Initialize P and Q destinations to zero */
> +			memset(p_virt, 0, vdesc->len);
> +			memset(q_virt, 0, vdesc->len);
> +
> +			/* Calculate P (XOR of all sources) and Q (weighted XOR) */
> +			for (i = 0; i < vdesc->src_cnt; i++) {
> +				void *src_virt = phys_to_virt(vdesc->src_list[i]);
> +				unsigned char *src_bytes = (unsigned char *)src_virt;
> +				unsigned char coef = vdesc->pq_coef[i];
> +
> +				for (j = 0; j < vdesc->len; j++) {
> +					/* P calculation: simple XOR */
> +					p_bytes[j] ^= src_bytes[j];
> +
> +					/* Q calculation: multiply in GF(2^8) and XOR */
> +					q_bytes[j] ^= gf_mul(src_bytes[j], coef);
> +				}
> +			}
> +			break;
> +		default:
> +			pr_warn("fake-dma: Unknown DMA operation type %d\n", vdesc->type);
> +			break;
> +		}
> +	}
> +
> +	/* Mark descriptor as complete */
> +	dma_cookie_complete(&vdesc->txd);
> +
> +	/* Call completion callback if set */
> +	dmaengine_desc_get_callback(&vdesc->txd, &cb);
> +	if (cb.callback)
> +		cb.callback(cb.callback_param);
> +
> +	/* Process next transfer if available */
> +	spin_lock_irqsave(&vchan->lock, flags);
> +	list_del(&vdesc->node);
> +
> +	/* Free allocated memory for XOR/PQ operations */
> +	if (vdesc->type == DMA_XOR || vdesc->type == DMA_PQ) {
> +		kfree(vdesc->src_list);
> +		if (vdesc->type == DMA_PQ) {
> +			kfree(vdesc->dst_list);
> +			kfree(vdesc->pq_coef);
> +		}
> +	}
> +
> +	kfree(vdesc);
> +
> +	if (!list_empty(&vchan->queue)) {
> +		spin_unlock_irqrestore(&vchan->lock, flags);
> +		schedule_work(&vchan->work);
> +	} else {
> +		vchan->running = false;
> +		spin_unlock_irqrestore(&vchan->lock, flags);
> +	}
> +}
> +
> +/* Submit descriptor to the DMA engine */
> +static dma_cookie_t fake_dma_tx_submit(struct dma_async_tx_descriptor *txd)
> +{
> +	struct fake_dma_chan *vchan = to_fake_dma_chan(txd->chan);
> +	struct fake_dma_desc *vdesc = to_fake_dma_desc(txd);
> +	unsigned long flags;
> +	dma_cookie_t cookie;
> +
> +	spin_lock_irqsave(&vchan->lock, flags);
> +
> +	cookie = dma_cookie_assign(txd);
> +	list_add_tail(&vdesc->node, &vchan->queue);
> +
> +	/* Schedule processing if not already running */
> +	if (!vchan->running) {
> +		vchan->running = true;
> +		schedule_work(&vchan->work);
> +	}
> +
> +	spin_unlock_irqrestore(&vchan->lock, flags);
> +
> +	return cookie;
> +}
> +
> +static
> +struct dma_async_tx_descriptor *fake_dma_prep_memcpy(struct dma_chan *chan,
> +						     dma_addr_t dest,
> +						     dma_addr_t src,
> +						     size_t len,
> +						     unsigned long flags)
> +{
> +	struct fake_dma_chan *vchan = to_fake_dma_chan(chan);
> +	struct fake_dma_desc *vdesc;
> +
> +	vdesc = kzalloc(sizeof(*vdesc), GFP_NOWAIT);
> +	if (!vdesc)
> +		return NULL;
> +
> +	if (!vchan)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&vdesc->txd, chan);
> +	vdesc->type = DMA_MEMCPY;
> +	vdesc->txd.tx_submit = fake_dma_tx_submit;
> +	vdesc->txd.flags = flags;
> +	vdesc->src = src;
> +	vdesc->dst = dest;
> +	vdesc->len = len;
> +	INIT_LIST_HEAD(&vdesc->node);
> +
> +	return &vdesc->txd;
> +}
> +
> +static
> +struct dma_async_tx_descriptor * fake_dma_prep_memset(struct dma_chan *chan,
> +						      dma_addr_t dest,
> +						      int value,
> +						      size_t len,
> +						      unsigned long flags)
> +{
> +	struct fake_dma_desc *vdesc;
> +
> +	vdesc = kzalloc(sizeof(*vdesc), GFP_NOWAIT);
> +	if (!vdesc)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&vdesc->txd, chan);
> +	vdesc->type = DMA_MEMSET;
> +	vdesc->txd.tx_submit = fake_dma_tx_submit;
> +	vdesc->txd.flags = flags;
> +	vdesc->dst = dest;
> +	vdesc->len = len;
> +	vdesc->memset_value = value & 0xFF; /* Ensure it's a single byte */
> +
> +	INIT_LIST_HEAD(&vdesc->node);
> +
> +	return &vdesc->txd;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +fake_dma_prep_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> +		  unsigned int src_cnt, size_t len, unsigned long flags)
> +{
> +	struct fake_dma_desc *vdesc;
> +
> +	vdesc = kzalloc(sizeof(*vdesc), GFP_NOWAIT);
> +	if (!vdesc)
> +		return NULL;
> +
> +	/* Allocate memory for source list */
> +	vdesc->src_list = kmalloc(src_cnt * sizeof(dma_addr_t), GFP_NOWAIT);
> +	if (!vdesc->src_list) {
> +		kfree(vdesc);
> +		return NULL;
> +	}
> +
> +	dma_async_tx_descriptor_init(&vdesc->txd, chan);
> +	vdesc->type = DMA_XOR;
> +	vdesc->txd.tx_submit = fake_dma_tx_submit;
> +	vdesc->txd.flags = flags;
> +	vdesc->dst = dest;
> +	vdesc->len = len;
> +	vdesc->src_cnt = src_cnt;
> +
> +	memcpy(vdesc->src_list, src, src_cnt * sizeof(dma_addr_t));
> +
> +	INIT_LIST_HEAD(&vdesc->node);
> +
> +	return &vdesc->txd;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +fake_dma_prep_pq(struct dma_chan *chan, dma_addr_t *dst, dma_addr_t *src,
> +		 unsigned int src_cnt, const unsigned char *scf, size_t len,
> +		 unsigned long flags)
> +{
> +	struct fake_dma_desc *vdesc;
> +
> +	vdesc = kzalloc(sizeof(*vdesc), GFP_NOWAIT);
> +	if (!vdesc)
> +		return NULL;
> +
> +	vdesc->src_list = kmalloc(src_cnt * sizeof(dma_addr_t), GFP_NOWAIT);
> +	if (!vdesc->src_list) {
> +		kfree(vdesc);
> +		return NULL;
> +	}
> +
> +	/* Allocate memory for destination list (P and Q) */
> +	vdesc->dst_list = kmalloc(2 * sizeof(dma_addr_t), GFP_NOWAIT);
> +	if (!vdesc->dst_list) {
> +		kfree(vdesc->src_list);
> +		kfree(vdesc);
> +		return NULL;
> +	}
> +
> +	/* Allocate memory for coefficients */
> +	vdesc->pq_coef = kmalloc(src_cnt * sizeof(unsigned char), GFP_NOWAIT);
> +	if (!vdesc->pq_coef) {
> +		kfree(vdesc->dst_list);
> +		kfree(vdesc->src_list);
> +		kfree(vdesc);
> +		return NULL;
> +	}
> +
> +	dma_async_tx_descriptor_init(&vdesc->txd, chan);
> +	vdesc->type = DMA_PQ;
> +	vdesc->txd.tx_submit = fake_dma_tx_submit;
> +	vdesc->txd.flags = flags;
> +	vdesc->len = len;
> +	vdesc->src_cnt = src_cnt;
> +
> +	/* Copy source addresses */
> +	memcpy(vdesc->src_list, src, src_cnt * sizeof(dma_addr_t));
> +	/* Copy destination addresses (P and Q) */
> +	memcpy(vdesc->dst_list, dst, 2 * sizeof(dma_addr_t));
> +	/* Copy coefficients */
> +	memcpy(vdesc->pq_coef, scf, src_cnt * sizeof(unsigned char));
> +
> +	INIT_LIST_HEAD(&vdesc->node);
> +
> +	return &vdesc->txd;
> +}
> +
> +static void fake_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct fake_dma_chan *vchan = to_fake_dma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vchan->lock, flags);
> +
> +	/* Start processing if not already running and queue not empty */
> +	if (!vchan->running && !list_empty(&vchan->queue)) {
> +		vchan->running = true;
> +		schedule_work(&vchan->work);
> +	}
> +
> +	spin_unlock_irqrestore(&vchan->lock, flags);
> +}
> +
> +static int fake_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct fake_dma_chan *vchan = to_fake_dma_chan(chan);
> +
> +	INIT_LIST_HEAD(&vchan->active_list);
> +	INIT_LIST_HEAD(&vchan->queue);
> +	vchan->running = false;
> +
> +	return 1; /* Number of descriptors allocated */
> +}
> +
> +static void fake_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct fake_dma_chan *vchan = to_fake_dma_chan(chan);
> +	struct fake_dma_desc *vdesc, *_vdesc;
> +	unsigned long flags;
> +
> +	cancel_work_sync(&vchan->work);
> +
> +	spin_lock_irqsave(&vchan->lock, flags);
> +
> +	/* Free all descriptors in queue */
> +	list_for_each_entry_safe(vdesc, _vdesc, &vchan->queue, node) {
> +		list_del(&vdesc->node);
> +
> +		/* Free allocated memory for XOR/PQ operations */
> +		if (vdesc->type == DMA_XOR || vdesc->type == DMA_PQ) {
> +			kfree(vdesc->src_list);
> +			if (vdesc->type == DMA_PQ) {
> +				kfree(vdesc->dst_list);
> +				kfree(vdesc->pq_coef);
> +			}
> +		}
> +		kfree(vdesc);
> +	}
> +
> +	/* Free all descriptors in active list */
> +	list_for_each_entry_safe(vdesc, _vdesc, &vchan->active_list, node) {
> +		list_del(&vdesc->node);
> +		/* Free allocated memory for XOR/PQ operations */
> +		if (vdesc->type == DMA_XOR || vdesc->type == DMA_PQ) {
> +			kfree(vdesc->src_list);
> +			if (vdesc->type == DMA_PQ) {
> +				kfree(vdesc->dst_list);
> +				kfree(vdesc->pq_coef);
> +			}
> +		}
> +		kfree(vdesc);
> +	}
> +
> +	spin_unlock_irqrestore(&vchan->lock, flags);
> +}
> +
> +static void fake_dma_release(struct dma_device *dma_dev)
> +{
> +	unsigned int i;
> +        struct fake_dma_device *fake_dma =
> +                container_of(dma_dev, struct fake_dma_device, dma_dev);
> +
> +	pr_info("refcount for dma device %s hit 0, quiescing...",
> +		dev_name(&fake_dma->pdev->dev));
> +
> +	for (i = 0; i < num_channels; i++) {
> +		struct fake_dma_chan *vchan = &fake_dma->channels[i];
> +		cancel_work_sync(&vchan->work);
> +	}
> +
> +        put_device(dma_dev->dev);
> +}
> +
> +static void fake_dma_setup_config(struct fake_dma_device *fake_dma)
> +{
> +	unsigned int i;
> +	struct dma_device *dma =  &fake_dma->dma_dev;
> +
> +	dma->dev = get_device(&fake_dma->pdev->dev);
> +
> +	/* Set multiple capabilities for dmatest compatibility */
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +	dma_cap_set(DMA_MEMSET, dma->cap_mask);
> +	dma_cap_set(DMA_XOR, dma->cap_mask);
> +	dma_cap_set(DMA_PQ, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
> +
> +	dma->device_alloc_chan_resources = fake_dma_alloc_chan_resources;
> +	dma->device_free_chan_resources = fake_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = fake_dma_prep_memcpy;
> +	dma->device_prep_dma_memset = fake_dma_prep_memset;
> +	dma->device_prep_dma_xor = fake_dma_prep_xor;
> +	dma->device_prep_dma_pq = fake_dma_prep_pq;
> +	dma->device_issue_pending = fake_dma_issue_pending;
> +	dma->device_tx_status = dma_cookie_status;
> +	dma->device_release = fake_dma_release;
> +
> +	dma->copy_align = 4; /* 4-byte alignment for memcpy */
> +	dma->fill_align = 4; /* 4-byte alignment for memset */
> +	dma->xor_align = 4;  /* 4-byte alignment for xor */
> +	dma->pq_align = 4;   /* 4-byte alignment for pq */
> +
> +	dma->max_xor = 16;   /* Support up to 16 XOR sources */
> +	dma->max_pq = 16;    /* Support up to 16 P+Q sources */
> +
> +	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			       BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			       BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			       BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +	dma->dst_addr_widths = dma->src_addr_widths;
> +	dma->directions = BIT(DMA_MEM_TO_MEM);
> +	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +
> +	INIT_LIST_HEAD(&dma->channels);
> +
> +	for (i = 0; i < num_channels; i++) {
> +		struct fake_dma_chan *vchan = &fake_dma->channels[i];
> +
> +		vchan->chan.device = dma;
> +		dma_cookie_init(&vchan->chan);
> +
> +		spin_lock_init(&vchan->lock);
> +		INIT_LIST_HEAD(&vchan->active_list);
> +		INIT_LIST_HEAD(&vchan->queue);
> +
> +		INIT_WORK(&vchan->work, fake_dma_work_func);
> +
> +		list_add_tail(&vchan->chan.device_node, &dma->channels);
> +	}
> +}
> +
> +static int fake_dma_load(void)
> +{
> +	unsigned int i;
> +	int ret;
> +	struct fake_dma_device *fake_dma;
> +	struct dma_device *dma;
> +
> +	if (single_fake_dma) {
> +		pr_err("Fake DMA device already loaded, skipping...");
> +		return -EALREADY;
> +	}
> +
> +	if (num_channels > FAKE_MAX_DMA_CHANNELS)
> +		num_channels = FAKE_MAX_DMA_CHANNELS;
> +
> +	ret = platform_driver_register(&fake_dma_engine_driver);
> +	if (ret)
> +		return ret;
> +
> +	fake_dma = kzalloc(sizeof(*fake_dma), GFP_KERNEL);
> +	if (!fake_dma) {
> +		ret = -ENOMEM;
> +		goto out_unregister_driver;
> +	}
> +
> +	fake_dma->channels = kzalloc(sizeof(struct fake_dma_chan) * num_channels,
> +				     GFP_KERNEL);
> +	if (!fake_dma->channels) {
> +		ret = -ENOMEM;
> +		goto out_free_dma;
> +	}
> +
> +	ret = fake_dma_create_platform_device(fake_dma);
> +	if (ret)
> +		goto out_free_chans;
> +
> +	fake_dma->pdev->dev.driver = &fake_dma_engine_driver.driver;
> +	ret = device_bind_driver(&fake_dma->pdev->dev);
> +	if (ret)
> +		goto out_unregister_device;
> +
> +	fake_dma_setup_config(fake_dma);
> +	dma = &fake_dma->dma_dev;
> +
> +	/* Register with the DMA Engine */
> +	ret = dma_async_device_register(dma);
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto out_release_driver;
> +	}
> +
> +	for (i = 0; i < num_channels; i++) {
> +		struct fake_dma_chan *vchan = &fake_dma->channels[i];
> +		pr_info("Registered fake DMA channel %d (%s)\n",
> +			i, dma_chan_name(&vchan->chan));
> +	}
> +
> +	single_fake_dma = fake_dma;
> +
> +	pr_info("Fake DMA engine: %s registered with %d channels\n",
> +		dev_name(&fake_dma->pdev->dev), num_channels);
> +
> +	pr_info("Fake DMA device name for dmatest: '%s'\n", dev_name(dma->dev));
> +	pr_info("Fake DMA device path: '%s'\n", dev_name(&fake_dma->pdev->dev));
> +
> +	return 0;
> +
> +out_release_driver:
> +	device_release_driver(&fake_dma->pdev->dev);
> +out_unregister_device:
> +	fake_dma_destroy_platform_device(fake_dma);
> +out_free_chans:
> +	kfree(fake_dma->channels);
> +out_free_dma:
> +	kfree(fake_dma);
> +	fake_dma = NULL;
> +out_unregister_driver:
> +	platform_driver_unregister(&fake_dma_engine_driver);
> +	return ret;
> +}
> +
> +static void fake_dma_unload(void)
> +{
> +	struct fake_dma_device *fake_dma = single_fake_dma;
> +
> +	if (!fake_dma) {
> +		pr_info("No fake DMA engines registered yet.\n");
> +		return;
> +	}
> +
> +	pr_info("Fake DMA engine: %s unregistering with %d channels ...\n",
> +		dev_name(&fake_dma->pdev->dev), num_channels);
> +
> +	dma_async_device_unregister(&fake_dma->dma_dev);
> +
> +	/*
> +	 * dma_async_device_unregister() will call device_release() only
> +	 * if a channel ever gets busy, so we need to tidy up ourselves
> +	 * here in case no channels are ever used.
> +	 */
> +	device_release_driver(&fake_dma->pdev->dev);
> +	fake_dma_destroy_platform_device(fake_dma);
> +
> +	kfree(fake_dma->channels);
> +	kfree(fake_dma);
> +
> +	platform_driver_unregister(&fake_dma_engine_driver);
> +	single_fake_dma = NULL;
> +}
> +
> +static ssize_t write_file_load(struct file *file, const char __user *user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	fake_dma_load();
> +
> +	return count;
> +}
> +
> +static const struct file_operations fops_load = {
> +	.write = write_file_load,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t write_file_unload(struct file *file, const char __user *user_buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	fake_dma_unload();
> +
> +	return count;
> +}
> +
> +static const struct file_operations fops_unload = {
> +	.write = write_file_unload,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static int __init fake_dma_init(void)
> +{
> +	struct dentry *fake_dir;
> +
> +	fake_dir = debugfs_create_dir("fake-dma", NULL);
> +	debugfs_create_file("load", 0600, fake_dir, NULL, &fops_load);
> +	debugfs_create_file("unload", 0600, fake_dir, NULL, &fops_unload);
> +
> +	return fake_dma_load();
> +}
> +late_initcall(fake_dma_init);
> +
> +static void __exit fake_dma_exit(void)
> +{
> +	fake_dma_unload();
> +}
> +module_exit(fake_dma_exit);
> +
> +MODULE_DESCRIPTION("Fake DMA Engine test module");
> +MODULE_AUTHOR("Luis Chamberlain");
> +MODULE_LICENSE("GPL v2");


