Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8936245C74
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 08:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHQG2w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 02:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgHQG2w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 02:28:52 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A30F2072D;
        Mon, 17 Aug 2020 06:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597645731;
        bh=zgG5YK7dMuJoaX/adKMs8azihNBpyM/EWQGkvgUQ3FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNh6IclMsXLEQIkIYr87LuuVcBbMCb2ZEhGGkg7cD9XMw+48rhP7//JMe8w8/wZsD
         Wf7I5GC9Wp8CitVG5S3kcJZ2JkvUkYk/xS9LILOotAk9OfDWunApV7NJbEjS9clSUZ
         gR3qTZUyDeutkvhSf/GRiQMuVK9BVPVdb/S0KcfU=
Date:   Mon, 17 Aug 2020 11:58:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] dmaengine: dw: Introduce non-mem peripherals
 optimizations
Message-ID: <20200817062847.GM2639@vkoul-mobl>
References: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-20, 23:08, Serge Semin wrote:
> After a lot of tests and thorough DW DMAC databook studying we've
> discovered that the driver can be optimized especially when it comes to
> working with non-memory peripherals.
> 
> First of all we've found out that since each DW DMAC channel can
> be synthesized with different parameters, then even when two of them
> are configured to perform the same DMA transactions they may execute them
> with different performance. Since some DMA client devices might be
> sensitive to such important parameter as performance, then it is a good
> idea to let them request only suitable DMA channels. In this patchset we
> introduce a functionality, which makes it possible by passing the DMA
> channels mask either over the "dmas" DT property or in the dw_dma_slave
> platform data descriptor.
> 
> Secondly FIFO-mode of the "FIFO readiness" criterion is more suitable for
> the pure memory DMA transfers, since it minimizes the system bus
> utilization, but causes some performance drop. When it comes to working with
> non-memory peripherals the DMA engine performance comes to the first
> place. Since normally DMA client devices keep data in internal FIFOs, any
> latency at some critical moment may cause a FIFO being overflown and
> consequently losing data. So in order to minimize a chance of the DW DMAC
> internal FIFO being a bottle neck during the DMA transfers to and from
> non-memory peripherals we propose not to use FIFO-mode for them.
> 
> Thirdly it has been discovered that using a DMA transaction length is
> redundant when calculating the destination transfer width for the
> dev-to-mem DMA communications. That shall increase performance of the DMA
> transfers with unaligned data length.
> 
> Finally there is a small optimization in the burst length setting. In
> particular we've found out, that according to the DW DMAC databoot it's
> pointless to set one for the memory peripherals since they don't have
> handshaking interface connected to the DMA controller. So we suggest to
> just ignore the burst length config when it comes to setting the memory
> peripherals up.

Applied all, thanks

-- 
~Vinod
