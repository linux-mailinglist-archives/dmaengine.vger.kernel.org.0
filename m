Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB71C3265
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEDFzp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgEDFzo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:55:44 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9075C20721;
        Mon,  4 May 2020 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588571743;
        bh=hsRcOcXiosbEqy3AmtQTRIvno9cmDyh65wixvhLD2o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+2ZSG+CW77IziyzS8stM3g0oqMWuv1wJC9kin2vUB3bNh14jsHciZXo9RGsYVnuq
         I+gsWJ7LAw9YrmAbwsQ0tWDuZVd9S6pYwWYhz5Zx3FcmJdpn/AS791yC0DI1ZP3Su5
         myp3hJnfR3yzAvhJ4qlhieTCz+NMfLmzJQGbsCPs=
Date:   Mon, 4 May 2020 11:25:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA controller
Message-ID: <20200504055539.GJ1375924@vkoul-mobl>
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588108416-49050-2-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-20, 16:13, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This driver add support for AMD PTDMA controller.  This device
> performs high-bandwidth memory to memory and IO copy operation.
> Device commands are managed via a circular queue of 'descriptors',
> each of which specifies source and destination addresses for copying
> a single buffer of data.
> 
> The driver handles multiple devices, which are logged on a linked
> list; all devices are treated equivalently.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/dma/Kconfig           |   2 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/ptdma/Kconfig     |  11 ++
>  drivers/dma/ptdma/Makefile    |  10 ++
>  drivers/dma/ptdma/ptdma-dev.c | 399 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c | 253 ++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma.h     | 324 ++++++++++++++++++++++++++++++++++
>  8 files changed, 1006 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db..8bf94b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -921,6 +921,12 @@ S:	Supported
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
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 0924836..44b8d73 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -738,6 +738,8 @@ source "drivers/dma/ti/Kconfig"
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
>  
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
> diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
> new file mode 100644
> index 0000000..320fa82
> --- /dev/null
> +++ b/drivers/dma/ptdma/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Passthru DMA driver
> +#
> +
> +obj-$(CONFIG_AMD_PTDMA) += ptdma.o
> +
> +ptdma-objs := ptdma-dev.o
> +
> +ptdma-$(CONFIG_PCI) += ptdma-pci.o
> diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
> new file mode 100644
> index 0000000..0a69fd4
> --- /dev/null
> +++ b/drivers/dma/ptdma/ptdma-dev.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD Passthru DMA device driver
> + * -- Based on the CCP driver
> + *
> + * Copyright (C) 2016,2020 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +
> +#include "ptdma.h"
> +
> +static int cmd_queue_length = 32;
> +module_param(cmd_queue_length, uint, 0644);
> +MODULE_PARM_DESC(cmd_queue_length,
> +		 " length of the command queue, a power of 2 (2 <= val <= 128)");

Any reason for this as module param? who will configure this and how?

> + * List of PTDMAs, PTDMA count, read-write access lock, and access functions
> + *
> + * Lock structure: get pt_unit_lock for reading whenever we need to
> + * examine the PTDMA list. While holding it for reading we can acquire
> + * the RR lock to update the round-robin next-PTDMA pointer. The unit lock
> + * must be acquired before the RR lock.
> + *
> + * If the unit-lock is acquired for writing, we have total control over
> + * the list, so there's no value in getting the RR lock.
> + */
> +static DEFINE_RWLOCK(pt_unit_lock);
> +static LIST_HEAD(pt_units);
> +
> +static struct pt_device *pt_rr;

why do we need these globals and not in driver context?

> +static void pt_add_device(struct pt_device *pt)
> +{
> +	unsigned long flags;
> +
> +	write_lock_irqsave(&pt_unit_lock, flags);
> +	list_add_tail(&pt->entry, &pt_units);
> +	if (!pt_rr)
> +		/*
> +		 * We already have the list lock (we're first) so this
> +		 * pointer can't change on us. Set its initial value.
> +		 */
> +		pt_rr = pt;
> +	write_unlock_irqrestore(&pt_unit_lock, flags);
> +}

Can you please explain what do you mean by having a list of devices and
why are we adding/removing dynamically?

-- 
~Vinod
