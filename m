Return-Path: <dmaengine+bounces-9033-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PT6FFF+nWk/QQQAu9opvQ
	(envelope-from <dmaengine+bounces-9033-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 11:32:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC31856A8
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 155EB30F9C5A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562C3783C7;
	Tue, 24 Feb 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oKvIyHka"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DA36B05A;
	Tue, 24 Feb 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929071; cv=none; b=OLVTFFyl4+E4Zghd82ow6BUOfe/43qb7kD/4VL3IJPFOzHSL+uO6lFIqZAe69O8iqHUAmde/lUJEd4zPw7A4C1y6KVeWZ7gy9FWseXn0Vxs4uNR9jlt/6PKfrs20szbR63E7PyRP1Yx0dmeMFeLelc0yITK16vHObzjDE/s49Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929071; c=relaxed/simple;
	bh=Xkb2MDt6xGYtR4mFfmU26Ues6I+i7U04Zx4BHV01rL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOPDpzWBI3TmKfZezm9PgCfYHi1te630UCuf0zPBXdsuWLYGQqcPLKbFAs1ZWjj9MvtrUZJhTgcOebVX8DDCsL2lQw6Kd/6YVwGf4v7eLob9HRkXrJPpRMxQg2Mb3PxIR8tzuJ3DXPRBDTB2Qe9z+CS5l9oJjsw5N3+p3gNZJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oKvIyHka; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fKvBw4sPGz9vVL;
	Tue, 24 Feb 2026 11:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771929064; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xkb2MDt6xGYtR4mFfmU26Ues6I+i7U04Zx4BHV01rL4=;
	b=oKvIyHkagUt14YjcbYzCVNDJBTWvjXhzWlALbZZ6Lw0fPfmU2t4YpBcyc2Qdi+4KzuI8TV
	PjvG94lhGB3d4tDbhN17up+D5FZdjhr7Eh1RuLqgokQP0yhg0vn3xjpuF4oElqvj77ZKNu
	uegXUTacyzp1TOx6rlp6O2U8X1QWdS9tD4xfi3YzpmsWUuiAO19VrBdX1JYDjqskBsAe26
	7ZrmtEb59iLMfke4uJ9HpLJf18h82NcDhAuMAtTl7ubBJmU3SnbXScrAQtdjXn85JSKagc
	9zeQm+tEOXbVSneuae/jh1kiLSnfiulfgc1bIwLohIi+JMrl0dUDX04SszIMag==
Message-ID: <48297cc524736e7452def05448ece84260a4fd83.camel@mailbox.org>
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, phasta@kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>, Shawn Lin
 <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>, "Vaibhaav
 Ram T . L" <vaibhaavram.tl@microchip.com>, Kumaravel Thiagarajan
 <kumaravel.thiagarajan@microchip.com>,  Even Xu <even.xu@intel.com>,
 Xinpeng Sun <xinpeng.sun@intel.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Zhou Wang
 <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>, Vinod
 Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, Jijie Shao
 <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Sunil Goutham
 <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,  Karol Wachowski
 <karol.wachowski@linux.intel.com>, Min Ma <mamin506@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>,  Andreas Noever <andreas.noever@gmail.com>, Mika
 Westerberg <westeri@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Will Deacon <will@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>, Tian
 Tao <tiantao6@hisilicon.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Srujana Challa
 <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Antoine
 Tenart <atenart@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Raag
 Jadav <raag.jadav@intel.com>, Hans de Goede <hansg@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Robert Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>, Nirmal
 Patel <nirmal.patel@linux.intel.com>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao
 <bingbu.cao@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,  linux-i3c@lists.infradead.org,
 dmaengine@vger.kernel.org, netdev@vger.kernel.org,  nic_swsd@realtek.com,
 linux-arm-msm@vger.kernel.org,  dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org,  iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, linux-cxl@vger.kernel.org, 
 linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-serial@vger.kernel.org, mhi@lists.linux.dev, Jan Dabros
 <jsd@semihalf.com>,  linux-i2c@vger.kernel.org, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-pci@vger.kernel.org,  linux-gpio@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>,  linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org
Date: Tue, 24 Feb 2026 11:30:28 +0100
In-Reply-To: <aZ1rb8zoqmQmakDP@smile.fi.intel.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	 <6223f3cb-693f-42e7-9147-30f659f08563@hogyros.de>
	 <7ca512d133f7a3bcfe00e9b0b2af5fe5f147ad77.camel@mailbox.org>
	 <aZ1rb8zoqmQmakDP@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 60f04246675bc741d14
X-MBO-RS-META: yon5wtfjc3h8rjostgzzw3ydtwwsf3ne
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9033-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[hogyros.de,rock-chips.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[88];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@mailbox.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	HAS_REPLYTO(0.00)[phasta@kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 12BC31856A8
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 11:12 +0200, Andy Shevchenko wrote:
> On Tue, Feb 24, 2026 at 08:39:43AM +0100, Philipp Stanner wrote:
> > On Tue, 2026-02-24 at 13:14 +0900, Simon Richter wrote:
> > > On 2/24/26 12:29 AM, Shawn Lin wrote:
>=20
> > > > When such a driver also uses `pcim_enable_device()`, the devres fra=
mework may
> > > > attempt to free the IRQ vectors a second time upon device release, =
leading to
> > > > a double-free. Analysis of the tree shows this hazardous pattern ex=
ists widely,
> > > > while 35 other drivers correctly rely solely on the implicit cleanu=
p.
> > >=20
> > > Would it make sense to have a function pcim_free_irq_vectors(), to al=
low=20
> > > explicit freeing even if the device is otherwise managed, analogous t=
o=20
> > > pcim_iounmap()?
> >=20
> > We used to add those. In part because it is easier to port old users.
> >=20
> > Nowadays I tend to think that those APIs were more on the too-complex
> > than too-simple side for a long time. As an expert or as the API
> > designer you wouldn't expect it, but there are actually far too many
> > users who came to believe they always have to use pcim_iounmap() and
> > counter parts.
> >=20
> > If I could design it from scratch I would probably try to tell users to
> > use the unmanaged versions instead of revoking the devres consequence.
>=20
> +many.

hm?

>=20
> > Devres is actually about your consequence always happening whenever the
> > driver unloads, for whatever reason.
>=20
> I believe you meant "unbinds". The device<-->driver link can be broken
> without unloading the driver.

Yes, thx for pointing that out. Greg KH AFAIK always calls it "driver
detach".

P.

