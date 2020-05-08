Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093C61CA985
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHL0G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:26:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:48123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHL0G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:26:06 -0400
IronPort-SDR: Z7Woj9NpJedFYMWO2l2Q9pv+ijHM5MzBE53xGs6YC+JDrhqERuqo1xpomLznzMEAQSYqqQ/Xw9
 4RnLjBVpXaRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:26:05 -0700
IronPort-SDR: EJZ25u9TwWmhpMu7/TpuqpIjDfqgRYL2yc1H4yD9ePqQNKbeHjWIx7T1RrS+YZTp/H774yoX3l
 1zXHlDGocy/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="462497652"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2020 04:26:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX18m-005PHB-R0; Fri, 08 May 2020 14:26:04 +0300
Date:   Fri, 8 May 2020 14:26:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200508112604.GJ185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Cc: Mark (question about SPI + DMA workflow)

On Fri, May 08, 2020 at 01:53:02PM +0300, Serge Semin wrote:
> Multi-block support provides a way to map the kernel-specific SG-table so
> the DW DMA device would handle it as a whole instead of handling the
> SG-list items or so called LLP block items one by one. So if true LLP
> list isn't supported by the DW DMA engine, then soft-LLP mode will be
> utilized to load and execute each LLP-block one by one. A problem may
> happen for multi-block DMA slave transfers, when the slave device buffers
> (for example Tx and Rx FIFOs) depend on each other and have size smaller
> than the block size. In this case writing data to the DMA slave Tx buffer
> may cause the Rx buffer overflow if Rx DMA channel is paused to
> reinitialize the DW DMA controller with a next Rx LLP item. In particular
> We've discovered this problem in the framework of the DW APB SPI device

Mark, do we have any adjustment knobs in SPI core to cope with this?

> working in conjunction with DW DMA. Since there is no comprehensive way to
> fix it right now lets at least print a warning for the first found
> multi-blockless DW DMAC channel. This shall point a developer to the
> possible cause of the problem if one would experience a sudden data loss.

-- 
With Best Regards,
Andy Shevchenko


