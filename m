Return-Path: <dmaengine+bounces-9031-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M7MwB8trnWkkQAQAu9opvQ
	(envelope-from <dmaengine+bounces-9031-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:13:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A018459F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24D34301701C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825DA3644C3;
	Tue, 24 Feb 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbGlTJ0Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062852BD58A;
	Tue, 24 Feb 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924358; cv=none; b=Da1BbYqToPVGJ6oYRmQU3VJeycTgPPT9MrRU9Hn/m0Sk2kkzFhrK4uvKYr6Q+UsEMjvVHuYvK+KGgxSWqGgBA653iOFBF/uLy4X8XNbGlKL2Wv1Q35jHi//DVENfQiwAduYeFjA2kq1PhJral3Bh/b2ouDfRqnI21aqjYHlvY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924358; c=relaxed/simple;
	bh=sllJU41EvNnfq6cfH0Cm3WpH9/CrTwdLF2yCyQc6C20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/gAMpgHSZ1SRP7q4jSbxH6lKlJB0RkbVOgj2Ou31ACwVTXselEnNkatNS1c7f0mLJigu1lzQrCqdYVii9Ul292BC+YJHzV1Oj1PyQBwaa3v/0QKk9qQDF9FNohkXy3pDeIhilETSKGPTrbqLFXvohvzHrDQDQabwYX7h+iyuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbGlTJ0Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771924357; x=1803460357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sllJU41EvNnfq6cfH0Cm3WpH9/CrTwdLF2yCyQc6C20=;
  b=AbGlTJ0YkokTsxQHaqiXwXrINmz91wb1ZioaSAF+CsR+O56xETJkqY5S
   8RdcSWqpL/MIaJAwKcVfwiX6frQgP6fjGdYpiL3PSETbSWDksFYjApTdQ
   IuaSY1vp1e2RlL10rItHevyWNK7rf8mNnjALd+jy211Jc9xdEreTZ32yv
   FBijpVAAGR3yg5b+TV7b7gPC7qUjtwVehNpqTc58PQPMfj5gqhXtEg+xK
   gZoH6SwtfJeO86zDyORjTJxLMsaeBBs40t/GNKo6JHFyTpuZPbpbrYpnc
   Bl9a+Ogeax8CUXgHTMri8ECjaQ3Nc7KDR/Il3Fju0vuAsXM14vxaySz47
   A==;
X-CSE-ConnectionGUID: 1nHSjMqyQwuBAY0+m+QfCQ==
X-CSE-MsgGUID: sq0LcavZRq+p34ZMSVo+Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73039913"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73039913"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:12:35 -0800
X-CSE-ConnectionGUID: v4GiDQV6T1ycBQRHOBv6QA==
X-CSE-MsgGUID: yR3Uba70Qr6uzGgc8QUkgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="219937945"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:12:17 -0800
Date: Tue, 24 Feb 2026 11:12:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: phasta@kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
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
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	mhi@lists.linux.dev, Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-spi@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
Message-ID: <aZ1rb8zoqmQmakDP@smile.fi.intel.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <6223f3cb-693f-42e7-9147-30f659f08563@hogyros.de>
 <7ca512d133f7a3bcfe00e9b0b2af5fe5f147ad77.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca512d133f7a3bcfe00e9b0b2af5fe5f147ad77.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[hogyros.de,rock-chips.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-9031-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 676A018459F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:39:43AM +0100, Philipp Stanner wrote:
> On Tue, 2026-02-24 at 13:14 +0900, Simon Richter wrote:
> > On 2/24/26 12:29 AM, Shawn Lin wrote:

> > > When such a driver also uses `pcim_enable_device()`, the devres framework may
> > > attempt to free the IRQ vectors a second time upon device release, leading to
> > > a double-free. Analysis of the tree shows this hazardous pattern exists widely,
> > > while 35 other drivers correctly rely solely on the implicit cleanup.
> > 
> > Would it make sense to have a function pcim_free_irq_vectors(), to allow 
> > explicit freeing even if the device is otherwise managed, analogous to 
> > pcim_iounmap()?
> 
> We used to add those. In part because it is easier to port old users.
> 
> Nowadays I tend to think that those APIs were more on the too-complex
> than too-simple side for a long time. As an expert or as the API
> designer you wouldn't expect it, but there are actually far too many
> users who came to believe they always have to use pcim_iounmap() and
> counter parts.
> 
> If I could design it from scratch I would probably try to tell users to
> use the unmanaged versions instead of revoking the devres consequence.

+many.

> Devres is actually about your consequence always happening whenever the
> driver unloads, for whatever reason.

I believe you meant "unbinds". The device<-->driver link can be broken
without unloading the driver.

-- 
With Best Regards,
Andy Shevchenko



