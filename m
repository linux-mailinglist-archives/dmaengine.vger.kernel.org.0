Return-Path: <dmaengine+bounces-8509-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMApBLVyd2n7ggEAu9opvQ
	(envelope-from <dmaengine+bounces-8509-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 14:57:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99689304
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEBAE301DD8B
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7933ADAD;
	Mon, 26 Jan 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9zPEz78"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D233A9C1;
	Mon, 26 Jan 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435637; cv=none; b=DyoNGIVb2tXAVwul3R81OpaWc2JHGOnBOkr0brKshIttNMPFJPvgEeyOPt/y4yJKau0+fnBn1SwsHivRSf72PszlWKXznFxkRGDcZmM3KFYjSVZLKxKePAQVhmyqeLuiMnjiEnzrvmbEeBed7bkCRcOEMC/qmKUePljZmT78WIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435637; c=relaxed/simple;
	bh=9icDPg6ZkVm6GU7we/zP1+CTW2MSDGgmmBuETqa+oJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHJjW+9yYMyDZ7D15RP/tbOmi82/kylbgi0vvSBwBBQfAmiS+wcpOn2bI1j9cQTXhrJvE5vUnOS0DeDPmdIBDcQuP9BdL4FSE6cWDkpOJXIMmjoueQiTUWcQfIoExiI3AiIgHrBt2s854f9rdqxkBtXai8TzPEu1iKM8H+Ehnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9zPEz78; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769435636; x=1800971636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9icDPg6ZkVm6GU7we/zP1+CTW2MSDGgmmBuETqa+oJU=;
  b=R9zPEz78XXqH/uW1OW5FljohC2kNp8hczTBriZZRpRGVl1S8okZ1WwwJ
   SlY30eLhPCpnCMlE7yGmKHxxthQ3E94gdJeL4dzNJHz8tBrjbz6kJP53Q
   Fr+9SVHEgZePS9bPygCfXQe3EbvyoVj+w5JdJBD4aCdQVITdk/C5M5DyJ
   NyJ3tX9KJPJgwOPlaJ4cy5IJo4uo8v1BSdWXMKU0LyUaoIJfxHRbE7Ywi
   +v5T8WKlx4Mh5AswBneuONTur9GRmsOC1QQpAqciVoLcb69sMk1GE81yC
   RBkUfgqg21NiAEmrKyAU2fDJ/hcF8fQhp5MIAeyTTGuiHxFMaRqYVIvW3
   Q==;
X-CSE-ConnectionGUID: xM1wGhvCT7a4Z27ZmmCkWw==
X-CSE-MsgGUID: 5Hz0Qdx+Rmmr5bsQ8C6Y9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="88024051"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="88024051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:53:56 -0800
X-CSE-ConnectionGUID: rfXz4owASQq6Na4vpyGh8A==
X-CSE-MsgGUID: oHsN1RWcR0mRUT+g0ZpOmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="206805556"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 26 Jan 2026 05:53:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0D8F895; Mon, 26 Jan 2026 14:53:53 +0100 (CET)
Date: Mon, 26 Jan 2026 14:53:53 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260126135353.GT2275908@black.igk.intel.com>
References: <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
 <20260122110021.GO2275908@black.igk.intel.com>
 <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
 <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8509-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F99689304
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:38:14PM -0500, correctmost wrote:
> I am seeing mixed results with those i2c config changes, depending on which modules are included in the initramfs image.
> 
> Build info for both tests:
> - Commit c072629f05d7
> - CONFIG_I2C_DESIGNWARE_CORE=m
> - CONFIG_I2C_DESIGNWARE_PLATFORM=m
> 
> --> Test 1 - Various i2c modules absent from initramfs
> 
> Modules:
> - drivers/dma/idma64.ko.zst present in initramfs
> - drivers/hid/i2c-hid/{i2c-hid-acpi.ko.zst,i2c-hid.ko.zst} absent from initramfs
> - drivers/i2c/busses/{i2c-designware-core.ko.zst,i2c-designware-platform.ko.zst,i2c-i801.ko.zst} absent from initramfs
> - drivers/i2c/{i2c-mux.ko.zst,i2c-smbus.ko.zst} absent from initramfs
> 
> Result: The touchpad works, but there are still IRQ #27 messages:

And the touchpad is working fine after boot too?

Can you share full dmesg of this boot and let's add "i2c-hid.dyndbg=+p" in
the kernel command line so we can see what it is doing as well.

