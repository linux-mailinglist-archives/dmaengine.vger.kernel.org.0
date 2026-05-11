Return-Path: <dmaengine+bounces-10302-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOeDGjArAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10302-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEB2514EDF
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44413025289
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B44D2ED1;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeEC8MLs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB943D51E;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=ZnEBb3p1Fzb0BRAykrrk4Ptyqv6qK+9ldchm3j4DCtUZTZeLJUQKIQdc1pbaIW2tfvMCftlUCkC32V+zzgjWD/chuUu/t/OTQiCMAHIPSIRgWlpT5FjG9qQD7DFKijt45saVy6UqU+osPgdstODkPzVgXVlDDFK8mg162VJWQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=hGZfqThOZZddpCbkz23NwkieHdYCpbQ6JESN1QIcXuM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jdnCup4WRxPt7NZLFnL5wjBv2EwRziWdwan54Bbj7bJ2ikKoyzGjk4zeVOkiYMngMybQb1j7SahcYvIYFZ2Lwc8mMqcwQOy4c+0f7frs9V7M1g2kIwidjprD+L0LsUSseuxt4TQeE9wNxyg0Lp3yil/z6arcgX3NYce/pEHgCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeEC8MLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 272ABC2BCB0;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=hGZfqThOZZddpCbkz23NwkieHdYCpbQ6JESN1QIcXuM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZeEC8MLsli540Xl/1KV8hTzn/Vd2W2j8qiWDiCUpXqn0EdMjL0a1cccMEQApgUgPj
	 kCq2fqIxq2WGnOCuP+YikOfBup92M65a264isMsPBU7QWeQ3W9f0baXsQ90LzXSaw3
	 64eevXVn+fLQQU/oL202uBejLRS1N1AkMxvO935j375QO/er/w1vUrb6ydCgyrK0HB
	 16xWO5cqS8s8r/ZC1QI2GdyEVW1xvybPhEoKnC1oBXKuP5S2JrJ/lVQpUpcQhcHD6s
	 nD91P01+YOHhrT01bBne6LFqtyaRWdBNjRhliTAxfHUax7obmVWASDB4CXJEoJ50qo
	 xGHB4Zaq3Ui/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16900CD4842;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Subject: [PATCH v2 00/23] dmaengine: Smart Data Accelerator Interface
 (SDXI) basic support
Date: Mon, 11 May 2026 14:16:12 -0500
Message-Id: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Myw7CIBBFf6VhLWaGR2ld+R/GBTBoWbRNwBBNw
 7+LutC4ujnJOXdjOaQYMjt0G0uhxBzXpYHYdcxPdrkGHqkxEyA0DCh5pnvkzubAjSTjxwv5oA1
 r/hTzbU2P91XBNqdPNYL+qQpy4ARSoUUxCmePdqa9X+fXRfN7UAj/PhIOyjvte/j651rrE7vzM
 1fAAAAA
X-Change-ID: 20250813-sdxi-base-73d7c9fdce57
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=7290;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=hGZfqThOZZddpCbkz23NwkieHdYCpbQ6JESN1QIcXuM=;
 b=eam0GBkBJ1o11YjISIg+HnSeG+PsFYfDRPvdNweZfP1A3vtqR27ga3qkStzz3/MBi3Betkxsn
 USmEdoq4X+yD/aZs9XE28j84yQah6Mzq3FEoiQ57cSko/hA9mjozmL2
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 0EEB2514EDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10302-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

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

---
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
 drivers/dma/sdxi/Kconfig            |  18 ++
 drivers/dma/sdxi/Makefile           |  16 ++
 drivers/dma/sdxi/completion.c       |  87 +++++++
 drivers/dma/sdxi/completion.h       |  25 ++
 drivers/dma/sdxi/context.c          | 507 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h          | 109 ++++++++
 drivers/dma/sdxi/descriptor.c       | 198 ++++++++++++++
 drivers/dma/sdxi/descriptor.h       | 135 ++++++++++
 drivers/dma/sdxi/descriptor_kunit.c | 484 ++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/device.c           | 357 +++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c              | 499 +++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h              |  11 +
 drivers/dma/sdxi/hw.h               | 254 ++++++++++++++++++
 drivers/dma/sdxi/mmio.h             |  57 ++++
 drivers/dma/sdxi/pci.c              | 115 ++++++++
 drivers/dma/sdxi/ring.c             | 159 +++++++++++
 drivers/dma/sdxi/ring.h             |  84 ++++++
 drivers/dma/sdxi/ring_kunit.c       | 105 ++++++++
 drivers/dma/sdxi/sdxi.h             | 138 ++++++++++
 include/linux/pci_ids.h             |   1 +
 24 files changed, 3373 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20250813-sdxi-base-73d7c9fdce57

Best regards,
--  
Nathan Lynch <nathan.lynch@amd.com>



