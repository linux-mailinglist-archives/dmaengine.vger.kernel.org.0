Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C613313F29
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhBHTgu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 14:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236348AbhBHTf7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Feb 2021 14:35:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FEE960238;
        Mon,  8 Feb 2021 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612812918;
        bh=MGpnihOYgovKUNDN8RKjHCBSWobXEqBkmqJNNNAU/3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aP+eunnCA20VP1zI4U0hV5jEh6HZTUkp/JehiOF9qu/veMnajkSD5d2+26+ErWDaA
         Tcnv00QAGC7mX2eSOC4umMTvYmyaUDFSL48/whkYmc/NBMLooV9tSj+40wXUnoj32y
         Wlw/+DAY9z9B64Sn3MqWj4+z0VkrlGD7rjmso/hy9GIxXxdbO8YB7qqEjNEWZ4I3JG
         CvCK4/hgZhjsqfI75qq71RnU0UoBgy2UOzmgFT3Jhg7gRP3VvC3GGiPDlgr5KlJ6Us
         d9JiPxaWK3+709ykTaOxAhQD0CbtxRnKFu2hlsHFyj4CyXnQuLMkl8yhHD9MctBtuC
         yJPPNzN3u39Ug==
Date:   Mon, 8 Feb 2021 13:35:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v4 15/15] dmaengine: dw-edma: Add pcim_iomap_table return
 checker
Message-ID: <20210208193516.GA406304@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb5eb396e417f9e45d39fd5ef565ba77aae6a63.1612389406.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[+cc Krzysztof]

From reading the subject, I thought you were adding a function to
check the return values, i.e., a "checker."  But you're really adding
"checks" :)

On Wed, Feb 03, 2021 at 10:58:06PM +0100, Gustavo Pimentel wrote:
> Detected by CoverityScan CID 16555 ("Dereference null return")
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 686b4ff..7445033 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -238,6 +238,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
>  
>  	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	if (!dw->rg_region.vaddr)
> +		return -ENOMEM;

This doesn't seem quite right.  If pcim_iomap_table() fails, it
returns NULL.  But then we assign "vaddr = NULL[vsec_data.rg.bar]"
which dereferences the NULL pointer even before your test.

This "pcim_iomap_table(dev)[n]" pattern is extremely common.  There
are over 100 calls of pcim_iomap_table(), and

  $ git grep "pcim_iomap_table(.*)\[.*\]" | wc -l

says about 75 of them are of this form, where we dereference the
result before testing it.

>  	dw->rg_region.vaddr += vsec_data.rg.off;
>  	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
>  	dw->rg_region.paddr += vsec_data.rg.off;
> @@ -250,12 +253,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
>  
>  		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
> +		if (!ll_region->vaddr)
> +			return -ENOMEM;
> +
>  		ll_region->vaddr += ll_block->off;
>  		ll_region->paddr = pdev->resource[ll_block->bar].start;
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
>  		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
> +		if (!dt_region->vaddr)
> +			return -ENOMEM;
> +
>  		dt_region->vaddr += dt_block->off;
>  		dt_region->paddr = pdev->resource[dt_block->bar].start;
>  		dt_region->paddr += dt_block->off;
> @@ -269,12 +278,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
>  
>  		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
> +		if (!ll_region->vaddr)
> +			return -ENOMEM;
> +
>  		ll_region->vaddr += ll_block->off;
>  		ll_region->paddr = pdev->resource[ll_block->bar].start;
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
>  		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
> +		if (!dt_region->vaddr)
> +			return -ENOMEM;
> +
>  		dt_region->vaddr += dt_block->off;
>  		dt_region->paddr = pdev->resource[dt_block->bar].start;
>  		dt_region->paddr += dt_block->off;
> -- 
> 2.7.4
> 
