Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929A81FD9BF
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 01:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFQXkr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 19:40:47 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57816 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFQXkq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Jun 2020 19:40:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 570AF803202B;
        Wed, 17 Jun 2020 23:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WumHxgepebhi; Thu, 18 Jun 2020 02:40:41 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/9] dmaengine: Introduce DMA-device device_caps callback
Date:   Thu, 18 Jun 2020 02:40:23 +0300
Message-ID: <20200617234028.25808-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru>
References: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are DMA devices (like ours version of Synopsys DW DMAC) which have
DMA capabilities non-uniformly redistributed between the device channels.
In order to provide a way of exposing the channel-specific parameters to
the DMA engine consumers, we introduce a new DMA-device callback. In case
if provided it gets called from the dma_get_slave_caps() method and is
able to override the generic DMA-device capabilities.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Changelog v5:
- Add in-line comment at the point of the device_caps callback invocation.
- Add doc-comment for the device_caps member of struct dma_device.
---
 drivers/dma/dmaengine.c   | 10 ++++++++++
 include/linux/dmaengine.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index b332ffe52780..7d6ac0ca2af5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -598,6 +598,16 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
 
+	/*
+	 * DMA engine device might be configured with non-uniformly
+	 * distributed slave capabilities per device channels. In this
+	 * case the corresponding driver may provide the device_caps
+	 * callback to override the generic capabilities with
+	 * channel-specific ones.
+	 */
+	if (device->device_caps)
+		device->device_caps(chan, caps);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0c7403b27133..7ae0daafda82 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -792,6 +792,8 @@ struct dma_filter {
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
+ * @device_caps: May be used to override the generic DMA slave capabilities
+ *	with per-channel specific ones
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
  * @device_pause: Pauses any transfer happening on a channel. Returns
@@ -891,6 +893,8 @@ struct dma_device {
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
 
+	void (*device_caps)(struct dma_chan *chan,
+			    struct dma_slave_caps *caps);
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
 	int (*device_pause)(struct dma_chan *chan);
-- 
2.26.2

