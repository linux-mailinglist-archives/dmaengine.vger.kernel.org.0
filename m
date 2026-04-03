Return-Path: <dmaengine+bounces-9874-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO10E0gPz2lysgYAu9opvQ
	(envelope-from <dmaengine+bounces-9874-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 02:52:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A161938FB22
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 02:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CD430160E2
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2026 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA011257435;
	Fri,  3 Apr 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U6fb1bYX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718A23F417
	for <dmaengine@vger.kernel.org>; Fri,  3 Apr 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177495; cv=none; b=uQmtJoijO5rnUTLj1GN4C9h8c8ZsHAfhjiwd3piDCuljnqpIQrRJDIeGGB+urqCKWbBe2csEN+dzn5LfeNW3uycYKfmkySFKDRW4GX8QTyefyRhbt9qdpuMNxOprcgXYjqPl5lAZsofqSsNWpgvMz6LMCuH+mDGDJndM7SajEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177495; c=relaxed/simple;
	bh=MLU3H0vT5l7RkyqJ4axMsnZCk3EEo/xxuxHDjIkeDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOvHSM3tswuJHdSr4XgW3zYdqqk2swDnXHDsc36Avn0LpJ15+ukJsf+IyS2T2vgch7qne2lu54ZXY6+uvG5TArtNvdIJrX1q7HJLojeZ4W/SmrryoxuwdlTyARXAKfITzI6VGR94ruah+/SySeuov2AFlWgSJDjZuyKtSYjcQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U6fb1bYX; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732165d1eso2249982c88.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177493; x=1775782293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=U6fb1bYXSFh8hkp9cNXTZqV0oKW2o3WGWUrIJCFeMAoeuwJh4rs88N+4Ft/69+Akbe
         yc0JovpEZfrW8+QvEM9WOWM560NZi8j+ES3IivhSWxA+G8l1WPLEvjINJoULkNm/le+a
         UGkWXcH+Wlj6BoSy9+6OKmwemoOa1Y2eiqXdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177493; x=1775782293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=LDvhmQ2NI1hvLHuzIC7fL3YgFDNcMVQj3eWqtKUOYUlNbSq/2fY0dxpFxbkZjolh0s
         ElUdmfh/T50iKfope+gCp+YJlcOSVqsz+KKUlWMZUgjPC+lGVKFnYDAp6+frtQ9ncHgO
         ArnQw3Dfeq3/H2T3iRpZAfSrqjVVIX+mEuDHGAc9UXzfyfTIgo7JbDhL6IWgCUlof/Se
         zN64e05sQ1E67uMk8AvM9fjCnQ/ZJGemQoFDSFFQv9siTScickbrlqx2lnzlRxn7X2iU
         SE5CU1SvQxet6HfAhc32fXmPlTl6IrKg9vsAfFzNXLuuytX5IXyzl06l+hHvG6q8lgjz
         mayQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMq5kbWO3gTCsF9tGGeFOhrez+SiQv91Id2KNKw8XbHE/0SdeGMLjlWfEjAYX3UeX9gsUwl9uI/3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEn7dUuuP/37ntctPKIGEFVSNZS4bFWfAuxdOzJDxo3xFys9Lt
	kCD55dg+kaDirJe6kXkhJ/f+92f4RZwfKnZnCc5EB3RBZCMrc632wHIe+GQnSCPrmw==
X-Gm-Gg: AeBDietbklMdSBbsgotgvSJCxHL1mSSTvSlLkDHCivsYFymCpkd7gfou/dsD5tZMR3+
	UQpClK+JfDp2OsMBpWDRZGJarfOhmQVWaaQJ0/EgjEBuJgRMFmrTM1qzm4zrTFplMZjmySF/TiA
	UG2g+Wp6u8AI8wNFr1x1GNYriqq4V16aOXc57soXN+QKXKUlWR5SA1LpgVnxrxS5BUUNnkJYJCJ
	KhUfwbNrQIE2HeAayeX1ZLN7PwTqwBSER2ORrpGjME1J+e3vcjJzWXDdXniHWabJfcTQUW+s4Mu
	cPVYNfz43tJ8dJ5zac/Otb9ckU8LvF76qPiWVXHSo8w0XP+dO+UIvmbgBRR3XwTffYuXAi1oZCv
	0DC7v9iuVkSvPauW918BQiNxqU9y6hidxzgivIK6EHFbvnGEC/YpU1ORlt3/TTf28BsK3DW0lZL
	3hqxnZxZyTGExCp4sOMbSIqkg7yLtn7Ap/9+He08XaQs9sM/7VHmoebibrDdwTfRI6iUo7GaIeW
	7M7cb9eKHicv+qdcQApWg==
X-Received: by 2002:a05:693c:3009:b0:2c1:558c:16f7 with SMTP id 5a478bee46e88-2cbf950392cmr655589eec.6.1775177492780;
        Thu, 02 Apr 2026 17:51:32 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank.Li@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	alex@ghiti.fr,
	alexander.stein@ew.tq-group.com,
	andre.przywara@arm.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	davem@davemloft.net,
	david@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	gregory.clement@bootlin.com,
	hkallweit1@gmail.com,
	iommu@lists.linux.dev,
	jirislaby@kernel.org,
	joel@jms.id.au,
	joro@8bytes.org,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kuba@kernel.org,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mani@kernel.org,
	maz@kernel.org,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	peter.ujfalusi@gmail.com,
	peterz@infradead.org,
	pjw@kernel.org,
	robh@kernel.org,
	sebastian.hesselbarth@gmail.com,
	tglx@kernel.org,
	tsbogend@alpha.franken.de,
	vgupta@kernel.org,
	vkoul@kernel.org,
	will@kernel.org,
	willy@infradead.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v3 0/9] driver core: Fix some race conditions
Date: Thu,  2 Apr 2026 17:49:46 -0700
Message-ID: <20260403005005.30424-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,mips.com,intel.com,google.com,hp.com,lst.de,ozlabs.ru,chromium.org,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.infradead.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,samsung.com,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9874-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[88];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:mid]
X-Rspamd-Queue-Id: A161938FB22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The main goal of this series is to fix the observed bug talked about
in the first patch ("driver core: Don't let a device probe until it's
ready"). That patch fixes a problem that has been observed in the real
world and could land even if the rest of the patches are found
unacceptable or need to be spun.

That said, during patch review Danilo correctly pointed out that many
of the bitfield accesses in "struct device" are unsafe. I added a
bunch of patches in the series to address each one.

Danilo said he's most worried about "can_match", so I put that one
first. After that, I tried to transition bitfields to flags in reverse
order to when the bitfield was added.

Even if transitioning from bitfields to flags isn't truly needed for
correctness, it seems silly (and wasteful of space in struct device)
to have some in bitfields and some as flags. Thus I didn't spend time
for each bitfield showing that it's truly needed for correctness.

Transition was done semi manually. Presumably someone skilled at
coccinelle could do a better job, but I just used sed in a heavy-
handed manner and then reviewed/fixed the results, undoing anything my
script got wrong. My terrible/ugly script was:

var=can_match
caps="${var^^}"
for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
  echo $f
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1.flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1.flags)\\2/" "$f"
done

NOTE: one potentially "controversial" choice I made in some patches
was to always reserve a flag ID even if a flag is only used under
certain CONFIG_ settings. This is a change from how things were
before. Keeping the numbering consistent and allowing easy
compile-testing of both CONFIG settings seemed worth it, especially
since it won't take up any extra space until we've added a lot more
flags.

I only marked the first patch as a "Fix" since it is the only one
fixing observed problems. Other patches could be considered fixes too
if folks want.

I tested the first patch in the series backported to kernel 6.6 on the
Pixel phone that was experiencing the race. I added extra printouts to
make sure that the problem was hitting / addressed. The rest of the
patches are tested with allmodconfig with arm32, arm64, ppc, and
x86. I boot tested on an arm64 Chromebook running mainline.

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

Douglas Anderson (9):
  driver core: Don't let a device probe until it's ready
  driver core: Replace dev->can_match with DEV_FLAG_CAN_MATCH
  driver core: Replace dev->dma_iommu with DEV_FLAG_DMA_IOMMU
  driver core: Replace dev->dma_skip_sync with DEV_FLAG_DMA_SKIP_SYNC
  driver core: Replace dev->dma_ops_bypass with DEV_FLAG_DMA_OPS_BYPASS
  driver core: Replace dev->state_synced with DEV_FLAG_STATE_SYNCED
  driver core: Replace dev->dma_coherent with DEV_FLAG_DMA_COHERENT
  driver core: Replace dev->of_node_reused with DEV_FLAG_OF_NODE_REUSED
  driver core: Replace dev->offline + ->offline_disabled with DEV_FLAGs

 arch/arc/mm/dma.c                             |  4 +-
 arch/arm/mach-highbank/highbank.c             |  2 +-
 arch/arm/mach-mvebu/coherency.c               |  2 +-
 arch/arm/mm/dma-mapping-nommu.c               |  4 +-
 arch/arm/mm/dma-mapping.c                     | 30 +++----
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/mm/dma-mapping.c                   |  2 +-
 arch/mips/mm/dma-noncoherent.c                |  2 +-
 arch/powerpc/kernel/dma-iommu.c               |  8 +-
 .../platforms/pseries/hotplug-memory.c        |  4 +-
 arch/riscv/mm/dma-noncoherent.c               |  2 +-
 drivers/acpi/scan.c                           |  3 +-
 drivers/base/core.c                           | 55 +++++++-----
 drivers/base/cpu.c                            |  4 +-
 drivers/base/dd.c                             | 28 +++++--
 drivers/base/memory.c                         |  2 +-
 drivers/base/pinctrl.c                        |  2 +-
 drivers/base/platform.c                       |  2 +-
 drivers/dma/ti/k3-udma-glue.c                 |  6 +-
 drivers/dma/ti/k3-udma.c                      |  6 +-
 drivers/iommu/dma-iommu.c                     |  9 +-
 drivers/iommu/iommu.c                         |  5 +-
 drivers/net/pcs/pcs-xpcs-plat.c               |  2 +-
 drivers/of/device.c                           |  6 +-
 drivers/pci/of.c                              |  2 +-
 drivers/pci/pwrctrl/core.c                    |  2 +-
 drivers/regulator/bq257xx-regulator.c         |  2 +-
 drivers/regulator/rk808-regulator.c           |  2 +-
 drivers/tty/serial/serial_base_bus.c          |  2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      |  2 +-
 include/linux/device.h                        | 83 ++++++++++---------
 include/linux/dma-map-ops.h                   |  6 +-
 include/linux/dma-mapping.h                   |  2 +-
 include/linux/iommu-dma.h                     |  4 +-
 kernel/cpu.c                                  |  4 +-
 kernel/dma/mapping.c                          | 16 ++--
 mm/hmm.c                                      |  2 +-
 37 files changed, 178 insertions(+), 143 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


