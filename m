Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895521F6BA
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGNQIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 12:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQIf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 12:08:35 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AE822515;
        Tue, 14 Jul 2020 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594742914;
        bh=m1sZU8ZEuecg3AdLYhlDX2E1cX3Y8hJyqEV30UQuGNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYPw/QTslqDwXMkvcuWmgLjUlIp+8O6gOIUKVUY2+TlTa34zQ+zz1U09lJOwQW09S
         Zs39faJMF1AQ5iw8NUoRb+aOAmoaJq57/pNyE2didK61rX+fg7Upj2jbx+qnSqFSBo
         krdukl4duieXXuhukMg/55wm4P/zD5q7x9vpVeLg=
Date:   Tue, 14 Jul 2020 21:38:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200714160830.GL34333@vkoul-mobl>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
 <20200710093834.su3nsjesnhntpd6d@mobilestation>
 <07d4a977-1de6-b611-3d4f-7c7d6cd7fe5f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d4a977-1de6-b611-3d4f-7c7d6cd7fe5f@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-07-20, 13:55, Dave Jiang wrote:
> 
> 
> On 7/10/2020 2:38 AM, Serge Semin wrote:
> > On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
> > > > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > > > DMA capabilities non-uniformly redistributed between the device channels.
> > > > In order to provide a way of exposing the channel-specific parameters to
> > > > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > > > if provided it gets called from the dma_get_slave_caps() method and is
> > > > able to override the generic DMA-device capabilities.
> > > 
> > 
> > > In light of recent developments consider not to add 'slave' and a such words to the kernel.
> > 
> > As long as the 'slave' word is used in the name of the dma_slave_caps
> > structure and in the rest of the DMA-engine subsystem, it will be ambiguous
> > to use some else terminology. If renaming needs to be done, then it should be
> > done synchronously for the whole subsystem.
> 
> What about just calling it dma_device_caps? Consider this is a useful
> function not only slave DMA will utilize this. I can see this being useful
> for some of my future code with idxd driver.

Some of the caps may make sense to generic dmaengine but few of them do
not :) While at it, am planning to make it dmaengine_periph_caps to
denote that these are dmaengine peripheral capabilities.

-- 
~Vinod
