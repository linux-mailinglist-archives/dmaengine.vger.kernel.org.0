Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B47B7C9E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJDJyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjJDJyP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 05:54:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B54AC;
        Wed,  4 Oct 2023 02:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4415AC433C7;
        Wed,  4 Oct 2023 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696413250;
        bh=DsquM9tEx33nGwumQu0NWjQmqydj6gI4nrLb6Np8JcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9NAt65+jEmMoTZVGhWXDdW7Co7+koML4kUDCD2AJQCoZQjY+KRSyLo3yuTI8K6Ux
         +DS7JVqHb9DIyYA/9ysCCYlSwu0ZhebzR9IE2FQa4ogBdCgC8c/c8nm/pA210/AcNN
         3wJRHKkxGPSDrHqF8rNKOg2cnJY5LDURYPDAjdvb7wu40RXZmKzq0mVMBKMoQetnuT
         1VF0OpbsWPpQCriq0o+ml9QkERfK0qKeCf933nxsf6vTkmJKSP/8P5hfjO60ahm4i+
         0+8nMtzPg3h+PlQj1rbet3gIS2Bq2l1YHVItxfUsPQEQKgdwXcaaYHhViFDJ0E/Kq8
         pt/od4pJ3xcIg==
Date:   Wed, 4 Oct 2023 15:24:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller driver
 with multi channel
Message-ID: <ZR02PT/k0op8T71U@matsya>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-09-23, 14:25, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Add support for AMD AE4DMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  MAINTAINERS                     |   6 +
>  drivers/dma/Kconfig             |   2 +
>  drivers/dma/Makefile            |   1 +
>  drivers/dma/ae4dma/Kconfig      |  11 ++
>  drivers/dma/ae4dma/Makefile     |  10 ++
>  drivers/dma/ae4dma/ae4dma-dev.c | 320 +++++++++++++++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma-pci.c | 247 +++++++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma.h     | 338 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 935 insertions(+)
>  create mode 100644 drivers/dma/ae4dma/Kconfig
>  create mode 100644 drivers/dma/ae4dma/Makefile
>  create mode 100644 drivers/dma/ae4dma/ae4dma-dev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma-pci.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d590ce3..fdcc6d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -891,6 +891,12 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
>  F:	drivers/infiniband/hw/efa/
>  F:	include/uapi/rdma/efa-abi.h
>  
> +AMD AE4DMA DRIVER
> +M:	Sanjay R Mehta <sanju.mehta@amd.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/ae4dma/
> +
>  AMD CDX BUS DRIVER
>  M:	Nipun Gupta <nipun.gupta@amd.com>
>  M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 08fdd0e..b26dbfb 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -777,6 +777,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>  
>  source "drivers/dma/lgm/Kconfig"
>  
> +source "drivers/dma/ae4dma/Kconfig"

There is another amd driver on the list, I suggest move all of these to
amd/ and have one kconfig inside amd/

> +
>  # clients
>  comment "DMA Clients"
>  	depends on DMA_ENGINE
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a4fd1ce..513d87f 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
> new file mode 100644
> index 0000000..1cda9de
> --- /dev/null
> +++ b/drivers/dma/ae4dma/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_AE4DMA
> +	tristate  "AMD AE4DMA Engine"
> +	depends on X86_64 && PCI
> +	help
> +	  Enabling this option provides support for the AMD AE4DMA controller,
> +	  which offers DMA capabilities for high-bandwidth memory-to-memory and
> +	  I/O copy operations. The controller utilizes a queue-based descriptor
> +	  management system for efficient DMA transfers. It is specifically
> +	  designed to be used in conjunction with AMD Non-Transparent Bridge devices
> +	  and is not intended for general-purpose peripheral DMA functionality.
> diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
> new file mode 100644
> index 0000000..db9cab1
> --- /dev/null
> +++ b/drivers/dma/ae4dma/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD AE4DMA driver
> +#
> +
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
> +
> +ae4dma-objs := ae4dma-dev.o
> +
> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> diff --git a/drivers/dma/ae4dma/ae4dma-dev.c b/drivers/dma/ae4dma/ae4dma-dev.c
> new file mode 100644
> index 0000000..a3c50a2
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma-dev.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD AE4DMA device driver
> + * -- Based on the PTDMA driver
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/debugfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +
> +#include "ae4dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +static unsigned int max_hw_q = 1;
> +module_param(max_hw_q, uint, 0444);
> +MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero value less than or equal to 16, default: 1)");
> +
> +/* Human-readable error strings */
> +static char *ae4_error_codes[] = {
> +	"",
> +	"ERR 01: INVALID HEADER DW0",
> +	"ERR 02: INVALID STATUS",
> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 06: INVALID ALIGNMENT",
> +	"ERR 07: INVALID DESCRIPTOR",
> +};
> +
> +static void ae4_log_error(struct ae4_device *d, int e)
> +{
> +	if (e <= 7)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> +	else if (e > 7 && e <= 15)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 15 && e <= 31)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 31 && e <= 63)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	else if (e > 63 && e <= 127)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> +	else if (e > 127 && e <= 255)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);

why info level? It should err going by fn description

> +}
> +
> +void ae4_start_queue(struct ae4_cmd_queue *cmd_q)
> +{
> +	/* Turn on the run bit */
> +	iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control);
> +}
> +
> +void ae4_stop_queue(struct ae4_cmd_queue *cmd_q)
> +{
> +	/* Turn off the run bit */
> +	iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control);
> +}
> +
> +static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *cmd_q)
> +{
> +	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
> +	u8 *q_desc = (u8 *)&cmd_q->qbase[0];
> +	u32 tail_wi;
> +
> +	cmd_q->int_rcvd = 0;
> +
> +	if (soc) {
> +		desc->dw0 |= FIELD_PREP(DWORD0_IOC, desc->dw0);
> +		desc->dw0 &= ~DWORD0_SOC;
> +	}
> +	mutex_lock(&cmd_q->q_mutex);
> +
> +	/* Write Index of circular queue */
> +	tail_wi =  ioread32(cmd_q->reg_control + 0x10);
> +	q_desc += (tail_wi * 32);
> +
> +	/* Copy 32-byte command descriptor to hw queue. */
> +	memcpy(q_desc, desc, 32);
> +	cmd_q->qidx = (cmd_q->qidx + 1) % CMD_Q_LEN; // Increment q_desc id.
> +
> +	/* The data used by this command must be flushed to memory */
> +	wmb();
> +
> +	/* Write the new tail_wi address back to the queue register */
> +	tail_wi = (tail_wi + 1) % CMD_Q_LEN;
> +	iowrite32(tail_wi, cmd_q->reg_control + 0x10);
> +
> +	mutex_unlock(&cmd_q->q_mutex);
> +
> +	return 0;
> +}
> +
> +int ae4_core_perform_passthru(struct ae4_cmd_queue *cmd_q, struct ae4_passthru_engine *ae4_engine)

Who calls this, pls document the arguments for apis


> +{
> +	struct ae4dma_desc desc;
> +	struct ae4_device *ae4 = cmd_q->ae4;
> +
> +	cmd_q->cmd_error = 0;
> +	memset(&desc, 0, sizeof(desc));
> +	desc.dw0 = CMD_DESC_DW0_VAL;
> +	desc.dw1.status = 0;
> +	desc.dw1.err_code = 0;
> +	desc.dw1.desc_id = 0;

these are redundant, u already did memset

> +	desc.length = ae4_engine->src_len;
> +	desc.src_lo = upper_32_bits(ae4_engine->src_dma);
> +	desc.src_hi = lower_32_bits(ae4_engine->src_dma);
> +	desc.dst_lo = upper_32_bits(ae4_engine->dst_dma);
> +	desc.dst_hi = lower_32_bits(ae4_engine->dst_dma);
> +
> +	if (cmd_q->int_en)
> +		ae4_core_enable_queue_interrupts(ae4, cmd_q);
> +	else
> +		ae4_core_disable_queue_interrupts(ae4, cmd_q);
> +
> +	return ae4_core_execute_cmd(&desc, cmd_q);
> +}
> +
> +static void ae4_do_cmd_complete(struct tasklet_struct *t)
> +{
> +	struct ae4_cmd_queue *cmd_q = from_tasklet(cmd_q, t, irq_tasklet);
> +	unsigned long flags;
> +	struct ae4_cmd *cmd;
> +
> +	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
> +	cmd = list_first_entry(&cmd_q->cmd, struct ae4_cmd, entry);
> +	list_del(&cmd->entry);
> +	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
> +
> +	cmd->ae4_cmd_callback(cmd->data, cmd->ret);
> +}
> +
> +void ae4_check_status_trans(struct ae4_device *ae4, struct ae4_cmd_queue *cmd_q)
> +{
> +	u8 status;
> +	int head = ioread32(cmd_q->reg_control + 0x0C);
> +	struct ae4dma_desc *desc;
> +
> +	head = (head - 1) & (CMD_Q_LEN - 1);
> +	desc = &cmd_q->qbase[head];
> +
> +	status = desc->dw1.status;
> +	if (status) {
> +		cmd_q->int_status = status;
> +		if (status != 0x3) {

magic number

> +			/* On error, only save the first error value */
> +			cmd_q->cmd_error = desc->dw1.err_code;
> +			if (cmd_q->cmd_error) {
> +				/*
> +				 * Log the error and flush the queue by
> +				 * moving the head pointer
> +				 */
> +				ae4_log_error(cmd_q->ae4, cmd_q->cmd_error);
> +			}
> +		}
> +	}
> +}
> +
> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
> +{
> +	struct ae4_cmd_queue *cmd_q = data;
> +	struct ae4_device *ae4 = cmd_q->ae4;
> +	u32 status = ioread32(cmd_q->reg_control + 0x4);
> +	u8 q_intr_type = (status >> 24) & 0xf;
> +
> +	if (q_intr_type ==  0x4)
> +		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue desc error", q_intr_type);
> +	else if (q_intr_type ==  0x2)
> +		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue stopped", q_intr_type);
> +	else if (q_intr_type ==  0x1)
> +		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue empty", q_intr_type);
> +	else
> +		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "unknown error", q_intr_type);

better use a switch

> +
> +	ae4_check_status_trans(ae4, cmd_q);
> +
> +	tasklet_schedule(&cmd_q->irq_tasklet);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int ae4_core_init(struct ae4_device *ae4)
> +{
> +	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
> +	struct ae4_cmd_queue *cmd_q;
> +	u32 dma_addr_lo, dma_addr_hi;
> +	struct device *dev = ae4->dev;
> +	struct dma_pool *dma_pool;
> +	unsigned int i;
> +	int ret;
> +	u32 q_per_eng = max_hw_q;
> +
> +	/* Update the device registers with queue information. */
> +	iowrite32(q_per_eng, ae4->io_regs);
> +
> +	q_per_eng = ioread32(ae4->io_regs);
> +
> +	for (i = 0; i < q_per_eng; i++) {
> +		/* Allocate a dma pool for the queue */
> +		snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q%d", dev_name(ae4->dev), i);
> +		dma_pool = dma_pool_create(dma_pool_name, dev,
> +					   AE4_DMAPOOL_MAX_SIZE,
> +					   AE4_DMAPOOL_ALIGN, 0);
> +		if (!dma_pool)
> +			return -ENOMEM;
> +
> +		/* ae4dma core initialisation */
> +		cmd_q = &ae4->cmd_q[i];
> +		cmd_q->id = ae4->cmd_q_count;
> +		ae4->cmd_q_count++;
> +		cmd_q->ae4 = ae4;
> +		cmd_q->dma_pool = dma_pool;
> +		mutex_init(&cmd_q->q_mutex);
> +		spin_lock_init(&cmd_q->q_lock);
> +
> +		/* Preset some register values (Q size is 32byte (0x20)) */
> +		cmd_q->reg_control = ae4->io_regs + ((i + 1) * 0x20);
> +
> +		/* Page alignment satisfies our needs for N <= 128 */
> +		cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
> +		cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma, GFP_KERNEL);
> +
> +		if (!cmd_q->qbase) {
> +			ret = -ENOMEM;
> +			goto e_destroy_pool;
> +		}
> +
> +		cmd_q->qidx = 0;
> +		cmd_q->q_space_available = 0;
> +
> +		init_waitqueue_head(&cmd_q->int_queue);
> +		init_waitqueue_head(&cmd_q->q_space);

why do you need two waitqueues here?

> +
> +		dev_dbg(dev, "queue #%u available\n", i);
> +	}
> +
> +	if (ae4->cmd_q_count == 0) {
> +		dev_notice(dev, "no command queues available\n");
> +		ret = -EIO;
> +		goto e_destroy_pool;
> +	}
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		cmd_q = &ae4->cmd_q[i];
> +		cmd_q->qcontrol = 0;
> +		ret = request_irq(ae4->ae4_irq[i], ae4_core_irq_handler, 0,
> +				  dev_name(ae4->dev), cmd_q);
> +		if (ret) {
> +			dev_err(dev, "unable to allocate an IRQ\n");
> +			goto e_free_dma;
> +		}
> +
> +		/* Update the device registers with cnd queue length (Max Index reg). */
> +		iowrite32(CMD_Q_LEN, cmd_q->reg_control + 0x08);
> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
> +		dma_addr_lo = lower_32_bits(cmd_q->qdma_tail);
> +		iowrite32((u32)dma_addr_lo, cmd_q->reg_control + 0x18);
> +		dma_addr_lo = ioread32(cmd_q->reg_control + 0x18);
> +		dma_addr_hi = upper_32_bits(cmd_q->qdma_tail);
> +		iowrite32((u32)dma_addr_hi, cmd_q->reg_control + 0x1C);
> +		dma_addr_hi = ioread32(cmd_q->reg_control + 0x1C);
> +		ae4_core_enable_queue_interrupts(ae4, cmd_q);
> +		INIT_LIST_HEAD(&cmd_q->cmd);
> +
> +		/* Initialize the ISR tasklet */
> +		tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
> +	}
> +
> +	return 0;
> +
> +e_free_dma:
> +	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
> +
> +e_destroy_pool:
> +	for (i = 0; i < ae4->cmd_q_count; i++)
> +		dma_pool_destroy(ae4->cmd_q[i].dma_pool);
> +
> +	return ret;
> +}
> +
> +void ae4_core_destroy(struct ae4_device *ae4)
> +{
> +	struct device *dev = ae4->dev;
> +	struct ae4_cmd_queue *cmd_q;
> +	struct ae4_cmd *cmd;
> +	unsigned int i;
> +
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		cmd_q = &ae4->cmd_q[i];
> +
> +		wake_up_all(&cmd_q->q_space);
> +		wake_up_all(&cmd_q->int_queue);
> +
> +		/* Disable and clear interrupts */
> +		ae4_core_disable_queue_interrupts(ae4, cmd_q);
> +
> +		/* Turn off the run bit */
> +		ae4_stop_queue(cmd_q);
> +
> +		free_irq(ae4->ae4_irq[i], cmd_q);
> +
> +		dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
> +				  cmd_q->qbase_dma);
> +	}
> +
> +	/* Flush the cmd queue */
> +	while (!list_empty(&ae4->cmd)) {
> +		/* Invoke the callback directly with an error code */
> +		cmd = list_first_entry(&ae4->cmd, struct ae4_cmd, entry);
> +		list_del(&cmd->entry);
> +		cmd->ae4_cmd_callback(cmd->data, -ENODEV);
> +	}
> +}
> diff --git a/drivers/dma/ae4dma/ae4dma-pci.c b/drivers/dma/ae4dma/ae4dma-pci.c
> new file mode 100644
> index 0000000..a77fbb5
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma-pci.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD AE4DMA device driver
> + * -- Based on the PTDMA driver

cant we use ptdma driver to support both cores?

> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + */
> +
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
> +
> +#include "ae4dma.h"
> +
> +struct ae4_msix {
> +	int msix_count;
> +	struct msix_entry msix_entry[MAX_HW_QUEUES];
> +};
> +
> +/*
> + * ae4_alloc_struct - allocate and initialize the ae4_device struct
> + *
> + * @dev: device struct of the AE4DMA
> + */
> +static struct ae4_device *ae4_alloc_struct(struct device *dev)
> +{
> +	struct ae4_device *ae4;
> +
> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> +

This empty line here doesnt make sense
> +	if (!ae4)
> +		return NULL;

it should be here instead :-)

> +	ae4->dev = dev;
> +
> +	INIT_LIST_HEAD(&ae4->cmd);
> +
> +	return ae4;
> +}
> +
> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> +	struct device *dev = ae4->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int v, i, ret;
> +
> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> +		ae4_msix->msix_entry[v].entry = v;
> +
> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
> +	if (ret < 0)
> +		return ret;
> +
> +	ae4_msix->msix_count = ret;
> +
> +	for (i = 0; i < MAX_HW_QUEUES; i++)
> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
> +
> +	return 0;
> +}
> +
> +static int ae4_get_msi_irq(struct ae4_device *ae4)
> +{
> +	struct device *dev = ae4->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret, i;
> +
> +	ret = pci_enable_msi(pdev);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < MAX_HW_QUEUES; i++)
> +		ae4->ae4_irq[i] = pdev->irq;
> +
> +	return 0;
> +}
> +
> +static int ae4_get_irqs(struct ae4_device *ae4)
> +{
> +	struct device *dev = ae4->dev;
> +	int ret;
> +
> +	ret = ae4_get_msix_irqs(ae4);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI-X vectors, try MSI */
> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> +	ret = ae4_get_msi_irq(ae4);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI interrupt */
> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static void ae4_free_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> +	struct device *dev = ae4->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned int i;
> +
> +	if (ae4_msix->msix_count)
> +		pci_disable_msix(pdev);
> +	else if (ae4->ae4_irq)
> +		pci_disable_msi(pdev);
> +
> +	for (i = 0; i < MAX_HW_QUEUES; i++)
> +		ae4->ae4_irq[i] = 0;
> +}
> +
> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct ae4_device *ae4;
> +	struct ae4_msix *ae4_msix;
> +	struct device *dev = &pdev->dev;
> +	void __iomem * const *iomap_table;
> +	int bar_mask;
> +	int ret = -ENOMEM;
> +
> +	ae4 = ae4_alloc_struct(dev);
> +	if (!ae4)
> +		goto e_err;
> +
> +	ae4_msix = devm_kzalloc(dev, sizeof(*ae4_msix), GFP_KERNEL);
> +	if (!ae4_msix)
> +		goto e_err;
> +
> +	ae4->ae4_msix = ae4_msix;
> +	ae4->dev_vdata = (struct ae4_dev_vdata *)id->driver_data;
> +	if (!ae4->dev_vdata) {
> +		ret = -ENODEV;
> +		dev_err(dev, "missing driver data\n");
> +		goto e_err;
> +	}
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
> +		goto e_err;
> +	}
> +
> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> +	if (ret) {
> +		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
> +		goto e_err;
> +	}
> +
> +	iomap_table = pcim_iomap_table(pdev);
> +	if (!iomap_table) {
> +		dev_err(dev, "pcim_iomap_table failed\n");
> +		ret = -ENOMEM;
> +		goto e_err;
> +	}
> +
> +	ae4->io_regs = iomap_table[ae4->dev_vdata->bar];
> +	if (!ae4->io_regs) {
> +		dev_err(dev, "ioremap failed\n");
> +		ret = -ENOMEM;
> +		goto e_err;
> +	}
> +
> +	ret = ae4_get_irqs(ae4);
> +	if (ret)
> +		goto e_err;
> +
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
> +				ret);
> +			goto e_err;
> +		}
> +	}
> +
> +	dev_set_drvdata(dev, ae4);
> +
> +	if (ae4->dev_vdata)
> +		ret = ae4_core_init(ae4);
> +
> +	if (ret)
> +		goto e_err;
> +
> +	return 0;
> +
> +e_err:
> +	dev_err(dev, "initialization failed ret = %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void ae4_pci_remove(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ae4_device *ae4 = dev_get_drvdata(dev);
> +
> +	if (!ae4)
> +		return;
> +
> +	if (ae4->dev_vdata)
> +		ae4_core_destroy(ae4);
> +
> +	ae4_free_irqs(ae4);
> +}
> +
> +static const struct ae4_dev_vdata dev_vdata[] = {
> +	{
> +		.bar = 0,

why pass zero data?

> +	},
> +};
> +
> +static const struct pci_device_id ae4_pci_table[] = {
> +	{ PCI_VDEVICE(AMD, 0x14C8), (kernel_ulong_t)&dev_vdata[0] },
> +	{ PCI_VDEVICE(AMD, 0x14DC), (kernel_ulong_t)&dev_vdata[0] },
> +	/* Last entry must be zero */
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> +
> +static struct pci_driver ae4_pci_driver = {
> +	.name = "ae4dma",
> +	.id_table = ae4_pci_table,
> +	.probe = ae4_pci_probe,
> +	.remove = ae4_pci_remove,
> +};
> +
> +module_pci_driver(ae4_pci_driver);
> +
> +MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD AE4DMA driver");
> diff --git a/drivers/dma/ae4dma/ae4dma.h b/drivers/dma/ae4dma/ae4dma.h
> new file mode 100644
> index 0000000..0ae46ee
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma.h
> @@ -0,0 +1,338 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AMD AE4DMA device driver
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + */
> +
> +#ifndef __AE4_DEV_H__
> +#define __AE4_DEV_H__
> +
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/wait.h>
> +#include <linux/dmapool.h>
> +
> +#define MAX_AE4_NAME_LEN			16
> +#define MAX_DMAPOOL_NAME_LEN		32
> +
> +#define MAX_HW_QUEUES			16
> +#define MAX_CMD_QLEN			32
> +
> +#define AE4_ENGINE_PASSTHRU		5
> +
> +/* Register Mappings */
> +#define IRQ_MASK_REG			0x040
> +#define IRQ_STATUS_REG			0x200
> +
> +#define CMD_Q_ERROR(__qs)		((__qs) & 0x0000003f)
> +
> +#define CMD_QUEUE_PRIO_OFFSET		0x00
> +#define CMD_REQID_CONFIG_OFFSET		0x04
> +#define CMD_TIMEOUT_OFFSET		0x08
> +#define CMD_AE4_VERSION			0x10
> +
> +#define CMD_Q_CONTROL_BASE		0x0000
> +#define CMD_Q_TAIL_LO_BASE		0x0004
> +#define CMD_Q_HEAD_LO_BASE		0x0008
> +#define CMD_Q_INT_ENABLE_BASE		0x000C

lower case please (here and elsewhere)

-- 
~Vinod
