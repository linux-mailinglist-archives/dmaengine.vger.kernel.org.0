Return-Path: <dmaengine+bounces-6066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8DB2C910
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640EB3B876C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF9253B40;
	Tue, 19 Aug 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="g6JhsmcD"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BE10F1
	for <dmaengine@vger.kernel.org>; Tue, 19 Aug 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619526; cv=none; b=cN8iyFeSL5XIG7R5uc5pqWkiEjihGYaiitPP/IrVHIn8HJjy67Vl8aYlNYU8aApwyxk+Rxlgi3FbPp+30ED6LJwx5jCVX9gL4eAlehZY0BqcEI2PTPk757ZqUTMgbsJc0FoNQ/ZuQ6L/crDtEzfFa08USQzNpIDoMpB6n+bdPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619526; c=relaxed/simple;
	bh=QahQIHEfZVjBZ0lZwIN+6CbEB/uXkn8Qmq3Gmb4z2x0=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=ms62HsfN7hrtHiP7c4qKwg9U0SM9Rcdl4PeMn++HX+w1nxRz1wbAoR6K0+Pnpintp4ZDkkGTqG482nCq76yvBM/23oioM8ngbjXOxKG7j1zMi/1zwR44FATWftHs9cYT/sExy0TVPE9dhXhmfac7KPw0UChycdZl0vRIg2kx860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=g6JhsmcD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=vtjxIj/VREXF2FIfsBOX48lwUope8c1U5ScON8PS+m4=; b=g6JhsmcDplkjFTnCCtwbzAvbB4
	+mye5jqQmSrvkcIP8B+Be+AX1JFpCSdri/Qd0IDTBa/MB8DtzVGeZkqjl1H223ufrC7a8VGFG+/Xt
	v/Kb7p81HK8pAycNQr6/MS1MzjzX4YdgWAx6Wq4DBQDccWkB3xFwI6mlG/cMFzNM3c1z3JIhekM+s
	P2HVEkocAny2Mq8LzBZO4MKz55oQl//K9gjjbg0e4JCL7/TP9uqx7tlAlyWxnmaZpoiSk0trPnfeM
	v+ByizjeD2pprMpWYNN6HngwkuGG/+c9RzfGOhjgFAP52NvHwijGOM8Lq6L/n5jhBoXjEg1LqxzSC
	o7WufamA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gunthorp@deltatee.com>)
	id 1uoOpr-000oE1-1E;
	Tue, 19 Aug 2025 10:05:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.96)
	(envelope-from <gunthorp@deltatee.com>)
	id 1uoOpe-0001nS-1w;
	Tue, 19 Aug 2025 10:05:06 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 19 Aug 2025 10:05:00 -0600
Message-Id: <20250819160503.6890-1-logang@deltatee.com>
X-Mailer: git-send-email 2.39.5
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
Subject: [PATCH v9 0/3] Switchtec Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

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

--

Kelvin Cao (3):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton
  dmaengine: switchtec-dma: Implement hardware initialization and
    cleanup
  dmaengine: switchtec-dma: Implement descriptor submission

 MAINTAINERS                 |    7 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1456 +++++++++++++++++++++++++++++++++++
 4 files changed, 1473 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
--
2.39.5

