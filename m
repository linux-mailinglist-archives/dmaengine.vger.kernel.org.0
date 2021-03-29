Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2B34C302
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhC2F3P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Mar 2021 01:29:15 -0400
Received: from verein.lst.de ([213.95.11.211]:52014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhC2F3N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Mar 2021 01:29:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F142568BEB; Mon, 29 Mar 2021 07:29:10 +0200 (CEST)
Date:   Mon, 29 Mar 2021 07:29:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] DMA: Mundane typo fixes
Message-ID: <20210329052910.GB26495@lst.de>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I really don't think these typo patchbomb are that useful.  I'm all
for fixing typos when working with a subsystem, but I'm not sure these
patchbombs help anything.

On Mon, Mar 29, 2021 at 05:22:56AM +0530, Bhaskar Chowdhury wrote:
> This patch series fixes some trivial and rudimentary spellings in the COMMENT
> sections.
> 
> Bhaskar Chowdhury (30):
>   acpi-dma.c: Fix couple of typos
>   altera-msgdma.c: Couple of typos fixed
>   amba-pl08x.c: Fixed couple of typos
>   bcm-sba-raid.c: Few typos fixed
>   bcm2835-dma.c: Fix a typo
>   idma64.c: Fix couple of typos
>   iop-adma.c: Few typos fixed
>   mv_xor.c: Fix a typo
>   mv_xor.h: Fixed a typo
>   mv_xor_v2.c: Fix a typo
>   nbpfaxi.c: Fixed a typo
>   of-dma.c: Fixed a typo
>   s3c24xx-dma.c: Fix a typo
>   Revert "s3c24xx-dma.c: Fix a typo"
>   s3c24xx-dma.c: Few typos fixed
>   st_fdma.h: Fix couple of typos
>   ste_dma40_ll.h: Fix a typo
>   tegra20-apb-dma.c: Fixed a typo
>   xgene-dma.c: Few spello fixes
>   at_hdmac.c: Quite a few spello fixes
>   owl-dma.c: Fix a typo
>   at_hdmac_regs.h: Couple of typo fixes
>   dma-jz4780.c: Fix a typo
>   Kconfig: Change Synopsys to Synopsis
>   ste_dma40.c: Few spello fixes
>   dw-axi-dmac-platform.c: Few typos fixed
>   dpaa2-qdma.c: Fix a typo
>   usb-dmac.c: Fix a typo
>   edma.c: Fix a typo
>   xilinx_dma.c: Fix a typo
> 
>  drivers/dma/Kconfig                            |  8 ++++----
>  drivers/dma/acpi-dma.c                         |  4 ++--
>  drivers/dma/altera-msgdma.c                    |  4 ++--
>  drivers/dma/amba-pl08x.c                       |  4 ++--
>  drivers/dma/at_hdmac.c                         | 14 +++++++-------
>  drivers/dma/at_hdmac_regs.h                    |  4 ++--
>  drivers/dma/bcm-sba-raid.c                     |  8 ++++----
>  drivers/dma/bcm2835-dma.c                      |  2 +-
>  drivers/dma/dma-jz4780.c                       |  2 +-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  8 ++++----
>  drivers/dma/idma64.c                           |  4 ++--
>  drivers/dma/iop-adma.c                         |  6 +++---
>  drivers/dma/mv_xor.c                           |  2 +-
>  drivers/dma/mv_xor.h                           |  2 +-
>  drivers/dma/mv_xor_v2.c                        |  2 +-
>  drivers/dma/nbpfaxi.c                          |  2 +-
>  drivers/dma/of-dma.c                           |  2 +-
>  drivers/dma/owl-dma.c                          |  2 +-
>  drivers/dma/s3c24xx-dma.c                      |  6 +++---
>  drivers/dma/sh/shdmac.c                        |  2 +-
>  drivers/dma/sh/usb-dmac.c                      |  2 +-
>  drivers/dma/st_fdma.h                          |  4 ++--
>  drivers/dma/ste_dma40.c                        | 10 +++++-----
>  drivers/dma/ste_dma40_ll.h                     |  2 +-
>  drivers/dma/tegra20-apb-dma.c                  |  2 +-
>  drivers/dma/ti/edma.c                          |  2 +-
>  drivers/dma/xgene-dma.c                        |  6 +++---
>  drivers/dma/xilinx/xilinx_dma.c                |  2 +-
>  28 files changed, 59 insertions(+), 59 deletions(-)
> 
> --
> 2.26.3
---end quoted text---
