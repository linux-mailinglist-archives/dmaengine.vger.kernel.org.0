Return-Path: <dmaengine+bounces-9943-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEyZJ5ey1mmFHQgAu9opvQ
	(envelope-from <dmaengine+bounces-9943-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 21:55:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A33C377F
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 21:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1AE304996D
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107937FF7B;
	Wed,  8 Apr 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HbONVFG6"
X-Original-To: dmaengine@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB23361DDD;
	Wed,  8 Apr 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677961; cv=none; b=JCzMULcuN7/dvHDuoP/9/5MpaKLXIjvKgyFfpQYmSNqJ2PkSZbDGgJLfM0fevonOoQn1a9/763Km10ohUXmLgAEfo3E9HU28eIKQnzuJcHJZ6TDkTPaV16LjhbMRWBPOZmthcCzHk3GHa3EY5Zl+yPnXJWDmuMNoWyqqYFwkFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677961; c=relaxed/simple;
	bh=9mqb4UmtbkwxmOKBN82oecxyPuZOukRhEtgO/Lh2Y5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDo9s905hzWgZuZy70ZR41oKp/qpLrpLGVcGxqDIyZBB1RmGZ3vSsnMurXy6crx1eKky+2+oPFpgtF/ZUMIlB+vA9BP9MabxayeRXmKHN7efcGWRve+Vf2/IV0ABxzb8WS7N8H68l0PaNlcE59zvqPINUFzssLI86ZlAIe/2mCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HbONVFG6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=siH4dWUpa1bG3+ZxEQfIrP5wIqLbPeNz587asx6iEtM=; b=HbONVFG6DRgrSygkw950meAgfH
	FLTLo7BxXvMxVYn1N3O9aPUiz3woyCupXzqlJQWKrMvzQLmTmBdI6FEku+H9GKYgnuT3VLPpCo9f+
	6UDXAtge8QqbJsZepg2gz1o0r8ZWvTGoK5cuNO5b+6T7SGJHaGQ1dJN34J2aho4Bw1hyZTnIeNaC4
	Poq5/q05n5j5v6Xxsm05218oh5ixACNea6eFktDlpcOoW2BJjsL2Wd0AjuMGd6wqOP2v1ksNxubFr
	y9J3KuLltt3yfobkIvJuBFwB/mpTyjhKQzrWzf7bSihFoYIWM5TQZmnfgoZQm6ZHigZ83vVG3EqUO
	pkUdBNyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44908)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAYx1-000000002jw-3Ojf;
	Wed, 08 Apr 2026 20:52:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAYwy-000000003cC-3cPP;
	Wed, 08 Apr 2026 20:52:32 +0100
Date: Wed, 8 Apr 2026 20:52:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dmaengine@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
Message-ID: <adayAMR_dEA6W5vW@shell.armlinux.org.uk>
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk>
 <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
 <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
 <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9943-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A8A33C377F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 05:40:48PM +0100, Robin Murphy wrote:
> On 2026-04-08 5:16 pm, Russell King (Oracle) wrote:
> > On Wed, Apr 08, 2026 at 05:08:34PM +0100, Russell King (Oracle) wrote:
> > > The rebase is still progressing, but it's landed on:
> > > 
> > > c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction
> 
> FWIW I don't see a Tegra having the Xilinx IP in it anyway - judging by the
> DT it has their own tegra-gpcdma engine...
> 
> There's a fair chance this could be 90c5def10bea ("iommu: Do not call
> drivers for empty gathers"), which JonH also reported causing boot issues on
> Tegras - in short, SMMU TLB maintenance may not be completed properly which
> could lead to recycled DMA addresses causing exactly this kind of random
> memory corruption. I CC'd you on a patch:
> 
> https://lore.kernel.org/linux-iommu/20260408162846.GE3357077@nvidia.com/T/#t

Okay, bisect complete, and... no idea. It seems to suggest that 7.0-rc6
is actually fine - it ended up blaming Linus' tagging of 7.0-rc6 which
only changed the makefile. So, my assumption that because rc6 was merged
into net-next last Thursday which fails, net-next+rc7 fails, rc7 also
fails, that rc6 would also fail seems to be false.

Right, rc7 built with the same .config that rc6 was built with
definitely fails, this time with:

Root device found: PARTUUID=741c0777-391a-4bce-a222-455e180ece2a
depmod: ERROR: could not open directory /lib/modules/7.0.0-rc7-bisect: No such file or directory
depmod: FATAL: could not search modules: No such file or directory
usb 2-3: new SuperSpeed Plus Gen 2x1 USB device number 2 using tegra-xusb
hub 2-3:1.0: USB hub found
hub 2-3:1.0: 4 ports detected
usb 1-3: new full-speed USB device number 3 using tegra-xusb
EXT4-fs (mmcblk0p1): VFS: Can't find ext4 filesystem
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/mmcblk0p1, missing codepage or helper program, or other error.
mount: /mnt/: can't find PARTUUID=741c0777-391a-4bce-a222-455e180ece2a.
get_swap_device: Bad swap file entry 1800c00008
get_swap_device: Bad swap file entry 1800c00008
get_swap_device: Bad swap file entry 1800c00008

So, it seems rc6 -> rc7 => fails
net-next with rc5 -> net-next with rc6 => fails

However, before I test anything else, I've just built the same rc7
which failed above with your patch applied - and that boots fine.

Now, each Thursday, net-next gets updated as that's the day that the
net tree gets sent for merging into mainline. This causes net-next's
version to increase. So something in current net-next plus in rc7 is
causing this problem.

The commit you claim needs fixing is:

$ git describe --contains 90c5def10bea
v7.0-rc7~29^2~2

which I had assumed wouldn't be in net-next.

Now, mainline had this on Thursday:

commit f8f5627a8aeab15183eef8930bf75ba88a51622f
Merge: 4c2c526b5adf ec7067e66119
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Apr 2 09:57:06 2026 -0700

    Merge tag 'net-7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

commit 4c2c526b5adfb580bd95316bf179327d5ee26da8
Merge: 2ec9074b28a0 8b72aa5704c7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Apr 2 09:53:16 2026 -0700

    Merge tag 'iommu-fixes-v7.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux

and merging iommu-fixes-v7.0-rc6 introduced the buggy 90c5def10bea
commit into -rc7.

However, as soon as Linus merged net-7.0-rc7, netdev maintainers merged
that exact commit back into net-next:

commit 8ffb33d7709b59ff60560f48960a73bd8a55be95
Merge: 269389ba5398 f8f5627a8aea
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Thu Apr 2 10:57:09 2026 -0700

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Thereby bringing in that buggy commit into net-next, but with net-next
identifying itself as 7.0-rc6.

That's... confusing, but explains why current net-next which reports
itself as 7.0-rc6 _and_ rc7 both fail, but rc6 itself does not. It
also means I've wasted an entire afternoon running a useless bisect
between rc5 and rc6 due to the version numbers in net-next being
meaningless.

What's the status on the iommu fix? Is it merged into mainline yet?
If it isn't already, that means net-next remains unbootable going
into the merge window without manually carrying the fix locally.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

