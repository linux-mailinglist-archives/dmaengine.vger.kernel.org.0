Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F621B26A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGJJii (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 05:38:38 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49904 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJii (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jul 2020 05:38:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D2ABA803202B;
        Fri, 10 Jul 2020 09:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S5HEgB7Js0P8; Fri, 10 Jul 2020 12:38:35 +0300 (MSK)
Date:   Fri, 10 Jul 2020 12:38:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200710093834.su3nsjesnhntpd6d@mobilestation>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200710084503.GE3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
> > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > DMA capabilities non-uniformly redistributed between the device channels.
> > In order to provide a way of exposing the channel-specific parameters to
> > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > if provided it gets called from the dma_get_slave_caps() method and is
> > able to override the generic DMA-device capabilities.
> 

> In light of recent developments consider not to add 'slave' and a such words to the kernel.

As long as the 'slave' word is used in the name of the dma_slave_caps
structure and in the rest of the DMA-engine subsystem, it will be ambiguous
to use some else terminology. If renaming needs to be done, then it should be
done synchronously for the whole subsystem.

-Sergey

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
