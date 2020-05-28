Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5760C1E6ED1
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437184AbgE1WY6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 18:24:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44664 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437101AbgE1WYR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 18:24:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DF16E80307FF;
        Thu, 28 May 2020 22:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7mYJfmEeV4PI; Fri, 29 May 2020 01:24:11 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/11] dmaengine: Introduce DMA-device device_caps callback
Date:   Fri, 29 May 2020 01:23:55 +0300
Message-ID: <20200528222401.26941-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are DMA devices (like ours version of Synopsys DW DMAC) which have
DMA capabilities non-uniformly redistributed amongst the device channels.
In order to provide a way of exposing the channel-specific parameters to
the DMA engine consumers, we introduce a new DMA-device callback. In case
if provided it gets called from the dma_get_slave_caps() method and is
able to override the generic DMA-device capabilities.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- This is a new patch created as a result of the discussion with Vinod and
  Andy in the framework of DW DMA burst and LLP capabilities.
---
 drivers/dma/dmaengine.c   | 3 +++
 include/linux/dmaengine.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ad56ad58932c..edbb11d56cde 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -599,6 +599,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
 
+	if (device->device_caps)
+		device->device_caps(chan, caps);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index a7e4d8dfdd19..b303e59929e5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -899,6 +899,8 @@ struct dma_device {
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
 
+	void (*device_caps)(struct dma_chan *chan,
+			    struct dma_slave_caps *caps);
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
 	int (*device_pause)(struct dma_chan *chan);
-- 
2.26.2

