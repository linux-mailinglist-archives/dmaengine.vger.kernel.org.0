Return-Path: <dmaengine+bounces-9029-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAtMMFhinWksPQQAu9opvQ
	(envelope-from <dmaengine+bounces-9029-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:33:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6B183BD7
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5D2C3028531
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56160366827;
	Tue, 24 Feb 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ed6RPlZl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504021DFDB8;
	Tue, 24 Feb 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922004; cv=none; b=nbQ2/uCUgp9QZBVSrJptxHleqA8dFTbM7/FYKEvb6PPxZUnN0D1BhwRzOY2U4ZFuQH9T3i0sDDDWPEjXT+IqGBuEeCZ8xrATCcmSLBM79mLOoJ//pyfI8vdfDJr6U0g3XjJSj5sXeOoYyc6oYTA1Qas0nlgz40bj7DfP2pVfdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922004; c=relaxed/simple;
	bh=jbJfsDf/AFVBkWOy7rSA4AaZdHLzv8lJvtIZjuKCFtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVf9aGxuXIcgilZMvncrDKL8sy8rQMUpPk83/EANmYRE+zOBqUqjNk38gUY1tx6dnuiF5c0LRCjZprClLlgD9Wl36Tnhy+ZBQagmEtPjrrYfC2NjaivYsrUhc9FT61FJ1OpQ6eD2Ezl4gWHK3InAKL9ZbHKFdyRfTiYE0KlqhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ed6RPlZl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fKrZw3WpFz9vHN;
	Tue, 24 Feb 2026 09:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771921992; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYg4q6UpxC9QuXXiNNDVGkJ25zHrTtqhRQuiGoCwbvc=;
	b=ed6RPlZlOUibWHwOocSfYTbtNmFVbXwAr31lgxNkh51bR+5xZFRh30ChM/VGa7gukLud7Z
	gjTbJ0LWe52KAN52GeHh8bJ/s/WoNKVXWlvSRa1yRizbR3EpzoiYW3Wbfme/2w9YFsXFEw
	1Sfja1+XOBY3ofP3UjIRgt036+qwuwuFFrM+HEUlokbyx8ydCENU7J4uyTEkj1BUrJue4J
	99L7hKKIyf8MBC9C72PvXh5nuwMG3ygnRsPehMi1rXkCt72nSQ/Sw/iY4BR8htDmahaWW7
	ev+dgehPQrgSupmjoTGs4VKws0G0Lm/uzKdxtzYsBciIbPjnvhapWs+EIlsL6g==
Message-ID: <3014988f8a26dbac18a32ec22e0da3f5a383fd97.camel@mailbox.org>
Subject: Re: [PATCH 01/37] PCI/MSI: Add Devres managed IRQ vectors allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, phasta@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Vaibhaav Ram T . L"
 <vaibhaavram.tl@microchip.com>, Kumaravel Thiagarajan
 <kumaravel.thiagarajan@microchip.com>, Even Xu <even.xu@intel.com>, Xinpeng
 Sun <xinpeng.sun@intel.com>, Srinivas Pandruvada
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
 linux-serial@vger.kernel.org, mhi@lists.linux.dev, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
 linux-i2c@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Date: Tue, 24 Feb 2026 09:32:39 +0100
In-Reply-To: <d601ec05-ef38-5e8e-c643-c05010717ebe@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	 <1771860581-82092-2-git-send-email-shawn.lin@rock-chips.com>
	 <20260223160402.3ad8f079@kernel.org>
	 <ec226aa1-5cc8-855f-8f90-1d7f89efe766@rock-chips.com>
	 <07fc896007d86b731cbfb3cf6bbdf4e5315d7a77.camel@mailbox.org>
	 <d601ec05-ef38-5e8e-c643-c05010717ebe@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 9xmyhhcgdmozckmn6yfrqrcxte8ryx4p
X-MBO-RS-ID: 6c93f1b6d9c4844e3a5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9029-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[88];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@mailbox.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	HAS_REPLYTO(0.00)[phasta@kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 69D6B183BD7
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 16:21 +0800, Shawn Lin wrote:
> =E5=9C=A8 2026/02/24 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:47, Philipp Stanner =
=E5=86=99=E9=81=93:
> > On Tue, 2026-02-24 at 10:08 +0800, Shawn Lin wrote:
> > > =E5=9C=A8 2026/02/24 =E6=98=9F=E6=9C=9F=E4=BA=8C 8:04, Jakub Kicinski=
 =E5=86=99=E9=81=93:
> > > > On Mon, 23 Feb 2026 23:29:40 +0800 Shawn Lin wrote:
> > > > > pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() ar=
e created for
> > > > > pci device drivers which rely on the devres machinery to help cle=
anup the IRQ
> > > > > vectors.
> > > >=20
> > > > If you can please add this API with just a few users, and then conv=
ert
> > > > remaining users via the subsystem trees in the next cycle.
> > > > There's no need to risk wasting maintainer time on conflicts with
> > > > conversions like this.
> > >=20
> > > Thanks for the suggestion, Jakub. I have little experience with
> > > cross-subsystem cleanups like this, so your suggestion is very helpfu=
l.
> >=20
> >=20
> > When I removed the hybrid nature of pci_request_region() et al., I
> > concluded that there were so few users that doing them all in one run
> > was sufficient.
> >=20
> > For larger reworks, like removing pcim_iomap_table(), a slower step-by-
> > step strategy is necessary for the reasons that Jakub details.
> >=20
> > It is then smart to omit an easy to port subsystem / driver for the
> > ultimate patch series where one then removes the hybrid behavior from
> > PCI itself, after porting the last driver.
> >=20
> > In general,=C2=A0 as Jakub details, those step-by-step cleanups are a b=
it
> > safer, since you can proof valid behavior early on and in case of an
> > explosion they are very easy to revert.
> >=20
>=20
> Thank you, Philipp. I wish I had attended your talk at FOSDEM 2025 on
> removing pcim_iomap_table earlier. This first version was perhaps a bit=
=20
> too aggressive.

No worries at all, it's very cool that you pick this work up!

>  For v2, I think the plan should start with addressing
> the switchtec and vmd drivers, since both of those, along with the new=
=20
> API additions, can be handled entirely within the PCI subsystem scope.

Sounds reasonable to me.

Regards
Philipp

