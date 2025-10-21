Return-Path: <dmaengine+bounces-6913-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B7BF438F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 03:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825993BCBDC
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EAA21CC47;
	Tue, 21 Oct 2025 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZyDha2B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49716CD33;
	Tue, 21 Oct 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008796; cv=none; b=nUVt3YFHLSSs+jZ3DWhLX+YzfvyLrKi6kZxKvf21ALIIDeZlWxhusJKqRxG9G1NGBcdHA02UYXEaPmnFB/LNIxr3WHfORvK/wU1PkDeW+FtEM+91Lv6rE/uXByeO5D5IabR/7BvZvnbQT500h0KTSV94mWe/Rc8MvMpnhZRT8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008796; c=relaxed/simple;
	bh=9FgjtWRQhn4mqAKvRrsk7CBm/hwklJdaemm2NrmTSy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tXCkFySWBkBaYKLJ/vbJT7G58FBIKaruirImR7/Nj198x8MJIDq//ni1V+LvifjNXXLtTiFg5Nj63gS2Bn265ysorKAHaSeScunmHGKj2rOBeHHVU1Icewdvb5F7u6lv5fnbUhGY2g1QAT+0PlyvTVHIOzyp3EnMycX9bGOerYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZyDha2B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761008796; x=1792544796;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9FgjtWRQhn4mqAKvRrsk7CBm/hwklJdaemm2NrmTSy0=;
  b=UZyDha2BnuVsIVsqMpDlRXsO5DzCToyQNJJKr0lVE1l+/BnCwkRYSGf1
   pidjjsH3wJUxs+B05O3firxYoPIvktZAO/kVTb5Zdtv4Dg30xuDc9whh7
   DDlZQuB6giEPfXy6e1uEAuCLh1RTi8U0qNLCNQ7iuU9w/He+YJHfWLrFd
   zFH5833pD3Iq1cpZsr8hZaWsm09hkQw+7uaDks3g6NaQC2oJ1NwreY35a
   AdZZgzvcdlmw2Lc5IRtcmqm/EEAV/Ui4BHF8LNutFtVpD7id1Ugjfqf1V
   vMcwEtzYUMtD55puQI0bBrIBay5FdvfQ8xw4wdh5zPlE/vdDJjuoWuxsg
   g==;
X-CSE-ConnectionGUID: 14/SfHXRS9KWkjqXHdPtdA==
X-CSE-MsgGUID: TSsAFEcAS1SGFUZnZePlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74475334"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74475334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 18:06:35 -0700
X-CSE-ConnectionGUID: 3RVYNCZSRtKscq20ThIqaw==
X-CSE-MsgGUID: RPdKOahXQL+QCYUDaaopKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="182659172"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 18:06:34 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] dmaengine: idxd: Memory leak and FLR fixes
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
Date: Mon, 20 Oct 2025 18:06:48 -0700
Message-ID: <871pmxkqqf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Vinod,

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> Hi,
>
> During testing some not so happy code paths in a debugging (lockdep,
> kmemleak, etc) kernel, found a few issues.
>
> There's still a crash that happens when doing a PCI unbind, but I
> don't have a patch at this time.
>
> Cheers,
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> Changes in v2:
> - Fixed messing up the definition of FLR (Function Level
>   Reset) (Nathan Lynch)
> - Simplified callers of idxd_device_config(), moved a common check,
>   and locking to inside the function (Dave Jiang);
> - For idxd DMA backend, ->terminate_all() now flushes all pending
>   descriptors (Dave Jiang);
> - For idxd DMA backend, ->device_synchronize() now waits for submitted
>   operations to finish (Dave Jiang);
> - Link to v1: https://lore.kernel.org/r/20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com
>

Gentle ping. If anything is missing/could be improved, glad to fix.


Cheers,
-- 
Vinicius

