Return-Path: <dmaengine+bounces-8422-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE5RJ1hocGkVXwAAu9opvQ
	(envelope-from <dmaengine+bounces-8422-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 06:47:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4256151AC7
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 06:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B244C4A76B9
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786E425CEE;
	Wed, 21 Jan 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="COB+kgub"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62558425CE1
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974325; cv=none; b=GETb9TrsHsHbQyKnqbA1HGeNEGXIaHkWBi1ZP3BABEWc9bNWofgIeNC0Qzdc0x7NovdQ1kc7Isho42+nBafR9/RNOSMRpngbqLvng2YcewqrokXh6AmvCGqk3JQSW1lzM9vwqqMCoxw+nOFWPuTswrbGmjsMCdiOcVGDq8WsGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974325; c=relaxed/simple;
	bh=S0IsqQbqWFl7r11vg5R3y+KM33Z6zpECjWRO1jQGLf4=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=GODhN/Bz7kAYT0n434qt617lq+otMpxprhh1CFjXM9QCFJCERlQq90PTja/IM/RbU+41M/bnsEP6iraBeTfKbBPo7ghu+JnXhbVGU+2o12cVkt1EDOBBpDbnLz3jCxVSdJHGVbOh3FcA4oBsiCR+n4crdTqV/RZ/LsSmrB/zjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=COB+kgub; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=YHvH0nnzfp8ndeXNxuAVwy1cLnx4LDpmfadjcqUd1HY=; b=COB+kgubn5Jk5sHuuojYPi2Uoc
	BTnvvvUrtOeaCsOkgvodoQR4oaeZCe7qZj0K1BjzPKLeAx/z2BNDDu2ZD4NU9nm1XGghmp8d62c4U
	r/zw1ss6ckIc+nJ6Mb3fQo+li9AI8Nmz8pAyqbni5TrLmkbodEfHmrt0/8gp8nJVINB1O642NrGWA
	qUim+/F3jaR5w5WjNIcLxcmZzIiIlVTtTqlf4BHHd5eR9HD0wNh5NLbnNWRVAPxkP41FXnThw9mJu
	pwzWdmshqKZqbb+AqEA8HW2HPEQONAWUq2mwC9owZPk1fTfOXDLlzjlsKa50XUySkgI/1O8s2D88H
	qNK6tHWw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1viQW9-00000005tSB-29tx;
	Tue, 20 Jan 2026 22:12:35 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1viQVy-000000000dA-3GL5;
	Tue, 20 Jan 2026 22:12:22 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 20 Jan 2026 22:12:15 -0700
Message-ID: <20260121051219.2409-1-logang@deltatee.com>
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
Subject: [PATCH v13 0/3] Switchtec Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[deltatee.com,quarantine];
	TAGGED_FROM(0.00)[bounces-8422-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,infradead.org,wanadoo.fr,deltatee.com];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,deltatee.com:mid,deltatee.com:dkim]
X-Rspamd-Queue-Id: 4256151AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is v13 of the Switchtec Switch DMA Engine Driver.

The patchset has been rebased on v6.19-rc6.

We've addressed a number of issues pointed out by Vinod and Frank.
We continue to push back on processing completions from the hardware
in switchtec_dma_tx_status() seeing this is the only place to handle
the completions if interrupts are disabled. A comment was added to
the code to clarify this point.

Thanks,

Logan

--

v13 changes:
 - Rebase onto v6.19-rc6
 - Drop error check for dma_set_mask_and_coherent() as it is not
   required when all 64 bits are valid. (Per Frank)
 - Remove wmb() call before writew() as the barrier should be
   implied by the write. (Per Frank)

v12 changes:
 - Rebase onto v6.19-rc5
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
 drivers/dma/switchtec_dma.c | 1437 +++++++++++++++++++++++++++++++++++
 4 files changed, 1454 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c


base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.47.3


