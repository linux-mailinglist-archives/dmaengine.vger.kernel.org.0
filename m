Return-Path: <dmaengine+bounces-8219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0204D14CA4
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 19:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80383300658F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83237F8A0;
	Mon, 12 Jan 2026 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="DNZuQ8No"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0182319851
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243252; cv=none; b=ju2Wz2LZyp+KpL9KLrJOmylK6PtgtkSZndwF2K3qcY5Ep0Y0BJbhhgVMtrBtfS5RmVjXWC3nPqwPUAEEaeZviiymfii+0cn1/LPOt8XTTpYxt0T6E9VO5xJ0GtSdcmzXHVZMp+jCtnZZTwOH8gK7gzsPVvhYRcT1V/Mh5qp6H1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243252; c=relaxed/simple;
	bh=QrUMZoTWlc1sHw5vPybylB3GDswvsr2UmP4WGQOg928=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=Ved1Lof+oTLqwdFaT8bBq1OlM0McYvv8m/Plx8XaUWUe11v6nRBRpWIn8/sEz9L9Gz18S98vBCJhQ9H5K0+Byak9rPE5MCTtkGZmyOl+n4PX6XmSX3Q1hia5+yLLINVvMxpeyeQvgxJCMHKb4vRfqcicvo8QcRb8gSuhttcAtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=DNZuQ8No; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=Q3OYtlQELgJ3ANis6ZNJK9/e+F9RgIJ/MJ69Ab3QXXI=; b=DNZuQ8NoAdmKYzBoyk/nhY/LIE
	eOBe2I9B2clSuSPkyfNFSluY+16abx4F2t7O+FaCzkxUYfX96mQti7BrejbYKRzULESk81aoGPO7C
	62FKxzTIush+B6ZPtr3k4cDaQovfvQsUEymnYHALGRZqhsv04SFXIudDYWN4Lh+cvPAwjt8A95VQ1
	mtDOr0+gBPdNwPwaUfHTHfudFJRHerafk/IJNhAR8au0pNuljrwNh1v5FKpRxqnrqddH0UiIpxu4t
	pRFx31gvS56uGA1L+jpk3eTwwxpx1kPu2T3foThUWZjN6XVFkhHa15ciBRSbzOf/8lkzV3pLs1N1q
	ezdQCT/A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vfMqI-000000001Dd-0hG3;
	Mon, 12 Jan 2026 11:40:44 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vfMq1-000000000gG-36Hq;
	Mon, 12 Jan 2026 11:40:25 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 12 Jan 2026 11:40:14 -0700
Message-ID: <20260112184017.2601-1-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v12 0/3] Switchtec Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

This is v12 of the Switchtec Switch DMA Engine Driver.

The patchset has been rebased on v6.19-rc5.

We've addressed a number of issues pointed out by Vinod and continued
to push back on processing completions from the hardware in
switchtec_dma_tx_status() seeing this is the only place to handle
the completions if interrupts are disabled. A comment was added to
the code to clarify this point.

Thanks,

Logan

--

v12 changes:
 - Drop some unecessary info messages and convert some others to debug
   messages (per Vinod)
 - Drop the MODULE_VERSION tag (per Vinod)
 - Move the enum chan_op definition up (per Vinod)
 - Change desc_ring to be part of the switchtec_dma_chan structure
   instead of its own allocation (per Vinod)
 - Move the increment of the head pointer out of switchtec_dma_prep_desc()
   and into switchtec_dma_tx_submit() (per Vinod)
 - Added a comment to switchtec_dma_tx_status() to justify calling
   switchtec_dma_cleanup_completed() in that function.

v11 changes:
 - Rebased onto v6.19-rc1

v10 changes:
 - Rebased onto v6.18-rc1
 - Some systems were seeing the warning message: "WARN: Device release
   is not defined so it is not safe to unbind this driver while in use"
   Adjusted the copy_align parameter to align to 8 bytes to fix this
   issue.

v9 changes:
 - Rebase onto v6.17-rc2
 - Fix multiple RCU derference warnings
 - Fix the spinlocks being used before they were initialized causing
   an INFO message when built with lockdep enabled. (noticed by Maciej
   Grochowski)
 - Add additional entries to the PCI table which use an EFAR vendor ID.
 - Remove some enums that were not used by the code
 - Update copyright date to 2025 (as requested by Vinod)
 - Drop the default values enum and just set the defaults
   directly. (to address some confusing code noticed by Vinod)
 - Use GENMASK and FIELD_GET/PREP macros instead of direct bit
   operations (suggested by Vinod)
 - Use lower case hex numbers (requested by Vinod)
 - Don't mangle the return value of readl_poll_timeout_atomic()
   and return it's error directly (per Vinod)
 - Split the patch into a couple patches (per Vinod)
 - Fix some missing new line characters on numerous printks
 - Rename switchtec_dma_process_desc() function to
   switchtec_dma_cleanup_completed() for clarity.
 - Open code a few short, unnecessary, helper functions.
 - Drop the tasklet used for the chan_status interrupt. It is only
   really used when the device is paused so performance is not
   critical and thus it can be a threaded interrupt instead of
   a tasklet.
 - Fixed an uninitialized symbol ('i') error (caught by Dan Carpenter)

v8 changes:
 - Rebase onto kernel 6.8
 - Add Gen5 device IDs

v7 changes:
 - Remove implementation of device_prep_dma_imm_data

v6 changes:
 - Fix './scripts/checkpatch.pl --strict' warnings
 - Use readl_poll_timeout_atomic for status checking with timeout
 - Wrap enable_channel/disable_channel over channel_op
 - Use flag GFP_NOWAIT for mem allocation in switchtec_dma_alloc_desc
 - Use proper comment for macro SWITCHTEC_DMA_DEVICE

v5 changes:
 - Remove unnecessary structure modifier '__packed'
 - Remove the use of union of identical data types in a structure
 - Remove unnecessary call sites of synchronize_irq
 - Remove unnecessary rcu lock for pdev during device initialization
 - Use pci_request_irq/pci_free_irq to replace request_irq/free_irq
 - Add mailing list info in file MAINTAINERS
 - Miscellaneous cleanups

v4 changes:
 - Sort driver entry in drivers/dma/Kconfig and drivers/dma/Makefile
   alphabetically
 - Fix miscellaneous style issues
 - Correct year in copyright
 - Add function and call sites to flush PCIe MMIO Write
 - Add a helper to wait for status register update
 - Move synchronize_irq out of RCU critical section
 - Remove unnecessary endianness conversion for register access
 - Remove some unused code
 - Use pci_enable_device/pci_request_mem_regions instead of
   pcim_enable_device/pcim_iomap_regions to make the resource lifetime
   management more understandable
 - Use offset macros instead of memory mapped structures when accessing
   some registers
 - Remove the attempt to set DMA mask with smaller number as it would
   never succeed if the first attempt with bigger number fails
 - Use PCI_VENDOR_ID_MICROSEMI in include/linux/pci_ids.h as device ID

v3 changes:
 - Remove some unnecessary memory/variable zeroing

v2 changes:
 - Move put_device(dma_dev->dev) before kfree(swdma_dev) as dma_dev is
   part of swdma_dev.
 - Convert dev_ print calls to pci_ print calls to make the use of
   print functions consistent within switchtec_dma_create().
 - Remove some dev_ print calls, which use device pointer as handles,
   to ensure there's no reference issue when the device is unbound.
 - Remove unused .driver_data from pci_device_id structure.

v1:
  The following patch implements a DMAEngine driver to use the DMA
  controller in Switchtec PSX/PFX switchtes. The DMA controller
  appears as a PCI function on the switch upstream port. The DMA
  function can include one or more DMA channels.
 Switchtec Switch DMA Engine Driver

This is v9 of the Switchtec Switch DMA Engine Driver. It's been over a
year since the last posting, appologies for that. Kelvin has asked
me to take over getting the work upstream.

I reviewed the feedback and addressed most of it in this posting. I've
also caught additional issues during my testing.

The remaining disagreement is on how the completions are cleaned up. I
maintain[1] that it's best to clean them up in the status() call back
in addition to the interrupt as this allows for transfers that don't
use interrupts. Vinod has argued that this is wrong and the other
drivers that do this should be changed as well (IOAT and PLX). In this
poisting, I have left it the original way with cleanups in the status()
call back.

This patch set is based on v6.17-rc2.

Thanks,

Logan

[1] https://lore.kernel.org/r/e759d483-e303-421a-b674-72fd9121750d@deltatee.com

--

v9 changes:
 - Rebase onto v6.17-rc2
 - Fix multiple RCU derference warnings
 - Fix the spinlocks being used before they were initialized causing
   an INFO message when built with lockdep enabled. (noticed by Maciej
   Grochowski)
 - Add additional entries to the PCI table which use an EFAR vendor ID.
 - Remove some enums that were not used by the code
 - Update copyright date to 2025 (as requested by Vinod)
 - Drop the default values enum and just set the defaults
   directly. (to address some confusing code noticed by Vinod)
 - Use GENMASK and FIELD_GET/PREP macros instead of direct bit
   operations (suggested by Vinod)
 - Use lower case hex numbers (requested by Vinod)
 - Don't mangle the return value of readl_poll_timeout_atomic()
   and return it's error directly (per Vinod)
 - Split the patch into a couple patches (per Vinod)
 - Fix some missing new line characters on numerous printks
 - Rename switchtec_dma_process_desc() function to
   switchtec_dma_cleanup_completed() for clarity.
 - Open code a few short, unnecessary, helper functions.
 - Drop the tasklet used for the chan_status interrupt. It is only
   really used when the device is paused so performance is not
   critical and thus it can be a threaded interrupt instead of
   a tasklet.
 - Fixed an uninitialized symbol ('i') error (caught by Dan Carpenter)

v8 changes:
 - Rebase onto kernel 6.8
 - Add Gen5 device IDs

v7 changes:
 - Remove implementation of device_prep_dma_imm_data

v6 changes:
 - Fix './scripts/checkpatch.pl --strict' warnings
 - Use readl_poll_timeout_atomic for status checking with timeout
 - Wrap enable_channel/disable_channel over channel_op
 - Use flag GFP_NOWAIT for mem allocation in switchtec_dma_alloc_desc
 - Use proper comment for macro SWITCHTEC_DMA_DEVICE

v5 changes:
 - Remove unnecessary structure modifier '__packed'
 - Remove the use of union of identical data types in a structure
 - Remove unnecessary call sites of synchronize_irq
 - Remove unnecessary rcu lock for pdev during device initialization
 - Use pci_request_irq/pci_free_irq to replace request_irq/free_irq
 - Add mailing list info in file MAINTAINERS
 - Miscellaneous cleanups

v4 changes:
 - Sort driver entry in drivers/dma/Kconfig and drivers/dma/Makefile
   alphabetically
 - Fix miscellaneous style issues
 - Correct year in copyright
 - Add function and call sites to flush PCIe MMIO Write
 - Add a helper to wait for status register update
 - Move synchronize_irq out of RCU critical section
 - Remove unnecessary endianness conversion for register access
 - Remove some unused code
 - Use pci_enable_device/pci_request_mem_regions instead of
   pcim_enable_device/pcim_iomap_regions to make the resource lifetime
   management more understandable
 - Use offset macros instead of memory mapped structures when accessing
   some registers
 - Remove the attempt to set DMA mask with smaller number as it would
   never succeed if the first attempt with bigger number fails
 - Use PCI_VENDOR_ID_MICROSEMI in include/linux/pci_ids.h as device ID

v3 changes:
 - Remove some unnecessary memory/variable zeroing

v2 changes:
 - Move put_device(dma_dev->dev) before kfree(swdma_dev) as dma_dev is
   part of swdma_dev.
 - Convert dev_ print calls to pci_ print calls to make the use of
   print functions consistent within switchtec_dma_create().
 - Remove some dev_ print calls, which use device pointer as handles,
   to ensure there's no reference issue when the device is unbound.
 - Remove unused .driver_data from pci_device_id structure.

v1:
  The following patch implements a DMAEngine driver to use the DMA
  controller in Switchtec PSX/PFX switchtes. The DMA controller
  appears as a PCI function on the switch upstream port. The DMA
  function can include one or more DMA channels.

Kelvin Cao (3):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton
  dmaengine: switchtec-dma: Implement hardware initialization and
    cleanup
  dmaengine: switchtec-dma: Implement descriptor submission

 MAINTAINERS                 |    7 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1445 +++++++++++++++++++++++++++++++++++
 4 files changed, 1462 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.47.3


