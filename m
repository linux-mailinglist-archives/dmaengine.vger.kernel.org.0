Return-Path: <dmaengine+bounces-6050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0370CB28879
	for <lists+dmaengine@lfdr.de>; Sat, 16 Aug 2025 00:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0F0604DEA
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAB2264B1;
	Fri, 15 Aug 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k92ed9Ci"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DE9460;
	Fri, 15 Aug 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297951; cv=none; b=RjItiDDdloYLZ8tgi84KqgsJQwBndG3or9Y1BmvK+j57J7Q/fL/UdboVT4t5Lsiqk6rkosjAVtRbJoBtGIbSUSpAFKzVYxvdnnlLq7KcekrB6BalnlNILMOvvTilWwAruozw5pgNakiW8+nJN5x4UNb8SZ+NAERxjMQO3UwSfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297951; c=relaxed/simple;
	bh=EG6y9qCoMpzoihjsyrVom/aJBOFjs/Hdckrc4xdzYeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qxCp+JZ80RNECe5l1gpbPVn37b+w3BMW21YBXRan/LRZgok84QhcrESqX9H5UNCAywVd7IPm7NJJg7hoLuu5L/IvmaDkoRxkrWi99clUo7DTQt0DgtuxKp9zCTRV5VanUFzSx8LMd2CYvc1cwAkgrCwpj/oN4wA1CyXDbwfABqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k92ed9Ci; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297950; x=1786833950;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EG6y9qCoMpzoihjsyrVom/aJBOFjs/Hdckrc4xdzYeI=;
  b=k92ed9CiYLFgeoLU8l90yhL90J/9WXXqj/B8ZKWjUOW363sD+QagkFcz
   6WQ/rU7DuZaAx6BLESOa+xKr1Dfqku3KHjg8RqnpYo/vjCudLMHXQjsYE
   biyA/i/jqPQOr1X5Av5+1Cf/sZHlvXzkGsB9PqJpZiGaP+jTK7SkfEu/r
   ZgiIIxyOpLgRszN9nB/lygUFef74rmLmaWlDqzNf3ChXRX6pMscRCPUxZ
   TKb2TCXdCA4YmOL5nJ3nkwa47K4vb2NpGFsZzo7GOyUVV08brkQkBEu+w
   Ro7Ae8b9llqqN9W3lwNgqFnccYUFoquKjDr3x1gnb42wSQy7QYF/vi8aP
   A==;
X-CSE-ConnectionGUID: FESIVdnoRi+kJyQqLaBgrA==
X-CSE-MsgGUID: tgcI26D8QYWCDFc7fSZlYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="69069779"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69069779"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:45:49 -0700
X-CSE-ConnectionGUID: kJpRLbq4S9mz5T89vy8XTA==
X-CSE-MsgGUID: FjnjxS3nSYmNkQrCsfI8TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198101372"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.111.232])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:45:47 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] dmaengine: idxd: Fix possible invalid memory access
 after FLR
In-Reply-To: <87349sgzcy.fsf@AUSNATLYNCH.amd.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
 <87349sgzcy.fsf@AUSNATLYNCH.amd.com>
Date: Fri, 15 Aug 2025 15:45:46 -0700
Message-ID: <878qjkkxut.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Lynch <nathan.lynch@amd.com> writes:

> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>
>> In the case that the first Field Level Reset (FLR) concludes
>
> I think you mean Function Level Reset? (here and in other changes in the
> series)
>

Ugh, thanks for noticing that. Don't know what happened that I messed
that up. Will fix.


Cheers,
-- 
Vinicius

