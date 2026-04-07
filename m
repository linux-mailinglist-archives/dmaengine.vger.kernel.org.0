Return-Path: <dmaengine+bounces-9926-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNaSMi+M1Wnr7QcAu9opvQ
	(envelope-from <dmaengine+bounces-9926-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 00:58:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EDC3B5608
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B1430115AB
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CB3890E1;
	Tue,  7 Apr 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxT4H0gM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5F37B02E;
	Tue,  7 Apr 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775602726; cv=none; b=e+sI2uhKu2i/P7Z5BZNR0yR/oeOxB+SX6vGPcCc2bzdHMwLrxYb134U5MV5ks5sSOKOnxNuBvjKM2PZXlj17Hrd9wr3LSg8/AOf/19w/vl48l5Sk+QGebZiNIB1qDbU5mJaAh8JJk1uX5Zrh5KRNP0dPUFZU+81PZ0vdA9pqsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775602726; c=relaxed/simple;
	bh=ZxMhQkn/NMJTsfUq+eNI5wRqTDBwCQBg1cjTyGaGSzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CAFvIFUcUCh0VIHYGjMrdQEU7mL056z+zfQGxWKN+y2EY4XuEQ+udsZzjBcgQZOMoNA+EQ4UDQruMAtfVoplvx+xf66OTsQffPw2Syll1ZFr/yBHxAY6sBNTcBP4WY2reidLOzXk6Re7rfFdF3Ro6CnEnIxr81bH/Ngj88si6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxT4H0gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C69C116C6;
	Tue,  7 Apr 2026 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775602726;
	bh=ZxMhQkn/NMJTsfUq+eNI5wRqTDBwCQBg1cjTyGaGSzA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YxT4H0gMU1uiOeHwbtOxxGkfFWJBaCzthqg03Sftf8l9d186Y09INkfJ8VCpcsjUT
	 Qfd/Qlw+XjxQGpsD/+wtJtFtyh3etr3/mtV9qhSmixByvSXfzBB7nBSEJNPsodmdHd
	 n6aWnXLqcu6DDQCkFID7N0ab2dedIpF0ftmNXCcvehsYTzafVVvpTSGtJI0Yt78qAh
	 7zcrBzbK4e2mGEgKbxfT4/RQOcj3aPhgKqv9IwN+ABisbMsvBq2hQAvVVGI9l26vIJ
	 NOji8KIk0pikMh4DCWmZrmRQsTJnp7fjTB24k9B9hx+3b4Laf7gnEUw1IEsuOG28xo
	 +wM+h43SmOleg==
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 00:58:28 +0200
Message-Id: <DHNAMNISZJ9O.3B58NWX64GBGE@kernel.org>
Subject: Re: [PATCH v5 0/9] driver core: Fix some race conditions
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Alexey
 Kardashevskiy" <aik@ozlabs.ru>, "Johan Hovold" <johan@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, <maz@kernel.org>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Saravana Kannan" <saravanak@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, <Frank.Li@kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <alex@ghiti.fr>,
 <alexander.stein@ew.tq-group.com>, <andre.przywara@arm.com>,
 <andrew@codeconstruct.com.au>, <andrew@lunn.ch>,
 <andriy.shevchenko@linux.intel.com>, <aou@eecs.berkeley.edu>,
 <ardb@kernel.org>, <astewart@tektelic.com>, <bhelgaas@google.com>,
 <brgl@kernel.org>, <broonie@kernel.org>, <catalin.marinas@arm.com>,
 <chleroy@kernel.org>, <davem@davemloft.net>, <david@kernel.org>,
 <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <gbatra@linux.ibm.com>,
 <gregory.clement@bootlin.com>, <hkallweit1@gmail.com>,
 <iommu@lists.linux.dev>, <jirislaby@kernel.org>, <joel@jms.id.au>,
 <joro@8bytes.org>, <kees@kernel.org>, <kevin.brodsky@arm.com>,
 <kuba@kernel.org>, <lenb@kernel.org>, <lgirdwood@gmail.com>,
 <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-snps-arc@lists.infradead.org>, <linux-usb@vger.kernel.org>,
 <linux@armlinux.org.uk>, <linuxppc-dev@lists.ozlabs.org>,
 <maddy@linux.ibm.com>, <mani@kernel.org>, <miko.lenczewski@arm.com>,
 <mpe@ellerman.id.au>, <netdev@vger.kernel.org>, <npiggin@gmail.com>,
 <osalvador@suse.de>, <oupton@kernel.org>, <pabeni@redhat.com>,
 <palmer@dabbelt.com>, <peter.ujfalusi@gmail.com>, <peterz@infradead.org>,
 <pjw@kernel.org>, <robh@kernel.org>, <sebastian.hesselbarth@gmail.com>,
 <tglx@kernel.org>, <tsbogend@alpha.franken.de>, <vgupta@kernel.org>,
 <vkoul@kernel.org>, <will@kernel.org>, <willy@infradead.org>,
 <yangyicong@hisilicon.com>, <yeoreum.yun@arm.com>
To: "Douglas Anderson" <dianders@chromium.org>, <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,rowland.harvard.edu,ozlabs.ru,google.com,lst.de,intel.com,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,arm.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.infradead.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	TAGGED_FROM(0.00)[bounces-9926-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30EDC3B5608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 7, 2026 at 1:22 AM CEST, Douglas Anderson wrote:

Applied to driver-core-testing, thanks!

> Douglas Anderson (9):
>   driver core: Don't let a device probe until it's ready
>   driver core: Replace dev->can_match with dev_can_match()
>   driver core: Replace dev->dma_iommu with dev_dma_iommu()
>   driver core: Replace dev->dma_skip_sync with dev_dma_skip_sync()
>   driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
>   driver core: Replace dev->state_synced with dev_state_synced()
>   driver core: Replace dev->dma_coherent with dev_dma_coherent()

    [ Since all DEV_FLAG_DMA_COHERENT accessors are exposed unconditionally=
,
      also drop the CONFIG guards around dev_assign_dma_coherent() in
      device_initialize() to ensure a correct default value. - Danilo ]

>   driver core: Replace dev->of_node_reused with dev_of_node_reused()
>   driver core: Replace dev->offline + ->offline_disabled with accessors

