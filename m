Return-Path: <dmaengine+bounces-9026-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BysJ2lWnWk2OgQAu9opvQ
	(envelope-from <dmaengine+bounces-9026-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 08:42:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF71832BB
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 08:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38F5230847E8
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A6364E8E;
	Tue, 24 Feb 2026 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FKEAxwg8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7526ADC;
	Tue, 24 Feb 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918830; cv=none; b=ZAf6DoS0p87tadAqumqKwQy8C9lHnlXjTgfcbuICRsOIXOZaoWtCfjMhtlKmoQ5ENGdWs+QAFbTzIJqvEzSGvPiXcVUaUzGY3XKHk2MKK59l0SN5PrWMgZrSn2gYiybcjg80Kon1jdStZAdRvX2AmvCG6b1+9J104oHodYF0C4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918830; c=relaxed/simple;
	bh=nO29udC/TvyKqbOOxAxOz7i5aFfdank76tWIHV3k8yo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Id41uLY/PCsfYRV6s33Rs/wEFPM0sOR34I08YnMJrihV6b/vgcBB5JwXgZwlgEshsOJ+uRRk52SuAIP8Be98J3N8UI6NbrCQqywnanM4FjNOUuNWAKHJ3Kvazf7voGf8vSdIU/XcuVKuHay+JMfB55hxfjdrHqJ4EHcLXd1Jayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FKEAxwg8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fKqQ11RwVz9v7N;
	Tue, 24 Feb 2026 08:40:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771918825; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nO29udC/TvyKqbOOxAxOz7i5aFfdank76tWIHV3k8yo=;
	b=FKEAxwg8/2TVXMyYr/OiVCz5K1q4W+C/xn+JVXi//EMazudZywyjLwZrwzHNLYzROrIGjJ
	WiOn32rHS7oEwHLLm6QL2yCRYinpfVLqqwTh7sT6RAQNG0u4EURZ5HxR4OK58Z3/n7gZZV
	8caQG4lw5WqV9qVnTFk84Cn+SoVQbSZKgx07St5+8pxpkc99ybs0qQSpkSnjhqX/fK2fVh
	R1e9tX2O0SBa7kFE1+a+xKqHOjB9jmAde03Ko6m7uo3zhkzAiDlzUONdZOidXL54Qs7PfF
	bCIWc/77Lvrh1BnmhbO6+/6V4uapf65BSL0fwPQx8DWsFH0Szy8rGeRiOsWY+A==
Message-ID: <7ca512d133f7a3bcfe00e9b0b2af5fe5f147ad77.camel@mailbox.org>
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Simon Richter <Simon.Richter@hogyros.de>, Shawn Lin
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
 <bingbu.cao@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-i3c@lists.infradead.org, 
 dmaengine@vger.kernel.org, Philipp Stanner <phasta@kernel.org>, 
 netdev@vger.kernel.org, nic_swsd@realtek.com,
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
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Date: Tue, 24 Feb 2026 08:39:43 +0100
In-Reply-To: <6223f3cb-693f-42e7-9147-30f659f08563@hogyros.de>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	 <6223f3cb-693f-42e7-9147-30f659f08563@hogyros.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: nd43b1cq9px89dfwjyyj71p3i7rr7fs9
X-MBO-RS-ID: 9e24931f76f65785344
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9026-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hogyros.de,rock-chips.com,google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,gmail.com,ffwll.ch,linux.intel.com,semihalf.com,zonque.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[phasta@kernel.org];
	RCPT_COUNT_GT_50(0.00)[88];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@mailbox.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18AF71832BB
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 13:14 +0900, Simon Richter wrote:
> Hi,
>=20
> On 2/24/26 12:29 AM, Shawn Lin wrote:
>=20
> > When such a driver also uses `pcim_enable_device()`, the devres framewo=
rk may
> > attempt to free the IRQ vectors a second time upon device release, lead=
ing to
> > a double-free. Analysis of the tree shows this hazardous pattern exists=
 widely,
> > while 35 other drivers correctly rely solely on the implicit cleanup.
>=20
> Would it make sense to have a function pcim_free_irq_vectors(), to allow=
=20
> explicit freeing even if the device is otherwise managed, analogous to=
=20
> pcim_iounmap()?

We used to add those. In part because it is easier to port old users.

Nowadays I tend to think that those APIs were more on the too-complex
than too-simple side for a long time. As an expert or as the API
designer you wouldn't expect it, but there are actually far too many
users who came to believe they always have to use pcim_iounmap() and
counter parts.

If I could design it from scratch I would probably try to tell users to
use the unmanaged versions instead of revoking the devres consequence.

Devres is actually about your consequence always happening whenever the
driver unloads, for whatever reason.


P.

