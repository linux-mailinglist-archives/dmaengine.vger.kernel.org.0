Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62E217BE74
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFN3Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 08:29:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:44493 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgCFN3O (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Mar 2020 08:29:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 05:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; 
   d="scan'208";a="352739465"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 05:29:10 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jAD2O-007Mv4-0y; Fri, 06 Mar 2020 15:29:12 +0200
Date:   Fri, 6 Mar 2020 15:29:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
Message-ID: <20200306132912.GA1748204@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 06, 2020 at 04:10:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Baikal-T1 SoC has an DW DMAC on-board to provide a Mem-to-Mem, low-speed
> peripherals Dev-to-Mem and Mem-to-Dev functionality. Mostly it's compatible
> with currently implemented in the kernel DW DMAC driver, but there are some
> peculiarities which must be taken into account in order to have the device
> fully supported.
> 
> First of all traditionally we replaced the legacy plain text-based dt-binding
> file with yaml-based one. Secondly Baikal-T1 DW DMA Controller provides eight
> channels, which alas have different max burst length configuration.
> In particular first two channels may burst up to 128 bits (16 bytes) at a time
> while the rest of them just up to 32 bits. We must make sure that the DMA
> subsystem doesn't set values exceeding these limitations otherwise the
> controller will hang up. In third currently we discovered the problem in using
> the DW APB SPI driver together with DW DMAC. The problem happens if there is no
> natively implemented multi-block LLP transfers support and the SPI-transfer
> length exceeds the max lock size. In this case due to asynchronous handling of
> Tx- and Rx- SPI transfers interrupt we might end up with Dw APB SSI Rx FIFO
> overflow. So if DW APB SSI (or any other DMAC service consumer) intends to use
> the DMAC to asynchronously execute the transfers we'd have to at least warn
> the user of the possible errors.
> 
> Finally there is a bug in the algorithm of the nollp flag detection.
> In particular even if DW DMAC parameters state the multi-block transfers
> support there is still HC_LLP (hardcode LLP) flag, which if set makes expected
> by the driver true multi-block LLP functionality unusable. This happens cause'
> if HC_LLP flag is set the LLP registers will be hardcoded to zero so the
> contiguous multi-block transfers will be only supported. We must take the
> flag into account when detecting the LLP support otherwise the driver just
> won't work correctly.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").

Thank you for your series!

I'll definitely review it, but it will take time. So, I think due to late
submission this is material at least for v5.8.

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (5):
>   dt-bindings: dma: dw: Replace DW DMAC legacy bindings with YAML-based
>     one
>   dt-bindings: dma: dw: Add max burst transaction length property
>     bindings
>   dmaengine: dw: Add LLP and block size config accessors
>   dmaengine: dw: Introduce max burst length hw config
>   dmaengine: dw: Take HC_LLP flag into account for noLLP auto-config
> 
>  .../bindings/dma/snps,dma-spear1340.yaml      | 180 ++++++++++++++++++
>  .../devicetree/bindings/dma/snps-dma.txt      |  69 -------
>  drivers/dma/dw/core.c                         |  24 ++-
>  drivers/dma/dw/dw.c                           |   1 +
>  drivers/dma/dw/of.c                           |   9 +
>  drivers/dma/dw/regs.h                         |   3 +
>  include/linux/platform_data/dma-dw.h          |  22 +++
>  7 files changed, 238 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps-dma.txt
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


