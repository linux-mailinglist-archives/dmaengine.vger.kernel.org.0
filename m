Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25A3BD273
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbfIXTNo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 15:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390196AbfIXTNo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 15:13:44 -0400
Received: from localhost (unknown [12.206.46.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2295C2146E;
        Tue, 24 Sep 2019 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569352422;
        bh=pOsnILBtlXu+awgCMT2MEK7w954jdbfewaaP1cRdc3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4PtixZSLFrD15AsUFBqb0oCoifOX/YNCXbbmMRPIPahHoJ+k7N8QvDKq/jehtt3x
         vunV6gcwxsxod41MbtNrDdXwIqgPHmA6hPkPWVdPi/KIyXhhOUVYxpDhHYvOoKkBM4
         T/SAeTcZAgJazC/EewLooF1LGSJ94rUwQqJPuCYI=
Date:   Tue, 24 Sep 2019 12:12:40 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/4] dma: Add PTDMA Engine driver support
Message-ID: <20190924191240.GD3824@vkoul-mobl>
References: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-19, 07:31, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This is the driver for the AMD passthrough DMA Engine

Please fix threading for your series, they are all over my inbox :(

> +#include "ptdma.h"
> +
> +/* Union to define the function field (cmd_reg1/dword0) */
> +union pt_function {
> +	struct {
> +		u16 byteswap:2;
> +		u16 bitwise:3;
> +		u16 reflect:2;
> +		u16 rsvd:8;
> +	} pt;
> +	u16 raw;
> +};

So IIUC you are using this to write to hw registers, what is wrong with
defining bit fields for registers using BIT and GENMASK and then write
the settings to the hardware. That IMHO looks much neater!

> +static inline u32 low_address(unsigned long addr)
> +{
> +	return (u64)addr & 0x0ffffffff;
> +}
> +
> +static inline u32 high_address(unsigned long addr)
> +{
> +	return ((u64)addr >> 32) & 0x00000ffff;
> +}

Use lower_32_bits() and upper_32_bits() please. Also check the APIs in
kernel and don't invent your own!

> +int pt_core_perform_passthru(struct pt_op *op)
> +{
> +	struct ptdma_desc desc;
> +	union pt_function function;
> +	struct pt_dma_info *saddr = &op->src.u.dma;
> +
> +	memset(&desc, 0, Q_DESC_SIZE);
> +
> +	PT_CMD_ENGINE(&desc) = PT_ENGINE_PASSTHRU;
> +
> +	PT_CMD_SOC(&desc) = 0;
> +	PT_CMD_IOC(&desc) = 1;
> +	PT_CMD_INIT(&desc) = 0;
> +	PT_CMD_EOM(&desc) = op->eom;
> +	PT_CMD_PROT(&desc) = 0;
> +
> +	function.raw = 0;
> +	PT_BYTESWAP(&function) = op->passthru.byte_swap;
> +	PT_BITWISE(&function) = op->passthru.bit_mod;
> +	PT_CMD_FUNCTION(&desc) = function.raw;
> +
> +	PT_CMD_LEN(&desc) = saddr->length;
> +
> +	PT_CMD_SRC_LO(&desc) = pt_addr_lo(&op->src.u.dma);
> +	PT_CMD_SRC_HI(&desc) = pt_addr_hi(&op->src.u.dma);
> +	PT_CMD_SRC_MEM(&desc) = PT_MEMTYPE_SYSTEM;
> +
> +	PT_CMD_DST_LO(&desc) = pt_addr_lo(&op->dst.u.dma);
> +	PT_CMD_DST_HI(&desc) = pt_addr_hi(&op->dst.u.dma);
> +	PT_CMD_DST_MEM(&desc) = PT_MEMTYPE_SYSTEM;

This really looks bad, as I siad please use bits and genmasks. Also see
how other driver handles registers transparently!

> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
> +{
> +	struct pt_device *pt = (struct pt_device *)data;
> +
> +	pt_core_disable_queue_interrupts(pt);
> +	tasklet_schedule(&pt->irq_tasklet);

Why are you not submitting txn in ISR, you are keeping dmaengine idle
for tasklet!

> +	cmd_q->qidx = 0;
> +	/* Preset some register values and masks that are queue
> +	 * number dependent
> +	 */

kernel style is 
/*
 * this is a multi line comment
 * notice first and last line
 */

> +	cmd_q->reg_control = pt->io_regs + CMD_Q_STATUS_INCR;
> +	cmd_q->reg_tail_lo = cmd_q->reg_control + CMD_Q_TAIL_LO_BASE;
> +	cmd_q->reg_head_lo = cmd_q->reg_control + CMD_Q_HEAD_LO_BASE;
> +	cmd_q->reg_int_enable = cmd_q->reg_control +
> +				CMD_Q_INT_ENABLE_BASE;
> +	cmd_q->reg_interrupt_status = cmd_q->reg_control +
> +				      CMD_Q_INTERRUPT_STATUS_BASE;
> +	cmd_q->reg_status = cmd_q->reg_control + CMD_Q_STATUS_BASE;
> +	cmd_q->reg_int_status = cmd_q->reg_control +
> +				CMD_Q_INT_STATUS_BASE;
> +	cmd_q->reg_dma_status = cmd_q->reg_control +
> +				CMD_Q_DMA_STATUS_BASE;
> +	cmd_q->reg_dma_read_status = cmd_q->reg_control +
> +				     CMD_Q_DMA_READ_STATUS_BASE;
> +	cmd_q->reg_dma_write_status = cmd_q->reg_control +
> +				      CMD_Q_DMA_WRITE_STATUS_BASE;
> +
> +	init_waitqueue_head(&cmd_q->int_queue);
> +
> +	dev_dbg(dev, "queue available\n");

Noise

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
> +	dev_dbg(dev, "Requesting an IRQ...\n");
> +	/* Request an irq */
> +	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, "pt", pt);
> +	if (ret) {
> +		dev_err(dev, "unable to allocate an IRQ\n");
> +		goto e_pool;
> +	}
> +	/* Initialize the ISR tasklet */
> +	tasklet_init(&pt->irq_tasklet, pt_core_irq_bh,
> +		     (unsigned long)pt);
> +
> +	dev_dbg(dev, "Configuring virtual queues...\n");
> +	/* Configure size of each virtual queue accessible to host */
> +
> +	cmd_q->qcontrol &= ~(CMD_Q_SIZE << CMD_Q_SHIFT);
> +	cmd_q->qcontrol |= QUEUE_SIZE_VAL << CMD_Q_SHIFT;
> +
> +	cmd_q->qdma_tail = cmd_q->qbase_dma;
> +	dma_addr_lo = low_address(cmd_q->qdma_tail);
> +	iowrite32((u32)dma_addr_lo, cmd_q->reg_tail_lo);
> +	iowrite32((u32)dma_addr_lo, cmd_q->reg_head_lo);
> +
> +	dma_addr_hi = high_address(cmd_q->qdma_tail);
> +	cmd_q->qcontrol |= (dma_addr_hi << 16);
> +	iowrite32(cmd_q->qcontrol, cmd_q->reg_control);
> +
> +	dev_dbg(dev, "Starting threads...\n");
> +	/* Create a kthread for command queue */
> +
> +	kthread = kthread_create(pt_cmd_queue_thread, cmd_q, "pt-q");

Why do you need a thread, you already have a tasklet?


Okay am stopping here. There are **tons** of style issues with the
series. For this patch alone checkpatch tells me:

total: 184 errors, 12 warnings, 31 checks, 1593 lines checked

1. Please **FIX** the errors
2. I suspect tab spaces are wrong (we use 8)
3. Read Documentation/process/coding-style.rst, if done, re read it
again
4. Use dmaengine APIs and virtual dma layer
5. Dont invent your own stuff, kernel already has stuff to deal with
most common thngs, no your case is not unique.
6. Check other drivers on how to do things
7. Make sure you send a series as athread, if in doubt send to yourself!

Thanks
-- 
~Vinod
