Return-Path: <dmaengine+bounces-9948-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEbIN2PS12mrTAgAu9opvQ
	(envelope-from <dmaengine+bounces-9948-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 18:22:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 691293CD9C3
	for <lists+dmaengine@lfdr.de>; Thu, 09 Apr 2026 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A201F303DD34
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2026 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC73DD52D;
	Thu,  9 Apr 2026 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lzseZNXA"
X-Original-To: dmaengine@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3B30DD0A;
	Thu,  9 Apr 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751430; cv=none; b=DRW9vWne1/EudsOSaHA7AgOhHyQs6kqB6IAJQH4lINzspKtwZ16lKC6CNEqdHS8xfiTzcWIR3BvR8L85LLgRy2R5LuU98/wzsthleUtt6fEVYDCH0RledWGKDHUh0lWWiSNtrbY4VkPtph0kwjMpgpB7psedGqjM56OjPTS+dAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751430; c=relaxed/simple;
	bh=Xy3uObCZ3K3Ccz73l5AsCbY040gCK80nzaz1QNDHoe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqBBXXTrUmp32k6gd87kA65sOKvd6390wdNQf2Hs5CKqbLjPCyoIiX/OGozAOohpsl5jFBkBRJaNcylnY7daeQ6/MS63a68NwXt6sguNLt9kNnzEcqGILlKUjTNOsiA7aDRnGzAmx7tBU75rGU1UeCVp/us/QmtJSnc7ci59bsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lzseZNXA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dd++4tKmdtMOvBBnnnoIYGKrXxRrKVRPTAqrEQXWV6w=; b=lzseZNXAHNB8VGospEKU+WILFk
	sYd2bdEtrFdshGRKyzaYgpQpxiHtaRuC7qIiBSZ7cBGCBZEzEGvcVYdbaN3U0IndulheHaQqJLGKl
	ZijNKS80e8Sz8pi3LZDRboXSmA9X7V/c+WQAsrHljmdsGa1gMhu81vlTFO605XcSec7J+OKQXQKX3
	AmSnCO0TLxIUmPqhmJmax/aHPMXw/vptQ5efr1LG1hLyr5MAY7J/wlyRN4y6ZBVkVcKynvyLkK6Y6
	Bc8z1VVZwnTXNQXvKHCG1QqeV+pFKrmHBMNwFVy6BVChKmKlgfYbPkJHJXKY6mGOpivm9giPrIVbL
	reicNc8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51834)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAs3z-000000003rq-3Ub9;
	Thu, 09 Apr 2026 17:17:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAs3v-000000004Ys-2ghu;
	Thu, 09 Apr 2026 17:16:59 +0100
Date: Thu, 9 Apr 2026 17:16:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
Message-ID: <adfQ-44bKs2I4FrN@shell.armlinux.org.uk>
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk>
 <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
 <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
 <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com>
 <adayAMR_dEA6W5vW@shell.armlinux.org.uk>
 <adeaiSAnkaggqPsA@willie-the-truck>
 <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9948-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 691293CD9C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 08:37:53AM -0700, Linus Torvalds wrote:
> On Thu, 9 Apr 2026 at 05:24, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Apr 08, 2026 at 08:52:32PM +0100, Russell King (Oracle) wrote:
> > > What's the status on the iommu fix? Is it merged into mainline yet?
> > > If it isn't already, that means net-next remains unbootable going
> > > into the merge window without manually carrying the fix locally.
> >
> > I'll pick it up for 7.0 in the iommu tree.
> 
> ... and now it's in my tree.

Thanks, I see you merged it prior to the net tree, which should mean
the fix finds its way into net-next! Yay! Double thanks for that!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

