Return-Path: <dmaengine+bounces-10196-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEVjHfpF8mmApQEAu9opvQ
	(envelope-from <dmaengine+bounces-10196-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:55:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C779C4985A2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D433830134B7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7E39B497;
	Wed, 29 Apr 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvO1VEX+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F63B19A6
	for <dmaengine@vger.kernel.org>; Wed, 29 Apr 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485302; cv=none; b=qed2wQFhtDG/5uouFu3pPLE8D9xRxk4GPfJYxnBp4KSWuwUsWRAr76GfqPGkimQxRwzGYpyY2N5MbJmGuTObw+IDC7d2hkDUcjq/brgntZCbURKjV4pPSoTjWmTRfw7DdnCI/UeXKBywFQr4JDXrgV/zYZoRh9PvlduWVsJk290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485302; c=relaxed/simple;
	bh=4AJPtb5RPQq2qv2NjVlwkwk7wHo11+3cshakOKAZBnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hUUZ+bZu/sUnsJw48WqNKjqr8dLjRk9s5LidohhCvmEgltbZ2uIZ9SALYAU5IoTla2wsuDvKoXYrtdQiOklG4zGq/tDRjiV0Q9lxoeHecuHYfr91VAvEXWvySwNDB+pDijjZ5HQLHzb8u/IdBiMzpvIJ4VZMqP8zYPLkkZSKjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvO1VEX+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777485300; x=1809021300;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4AJPtb5RPQq2qv2NjVlwkwk7wHo11+3cshakOKAZBnw=;
  b=PvO1VEX+ZVxy6kYADS7hs/Yt2FhInesyV1Y79GsPvkdem+mZI2Cl1sFg
   1YwlxEuX4mJgGLub9cQZ5PVMt3wwO/JR8jDDVAqN1cg/251d0tm265CgG
   Qq0GJI65yMwk6TsdP0jl8JMKJ9MnvB0J1FTJ7QhQpQhHNYkKGrUxH6ll5
   WJqNKDFannXFgf3rlv8nXsQVqjf/gC6UFUnRGkYPfjJaX5taCgyMc7ahj
   LA1wYBTblBt56TI9NbvWwnR5i6a/+vnqOFHkGVrYi8mLmzms/iQLhbmpU
   1kdzWnZiMJUmM3tFLtNdmbBSaRyRS6v3yK83PQ112y5UEePWcqR7fk6s5
   g==;
X-CSE-ConnectionGUID: gsInKT8tTB68OQAxKAOGRA==
X-CSE-MsgGUID: kHbrlo02Q/WdUazf77j6xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="103878740"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="103878740"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:54:59 -0700
X-CSE-ConnectionGUID: QdB15IGyQu69/6io39uing==
X-CSE-MsgGUID: P6uD+cEbTnSflLsQLYfjPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233498295"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:54:59 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
In-Reply-To: <20260415095030.42183-1-kanie@linux.alibaba.com>
References: <20260415095030.42183-1-kanie@linux.alibaba.com>
Date: Wed, 29 Apr 2026 10:54:58 -0700
Message-ID: <87tsstwt1p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C779C4985A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10196-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,intel.com:email,intel.com:dkim,intel.com:mid]

Guixin Liu <kanie@linux.alibaba.com> writes:

> We found an idxd_wq use-after-free issue with kasan
> when remove the idxd PCI device:
>
> BUG: KASAN: slab-use-after-free in idxd_device_drv_remove+0x1f8/0x240 [idxd]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x32/0x50
>   print_address_description.constprop.0+0x2c/0x390
>   ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
>   print_report+0xba/0x280
>   ? kasan_addr_to_slab+0x9/0xa0
>   ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
>   kasan_report+0xab/0xe0
>   ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
>   idxd_device_drv_remove+0x1f8/0x240 [idxd]
>   device_release_driver_internal+0x391/0x560
>   bus_remove_device+0x1f5/0x3f0
>   device_del+0x392/0x990
>   ? __pfx_device_del+0x10/0x10
>   ? kobject_cleanup+0x117/0x360
>   ? idxd_unregister_devices+0x229/0x320 [idxd]
>   device_unregister+0x13/0xa0
>   idxd_remove+0x4f/0x1b0 [idxd]
>   pci_device_remove+0xa7/0x1d0
>   device_release_driver_internal+0x391/0x560
>   ? pci_pme_active+0x1e/0x450
>   pci_stop_bus_device+0x10a/0x150
>   pci_stop_and_remove_bus_device_locked+0x16/0x30
>   remove_store+0xcf/0xe0
>
> Freed by task 15535:
>   kasan_save_stack+0x1c/0x40
>   kasan_set_track+0x21/0x30
>   kasan_save_free_info+0x27/0x40
>   ____kasan_slab_free+0x171/0x240
>   slab_free_freelist_hook+0xde/0x190
>   __kmem_cache_free+0x19e/0x310
>   device_release+0x98/0x210
>   kobject_cleanup+0x102/0x360
>   idxd_unregister_devices+0xb3/0x320 [idxd]
>   dxd_remove+0x3f/0x1b0 [idxd]
>   pci_device_remove+0xa7/0x1d0
>   device_release_driver_internal+0x391/0x560
>   pci_stop_bus_device+0x10a/0x150
>   pci_stop_and_remove_bus_device_locked+0x16/0x30
>   remove_store+0xcf/0xe0
>
> In the idxd_remove() flow, when execution reaches
> idxd_unregister_devices(), all idxd_wq instances have already been
> freed. Subsequently, when device_unregister(idxd_confdev(idxd)) is
> executed, it calls into idxd_device_drv_remove() which accesses the
> already-freed idxd_wq. This fix resolves the issue by calling
> device_release_driver() before idxd_unregister_devices().
>
> Fixes: 98da0106aac0d ("dmanegine: idxd: fix resource free ordering on driver removal")
> Co-developed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---

All questions that I had after the AI review are handled:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

