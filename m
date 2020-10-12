Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AEF28B93E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgJLN6r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 09:58:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:29346 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbgJLN6E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 09:58:04 -0400
IronPort-SDR: 2iSXIHzNz1joRimgWc/dfunJJG6YjUa9q8c9FPPAOwCNNs7nXprrCMlC2S9/cDPo+zY7sWGpLt
 53850SBbvzMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="227387865"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="227387865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 06:58:03 -0700
IronPort-SDR: m4+dQVmhOc5UinBrvlXKAPxQG1V3XuyJr3v3C00yoZ7lZsQm92/o9IYAtXU9pQYmEwfnFyQyQ4
 XnyTJOg7w7nA==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="344893017"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 06:58:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kRyLx-0053H0-2r; Mon, 12 Oct 2020 16:59:05 +0300
Date:   Mon, 12 Oct 2020 16:59:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Message-ID: <20201012135905.GX4077@smile.fi.intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 12, 2020 at 12:21:45PM +0800, Sia Jee Heng wrote:
> The below patch series are to support AxiDMA running on Intel KeemBay SoC.
> The base driver is dw-axi-dmac but code refactoring is needed, for example:
> - Support YAML Schemas DT binding.
> - Replacing Linked List with virtual descriptor management.
> - Remove unrelated hw desc stuff from dma memory pool.
> - Manage dma memory pool alloc/destroy based on channel activity.
> - Support dmaengine device_sync() callback.
> - Support dmaengine device_config().
> - Support dmaegnine device_prep_slave_sg().
> - Support dmaengine device_prep_dma_cyclic().
> - Support of_dma_controller_register().
> - Support burst residue granularity.
> - Support Intel KeemBay AxiDMA registers.
> - Support Intel KeemBay AxiDMA device handshake.
> - Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
> - Add constraint to Max segment size.
> 
> This patch set is to replace the patch series submitted at:
> https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-email-jee.heng.sia@intel.com/

And it means effectively the bumped version, besides the fact that you double
sent this one...


Please fix and resend. Note, now is merge window is open. Depends on
maintainer's flow it may be good or bad time to resend with properly formed
changelog and version of the series.

> This patch series are tested on Intel KeemBay platform.
> 
> 
> Sia Jee Heng (15):
>   dt-bindings: dma: Add YAML schemas for dw-axi-dmac
>   dmaengine: dw-axi-dmac: simplify descriptor management
>   dmaengine: dw-axi-dmac: move dma_pool_create() to
>     alloc_chan_resources()
>   dmaengine: dw-axi-dmac: Add device_synchronize() callback
>   dmaengine: dw-axi-dmac: Add device_config operation
>   dmaengine: dw-axi-dmac: Support device_prep_slave_sg
>   dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
>   dmaengine: dw-axi-dmac: Support of_dma_controller_register()
>   dmaengine: dw-axi-dmac: Support burst residue granularity
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
>   dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
>   dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD
>     registers
>   dmaengine: dw-axi-dmac: Set constraint to the Max segment size
> 
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 149 ++++
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 696 +++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  33 +-
>  4 files changed, 783 insertions(+), 134 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> 
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


