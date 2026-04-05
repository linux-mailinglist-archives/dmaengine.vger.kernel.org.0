Return-Path: <dmaengine+bounces-9883-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMLAOfby0WlYRgcAu9opvQ
	(envelope-from <dmaengine+bounces-9883-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 05 Apr 2026 07:28:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF339D595
	for <lists+dmaengine@lfdr.de>; Sun, 05 Apr 2026 07:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84AC300B452
	for <lists+dmaengine@lfdr.de>; Sun,  5 Apr 2026 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE634B183;
	Sun,  5 Apr 2026 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bejAtE4V"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC526A08A;
	Sun,  5 Apr 2026 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366895; cv=none; b=egXLFmhE/8wWWu3+GNw2nE2BssqQ8owqs0vUJnWHvEUHSF9ZkL1ANZK0+M8Jn8DwEY+dw7pKPZ5iadCTtI5e0fY34UPC+e6Qvb0wiSrqaV073de9LqIvIJAw9bzBMvD5DsUn3b9f5dhvjgwu78cNMEYlpYwX4tys9dzTEO8mYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366895; c=relaxed/simple;
	bh=ophk+hp6kRAG0U/TAGAhUuOrKmitf0U0PYwWZuudius=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq0WEIfG+YhxDZ3UZx6CF9+CdwJWbvRtYXNxWWruHFMcBHMChd3/3wpYJeruXHbqFQmonNKy2qMgTLOlRsQ6cd5XhnegWBEUMaVoi59/Te8kW4BOyGyb0p/QG7a/QnpIOZUzcE8jDlkMzocdg0ApzlLmaJ0689G3dopB4re4PtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bejAtE4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B7DC116C6;
	Sun,  5 Apr 2026 05:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775366895;
	bh=ophk+hp6kRAG0U/TAGAhUuOrKmitf0U0PYwWZuudius=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bejAtE4V1Hz3lTSKLlyBcIyR+JNRKDGMc/G8Z0GN4ZPNsCF585rejSzukgcFioxub
	 QUbiyQrTx+RcM6s1+Zu0oaI1vfJoHXTXgrhOUb/YXCMVVE2KZgd+scb35TQsQF7wMb
	 a7Wf9qe7CdkvcplKMPdPqmr9WcFeVQib8uJGDZ1Y=
Date: Sun, 5 Apr 2026 07:27:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr,
	alexander.stein@ew.tq-group.com, andre.przywara@arm.com,
	andrew@codeconstruct.com.au, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu,
	ardb@kernel.org, bhelgaas@google.com, brgl@kernel.org,
	broonie@kernel.org, catalin.marinas@arm.com, chleroy@kernel.org,
	davem@davemloft.net, david@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, driver-core@lists.linux.dev,
	gbatra@linux.ibm.com, gregory.clement@bootlin.com,
	hkallweit1@gmail.com, iommu@lists.linux.dev, jirislaby@kernel.org,
	joel@jms.id.au, joro@8bytes.org, kees@kernel.org,
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org,
	lgirdwood@gmail.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-usb@vger.kernel.org, linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com,
	maddy@linux.ibm.com, mani@kernel.org, maz@kernel.org,
	miko.lenczewski@arm.com, mpe@ellerman.id.au, netdev@vger.kernel.org,
	npiggin@gmail.com, osalvador@suse.de, oupton@kernel.org,
	pabeni@redhat.com, palmer@dabbelt.com, peter.ujfalusi@gmail.com,
	peterz@infradead.org, pjw@kernel.org, robh@kernel.org,
	sebastian.hesselbarth@gmail.com, tglx@kernel.org,
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org,
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
Message-ID: <2026040539-sponge-publisher-2b42@gregkh>
References: <20260404000644.522677-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9883-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,rowland.harvard.edu,lst.de,google.com,intel.com,ozlabs.ru,arm.com,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.infradead.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,samsung.com,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[84];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47FF339D595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> NOTE: one potentially "controversial" choice I made in some patches
> was to always reserve a flag ID even if a flag is only used under
> certain CONFIG_ settings. This is a change from how things were
> before. Keeping the numbering consistent and allowing easy
> compile-testing of both CONFIG settings seemed worth it, especially
> since it won't take up any extra space until we've added a lot more
> flags.

Nah, this is fine, I don't see any problems with this as the original
code kind of was doing the same thing with the "hole" in the structure
if those options were not enabled.

> I only marked the first patch as a "Fix" since it is the only one
> fixing observed problems. Other patches could be considered fixes too
> if folks want.
> 
> I tested the first patch in the series backported to kernel 6.6 on the
> Pixel phone that was experiencing the race. I added extra printouts to
> make sure that the problem was hitting / addressed. The rest of the
> patches are tested with allmodconfig with arm32, arm64, ppc, and
> x86. I boot tested on an arm64 Chromebook running mainline.

I'm guessing your tests passed?  :)

Anyway, this looks great, unless there are any objections, other than
the "needs to be undefined", which a follow-on patch can handle, I'll
queue them up next week for 7.1-rc1.

thanks,

greg k-h

