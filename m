Return-Path: <dmaengine+bounces-8424-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN2oK8OacGlyYgAAu9opvQ
	(envelope-from <dmaengine+bounces-8424-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 10:22:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20F54489
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D77824AAF
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF98B1367;
	Wed, 21 Jan 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YE1p8ltA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FE346FBC;
	Wed, 21 Jan 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986822; cv=none; b=G2Vp8htidO2JTjHQ4IWDBRSYHIm8d3WmfN1meLOzPAnJa6CErlxnvZHOFqjj60+67DoKY1VVlKpUBcHNI9S+K90++GGYtBKcEdLGC0iLzXcJxRUm4wIWFrsDXfGCdNerP/4AvWspZNWjvN5b5MNNDf0+C+slMlfW8wVafEFunSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986822; c=relaxed/simple;
	bh=fzd4LZJfsbgavj/li4H7ZY/5uafPy9wpMW2RXV7mj/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPD+oc3UOBJKmQCwcg8oX3wOaKHG+JQ8myl2X0hp1JQwQhQtS8Aqkc5PjWxzkoQw5Z8dfX1QjARnWwT5mm1lA5wlicaogcGHLWe+iNMrDtKqDCaBseKKr/Og7wiJphc/2s5G24aHUIZlpd3KXBX5fcGxI321Y7H2HbOkQUznk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YE1p8ltA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768986820; x=1800522820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fzd4LZJfsbgavj/li4H7ZY/5uafPy9wpMW2RXV7mj/4=;
  b=YE1p8ltAx7PUdrbxfU0kMUaxO/VDZKYhsWJhFiYrFp6uUICD9BPxQtCU
   cLxCfoYPMn/dbk9h29RvlMjedstVvXWCDJtJ84CLKXNemcKSn6Bn5Hnqf
   SnfYhakeoUbH5eFr5GLRv0p7VK2/lCSi7te8QRGNlKd6XyRrjKuQegjPi
   29uugqcEjWq2StFWRAk5OZUOdwHTuJnkTKXeIds9THyJTr7F+vTsWM70C
   2dk6RjofedwRst7GYUzdPs1dK6r/OqBREnXYkJmR3ATAbrEhxAi9xx39Q
   zjP1uRrW+gM98GGPM1bVMCUq4tCTRb3A8nV5J3E/n2hjfrCN19NJ7Q8pK
   g==;
X-CSE-ConnectionGUID: qgZwWo+ST3+WIIKFtrwgmA==
X-CSE-MsgGUID: sRl7IZ7AQASXSn7xRRsmlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="95682402"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="95682402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:13:40 -0800
X-CSE-ConnectionGUID: M3Q3oyIRQwaruqbQ7Goc+Q==
X-CSE-MsgGUID: L4KcMM3qTm2qj+IeG2Q5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210848204"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:13:38 -0800
Date: Wed, 21 Jan 2026 11:13:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
References: <51388859-bf5f-484c-9937-8f6883393b4d@app.fastmail.com>
 <aWUGmfcjWpFJs3-X@smile.fi.intel.com>
 <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8424-lists,dmaengine=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim,dreamwidth.org:url,altlinux.org:url]
X-Rspamd-Queue-Id: 2C20F54489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:56:15PM -0500, correctmost wrote:
> On Tue, Jan 20, 2026, at 4:33 AM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 12:49:59PM +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 19, 2026 at 12:39:41PM +0200, Andy Shevchenko wrote:
> >> > On Fri, Jan 16, 2026 at 07:25:54PM -0500, correctmost wrote:
> >> > > On Fri, Jan 16, 2026, at 5:35 AM, Andy Shevchenko wrote:
> >> > > > On Fri, Jan 16, 2026 at 12:03:12PM +0200, Andy Shevchenko wrote:
> >> > > >> On Thu, Jan 15, 2026 at 05:50:36PM -0500, correctmost wrote:
> >> > > >> > On Mon, Jan 12, 2026, at 9:35 AM, Andy Shevchenko wrote:
> >> > > >> > > On Tue, Dec 16, 2025 at 12:57:10PM -0500, correctmost wrote:

...

> >> > > >> > >> The following commit
> >> > > >> > >
> >> > > >> > > No, it's false positive. The reality is that something else is going on
> >> > > >> > > there on this and other similar laptops.
> >> > > >> > >
> >> > > >> > >> causes my Lenovo IdeaPad touchpad not to work when
> >> > > >> > >> kernel/drivers/dma/idma64.ko.zst is present in the initramfs image:
> >> > > >> > >> 
> >> > > >> > >> #regzbot introduced: 9140ce47872bfd89fca888c2f992faa51d20c2bc
> >> > > >> > >> 
> >> > > >> > >> "idma64: Don't try to serve interrupts when device is powered off"
> >> > > >> > >
> >> > > >> > > So, the touchpad is an I²C device, which is connected to an Intel SoC.
> >> > > >> > > The I²C host controller is Synopsys DesignWare. On Intel SoCs the above
> >> > > >> > > mentioned IP is generated with private DMA engine, that's called Intel
> >> > > >> > > iDMA 64-bit. Basically it's two devices under a single PCI hood.
> >> > > >> > > The problem here is that when PCI device is in D3, both devices are
> >> > > >> > > powered off, but something sends an interrupt and it's not recognized
> >> > > >> > > being the one, send by a device (touchpad).
> >> > > >> > >
> >> > > >> > > There is one of the following potential issues (or their combinations):
> >> > > >> > >
> >> > > >> > > - the I²C host controller hardware got off too early
> >> > > >> > > - the line is shared with something else that generates interrupt storm
> >> > > >> > > - the BIOS does weird (wrong) things at a boot time, like not properly
> >> > > >> > >   shutting down and disabling interrupt sources; also may have wrong
> >> > > >> > >   pin control settings
> >> > > >> > > - the touchpad is operating on higher frequency like 400kHz (because
> >> > > >> > >   BIOS told to use that one instead of 100kHz) than the HW is designed
> >> > > >> > >   for and hence unreliable with all possible side effects
> >> > > >> > > - the touchpad firmware behaves wrongly on some sequences (see also
> >> > > >> > >   note about the bus speed above), try to upgrade touchpad FW
> >> > > >> > >
> >> > > >> > > With my experience with the case of the above mentioned commit that it
> >> > > >> > > may be BIOS thingy. Also consider the bus speed, there are quirks in
> >> > > >> > > the kernel for that.
> >> > > >> > 
> >> > > >> > Thank you for the detailed notes.  I will see if I can update my BIOS and
> >> > > >> > experiment with different quirks values, though I won't be able to do that
> >> > > >> > until late next week.
> >> > > >> 
> >> > > >> You're welcome!
> >> > > >> 
> >> > > >> > >> Here are the related logs:
> >> > > >> > >> 
> >> > > >> > >> ---
> >> > > >> > >> 
> >> > > >> > >> irq 27: nobody cared (try booting with the "irqpoll" option)
> >> > > >> > >
> >> > > >> > > Almost all below is not so interesting.
> >> > > >> > >
> >> > > >> > > ...
> >> > > >> > >
> >> > > >> > >> handlers:
> >> > > >> > >> [<00000000104a7621>] idma64_irq [idma64]
> >> > > >> > >> [<00000000bd8d08e9>] i2c_dw_isr
> >> > > >> > >> Disabling IRQ #27
> >> > > >> > >
> >> > > >> > > Yes, this line at least shared between those two and might be more.
> >> > > >> > >
> >> > > >> > > ...
> >> > > >> > >
> >> > > >> > >> i2c_designware i2c_designware.0: controller timed out
> >> > > >> > >> hid (null): reading report descriptor failed
> >> > > >> > >> i2c_hid_acpi i2c-ELAN06FA:00: can't add hid device: -110
> >> > > >> > >> i2c_hid_acpi i2c-ELAN06FA:00: probe with driver i2c_hid_acpi failed with error -110
> >> > > >> > >
> >> > > >> > > Yes, sounds familiar with the speed settings. Try to down it to 100kHz in case
> >> > > >> > > it's confirmed to be 400kHz.
> >> > > >> > >
> >> > > >> > >> ---
> >> > > >> > >
> >> > > >> > > Any pointers to that thread, please?
> >> > > >> > 
> >> > > >> > The following threads have users who were able to restore touchpad
> >> > > >> > functionality by undoing the idma64 change in initramfs:
> >> > > >> 
> >> > > >> Yes, = "they have hidden the existing problem". No value in that, sorry.
> >> > > >> What is the exact link that refer to the thread you previously mentioned?
> >> > > >> 
> >> > > >> ...
> >> > > >> 
> >> > > >> > Lastly, I saw another bug report that mentions the "probe with driver
> >> > > >> > i2c_hid_acpi failed with error -110" error.  It seems to state that the error
> >> > > >> > only occurs when a power cable is connected during boot:
> >> > > >> > 
> >> > > >> > - https://bugzilla.altlinux.org/57094
> >> > > >> >   - Huawei Matebook D15 BOD-WXX9-PCB-B4
> >> > > >> >   - i2c-GXTP7863:00
> >> > > >> > 
> >> > > >> > >> so I don't think this is a hardware issue with my individual laptop.
> >> > > >> > >
> >> > > >> > > I don't know how this conclusion is came here. You mean HW as laptop model?
> >> > > >> > > But are the involved components the same (I²C host controller + touchpad)?
> >> > > >> > 
> >> > > >> > Sorry for the confusion.  I meant the individual machine in my possession and
> >> > > >> > not the laptop model as a whole.
> >> > > >> 
> >> > > >> Yeah, something here is common and I can't say for sure this all about Synaptic
> >> > > >> touchpads...
> >> > > >
> >> > > > So, what I think I need to understand this more is the following
> >> > > > (all information should be gathered under root user) for working
> >> > > > and non-working cases:
> >> > > >
> >> > > > - `cat /proc/interrupts`
> >> > > > - `dmesg`
> >> > > >    # with `initcall_debug ignore_loglevel` added to the kernel command line
> >> > > > - `cat /sys/kernel/debug/pinctrl/.../pins`
> >> > > >    # ... should be something like INTC1234:00
> >> > > >
> >> > > > And just once these:
> >> > > > - `acpidump -o tables.dat` # the tables.dat file
> >> > > > - `grep -H 15 /sys/bus/acpi/devices/*/status`
> >> > > > - `lspci -nk -vv`
> >> > > 
> >> > > The tables.dat file and the dmesg logs seemed too big to post inline, so I
> >> > > ended up zipping all of the files (attached).
> >> > 
> >> > Thanks for the files. The same suspicion as in the original report
> >> > https://lore.kernel.org/all/e3f2debf-c762-48d9-876e-bcb60841f909@gmail.com/
> >> > 
> >> > Have you read it in full?
> >> > 
> >> > My understanding that the pin 3 on GPIO might be wrongly configured
> >> > by BIOS.  The difference with the original case is that your GPIO device
> >> > is locked against modifications and until you unlock it (usually
> >> > it's done in BIOS in some debug menu) it may not be fixable without OEM
> >> > fixing the issue themselves. In any case you can try the workaround
> >> > (see https://lore.kernel.org/all/ZftTcSA5dn13eAmr@smile.fi.intel.com/).
> >> > But I am skeptical about it.
> 
> I tested commit c03e9c42ae8 with the following patch and still saw the "probe
> with driver i2c_hid_acpi failed" error:

Yeah, that was expected (see remarks in [] in the pins file, they are fully locked).

> >> Just in case, this https://hansdegoede.dreamwidth.org/25589.html might be
> >> also useful.
> 
> Thanks, I will try to find out if my laptop allows access to advanced BIOS options.
> 
> The Lenovo support site lists some BIOS updates for my laptop, though the
> release notes do not mention any touchpad fixes.  The updates are not
> available via fwupd, so I probably won't be able to update anytime soon.
> 
> > FWIW, seems familiar:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219799
> >
> > Have you tried similar steps described there? (Id est turning PM off and
> > see if it affects the case. In your case it might be needed to comment out
> > the dev_pm_ops assignment in the LPSS driver drivers/mfd/intel-lpss*.c and
> > recompile the kernel / modules).
> 
> I tested commit c03e9c42ae8 with the following changes and still saw the
> "probe with driver i2c_hid_acpi failed" error:

Yeah, also was kinda expected...

> I also tried booting Arch's 6.18.5 kernel with the power cord unplugged to
> see if that helped, but I still saw the "i2c_hid_acpi failed" error.

Yes, this just confirms a long standing issue most likely related to how HW
behaves (and we kinda know this already).

> It seems like the next step is to try to enable GPIO unlocking in the BIOS.

Yes, and communicate to vendor of the BIOS / laptop to ask them for the pin
configurations. If you have time and skills you can try to analyse what windows
driver does. The main question if the interrupt in question is also storming
there (they might have simply disable it at boot time or somehow, I know 0
about windows guts).

Mika, do you have any other insights, suggestions, comments?

-- 
With Best Regards,
Andy Shevchenko



