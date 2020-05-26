Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB171E3328
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 00:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404590AbgEZWvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 18:51:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60256 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404569AbgEZWvo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 May 2020 18:51:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 315BB803086B;
        Tue, 26 May 2020 22:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SpAFzcB6n2pf; Wed, 27 May 2020 01:51:40 +0300 (MSK)
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
Subject: [PATCH v3 03/10] dmaengine: Introduce min burst length capability
Date:   Wed, 27 May 2020 01:50:14 +0300
Message-ID: <20200526225022.20405-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some hardware aside from default 0/1 may have greater minimum burst
transactions length constraints. Here we introduce the DMA device
and slave capability, which if required can be initialized by the DMA
engine driver with the device-specific value.

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
- This is a new patch created as a result of the discussion with Vinud and
  Andy in the framework of DW DMA burst and LLP capabilities.
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d31076d9ef25..b332ffe52780 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -590,6 +590,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
+	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e1c03339918f..0c7403b27133 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -465,6 +465,7 @@ enum dma_residue_granularity {
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
+ * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
  * @cmd_pause: true, if pause is supported (i.e. for reading residue or
  *	       for resume later)
@@ -478,6 +479,7 @@ struct dma_slave_caps {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	u32 min_burst;
 	u32 max_burst;
 	bool cmd_pause;
 	bool cmd_resume;
@@ -769,6 +771,7 @@ struct dma_filter {
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
+ * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
@@ -839,6 +842,7 @@ struct dma_device {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	u32 min_burst;
 	u32 max_burst;
 	bool descriptor_reuse;
 	enum dma_residue_granularity residue_granularity;
-- 
2.26.2

