Return-Path: <dmaengine+bounces-1422-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD087EF4C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBE1C222FA
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599055C34;
	Mon, 18 Mar 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wBboJq0u"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C455C2B;
	Mon, 18 Mar 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784583; cv=none; b=MxbUR9rcEjRkv8Iy9+04NehGTZU2KDuHIc3V0pbFHR0hEuJ1kmnP9hSMfaSRBtjAywxAAFlHFmpzb41z/fhdkW9KWNzWn8pvvdlpxocMcynEwcCmu3LEO2zNC8T9C6SZaGJS0t13nTkPIOanT6ZlCShTl2pmgS3UzVvb6Pc5zI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784583; c=relaxed/simple;
	bh=9gjkxijxpavPBjT+YAINHA1vIXHl9kXRXGA9e4hXPOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZQxVREwdwaH6EQ+f25llxJFPwkjgJuxa71QfVVo6OmI6k47ZBXiAZuJgsV2ZLaTrBK5+xa/LLe0nO/1WR7tYXD9Z7Zc8HoULoEs+aNmmChZjc+hmPYIh1uggme5ZlGDwhe/3qXi6ELH//yMB4q+hM5OvkmsclFuKOpwm2ykaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wBboJq0u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710784581; x=1742320581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9gjkxijxpavPBjT+YAINHA1vIXHl9kXRXGA9e4hXPOg=;
  b=wBboJq0uS4JkndIvV45N//JT/OkoPK+oRKZxEhnp/paGeRKq2FkaJAgx
   Gx72wWPqNtch91Z7JJ33ojh10O0jpYJGvQJbRD/MWsrKdts1w5f3+8n6K
   iLX1qDNC9SlmsaASimFOB/t4hkYU7UE/KjzfvvvuaMIXpZ//hKXMIxkUp
   YJwM9jlqXs0Rd8cPkylxcjJnSIzNqymIkbkkQGtiElDd/rw7Gh7S0wpIx
   b6Z98nb5vZktzmCotF9K7SFoYsdLMbIChgkYMBwdteQpP61zkawrJ9wPy
   1+tdZtQZWgaqceAZW5veaeCmv+uas5+g3npcv7DM+HCqcJT/OEx+jH8Bp
   g==;
X-CSE-ConnectionGUID: 4vmFKSkTSKazXyGlRjISMg==
X-CSE-MsgGUID: 8CuTW6MIRk+GSYMwJcVhAA==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; 
   d="scan'208";a="185071343"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 10:56:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 10:55:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 18 Mar 2024 10:55:54 -0700
From: Kelvin Cao <kelvin.cao@microchip.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <logang@deltatee.com>, <George.Ge@microchip.com>,
	<christophe.jaillet@wanadoo.fr>, <hch@infradead.org>
Subject: [PATCH v8 0/1] Switchtec Switch DMA Engine Driver
Date: Mon, 18 Mar 2024 09:33:12 -0700
Message-ID: <20240318163313.236948-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi,
 
This is v8 of the Switchtec Switch DMA Engine Driver, incorporating
changes for the v2/v3/v4/v5/v6 review comments. This version is same as
v7 except some newly added Gen5 device IDs.

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
controller in Switchtec PSX/PFX switchtes. The DMA controller appears as
a PCI function on the switch upstream port. The DMA function can include
one or more DMA channels.
 
This patchset is based off of 6.8.

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    6 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1546 +++++++++++++++++++++++++++++++++++
 4 files changed, 1562 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1


