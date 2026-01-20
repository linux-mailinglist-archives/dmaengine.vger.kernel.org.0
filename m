Return-Path: <dmaengine+bounces-8408-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNFoIx/Zb2n8RwAAu9opvQ
	(envelope-from <dmaengine+bounces-8408-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 20:35:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5424A8CC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 20:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 450F9849721
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE00466B6A;
	Tue, 20 Jan 2026 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggEuowbt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1594611C5;
	Tue, 20 Jan 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934863; cv=none; b=G91CuxVWOnfo4n0ew5MygrbMOeQI3XU+/CSPtxt+LL0dnu/rKQrA/McNZ5+6ah+L9WY/BDfxhc6fjV9th/VOnxmFx+cxkd2s4lEUpy3P3awGOWTlzoD871YAClwl6E1riONMc8uS5SPO4z+QdLG9QIAqOxUz4bMdQm0e9RZIEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934863; c=relaxed/simple;
	bh=t0ZuMZsLLfJmBJE3WheVrPlJHvgNs3Tn82FtuhGfj0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EMLmxf08QSY48d1SoqAeEP1wH+kkxKzK2qTv82SFWj7Wppe/dj1m17ygTAdG8IYrblIV1iHKAQ1OLaIuHvWe0MABw1tiM3pSqVm8hkLWEi9eBWeds1Bg0gUM5Zb1wruMEQVLPb+bhyleHtuHJTo4/bcov/7FiYGrYis9E2xryyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggEuowbt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768934860; x=1800470860;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=t0ZuMZsLLfJmBJE3WheVrPlJHvgNs3Tn82FtuhGfj0k=;
  b=ggEuowbtlAG8nnaCZDC0e8Xcc8XqZKaONSBJncA1z1aoJhJp93onDirC
   q5cNYU0r3cUlg3U+/upGlMDtFfiV4Ra8QeUauh6Ef7F7nb++OJD5i3exZ
   c3uScPWqVHBpfnwlI8/+02QqBcHe9mmZEqhqoiaj/6Qf2Pcxcvs3bvCeL
   Rk2xIyezgPWMSADX3UNF4oNbzI5gnt11b2Q6R4YEBNaoBw8kcZkmSNjNL
   0CDil+zisgaah8zencIvLfFQqmnGdmbOnfepvNRTSMX+zcSA+O8RwlLX/
   UN+ulszQ8jSX7vgRaJMNn1gRQ1WdcZcIlFUnuJgUoPD9KhmSr5bp83wXi
   w==;
X-CSE-ConnectionGUID: knfxekxvQ5ubjfmHqXwh7w==
X-CSE-MsgGUID: LsVlN5OZQrSNv5ojrk5L7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70054306"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70054306"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:47:39 -0800
X-CSE-ConnectionGUID: ovHs6qFAQlC5kButLCq8cg==
X-CSE-MsgGUID: ezihZqD8Qr+UR6SSLR7CKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206241387"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:47:33 -0800
Message-ID: <cfc0d357-18c3-40b8-b355-0055bd82bac8@intel.com>
Date: Tue, 20 Jan 2026 11:47:32 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
From: Dave Jiang <dave.jiang@intel.com>
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, cassel@kernel.org,
 mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, geert+renesas@glider.be, robh@kernel.org,
 vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 iommu@lists.linux.dev, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com, utkarsh02t@gmail.com
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <120e42c4-9ba8-4f4b-a06c-61888fc961d1@intel.com>
Content-Language: en-US
In-Reply-To: <120e42c4-9ba8-4f4b-a06c-61888fc961d1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8408-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[valinux.co.jp,nxp.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,kernel.org,arm.com,gmail.com,lwn.net,linux.intel.com,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3E5424A8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/20/26 11:30 AM, Dave Jiang wrote:
> 
> 
> On 1/18/26 6:54 AM, Koichiro Den wrote:
>> Hi,
>>
>> This is RFC v4 of the NTB/PCI/dmaengine series that introduces an
>> optional NTB transport variant where payload data is moved by a PCI
>> embedded-DMA engine (eDMA) residing on the endpoint side.
> 
> Just a fly by comment. This series is huge. I do suggest break it down to something more manageable to prevent review fatigue from patch reviewers. For example, linux network sub-system has a rule to restrict patch series to no more than 15 patches. NTB sub-system does not have that rule. But maybe split out the dmaengine changes and the hardware specific dw-edma bits from the ntb core changes.
> 
> DJ

Ah I do see your comment that you will split when out of RFC below now.

DJ
>  
>>
>> The primary target is Synopsys DesignWare PCIe endpoint controllers that
>> integrate a DesignWare eDMA instance (dw-edma). In the remote
>> embedded-DMA mode, payload is transferred by DMA directly between the
>> two systems' memory, and NTB Memory Windows are used primarily for
>> control/metadata and for exposing the endpoint eDMA resources (register
>> window + linked-list rings) to the host.
>>
>> Compared to the existing cpu/dma memcpy-based implementation, this
>> approach avoids window-backed payload rings and the associated extra
>> copies, and it is less sensitive to scarce MW space. This also enables
>> scaling out to multiple queue pairs, which is particularly beneficial
>> for ntb_netdev. On R-Car S4, preliminary iperf3 results show 10~20x
>> throughput improvement. Latency improvements are also observed.
>>
>> RFC history:
>>   RFC v3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
>>   RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
>>   RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
>>
>> Parts of RFC v3 series have already been split out and posted separately
>> (see "Kernel base / dependencies" section below). However, feedback on
>> the remaining parts led to substantial restructuring and code changes,
>> so I am sending an RFC v4 as a refreshed version of the full series.
>>
>> RFC v4 is still a large, cross-subsystem series. At this RFC stage,
>> I am sending the full picture in a single set to make it easier to
>> review the overall direction and architecture. Once the direction is
>> agreed upon and no further large restructuring appears necessary, I will stop
>> posting the new RFC-tagged revisions and continue development on
>> separate threads, split by sub-topic.
>>
>> Many thanks for all the reviews and feedback from multiple perspectives.
>>
>>
>> Software architecture overview (RFC v4)
>> =======================================
>>
>> A major change in RFC v4 is the software layering and module split.
>>
>> The existing memcpy-based transport and the new remote embedded-DMA
>> transport are implemented as two independent NTB client drivers on top
>> of a shared core library:
>>
>>                        +--------------------+
>>                        | ntb_transport_core |
>>                        +--------------------+
>>                            ^            ^
>>                            |            |
>>         ntb_transport -----+            +----- ntb_transport_edma
>>        (cpu/dma memcpy)                   (remote embedded DMA transfer)
>>                                                        |
>>                                                        v
>>                                                  +-----------+
>>                                                  |  ntb_edma |
>>                                                  +-----------+
>>                                                        ^
>>                                                        |
>>                                                +----------------+
>>                                                |                |
>>                                           ntb_dw_edma         [...]
>>
>> Key points:
>>   * ntb_transport_core provides the queue-pair abstraction used by upper
>>     layer clients (e.g. ntb_netdev).
>>   * ntb_transport is the legacy shared-memory transport client (CPU/DMA
>>     memcpy).
>>   * ntb_transport_edma is the remote embedded-DMA transport client.
>>   * ntb_transport_edma relies on an ntb_edma backend registry.
>>     This RFC provides an initial DesignWare backend (ntb_dw_edma).
>>   * Transport selection is per-NTB device via the standard
>>     driver_override mechanism. To enable that, this RFC adds
>>     driver_override support to ntb_bus. This allows mixing transports
>>     across multiple NTB ports and provides an explicit fallback path to
>>     the legacy transport.
>>
>> So, if ntb_transport / ntb_transport_edma are built as loadable modules,
>> you can just run modprobe ntb_transport as before and the original cpu/dma
>> memcpy-based implementation will be active. If they are built-in, whether
>> ntb_transport or ntb_transport_edma are bound by default depends on
>> initcall order. Regarding how to switch the driver, please see Patch 34
>> ("Documentation: driver-api: ntb: Document remote embedded-DMA transport")
>> for details.
>>
>>
>> Data flow overview (remote embedded-DMA transport)
>> ==================================================
>>
>> At a high level:
>>   * One MW is reserved as an "eDMA window". The endpoint exposes the
>>     eDMA register block plus LL descriptor rings through that window, so
>>     the peer can ioremap it and drive DMA reads remotely.
>>   * Remaining MWs carry only small control-plane rings used to exchange
>>     buffer addresses and completion information.
>>   * For RC->EP traffic, the RC drives endpoint DMA read channels through
>>     the peer-visible eDMA window.
>>   * For EP->RC traffic, the endpoint uses its local DMA write channels.
>>
>> The following figures illustrate the data flow when ntb_netdev sits on
>> top of the transport:
>>
>>      Figure 1. RC->EP traffic via ntb_netdev + ntb_transport_edma
>>                    backed by ntb_edma/ntb_dw_edma
>>
>>              EP                                   RC
>>           phys addr                            phys addr
>>             space                                space
>>              +-+                                  +-+
>>              | |                                  | |
>>              | |                ||                | |
>>              +-+-----.          ||                | |
>>     EDMA REG | |      \     [A] ||                | |
>>              +-+----.  '---+-+  ||                | |
>>              | |     \     | |<---------[0-a]----------
>>              +-+-----------| |<----------[2]----------.
>>      EDMA LL | |           | |  ||                | | :
>>              | |           | |  ||                | | :
>>              +-+-----------+-+  ||  [B]           | | :
>>              | |                ||  ++            | | :
>>           ---------[0-b]----------->||----------------'
>>              | |            ++  ||  ||            | |
>>              | |            ||  ||  ++            | |
>>              | |            ||<----------[4]-----------
>>              | |            ++  ||                | |
>>              | |           [C]  ||                | |
>>           .--|#|<------------------------[3]------|#|<-.
>>           :  |#|                ||                |#|  :
>>          [5] | |                ||                | | [1]
>>           :  | |                ||                | |  :
>>           '->|#|                                  |#|--'
>>              |#|                                  |#|
>>              | |                                  | |
>>
>>      Figure 2. EP->RC traffic via ntb_netdev + ntb_transport_edma
>>                   backed by ntb_edma/ntb_dw_edma
>>
>>              EP                                   RC
>>           phys addr                            phys addr
>>             space                                space
>>              +-+                                  +-+
>>              | |                                  | |
>>              | |                ||                | |
>>              +-+                ||                | |
>>     EDMA REG | |                ||                | |
>>              +-+                ||                | |
>>     ^        | |                ||                | |
>>     :        +-+                ||                | |
>>     : EDMA LL| |                ||                | |
>>     :        | |                ||                | |
>>     :        +-+                ||  [C]           | |
>>     :        | |                ||  ++            | |
>>     :     -----------[4]----------->||            | |
>>     :        | |            ++  ||  ||            | |
>>     :        | |            ||  ||  ++            | |
>>     '----------------[2]-----||<--------[0-b]-----------
>>              | |            ++  ||                | |
>>              | |           [B]  ||                | |
>>           .->|#|--------[3]---------------------->|#|--.
>>           :  |#|                ||                |#|  :
>>          [1] | |                ||                | | [5]
>>           :  | |                ||                | |  :
>>           '--|#|                                  |#|<-'
>>              |#|                                  |#|
>>              | |                                  | |
>>
>>     0-a. configure remote embedded DMA (program endpoint DMA registers)
>>     0-b. DMA-map and publish destination address (DAR)
>>     1.   network stack builds skb (copy from application/user memory)
>>     2.   consume DAR, DMA-map source address (SAR) and kick DMA transfer
>>     3.   DMA transfer (payload moves between RC/EP memory)
>>     4.   consume completion (commit)
>>     5.   network stack delivers data to application/user memory
>>
>>     [A]: Dedicated MW that aggregates DMA regs and LL (peer ioremaps it)
>>     [B]: Control-plane ring buffer for "produce"
>>     [C]: Control-plane ring buffer for "consume"
>>
>>
>> Kernel base / dependencies
>> ==========================
>>
>> This series is based on:
>>
>>   - next-20260114 (commit b775e489bec7)
>>
>> plus the following seven unmerged patch series or standalone patches:
>>
>>   - [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
>>     https://lore.kernel.org/all/20251202072348.2752371-1-den@valinux.co.jp/
>>
>>   - [PATCH v2 0/2] NTB: ntb_transport: debugfs cleanups
>>     https://lore.kernel.org/all/20260107042458.1987818-1-den@valinux.co.jp/
>>
>>   - [PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
>>     https://lore.kernel.org/all/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
>>
>>   - [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
>>     https://lore.kernel.org/all/20260115084928.55701-1-den@valinux.co.jp/
>>
>>   - [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
>>     https://lore.kernel.org/all/20260105075606.1253697-1-den@valinux.co.jp/
>>
>>   - [PATCH] dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
>>     https://lore.kernel.org/all/20260105075904.1254012-1-den@valinux.co.jp/
>>
>>   - [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
>>     https://lore.kernel.org/imx/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
>>     (only this single commit is cherry-picked from the series)
>>
>>
>> Patch layout
>> ============
>>
>>   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
>>      register/LL windows, IRQ routing control, etc.)
>>
>>      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
>>      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
>>      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
>>      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
>>      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
>>
>>   2. NTB EPF/core + vNTB prep (mwN_offset + versioning, MSI vector
>>      management, new ntb_dev_ops helpers, driver_override, vntb glue)
>>
>>      Patch 06 : NTB: epf: Add mwN_offset support and config region versioning
>>      Patch 07 : NTB: epf: Reserve a subset of MSI vectors for non-NTB users
>>      Patch 08 : NTB: epf: Provide db_vector_count/db_vector_mask callbacks
>>      Patch 09 : NTB: core: Add mw_set_trans_ranges() for subrange programming
>>      Patch 10 : NTB: core: Add .get_private_data() to ntb_dev_ops
>>      Patch 11 : NTB: core: Add .get_dma_dev() to ntb_dev_ops
>>      Patch 12 : NTB: core: Add driver_override support for NTB devices
>>      Patch 13 : PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
>>      Patch 14 : PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
>>      Patch 15 : PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
>>
>>   3. ntb_transport refactor/modularization and backend infrastructure
>>
>>      Patch 16 : NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
>>      Patch 17 : NTB: ntb_transport: Dynamically determine qp count
>>      Patch 18 : NTB: ntb_transport: Use ntb_get_dma_dev()
>>      Patch 19 : NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
>>      Patch 20 : NTB: ntb_transport: Move internal types to ntb_transport_internal.h
>>      Patch 21 : NTB: ntb_transport: Export common helpers for modularization
>>      Patch 22 : NTB: ntb_transport: Split core library and default NTB client
>>      Patch 23 : NTB: ntb_transport: Add transport backend infrastructure
>>      Patch 24 : NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
>>
>>   4. ntb_edma backend registry + DesignWare backend + transport client
>>
>>      Patch 25 : NTB: hw: Add remote eDMA backend registry and DesignWare backend
>>      Patch 26 : NTB: ntb_transport: Add remote embedded-DMA transport client
>>
>>   5. ntb_netdev multi-queue support
>>
>>      Patch 27 : ntb_netdev: Multi-queue support
>>
>>   6. Renesas R-Car S4 enablement (IOMMU, DTs, quirks)
>>
>>      Patch 28 : iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
>>      Patch 29 : iommu: ipmmu-vmsa: Add support for reserved regions
>>      Patch 30 : arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
>>      Patch 31 : NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
>>      Patch 32 : NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car
>>
>>   7. Documentation updates
>>
>>      Patch 33 : Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
>>      Patch 34 : Documentation: driver-api: ntb: Document remote embedded-DMA transport
>>
>>   8. pci-epf-test / pci_endpoint_test / kselftest coverage for remote eDMA
>>
>>      Patch 35 : PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
>>      Patch 36 : PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
>>      Patch 37 : misc: pci_endpoint_test: Add remote eDMA transfer test mode
>>      Patch 38 : selftests: pci_endpoint: Add remote eDMA transfer coverage
>>
>>
>> Tested on
>> =========
>>
>> * 2x Renesas R-Car S4 Spider (RC<->EP connected with OCuLink cable)
>> * Kernel base as described above
>>
>>
>> Performance notes
>> =================
>>
>> The primary motivation remains improving throughput/latency for ntb_transport
>> users (typically ntb_netdev). On R-Car S4, the earlier prototype (RFC v3)
>> showed roughly 10-20x throughput improvement in preliminary iperf3 tests and
>> lower ping RTT. I have not yet re-measured after the v4 refactor and
>> module split.
>>
>>
>> Changelog
>> =========
>>
>> RFCv3->RFCv4 changes:
>>   - Major refactor of the transport layering:
>>     - Introduce ntb_transport_core as a shared library module.
>>     - Split the legacy shared-memory transport client (ntb_transport) and the
>>       remote embedded-DMA transport client (ntb_transport_edma).
>>     - Add driver_override support for ntb_bus and use it for per-port transport
>>       selection.
>>   - Introduce a vendor-agnostic remote embedded-DMA backend registry (ntb_edma)
>>     and add the initial DesignWare backend (ntb_dw_edma).
>>   - Rebase to next-20260114 and move several prerequisite/fixup patchsets into
>>     separate threads (listed above), including BAR subrange mapping support and
>>     dw-edma fixes.
>>   - Add PCI endpoint test coverage for the remote embedded-DMA path:
>>     - extend pci-epf-test / pci_endpoint_test
>>     - add a kselftest variant to exercise remote-eDMA transfers
>>     Note: to keep the changes as small as possible, I added a few #ifdefs
>>     in the main test code. Feedback on whether/how/to what extent this
>>     should be split into separate modules would be appreciated.
>>   - Expand documentation (Documentation/driver-api/ntb.rst) to describe transport
>>     variants, the new module structure, and the remote embedded-DMA data flow.
>>   - Addressed other feedbacks from the RFC v3 thread.
>>
>> RFCv2->RFCv3 changes:
>>   - Architecture
>>     - Have EP side use its local write channels, while leaving RC side to
>>       use remote read channels.
>>     - Abstraction/HW-specific stuff encapsulation improved.
>>   - Added control/config region versioning for the vNTB/EPF control region
>>     so that mismatched RC/EP kernels fail early instead of silently using an
>>     incompatible layout.
>>   - Reworked BAR subrange / multi-region mapping support:
>>     - Dropped the v2 approach that added new inbound mapping ops in the EPC
>>       core.
>>     - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
>>       support BAR subrange inbound mapping via Address Match Mode IB iATU.
>>     - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
>>       when offsets are used.
>>   - Changed .get_pci_epc() to .get_private_data()
>>   - Dropped two commits from RFC v2 that should be submitted separately:
>>     (1) ntb_transport debugfs seq_file conversion
>>     (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
>>   - Added documentation updates.
>>   - Addressed assorted review nits from the RFC v2 thread (naming/structure).
>>
>> RFCv1->RFCv2 changes:
>>   - Architecture
>>     - Drop the generic interrupt backend + DW eDMA test-interrupt backend
>>       approach and instead adopt the remote eDMA-backed ntb_transport mode
>>       proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
>>       mapping (Address Match Mode) infrastructure from RFC v1 is largely
>>       kept, with only minor refinements and code motion where necessary
>>       to fit the new transport-mode design.
>>   - For Patch 01
>>     - Rework the array_index_nospec() conversion to address review
>>       comments on "[RFC PATCH 01/25]".
>>
>> RFCv3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
>> RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
>> RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
>>
>> Thank you for reviewing,
>>
>>
>> Koichiro Den (38):
>>   dmaengine: dw-edma: Export helper to get integrated register window
>>   dmaengine: dw-edma: Add per-channel interrupt routing control
>>   dmaengine: dw-edma: Poll completion when local IRQ handling is
>>     disabled
>>   dmaengine: dw-edma: Add notify-only channels support
>>   dmaengine: dw-edma: Add a helper to query linked-list region
>>   NTB: epf: Add mwN_offset support and config region versioning
>>   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
>>   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
>>   NTB: core: Add mw_set_trans_ranges() for subrange programming
>>   NTB: core: Add .get_private_data() to ntb_dev_ops
>>   NTB: core: Add .get_dma_dev() to ntb_dev_ops
>>   NTB: core: Add driver_override support for NTB devices
>>   PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
>>   PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
>>   PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
>>   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
>>   NTB: ntb_transport: Dynamically determine qp count
>>   NTB: ntb_transport: Use ntb_get_dma_dev()
>>   NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
>>   NTB: ntb_transport: Move internal types to ntb_transport_internal.h
>>   NTB: ntb_transport: Export common helpers for modularization
>>   NTB: ntb_transport: Split core library and default NTB client
>>   NTB: ntb_transport: Add transport backend infrastructure
>>   NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
>>   NTB: hw: Add remote eDMA backend registry and DesignWare backend
>>   NTB: ntb_transport: Add remote embedded-DMA transport client
>>   ntb_netdev: Multi-queue support
>>   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
>>   iommu: ipmmu-vmsa: Add support for reserved regions
>>   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
>>     eDMA
>>   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
>>   NTB: epf: Add an additional memory window (MW2) barno mapping on
>>     Renesas R-Car
>>   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
>>     usage
>>   Documentation: driver-api: ntb: Document remote embedded-DMA transport
>>   PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
>>   PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
>>   misc: pci_endpoint_test: Add remote eDMA transfer test mode
>>   selftests: pci_endpoint: Add remote eDMA transfer coverage
>>
>>  Documentation/PCI/endpoint/pci-vntb-howto.rst |   19 +-
>>  Documentation/driver-api/ntb.rst              |  193 ++
>>  arch/arm64/boot/dts/renesas/Makefile          |    2 +
>>  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   37 +
>>  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
>>  drivers/dma/dw-edma/dw-edma-core.c            |  207 +-
>>  drivers/dma/dw-edma/dw-edma-core.h            |   10 +
>>  drivers/dma/dw-edma/dw-edma-v0-core.c         |   26 +-
>>  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
>>  drivers/misc/pci_endpoint_test.c              |  633 +++++
>>  drivers/net/ntb_netdev.c                      |  341 ++-
>>  drivers/ntb/Kconfig                           |   13 +
>>  drivers/ntb/Makefile                          |    2 +
>>  drivers/ntb/core.c                            |   68 +
>>  drivers/ntb/hw/Kconfig                        |    1 +
>>  drivers/ntb/hw/Makefile                       |    1 +
>>  drivers/ntb/hw/edma/Kconfig                   |   28 +
>>  drivers/ntb/hw/edma/Makefile                  |    5 +
>>  drivers/ntb/hw/edma/backend.c                 |   87 +
>>  drivers/ntb/hw/edma/backend.h                 |  102 +
>>  drivers/ntb/hw/edma/ntb_dw_edma.c             |  977 +++++++
>>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  199 +-
>>  drivers/ntb/ntb_transport.c                   | 2458 +---------------
>>  drivers/ntb/ntb_transport_core.c              | 2523 +++++++++++++++++
>>  drivers/ntb/ntb_transport_edma.c              | 1110 ++++++++
>>  drivers/ntb/ntb_transport_internal.h          |  261 ++
>>  drivers/pci/controller/dwc/pcie-designware.c  |   26 +
>>  drivers/pci/endpoint/functions/pci-epf-test.c |  497 +++-
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  380 ++-
>>  include/linux/dma/edma.h                      |  106 +
>>  include/linux/ntb.h                           |   88 +
>>  include/uapi/linux/pcitest.h                  |    3 +-
>>  .../pci_endpoint/pci_endpoint_test.c          |   17 +
>>  33 files changed, 7855 insertions(+), 2624 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
>>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
>>  create mode 100644 drivers/ntb/hw/edma/Kconfig
>>  create mode 100644 drivers/ntb/hw/edma/Makefile
>>  create mode 100644 drivers/ntb/hw/edma/backend.c
>>  create mode 100644 drivers/ntb/hw/edma/backend.h
>>  create mode 100644 drivers/ntb/hw/edma/ntb_dw_edma.c
>>  create mode 100644 drivers/ntb/ntb_transport_core.c
>>  create mode 100644 drivers/ntb/ntb_transport_edma.c
>>  create mode 100644 drivers/ntb/ntb_transport_internal.h
>>
> 


