Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD821E143
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 22:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGMUNL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 16:13:11 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58364 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgGMUNL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Jul 2020 16:13:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 51EBA8030866;
        Mon, 13 Jul 2020 20:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RqU2vW_Nx0sU; Mon, 13 Jul 2020 23:13:07 +0300 (MSK)
Date:   Mon, 13 Jul 2020 23:13:06 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200713201306.4rfmvtjzklcldajc@mobilestation>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
 <20200710093834.su3nsjesnhntpd6d@mobilestation>
 <20200713065131.GG34333@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200713065131.GG34333@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vinod,
  
Could you please keep on this patchset review? Really, the patchset isn't that
big and complicated to be working on it for such a long time. I've sent it out
at the time of the kernel 5.6. I've considered all the Andy's comments since
then. There is going to be 5.9 merge window soon, but the patchset still under
review procedure, while I still have some work, which depends on the changes
provided by this patchset. It would be great to at least submit it for review
before the next merge window, and super-great have it merged in before that.

There is a Peter Ujfalusi comment to the patch
"[PATCH v7 04/11] dmaengine: Introduce max SG list entries capability", which
needs your attention. Could you please take a look at that? So I could submit
the next patchset revision if you agree with the Peter' suggestion.

-Sergey

On Mon, Jul 13, 2020 at 12:21:31PM +0530, Vinod Koul wrote:
> On 10-07-20, 12:38, Serge Semin wrote:
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
> Right, I have plans to tackle that during next merge window and have
> started changes. Thankfully slave_dma can be replaced by peripheral dma
> easily. But getting that in would be tricky as we need to change users
> too.
> 
> -- 
> ~Vinod
