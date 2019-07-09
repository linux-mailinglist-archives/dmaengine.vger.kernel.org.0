Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB8636F5
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGIN3r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jul 2019 09:29:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:57176 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfGIN3r (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jul 2019 09:29:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 06:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="165763391"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2019 06:29:45 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkqBj-0003nZ-Tk; Tue, 09 Jul 2019 16:29:43 +0300
Date:   Tue, 9 Jul 2019 16:29:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Fletcher Woodruff <fletcherw@google.com>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Message-ID: <20190709132943.GB9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709131401.GA9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:

> So, the correct fix is to provide a platform data, like it's done in
> drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> 
> (It will require latest patches to be applied, which are material for v5.x)

Below completely untested patch to try

--- 8< --- 8< --- 8< ---

 From 2bd36a75460613f0a14f0763b766cae8ce20c57d Mon Sep 17 00:00:00 2001
 From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Date: Tue, 9 Jul 2019 16:24:35 +0300
 Subject: [PATCH 1/1] ASoC: Intel: common: Use proper DMA controller type

It has been reported that Intel Broadwell machines can't use SST
since DMA driver probe failure. The root cause *maybe* in a wrong type
of DMA controller in use.

Use Intel iDMA 32-bit instead of Synopsys DesignWare controller for Intel SST.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/common/sst-firmware.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index d27947aeb079..5da7fb74c845 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -174,6 +174,16 @@ static int block_list_prepare(struct sst_dsp *dsp,
 	return ret;
 }
 
+static const struct dw_dma_platform_data idma32_pdata = {
+	.nr_channels = 8,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+	.block_size = 131071,
+	.nr_masters = 1,
+	.data_width = {4},
+	.multi_block = {1, 1, 1, 1, 1, 1, 1, 1},
+};
+
 static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 	int irq)
 {
@@ -184,6 +194,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 	if (!chip)
 		return ERR_PTR(-ENOMEM);
 
+	chip->pdata = &idma32_pdata;
 	chip->irq = irq;
 	chip->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(chip->regs))
@@ -195,7 +206,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 
 	chip->dev = dev;
 
-	err = dw_dma_probe(chip);
+	err = idma32_dma_probe(chip);
 	if (err)
 		return ERR_PTR(err);
 
@@ -204,7 +215,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 
 static void dw_remove(struct dw_dma_chip *chip)
 {
-	dw_dma_remove(chip);
+	idma32_dma_remove(chip);
 }
 
 static bool dma_chan_filter(struct dma_chan *chan, void *param)
-- 
2.20.1



-- 
With Best Regards,
Andy Shevchenko


