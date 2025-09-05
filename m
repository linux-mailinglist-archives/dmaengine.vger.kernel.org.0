Return-Path: <dmaengine+bounces-6407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E717B4629A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA4DA61B70
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F5272811;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXwKfgA/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BA266591;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098130; cv=none; b=CpPYenHHGddDbv2MhPzkz4Gqqw1Gu6pEqFc4u5UrA/v6BLuGyLWSdN46fFVqIqMaSjyE9qGeB4Vah2DW7pyqfJhUgs9tWOQtx7MOwwe4TzULCySKH5Wex4cb8sDPGAPqsgEEQl4+u8RaOBoYvvRtkTdNWA9wEj2AFY7c+qXnObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098130; c=relaxed/simple;
	bh=EtS18cPQp642F259+o2Fz/jfh1Vgpj1ASix6SL/Hf28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CqdOQTnUN2zdSwDW3g4nxwSviKRJTAWixDGBcJ9af04BUuZmX1pBbLaaHez9H6OnvydrmCMxpPv2Zl1atL9UxZ+YER8fX9JffgrA4MQy2n4NV+09+fkSdpQ5H4e7u67qhVh+AMjvCwzE2n6f35kUjRRLFSOAApHrhFx+CJhXgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXwKfgA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 605D9C4CEF1;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=EtS18cPQp642F259+o2Fz/jfh1Vgpj1ASix6SL/Hf28=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aXwKfgA/p0TtSF4n77I4NILylEp16UkFqn2dcqy/20A8CQP5FEzVhxFQd1XdOHHUG
	 rTK9IggWfLA8sW44H8gVZk9HWPSp/o5F0g6ueNvI+adG9filDYXH8e0W3ZstYWN8mo
	 r9yktzpviMRU5XbqGhX1fRbYhL33zmCWRfr1dQSG3f3wPCiL9ygCCjbUOjMthMU51J
	 ql/HagW33oO+pBvge1ir1FI8ROi+NOd2uBr2Txtd8HgkGCOw2SrJEnP+53twaweQEU
	 OxXyz7QCf9wyusVS1et0YJwxltyeehSII5PA5CGMQvk6Fe9ek2MsFAiG0oSLB8REEJ
	 gOwjT7FQkr6cg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A5CA1010;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Subject: [PATCH RFC 00/13] dmaengine: Smart Data Accelerator Interface
 (SDXI) basic support
Date: Fri, 05 Sep 2025 13:48:23 -0500
Message-Id: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcwu2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3eKUikzdpMTiVF1z4xTzZMu0lORUU3MloPqCotS0zAqwWdFKQW7
 OSrG1tQB2/4WQYAAAAA==
X-Change-ID: 20250813-sdxi-base-73d7c9fdce57
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=3884;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=EtS18cPQp642F259+o2Fz/jfh1Vgpj1ASix6SL/Hf28=;
 b=iVkDOOyZdiEyU2gtuQtkxNnaJPuHOvBGX1zqikp6ZyoWp8HWIlxFBzj0d+MNk9wJO0e8rHN7r
 b80J+I2ExHOC0FbEjtzsezbZLs2MRqVZlpdAAD24jqUeCYTnvNHjvGE
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

The Smart Data Accelerator Interface (SDXI) is a vendor-neutral
architecture for memory-to-memory data movement offload designed for
kernel bypass and virtualization.

General information on SDXI may be found at:
https://www.snia.org/sdxi

This submission adds a driver with basic support for PCIe-hosted SDXI 1.0
implementations and includes a DMA engine provider.

It is very much a work in progress. Among other issues, the DMA
provider code only supports single-threaded polled mode, and context
management should use better data structures.

While we're addressing those shortcomings, we'd appreciate any
feedback on:

* Where the code should live. SDXI entails a fair amount of code for
  context and descriptor management, and we expect to eventually add a
  character device ABI for user space access. Should all of this go in
  drivers/dma/sdxi?

* Whether the DMA engine provider should use virt-dma/vchan. SDXI
  submission queues can be almost arbitrarily large, and I'm not sure
  putting a software queue in front of that makes sense.

Planned future SDXI work (out of scope for this series):

* Character device for user space access. We are evaluating the uacce
  framework for this.

* Support for operation types to be added in future SDXI revisions.

* Greater configurability for control structures, e.g. descriptor ring
  size.

The latest released version of the SDXI specification is 1.0:
https://www.snia.org/sites/default/files/technical-work/sdxi/release/SNIA-SDXI-Specification-v1.0a.pdf

Draft versions of future SDXI specifications in development may be found at:
https://www.snia.org/tech_activities/publicreview#sdxi

---
Nathan Lynch (13):
      PCI: Add SNIA SDXI accelerator sub-class
      dmaengine: sdxi: Add control structure definitions
      dmaengine: sdxi: Add descriptor encoding and unit tests
      dmaengine: sdxi: Add MMIO register definitions
      dmaengine: sdxi: Add software data structures
      dmaengine: sdxi: Add error reporting support
      dmaengine: sdxi: Import descriptor enqueue code from spec
      dmaengine: sdxi: Context creation/removal, descriptor submission
      dmaengine: sdxi: Add core device management code
      dmaengine: sdxi: Add PCI driver support
      dmaengine: sdxi: Add DMA engine provider
      dmaengine: sdxi: Add Kconfig and Makefile
      MAINTAINERS: Add entry for SDXI driver

 MAINTAINERS                         |   7 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/sdxi/.kunitconfig       |   4 +
 drivers/dma/sdxi/Kconfig            |  23 ++
 drivers/dma/sdxi/Makefile           |  17 ++
 drivers/dma/sdxi/context.c          | 547 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h          |  28 ++
 drivers/dma/sdxi/descriptor.c       | 197 +++++++++++++
 drivers/dma/sdxi/descriptor.h       | 107 +++++++
 drivers/dma/sdxi/descriptor_kunit.c | 181 ++++++++++++
 drivers/dma/sdxi/device.c           | 401 ++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c              | 409 +++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h              |  12 +
 drivers/dma/sdxi/enqueue.c          | 136 +++++++++
 drivers/dma/sdxi/enqueue.h          |  16 ++
 drivers/dma/sdxi/error.c            | 340 ++++++++++++++++++++++
 drivers/dma/sdxi/error.h            |  16 ++
 drivers/dma/sdxi/hw.h               | 249 ++++++++++++++++
 drivers/dma/sdxi/mmio.h             |  92 ++++++
 drivers/dma/sdxi/pci.c              | 216 ++++++++++++++
 drivers/dma/sdxi/sdxi.h             | 206 ++++++++++++++
 include/linux/pci_ids.h             |   1 +
 23 files changed, 3208 insertions(+)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250813-sdxi-base-73d7c9fdce57

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



