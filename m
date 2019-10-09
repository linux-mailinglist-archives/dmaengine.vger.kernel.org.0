Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A08D101F
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfJIN3F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 09:29:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49318 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbfJIN3F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 09:29:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x99DSlKQ083319;
        Wed, 9 Oct 2019 08:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570627727;
        bh=BLLJa0oZajJywt1OstDRIC0gUbZMeNtRpNZb2STEWis=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FFJhNOtEwsuCvPg+CmL7OfpPJwmZBUaPjX4zNRgdWGNOID6LP2NB2fUfpHkII+iX2
         uX3ldzL94Ww9MqvZwIeMG4kV7c5KuJpczit6nlll26/KEJs9VZ+U8tnnMBggmkGJ3W
         nxGeEUV+bCDGv0PDqvZG1dgPQ+JzLTNa8fP381AQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x99DSlMi049217
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 08:28:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 08:28:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 08:28:44 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99DSfwR036898;
        Wed, 9 Oct 2019 08:28:42 -0500
Subject: Re: [PATCH v3 02/14] soc: ti: k3: add navss ringacc driver
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-3-peter.ujfalusi@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <86344789-e0f4-5b29-62da-3fb08025177b@ti.com>
Date:   Wed, 9 Oct 2019 18:57:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/10/19 11:46 AM, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x SoCs.
> 
> The RINGACC converts constant-address read and write accesses to equivalent
> read or write accesses to a circular data structure in memory. The RINGACC
> eliminates the need for each DMA controller which needs to access ring
> elements from having to know the current state of the ring (base address,
> current offset). The DMA controller performs a read or write access to a
> specific address range (which maps to the source interface on the RINGACC)
> and the RINGACC replaces the address for the transaction with a new address
> which corresponds to the head or tail element of the ring (head for reads,
> tail for writes). Since the RINGACC maintains the state, multiple DMA
> controllers or channels are allowed to coherently share the same rings as
> applicable. The RINGACC is able to place data which is destined towards
> software into cached memory directly.
> 
> Supported ring modes:
> - Ring Mode
> - Messaging Mode
> - Credentials Mode
> - Queue Manager Mode
> 
> TI-SCI integration:
> 
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol now
> has control over Ringacc module resources management (RM) and Rings
> configuration.
> 
> The corresponding support of TI-SCI Ringacc module RM protocol
> introduced as option through DT parameters:
> - ti,sci: phandle on TI-SCI firmware controller DT node
> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
> 
> if both parameters present - Ringacc driver will configure/free/reset Rings
> using TI-SCI Message Ringacc RM Protocol.
> 
> The Ringacc driver manages Rings allocation by itself now and requests
> TI-SCI firmware to allocate and configure specific Rings only. It's done
> this way because, Linux driver implements two stage Rings allocation and
> configuration (allocate ring and configure ring) while I-SCI Message
> Protocol supports only one combined operation (allocate+configure).
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/soc/ti/Kconfig            |   12 +
>  drivers/soc/ti/Makefile           |    1 +
>  drivers/soc/ti/k3-ringacc.c       | 1165 +++++++++++++++++++++++++++++
>  include/linux/soc/ti/k3-ringacc.h |  245 ++++++
>  4 files changed, 1423 insertions(+)
>  create mode 100644 drivers/soc/ti/k3-ringacc.c
>  create mode 100644 include/linux/soc/ti/k3-ringacc.h
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index cf545f428d03..87722d33333a 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -80,6 +80,18 @@ config TI_SCI_PM_DOMAINS
>  	  called ti_sci_pm_domains. Note this is needed early in boot before
>  	  rootfs may be available.
>  
> +config TI_K3_RINGACC
> +	tristate "K3 Ring accelerator Sub System"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_INTA_IRQCHIP
> +	default y
> +	help
> +	  Say y here to support the K3 Ring accelerator module.
> +	  The Ring Accelerator (RINGACC or RA)  provides hardware acceleration
> +	  to enable straightforward passing of work between a producer
> +	  and a consumer. There is one RINGACC module per NAVSS on TI AM65x SoCs
> +	  If unsure, say N.
> +
>  endif # SOC_TI
>  
>  config TI_SCI_INTA_MSI_DOMAIN
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index b3868d392d4f..cc4bc8b08bf5 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>  obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
> +obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> new file mode 100644
> index 000000000000..4728a79fd2c0
> --- /dev/null
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -0,0 +1,1165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI K3 NAVSS Ring Accelerator subsystem driver
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/soc/ti/k3-ringacc.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +#include <linux/soc/ti/ti_sci_inta_msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +
> +static LIST_HEAD(k3_ringacc_list);
> +static DEFINE_MUTEX(k3_ringacc_list_lock);
> +
> +#define K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK		GENMASK(19, 0)
> +
> +/**
> + * struct k3_ring_rt_regs -  The RA Control/Status Registers region
> + */
> +struct k3_ring_rt_regs {
> +	u32	resv_16[4];
> +	u32	db;		/* RT Ring N Doorbell Register */
> +	u32	resv_4[1];
> +	u32	occ;		/* RT Ring N Occupancy Register */
> +	u32	indx;		/* RT Ring N Current Index Register */
> +	u32	hwocc;		/* RT Ring N Hardware Occupancy Register */
> +	u32	hwindx;		/* RT Ring N Current Index Register */
> +};
> +
> +#define K3_RINGACC_RT_REGS_STEP	0x1000
> +
> +/**
> + * struct k3_ring_fifo_regs -  The Ring Accelerator Queues Registers region
> + */
> +struct k3_ring_fifo_regs {
> +	u32	head_data[128];		/* Ring Head Entry Data Registers */
> +	u32	tail_data[128];		/* Ring Tail Entry Data Registers */
> +	u32	peek_head_data[128];	/* Ring Peek Head Entry Data Regs */
> +	u32	peek_tail_data[128];	/* Ring Peek Tail Entry Data Regs */
> +};
> +
> +/**
> + * struct k3_ringacc_proxy_gcfg_regs - RA Proxy Global Config MMIO Region
> + */
> +struct k3_ringacc_proxy_gcfg_regs {
> +	u32	revision;	/* Revision Register */
> +	u32	config;		/* Config Register */
> +};
> +
> +#define K3_RINGACC_PROXY_CFG_THREADS_MASK		GENMASK(15, 0)
> +
> +/**
> + * struct k3_ringacc_proxy_target_regs -  Proxy Datapath MMIO Region
> + */
> +struct k3_ringacc_proxy_target_regs {
> +	u32	control;	/* Proxy Control Register */
> +	u32	status;		/* Proxy Status Register */
> +	u8	resv_512[504];
> +	u32	data[128];	/* Proxy Data Register */
> +};
> +
> +#define K3_RINGACC_PROXY_TARGET_STEP	0x1000
> +#define K3_RINGACC_PROXY_NOT_USED	(-1)
> +
> +enum k3_ringacc_proxy_access_mode {
> +	PROXY_ACCESS_MODE_HEAD = 0,
> +	PROXY_ACCESS_MODE_TAIL = 1,
> +	PROXY_ACCESS_MODE_PEEK_HEAD = 2,
> +	PROXY_ACCESS_MODE_PEEK_TAIL = 3,
> +};
> +
> +#define K3_RINGACC_FIFO_WINDOW_SIZE_BYTES  (512U)
> +#define K3_RINGACC_FIFO_REGS_STEP	0x1000
> +#define K3_RINGACC_MAX_DB_RING_CNT    (127U)
> +
> +/**
> + * struct k3_ring_ops -  Ring operations
> + */
> +struct k3_ring_ops {
> +	int (*push_tail)(struct k3_ring *ring, void *elm);
> +	int (*push_head)(struct k3_ring *ring, void *elm);
> +	int (*pop_tail)(struct k3_ring *ring, void *elm);
> +	int (*pop_head)(struct k3_ring *ring, void *elm);
> +};
> +
> +/**
> + * struct k3_ring - RA Ring descriptor
> + *
> + * @rt - Ring control/status registers
> + * @fifos - Ring queues registers
> + * @proxy - Ring Proxy Datapath registers
> + * @ring_mem_dma - Ring buffer dma address
> + * @ring_mem_virt - Ring buffer virt address
> + * @ops - Ring operations
> + * @size - Ring size in elements
> + * @elm_size - Size of the ring element
> + * @mode - Ring mode
> + * @flags - flags
> + * @free - Number of free elements
> + * @occ - Ring occupancy
> + * @windex - Write index (only for @K3_RINGACC_RING_MODE_RING)
> + * @rindex - Read index (only for @K3_RINGACC_RING_MODE_RING)
> + * @ring_id - Ring Id
> + * @parent - Pointer on struct @k3_ringacc
> + * @use_count - Use count for shared rings
> + * @proxy_id - RA Ring Proxy Id (only if @K3_RINGACC_RING_USE_PROXY)
> + */
> +struct k3_ring {
> +	struct k3_ring_rt_regs __iomem *rt;
> +	struct k3_ring_fifo_regs __iomem *fifos;
> +	struct k3_ringacc_proxy_target_regs  __iomem *proxy;
> +	dma_addr_t	ring_mem_dma;
> +	void		*ring_mem_virt;
> +	struct k3_ring_ops *ops;
> +	u32		size;
> +	enum k3_ring_size elm_size;
> +	enum k3_ring_mode mode;
> +	u32		flags;
> +#define K3_RING_FLAG_BUSY	BIT(1)
> +#define K3_RING_FLAG_SHARED	BIT(2)
> +	u32		free;
> +	u32		occ;
> +	u32		windex;
> +	u32		rindex;
> +	u32		ring_id;
> +	struct k3_ringacc	*parent;
> +	u32		use_count;
> +	int		proxy_id;
> +};
> +
> +/**
> + * struct k3_ringacc - Rings accelerator descriptor
> + *
> + * @dev - pointer on RA device
> + * @proxy_gcfg - RA proxy global config registers
> + * @proxy_target_base - RA proxy datapath region
> + * @num_rings - number of ring in RA
> + * @rings_inuse - bitfield for ring usage tracking
> + * @rm_gp_range - general purpose rings range from tisci
> + * @dma_ring_reset_quirk - DMA reset w/a enable
> + * @num_proxies - number of RA proxies
> + * @proxy_inuse - bitfield for proxy usage tracking
> + * @rings - array of rings descriptors (struct @k3_ring)
> + * @list - list of RAs in the system
> + * @tisci - pointer ti-sci handle
> + * @tisci_ring_ops - ti-sci rings ops
> + * @tisci_dev_id - ti-sci device id
> + */
> +struct k3_ringacc {
> +	struct device *dev;
> +	struct k3_ringacc_proxy_gcfg_regs __iomem *proxy_gcfg;
> +	void __iomem *proxy_target_base;
> +	u32 num_rings; /* number of rings in Ringacc module */
> +	unsigned long *rings_inuse;
> +	struct ti_sci_resource *rm_gp_range;
> +
> +	bool dma_ring_reset_quirk;
> +	u32 num_proxies;
> +	unsigned long *proxy_inuse;
> +
> +	struct k3_ring *rings;
> +	struct list_head list;
> +	struct mutex req_lock; /* protect rings allocation */
> +
> +	const struct ti_sci_handle *tisci;
> +	const struct ti_sci_rm_ringacc_ops *tisci_ring_ops;
> +	u32  tisci_dev_id;

This can be dropped no? pdev->id has it already.

> +};
> +
> +static long k3_ringacc_ring_get_fifo_pos(struct k3_ring *ring)
> +{
> +	return K3_RINGACC_FIFO_WINDOW_SIZE_BYTES -
> +	       (4 << ring->elm_size);
> +}
> +
> +static void *k3_ringacc_get_elm_addr(struct k3_ring *ring, u32 idx)
> +{
> +	return (ring->ring_mem_virt + idx * (4 << ring->elm_size));
> +}
> +
> +static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_pop_mem(struct k3_ring *ring, void *elem);
> +
> +static struct k3_ring_ops k3_ring_mode_ring_ops = {
> +		.push_tail = k3_ringacc_ring_push_mem,
> +		.pop_head = k3_ringacc_ring_pop_mem,
> +};
> +
> +static int k3_ringacc_ring_push_io(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_push_head_io(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem);
> +
> +static struct k3_ring_ops k3_ring_mode_msg_ops = {
> +		.push_tail = k3_ringacc_ring_push_io,
> +		.push_head = k3_ringacc_ring_push_head_io,
> +		.pop_tail = k3_ringacc_ring_pop_tail_io,
> +		.pop_head = k3_ringacc_ring_pop_io,
> +};
> +
> +static int k3_ringacc_ring_push_head_proxy(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_push_tail_proxy(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_pop_head_proxy(struct k3_ring *ring, void *elem);
> +static int k3_ringacc_ring_pop_tail_proxy(struct k3_ring *ring, void *elem);
> +
> +static struct k3_ring_ops k3_ring_mode_proxy_ops = {
> +		.push_tail = k3_ringacc_ring_push_tail_proxy,
> +		.push_head = k3_ringacc_ring_push_head_proxy,
> +		.pop_tail = k3_ringacc_ring_pop_tail_proxy,
> +		.pop_head = k3_ringacc_ring_pop_head_proxy,
> +};
> +
> +static void k3_ringacc_ring_dump(struct k3_ring *ring)
> +{
> +	struct device *dev = ring->parent->dev;
> +
> +	dev_dbg(dev, "dump ring: %d\n", ring->ring_id);
> +	dev_dbg(dev, "dump mem virt %p, dma %pad\n", ring->ring_mem_virt,
> +		&ring->ring_mem_dma);
> +	dev_dbg(dev, "dump elmsize %d, size %d, mode %d, proxy_id %d\n",
> +		ring->elm_size, ring->size, ring->mode, ring->proxy_id);
> +
> +	dev_dbg(dev, "dump ring_rt_regs: db%08x\n", readl(&ring->rt->db));
> +	dev_dbg(dev, "dump occ%08x\n", readl(&ring->rt->occ));
> +	dev_dbg(dev, "dump indx%08x\n", readl(&ring->rt->indx));
> +	dev_dbg(dev, "dump hwocc%08x\n", readl(&ring->rt->hwocc));
> +	dev_dbg(dev, "dump hwindx%08x\n", readl(&ring->rt->hwindx));
> +
> +	if (ring->ring_mem_virt)
> +		print_hex_dump_debug("dump ring_mem_virt ", DUMP_PREFIX_NONE,
> +				     16, 1, ring->ring_mem_virt, 16 * 8, false);
> +}
> +
> +struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
> +					int id, u32 flags)
> +{
> +	int proxy_id = K3_RINGACC_PROXY_NOT_USED;
> +
> +	mutex_lock(&ringacc->req_lock);
> +
> +	if (id == K3_RINGACC_RING_ID_ANY) {
> +		/* Request for any general purpose ring */
> +		struct ti_sci_resource_desc *gp_rings =
> +						&ringacc->rm_gp_range->desc[0];> +		unsigned long size;
> +
> +		size = gp_rings->start + gp_rings->num;
> +		id = find_next_zero_bit(ringacc->rings_inuse, size,
> +					gp_rings->start);

ti_sci_get_free resource can be used no? In case if id is passed, that bit alone
can be set.

> +		if (id == size)
> +			goto error;
> +	} else if (id < 0) {
> +		goto error;
> +	}
> +
> +	if (test_bit(id, ringacc->rings_inuse) &&
> +	    !(ringacc->rings[id].flags & K3_RING_FLAG_SHARED))
> +		goto error;
> +	else if (ringacc->rings[id].flags & K3_RING_FLAG_SHARED)
> +		goto out;
> +
> +	if (flags & K3_RINGACC_RING_USE_PROXY) {
> +		proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
> +					      ringacc->num_proxies, 0);

May be a dump question, but how do we make sure that these proxies are not used
by another Hosts?

> +		if (proxy_id == ringacc->num_proxies)
> +			goto error;
> +	}
> +
> +	if (!try_module_get(ringacc->dev->driver->owner))
> +		goto error;
> +
> +	if (proxy_id != K3_RINGACC_PROXY_NOT_USED) {
> +		set_bit(proxy_id, ringacc->proxy_inuse);
> +		ringacc->rings[id].proxy_id = proxy_id;
> +		dev_dbg(ringacc->dev, "Giving ring#%d proxy#%d\n", id,
> +			proxy_id);
> +	} else {
> +		dev_dbg(ringacc->dev, "Giving ring#%d\n", id);
> +	}
> +
> +	set_bit(id, ringacc->rings_inuse);
> +out:
> +	ringacc->rings[id].use_count++;
> +	mutex_unlock(&ringacc->req_lock);
> +	return &ringacc->rings[id];
> +
> +error:
> +	mutex_unlock(&ringacc->req_lock);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
> +

[..snip..]

> +
> +static int k3_ringacc_probe(struct platform_device *pdev)
> +{
> +	struct k3_ringacc *ringacc;
> +	void __iomem *base_fifo, *base_rt;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret, i;
> +
> +	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
> +	if (!ringacc)
> +		return -ENOMEM;
> +
> +	ringacc->dev = dev;
> +	mutex_init(&ringacc->req_lock);
> +
> +	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
> +					    DOMAIN_BUS_TI_SCI_INTA_MSI);
> +	if (!dev->msi_domain) {
> +		dev_err(dev, "Failed to get MSI domain\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = k3_ringacc_probe_dt(ringacc);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rt");
> +	base_rt = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base_rt))
> +		return PTR_ERR(base_rt);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fifos");
> +	base_fifo = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base_fifo))
> +		return PTR_ERR(base_fifo);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "proxy_gcfg");
> +	ringacc->proxy_gcfg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ringacc->proxy_gcfg))
> +		return PTR_ERR(ringacc->proxy_gcfg);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "proxy_target");
> +	ringacc->proxy_target_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ringacc->proxy_target_base))
> +		return PTR_ERR(ringacc->proxy_target_base);
> +
> +	ringacc->num_proxies = readl(&ringacc->proxy_gcfg->config) &
> +				     K3_RINGACC_PROXY_CFG_THREADS_MASK;
> +
> +	ringacc->rings = devm_kzalloc(dev,
> +				      sizeof(*ringacc->rings) *
> +				      ringacc->num_rings,
> +				      GFP_KERNEL);
> +	ringacc->rings_inuse = devm_kcalloc(dev,
> +					    BITS_TO_LONGS(ringacc->num_rings),
> +					    sizeof(unsigned long), GFP_KERNEL);
> +	ringacc->proxy_inuse = devm_kcalloc(dev,
> +					    BITS_TO_LONGS(ringacc->num_proxies),
> +					    sizeof(unsigned long), GFP_KERNEL);
> +
> +	if (!ringacc->rings || !ringacc->rings_inuse || !ringacc->proxy_inuse)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ringacc->num_rings; i++) {
> +		ringacc->rings[i].rt = base_rt +
> +				       K3_RINGACC_RT_REGS_STEP * i;
> +		ringacc->rings[i].fifos = base_fifo +
> +					  K3_RINGACC_FIFO_REGS_STEP * i;
> +		ringacc->rings[i].parent = ringacc;
> +		ringacc->rings[i].ring_id = i;
> +		ringacc->rings[i].proxy_id = K3_RINGACC_PROXY_NOT_USED;
> +	}
> +	dev_set_drvdata(dev, ringacc);
> +
> +	ringacc->tisci_ring_ops = &ringacc->tisci->ops.rm_ring_ops;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		dev_err(dev, "Failed to enable pm %d\n", ret);
> +		goto err;
> +	}

Don't you need power-domains property in DT so that pm is actually working? If
that is populated, dev-id can be derived from power-domains rather than a
separate dt property.

[...snip..]


> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
> new file mode 100644
> index 000000000000..526b2e38fcce
> --- /dev/null
> +++ b/include/linux/soc/ti/k3-ringacc.h
> @@ -0,0 +1,245 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * K3 Ring Accelerator (RA) subsystem interface
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#ifndef __SOC_TI_K3_RINGACC_API_H_
> +#define __SOC_TI_K3_RINGACC_API_H_
> +
> +#include <linux/types.h>
> +
> +struct device_node;
> +

[...snip..]

> +
> +/**
> + * k3_ringacc_ring_reset - ring reset
> + * @ring: pointer on Ring
> + *
> + * Resets ring internal state ((hw)occ, (hw)idx).
> + * TODO_GS: ? Ring can be reused without reconfiguration

TODO_GS?

Thanks and regards,
Lokesh
