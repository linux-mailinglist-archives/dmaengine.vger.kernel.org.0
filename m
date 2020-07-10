Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65321B1B8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGJIxB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 04:53:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:6065 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGJIxB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jul 2020 04:53:01 -0400
IronPort-SDR: l9fjHArwszqsaGn3r9+wIPdu85PhiqRIGY4VE9BJHjU1s2kp2McgB/dZHAfGasNRvzNH743Oj6
 gu/p8t+QQ4Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="166261589"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="166261589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 01:53:00 -0700
IronPort-SDR: 4aHkhL0w0yOuCrWxuFpni5YCq9aksJvJK62MuowlK8S8jL8LTaItN+0eIApHptMMJXbflEoguA
 W/AH5SXeMSJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="298361965"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2020 01:52:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtomA-0011SQ-4A; Fri, 10 Jul 2020 11:52:58 +0300
Date:   Fri, 10 Jul 2020 11:52:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200710085258.GG3703480@smile.fi.intel.com>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-9-Sergey.Semin@baikalelectronics.ru>
 <20200710085123.GF3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710085123.GF3703480@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 10, 2020 at 11:51:23AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 10, 2020 at 01:45:47AM +0300, Serge Semin wrote:
> > Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> > have non-uniform DMA capabilities per device channels, let's add
> > the DW DMA specific device_caps callback to expose that specifics up to
> > the DMA consumer. It's a dummy function for now. We'll fill it in with
> > capabilities overrides in the next commits.
> 
> Just a reminder (mainly to Vinod) of my view to this.
> Unneeded churn, should be folded to patch 9.

Sorry, s/9/10/ (also the sign that they should be in one, rather than spread
over the series).

-- 
With Best Regards,
Andy Shevchenko


