Return-Path: <dmaengine+bounces-8087-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD1CFB0B7
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 22:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3653032ABB
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9CA29BDBD;
	Tue,  6 Jan 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deJfgdyZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7F7E0FF;
	Tue,  6 Jan 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767733784; cv=none; b=Da9WKo3D3LXNPvuuqaEmGxUCrkxKr/1WWdH7yr5w2pLaKmDeb61qlJHjWWMWoCvDv2Alvmu6/qq1bTxZVTX6pJLuye6WxcLbrvUzB4nbe5GzwNuqmEowAO0v5rb8q8UZSLXCWm9XZbE5hqQIniLWaQOZ7dBySQyAew9TWeGChdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767733784; c=relaxed/simple;
	bh=gc8s8s4SMDnbfho5P/tSa23Hd6vkDDi4mF917YCDjXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AloQXDd0b0rVmLpxgAO0IO6EGM+RMZQ5kwG3GTKl5s85Eaxa2NkO9brgWYzAphOZgiTVavkPjGw9a70HcrjjhN5QJ6fg69hYTLhQ51GhnxMu5qLhVx3McMr3wtZWyjLe0k85hglfTHKqJagrqyeBnRYpNw814hGYHSMH2CkjXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deJfgdyZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767733782; x=1799269782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gc8s8s4SMDnbfho5P/tSa23Hd6vkDDi4mF917YCDjXc=;
  b=deJfgdyZyUu5aKmY4oM3CULs6ZkAM7GKl0mL2uDMGM1DkchBREIhR25o
   xg6BWdm7YC9xV/jYZj+IT9HNbxBg76Z71gq2U/tqaTJu+PrwCkKfYgxWX
   B4Y9i4mudd8Yl3ae25nsn582+mq9wGk0I/Rz2CivJICwURnMy6pJGbmoL
   GaUoBFayAd74yio766V8WoxPtevvKVQHAdjXX8AXnbPUgcce1JJLHaAGk
   0P4uC83jTnwOaXl3WgPLD+lWOSO3BXAd5gajPznwSuKMsOf0pDaHHDlrf
   +Q3TKM3xBpJrQPznXFxasfeDhFr7t/Wmlv9ZxtxLqt5e0Jmo1N275VDGf
   w==;
X-CSE-ConnectionGUID: e7Vx1SoEQrqFR4ChE6X/bQ==
X-CSE-MsgGUID: xPHsm76lRiq1SQwJvYeHhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72951168"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72951168"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:09:41 -0800
X-CSE-ConnectionGUID: HtX0w+g7Squd9ZT76KBc3w==
X-CSE-MsgGUID: WCpEeaywTEiGKwqTHQwOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202762830"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:09:40 -0800
Message-ID: <77ae1b02-ff32-4694-9b34-bc49c85c6c82@intel.com>
Date: Tue, 6 Jan 2026 14:09:38 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 35/35] Documentation: driver-api: ntb: Document
 remote eDMA transport backend
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be,
 magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jdmason@kudzu.us, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com,
 Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com,
 jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com,
 jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de,
 elfring@users.sourceforge.net
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-36-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251217151609.3162665-36-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/17/25 8:16 AM, Koichiro Den wrote:
> Add a description of the ntb_transport backend architecture and the new
> remote eDMA backed mode introduced by CONFIG_NTB_TRANSPORT_EDMA and the
> use_remote_edma module parameter.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  Documentation/driver-api/ntb.rst | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
> index a49c41383779..eb7b889d17c4 100644
> --- a/Documentation/driver-api/ntb.rst
> +++ b/Documentation/driver-api/ntb.rst
> @@ -132,6 +132,64 @@ Transport queue pair.  Network data is copied between socket buffers and the
>  Transport queue pair buffer.  The Transport client may be used for other things
>  besides Netdev, however no other applications have yet been written.
>  
> +Transport backends
> +~~~~~~~~~~~~~~~~~~
> +
> +The ``ntb_transport`` core driver implements a generic "queue pair"
> +abstraction on top of the memory windows exported by the NTB hardware. Each
> +queue pair has a TX and an RX ring and is used by client drivers such as
> +``ntb_netdev`` to exchange variable sized payloads with the peer.
> +
> +There are currently two ways for ``ntb_transport`` to move payload data
> +between the local system memory and the peer:
> +
> +* The default backend copies data between the caller buffers and the TX/RX
> +  rings in the memory windows using ``memcpy()`` on the local CPU or, when
> +  the ``use_dma`` module parameter is set, a local DMA engine via the
> +  standard dmaengine ``DMA_MEMCPY`` interface.
> +
> +* When ``CONFIG_NTB_TRANSPORT_EDMA`` is enabled in the kernel configuration
> +  and the ``use_remote_edma`` module parameter is set at run time, a second
> +  backend uses a DesignWare eDMA engine that resides on the endpoint side

I would say "embedded DMA device" instead of a specific DesignWare eDMA engine to keep the transport generic. But provide a reference or link to DesignWare eDMA engine as reference.

> +  of the NTB. In this mode the endpoint driver exposes a dedicated peer
> +  memory window that contains the eDMA register block together with a small
> +  control structure and per-channel linked-list rings only for read
> +  channels. The host ioremaps this window and configures a dmaengine
> +  device. The endpoint uses its local eDMA write channels for its TX
> +  transfer, while the host side uses the remote eDMA read channels for its
> +  TX transfer.

Can you provide some more text on the data flow from one host to the other for eDMA vs via host based DMA in the current transport? i.e. currently for a transmit, user data gets copied into an skbuff by the network stack, and then the local host copies it into the ring buffer on the remote host via DMA write (or CPU). And the remote host then copies out of the ring buffer entry to a kernel skbuff and back to user space on the receiver side. How does it now work with eDMA? Also can the mechanism used by eDMA be achieved with a host DMA setup or is the eDMA mechanism specifically tied to the DW hardware design? Would be nice to move the ASCII data flow diagram in the cover to documentation so we don't lose that.

DJ

> +
> +The ``ntb_transport`` core routes queue pair operations (enqueue,
> +completion polling, link bring-up/teardown etc.) through a small
> +backend-ops structure so that both implementations can coexist in the same
> +module without affecting the public queue pair API used by clients. From a
> +client driver's point of view (for example ``ntb_netdev``) the queue pair
> +interface is the same regardless of which backend is active.
> +
> +When ``use_remote_edma`` is not enabled, ``ntb_transport`` behaves as in
> +previous kernels before the optional ``use_remote_edma`` parameter was
> +introduced, and continues to use the shared-memory backend. Existing
> +configurations that do not select the eDMA backend therefore see no
> +behavioural change.
> +
> +In the remote eDMA mode host-to-endpoint notifications are delivered via a
> +dedicated DMA read channel located at the endpoint. In both the default
> +backend mode and the remote eDMA mode, endpoint-to-host notifications are
> +backed by native MSI support on DW EPC, even when ``use_msi=0``.  Because
> +of this, the ``use_msi`` module parameter has no effect when
> +``use_remote_edma=1`` on the host.
> +
> +At a high level, enabling the remote eDMA transport backend requires:
> +
> +* building the kernel with ``CONFIG_NTB_TRANSPORT`` and
> +  ``CONFIG_NTB_TRANSPORT_EDMA`` enabled,
> +* configuring the NTB endpoint so that it exposes a memory window containing
> +  the eDMA register block, descriptor rings and control structure expected by
> +  the helper driver, and
> +* loading ``ntb_transport`` on the host with ``use_remote_edma=1`` so that
> +  the eDMA-backed backend is selected instead of the default shared-memory
> +  backend.
> +
>  NTB Ping Pong Test Client (ntb\_pingpong)
>  -----------------------------------------
>  


