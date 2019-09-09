Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF5AD987
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbfIINAZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 09:00:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58928 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfIINAZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 09:00:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x89D0Bms112937;
        Mon, 9 Sep 2019 08:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568034011;
        bh=4lqQX7rdUF84bviuVr+za8Q2BVAw9BrK95GZEzi1OeQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KA0R82BJyOczNU/iS6vDH/+MwhvnCCJBj3CgfnqLlOryIqthYto98hRhWvU+zGv2D
         Zg964QxLsMCaTKxAeKDxvVBeU/guRFevsIOq9XMUcxZEkJFytlT2C2Z6BVrG2PQ+Jq
         AGvrZVyGJf+wZC+xsmXPdMTz16DeYuNB9t46Vb2k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x89D0Bm0080529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Sep 2019 08:00:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 08:00:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 08:00:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x89D07aa051765;
        Mon, 9 Sep 2019 08:00:07 -0500
Subject: Re: [PATCH v2 02/14] soc: ti: k3: add navss ringacc driver
To:     Tero Kristo <t-kristo@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-3-peter.ujfalusi@ti.com>
 <13e5c02f-7060-3a30-56cb-a9caca9fc85b@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ba083c56-782b-3c44-2778-b56f4a5be912@ti.com>
Date:   Mon, 9 Sep 2019 16:00:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13e5c02f-7060-3a30-56cb-a9caca9fc85b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Grygorii, can you take a look?

On 09/09/2019 9.09, Tero Kristo wrote:
> Hi,
> 
> Mostly some cosmetic comments below, other than that seems fine to me.
> 
> On 30/07/2019 12:34, Peter Ujfalusi wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
>> enable straightforward passing of work between a producer and a consumer.
>> There is one RINGACC module per NAVSS on TI AM65x SoCs.
>>
>> The RINGACC converts constant-address read and write accesses to
>> equivalent
>> read or write accesses to a circular data structure in memory. The
>> RINGACC
>> eliminates the need for each DMA controller which needs to access ring
>> elements from having to know the current state of the ring (base address,
>> current offset). The DMA controller performs a read or write access to a
>> specific address range (which maps to the source interface on the
>> RINGACC)
>> and the RINGACC replaces the address for the transaction with a new
>> address
>> which corresponds to the head or tail element of the ring (head for
>> reads,
>> tail for writes). Since the RINGACC maintains the state, multiple DMA
>> controllers or channels are allowed to coherently share the same rings as
>> applicable. The RINGACC is able to place data which is destined towards
>> software into cached memory directly.
>>
>> Supported ring modes:
>> - Ring Mode
>> - Messaging Mode
>> - Credentials Mode
>> - Queue Manager Mode
>>
>> TI-SCI integration:
>>
>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol now
>> has control over Ringacc module resources management (RM) and Rings
>> configuration.
>>
>> The corresponding support of TI-SCI Ringacc module RM protocol
>> introduced as option through DT parameters:
>> - ti,sci: phandle on TI-SCI firmware controller DT node
>> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
>>
>> if both parameters present - Ringacc driver will configure/free/reset
>> Rings
>> using TI-SCI Message Ringacc RM Protocol.
>>
>> The Ringacc driver manages Rings allocation by itself now and requests
>> TI-SCI firmware to allocate and configure specific Rings only. It's done
>> this way because, Linux driver implements two stage Rings allocation and
>> configuration (allocate ring and configure ring) while I-SCI Message
> 
> I-SCI should be TI-SCI I believe.

Yes, it supposed to be.

> 
>> Protocol supports only one combined operation (allocate+configure).
>>
>> Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Above seems to be missing SoB?

Oh, it is really missing.

> 
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/soc/ti/Kconfig            |   17 +
>>   drivers/soc/ti/Makefile           |    1 +
>>   drivers/soc/ti/k3-ringacc.c       | 1191 +++++++++++++++++++++++++++++
>>   include/linux/soc/ti/k3-ringacc.h |  262 +++++++
>>   4 files changed, 1471 insertions(+)
>>   create mode 100644 drivers/soc/ti/k3-ringacc.c
>>   create mode 100644 include/linux/soc/ti/k3-ringacc.h
>>
>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>> index cf545f428d03..10c76faa503e 100644
>> --- a/drivers/soc/ti/Kconfig
>> +++ b/drivers/soc/ti/Kconfig
>> @@ -80,6 +80,23 @@ config TI_SCI_PM_DOMAINS
>>         called ti_sci_pm_domains. Note this is needed early in boot
>> before
>>         rootfs may be available.
>>   +config TI_K3_RINGACC
>> +    tristate "K3 Ring accelerator Sub System"
>> +    depends on ARCH_K3 || COMPILE_TEST
>> +    depends on TI_SCI_INTA_IRQCHIP
>> +    default y
>> +    help
>> +      Say y here to support the K3 Ring accelerator module.
>> +      The Ring Accelerator (RINGACC or RA)  provides hardware
>> acceleration
>> +      to enable straightforward passing of work between a producer
>> +      and a consumer. There is one RINGACC module per NAVSS on TI
>> AM65x SoCs
>> +      If unsure, say N.
>> +
>> +config TI_K3_RINGACC_DEBUG
>> +    tristate "K3 Ring accelerator Sub System tests and debug"
>> +    depends on TI_K3_RINGACC
>> +    default n
>> +
>>   endif # SOC_TI
>>     config TI_SCI_INTA_MSI_DOMAIN
>> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
>> index b3868d392d4f..cc4bc8b08bf5 100644
>> --- a/drivers/soc/ti/Makefile
>> +++ b/drivers/soc/ti/Makefile
>> @@ -9,3 +9,4 @@ obj-$(CONFIG_AMX3_PM)            += pm33xx.o
>>   obj-$(CONFIG_WKUP_M3_IPC)        += wkup_m3_ipc.o
>>   obj-$(CONFIG_TI_SCI_PM_DOMAINS)        += ti_sci_pm_domains.o
>>   obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)    += ti_sci_inta_msi.o
>> +obj-$(CONFIG_TI_K3_RINGACC)        += k3-ringacc.o
>> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
>> new file mode 100644
>> index 000000000000..401dfc963319
>> --- /dev/null
>> +++ b/drivers/soc/ti/k3-ringacc.c
>> @@ -0,0 +1,1191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * TI K3 NAVSS Ring Accelerator subsystem driver
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/soc/ti/k3-ringacc.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +#include <linux/soc/ti/ti_sci_inta_msi.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/irqdomain.h>
>> +
>> +static LIST_HEAD(k3_ringacc_list);
>> +static DEFINE_MUTEX(k3_ringacc_list_lock);
>> +
>> +#ifdef CONFIG_TI_K3_RINGACC_DEBUG
>> +#define    k3_nav_dbg(dev, arg...) dev_err(dev, arg)
> 
> dev_err seems exaggeration for debug purposes, maybe just dev_info.
> 
>> +static    void dbg_writel(u32 v, void __iomem *reg)
>> +{
>> +    pr_err("WRITEL(32): v(%08X)-->reg(%p)\n", v, reg);
> 
> Again, maybe just pr_info.

I think I'll just drop CONFIG_TI_K3_RINGACC_DEBUG altogether along with
dbg_writel/dbg_readl/k3_nav_dbg and use dev_dbg() when appropriate.

> 
>> +    writel(v, reg);
>> +}
>> +
>> +static    u32 dbg_readl(void __iomem *reg)
>> +{
>> +    u32 v;
>> +
>> +    v = readl(reg);
>> +    pr_err("READL(32): v(%08X)<--reg(%p)\n", v, reg);
>> +    return v;
>> +}
>> +#else
>> +#define    k3_nav_dbg(dev, arg...) dev_dbg(dev, arg)
>> +#define dbg_writel(v, reg) writel(v, reg)
> 
> Do you need to use hard writel, writel_relaxed is not enough?

not sure if we really need the barriers, but __raw_writel() should be
fine here imho

>> +
>> +#define dbg_readl(reg) readl(reg)
> 
> Same as above but for read?

__raw_readl() could be fine in also.

...

>> +/**
>> + * struct k3_ringacc - Rings accelerator descriptor
>> + *
>> + * @dev - pointer on RA device
>> + * @proxy_gcfg - RA proxy global config registers
>> + * @proxy_target_base - RA proxy datapath region
>> + * @num_rings - number of ring in RA
>> + * @rm_gp_range - general purpose rings range from tisci
>> + * @dma_ring_reset_quirk - DMA reset w/a enable
>> + * @num_proxies - number of RA proxies
>> + * @rings - array of rings descriptors (struct @k3_ring)
>> + * @list - list of RAs in the system
>> + * @tisci - pointer ti-sci handle
>> + * @tisci_ring_ops - ti-sci rings ops
>> + * @tisci_dev_id - ti-sci device id
>> + */
>> +struct k3_ringacc {
>> +    struct device *dev;
>> +    struct k3_ringacc_proxy_gcfg_regs __iomem *proxy_gcfg;
>> +    void __iomem *proxy_target_base;
>> +    u32 num_rings; /* number of rings in Ringacc module */
>> +    unsigned long *rings_inuse;
>> +    struct ti_sci_resource *rm_gp_range;
>> +
>> +    bool dma_ring_reset_quirk;
>> +    u32 num_proxies;
>> +    unsigned long *proxy_inuse;
> 
> proxy_inuse is not documented above.

I see, I'll update the documentation.

>> +
>> +    struct k3_ring *rings;
>> +    struct list_head list;
>> +    struct mutex req_lock; /* protect rings allocation */
>> +
>> +    const struct ti_sci_handle *tisci;
>> +    const struct ti_sci_rm_ringacc_ops *tisci_ring_ops;
>> +    u32  tisci_dev_id;
>> +};
>> +
>> +static long k3_ringacc_ring_get_fifo_pos(struct k3_ring *ring)
>> +{
>> +    return K3_RINGACC_FIFO_WINDOW_SIZE_BYTES -
>> +           (4 << ring->elm_size);
>> +}
>> +
>> +static void *k3_ringacc_get_elm_addr(struct k3_ring *ring, u32 idx)
>> +{
>> +    return (idx * (4 << ring->elm_size) + ring->ring_mem_virt);
> 
> The arithmetic here seems backwards compared to most other code I've
> seen. It would be more readable if you have it like:
> 
> ring->ring_mem_virt + idx * (4 << ring->elm_size);

Yes, I'll update.

> 
>> +}
>> +
>> +static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem);
>> +static int k3_ringacc_ring_pop_mem(struct k3_ring *ring, void *elem);
>> +
>> +static struct k3_ring_ops k3_ring_mode_ring_ops = {
>> +        .push_tail = k3_ringacc_ring_push_mem,
>> +        .pop_head = k3_ringacc_ring_pop_mem,
>> +};
>> +
>> +static int k3_ringacc_ring_push_io(struct k3_ring *ring, void *elem);
>> +static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem);
>> +static int k3_ringacc_ring_push_head_io(struct k3_ring *ring, void
>> *elem);
>> +static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void
>> *elem);
>> +
>> +static struct k3_ring_ops k3_ring_mode_msg_ops = {
>> +        .push_tail = k3_ringacc_ring_push_io,
>> +        .push_head = k3_ringacc_ring_push_head_io,
>> +        .pop_tail = k3_ringacc_ring_pop_tail_io,
>> +        .pop_head = k3_ringacc_ring_pop_io,
>> +};
>> +
>> +static int k3_ringacc_ring_push_head_proxy(struct k3_ring *ring, void
>> *elem);
>> +static int k3_ringacc_ring_push_tail_proxy(struct k3_ring *ring, void
>> *elem);
>> +static int k3_ringacc_ring_pop_head_proxy(struct k3_ring *ring, void
>> *elem);
>> +static int k3_ringacc_ring_pop_tail_proxy(struct k3_ring *ring, void
>> *elem);
>> +
>> +static struct k3_ring_ops k3_ring_mode_proxy_ops = {
>> +        .push_tail = k3_ringacc_ring_push_tail_proxy,
>> +        .push_head = k3_ringacc_ring_push_head_proxy,
>> +        .pop_tail = k3_ringacc_ring_pop_tail_proxy,
>> +        .pop_head = k3_ringacc_ring_pop_head_proxy,
>> +};
>> +
>> +#ifdef CONFIG_TI_K3_RINGACC_DEBUG
>> +void k3_ringacc_ring_dump(struct k3_ring *ring)
>> +{
>> +    struct device *dev = ring->parent->dev;
>> +
>> +    k3_nav_dbg(dev, "dump ring: %d\n", ring->ring_id);
>> +    k3_nav_dbg(dev, "dump mem virt %p, dma %pad\n",
>> +           ring->ring_mem_virt, &ring->ring_mem_dma);
>> +    k3_nav_dbg(dev, "dump elmsize %d, size %d, mode %d, proxy_id %d\n",
>> +           ring->elm_size, ring->size, ring->mode, ring->proxy_id);
>> +
>> +    k3_nav_dbg(dev, "dump ring_rt_regs: db%08x\n",
>> +           readl(&ring->rt->db));
> 
> Why not use readl_relaxed in this func?

__raw_readl() might be enough?

> 
>> +    k3_nav_dbg(dev, "dump occ%08x\n",
>> +           readl(&ring->rt->occ));
>> +    k3_nav_dbg(dev, "dump indx%08x\n",
>> +           readl(&ring->rt->indx));
>> +    k3_nav_dbg(dev, "dump hwocc%08x\n",
>> +           readl(&ring->rt->hwocc));
>> +    k3_nav_dbg(dev, "dump hwindx%08x\n",
>> +           readl(&ring->rt->hwindx));
>> +
>> +    if (ring->ring_mem_virt)
>> +        print_hex_dump(KERN_ERR, "dump ring_mem_virt ",
>> +                   DUMP_PREFIX_NONE, 16, 1,
>> +                   ring->ring_mem_virt, 16 * 8, false);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_dump);
> 
> Do you really need to export a debug function?

It might come helpful for clients to dump the ring status runtime, but
since we don't have users, I'll move it to static.

>> +#endif
>> +
>> +struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>> +                    int id, u32 flags)
>> +{
>> +    int proxy_id = K3_RINGACC_PROXY_NOT_USED;
>> +
>> +    mutex_lock(&ringacc->req_lock);
>> +
>> +    if (id == K3_RINGACC_RING_ID_ANY) {
>> +        /* Request for any general purpose ring */
>> +        struct ti_sci_resource_desc *gp_rings =
>> +                        &ringacc->rm_gp_range->desc[0];
>> +        unsigned long size;
>> +
>> +        size = gp_rings->start + gp_rings->num;
>> +        id = find_next_zero_bit(ringacc->rings_inuse, size,
>> +                    gp_rings->start);
>> +        if (id == size)
>> +            goto error;
>> +    } else if (id < 0) {
>> +        goto error;
>> +    }
>> +
>> +    if (test_bit(id, ringacc->rings_inuse) &&
>> +        !(ringacc->rings[id].flags & K3_RING_FLAG_SHARED))
>> +        goto error;
>> +    else if (ringacc->rings[id].flags & K3_RING_FLAG_SHARED)
>> +        goto out;
>> +
>> +    if (flags & K3_RINGACC_RING_USE_PROXY) {
>> +        proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
>> +                          ringacc->num_proxies, 0);
>> +        if (proxy_id == ringacc->num_proxies)
>> +            goto error;
>> +    }
>> +
>> +    if (!try_module_get(ringacc->dev->driver->owner))
>> +        goto error;
>> +
>> +    if (proxy_id != K3_RINGACC_PROXY_NOT_USED) {
>> +        set_bit(proxy_id, ringacc->proxy_inuse);
>> +        ringacc->rings[id].proxy_id = proxy_id;
>> +        k3_nav_dbg(ringacc->dev, "Giving ring#%d proxy#%d\n",
>> +               id, proxy_id);
>> +    } else {
>> +        k3_nav_dbg(ringacc->dev, "Giving ring#%d\n", id);
>> +    }
>> +
>> +    set_bit(id, ringacc->rings_inuse);
>> +out:
>> +    ringacc->rings[id].use_count++;
>> +    mutex_unlock(&ringacc->req_lock);
>> +    return &ringacc->rings[id];
>> +
>> +error:
>> +    mutex_unlock(&ringacc->req_lock);
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
>> +
>> +static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
>> +{
>> +    struct k3_ringacc *ringacc = ring->parent;
>> +    int ret;
>> +
>> +    ret = ringacc->tisci_ring_ops->config(
>> +            ringacc->tisci,
>> +            TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID,
>> +            ringacc->tisci_dev_id,
>> +            ring->ring_id,
>> +            0,
>> +            0,
>> +            ring->size,
>> +            0,
>> +            0,
>> +            0);
>> +    if (ret)
>> +        dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx
>> %d\n",
>> +            ret, ring->ring_id);
> 
> Return value of sci ops is masked, why not return it and let the caller
> handle it properly?
> 
> Same comment for anything similar that follows.

Hrm, there is not much a caller can do other than PANIC in case the ring
configuration fails.
I can probagate the error, but not sure what action can be taken, if any.

>> +}
>> +
>> +void k3_ringacc_ring_reset(struct k3_ring *ring)
>> +{
>> +    if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
>> +        return;
>> +
>> +    ring->occ = 0;
>> +    ring->free = 0;
>> +    ring->rindex = 0;
>> +    ring->windex = 0;
>> +
>> +    k3_ringacc_ring_reset_sci(ring);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset);
>> +
>> +static void k3_ringacc_ring_reconfig_qmode_sci(struct k3_ring *ring,
>> +                           enum k3_ring_mode mode)
>> +{
>> +    struct k3_ringacc *ringacc = ring->parent;
>> +    int ret;
>> +
>> +    ret = ringacc->tisci_ring_ops->config(
>> +            ringacc->tisci,
>> +            TI_SCI_MSG_VALUE_RM_RING_MODE_VALID,
>> +            ringacc->tisci_dev_id,
>> +            ring->ring_id,
>> +            0,
>> +            0,
>> +            0,
>> +            mode,
>> +            0,
>> +            0);
>> +    if (ret)
>> +        dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx
>> %d\n",
>> +            ret, ring->ring_id);
>> +}
>> +
>> +void k3_ringacc_ring_reset_dma(struct k3_ring *ring, u32 occ)
>> +{
>> +    if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
>> +        return;
>> +
>> +    if (!ring->parent->dma_ring_reset_quirk)
>> +        return;
>> +
>> +    if (!occ)
>> +        occ = dbg_readl(&ring->rt->occ);
>> +
>> +    if (occ) {
>> +        u32 db_ring_cnt, db_ring_cnt_cur;
>> +
>> +        k3_nav_dbg(ring->parent->dev, "%s %u occ: %u\n", __func__,
>> +               ring->ring_id, occ);
>> +        /* 2. Reset the ring */
> 
> 2? Where is 1?

Oh, I'll fix the numbering.

> 
>> +        k3_ringacc_ring_reset_sci(ring);
>> +
>> +        /*
>> +         * 3. Setup the ring in ring/doorbell mode
>> +         * (if not already in this mode)
>> +         */
>> +        if (ring->mode != K3_RINGACC_RING_MODE_RING)
>> +            k3_ringacc_ring_reconfig_qmode_sci(
>> +                    ring, K3_RINGACC_RING_MODE_RING);
>> +        /*
>> +         * 4. Ring the doorbell 2**22 – ringOcc times.
>> +         * This will wrap the internal UDMAP ring state occupancy
>> +         * counter (which is 21-bits wide) to 0.
>> +         */
>> +        db_ring_cnt = (1U << 22) - occ;
>> +
>> +        while (db_ring_cnt != 0) {
>> +            /*
>> +             * Ring the doorbell with the maximum count each
>> +             * iteration if possible to minimize the total
>> +             * of writes
>> +             */
>> +            if (db_ring_cnt > K3_RINGACC_MAX_DB_RING_CNT)
>> +                db_ring_cnt_cur = K3_RINGACC_MAX_DB_RING_CNT;
>> +            else
>> +                db_ring_cnt_cur = db_ring_cnt;
>> +
>> +            writel(db_ring_cnt_cur, &ring->rt->db);
>> +            db_ring_cnt -= db_ring_cnt_cur;
>> +        }
>> +
>> +        /* 5. Restore the original ring mode (if not ring mode) */
>> +        if (ring->mode != K3_RINGACC_RING_MODE_RING)
>> +            k3_ringacc_ring_reconfig_qmode_sci(ring, ring->mode);
>> +    }
>> +
>> +    /* 2. Reset the ring */
> 
> Again 2?

I'll drop the '2.'

> 
>> +    k3_ringacc_ring_reset(ring);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset_dma);
>> +
>> +static void k3_ringacc_ring_free_sci(struct k3_ring *ring)
>> +{
>> +    struct k3_ringacc *ringacc = ring->parent;
>> +    int ret;
>> +
>> +    ret = ringacc->tisci_ring_ops->config(
>> +            ringacc->tisci,
>> +            TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER,
>> +            ringacc->tisci_dev_id,
>> +            ring->ring_id,
>> +            0,
>> +            0,
>> +            0,
>> +            0,
>> +            0,
>> +            0);
>> +    if (ret)
>> +        dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
>> +            ret, ring->ring_id);
>> +}
>> +
>> +int k3_ringacc_ring_free(struct k3_ring *ring)
>> +{
>> +    struct k3_ringacc *ringacc;
>> +
>> +    if (!ring)
>> +        return -EINVAL;
>> +
>> +    ringacc = ring->parent;
>> +
>> +    k3_nav_dbg(ring->parent->dev, "flags: 0x%08x\n", ring->flags);
>> +
>> +    if (!test_bit(ring->ring_id, ringacc->rings_inuse))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&ringacc->req_lock);
>> +
>> +    if (--ring->use_count)
>> +        goto out;
>> +
>> +    if (!(ring->flags & K3_RING_FLAG_BUSY))
>> +        goto no_init;
>> +
>> +    k3_ringacc_ring_free_sci(ring);
>> +
>> +    dma_free_coherent(ringacc->dev,
>> +              ring->size * (4 << ring->elm_size),
>> +              ring->ring_mem_virt, ring->ring_mem_dma);
>> +    ring->flags = 0;
>> +    ring->ops = NULL;
>> +    if (ring->proxy_id != K3_RINGACC_PROXY_NOT_USED) {
>> +        clear_bit(ring->proxy_id, ringacc->proxy_inuse);
>> +        ring->proxy = NULL;
>> +        ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
>> +    }
>> +
>> +no_init:
>> +    clear_bit(ring->ring_id, ringacc->rings_inuse);
>> +
>> +    module_put(ringacc->dev->driver->owner);
>> +
>> +out:
>> +    mutex_unlock(&ringacc->req_lock);
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_free);
>> +
>> +u32 k3_ringacc_get_ring_id(struct k3_ring *ring)
>> +{
>> +    if (!ring)
>> +        return -EINVAL;
>> +
>> +    return ring->ring_id;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_id);
>> +
>> +u32 k3_ringacc_get_tisci_dev_id(struct k3_ring *ring)
>> +{
>> +    if (!ring)
>> +        return -EINVAL;
>> +
> 
> What if parent is NULL? Can it ever be here?

No, parent can not be NULL as the client would not have the ring in the
first place.

> 
>> +    return ring->parent->tisci_dev_id;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_get_tisci_dev_id);
>> +
>> +int k3_ringacc_get_ring_irq_num(struct k3_ring *ring)
>> +{
>> +    int irq_num;
>> +
>> +    if (!ring)
>> +        return -EINVAL;
>> +
>> +    irq_num = ti_sci_inta_msi_get_virq(ring->parent->dev,
>> ring->ring_id);
>> +    if (irq_num <= 0)
>> +        irq_num = -EINVAL;
>> +    return irq_num;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_irq_num);
>> +
>> +static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
>> +{
>> +    struct k3_ringacc *ringacc = ring->parent;
>> +    u32 ring_idx;
>> +    int ret;
>> +
>> +    if (!ringacc->tisci)
>> +        return -EINVAL;
>> +
>> +    ring_idx = ring->ring_id;
>> +    ret = ringacc->tisci_ring_ops->config(
>> +            ringacc->tisci,
>> +            TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER,
>> +            ringacc->tisci_dev_id,
>> +            ring_idx,
>> +            lower_32_bits(ring->ring_mem_dma),
>> +            upper_32_bits(ring->ring_mem_dma),
>> +            ring->size,
>> +            ring->mode,
>> +            ring->elm_size,
>> +            0);
>> +    if (ret)
>> +        dev_err(ringacc->dev, "TISCI config ring fail (%d) ring_idx
>> %d\n",
>> +            ret, ring_idx);
>> +
>> +    return ret;
>> +}
>> +
>> +int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
>> +{
>> +    struct k3_ringacc *ringacc = ring->parent;
>> +    int ret = 0;
>> +
>> +    if (!ring || !cfg)
>> +        return -EINVAL;
>> +    if (cfg->elm_size > K3_RINGACC_RING_ELSIZE_256 ||
>> +        cfg->mode > K3_RINGACC_RING_MODE_QM ||
>> +        cfg->size & ~K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK ||
>> +        !test_bit(ring->ring_id, ringacc->rings_inuse))
>> +        return -EINVAL;
>> +
>> +    if (ring->use_count != 1)
> 
> Hmm, isn't this a failure actually?

Yes, it is: -EBUSY

>> +        return 0;
>> +
>> +    ring->size = cfg->size;
>> +    ring->elm_size = cfg->elm_size;
>> +    ring->mode = cfg->mode;
>> +    ring->occ = 0;
>> +    ring->free = 0;
>> +    ring->rindex = 0;
>> +    ring->windex = 0;
>> +
>> +    if (ring->proxy_id != K3_RINGACC_PROXY_NOT_USED)
>> +        ring->proxy = ringacc->proxy_target_base +
>> +                  ring->proxy_id * K3_RINGACC_PROXY_TARGET_STEP;
>> +
>> +    switch (ring->mode) {
>> +    case K3_RINGACC_RING_MODE_RING:
>> +        ring->ops = &k3_ring_mode_ring_ops;
>> +        break;
>> +    case K3_RINGACC_RING_MODE_QM:
>> +        /*
>> +         * In Queue mode elm_size can be 8 only and each operation
>> +         * uses 2 element slots
>> +         */
>> +        if (cfg->elm_size != K3_RINGACC_RING_ELSIZE_8 ||
>> +            cfg->size % 2)
>> +            goto err_free_proxy;
>> +        /* else, fall through */
>> +    case K3_RINGACC_RING_MODE_MESSAGE:
>> +        if (ring->proxy)
>> +            ring->ops = &k3_ring_mode_proxy_ops;
>> +        else
>> +            ring->ops = &k3_ring_mode_msg_ops;
>> +        break;
>> +    default:
>> +        ring->ops = NULL;
>> +        ret = -EINVAL;
>> +        goto err_free_proxy;
>> +    };
>> +
>> +    ring->ring_mem_virt =
>> +            dma_alloc_coherent(ringacc->dev,
>> +                       ring->size * (4 << ring->elm_size),
>> +                       &ring->ring_mem_dma, GFP_KERNEL);
>> +    if (!ring->ring_mem_virt) {
>> +        dev_err(ringacc->dev, "Failed to alloc ring mem\n");
>> +        ret = -ENOMEM;
>> +        goto err_free_ops;
>> +    }
>> +
>> +    ret = k3_ringacc_ring_cfg_sci(ring);
>> +
>> +    if (ret)
>> +        goto err_free_mem;
>> +
>> +    ring->flags |= K3_RING_FLAG_BUSY;
>> +    ring->flags |= (cfg->flags & K3_RINGACC_RING_SHARED) ?
>> +            K3_RING_FLAG_SHARED : 0;
>> +
>> +    k3_ringacc_ring_dump(ring);
>> +
>> +    return 0;
>> +
>> +err_free_mem:
>> +    dma_free_coherent(ringacc->dev,
>> +              ring->size * (4 << ring->elm_size),
>> +              ring->ring_mem_virt,
>> +              ring->ring_mem_dma);
>> +err_free_ops:
>> +    ring->ops = NULL;
>> +err_free_proxy:
>> +    ring->proxy = NULL;
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_cfg);
>> +
>> +u32 k3_ringacc_ring_get_size(struct k3_ring *ring)
>> +{
>> +    if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
>> +        return -EINVAL;
>> +
>> +    return ring->size;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_size);
>> +
>> +u32 k3_ringacc_ring_get_free(struct k3_ring *ring)
>> +{
>> +    if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
>> +        return -EINVAL;
>> +
>> +    if (!ring->free)
>> +        ring->free = ring->size - dbg_readl(&ring->rt->occ);
>> +
>> +    return ring->free;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_free);
>> +
>> +u32 k3_ringacc_ring_get_occ(struct k3_ring *ring)
>> +{
>> +    if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
>> +        return -EINVAL;
>> +
>> +    return dbg_readl(&ring->rt->occ);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_occ);
>> +
>> +u32 k3_ringacc_ring_is_full(struct k3_ring *ring)
>> +{
>> +    return !k3_ringacc_ring_get_free(ring);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_is_full);
>> +
>> +enum k3_ringacc_access_mode {
>> +    K3_RINGACC_ACCESS_MODE_PUSH_HEAD,
>> +    K3_RINGACC_ACCESS_MODE_POP_HEAD,
>> +    K3_RINGACC_ACCESS_MODE_PUSH_TAIL,
>> +    K3_RINGACC_ACCESS_MODE_POP_TAIL,
>> +    K3_RINGACC_ACCESS_MODE_PEEK_HEAD,
>> +    K3_RINGACC_ACCESS_MODE_PEEK_TAIL,
>> +};
>> +
>> +static int k3_ringacc_ring_cfg_proxy(struct k3_ring *ring,
>> +                     enum k3_ringacc_proxy_access_mode mode)
>> +{
>> +    u32 val;
>> +
>> +    val = ring->ring_id;
>> +    val |= mode << 16;
>> +    val |= ring->elm_size << 24;
> 
> Would be nice to have these magic shifts as defines.

OK, I'll add defines for the magic shifts.

> 
>> +    dbg_writel(val, &ring->proxy->control);
>> +    return 0;
>> +}
>> +

Thanks for the review,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
