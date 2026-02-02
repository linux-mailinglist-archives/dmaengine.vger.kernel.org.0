Return-Path: <dmaengine+bounces-8661-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6PIu9ZgGns6wIAu9opvQ
	(envelope-from <dmaengine+bounces-8661-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:01:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA7C9722
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226CC301A724
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563322BEC20;
	Mon,  2 Feb 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bey8T7+O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4822BDC16;
	Mon,  2 Feb 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018683; cv=none; b=CZuCdkMczsmwV0P2Xn/t8Idc+xi+2dQV0j79BokZki1M40QRC5NFCX9xsTFnNh6ost0v20V0p9kObsm3STPG/KCRGUPdge9+/V9Qpe1+l2v5Rjo+Y5fcODmDoIEtuD67EyXs/lqL/VQCegZSfjJvhzLpLxJ3Njvx3Z6bkF3m2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018683; c=relaxed/simple;
	bh=cE1vERJlb9tOat0t1vGBuv/pgNjdAg98DSSNpmxp6c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaZS3JOWlFXshCpcPIHcGhmfXQpdZJECSjajPcaU5pCG692q7KEKCzQBLHeKb+1TLrqJ0+M4C9HXa1FLomY7rklrMlTKRVUgmruh7ikG6EJNtwvmOl9ZSU3ESxqMoZRE6NIpnMqclo3FehiLQhW1eKSCZJiEugnN+5BYDkHu23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bey8T7+O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770018682; x=1801554682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cE1vERJlb9tOat0t1vGBuv/pgNjdAg98DSSNpmxp6c8=;
  b=bey8T7+OM4qtrjsY1ScXawPPF9cEyQzxq+udml8jkz8/hPj7osVxX7pn
   GFy1iHsZqtlLNxjcAcG0YpFZM8qvJh40zBFoSvbQ/kb4dbEMvOv4MU9Lk
   Sxu2ySkWGtHJgl8qNxVsj+uRQoIlCEuyuem2Ieorx9yyeeUrm8IVO3fS5
   Yq06TiUYm5l3Czj9ldJYXpvl3C7FTuMSKyPiQuOhafvudYf4zZ7dfCOpM
   59bDiP7SRKVhmD7ViuuC6u8i91/ayNuxRBa36nFyY16qA5+D2MjNovCCn
   sGd9WysuuU/ka1Xfrmdx9sVyCw23ZFnjCsnsegqNPizEaX6dsw2u298yP
   Q==;
X-CSE-ConnectionGUID: 65VeYfGcRXKqkD8wlelg0Q==
X-CSE-MsgGUID: JY7ToGbFSi2C5onykebpEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82598542"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="82598542"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 23:51:22 -0800
X-CSE-ConnectionGUID: hl/iWMbCRx6JPDrEph5Wxg==
X-CSE-MsgGUID: hbW1C4V2QB2c3RTLAC23/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="232386427"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 01 Feb 2026 23:51:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B208D95; Mon, 02 Feb 2026 08:51:18 +0100 (CET)
Date: Mon, 2 Feb 2026 08:51:18 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260202075118.GY2275908@black.igk.intel.com>
References: <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
 <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
 <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
 <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
 <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-8661-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93CA7C9722
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 03:18:05AM -0500, correctmost wrote:
> > Lets try this: block LPSS runtime PM. I know you did it in the past but
> > this one does it slightly differently (you commented out the ops, this one
> > prevents the LPSS from runtime suspending). Can you replace previous hack
> > patch with the below?
> 
> After applying that patch, I still see the IRQ message and the touchpad
> doesn't work (full log attached).
> 
> I'm not sure if this is helpful, but it seems like a similar IRQ issue was discussed in the past:
> - https://lore.kernel.org/all/20251102190921.30068-1-hansg@kernel.org/
> - https://github.com/alexpevzner/hotfix-kvadra-touchpad
> - https://bbs.archlinux.org/viewtopic.php?id=302348

Yeah, I think Andy has been part of many of those discussions.

I went through again the logs that you have sent and tried to figure if
there is something we are missing. I noticed couple of things actually.
First of all it seems that even if we get the interrupt storm the I2C works
fine until the touchpad has been reset. Second is that the Linux interrupt
number is different when it "works". This itself does not say much because
it is just a number (not HW number) but since they are allocated sequently
maybe something messes up with that.

The working case:

i2c_hid_acpi i2c-ELAN06FA:00: HID Descriptor: 1e 00 00 01 a3 02 02 00 03 00 1f 00 04 00 00 00 05 00 06 00 f3 04 7e 32 04 00 00 00 00 00
i2c_hid_acpi i2c-ELAN06FA:00: Requesting IRQ: 156
i2c_hid_acpi i2c-ELAN06FA:00: entering i2c_hid_parse
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_start_hwreset
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_set_power
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 08
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 01
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: waiting...
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: finished.
i2c_hid_acpi i2c-ELAN06FA:00: asking HID report descriptor
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=02 00
i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5

the non-working case:

i2c_hid_acpi i2c-ELAN06FA:00: HID Descriptor: 1e 00 00 01 a3 02 02 00 03 00 1f 00 04 00 00 00 05 00 06 00 f3 04 7e 32 04 00 00 00 00 00
i2c_hid_acpi i2c-ELAN06FA:00: Requesting IRQ: 155
i2c_hid_acpi i2c-ELAN06FA:00: entering i2c_hid_parse
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_start_hwreset
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_set_power
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 08
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 01
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: waiting...
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: finished.
i2c_hid_acpi i2c-ELAN06FA:00: asking HID report descriptor
i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=02 00
i2c_designware i2c_designware.0: i2c_dw_xfer: msgs: 2
i2c_designware i2c_designware.0: enabled=0x1 stat=0x10
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
i2c_designware i2c_designware.0: controller timed out
hid (null): reading report descriptor failed
i2c_hid_acpi i2c-ELAN06FA:00: can't add hid device: -110
i2c_hid_acpi i2c-ELAN06FA:00: probe with driver i2c_hid_acpi failed with error -110

Both cases the HID descriptor read over I2C works fine. It's just after the
reset when reading the HID report descriptor things stall. I left the debug
there above it shows for I2C that MASTER_ON_HOLD is set which means the TX
fifo is empty and the controller is holding the bus which, I think should
not happen.

Notice also IRQ 155 vs 156.

Can you run one more test so that you have the latest debug patch but
comment out in the idma64.c this part:

static irqreturn_t idma64_irq(int irq, void *dev)
{
	struct idma64 *idma64 = dev;
	u32 status = dma_readl(idma64, STATUS_INT);
	u32 status_xfer;
	u32 status_err;
	unsigned short i;

#if 0
	/* Since IRQ may be shared, check if DMA controller is powered on */
	if (status == GENMASK(31, 0))
		return IRQ_NONE;
#endif

	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);


I would like to see what's the difference in "working" wrt. I2C-HD messages
above. If you can provide full dmesg again? Thanks!

