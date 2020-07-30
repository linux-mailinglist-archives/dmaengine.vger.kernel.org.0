Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023F2336F0
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3Qhd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:37:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57560 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Qhd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jul 2020 12:37:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A8F7B8030866;
        Thu, 30 Jul 2020 16:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0mIXFzg4vNJg; Thu, 30 Jul 2020 19:37:30 +0300 (MSK)
Date:   Thu, 30 Jul 2020 19:37:29 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] dmaengine: dw: Ignore burst setting for memory
 peripherals
Message-ID: <20200730163729.azi6e2ket37choub@mobilestation>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-5-Sergey.Semin@baikalelectronics.ru>
 <20200730163122.GW3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730163122.GW3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 07:31:22PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 06:45:44PM +0300, Serge Semin wrote:
> > According to the DW DMA controller Databook (page 40 "3.5 Memory
> 

> Which version of it?

2.18b

> 
> > Peripherals") memory peripherals don't have handshaking interface
> > connected to the controller, therefore they can never be a flow
> > controller. Since the CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are
> > properties valid only for peripherals with a handshaking
> > interface, we can freely zero these fields out if the memory peripheral
> > is selected to be the source or the destination of the DMA transfers.
> > 
> > Note according to the databook, length of burst transfers to memory is
> > always equal to the number of data items available in a channel FIFO or
> > data items required to complete the block transfer, whichever is smaller;
> > length of burst transfers from memory is always equal to the space
> > available in a channel FIFO or number of data items required to complete
> > the block transfer, whichever is smaller.
> 

> But does it really matter if you program there something or not?

For memory peripherals it doesn't. But it's better to remove the redundant
settings for consistency with the doc and to get rid of the unneeded
stack-variable declaration.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
