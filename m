Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CD22A3FC
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 02:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgGWA64 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 20:58:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60896 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbgGWA6z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 20:58:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EE07180045E5;
        Thu, 23 Jul 2020 00:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g0kkXRreM11a; Thu, 23 Jul 2020 03:58:52 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 03/10] dmaengine: Introduce min burst length capability
Date:   Thu, 23 Jul 2020 03:58:41 +0300
Message-ID: <20200723005848.31907-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
References: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changelog v3:
- This is a new patch created as a result of the discussion with Vinud and
  Andy in the framework of DW DMA burst and LLP capabilities.
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2b06a7a8629d..2f1a7c0c5446 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
+	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6283917edd90..669833c15dfc 100644
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

