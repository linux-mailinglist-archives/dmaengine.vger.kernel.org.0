Return-Path: <dmaengine+bounces-6961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB558BFFBEB
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D2919A210D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E082DEA78;
	Thu, 23 Oct 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ds3iu9Mi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993272E62A8
	for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206148; cv=none; b=fiu6putP/9CvzYzdjlcpeT2jcMWejvQmFni13/xEdpvtQlE6bX4Mjt0I2hcVnMp5m1ucLHIrdVGqPMmg3RwLwx1bg5NapcZaKBYzn+YV+0KVhykph9bLhhQTONTLkytkRdkJ4iawHy4tDuXyGsqk2oLsSIuP4KJhnvwUU/rLHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206148; c=relaxed/simple;
	bh=2mW2ufPwK26AhdRx9EYoLmILverODcdS8Sg1ER/tufo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOyY737s++9e8PkIrqhVtPod2Dge+VAw97QZ4QSQgqDHB4qeV6OCxBEbVr+UAa9hhtzmcm+uGaJqYVfnCWIpAq71F4wBSIPdo1eC0odmoXzwa/7GIH/nBfyyjbhpnYl+N8xDhyrAh+axRMJMe6ztEWbwJOfMEqpJ1NL30DZND2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ds3iu9Mi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47117f92e32so4079525e9.1
        for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761206144; x=1761810944; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP7Zvul1aJ+pzBJTLArL0ELIUpNFf5csxKan8A8VPjY=;
        b=ds3iu9MiwPN8FWrUAyOoTJAWq5Z3+cMg4KukmyjXLcQ1z2DYr1YYWunxfQuqGXEAvo
         loaHrqBDy2ZH7YlhZsClxrnLOT2Ixdiwg3EuilwcqJHiXbsz4chRbN4qOiJrFWnPjCCE
         glgL5OdYy0FPoHsgtmH18nKAKHr/xYjXGiGNdinca8fFvMPWniFuup13qlZOKnibplfn
         J2+si7gNzmW+U2dIb1n0wqnQqIJXuMFUqsgrp8kwz14DMgpPw6SJmhnqo4kI+f1Vrzsq
         a9AwCy/uiuZaGfPVPgin90hHzOXJ1FcZvAdWZbCrlg92m2kucqSygBzaIu6FuMk/t6p+
         oaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206144; x=1761810944;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP7Zvul1aJ+pzBJTLArL0ELIUpNFf5csxKan8A8VPjY=;
        b=QHvPh0OBLZ43Sb89/l3fwiwGn+93SjeCcDualejavmkaRVQEh2mfjq2sDVmx7wKlXb
         q0t4lW3C3hB0SYgtLtIQ24N5f7kU3uVAehupVHrlDC6UM7TG6Gw/jjxptXPLTpXbQsuk
         BI/bVcWXMTJ6qO7EHvxcRi/KclWsPkMY2kXeSz+Uua3Zn/CBes8by/+btmm8/DNmO67V
         +h2xqSODU6vXelkodkJdkVPAi2w1Vj+oqteHqmPQQsL+8bW/NZqP3VFDPVJMvQjbAlxM
         E78aSkmSGZKaRQv2PZ5alvraAicSim2J7bgE3lQ+WUMTFjQf8wdcX41fegXnirwHVkuX
         ZSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqhteP5iBYcJt7LRhl/f/OQ+GiAwLe9S001Bc7vpJMkCnrVtdULkz0e7JwMfqYvroSisbtqULKG7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhCnO5Ie1SEHWsA+Zw8BqFvZSbK6F5lZoyjwi8ZWRTWfUmQ/x
	J/xvNzZjQw790vYoOfUXY6U8xTWAzhwFH7uZW8wH0NQd6ctvPZjDpaDCkSvuhX5eLzY=
X-Gm-Gg: ASbGncvCD6dLFpk0BzWyvgAggN6sUodMKf5KOVMil1kCkRpaF/lVu3t7JkqBKC4Y6Oh
	/II6J/uxcc/Xj4dQGUTZeO8TH7wQNq40a0tWjP4e3tQ+T1N+V21PtfTmzseVTJ/YuomX0OTbwvg
	vO0bRDv7rmWpVt97oQwTLRLVM9xS87wQbyC180MniNrEzmdXibJIsdKn+bBGHut2WvivRFbCI3m
	OXCOYY69bjsmT5jJUFk1a8NTTMgb7GyLeCdoyZ2dB2TtAaeFiaJc/KcaUCvHtDid5wsFFLHOJT3
	opqqHKyoWejWYjbbo1VOV2sWsLyucoYc0UmKS+pTwj5bhtbjSxPoR4cEFY8k8J/EdWe6q5ZGiQc
	g7XaLaSdI86SKpxEjEoNF78JwZvN4ELC7CSo1SmNiNPimo5yFhG54jm0WIx2WXDZzL0TSYpFuGT
	hqC9GcnA2G
X-Google-Smtp-Source: AGHT+IHfejwjiA0rmTrIPIQL9pQttVcomeiavvXgPCYnLp3S1n4oYYBb/LewOnrxM9mg10WKWzhDig==
X-Received: by 2002:a05:600c:3e07:b0:471:13fc:e356 with SMTP id 5b1f17b1804b1-471178760f8mr174411675e9.3.1761206143582;
        Thu, 23 Oct 2025 00:55:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6aef:b8f:aa92:c859])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c4342946sm81833535e9.10.2025.10.23.00.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:55:43 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  dmaengine@vger.kernel.org,  linux-kernel@vger.kernel.org,
  mani@kernel.org,  kwilczynski@kernel.org,  kishon@kernel.org,
  bhelgaas@google.com,  corbet@lwn.net,  vkoul@kernel.org,
  jdmason@kudzu.us,  dave.jiang@intel.com,  allenbh@gmail.com,
  Basavaraj.Natikar@amd.com,  Shyam-sundar.S-k@amd.com,
  kurt.schwemmer@microsemi.com,  logang@deltatee.com,
  jingoohan1@gmail.com,  lpieralisi@kernel.org,  robh@kernel.org,
  Frank.Li@nxp.com,  fancer.lancer@gmail.com,  arnd@arndb.de,
  pstanner@redhat.com,  elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp> (Koichiro Den's
	message of "Thu, 23 Oct 2025 16:18:51 +0900")
References: <20251023071916.901355-1-den@valinux.co.jp>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 23 Oct 2025 09:55:42 +0200
Message-ID: <1jqzuu2gsh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 23 Oct 2025 at 16:18, Koichiro Den <den@valinux.co.jp> wrote:

> Hi all,
>
> Motivation
> ==========
>
> On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> (EP) is not possible even if we would add implementation to create a MSI
> domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> traffic must fall back to doorbells (polling). In addition, BAR resources
> are scarce, which makes it difficult to dedicate a BAR solely to an
> NTB/msi window.
>
> This RFC introduces a generic interrupt backend for NTB. The existing MSI
> path is converted to a backend, and a new DW eDMA test-interrupt backend
> provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> The vNTB EPF and ntb_transport are taught about offsets.
>
> Backend selection is automatic: if MSI is available we use the MSI backend.
> Otherwise, if enabled, the DW eDMA backend is used. If neither is
> available, we continue to use doorbells. Existing systems remain unaffected
> unless use_intr=1 is set.
>
> Example layout (R-Car S4):
>
>   BAR0: Config/Spad
>   BAR2 [0x00000-0xF0000]: MW1 (data)
>   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
>   BAR4: Doorbell

Have you considered putting the doorbell in BAR0 along Config/SPAD
instead ? Doorbells already have an offset in the config and it would
allow the following setup

BAR0 : Config/Spad/Doorbell
BAR2 : MW1
BAR4 : MW2

If MW2 handle the IRQs, I suppose the size requirement is rather
limited so it should fit ?

The modification to allow this setup is minimal and you would not need
all the offset related changes below ... This is something I
was experimenting on. I can share that if you are interested.

>
>   # The corresponding configfs settings (see Patch #25):
>   echo 0xF0000 > ./mw1
>   echo 0x8000  > ./mw2
>   echo 0xF0000 > ./mw2_offset
>   echo 2       > ./mw1_bar
>   echo 2       > ./mw2_bar
>
> Summary of changes
> ==================
>
> * NTB core/transport
>   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
>   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
>   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
>   - Support offsetted partial MWs in ntb_transport.
>   - Hardening for peer-reported interrupt values and minor cleanups.
>
> * PCI Endpoint core and DWC EP controller
>   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
>   - Implement inbound mapping for DesignWare EP (Address Match mode), with
>     tracking of multiple inbound iATU entries per BAR and proper teardown.
>
> * EPF vNTB
>   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.

... then you would not need this with and it would remove significant
part of the necessary changes below

>   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
>     set_bar().
>   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
>
> * DW eDMA
>   - Add self-interrupt registration and expose test-IRQ register offsets.
>   - Provide dw_edma_find_by_child().
>
> * Renesas R-Car
>   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
>
> * Documentation
>
> Patch layout
> ============
>
> * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> * Patch 25      : Documentation updates
>
> Tested on
> =========
>
> * Renesas R-Car S4 Spider
> * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
>
> Performance measurement
> =======================
>
> Even without the DMA acceleration patches for R-Car S4 (which I keep
> separate from this RFC patch series), enabling RC-to-EP interrupts
> dramatically improves NTB latency on R-Car S4:
>
> * Before this patch series (NB. use_msi doesn't work on R-Car S4)
>
>   # Server: sockperf server -i 0.0.0.0
>   # Client: sockperf ping-pong -i $SERVER_IP
>   ========= Printing statistics for Server No: 0
>   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
>   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
>         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
>   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
>   Summary: Latency is 5995.680 usec
>   Total 45 observations; each percentile contains 0.45 observations
>   ---> <MAX> observation = 6121.137
>   ---> percentile 99.999 = 6121.137
>   ---> percentile 99.990 = 6121.137
>   ---> percentile 99.900 = 6121.137
>   ---> percentile 99.000 = 6121.137
>   ---> percentile 90.000 = 6099.178
>   ---> percentile 75.000 = 6054.418
>   ---> percentile 50.000 = 5993.040
>   ---> percentile 25.000 = 5935.021
>   ---> <MIN> observation = 5883.362
>
> * With this series (use_intr=1)
>
>   # Server: sockperf server -i 0.0.0.0
>   # Client: sockperf ping-pong -i $SERVER_IP
>   ========= Printing statistics for Server No: 0
>   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
>   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
>         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
>   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
>   Summary: Latency is 127.677 usec
>   Total 2145 observations; each percentile contains 21.45 observations
>   ---> <MAX> observation =  446.691
>   ---> percentile 99.999 =  446.691
>   ---> percentile 99.990 =  446.691
>   ---> percentile 99.900 =  291.234
>   ---> percentile 99.000 =  221.515
>   ---> percentile 90.000 =  149.277
>   ---> percentile 75.000 =  124.497
>   ---> percentile 50.000 =  121.137
>   ---> percentile 25.000 =  119.037
>   ---> <MIN> observation =  113.637
>
> Feedback welcome on both the approach and the splitting/routing preference.
>
> (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> later if preferred.)
>
> Thanks for reviewing.
>
>
> Koichiro Den (25):
>   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
>     access
>   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
>   NTB: epf: Handle mwN_offset for inbound MW regions
>   PCI: endpoint: Add inbound mapping ops to EPC core
>   PCI: dwc: ep: Implement EPC inbound mapping support
>   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
>   NTB: Add offset parameter to MW translation APIs
>   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
>     present
>   NTB: ntb_transport: Support offsetted partial memory windows
>   NTB/msi: Support offsetted partial memory window for MSI
>   NTB/msi: Do not force MW to its maximum possible size
>   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
>   NTB/msi: Skip mw_set_trans() if already configured
>   NTB/msi: Add a inner loop for PCI-MSI cases
>   dmaengine: dw-edma: Add self-interrupt registration API
>   dmaengine: dw-edma: Expose self-IRQ register offsets
>   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
>   NTB: core: Add .get_pci_epc() to ntb_dev_ops
>   NTB: epf: vntb: Implement .get_pci_epc() callback
>   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
>   NTB: Introduce generic interrupt backend abstraction and convert MSI
>   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
>   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
>   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
>   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
>     usage
>
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
>  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
>  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
>  drivers/ntb/Kconfig                           |  15 ++
>  drivers/ntb/Makefile                          |   6 +-
>  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
>  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
>  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
>  drivers/ntb/intr_common.c                     |  61 +++++
>  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
>  drivers/ntb/msi.c                             | 186 +++++++------
>  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
>  drivers/ntb/test/ntb_msi_test.c               |  26 +-
>  drivers/ntb/test/ntb_perf.c                   |   4 +-
>  drivers/ntb/test/ntb_tool.c                   |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
>  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
>  include/linux/dma/edma.h                      |  31 +++
>  include/linux/ntb.h                           | 134 +++++++---
>  include/linux/pci-epc.h                       |  11 +
>  29 files changed, 1310 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/ntb/intr_common.c
>  create mode 100644 drivers/ntb/intr_dw_edma.c

-- 
Jerome

