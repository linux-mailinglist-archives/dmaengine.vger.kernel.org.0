Return-Path: <dmaengine+bounces-9009-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Df2KVSRnGnRJQQAu9opvQ
	(envelope-from <dmaengine+bounces-9009-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 18:41:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C317AF4F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB93E30C1915
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB4333436;
	Mon, 23 Feb 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvMPcrsr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4553328ED;
	Mon, 23 Feb 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868336; cv=none; b=S0TDDsvzZx6kNRvbVQgbRkKM8whhRbD1pOF1b8Qh5ncKju18ZJ1Hbz9RP1NOs8xq/4FSDTMxBza9tuPy2PsrFsjUP0OGDCBVC8QmRHJamUDbiq4ImrTmyQTQgGChdBN6PvUreolfdM3m83/vBxR7LVSjmBMoheYxCv95brtT2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868336; c=relaxed/simple;
	bh=OFs+F2i4fpeRmsTH7tUJ5hO0npgCDxBo25FPhTX/hFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE0pNcsIdieHenKdz4s0nolqaxsrB3RIVp71Iabx+AgxS75Z5+p/sIj9saDfKA97vI9w7LRFRfYShrGoDlpMBS2btFk5miAzjNNuM0oxvFeZjOXtPCxARM2sACeTlCqWH0jJIlKbNeP5II3760TLhyAk6qLk8VEY7qaBCBoSV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvMPcrsr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771868335; x=1803404335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OFs+F2i4fpeRmsTH7tUJ5hO0npgCDxBo25FPhTX/hFs=;
  b=NvMPcrsrscxq4yCJYNHBwma5dXpYiaLlpl5YaiHU4AbKmW1dss4zVpgH
   eKc6wHV4HSpKqyOZ8UlLVlghXkur2gCHm4j/0tVPiKMiMs8WIyTYBU/2a
   6yowW4cOU55qzj4P1UFjG06x85lKFyOgcBuajicG0+hQ7xUZWW5IVie0T
   CzejcQppfEPzmSpHn0vPl0BWBUbMvv0s0ke5e+Qjssqu807Hmk7eyaE7j
   rAcT4p6XKH7FNn0xujYAvGZ00DAcOtrZCn+DLE46UjHdqz7MQNGpBv4ef
   eZ4zNkJ8cO1QoE+PCo+ORxkR4NcdogZJ2/EBVMiLNS/FtyyTrgvpBtjZv
   g==;
X-CSE-ConnectionGUID: jsfaBeNbRdOcjkAScBt/AA==
X-CSE-MsgGUID: qC3ahawxSriUb3w5OK63yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73050398"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="73050398"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:38:54 -0800
X-CSE-ConnectionGUID: i7eZdD4uRr+gNr/ct2htpA==
X-CSE-MsgGUID: B0cv0ytAS2ClRPRHaDlf4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214708424"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:38:36 -0800
Date: Mon, 23 Feb 2026 19:38:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Raag Jadav <raag.jadav@intel.com>, Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Robert Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-i3c@lists.infradead.org,
	dmaengine@vger.kernel.org, Philipp Stanner <phasta@kernel.org>,
	netdev@vger.kernel.org, nic_swsd@realtek.com,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, linux-cxl@vger.kernel.org,
	linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org, mhi@lists.linux.dev,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-spi@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
Message-ID: <aZyQmc7nOt87jitX@smile.fi.intel.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
 <cb878741-7b61-b72c-5a72-6ed6d5091b1f@rock-chips.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb878741-7b61-b72c-5a72-6ed6d5091b1f@rock-chips.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-9009-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[87];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid,rock-chips.com:email]
X-Rspamd-Queue-Id: 122C317AF4F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:09:37AM +0800, Shawn Lin wrote:
> 在 2026/02/23 星期一 23:50, Andy Shevchenko 写道:
> > On Mon, Feb 23, 2026 at 5:32 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > > 
> > > This patch series addresses a long-standing design issue in the PCI/MSI
> > > subsystem where the implicit, automatic management of IRQ vectors by
> > > the devres framework conflicts with explicit driver cleanup, creating
> > > ambiguity and potential resource management bugs.
> > > 
> > > ==== The Problem: Implicit vs. Explicit Management ====
> > > Historically, `pcim_enable_device()` not only manages standard PCI resources
> > > (BARs) via devres but also implicitly triggers automatic IRQ vector management
> > > by setting a flag that registers `pcim_msi_release()` as a cleanup action.
> > > 
> > > This creates an ambiguous ownership model. Many drivers follow a pattern of:
> > > 1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
> > > 2. Also calling `pci_free_irq_vectors()` in their error paths or remove routines.
> > > 
> > > When such a driver also uses `pcim_enable_device()`, the devres framework may
> > > attempt to free the IRQ vectors a second time upon device release, leading to
> > > a double-free. Analysis of the tree shows this hazardous pattern exists widely,
> > > while 35 other drivers correctly rely solely on the implicit cleanup.
> > 
> > Is this confirmed? What I read from the cover letter, this series was
> > only compile-tested, so how can you prove the problem exists in the
> > first place?
> 
> Yes, it's confirmed. My debug of a double free issue of a out-of-tree
> PCIe wifi driver which uses
> pcim_enable_device + pci_alloc_irq_vectors + pci_free_irq_vectors expose
> it. And we did have a TODO to cleanup this hybrid usage, targeted in
> this cycle[1] suggested by Philipp:

Okay, fair enough. I think this bit was missing in the cover letter.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=msi

> > > ==== The Solution: Making Management Explicit ====
> > > This series enforces a clear, predictable model:
> > > 1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
> > >      pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed IRQ
> > >      vectors should use these functions, which set the is_msi_managed flag and
> > >      ensure automatic cleanup.
> > > 2.  Patches 2 through 36 convert each driver that uses pcim_enable_device() alongside
> > >      pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup to instead
> > >      make an explicit call to pcim_alloc_irq_vectors().
> > > 3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim_setup_msi_release()
> > >      to check only the is_msi_managed flag. This decouples automatic IRQ cleanup from
> > >      pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors*()
> > >      are now solely the driver's responsibility to free with pci_free_irq_vectors().
> > > 
> > > With these changes, we clear ownership model: Explicit resource management eliminates
> > > ambiguity and follows the "principle of least surprise." New drivers choose one model and
> > > be consistent.
> > > - Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit control.
> > > - Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.
> > 
> > Have you checked previous attempts? Why is your series better than those?
> 
> There seems not previous attempts.

Maybe we are looking to the different projects...

https://lore.kernel.org/all/?q=pcim_alloc_irq_vectors

> > > ==== Testing And Review ====
> > > 1. This series is only compiled test with allmodconfig.
> > > 2. Given the substantial size of this patch series, I have structured the mailing
> > >     to facilitate efficient review. The cover letter, the first patch and the last one will be sent
> > >     to all relevant mailing lists and key maintainers to ensure broad visibility and
> > >     initial feedback on the overall approach. The remaining subsystem-specific patches
> > >     will be sent only to the respective subsystem maintainers and their associated
> > >     mailing lists, reducing noise.

-- 
With Best Regards,
Andy Shevchenko



