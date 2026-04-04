Return-Path: <dmaengine+bounces-9882-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOC3MIFG0Wn5HAcAu9opvQ
	(envelope-from <dmaengine+bounces-9882-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 19:12:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868F39BEBE
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F0E30136A5
	for <lists+dmaengine@lfdr.de>; Sat,  4 Apr 2026 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EC337B99;
	Sat,  4 Apr 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcgJMoZ0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C51336EE1
	for <dmaengine@vger.kernel.org>; Sat,  4 Apr 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322733; cv=none; b=qd00E24j+TRRTYN80j3NAFQ/LnF3VlOEcWpklsAiE5iGf7IylZLEB1jOPdUPr8t4p1Ek4gsP1pY5iAbCDkvSV1WEWZEfekmHqVCA+ATclWvthgc3gnqRs7NXI2bwFyJnoMpZurnXhfT2yEbPRGn+M4YpRHbTDrdQVvEunaDvxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322733; c=relaxed/simple;
	bh=6HWbdXTvY5ARCKQw/mJejk6jJkYYvhLGzuFZu/CMKrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7A4fJ8oEKf0IzH5VEkWikK9jZJ+ZqGLKHVQ5WwAQPkyRZxGAZmTiT0e2Rqc4xBvE7TAvBcUBPt7Igi8LiP3pK08HihINIbVJHkifK6+OAhnIqINxp91qyyCIuvcb+ZPb1s2aMKtMGCWdEa0oQ1aRa68o35W4BL0PJv0vuoRa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcgJMoZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF4AC32781
	for <dmaengine@vger.kernel.org>; Sat,  4 Apr 2026 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322733;
	bh=6HWbdXTvY5ARCKQw/mJejk6jJkYYvhLGzuFZu/CMKrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GcgJMoZ0JuCk1oE2p1uOznAEPZR6CrHmU63ZoUxVtxnX8mJab0r4uPFFxlAmTqcZA
	 myj15f5ytltHO0slbfE7HO6gmrYbw3URX3zm5Ch5rWSlVdR401ec5dfg7RfsH5oBN4
	 PnqK3oN/0RY4LZWR+knx2bZtXfIc8cep3MmTai8iVDgIiE9nPWWVN8CVFPKdI3F70S
	 gC8kQiqGR2CuAUPcJ/9Yaydp3RzrBUC+10/bPsY353+aL5ufFQEdpAgg8xvos3Up3I
	 owNuHEnPhFIkScgSgy7tm8cpYaSl2vK6VDp57FI0G+Yzb2m579C7WS8lt58GdxocpN
	 fGfJdiBZK7yLg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4042905015cso1753045fac.0
        for <dmaengine@vger.kernel.org>; Sat, 04 Apr 2026 10:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDOKe5E9ly52cPO7m9rT/nv9IG2JUBgzA+ZDKzHecoHkTqr8jDz+6VNGbsyQEocPJk/sACeoKYa9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rk0qXjxk6Qm46V+W8CpGluu77GFzxYL97Nj+xoWk8KgbKYU8
	vreKdGn1QFMWHOikG4GrsjpiXMMhSuT9pWs7KlWyaRfvamHAuDvOCl9hLGKvt6gdlDRvMZ1Oy9y
	OvFC7Nl8S3MqA3ggHBEtz013V8mDieBc=
X-Received: by 2002:a05:6871:581e:b0:422:cd76:929d with SMTP id
 586e51a60fabf-4230fd2d9e4mr3996409fac.18.1775322730928; Sat, 04 Apr 2026
 10:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 19:11:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRKyPesMGKGoDZEMDCX-GVw6Z-dxMLhNhwy6Kjz=7MCQ@mail.gmail.com>
X-Gm-Features: AQROBzCS1sK1yep87rT-2xolltVfQ4j4qlt-9lHai0wQJnu4V3tzUHOX8_7jVCo
Message-ID: <CAJZ5v0hRKyPesMGKGoDZEMDCX-GVw6Z-dxMLhNhwy6Kjz=7MCQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Saravana Kannan <saravanak@kernel.org>, Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, 
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,rowland.harvard.edu,lst.de,google.com,intel.com,ozlabs.ru,arm.com,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.infradead.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,samsung.com,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9882-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:email]
X-Rspamd-Queue-Id: 2868F39BEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 4, 2026 at 2:07=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> The main goal of this series is to fix the observed bug talked about
> in the first patch ("driver core: Don't let a device probe until it's
> ready"). That patch fixes a problem that has been observed in the real
> world and could land even if the rest of the patches are found
> unacceptable or need to be spun.
>
> That said, during patch review Danilo correctly pointed out that many
> of the bitfield accesses in "struct device" are unsafe. I added a
> bunch of patches in the series to address each one.
>
> Danilo said he's most worried about "can_match", so I put that one
> first. After that, I tried to transition bitfields to flags in reverse
> order to when the bitfield was added.
>
> Even if transitioning from bitfields to flags isn't truly needed for
> correctness, it seems silly (and wasteful of space in struct device)
> to have some in bitfields and some as flags. Thus I didn't spend time
> for each bitfield showing that it's truly needed for correctness.
>
> Transition was done semi manually. Presumably someone skilled at
> coccinelle could do a better job, but I just used sed in a heavy-
> handed manner and then reviewed/fixed the results, undoing anything my
> script got wrong. My terrible/ugly script was:
>
> var=3Dcan_match
> caps=3D"${var^^}"
> for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
>   echo $f
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D tru=
e/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D tru=
e/dev_set_${caps}(\&\\1)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D fal=
se/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D fal=
se/dev_clear_${caps}(\&\\1)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D \([=
^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D \([=
^;]*\)/dev_assign_${caps}(\&\\1, \\2)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_=
a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_=
a-zA-Z\[]\)/dev_${caps}(\&\\1)\\2/" "$f"
> done
>
> From v3 to v4, I transitioned to accessor functions with another ugly
> sed script. I had git format the old patches, then transformed them
> with:
>
> for f in *.patch; do
>   echo $f
>   sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev=
_test_and_set_\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_t=
est_and_set_\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_\\L\\1(=
\\2)/" "$f"
>   sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_\\L\\1(\\=
2)/" "$f"
>   sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_set_\\L\=
\1(\\2)/" "$f"
>   sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_set_\\L\\1=
(\\2)/" "$f"
>   sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_clear_=
\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_clear_\\=
L\\1(\\2)/" "$f"
>   sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags, \(.*\))/d=
ev_assign_\\L\\1(\\2, \\3)/" "$f"
>   sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags, \(.*\))/dev=
_assign_\\L\\1(\\2, \\3)/" "$f"
> done
>
> ...and then did a few manual touchups for spacing.
>
> NOTE: one potentially "controversial" choice I made in some patches
> was to always reserve a flag ID even if a flag is only used under
> certain CONFIG_ settings. This is a change from how things were
> before. Keeping the numbering consistent and allowing easy
> compile-testing of both CONFIG settings seemed worth it, especially
> since it won't take up any extra space until we've added a lot more
> flags.
>
> I only marked the first patch as a "Fix" since it is the only one
> fixing observed problems. Other patches could be considered fixes too
> if folks want.
>
> I tested the first patch in the series backported to kernel 6.6 on the
> Pixel phone that was experiencing the race. I added extra printouts to
> make sure that the problem was hitting / addressed. The rest of the
> patches are tested with allmodconfig with arm32, arm64, ppc, and
> x86. I boot tested on an arm64 Chromebook running mainline.
>
> Changes in v4:
> - Use accessor functions for flags
>
> Changes in v3:
> - Use a new "flags" bitfield
> - Add missing \n in probe error message
>
> Changes in v2:
> - Instead of adjusting the ordering, use "ready_to_probe" flag
>
> Douglas Anderson (9):
>   driver core: Don't let a device probe until it's ready
>   driver core: Replace dev->can_match with dev_can_match()
>   driver core: Replace dev->dma_iommu with dev_dma_iommu()
>   driver core: Replace dev->dma_skip_sync with dev_dma_skip_sync()
>   driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
>   driver core: Replace dev->state_synced with dev_state_synced()
>   driver core: Replace dev->dma_coherent with dev_dma_coherent()
>   driver core: Replace dev->of_node_reused with dev_of_node_reused()
>   driver core: Replace dev->offline + ->offline_disabled with accessors
>
>  arch/arc/mm/dma.c                             |   4 +-
>  arch/arm/mach-highbank/highbank.c             |   2 +-
>  arch/arm/mach-mvebu/coherency.c               |   2 +-
>  arch/arm/mm/dma-mapping-nommu.c               |   4 +-
>  arch/arm/mm/dma-mapping.c                     |  28 ++--
>  arch/arm64/kernel/cpufeature.c                |   2 +-
>  arch/arm64/mm/dma-mapping.c                   |   2 +-
>  arch/mips/mm/dma-noncoherent.c                |   2 +-
>  arch/powerpc/kernel/dma-iommu.c               |   8 +-
>  .../platforms/pseries/hotplug-memory.c        |   4 +-
>  arch/riscv/mm/dma-noncoherent.c               |   2 +-
>  drivers/acpi/scan.c                           |   2 +-
>  drivers/base/core.c                           |  53 +++++---
>  drivers/base/cpu.c                            |   4 +-
>  drivers/base/dd.c                             |  28 ++--
>  drivers/base/memory.c                         |   2 +-
>  drivers/base/pinctrl.c                        |   2 +-
>  drivers/base/platform.c                       |   2 +-
>  drivers/dma/ti/k3-udma-glue.c                 |   6 +-
>  drivers/dma/ti/k3-udma.c                      |   6 +-
>  drivers/iommu/dma-iommu.c                     |   9 +-
>  drivers/iommu/iommu.c                         |   5 +-
>  drivers/net/pcs/pcs-xpcs-plat.c               |   2 +-
>  drivers/of/device.c                           |   6 +-
>  drivers/pci/of.c                              |   2 +-
>  drivers/pci/pwrctrl/core.c                    |   2 +-
>  drivers/regulator/bq257xx-regulator.c         |   2 +-
>  drivers/regulator/rk808-regulator.c           |   2 +-
>  drivers/tty/serial/serial_base_bus.c          |   2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c      |   2 +-
>  include/linux/device.h                        | 120 ++++++++++++------
>  include/linux/dma-map-ops.h                   |   6 +-
>  include/linux/dma-mapping.h                   |   2 +-
>  include/linux/iommu-dma.h                     |   3 +-
>  kernel/cpu.c                                  |   4 +-
>  kernel/dma/mapping.c                          |  12 +-
>  mm/hmm.c                                      |   2 +-
>  37 files changed, 206 insertions(+), 142 deletions(-)
>
> --

For the whole set

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

