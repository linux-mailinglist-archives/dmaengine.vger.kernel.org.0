Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4E1E8081
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2OlH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 10:41:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48936 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgE2OlH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 10:41:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 00DB18029EA0;
        Fri, 29 May 2020 14:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O2GusPnYRTL7; Fri, 29 May 2020 17:41:03 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 08/11] dmaengine: dw: Add dummy device_caps callback
Date:   Fri, 29 May 2020 17:40:51 +0300
Message-ID: <20200529144054.4251-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
have non-uniform DMA capabilities per device channels, let's add
the DW DMA specific device_caps callback to expose that specifics up to
the DMA consumer. It's a dummy function for now. We'll fill it in with
capabilities overrides in the next commits.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- This is a new patch created as a result of the discussion with Vinud and
  Andy in the framework of DW DMA burst and LLP capabilities.
---
 drivers/dma/dw/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index fb95920c429e..ceded21537e2 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1049,6 +1049,11 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
+static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
+{
+
+}
+
 int do_dma_probe(struct dw_dma_chip *chip)
 {
 	struct dw_dma *dw = chip->dw;
@@ -1214,6 +1219,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_prep_dma_memcpy = dwc_prep_dma_memcpy;
 	dw->dma.device_prep_slave_sg = dwc_prep_slave_sg;
 
+	dw->dma.device_caps = dwc_caps;
 	dw->dma.device_config = dwc_config;
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
-- 
2.26.2

