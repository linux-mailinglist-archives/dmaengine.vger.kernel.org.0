Return-Path: <dmaengine+bounces-8592-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFypKS1dfGkYMAIAu9opvQ
	(envelope-from <dmaengine+bounces-8592-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 08:26:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB4B7E76
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 08:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 913073004DC3
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B030C34E;
	Fri, 30 Jan 2026 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP9HBAU/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CB3081BD;
	Fri, 30 Jan 2026 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757993; cv=none; b=UdYZKI+n7b2E62sgOZhk1yjYdi4Tye6Td9nVazg46dpjTkk/mBytpDHGMtSRS9CbHV3b8Vcq8tjf2QFMwxUfrsh7uDWbQ5KsxRwxPhjoiLec8BkuoT0Tyai2ozs3PuMAHOWtc94MLtmt6YuMt7LNl4Q8kwMQGoHpOBo37Zl/AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757993; c=relaxed/simple;
	bh=Lb6IQKDZ1FpcpnxnPG/csOeSSZKW4yVl6L5kiRVWdUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txs12e01YuDLl2QIo07DRHa4F38+U5wI3hE8z4qHNB+ptNcZEwQRzugK2Cl1OXLY5sKYl82fSn8Nlu0pj7AxFHXfDD6ikmk6jci5WaN9bqJxdnY2BA1T9CZem6GonS8YXYjARGto5nrTODTAk4Ldzdsoe594q9n2FYFN62Y12uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP9HBAU/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769757991; x=1801293991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lb6IQKDZ1FpcpnxnPG/csOeSSZKW4yVl6L5kiRVWdUQ=;
  b=gP9HBAU/sOSQYKx/asu4XSkjxODjcWSklacGl9fy03TBBTYree5FffhZ
   0U2xTpSMwxLY+cCaGtRxKiOaikYEsClAYyIdK76qubX61wIWMK8ThAdll
   vfsVdPNOnluzmqlnVpghOXZ0r+N9EBU+ntje95vsUZ9sQToLS8z/2vX+3
   j/n8+R3i8dQoEsHzbZy2z6EAnlfGqZa50sEnmqrMUQJTin+klVH52vAeV
   E477lQ8OvorlCH+4l0fOlz90atLv4ji32pLipFNZhFSAhiDR0jWih3E8i
   CtxrKvo7ne1u9lXkDa9YGiMJnXFya2hUOdNZs0+RCUv3WpcvwS00KQYa0
   A==;
X-CSE-ConnectionGUID: yi/I4Zd2SoSKXYUlkjUljA==
X-CSE-MsgGUID: 7hMLr+WYTomIL9UGJkGzLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70912402"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70912402"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:26:31 -0800
X-CSE-ConnectionGUID: P8a5reU+SLe8t2+GKf86RA==
X-CSE-MsgGUID: qthRW0+QRJiQYqwWrYWmTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208034489"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 29 Jan 2026 23:26:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DBD8495; Fri, 30 Jan 2026 08:26:20 +0100 (CET)
Date: Fri, 30 Jan 2026 08:26:20 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260130072620.GW2275908@black.igk.intel.com>
References: <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
 <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
 <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
 <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8592-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 4BFB4B7E76
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:06:29AM -0500, correctmost wrote:
> On Thu, Jan 29, 2026, at 6:56 AM, Mika Westerberg wrote:
> > On Thu, Jan 29, 2026 at 02:20:22AM -0500, correctmost wrote:
> >> >> > Can you next apply the below patch (only that one) and try? Any test case
> >> >> > where it reproduces is good. The provide again full dmesg. While at it can
> >> >> > you enable CONFIG_PRINTK_TIME=y so we can also get timestamps to the dmesg.
> >> >> 
> >> >> Full log attached with the added debug prints and timestamps
> >> >
> >> > Thanks! Okay so the interrupt is active immediately when the LPSS probes.
> >> > One thing that could explain this is that the IO-APIC is misconfigured to
> >> > have the polarity reversed. Can you boot with "apic=debug" in the kernel
> >> > command line so that it dumps the entries and provide again full dmesg?
> >> 
> >> Sure, full log attached
> >
> > Thanks! The IO-APIC configuration seems fine too. I also compared with my
> > MTLP based reference system and it shows the same (but my system does not
> > have this issue).
> >
> > Let's add even more debug. Can you replace the previous hack patch with the
> > below.
> >
> > You can drop the "apic=debug" from the command line but can you add
> > acpi.dyndbg=+p" instead.
> >
> > Then also enable CONFIG_PCI_DEBUG=y.
> 
> Full log attached.  (I also set CONFIG_LOG_BUF_SHIFT=24 to handle the extra dmesg output.) 

Thanks! Unfortunaly I can't still spot anything that could cause this
behaviour :-/

Lets try this: block LPSS runtime PM. I know you did it in the past but
this one does it slightly differently (you commented out the ops, this one
prevents the LPSS from runtime suspending). Can you replace previous hack
patch with the below?

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
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8d92c895d3ae..b2d387080619 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -81,14 +81,14 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	pm_runtime_put(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
+//	pm_runtime_allow(&pdev->dev);
 
 	return 0;
 }
 
 static void intel_lpss_pci_remove(struct pci_dev *pdev)
 {
-	pm_runtime_forbid(&pdev->dev);
+//	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
 	intel_lpss_remove(&pdev->dev);
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
 

