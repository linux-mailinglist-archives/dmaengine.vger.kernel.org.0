Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267AE1C3289
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgEDGUH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 02:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgEDGUH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 02:20:07 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BFE6206B9;
        Mon,  4 May 2020 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588573206;
        bh=gBVdlnwDDaIqWgTS9qLDeeC9X3IkgNNHkoku+6ZKLjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEsM+MjddLEX4k3BYULolB/p5llNHINyOlEy7hRt9ktLCnk/d7IQw7Kq/CRaGQg5E
         jKCuRe3t8t7oqrRm2c4L6yLR4BMxTuglfcK7tCpU7gM/Hfh93V5VeCvYfU6/a1opMH
         uTYxmwXwcUBePFS1uj8CGiixaodL6BQEuaa/wLw0=
Date:   Mon, 4 May 2020 11:50:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
 information
Message-ID: <20200504062002.GL1375924@vkoul-mobl>
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-4-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588108416-49050-4-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-20, 16:13, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Expose data about the configuration and operation of the
> PTDMA through debugfs entries: device name, capabilities,
> configuration, statistics.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/dma/ptdma/Makefile        |   3 +-
>  drivers/dma/ptdma/ptdma-debugfs.c | 237 ++++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dev.c     |  26 +++++
>  drivers/dma/ptdma/ptdma.h         |  13 +++
>  4 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
> 
> diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
> index 6fcb4ad..60e7c10 100644
> --- a/drivers/dma/ptdma/Makefile
> +++ b/drivers/dma/ptdma/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_AMD_PTDMA) += ptdma.o
>  
>  ptdma-objs := ptdma-dev.o \
> -	      ptdma-dmaengine.o
> +	      ptdma-dmaengine.o \
> +	      ptdma-debugfs.o
>  
>  ptdma-$(CONFIG_PCI) += ptdma-pci.o
> diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/ptdma/ptdma-debugfs.c
> new file mode 100644
> index 0000000..837c43c
> --- /dev/null
> +++ b/drivers/dma/ptdma/ptdma-debugfs.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD Passthrough DMA device driver
> + * -- Based on the CCP driver
> + *
> + * Copyright (C) 2016,2020 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "ptdma.h"
> +
> +/* DebugFS helpers */
> +#define	OBUFP		(obuf + oboff)
> +#define	OBUFLEN		512
> +#define	OBUFSPC		(OBUFLEN - oboff)
> +
> +#define	MAX_NAME_LEN	20
> +#define	BUFLEN		63
> +#define	RI_VERSION_NUM	0x0000003F
> +
> +#define	RI_NUM_VQM	0x00078000
> +#define	RI_NVQM_SHIFT	15
> +#define	RI_NVQM(r)	(((r) * RI_NUM_VQM) >> RI_NVQM_SHIFT)
> +#define	RI_LSB_ENTRIES	0x0FF80000
> +#define	RI_NLSB_SHIFT	19
> +#define	RI_NLSB(r)	(((r) * RI_LSB_ENTRIES) >> RI_NLSB_SHIFT)
> +
> +static struct dentry *pt_debugfs_dir;
> +static DEFINE_MUTEX(pt_debugfs_lock);
> +
> +static ssize_t ptdma_debugfs_info_read(struct file *filp, char __user *ubuf,
> +				       size_t count, loff_t *offp)
> +{
> +	struct pt_device *pt = filp->private_data;
> +	unsigned int oboff = 0;
> +	unsigned int regval;
> +	ssize_t ret;
> +	char *obuf;
> +
> +	if (!pt)
> +		return 0;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += snprintf(OBUFP, OBUFSPC, "Device name: %s\n", pt->name);
> +	oboff += snprintf(OBUFP, OBUFSPC, "   # Queues: %d\n", 1);
> +	oboff += snprintf(OBUFP, OBUFSPC, "     # Cmds: %d\n", pt->cmd_count);
> +
> +	regval = ioread32(pt->io_regs + CMD_PT_VERSION);
> +
> +	oboff += snprintf(OBUFP, OBUFSPC, "    Version: %d\n",
> +		   regval & RI_VERSION_NUM);
> +	oboff += snprintf(OBUFP, OBUFSPC, "    Engines:");
> +	oboff += snprintf(OBUFP, OBUFSPC, "\n");
> +	oboff += snprintf(OBUFP, OBUFSPC, "     Queues: %d\n",
> +		   (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
> +
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +/*
> + * Return a formatted buffer containing the current
> + * statistics of queue for PTDMA
> + */
> +static ssize_t ptdma_debugfs_stats_read(struct file *filp, char __user *ubuf,
> +					size_t count, loff_t *offp)
> +{
> +	struct pt_device *pt = filp->private_data;
> +	unsigned long total_pt_ops = 0;
> +	unsigned int oboff = 0;
> +	ssize_t ret = 0;
> +	char *obuf;
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +
> +	total_pt_ops += cmd_q->total_pt_ops;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += snprintf(OBUFP, OBUFSPC, "Total Interrupts Handled: %ld\n",
> +			    pt->total_interrupts);
> +
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +/*
> + * Reset the counters in a queue
> + */
> +static void ptdma_debugfs_reset_queue_stats(struct pt_cmd_queue *cmd_q)
> +{
> +	cmd_q->total_pt_ops = 0L;
> +}
> +
> +/*
> + * A value was written to the stats variable, which
> + * should be used to reset the queue counters across
> + * that device.
> + */
> +static ssize_t ptdma_debugfs_stats_write(struct file *filp,
> +					 const char __user *ubuf,
> +					 size_t count, loff_t *offp)
> +{
> +	struct pt_device *pt = filp->private_data;
> +
> +	ptdma_debugfs_reset_queue_stats(&pt->cmd_q);
> +	pt->total_interrupts = 0L;
> +
> +	return count;
> +}
> +
> +/*
> + * Return a formatted buffer containing the current information
> + * for that queue
> + */
> +static ssize_t ptdma_debugfs_queue_read(struct file *filp, char __user *ubuf,
> +					size_t count, loff_t *offp)
> +{
> +	struct pt_cmd_queue *cmd_q = filp->private_data;
> +	unsigned int oboff = 0;
> +	unsigned int regval;
> +	ssize_t ret;
> +	char *obuf;
> +
> +	if (!cmd_q)
> +		return 0;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += snprintf(OBUFP, OBUFSPC, "               Pass-Thru: %ld\n",
> +			    cmd_q->total_pt_ops);
> +
> +	regval = ioread32(cmd_q->reg_int_enable);
> +	oboff += snprintf(OBUFP, OBUFSPC, "      Enabled Interrupts:");
> +	if (regval & INT_EMPTY_QUEUE)
> +		oboff += snprintf(OBUFP, OBUFSPC, " EMPTY");
> +	if (regval & INT_QUEUE_STOPPED)
> +		oboff += snprintf(OBUFP, OBUFSPC, " STOPPED");
> +	if (regval & INT_ERROR)
> +		oboff += snprintf(OBUFP, OBUFSPC, " ERROR");
> +	if (regval & INT_COMPLETION)
> +		oboff += snprintf(OBUFP, OBUFSPC, " COMPLETION");
> +	oboff += snprintf(OBUFP, OBUFSPC, "\n");
> +
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +/*
> + * A value was written to the stats variable for a
> + * queue. Reset the queue counters to this value.
> + */
> +static ssize_t ptdma_debugfs_queue_write(struct file *filp,
> +					 const char __user *ubuf,
> +					 size_t count, loff_t *offp)
> +{
> +	struct pt_cmd_queue *cmd_q = filp->private_data;
> +
> +	ptdma_debugfs_reset_queue_stats(cmd_q);
> +
> +	return count;
> +}
> +
> +static const struct file_operations pt_debugfs_info_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_info_read,
> +	.write = NULL,
> +};
> +
> +static const struct file_operations pt_debugfs_queue_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_queue_read,
> +	.write = ptdma_debugfs_queue_write,
> +};
> +
> +static const struct file_operations pt_debugfs_stats_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_stats_read,
> +	.write = ptdma_debugfs_stats_write,
> +};

pls convert to use DEFINE_SHOW_ATTRIBUTE()

> +void ptdma_debugfs_setup(struct pt_device *pt)
> +{
> +	struct pt_cmd_queue *cmd_q;
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *debugfs_q_instance;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	mutex_lock(&pt_debugfs_lock);
> +	if (!pt_debugfs_dir)
> +		pt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +	mutex_unlock(&pt_debugfs_lock);
> +
> +	pt->debugfs_instance = debugfs_create_dir(pt->name, pt_debugfs_dir);
> +
> +	debugfs_create_file("info", 0400, pt->debugfs_instance, pt,
> +			    &pt_debugfs_info_ops);
> +
> +	debugfs_create_file("stats", 0600, pt->debugfs_instance, pt,
> +			    &pt_debugfs_stats_ops);
> +
> +	cmd_q = &pt->cmd_q;
> +
> +	snprintf(name, MAX_NAME_LEN - 1, "q");
> +
> +	debugfs_q_instance =
> +		debugfs_create_dir(name, pt->debugfs_instance);
> +
> +	debugfs_create_file("stats", 0600, debugfs_q_instance, cmd_q,
> +			    &pt_debugfs_queue_ops);

Pls use dbg_dev_root in struct dma_device as root for your own debugfs

Thanks
-- 
~Vinod
