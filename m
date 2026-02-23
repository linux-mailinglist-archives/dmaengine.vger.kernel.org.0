Return-Path: <dmaengine+bounces-9007-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK4fFtx8nGm6IQQAu9opvQ
	(envelope-from <dmaengine+bounces-9007-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:14:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B76841797EE
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B733106C66
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C530AABE;
	Mon, 23 Feb 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QIa8w6+m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044C3090C1;
	Mon, 23 Feb 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862993; cv=none; b=NZWiBPIlGdmnFAg3C+bwqlesBjeaxNCoVhpHyuSf2OVtmR+7ETv2ehkBtOlM8nm9C/Y0z/FIqBhUNWU03Ftq+uIpEXP9vlMzI4Yxp/TBXr2H5/pFrUN0p7ijiRuQEM/RE4i+RGp0g22jfwirHwZn+Yht4hon1Pm+npx1SmvTnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862993; c=relaxed/simple;
	bh=AHx0h1hO5knesFXxZVApDK1swS5oE7zMU5mMkaIob88=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gZPtP7sBDWcXNLShBalb+Y2iEoEZxwfbJ8Bi48jQEm+hWXxoddw8cWJT49xKfIkcajFyx/rzcHN/UE6ytJau09R6W7AqO9sb80tUHdNfe/a63OdFKgXbYdgPlGGd0dReAEhrN+ZZI6Lo3e3PyFRdJsUmd0dL00girDGCcY3r/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QIa8w6+m; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b44f421;
	Tue, 24 Feb 2026 00:09:40 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>,
 Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>,
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>,
 Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Tomasz Jeznach
 <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Srujana Challa <schalla@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>,
 Mark Brown <broonie@kernel.org>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-i3c@lists.infradead.org,
 dmaengine@vger.kernel.org, Philipp Stanner <phasta@kernel.org>,
 netdev@vger.kernel.org, nic_swsd@realtek.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
 mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <cb878741-7b61-b72c-5a72-6ed6d5091b1f@rock-chips.com>
Date: Tue, 24 Feb 2026 00:09:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c8b4376c609cckunm3fddd3f4988fc3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9CQlYeGUkeS01CTB5IS0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=QIa8w6+mvkPs5yiMg8fVRt+gi3F6m/qkhqhjD+6XgiSvEJjtpIRJHvdkclp/pXy7G5fSEbf/NetLr/rXCYIFm/CQEBB6zjl+aiz8R4JS9N+fvFShWzFTgOlhNPDfffXHGWPxdi8/iAaZQWZ16BNVBWgFXcFRVBUKCW34Wu0UCFI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=scr8hCA+aPfGKwMjupeE8viSs7WuDndPG1pZF3mByMQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9007-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[rock-chips.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[88];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B76841797EE
X-Rspamd-Action: no action

Hi Andy

在 2026/02/23 星期一 23:50, Andy Shevchenko 写道:
> On Mon, Feb 23, 2026 at 5:32 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> This patch series addresses a long-standing design issue in the PCI/MSI
>> subsystem where the implicit, automatic management of IRQ vectors by
>> the devres framework conflicts with explicit driver cleanup, creating
>> ambiguity and potential resource management bugs.
>>
>> ==== The Problem: Implicit vs. Explicit Management ====
>> Historically, `pcim_enable_device()` not only manages standard PCI resources
>> (BARs) via devres but also implicitly triggers automatic IRQ vector management
>> by setting a flag that registers `pcim_msi_release()` as a cleanup action.
>>
>> This creates an ambiguous ownership model. Many drivers follow a pattern of:
>> 1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
>> 2. Also calling `pci_free_irq_vectors()` in their error paths or remove routines.
>>
>> When such a driver also uses `pcim_enable_device()`, the devres framework may
>> attempt to free the IRQ vectors a second time upon device release, leading to
>> a double-free. Analysis of the tree shows this hazardous pattern exists widely,
>> while 35 other drivers correctly rely solely on the implicit cleanup.
> 
> Is this confirmed? What I read from the cover letter, this series was
> only compile-tested, so how can you prove the problem exists in the
> first place?

Yes, it's confirmed. My debug of a double free issue of a out-of-tree
PCIe wifi driver which uses
pcim_enable_device + pci_alloc_irq_vectors + pci_free_irq_vectors expose
it. And we did have a TODO to cleanup this hybrid usage, targeted in
this cycle[1] suggested by Philipp:

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=msi

> 
>> ==== The Solution: Making Management Explicit ====
>> This series enforces a clear, predictable model:
>> 1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
>>      pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed IRQ
>>      vectors should use these functions, which set the is_msi_managed flag and
>>      ensure automatic cleanup.
>> 2.  Patches 2 through 36 convert each driver that uses pcim_enable_device() alongside
>>      pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup to instead
>>      make an explicit call to pcim_alloc_irq_vectors().
>> 3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim_setup_msi_release()
>>      to check only the is_msi_managed flag. This decouples automatic IRQ cleanup from
>>      pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors*()
>>      are now solely the driver's responsibility to free with pci_free_irq_vectors().
>>
>> With these changes, we clear ownership model: Explicit resource management eliminates
>> ambiguity and follows the "principle of least surprise." New drivers choose one model and
>> be consistent.
>> - Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit control.
>> - Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.
> 
> Have you checked previous attempts? Why is your series better than those?

There seems not previous attempts.

> 
>> ==== Testing And Review ====
>> 1. This series is only compiled test with allmodconfig.
>> 2. Given the substantial size of this patch series, I have structured the mailing
>>     to facilitate efficient review. The cover letter, the first patch and the last one will be sent
>>     to all relevant mailing lists and key maintainers to ensure broad visibility and
>>     initial feedback on the overall approach. The remaining subsystem-specific patches
>>     will be sent only to the respective subsystem maintainers and their associated
>>     mailing lists, reducing noise.
> 

