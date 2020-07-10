Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D6C21B190
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGJIpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 04:45:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:24374 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgGJIpH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jul 2020 04:45:07 -0400
IronPort-SDR: 9hRgbwXRXcbgbnZ8vur1a3PR/ynxpmLLJRCD84paMBm7VBzB3/8dF2kITVgD7GTH/tGf5S7B5s
 QjnS06IXOXQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213056418"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="213056418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 01:45:05 -0700
IronPort-SDR: c0JgcaSniB4CoBNI3AJkJW888/iyZ2r740ImfuM+/UZsaaY2DXyshWTX5zLS/+VKFCjSvjTZdZ
 Xz0Y9Sa2HEHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="458218230"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2020 01:45:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtoeV-0011Op-Fz; Fri, 10 Jul 2020 11:45:03 +0300
Date:   Fri, 10 Jul 2020 11:45:03 +0300
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
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200710084503.GE3703480@smile.fi.intel.com>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
> There are DMA devices (like ours version of Synopsys DW DMAC) which have
> DMA capabilities non-uniformly redistributed between the device channels.
> In order to provide a way of exposing the channel-specific parameters to
> the DMA engine consumers, we introduce a new DMA-device callback. In case
> if provided it gets called from the dma_get_slave_caps() method and is
> able to override the generic DMA-device capabilities.

In light of recent developments consider not to add 'slave' and a such words to the kernel.


-- 
With Best Regards,
Andy Shevchenko


