Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35010213540
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGCHmF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 03:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHmF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 03:42:05 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FAC206B6;
        Fri,  3 Jul 2020 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593762124;
        bh=ytBBrNASNi4lreEswlKiG9zTyR8nMpCN2T+EsIZP4dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSvUHUNUrEn20qbxTBkbQKP8JuGvidWsl2Fl6NBxcgYKzCUJdDWKbEi2qRwY/eRdi
         Q1NWFV03GfuUnjoLSd5LJGzQAtutF3HcoM5FzbdNUo9P8RAXB08ZYtRIDtKJc2dfaZ
         xMB30M/w863jvJLhtwefYHdd2R8yKZ3aAIcGpGww=
Date:   Fri, 3 Jul 2020 13:12:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
 information
Message-ID: <20200703074200.GL273932@vkoul-mobl>
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-4-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592356288-42064-4-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-20, 20:11, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Expose data about the configuration and operation of the
> PTDMA through debugfs entries: device name, capabilities,
> configuration, statistics.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/dma/ptdma/Makefile        |   3 +-
>  drivers/dma/ptdma/ptdma-debugfs.c | 130 ++++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dev.c     |   8 +++
>  drivers/dma/ptdma/ptdma.h         |   9 +++
>  4 files changed, 149 insertions(+), 1 deletion(-)
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
> index 0000000..506c148b
> --- /dev/null
> +++ b/drivers/dma/ptdma/ptdma-debugfs.c
> @@ -0,0 +1,130 @@
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
> +#include <linux/seq_file.h>
> +
> +#include "ptdma.h"
> +
> +/* DebugFS helpers */
> +#define	MAX_NAME_LEN	20
> +#define	RI_VERSION_NUM	0x0000003F
> +
> +#define	RI_NUM_VQM	0x00078000
> +#define	RI_NVQM_SHIFT	15
> +
> +static struct dentry *pt_debugfs_dir;
> +static DEFINE_MUTEX(pt_debugfs_lock);
> +
> +static int pt_debugfs_info_show(struct seq_file *s, void *p)
> +{
> +	struct pt_device *pt = s->private;
> +	unsigned int regval;
> +
> +	if (!pt)
> +		return 0;
> +
> +	seq_printf(s, "Device name: %s\n", pt->name);
> +	seq_printf(s, "   # Queues: %d\n", 1);
> +	seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
> +
> +	regval = ioread32(pt->io_regs + CMD_PT_VERSION);
> +
> +	seq_printf(s, "    Version: %d\n", regval & RI_VERSION_NUM);
> +	seq_puts(s, "    Engines:");
> +	seq_puts(s, "\n");
> +	seq_printf(s, "     Queues: %d\n", (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
> +
> +	return 0;
> +}
> +
> +/*
> + * Return a formatted buffer containing the current
> + * statistics of queue for PTDMA
> + */
> +static int pt_debugfs_stats_show(struct seq_file *s, void *p)
> +{
> +	struct pt_device *pt = s->private;
> +
> +	seq_printf(s, "Total Interrupts Handled: %ld\n", pt->total_interrupts);
> +
> +	return 0;
> +}
> +
> +static int pt_debugfs_queue_show(struct seq_file *s, void *p)
> +
> +{
> +	struct pt_cmd_queue *cmd_q = s->private;
> +	unsigned int regval;
> +
> +	if (!cmd_q)
> +		return 0;
> +
> +	seq_printf(s, "               Pass-Thru: %ld\n", cmd_q->total_pt_ops);
> +
> +	regval = ioread32(cmd_q->reg_int_enable);
> +
> +	seq_puts(s, "      Enabled Interrupts:");
> +	if (regval & INT_EMPTY_QUEUE)
> +		seq_puts(s, " EMPTY");
> +	if (regval & INT_QUEUE_STOPPED)
> +		seq_puts(s, " STOPPED");
> +	if (regval & INT_ERROR)
> +		seq_puts(s, " ERROR");
> +	if (regval & INT_COMPLETION)
> +		seq_puts(s, " COMPLETION");
> +	seq_puts(s, "\n");
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_info);
> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_queue);
> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
> +
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

please do not create your own, you already have one under
/sys/kernel/debug/dmaengine/<>/ use that :)

> +	mutex_unlock(&pt_debugfs_lock);
> +
> +	pt->dma_dev.dbg_dev_root = debugfs_create_dir(pt->name, pt_debugfs_dir);

argh, this is already created by core and you leaked that one and added
your own!

-- 
~Vinod
