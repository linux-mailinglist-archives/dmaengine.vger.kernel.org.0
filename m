Return-Path: <dmaengine+bounces-6912-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E08ABF3ABD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E060B18820EC
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A22D0601;
	Mon, 20 Oct 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaxUn8A9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD38278779;
	Mon, 20 Oct 2025 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994705; cv=none; b=RHQNBO5gqFn9QrbMILQge2RK6aqkkiFr1nKKk0TO5j21aQtuKeo3CNoCgzHnb3etfDHJoe16nLUNHVOUp4iACdjLXhZi6OcOJETlkiYbSekuCpYFGO4Q3Gh93dIUaXwz+PSdMviNc5YmZtvb9vBvcOcFJhYMWazY1aoaUDq+7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994705; c=relaxed/simple;
	bh=O0XWQxNcqr7lrjtTeC0YbuaDEI/QKM9Ag4XHafCsbhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oz2h3o8ikU7bOCDQGHWjdR3njrIY9fXIvmIR05pZ+I82KSUrNwtsYxnPof/n3Q7JzuWtV8Fux11eeQVmbfAxoGTOskVeRQTYp5xfmBIF6+35lJsipu+qhTsQKQ9Ann1P3oi/ZmS6mwAf2NWlyJjICwR3e1ghUyV4EwzmWp5TgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaxUn8A9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760994704; x=1792530704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O0XWQxNcqr7lrjtTeC0YbuaDEI/QKM9Ag4XHafCsbhk=;
  b=HaxUn8A9PF86JBZ1woF2S3POZfk+h8TEXAmLisUB3mCRZkXG0Jxo0ffg
   J+Nb0YBjRd/hCUtYfPmvvP4+I+Z4hpb2i359fZwAvr/9mdZXDo/EpEn4A
   +T23h2s8AquOro4swYN3QCfCxKwh5TTfisg/6Ezf/imV1HPoav7GjwIDy
   vdVQ0rAEY5mLZdz56OFLa2jkFeKpO0FXOFck/4brTpHRwOn4aeJ5D0gxd
   sGba6XhvvKuOLEKfRYJ8EmV93nSBUD4VWdvQ5+aNrAdkkoUi/aQnhMxMh
   wsMgubBTTuaKqKQQX0NCy0fMgx2uaizGESau7jQw8802Tj7WdvxLgi+i5
   w==;
X-CSE-ConnectionGUID: 4yW4PwM6S1GoYlknTnOEAw==
X-CSE-MsgGUID: ixJd+HZ4QAeS1luqk7yBoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62150472"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="62150472"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 14:11:43 -0700
X-CSE-ConnectionGUID: 79YoqZeXTXWg1dPD2YtHJQ==
X-CSE-MsgGUID: zLZOAwvWR1qE5ZXHr5NCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187688620"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 14:11:43 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dmaengine@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Yi Sun
 <yi.sun@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Dave Jiang
 <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 6.12] dmaengine: Add missing cleanup on module unload
In-Reply-To: <20251020170422.2630360-1-linux@roeck-us.net>
References: <20251020170422.2630360-1-linux@roeck-us.net>
Date: Mon, 20 Oct 2025 14:11:57 -0700
Message-ID: <87cy6hl1lu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> Upstream commit b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow
> on module unload") fixes a refcount underflow by replacing the call to
> idxd_cleanup() in the remove function with direct cleanup calls. That works
> fine upstream. However, upstream removed support for IOMMU_DEV_FEAT_IOPF,
> which is still supported in v6.12.y. The backport of commit b7cb9a034305
> into v6.12.y misses the call to disable it. This results in a warning
> backtrace when unloading and reloading the module.
>
> WARNING: CPU: 0 PID: 665849 at drivers/pci/ats.c:337 pci_reset_pri+0x4c/0x60
> ...
> RIP: 0010:pci_reset_pri+0xa7/0x130
>
> Add the missing cleanup call to fix the problem.
>
> Fixes: ce81905bec91 ("dmaengine: idxd: Fix refcount underflow on module unload")
> Cc: Yi Sun <yi.sun@intel.com>
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> The problem fixed with this patch only affects v6.12.y.
>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

