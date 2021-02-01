Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CE30A2A6
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBAH04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 02:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhBAH0z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 02:26:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4736864DD8;
        Mon,  1 Feb 2021 07:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612163817;
        bh=Zwn/mjIhE8KaLzdWcR0nmtPEaa95EKlnI9n3HIC0218=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ul8/WhlnRwOFuGNOmIOg2qsXdwR0FMbdh0lyr8hIKNbJ2hUegMbqxnjf4wmb8PKMR
         zogaXergaIbHMklrTDNMeyJrrybJW9ETUcMiBarS1Vm3DcFB2XpoZUmWYTu6quZOBL
         G0h3GJoAVaVRRF4+qjmOPzB/wNUO5wfJ4kyTMdjRtEd0CxhTqXg8hvYnu7UTzIL1nb
         B/3Qt0H/4B6bRVqt3ncIvOATl77/QmksWaHsaS5xM2S85jjuiwhGhFXRMLgcENGGcI
         KxIs0iL/s5200ZdWSM9QjzjaWPATdiGGWcUr3I4B6aZ8mHIgXBwwPHmYqFwc75AhEV
         n5NhVXkVVfhZA==
Date:   Mon, 1 Feb 2021 12:46:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/15] dmaengine: dw-edma: HDMA support
Message-ID: <20210201071652.GN2771@vkoul-mobl>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-12-20, 18:30, Gustavo Pimentel wrote:
> This patch series adds the HDMA support, as long the IP design has set
> the compatible register map parameter, which allows compatibility at
> some degree for the existing Synopsys DesignWare eDMA driver that is
> already available on the Kernel.
> 
> The HDMA "Hyper-DMA" IP is an enhancement of the eDMA "embedded-DMA" IP.
> 
> This new improvement comes with a PCI DVSEC that allows to the driver
> recognize and switch behavior if it's an eDMA or an HDMA, becoming
> retrocompatible, in the absence of this DVSEC, the driver will assume
> that is an eDMA IP.
> 
> It also adds the interleaved support, since it will be similar to the
> current scatter-gather implementation.
> 
> As well fixes/improves some abnormal behaviors not detected before, such as:
>  - crash on loading/unloading driver
>  - memory space definition for the data area and for the linked list space
>  - scatter-gather address calculation on 32 bits platforms
>  - minor comment and variable reordering
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> 
> Gustavo Pimentel (15):
>   dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
>   dmaengine: dw-edma: Fix comments offset characters' alignment
>   dmaengine: dw-edma: Add support for the HDMA feature
>   PCI: Add pci_find_vsec_capability() to find a specific VSEC

Had this been picked up.. I see we have dependency on pci patch for this
series..

>   dmaengine: dw-edma: Add PCIe VSEC data retrieval support
>   dmaengine: dw-edma: Add device_prep_interleave_dma() support
>   dmaengine: dw-edma: Improve number of channels check
>   dmaengine: dw-edma: Reorder variables to keep consistency
>   dmaengine: dw-edma: Improve the linked list and data blocks definition
>   dmaengine: dw-edma: Change linked list and data blocks offset and
>     sizes
>   dmaengine: dw-edma: Move struct dentry variable from static definition
>     into dw_edma struct
>   dmaengine: dw-edma: Fix crash on loading/unloading driver
>   dmaengine: dw-edma: Change DMA abreviation from lower into upper case
>   dmaengine: dw-edma: Revert fix scatter-gather address calculation
>   dmaengine: dw-edma: Add pcim_iomap_table return checker
> 
>  drivers/dma/dw-edma/dw-edma-core.c       | 178 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h       |  37 ++--
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 275 +++++++++++++++++++++-------
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 300 ++++++++++++++++++++++++-------
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |   2 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  77 ++++----
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-regs.h    | 291 +++++++++++++++++++-----------
>  drivers/pci/pci.c                        |  29 +++
>  include/linux/pci.h                      |   1 +
>  include/uapi/linux/pci_regs.h            |   5 +
>  11 files changed, 844 insertions(+), 355 deletions(-)
> 
> -- 
> 2.7.4

-- 
~Vinod
