Return-Path: <dmaengine+bounces-11224-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDziCRVkI2o4sQEAu9opvQ
	(envelope-from <dmaengine+bounces-11224-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5864BE94
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HblXOeMg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11224-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11224-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6BBD3022943
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8B175A76;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97502AE8D;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704142; cv=none; b=iuHh1f1WmHJCf2Kx+MUEWGLeU6GjOPNOYQtkzMB42Gy2eFDLkT5k8mZpJrRj2yUZrOqa+v1h6ia4RcFQa/QjBAWFw8ETiZgOqFV5qOESklwcZ3s8XPCysuncan0g1LMZi/N4Z9VjVLn4z6ByR6RLBqSQ30z/QAtHDWfGA6f4hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704142; c=relaxed/simple;
	bh=GPeLELwKUxb5g3CMxcLjsNEd5OdsvCqnB57pdS86BWU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GU9D9hcJeGehe/SUTiS17jVjywNBY8atlCZzbFuGp4AsyX6jFhweZVKOL6aX/zCY9aHszI/SYDKi71xRIcxEFBVwSINP2AS6yeDv1Cmx8eNtmlDwoMjyxFDgp9P27tsvVeHZDFXBCcmnAmpTsB+BPdNnrAcVBwpCr/VL87UtsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HblXOeMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B3B6C2BCB4;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=GPeLELwKUxb5g3CMxcLjsNEd5OdsvCqnB57pdS86BWU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HblXOeMgds2XSzUejZAwhrIPJzeFhlDaBJFIQ+F34oeC6WfE0W5QJ4AS5DrcnvnLV
	 kJhwtUg79VCsGwI0ehJoiJjqPkbr7H+2eYk/ThzL8r1WXIyhlC1oEk8GNFG6ert4jo
	 wTyR34Y1km1ZNUf3Z5jFGEm9tKQ6Paxxx6qJoJ4r4IBuJxgKadIJ9fEJRpaSWodrqQ
	 wqrJwFLBkRxCi2ivif7jjAR/Fu43IJajSgPqBmADvA6W/uC1SHr7j0pDjpg1dkuTLN
	 SZt7WiWPTmtQj+Qj5eDCouF9LwLze/Lrxv2ISVRvLudQ+KW8QYf++VVZBrZZlkf4hv
	 aCsBHnEklNv6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D461CD6E7C;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Subject: [PATCH v3 00/23] dmaengine: Smart Data Accelerator Interface
 (SDXI) basic support
Date: Fri, 05 Jun 2026 19:02:03 -0500
Message-Id: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQrCMBREr1KyNvJ/0jSJK+8hLtL81GbRFhoJS
 undjYq0uBoG3ptZWApzDImdqoXNIccUp7EUeaiY7914CzxS6UyAUGBQ8kSPyFuXAteStLcd+aA
 0K3wf032an5+pjCUuX8uC2lkZOXACWaNDYUXrzm6go5+G90ThG6gR/nkkNLVvlW9g469FyOL30
 4BC3HuieMZY3wVCHWS3eeu6vgDOesE8+AAAAA==
X-Change-ID: 20250813-sdxi-base-73d7c9fdce57
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=9954;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=GPeLELwKUxb5g3CMxcLjsNEd5OdsvCqnB57pdS86BWU=;
 b=eq/NXwRQl2LzAQrXu7aGIiRLzP/pY0lxz3TvMgZYnr9DbWPNQU2mfMNbJvTBPmtI3Kw1vtDn8
 Hm13iDj08CSDmdM7uiQkecqcSzsOpmWXoBs5Xwgp14c1UEgb3lh6pOw
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11224-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:email,amd.com:replyto,snia.org:url,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB5864BE94

The Smart Data Accelerator Interface (SDXI) is a vendor-neutral
architecture for memory-to-memory data movement offload designed for
kernel bypass and virtualization.

General information on SDXI may be found at:
https://www.snia.org/sdxi

This submission adds a driver with basic support for PCIe-hosted SDXI
1.0 implementations and includes a DMA engine provider with memcpy
capability.

Planned future SDXI work (out of scope for this series):

* Character device for exposing SDXI contexts to user space.

* Support for operation types to be added in future SDXI revisions.

* Greater configurability for control structures, e.g. descriptor ring
  size.

The latest released version of the SDXI specification is 1.0:
https://www.snia.org/sites/default/files/technical-work/sdxi/release/SNIA-SDXI-Specification-v1.0a.pdf

Draft versions of future SDXI specifications in development may be found at:
https://www.snia.org/tech_activities/publicreview#sdxi

The DMA engine provider included here survives dmatest runs with both
polled and interrupt-signaled completion modes, with the following
debug options and sanitizers enabled:

CONFIG_DEBUG_KMEMLEAK=y
CONFIG_KASAN=y
CONFIG_PROVE_LOCKING=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_UBSAN=y

Example test:
  $ qemu-system-x86_64 -m 4G -smp 4 -kernel ~/bzImage -nographic \
    -append 'console=ttyS0 debug sdxi_core.dma_channels=2
    dmatest.polled=0 dmatest.iterations=10000 dmatest.run=1 \
    dmatest.threads_per_chan=2 sdxi_core.dyndbg=+p \
    sdxi_pci.dyndbg=+p' -device vfio-pci,host=0000:01:02.1 \
    -initrd ~/rootfs.cpio -M q35 -accel kvm
  [...]
  # dmesg | grep -i -e sdxi -e dmatest
  dmatest: No channels configured, continue with any
  sdxi 0000:00:03.0: allocated 64 vectors
  sdxi 0000:00:03.0: attempting stop, current state: stopped
  sdxi 0000:00:03.0: SDXI 1.0 device found
  sdxi 0000:00:03.0: activated
  dmatest: Added 2 threads using dma0chan0
  dmatest: Added 2 threads using dma0chan1
  dmatest: Started 2 threads using dma0chan0
  dmatest: Started 2 threads using dma0chan1
  dmatest: dma0chan0-copy0: summary 10000 tests, 0 failures
  dmatest: dma0chan0-copy1: summary 10000 tests, 0 failures
  dmatest: dma0chan1-copy1: summary 10000 tests, 0 failures
  dmatest: dma0chan1-copy0: summary 10000 tests, 0 failures

---
Changes in v3:

(I'm continuing to work through the Sashiko-reported issues/comments
from the v2 submission, but IMO there's enough of a delta here to
respin.)

- Fix akey allocation error path in dma.c to return a proper
  error value. (Tycho Andersen)
- Disable SR-IOV in PCI removal. (TA)
- Update the Rust list of PCI class codes simultaneously with the C
  header. (Sashiko)
- Properly build the bus-agnostic core support as a separate
  module (sdxi-core) from the PCI driver (sdxi-pci). (Sashiko)
- Add dependency on CONFIG_64BIT to simplify assumptions around MMIO
  and control structure accesses. (Sashiko)
- Use readq/writeq instead of ioread64/iowrite64 since we don't need
  to handle port space. (Sashiko)
- Correct vector allocation range to ensure the error IRQ index (0) is
  reserved. (Sashiko)
- Fix context control block dma pool allocation failure
  check. (Sashiko)
- Ensure device is in stopped state before clearing MMIO_CTL0
  configuration during init. (Sashiko)
- Add explicit alignment attributes to packed control structure
  types. (Sashiko)
- Rename prep_memcpy_polled() to prep_memcpy_nointr(). (Frank Li)
- Link to v2: https://patch.msgid.link/20260511-sdxi-base-v2-0-889cfed17e3f@amd.com

Changes in v2:
- Drop unneeded dma_set_mask_and_coherent() result check. (Frank Li)
- Inline SDXI_DRV_DESC directly into MODULE_DESCRIPTION(). (FL)
- Drop unneeded braces from simple conditionals. (FL)
- Drop sdxi logging wrapper macros; use dev_dbg, dev_info etc
  directly. (FL)
- Reordering of commit message (patch 04, "Feature
  discovery..."). (FL)
- Use read_poll_timeout() for function start and stop routines. (FL)
- Align multi-line FIELD_PREP() uses. (FL)
- Drop sdxi_create_dma_pool() helper. (FL)
- Remove unneeded dma_wmb() before iowrite64() to doorbell. (FL)
- Use WRITE_ONCE() to update descriptor ring write index. (FL)
- Make sdxi_completion_poll() eventually time out and adjust call
  sites. (FL)
- Remove vestigial sdxi_dma_unregister() declaration. (FL)
- Reserve context ID before allocating context data structures instead
  of after.
- Update context ID class to transfer ownership of ID to context
  object; sdxi_free_cxt() now responsible for releasing ID once
  assigned.
- Align small frequently-updated DMA pool objects to cacheline
  boundaries.
- Drop redundant dma_set_mask_and_coherent() from DMA provider.
- Log unarchitected function status values in sdxi_dev_gsv().
- Remove sdxi_to_dev(); the abstraction is unnecessary and sdxi->dev
  is shorter.
- Link to v1: https://patch.msgid.link/20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com

Changes in v1:
- Reorder series and introduce functionality incrementally while
  remaining buildable and functional at each step. (Jonathan Cameron)
- Use devres APIs where possible for device resources (JC)
- Use cleanup APIs to significantly reduce use of goto-oriented error
  unwinding. (JC)
- Drop SDXI_DEBUG config option. (JC)
- Cite SDXI spec version and section number consistently throughout. (JC)
- Combine local variable declarations of same type. (JC)
- Mark descriptor structs __packed. (JC)
- Use designated initializers in descriptor encoding functions. (JC)
- Prefer dev_err_probe() over sdxi_err() in sdxi_pci_init(). (JC)
- Prune unnecessary includes throughout source files. (JC)
- Remove unnecessary/unhelpful comments in several places. (JC)
- Remove SDXI spec material from "Add SNIA SDXI accelerator sub-class"
  commit message and reword the remainder. (Bjorn Helgaas)
- Remove unnecessary local for DMA_BIT_MASK() argument in
  sdxi_pci_init(). (BH)
- Use "{ }" for final null entry in id table, not "{ 0, }". (BH)
- Replace sample descriptor submission code from the SDXI spec with an
  improved API that has unit tests, eliminates a copy step for
  callers, and can block until ring space becomes available if
  desired.
- Omit the error log facility for now; it can be reintroduced later.
- Use a per-device xarray to allocate context IDs and map them to
  context objects.
- Implement interrupt-based completion signaling for memcpy operations
  in the DMA engine provider, DMA provider code mostly rewritten.

Non-changes in v1:
- Mario suggested that pci_clear_master() is needed in
  sdxi_pci_init()'s error path and in sdxi_pci_exit() (now
  sdxi_pci_remove()). However, sdxi uses pcim_enable_device(), which
  appears to ensure that master is cleared for the device. Happy to
  revisit this if I'm mistaken.

- Link to RFC: https://lore.kernel.org/r/20250905-sdxi-base-v1-0-d0341a1292ba@amd.com

---
Nathan Lynch (23):
      PCI: Add SNIA SDXI accelerator sub-class
      MAINTAINERS: Add entry for SDXI driver
      dmaengine: sdxi: Add PCI initialization
      dmaengine: sdxi: Feature discovery and initial configuration
      dmaengine: sdxi: Configure context tables
      dmaengine: sdxi: Allocate DMA pools
      dmaengine: sdxi: Allocate administrative context
      dmaengine: sdxi: Install administrative context
      dmaengine: sdxi: Start functions on probe, stop on remove
      dmaengine: sdxi: Complete administrative context jump start
      dmaengine: sdxi: Add client context alloc and release APIs
      dmaengine: sdxi: Add descriptor ring management
      dmaengine: sdxi: Add unit tests for descriptor ring reservations
      dmaengine: sdxi: Attach descriptor ring state to contexts
      dmaengine: sdxi: Per-context access key (AKey) table entry allocator
      dmaengine: sdxi: Generic descriptor manipulation helpers
      dmaengine: sdxi: Add completion status block API
      dmaengine: sdxi: Encode context start, stop, and sync descriptors
      dmaengine: sdxi: Provide context start and stop APIs
      dmaengine: sdxi: Encode nop, copy, and interrupt descriptors
      dmaengine: sdxi: Add unit tests for descriptor encoding
      dmaengine: sdxi: MSI/MSI-X vector allocation and mapping
      dmaengine: sdxi: Add DMA engine provider

 MAINTAINERS                         |   7 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/sdxi/.kunitconfig       |   4 +
 drivers/dma/sdxi/Kconfig            |  40 +++
 drivers/dma/sdxi/Makefile           |  16 ++
 drivers/dma/sdxi/completion.c       |  87 +++++++
 drivers/dma/sdxi/completion.h       |  25 ++
 drivers/dma/sdxi/context.c          | 507 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h          | 109 ++++++++
 drivers/dma/sdxi/descriptor.c       | 198 ++++++++++++++
 drivers/dma/sdxi/descriptor.h       | 135 ++++++++++
 drivers/dma/sdxi/descriptor_kunit.c | 484 ++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/device.c           | 371 ++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c              | 501 +++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h              |  11 +
 drivers/dma/sdxi/hw.h               | 254 ++++++++++++++++++
 drivers/dma/sdxi/mmio.h             |  60 +++++
 drivers/dma/sdxi/pci.c              | 117 +++++++++
 drivers/dma/sdxi/ring.c             | 159 +++++++++++
 drivers/dma/sdxi/ring.h             |  84 ++++++
 drivers/dma/sdxi/ring_kunit.c       | 105 ++++++++
 drivers/dma/sdxi/sdxi.h             | 138 ++++++++++
 include/linux/pci_ids.h             |   1 +
 rust/kernel/pci/id.rs               |   1 +
 25 files changed, 3417 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20250813-sdxi-base-73d7c9fdce57

Best regards,
--  
Nathan Lynch <nathan.lynch@amd.com>



