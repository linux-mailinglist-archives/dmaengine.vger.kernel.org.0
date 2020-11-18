Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE32B7D16
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKRLzw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 06:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKRLzw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 06:55:52 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECFC241A5;
        Wed, 18 Nov 2020 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605700551;
        bh=SsbFWH8WRjSfm06Mhwwk+gbH5/tPQQYvBo6/Q4ptO+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4BFS8ALIg3a4ZvAahcPv0J+gSjZewBISsoLBwClHCLyWBiGgaQ88kKa2tm1/dc2F
         V8GBeiXHs1foPwHahQPWpsvX9XvSrO+cf2i+VobsdHXiBZcjjHwMMDftmVWlcOCbzl
         B67n+N55npWrj9lfNgUuoxleKeXdS1MNVQMDJmus=
Date:   Wed, 18 Nov 2020 17:25:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <20201118115545.GQ50232@vkoul-mobl>
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602833947-82021-2-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-10-20, 02:39, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Adding support for AMD PTDMA controller. It performs high-bandwidth

Add support or Adds support.. would be apt!

> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/dma/Kconfig           |   2 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/ptdma/Kconfig     |  11 ++
>  drivers/dma/ptdma/Makefile    |  10 ++
>  drivers/dma/ptdma/ptdma-dev.c | 296 +++++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c | 252 +++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma.h     | 316 ++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 894 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33b27e6..f6ae0d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -943,6 +943,12 @@ S:	Supported
>  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  F:	drivers/net/ethernet/amd/xgbe/
>  
> +AMD PTDMA DRIVER
> +M:	Sanjay R Mehta <sanju.mehta@amd.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/ptdma/
> +
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 518a143..a21c983 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -748,6 +748,8 @@ source "drivers/dma/ti/Kconfig"
>  
>  source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>  
> +source "drivers/dma/ptdma/Kconfig"
> +
>  # clients
>  comment "DMA Clients"
>  	depends on DMA_ENGINE
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index e60f813..2785756 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ZX_DMA) += zx_dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
> +obj-$(CONFIG_AMD_PTDMA) += ptdma/

Please keep this sorted :(

>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
> new file mode 100644
> index 0000000..f93f9c2
> --- /dev/null
> +++ b/drivers/dma/ptdma/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_PTDMA
> +	tristate  "AMD PassThru DMA Engine"
> +	depends on X86_64 && PCI
> +	help
> +	  Enable support for the AMD PTDMA controller.  This controller
> +	  provides DMA capabilities & performs high bandwidth memory to
> +	  memory and IO copy operation and performs DMA transfer through
> +	  queue based descriptor management. This DMA controller is intended
> +	  to use with AMD Non-Transparent Bridge devices and not for general
> +	  purpose slave DMA.

s/slave/peripheral

> +static int pt_core_execute_cmd(struct ptdma_desc *desc,
> +			       struct pt_cmd_queue *cmd_q)
> +{
> +	__le32 *mp;
> +	u32 *dp;
> +	u32 tail;
> +	int i;
> +
> +	if (desc->dw0.soc) {
> +		desc->dw0.ioc = 1;
> +		desc->dw0.soc = 0;
> +	}
> +	mutex_lock(&cmd_q->q_mutex);
> +
> +	mp = (__le32 *)&cmd_q->qbase[cmd_q->qidx];

why not make the qidx __le32 instead of int ?

> +	dp = (u32 *)desc;
> +	for (i = 0; i < 8; i++)

why 8..?

> +		mp[i] = cpu_to_le32(dp[i]); /* handle endianness */

Where is this used..? Why not drop this..

> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
> +{
> +	struct pt_device *pt = (struct pt_device *)data;

why do you need cast away from void *

> +int pt_core_init(struct pt_device *pt)
> +{
> +	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	u32 dma_addr_lo, dma_addr_hi;
> +	struct device *dev = pt->dev;
> +	struct dma_pool *dma_pool;
> +	int ret;
> +
> +	/* Allocate a dma pool for the queue */
> +	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
> +
> +	dma_pool = dma_pool_create(dma_pool_name, dev,
> +				   PT_DMAPOOL_MAX_SIZE,
> +				   PT_DMAPOOL_ALIGN, 0);
> +	if (!dma_pool) {
> +		dev_err(dev, "unable to allocate dma pool\n");
> +		ret = -ENOMEM;
> +		return ret;

return -ENOMEM?

> +	}
> +
> +	/* ptdma core initialisation */
> +	iowrite32(CMD_CONFIG_VHB_EN, pt->io_regs + CMD_CONFIG_OFFSET);
> +	iowrite32(CMD_QUEUE_PRIO, pt->io_regs + CMD_QUEUE_PRIO_OFFSET);
> +	iowrite32(CMD_TIMEOUT_DISABLE, pt->io_regs + CMD_TIMEOUT_OFFSET);
> +	iowrite32(CMD_CLK_GATE_CONFIG, pt->io_regs + CMD_CLK_GATE_CTL_OFFSET);
> +	iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
> +
> +	cmd_q->pt = pt;
> +	cmd_q->dma_pool = dma_pool;
> +	mutex_init(&cmd_q->q_mutex);
> +
> +	/* Page alignment satisfies our needs for N <= 128 */
> +	cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
> +	cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize,
> +					  &cmd_q->qbase_dma,
> +					  GFP_KERNEL);
> +	if (!cmd_q->qbase) {
> +		dev_err(dev, "unable to allocate command queue\n");
> +		ret = -ENOMEM;
> +		goto e_dma_alloc;
> +	}
> +
> +	cmd_q->qidx = 0;
> +
> +	/* Preset some register values */
> +	cmd_q->reg_control = pt->io_regs + CMD_Q_STATUS_INCR;
> +	pt_init_cmdq_regs(cmd_q);
> +
> +	/* Turn off the queues and disable interrupts until ready */
> +	pt_core_disable_queue_interrupts(pt);
> +
> +	cmd_q->qcontrol = 0; /* Start with nothing */
> +	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
> +
> +	ioread32(cmd_q->reg_int_status);
> +	ioread32(cmd_q->reg_status);
> +
> +	/* Clear the interrupt status */
> +	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_interrupt_status);
> +
> +	/* Request an irq */
> +	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, pt->name, pt);
> +	if (ret) {
> +		dev_err(dev, "unable to allocate an IRQ\n");

Do log the error while you are it!

> +		goto e_pool;
> +	}
> +
> +	/* Update the device registers with queue information.  */
> +
> +	cmd_q->qcontrol &= ~(CMD_Q_SIZE << CMD_Q_SHIFT);
> +	cmd_q->qcontrol |= QUEUE_SIZE_VAL << CMD_Q_SHIFT;

Please use helpers in bitfield.h to do the shifts for you, no need to
define the shift values

> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/sched.h>

why do you need sched.h here?

> +
> +#include "ptdma.h"
> +
> +/* Ever-increasing value to produce unique unit numbers */
> +static atomic_t pt_ordinal;

What is the need of that?

> +static int pt_get_irqs(struct pt_device *pt)
> +{
> +	struct device *dev = pt->dev;
> +	int ret;
> +
> +	ret = pt_get_msix_irqs(pt);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI-X vectors, try MSI */
> +	dev_dbg(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> +	ret = pt_get_msi_irq(pt);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI interrupt */
> +	dev_dbg(dev, "could not enable MSI (%d)\n", ret);

Should this not be an error?

> +/*
> + * descriptor for PTDMA commands
> + * 8 32-bit words:
> + * word 0: function; engine; control bits
> + * word 1: length of source data
> + * word 2: low 32 bits of source pointer
> + * word 3: upper 16 bits of source pointer; source memory type
> + * word 4: low 32 bits of destination pointer
> + * word 5: upper 16 bits of destination pointer; destination memory type
> + * word 6: reserved 32 bits
> + * word 7: reserved 32 bits
> + */
> +
> +union dword0 {
> +	struct {
> +		unsigned int soc:1;
> +		unsigned int ioc:1;
> +		unsigned int rsvd1:1;
> +		unsigned int init:1;
> +		unsigned int eom:1;
> +		unsigned int function:15;
> +		unsigned int engine:4;
> +		unsigned int prot:1;
> +		unsigned int rsvd2:7;
> +	};

Do you really want to use union and bitfields here, this seem like HW
description, best to use FIELD_PREP or FIELD_GET for these

Been there, done that would advise to avoid this approach.

-- 
~Vinod
