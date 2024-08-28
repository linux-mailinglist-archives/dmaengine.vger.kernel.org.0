Return-Path: <dmaengine+bounces-2983-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C540296288B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DA52842F3
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC116D4CD;
	Wed, 28 Aug 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC4Y5nQh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007A17332A
	for <dmaengine@vger.kernel.org>; Wed, 28 Aug 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851399; cv=none; b=UoJbRHeIjlU5Yx6IqZ6+/8/u4Zo0S4zS89UFvYvbnLWt+d7MT0qOFkvWNUNFi72b65W38nVb1kWK1g2jg5GPBdrJsNcf4QMh3vnRDkuKjEUSQ65mA5ZAO1oTRDGQYUA0GVKSgugYt/pH+W7CHtLLV8L9TA5HwmIkABNdkMuYJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851399; c=relaxed/simple;
	bh=YJE96Lc50BNpkKYoSYUAy8ZzF2UHuPAhwpyxvU05dGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZBzOWXRRyM74BNagQYtirmZGSuIUSa6scLIoaHhC51AE3iCucjABonrXOxajAKvc3EBZaGGaZ4FFGglOSubBEd4AahNap2w0Fje3vWHjvKL4PDs1+4dBF59KA+G49kFsPeBpwjfMRYZ+mpzNhBU1evANTkmsp2HvEdA/vPDiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC4Y5nQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E40AC98EC8;
	Wed, 28 Aug 2024 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851398;
	bh=YJE96Lc50BNpkKYoSYUAy8ZzF2UHuPAhwpyxvU05dGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC4Y5nQhqGg1Q2p8jz9zU0atzFwhX+K5zY3E0seYshPhLNaNixbd+3k6W97b6iMdJ
	 VMittVI4qhT4oCGFjPKSlbYpTh3pRJY4zRWQ+VtTYlbja+EKmXDpykKvFTPD/M44R1
	 FdRiAgg9QcVIzVHTiuqsZWDsOO4I6HF+69GMOEAyKzNuv7FYhOAFIdGcMp+qwrB3OA
	 xl5nqs2Uphyvu/PzlnpKoEg6jL2jBNaG5ExDU4scKvJziUoONP9UV2gu0xfr5w6znI
	 41BT5rxu3Z7obafvWw7oghQmuU/vHAikVGVwesaZ4LLxOPtQfZtiVyv0zlr0X1ogLX
	 Hc1ycql3qJUzw==
Date: Wed, 28 Aug 2024 18:53:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v5 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
Message-ID: <Zs8kwwveNCTvHnvX@vaman>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-3-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708144500.1523651-3-Basavaraj.Natikar@amd.com>

On 08-07-24, 20:14, Basavaraj Natikar wrote:
> Add support for AMD AE4DMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  MAINTAINERS                         |   6 +
>  drivers/dma/amd/Kconfig             |   1 +
>  drivers/dma/amd/Makefile            |   1 +
>  drivers/dma/amd/ae4dma/Kconfig      |  14 ++
>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 198 ++++++++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 157 ++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma.h     |  85 ++++++++++++
>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>  9 files changed, 498 insertions(+)
>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>  create mode 100644 drivers/dma/amd/common/amd_dma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33a1049fd38b..539bf52410de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -947,6 +947,12 @@ L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/ras/amd/atl/*
>  
> +AMD AE4DMA DRIVER
> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/amd/ae4dma/
> +
>  AMD AXI W1 DRIVER
>  M:	Kris Chaplin <kris.chaplin@amd.com>
>  R:	Thomas Delev <thomas.delev@amd.com>
> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
> index 8246b463bcf7..8c25a3ed6b94 100644
> --- a/drivers/dma/amd/Kconfig
> +++ b/drivers/dma/amd/Kconfig
> @@ -3,3 +3,4 @@
>  # AMD DMA Drivers
>  
>  source "drivers/dma/amd/ptdma/Kconfig"
> +source "drivers/dma/amd/ae4dma/Kconfig"
> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
> index dd7257ba7e06..8049b06a9ff5 100644
> --- a/drivers/dma/amd/Makefile
> +++ b/drivers/dma/amd/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
> new file mode 100644
> index 000000000000..ea8a7fe68df5
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config AMD_AE4DMA
> +	tristate  "AMD AE4DMA Engine"
> +	depends on (X86_64 || COMPILE_TEST) && PCI
> +	depends on AMD_PTDMA
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Enable support for the AMD AE4DMA controller. This controller
> +	  provides DMA capabilities to perform high bandwidth memory to
> +	  memory and IO copy operations. It performs DMA transfer through
> +	  queue-based descriptor management. This DMA controller is intended
> +	  to be used with AMD Non-Transparent Bridge devices and not for
> +	  general purpose peripheral DMA.
> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
> new file mode 100644
> index 000000000000..e918f85a80ec
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD AE4DMA driver
> +#
> +
> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
> +
> +ae4dma-objs := ae4dma-dev.o
> +
> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> new file mode 100644
> index 000000000000..c38464b96fc6
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#include "ae4dma.h"
> +
> +static unsigned int max_hw_q = 1;
> +module_param(max_hw_q, uint, 0444);
> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
> +
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
> +static void ae4_log_error(struct pt_device *d, int e)
> +{
> +	/* ERR 01 - 07 represents Invalid AE4 errors */
> +	if (e <= 7)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> +	/* ERR 08 - 15 represents Invalid Descriptor errors */
> +	else if (e > 7 && e <= 15)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	/* ERR 16 - 31 represents Firmware errors */
> +	else if (e > 15 && e <= 31)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
> +	/* ERR 32 - 63 represents Fatal errors */
> +	else if (e > 31 && e <= 63)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
> +	/* ERR 64 - 255 represents PTE errors */
> +	else if (e > 63 && e <= 255)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> +	else
> +		dev_info(d->dev, "Unknown AE4DMA error");
> +}
> +
> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> +{
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +	struct ae4dma_desc desc;
> +	u8 status;
> +
> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> +	status = desc.dw1.status;
> +	if (status && status != AE4_DESC_COMPLETED) {
> +		cmd_q->cmd_error = desc.dw1.err_code;
> +		if (cmd_q->cmd_error)
> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> +	}
> +}
> +
> +static void ae4_pending_work(struct work_struct *work)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +	struct pt_cmd *cmd;
> +	u32 cridx;
> +
> +	for (;;) {
> +		wait_event_interruptible(ae4cmd_q->q_w,
> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
> +
> +		atomic64_inc(&ae4cmd_q->done_cnt);
> +
> +		mutex_lock(&ae4cmd_q->cmd_lock);
> +		cridx = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
> +		while ((ae4cmd_q->dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
> +			list_del(&cmd->entry);
> +
> +			ae4_check_status_error(ae4cmd_q, ae4cmd_q->dridx);
> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
> +
> +			ae4cmd_q->q_cmd_count--;
> +			ae4cmd_q->dridx = (ae4cmd_q->dridx + 1) % CMD_Q_LEN;
> +
> +			complete_all(&ae4cmd_q->cmp);
> +		}
> +		mutex_unlock(&ae4cmd_q->cmd_lock);
> +	}
> +}
> +
> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = data;
> +	struct pt_cmd_queue *cmd_q;
> +	struct pt_device *pt;
> +	u32 status;
> +
> +	cmd_q = &ae4cmd_q->cmd_q;
> +	pt = cmd_q->pt;
> +
> +	pt->total_interrupts++;
> +	atomic64_inc(&ae4cmd_q->intr_cnt);
> +
> +	wake_up(&ae4cmd_q->q_w);

shouldnt this be last thing before returning

> +
> +	status = readl(cmd_q->reg_control + AE4_INTR_STS_OFF);
> +	if (status & BIT(0)) {
> +		status &= GENMASK(31, 1);
> +		writel(status, cmd_q->reg_control + AE4_INTR_STS_OFF);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void ae4_destroy_work(struct ae4_device *ae4)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q;
> +	int i;
> +
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +
> +		if (!ae4cmd_q->pws)
> +			break;
> +
> +		cancel_delayed_work_sync(&ae4cmd_q->p_work);
> +		destroy_workqueue(ae4cmd_q->pws);
> +	}
> +}
> +
> +int ae4_core_init(struct ae4_device *ae4)
> +{
> +	struct pt_device *pt = &ae4->pt;
> +	struct ae4_cmd_queue *ae4cmd_q;
> +	struct device *dev = pt->dev;
> +	struct pt_cmd_queue *cmd_q;
> +	int i, ret = 0;
> +
> +	writel(max_hw_q, pt->io_regs);
> +
> +	for (i = 0; i < max_hw_q; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +		ae4cmd_q->id = ae4->cmd_q_count;
> +		ae4->cmd_q_count++;
> +
> +		cmd_q = &ae4cmd_q->cmd_q;
> +		cmd_q->pt = pt;
> +
> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
> +
> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
> +				       dev_name(pt->dev), ae4cmd_q);
> +		if (ret)
> +			return ret;
> +
> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
> +
> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
> +						   GFP_KERNEL);
> +		if (!cmd_q->qbase)
> +			return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> +
> +		cmd_q = &ae4cmd_q->cmd_q;
> +
> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
> +
> +		/* Update the device registers with queue information. */
> +		writel(CMD_Q_LEN, cmd_q->reg_control + AE4_MAX_IDX_OFF);
> +
> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_L_OFF);
> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_H_OFF);
> +
> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
> +		init_waitqueue_head(&ae4cmd_q->q_w);
> +
> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
> +		if (!ae4cmd_q->pws) {
> +			ae4_destroy_work(ae4);
> +			return -ENOMEM;
> +		}
> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
> +
> +		init_completion(&ae4cmd_q->cmp);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> new file mode 100644
> index 000000000000..43d36e9d1efb
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#include "ae4dma.h"
> +
> +static int ae4_get_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	struct pci_dev *pdev;
> +	int i, v, ret;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> +		ae4_msix->msix_entry[v].entry = v;
> +
> +	ret = pci_alloc_irq_vectors(pdev, v, v, PCI_IRQ_MSIX);
> +	if (ret != v) {
> +		if (ret > 0)
> +			pci_free_irq_vectors(pdev);
> +
> +		dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> +		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +		if (ret < 0) {
> +			dev_err(dev, "could not enable MSI (%d)\n", ret);
> +			return ret;
> +		}
> +
> +		ret = pci_irq_vector(pdev, 0);
> +		if (ret < 0) {
> +			pci_free_irq_vectors(pdev);
> +			return ret;
> +		}
> +
> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +			ae4->ae4_irq[i] = ret;
> +
> +	} else {
> +		ae4_msix->msix_count = ret;
> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +			ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
> +	}
> +
> +	return ret;
> +}
> +
> +static void ae4_free_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	struct pci_dev *pdev;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	if (ae4_msix && (ae4_msix->msix_count || ae4->ae4_irq[MAX_AE4_HW_QUEUES - 1]))
> +		pci_free_irq_vectors(pdev);
> +}
> +
> +static void ae4_deinit(struct ae4_device *ae4)
> +{
> +	ae4_free_irqs(ae4);
> +}
> +
> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ae4_device *ae4;
> +	struct pt_device *pt;
> +	int bar_mask;
> +	int ret = 0;
> +
> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> +	if (!ae4)
> +		return -ENOMEM;
> +
> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
> +	if (!ae4->ae4_msix)
> +		return -ENOMEM;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		goto ae4_error;
> +
> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> +	if (ret)
> +		goto ae4_error;
> +
> +	pt = &ae4->pt;
> +	pt->dev = dev;
> +
> +	pt->io_regs = pcim_iomap_table(pdev)[0];
> +	if (!pt->io_regs) {
> +		ret = -ENOMEM;
> +		goto ae4_error;
> +	}
> +
> +	ret = ae4_get_irqs(ae4);
> +	if (ret < 0)
> +		goto ae4_error;
> +
> +	pci_set_master(pdev);
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +
> +	dev_set_drvdata(dev, ae4);
> +
> +	ret = ae4_core_init(ae4);
> +	if (ret)
> +		goto ae4_error;
> +
> +	return 0;
> +
> +ae4_error:
> +	ae4_deinit(ae4);
> +
> +	return ret;
> +}
> +
> +static void ae4_pci_remove(struct pci_dev *pdev)
> +{
> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> +
> +	ae4_destroy_work(ae4);
> +	ae4_deinit(ae4);
> +}
> +
> +static const struct pci_device_id ae4_pci_table[] = {
> +	{ PCI_VDEVICE(AMD, 0x14C8), },
> +	{ PCI_VDEVICE(AMD, 0x14DC), },
> +	{ PCI_VDEVICE(AMD, 0x149B), },
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
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD AE4DMA driver");
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> new file mode 100644
> index 000000000000..a63525792080
> --- /dev/null
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD AE4DMA driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +#ifndef __AE4DMA_H__
> +#define __AE4DMA_H__
> +
> +#include "../common/amd_dma.h"
> +
> +#define MAX_AE4_HW_QUEUES		16
> +
> +#define AE4_DESC_COMPLETED		0x03
> +
> +#define AE4_MAX_IDX_OFF			0x08
> +#define AE4_RD_IDX_OFF			0x0C
> +#define AE4_WR_IDX_OFF			0x10
> +#define AE4_INTR_STS_OFF		0x14
> +#define AE4_Q_BASE_L_OFF		0x18
> +#define AE4_Q_BASE_H_OFF		0x1C
> +#define AE4_Q_SZ			0x20

lower case for hex values please

> +
> +struct ae4_msix {
> +	int msix_count;
> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> +};
> +
> +struct ae4_cmd_queue {
> +	struct ae4_device *ae4;
> +	struct pt_cmd_queue cmd_q;
> +	struct list_head cmd;
> +	/* protect command operations */
> +	struct mutex cmd_lock;
> +	struct delayed_work p_work;
> +	struct workqueue_struct *pws;
> +	struct completion cmp;
> +	wait_queue_head_t q_w;
> +	atomic64_t intr_cnt;
> +	atomic64_t done_cnt;
> +	u64 q_cmd_count;
> +	u32 dridx;
> +	u32 id;
> +};
> +
> +union dwou {
> +	u32 dw0;
> +	struct dword0 {
nice naming dw0 dword0!

> +	u8	byte0;
> +	u8	byte1;
> +	u16	timestamp;
> +	} dws;
> +};
> +
> +struct dword1 {
> +	u8	status;
> +	u8	err_code;
> +	u16	desc_id;
> +};
> +
> +struct ae4dma_desc {
> +	union dwou dwouv;
> +	struct dword1 dw1;
> +	u32 length;
> +	u32 rsvd;
> +	u32 src_hi;
> +	u32 src_lo;
> +	u32 dst_hi;
> +	u32 dst_lo;
> +};
> +
> +struct ae4_device {
> +	struct pt_device pt;
> +	struct ae4_msix *ae4_msix;
> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
> +	unsigned int cmd_q_count;
> +};
> +
> +int ae4_core_init(struct ae4_device *ae4);
> +void ae4_destroy_work(struct ae4_device *ae4);
> +#endif
> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
> new file mode 100644
> index 000000000000..f9f396cd4371
> --- /dev/null
> +++ b/drivers/dma/amd/common/amd_dma.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD DMA Driver common
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> + */
> +
> +#ifndef AMD_DMA_H
> +#define AMD_DMA_H
> +
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +
> +#include "../ptdma/ptdma.h"
> +#include "../../virt-dma.h"

Header which adds other headers? That does not look good?
Why not add these in C files directly


-- 
~Vinod

