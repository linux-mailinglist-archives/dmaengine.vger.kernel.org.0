Return-Path: <dmaengine+bounces-9956-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM1aD5r22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9956-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:09:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76993D7EC5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9FC30252AA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E833030F;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBqfXyEb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF6311C2A;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826469; cv=none; b=XB8HA/BIQE9Ng0aPTlnszJs74YzLT3nMdRTFsf+Rm+oVNcL5GBUxhXRNkTso9OjvJ2L6W2Q9qemow8J/vg95duH0ay/ctxjwN0vEHWvUACCAsoH9KwPaV0+2hV2wn5NYru2ZyTMNh1QSW9y99WrumQRcOYfkQNgom3kHV/bym44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826469; c=relaxed/simple;
	bh=9rBcO8VxjER3OnuYfoq9G9H5KIuoJGxGfKEMHDiZlyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nmZAaZiWXH3982FuuNty6wcuiYts45+rNU/OMBdC1EsD/2ootKfiDUSlNkTP8f/SZ/TTLvbl1nIjlBq7By/k6JyymUhqCYGlv9kdf6F0Vv0AilDIJosawjIYHF2GaPkw9y9e72EAgYsOhQ2AtA/N9eMCYi2TSaDsPwhwsiBp7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBqfXyEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 759FEC19421;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826469;
	bh=9rBcO8VxjER3OnuYfoq9G9H5KIuoJGxGfKEMHDiZlyY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JBqfXyEb9TOT8FgY/nbT253IAXAJWn6WZXPN4ECiK0zkxL8r0ZdUm7ivM6yFvmx/+
	 X0gypKP5qvXxp1oFFfeCUhf1WLxVBIizLagwF55RfkvU59V752i0H3a2+9JBm9wv/H
	 BFKmo60dOGs0Xclw2gsZDZ8r39OmFE7cySVUaRtVuG6065THkKCCa81tjN7DdC//4T
	 eWlaPXRsnVq+MGLDx8T182DCXVlzgJcHAJNPX2gFVum4/2Oic3rNULkkRJVzrxvrVk
	 AeglrkNCCo5Womy993S9+W2pri7JZF7VBMHp6z9pBA5/DKLEGi4wqVBxhvRbram7GX
	 BQD+GizXJzQng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEAFF4485B;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Subject: [PATCH 00/23] dmaengine: Smart Data Accelerator Interface (SDXI)
 basic support
Date: Fri, 10 Apr 2026 08:07:10 -0500
Message-Id: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MQQrCMBBFr1JmbSSTGGJceQ9xkWZGm0Ub6JSgl
 NzdoBtXnwf/vR2E18wCl2GHlWuWXJYOeBggTXF5ssrUGYw2Tp/RKqFXVmMUVt6ST+FBiZ2H/p+
 ybGV9f1MV+9x+VtDuz6qotCJtTxjRBDPGa5zpmMoM99baBxF+B9CQAAAA
X-Change-ID: 20250813-sdxi-base-73d7c9fdce57
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=6024;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=9rBcO8VxjER3OnuYfoq9G9H5KIuoJGxGfKEMHDiZlyY=;
 b=gAwlqr9NKfu+gJarBGqfqo48zzVDQS3J4QnIesv9toDOQO891IMNga67nVexAyP4Pm4cjv4uW
 oxiFF3l5Vd7DriNYBpEMFpb7EjiywwC8C6tkz/ueyeKCXXbp7BcoEZv
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9956-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com]
X-Rspamd-Queue-Id: B76993D7EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Smart Data Accelerator Interface (SDXI) is a vendor-neutral
architecture for memory-to-memory data movement offload designed for
kernel bypass and virtualization.

General information on SDXI may be found at:
https://www.snia.org/sdxi

This submission adds a driver with basic support for PCIe-hosted SDXI
1.0 implementations and includes a DMA engine provider with memcpy
capability. A more limited RFC version was posted in September 2025;
the code has seen multiple substantial updates since then, described
below.

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
 drivers/dma/sdxi/completion.c       |  79 ++++++
 drivers/dma/sdxi/completion.h       |  24 ++
 drivers/dma/sdxi/context.c          | 504 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h          | 105 ++++++++
 drivers/dma/sdxi/descriptor.c       | 198 ++++++++++++++
 drivers/dma/sdxi/descriptor.h       | 135 ++++++++++
 drivers/dma/sdxi/descriptor_kunit.c | 484 ++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/device.c           | 333 ++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c              | 497 +++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h              |  12 +
 drivers/dma/sdxi/hw.h               | 254 ++++++++++++++++++
 drivers/dma/sdxi/mmio.h             |  57 ++++
 drivers/dma/sdxi/pci.c              | 120 +++++++++
 drivers/dma/sdxi/ring.c             | 158 +++++++++++
 drivers/dma/sdxi/ring.h             |  84 ++++++
 drivers/dma/sdxi/ring_kunit.c       | 105 ++++++++
 drivers/dma/sdxi/sdxi.h             | 149 +++++++++++
 include/linux/pci_ids.h             |   1 +
 24 files changed, 3347 insertions(+)
---
base-commit: c03d8b5462bcb0022f9477d09eb37dae66c3a769
change-id: 20250813-sdxi-base-73d7c9fdce57

Best regards,
--  
Nathan Lynch <nathan.lynch@amd.com>



