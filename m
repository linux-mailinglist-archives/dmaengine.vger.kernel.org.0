Return-Path: <dmaengine+bounces-8665-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ARAAmJ8gGnE8wIAu9opvQ
	(envelope-from <dmaengine+bounces-8665-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 11:28:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD8CAED3
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 873EB301BCC9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B09F3587A6;
	Mon,  2 Feb 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+OU2PAO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC7357738;
	Mon,  2 Feb 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027749; cv=none; b=Rj+TzGb56LuTrZ9Zy9KMEOktLdfsmhQMm8dDSNa0CQnUsmIXBfWnJjXlzrMLIJvlbCGWXxta8N++yeHeQ0sd/98Lj5XPYr62P3Cj9ICaZKlqTCAWPmX1t+Yc54vRf+q515s+6+yJxkIjZBLnC6na/1hub9+EoR8HdPPKWoqQeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027749; c=relaxed/simple;
	bh=epr231sJVwHfFe18+CImf/yIbQQMtbyXiJ9hAO60XhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMuFhH9m1cuA9Tt3msCitopEilVOnd3mWuExdubjGCwxtdTwORyS51Yjq2freF9AvfDrOIYJtaXcuBqAUI72+6BY89t9ToT+A8qKSfXrxgw3Zl+AoFLZhc8YQOGB1ou7twKzxecrhK/ua5N4Bo67F6We7j8q6oKoNfD9CT7DkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+OU2PAO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770027748; x=1801563748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=epr231sJVwHfFe18+CImf/yIbQQMtbyXiJ9hAO60XhA=;
  b=V+OU2PAOmBwOLLs0LJJgsgPEb6HD/kz5b9Yx+JkMf6U2mjJZCSdK0Iws
   +s6bxOB/Kj37gsRrLgnQgqz+ldFNlbMJZY/NGIs46nLt8kGINlClGhbL3
   X/lDJIbabwBqCrSc0JuVS92CDPF+VD/2b0Q/4rY/0u+VGM9hzqBubvlyS
   NebaEPQYhUMlQrT+gDHnWRqlWm2rtv1oH0/1KCYXAiW2UWJITRzjyC9x3
   Irab1NdNnGY0e9sxQALkYIf9R3CXSGnHdnOk0hXLLvPmOVqi5nRDKex41
   naXFYfCaHZw7/hnn2AJaRDjcMZj3lQStWv8AOtjJsWpUQRgmVPQwpMOnR
   Q==;
X-CSE-ConnectionGUID: 7pK6VRw1R1qAZ63r0c4oQg==
X-CSE-MsgGUID: bZMXCesPThyEOvbKG7yPZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71236988"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="71236988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 02:22:27 -0800
X-CSE-ConnectionGUID: jdrOrs63QbO6Ea4M4VGBVw==
X-CSE-MsgGUID: 9Un4wCC7TMev/wG1/dczkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="213951994"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 02 Feb 2026 02:22:26 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3E68B95; Mon, 02 Feb 2026 11:22:25 +0100 (CET)
Date: Mon, 2 Feb 2026 11:22:25 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260202102225.GB2275908@black.igk.intel.com>
References: <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
 <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
 <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
 <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
 <20260202075118.GY2275908@black.igk.intel.com>
 <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8665-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 32FD8CAED3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 03:38:21AM -0500, correctmost wrote:
> >
> > static irqreturn_t idma64_irq(int irq, void *dev)
> > {
> > 	struct idma64 *idma64 = dev;
> > 	u32 status = dma_readl(idma64, STATUS_INT);
> > 	u32 status_xfer;
> > 	u32 status_err;
> > 	unsigned short i;
> >
> > #if 0
> > 	/* Since IRQ may be shared, check if DMA controller is powered on */
> > 	if (status == GENMASK(31, 0))
> > 		return IRQ_NONE;
> > #endif
> >
> > 	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
> >
> >
> > I would like to see what's the difference in "working" wrt. I2C-HD messages
> > above. If you can provide full dmesg again? Thanks!
> 
> In the previous test, I had commented out pm_runtime_* calls in intel-lpss-pci.c.  I restored those lines and then applied the if 0 patch above (full log attached).

Thanks!

The I2C DW behaviour differs between the cases. When it fails it holds the
SCL line but then the timeout triggers.

Could you drop the above hack again so that it should "fail". Then build
the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
this is just lucky timing? Please try a couple of boots and make sure the
results are the same each time.

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 45bfca05bb30..1e2150390809 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -1053,6 +1053,7 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 		scnprintf(adap->name, sizeof(adap->name),
 			  "Synopsys DesignWare I2C adapter");
 	adap->retries = 3;
+	adap->timeout = msecs_to_jiffies(5000);
 	adap->algo = &i2c_dw_algo;
 	adap->quirks = &i2c_dw_quirks;
 	adap->dev.parent = dev->dev;

