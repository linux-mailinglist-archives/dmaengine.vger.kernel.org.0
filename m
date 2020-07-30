Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFEA2335F5
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgG3Pp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 11:45:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57340 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbgG3Ppz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jul 2020 11:45:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F04418040A69;
        Thu, 30 Jul 2020 15:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KJ0HO7bzAbyZ; Thu, 30 Jul 2020 18:45:51 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] dmaengine: dw: Introduce non-mem peripherals optimizations
Date:   Thu, 30 Jul 2020 18:45:40 +0300
Message-ID: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After a lot of tests and thorough DW DMAC databook studying we've
discovered that the driver can be optimized especially when it comes to
working with non-memory peripherals.

First of all we've found out that since each DW DMAC channel can
be synthesized with different parameters, then even when two of them
are configured to perform the same DMA transactions they may execute them
with different performance. Since some DMA client devices might be
sensitive to such important parameter as performance, then it is a good
idea to let them request only suitable DMA channels. In this patchset we
introduce a functionality, which makes it possible by passing the DMA
channels mask either over the "dmas" DT property or in the dw_dma_slave
platform data descriptor.

Secondly FIFO-mode of the "FIFO readiness" criterion is more suitable for
the pure memory DMA transfers, since it minimizes the system bus
utilization, but causes some performance drop. When it comes to working with
non-memory peripherals the DMA engine performance comes to the first
place. Since normally DMA client devices keep data in internal FIFOs, any
latency at some critical moment may cause a FIFO being overflown and
consequently losing data. So in order to minimize a chance of the DW DMAC
internal FIFO being a bottle neck during the DMA transfers to and from
non-memory peripherals we propose not to use FIFO-mode for them.

Thirdly it has been discovered that using a DMA transaction length is
redundant when calculating the destination transfer width for the
dev-to-mem DMA communications. That shall increase performance of the DMA
transfers with unaligned data length.

Finally there is a small optimization in the burst length setting. In
particular we've found out, that according to the DW DMAC databoot it's
pointless to set one for the memory peripherals since they don't have
handshaking interface connected to the DMA controller. So we suggest to
just ignore the burst length config when it comes to setting the memory
peripherals up.

Note this patchset is supposed to be applied on top of the series:
Link: https://lore.kernel.org/dmaengine/20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (5):
  dt-bindings: dma: dw: Add optional DMA-channels mask cell support
  dmaengine: dw: Activate FIFO-mode for memory peripherals only
  dmaengine: dw: Discard dlen from the dev-to-mem xfer width calculation
  dmaengine: dw: Ignore burst setting for memory peripherals
  dmaengine: dw: Add DMA-channels mask cell support

 .../devicetree/bindings/dma/snps,dma-spear1340.yaml        | 7 +++++--
 drivers/dma/dw/core.c                                      | 6 +++++-
 drivers/dma/dw/dw.c                                        | 7 +++----
 drivers/dma/dw/idma32.c                                    | 5 ++---
 drivers/dma/dw/of.c                                        | 7 +++++--
 include/linux/platform_data/dma-dw.h                       | 3 +++
 6 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.27.0

