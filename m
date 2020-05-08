Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7251CA9CC
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLlz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:41:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:13975 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLlz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:41:55 -0400
IronPort-SDR: GWIdDZpYotfAyhLXAZ/vF4xmmW7kpozpBVAbes897bMNR67Nrzw4HVjdyabgGCLoQCeaouNuap
 uWS5ATtAyOIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:41:54 -0700
IronPort-SDR: pqg9ea5sq3gBLSKmJxZ9towtF/mCW6bdxqTrsGht2U1AuNh9Tf7N59C7x/gjEhg9hQJQqbAM46
 C59FwBIt5bNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="339694730"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2020 04:41:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX1O5-005POV-Nl; Fri, 08 May 2020 14:41:53 +0300
Date:   Fri, 8 May 2020 14:41:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
Subject: Re: [PATCH v2 5/6] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200508114153.GK185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 01:53:03PM +0300, Serge Semin wrote:
> IP core of the DW DMA controller may be synthesized with different
> max burst length of the transfers per each channel. According to Synopsis
> having the fixed maximum burst transactions length may provide some
> performance gain. At the same time setting up the source and destination
> multi size exceeding the max burst length limitation may cause a serious
> problems. In our case the system just hangs up. In order to fix this
> lets introduce the max burst length platform config of the DW DMA
> controller device and don't let the DMA channels configuration code
> exceed the burst length hardware limitation. Depending on the IP core
> configuration the maximum value can vary from channel to channel.
> It can be detected either in runtime from the DWC parameter registers
> or from the dedicated dts property.

I'm wondering what can be the scenario when your peripheral will ask something
which is not supported by DMA controller?

Peripheral needs to supply a lot of configuration parameters specific to the
DMA controller in use (that's why we have struct dw_dma_slave).
So, seems to me the feasible approach is supply correct data in the first place.

If you have specific channels to acquire then you probably need to provide a
custom xlate / filter functions. Because above seems a bit hackish workaround
of dynamic channel allocation mechanism.

But let's see what we can do better. Since maximum is defined on the slave side
device, it probably needs to define minimum as well, otherwise it's possible
that some hardware can't cope underrun bursts.

Vinod, what do you think?

-- 
With Best Regards,
Andy Shevchenko


