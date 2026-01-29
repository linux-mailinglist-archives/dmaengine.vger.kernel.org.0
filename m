Return-Path: <dmaengine+bounces-8580-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DZSM+NKe2l/DgIAu9opvQ
	(envelope-from <dmaengine+bounces-8580-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 12:56:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE5AFD4A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DB2A3002B74
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A733876BA;
	Thu, 29 Jan 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV7v2PXI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE424385EE1;
	Thu, 29 Jan 2026 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687774; cv=none; b=FR8ql8VzTpm/QVaeIfIwKtC0IlHUNN2FdglQTB35ObNi91ul2g0U69sQX6bpQSP/9KCxru0QqqirqZ8SFseLkL5YjwaXhpDVwZPufv+IFwth6XXaX1KErzKgtGkEz1C+5pyZ7qY82dpYuws9CbPifJDBD/bFqFfgoX9ZUaARC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687774; c=relaxed/simple;
	bh=R72T8zgTTX0qxrzTcx+qdFyx66AvGzQQc48dBJ75vPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quGHdvxxZhFvKGKcATa83+YG9sc5m47rk25RqmdwpdQ5Jekn29sYYUK+H1rch1IbksdjAwcSM2ICo/NyDr75zi0J0wdROmVQMx/vn6s6nochtn1LrpsOMlR6dSFle6cWTX3D09EI3C9LEbK632TDDsfxJPtU1DLbB4/E8KwQl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XV7v2PXI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769687773; x=1801223773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R72T8zgTTX0qxrzTcx+qdFyx66AvGzQQc48dBJ75vPk=;
  b=XV7v2PXI0f346m2roQOYDkSYiXZ0C1NwVOZFKueDMcEkFmtaZBv4k4zv
   0qRO0Eb0SjjGgAUzBuldtnCnBDBwSkedx9tcLxhGuGGJsj/8CAcOrDZWB
   /ttlshmeB/30nlJHb0XFey0FcUEB7fajUDinp7j9DZmOO4rzBE0FrTvRb
   MFnYgn6v0w4gb4iNyAbda5P6TFJOeWPJWoCbXSjawFabxFILf3u4eVhQR
   lPHHwLxu5UOxZtiHFd0jIhgP0h5mW7gvm5+8M71JRzzLxBnRRlhhdqqrO
   jLz/iO4DFArjxa1Go5Fgh5ycj9CIp2KKbopDkFlM3uBJefs3qE7rrpF9B
   Q==;
X-CSE-ConnectionGUID: qt47JDKNQFei/3O4AXkeQQ==
X-CSE-MsgGUID: 8s0/bMnHTrOM0WKwnMSd4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82351956"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="82351956"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:56:12 -0800
X-CSE-ConnectionGUID: IPnGDXsGQ0eMXR7nczGBZQ==
X-CSE-MsgGUID: Q9BSsIlaSVycS69m7+liUQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jan 2026 03:56:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 495B69B; Thu, 29 Jan 2026 12:56:09 +0100 (CET)
Date: Thu, 29 Jan 2026 12:56:09 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260129115609.GV2275908@black.igk.intel.com>
References: <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
 <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
 <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8580-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2DE5AFD4A
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:20:22AM -0500, correctmost wrote:
> >> > Can you next apply the below patch (only that one) and try? Any test case
> >> > where it reproduces is good. The provide again full dmesg. While at it can
> >> > you enable CONFIG_PRINTK_TIME=y so we can also get timestamps to the dmesg.
> >> 
> >> Full log attached with the added debug prints and timestamps
> >
> > Thanks! Okay so the interrupt is active immediately when the LPSS probes.
> > One thing that could explain this is that the IO-APIC is misconfigured to
> > have the polarity reversed. Can you boot with "apic=debug" in the kernel
> > command line so that it dumps the entries and provide again full dmesg?
> 
> Sure, full log attached

Thanks! The IO-APIC configuration seems fine too. I also compared with my
MTLP based reference system and it shows the same (but my system does not
have this issue).

Let's add even more debug. Can you replace the previous hack patch with the
below.

You can drop the "apic=debug" from the command line but can you add
acpi.dyndbg=+p" instead.

Then also enable CONFIG_PCI_DEBUG=y.

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index d147353d47ab..9c06b137ed0b 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -6,6 +6,7 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
+#define DEBUG
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -171,6 +172,8 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 	u32 status_err;
 	unsigned short i;
 
+	dev_dbg_ratelimited(idma64->dma.dev, "status=%#x\n", status);
+
 	/* Since IRQ may be shared, check if DMA controller is powered on */
 	if (status == GENMASK(31, 0))
 		return IRQ_NONE;
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 5b1e8f74c4ac..6be3ce3edd4b 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -772,12 +772,17 @@ static int i2c_dw_runtime_suspend(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
 
+	dev_info(device, "runtime suspend start\n");
+
+
 	if (dev->shared_with_punit)
 		return 0;
 
 	i2c_dw_disable(dev);
 	i2c_dw_prepare_clk(dev, false);
 
+	dev_info(device, "runtime suspend finished\n");
+
 	return 0;
 }
 
@@ -794,11 +799,15 @@ static int i2c_dw_runtime_resume(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
 
+	dev_info(device, "runtime resume start\n");
+
 	if (!dev->shared_with_punit)
 		i2c_dw_prepare_clk(dev, true);
 
 	dev->init(dev);
 
+	dev_info(device, "runtime resume finished\n");
+
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 45bfca05bb30..7461254ec863 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -10,6 +10,7 @@
  */
 
 #define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW"
+#define DEBUG
 
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -756,6 +757,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 	regmap_read(dev->map, DW_IC_ENABLE, &enabled);
 	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
+	dev_dbg_ratelimited(dev->dev, "enabled=%#x stat=%#x\n", enabled, stat);
 	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
 		return IRQ_NONE;
 	if (pm_runtime_suspended(dev->dev) || stat == GENMASK(31, 0))
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 63d6694f7145..b82a22e5977f 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -501,6 +501,8 @@ static int intel_lpss_suspend(struct device *dev)
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
 
+	dev_info(dev, "supend started\n");
+
 	/* Save device context */
 	for (i = 0; i < LPSS_PRIV_REG_COUNT; i++)
 		lpss->priv_ctx[i] = readl(lpss->priv + i * 4);
@@ -513,6 +515,8 @@ static int intel_lpss_suspend(struct device *dev)
 	if (lpss->type != LPSS_DEV_UART)
 		writel(0, lpss->priv + LPSS_PRIV_RESETS);
 
+	dev_info(dev, "supend finished\n");
+
 	return 0;
 }
 
@@ -521,12 +525,16 @@ static int intel_lpss_resume(struct device *dev)
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
 
+	dev_info(dev, "resume started\n");
+
 	intel_lpss_deassert_reset(lpss);
 
 	/* Restore device context */
 	for (i = 0; i < LPSS_PRIV_REG_COUNT; i++)
 		writel(lpss->priv_ctx[i], lpss->priv + i * 4);
 
+	dev_info(dev, "resume finished\n");
+
 	return 0;
 }
 

