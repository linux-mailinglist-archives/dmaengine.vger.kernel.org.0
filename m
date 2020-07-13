Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4A21D00F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgGMGvg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 02:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgGMGvg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jul 2020 02:51:36 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE78920663;
        Mon, 13 Jul 2020 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594623095;
        bh=eICm5z1aVZzbICki22PDS3qQwA4tGgtSA08FRFspzSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0u/PPKPVHJrtXQ1BQ9UECn/8iSxQKll6GDhkWKShES2uESX6/+sOpgtEBloL5Oo1O
         H7Qe0n1nCHNokb7cv+f3Gv4yg6+lVdhaQwZ4TtKlV5LyCrtRdy0OnP0k5kGvd3eA4y
         ZbAMNdnelKHkzhPwyE/PCcwOXoCqldskaj7Y/veQ=
Date:   Mon, 13 Jul 2020 12:21:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200713065131.GG34333@vkoul-mobl>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
 <20200710093834.su3nsjesnhntpd6d@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710093834.su3nsjesnhntpd6d@mobilestation>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-20, 12:38, Serge Semin wrote:
> On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
> > > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > > DMA capabilities non-uniformly redistributed between the device channels.
> > > In order to provide a way of exposing the channel-specific parameters to
> > > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > > if provided it gets called from the dma_get_slave_caps() method and is
> > > able to override the generic DMA-device capabilities.
> > 
> 
> > In light of recent developments consider not to add 'slave' and a such words to the kernel.
> 
> As long as the 'slave' word is used in the name of the dma_slave_caps
> structure and in the rest of the DMA-engine subsystem, it will be ambiguous
> to use some else terminology. If renaming needs to be done, then it should be
> done synchronously for the whole subsystem.

Right, I have plans to tackle that during next merge window and have
started changes. Thankfully slave_dma can be replaced by peripheral dma
easily. But getting that in would be tricky as we need to change users
too.

-- 
~Vinod
