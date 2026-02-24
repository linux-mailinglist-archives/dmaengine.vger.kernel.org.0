Return-Path: <dmaengine+bounces-9034-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PpANVyAnWk/QQQAu9opvQ
	(envelope-from <dmaengine+bounces-9034-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 11:41:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611718587D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 11:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90017305C2CA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A50378D71;
	Tue, 24 Feb 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XopqSYRt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3C36B042;
	Tue, 24 Feb 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929602; cv=none; b=lCGV+B7GrV2vkwhIcFEa3djAP3J1KXbLTHGVF+vJ2DkbF3UKSh1oemtRWoVk2oKxtblnr7eTwBrzHV0R5Su4uYmF7z9iMw/dNO3sDybZVMLeYQtiubyYeexmbwUyNbpeq6kvXsBwev16sxbJURU2Br3aUqEKOelJ0bmzvCZBMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929602; c=relaxed/simple;
	bh=NKaZi+5e3r7u58UMALFBdqyb3F151mM8t+8ODkTnkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuVBIeOeUqGXMbbJHrkZcYWxFhvxHGZcPdxuev153x914ZOjrvDielbNx8FBfnZ8RLzQtl6ieF8M7xLFPUbe2cMXUmarizYJ4EtyXQaWNOZR+O0HF/WK21g9jeZ4wxiJKXRghRNZhGPlE2MbMcuQggl2avj4uvy4dHy2IUbXVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XopqSYRt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771929602; x=1803465602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKaZi+5e3r7u58UMALFBdqyb3F151mM8t+8ODkTnkmk=;
  b=XopqSYRtkRY1kCpFjPfo9JlkKyvfOTeNjUvTQzcCvZ0Wco/duPPH9yTs
   2BYYe1ehVILAzceGH3kR9Ibdhf9OdaX0nn1X+vLN3lM1WFq9/902MOfSq
   KT0akGC9Z4l09cVdSTLbXXcMpaWiKqBLrrciFeZCshMMukhcqiV22WdDG
   /b5p/RX0xr+bMaYohToKBvv7n25aF+7rfchza6LMWuxfkVjUPNhRyRaZg
   6+zN1SqET5WB4RSFWsS4RccWLmqdGwrGo3zuyT4VJ9ien/7/RJBTVlnn9
   zk21cIhc+ThlCIJv5ipNdkJCwoh73AczH8JmwDZjLoXyC+iRkkxjPc7ot
   A==;
X-CSE-ConnectionGUID: 8SFCJy6SQ3uU5+xUyiH0AA==
X-CSE-MsgGUID: Aog20IZDRxCZFn5F5ixt8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95556109"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="95556109"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:40:01 -0800
X-CSE-ConnectionGUID: 2vh5u/4QSUOjYuKUxqshOA==
X-CSE-MsgGUID: IM2dRI81S8i45s0yX8WRUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214955497"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:39:43 -0800
Date: Tue, 24 Feb 2026 12:39:40 +0200
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
Message-ID: <aZ1_7IwDYfiLbfQE@smile.fi.intel.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <6223f3cb-693f-42e7-9147-30f659f08563@hogyros.de>
 <7ca512d133f7a3bcfe00e9b0b2af5fe5f147ad77.camel@mailbox.org>
 <aZ1rb8zoqmQmakDP@smile.fi.intel.com>
 <48297cc524736e7452def05448ece84260a4fd83.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48297cc524736e7452def05448ece84260a4fd83.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[hogyros.de,rock-chips.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-9034-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1611718587D
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:30:28AM +0100, Philipp Stanner wrote:
> On Tue, 2026-02-24 at 11:12 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 24, 2026 at 08:39:43AM +0100, Philipp Stanner wrote:
> > > On Tue, 2026-02-24 at 13:14 +0900, Simon Richter wrote:

...

> > > If I could design it from scratch I would probably try to tell users to
> > > use the unmanaged versions instead of revoking the devres consequence.
> > 
> > +many.

> hm?

I'm supporting you with many hands up (more than I possess)!

> > > Devres is actually about your consequence always happening whenever the
> > > driver unloads, for whatever reason.
> > 
> > I believe you meant "unbinds". The device<-->driver link can be broken
> > without unloading the driver.
> 
> Yes, thx for pointing that out. Greg KH AFAIK always calls it "driver
> detach".

-- 
With Best Regards,
Andy Shevchenko



