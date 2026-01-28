Return-Path: <dmaengine+bounces-8551-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ+9EtYCemku1gEAu9opvQ
	(envelope-from <dmaengine+bounces-8551-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 13:36:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E53A1543
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2D630818B5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A834EF06;
	Wed, 28 Jan 2026 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCZuIhRo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D525485A;
	Wed, 28 Jan 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603501; cv=none; b=HnIOZ4EJwGrse7sE3oL1xTEp/yXajj1dEiANP319OYuAwO9WUVVp65fmhKB8fJkX9EE9woYuXFIpLEhyCoLnGliBJUIP/avz/Y0hDMguR+dd8qiuDcX3wcNPFja5V/6QRZygTP24XEGW8zmQzx63+IXeyYt8kGFIdgcWlqTEoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603501; c=relaxed/simple;
	bh=jhReHcVoLeAYfxmXSnz9SKAPwc/pTTpvp9BhBdYEkn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPmiFqPpdVQ+NDkxZkX1+pUFc6fwnHoXG2PIXWOQX4z/7ekG7wfodotcIGp1DKr8rXKZtC70AxM+B0aYX5ax2tVl848/pGnjGvjRHvF5QCFQ/N0aCYiOuB6m968H8qVNvARVHQNI1asrmJqr4Zad1/iWp9/h6XByOfMseavpzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCZuIhRo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769603499; x=1801139499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhReHcVoLeAYfxmXSnz9SKAPwc/pTTpvp9BhBdYEkn0=;
  b=XCZuIhRo6rfqip4Hf+CDM4JMyh+hPRYcpZloXKOym+2qpUTR3jfBlhtU
   ykvpSuP5E0rfbbqBdkCu9e6wM9TxFUA2rKla5nfQrDmi1TvEOACqN35R8
   MzDx4EeeXQCJr1PB6YMZP4FLxDUVJ4AJ8meOBPtgZQtvrar3lp5d5YtlZ
   k0DrjabBBjS26DzgO3EhLQV0yqhusXoKqtJU+jHLAcgKY+JOHEAemyRRQ
   Nol4vwlNbmY7fFYE/NG8kLu/AJFdAxn83eNn1ZeasuGIV55F/v10M2/gY
   P1+dG/gJ98kAIY/ZpW6V7BVEfVdJyE7d3fZInWqI8DvlfOw8sXLiQrcqt
   A==;
X-CSE-ConnectionGUID: jSbyUAvUTUOBsC1AMHmOGg==
X-CSE-MsgGUID: zlRrRJqsReW5gq0NnA650A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70713797"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70713797"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:31:39 -0800
X-CSE-ConnectionGUID: U7/xe9KjS8qNnnTkKxvSDw==
X-CSE-MsgGUID: W0GHs2ttRfuqYkLG1KcqLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213229400"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 28 Jan 2026 04:31:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F292998; Wed, 28 Jan 2026 13:31:35 +0100 (CET)
Date: Wed, 28 Jan 2026 13:31:35 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260128123135.GM2275908@black.igk.intel.com>
References: <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8551-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4E53A1543
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:21:20AM -0500, correctmost wrote:
> On Wed, Jan 28, 2026, at 4:34 AM, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 11:56:15PM -0500, correctmost wrote:
> >> On Tue, Jan 20, 2026, at 4:33 AM, Andy Shevchenko wrote:
> >> > On Mon, Jan 19, 2026 at 12:49:59PM +0200, Andy Shevchenko wrote:
> >> >> On Mon, Jan 19, 2026 at 12:39:41PM +0200, Andy Shevchenko wrote:
> >> >> > On Fri, Jan 16, 2026 at 07:25:54PM -0500, correctmost wrote:
> >
> > ...
> >
> >> >> > My understanding that the pin 3 on GPIO might be wrongly configured
> >> >> > by BIOS.  The difference with the original case is that your GPIO device
> >> >> > is locked against modifications and until you unlock it (usually
> >> >> > it's done in BIOS in some debug menu) it may not be fixable without OEM
> >> >> > fixing the issue themselves. In any case you can try the workaround
> >> >> > (see https://lore.kernel.org/all/ZftTcSA5dn13eAmr@smile.fi.intel.com/).
> >> >> > But I am skeptical about it.
> >> 
> >> I tested commit c03e9c42ae8 with the following patch and still saw the "probe
> >> with driver i2c_hid_acpi failed" error:
> >
> >> +	{
> >> +		void __iomem *padcfg0;
> >> +	        u32 value;
> >
> >> +		padcfg0 = intel_get_padcfg(pctrl, 3, PADCFG0);
> >
> > I'm sorry to get you back to this one, but can you replace 3 with 82 and try
> > again (keep the kernel command options with HID debug enabled, etc, but no
> > other patches applied).
> 
> I tested the pin 82 patch by itself (no other patches and no config changes).  I received the IRQ message and the touchpad didn't work (full log attached):

Okay let's add some debug to the drivers involved and try to figure out
what is happening.

Can you next apply the below patch (only that one) and try? Any test case
where it reproduces is good. The provide again full dmesg. While at it can
you enable CONFIG_PRINTK_TIME=y so we can also get timestamps to the dmesg.

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
 

