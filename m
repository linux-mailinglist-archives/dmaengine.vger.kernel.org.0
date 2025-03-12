Return-Path: <dmaengine+bounces-4723-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF79A5E711
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4AE3AE6BF
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38C1EC012;
	Wed, 12 Mar 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2knlsPa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FA1CD215;
	Wed, 12 Mar 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817645; cv=none; b=N5E2D2HKNff91K4YiMs8S4gx9WagZqAcBrERhvqjv/CizwGG4n4TQ2nOi5FHMqE6iHSk0s6lVK2SI2MSgX3Sufq3plnACswZfpsezS46UXgZvDnscfu3UBC8V/aR9SRjazGGHApVaU6o7JqNPaRQ9XIevAYCCzJdovDkxB9/PLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817645; c=relaxed/simple;
	bh=pnig5HAjgiLNm+cQzJg7it/Upu6+V7kDl39VH+48PtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uc64okXdY5jZMcumTWNJFnjD0HUNBJFhqQVo/8VOmGkF8yu+PWZD5Ueyw7pP6ZzOg6ZVd6Q+AAvEc91YCtzznekQtcX6g0/g1dR4A6h8nYcxjFs1eaw0UFH06XcJmfcHRNeCfkfHo9HedIr2laDqA0xxMsCwFYmaYRQhUDQXBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2knlsPa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741817640; x=1773353640;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pnig5HAjgiLNm+cQzJg7it/Upu6+V7kDl39VH+48PtI=;
  b=R2knlsPatHYfoqJIx2Krc8V72h6BSjxiYxFPkkQp7OJVG51FbPVfKkI4
   FbVI84uw8LNwxe8Eujcj5IeCk73qYonFBUgG48ePG+3zjQBCXN0HfRGEK
   3eMVBKv/LbVwT2agGPoIdryB8bsfGH6cHEVJtyEhibLKbbDjGq1eDRynl
   NgSQVv9jzeHeD6CdOpBhrS/+GepZoFFnkfw5jxCQG9PNeqhY4c45Px8jD
   StgTyzmohEV/l5ERnFoUj/fYbgXwZxK9CllNqAUfFRCkENrrJUk6SEXKa
   s5+KSPQK9ZtGTV9ZlZ4fZaW5zC1jHKSmA2QVfCjgkXmQHNyllOmGD36c8
   w==;
X-CSE-ConnectionGUID: bFw9gJ9rQLqqDwGqdp+QZA==
X-CSE-MsgGUID: wabgo4+AR5SqbEsPEiuG5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53911278"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53911278"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:14:00 -0700
X-CSE-ConnectionGUID: hpIrZwrqRyKc/yUpj22FrQ==
X-CSE-MsgGUID: FvxHMVo/Ql2OnKq1PA/f9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120752101"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.86])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:13:59 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <878qpa13fe.fsf@AUSNATLYNCH.amd.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com>
Date: Wed, 12 Mar 2025 15:13:59 -0700
Message-ID: <87senhoq1k.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Nathan,

Nathan Lynch <nathan.lynch@amd.com> writes:

> Hi,
>
> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Change the "wait for operation finish" logic to take interrupts into
>> account.
>>
>> When using dmatest with idxd DMA engine, it's possible that during
>> longer tests, the interrupt notifying the finish of an operation
>> happens during wait_event_freezable_timeout(), which causes dmatest to
>> cleanup all the resources, some of which might still be in use.
>>
>> This fix ensures that the wait logic correctly handles interrupts,
>> preventing premature cleanup of resources.
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
>
> Given the report at the URL above I'm struggling to follow the rationale
> for this change. It looks like a use-after-free in idxd while
> resetting/unbinding the device, and I can't see how changing whether
> dmatest threads perform freezeable waits would change this.
>

I think that the short version is that the reproducition script triggers
different problems on different platforms/configurations.

The solution I proposed fixes a problem I was seeing on a SPR system, on
a GNR system (that I was only able to get later) I see something more similar
to this particular splat (currently working on the fix).

Seeing this question, I realize that I should have added a note to the
commit detailing this.

So I am planning on proposing two (this and another) fixes for the same
report, hoping that it's not that confusing/unusual.


Cheers,
-- 
Vinicius

