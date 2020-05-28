Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961D31E6440
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE1Om6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:42:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:64050 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgE1Om6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:42:58 -0400
IronPort-SDR: vtbITcFiQ2YbsosHlotZ5TWQ5ITJQR6NtriOT2pykokRI0Q0Q+/Wc+ndcx+CvzhtxZj2Zmgz6C
 dfUly+lqGkhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:42:57 -0700
IronPort-SDR: MkO6wj4WQWMceXjZfzB5XHP7m55tPSxlWuNtkLPz3OT58GauzV8oD1s5UGLHxx51H7En4fHf0p
 /rVqHKTsQh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="310944024"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 07:42:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJkH-009RVq-OY; Thu, 28 May 2020 17:42:57 +0300
Date:   Thu, 28 May 2020 17:42:57 +0300
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
Subject: Re: [PATCH v3 05/10] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200528144257.GS1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:16AM +0300, Serge Semin wrote:
> There are DMA devices (like ours version of Synopsys DW DMAC) which have
> DMA capabilities non-uniformly redistributed amongst the device channels.
> In order to provide a way of exposing the channel-specific parameters to
> the DMA engine consumers, we introduce a new DMA-device callback. In case
> if provided it gets called from the dma_get_slave_caps() method and is
> able to override the generic DMA-device capabilities.

> +	if (device->device_caps)
> +		device->device_caps(chan, caps);
> +
>  	return 0;

I dunno why this returns int, but either we get rid of this returned value
(perhaps in the future, b/c it's not directly related to this series), or
something like

	if (device->device_caps)
		return device->device_caps(chan, caps);

-- 
With Best Regards,
Andy Shevchenko


