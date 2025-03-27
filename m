Return-Path: <dmaengine+bounces-4790-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43244A73F44
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123273A185E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FD1C84B7;
	Thu, 27 Mar 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV5LJt0k"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125D28EC
	for <dmaengine@vger.kernel.org>; Thu, 27 Mar 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743106952; cv=none; b=ncPBkdrG1xjO/CBQi1WEp1NwakBLJ+fclnk9/ZsELqnafHWsvnbGJuVAuIW8Tm6Tt9PjysdarZZ3rlNRHajsZVXuUO07+3qG/qfE6OToqfBbaPXsyecmypPkYI8Cp87DQeM8S2USCz1mk4Kn5dtJw7sNBYjyVkuSBoOe/hNnaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743106952; c=relaxed/simple;
	bh=8jt8H4RYIEnIIX2QWZggnhXemis/vyRZenWXEMKuJMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nl9d/5z5bSQn7RqyljAujFNDuQQ/52li6JX57q1ySHN4xWQUddUbBTxd4dxW3hH+grtRaTxHWu9F0uPBFOUcBB56n6RxRI8ZeQHLo4Of0dpCUsD3rvcYLeyAd+fnn/Z5aOI/+fXpVu6BuBcpkMd3F7hmStKKElSY70WMmgApPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV5LJt0k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743106950; x=1774642950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8jt8H4RYIEnIIX2QWZggnhXemis/vyRZenWXEMKuJMc=;
  b=bV5LJt0kkuMmEEbSxKBN90qS/ZP5PoQvQ6OoOIw/ZpdLqKNqHhI1PXr1
   kAwokC3qneHlbszvKjVAxq9+IzkLMEX+xYcrCaDXIESZm0aztK/yCyMcv
   6FMtZQkkZd1G/ntqYixQIPXuX6lEzUxdcY5B7/HXijInsEVkBrkTa8DC5
   aop++xi9cXnSZhAGm8WvaIrbHlUs6753x9qZ5sdFFzT+Ep2OX4AoqnxGd
   +WlajWFYgB7wXPkoJDMssH4QOMYxLvwcqCJrobBIzwooN5Zpyv/+zz2ZE
   rE2g2605iiKRK62jUsdUpzHSnEZQLj52QRhhh4CqWwc7GI+KXDrqxijpp
   g==;
X-CSE-ConnectionGUID: QBA9/S8eSxy/APQYKGJMoQ==
X-CSE-MsgGUID: XjZ4debjS6Sh6aYrMbyy8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44566508"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="44566508"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 13:22:30 -0700
X-CSE-ConnectionGUID: d1Mh2gXOTsi6Gor4X3EAEQ==
X-CSE-MsgGUID: 08TAmChJR9OvD8pem2ym/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125763871"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.108.110]) ([10.125.108.110])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 13:22:29 -0700
Message-ID: <19adb45e-7816-460e-b8e4-490ce70d5508@intel.com>
Date: Thu, 27 Mar 2025 13:22:29 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: idxd: shared workqueues and dmaengine
To: Kevin Krakauer <krakauer@google.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, dmaengine@vger.kernel.org
References: <Z-SWM-F0O9XU1zqp@google.com>
 <3a28b0a6-3c7c-43b9-a592-111692d3c1bf@intel.com>
 <Z-WfWC63NbzoU_kk@google.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z-WfWC63NbzoU_kk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/25 11:56 AM, Kevin Krakauer wrote:
> On Wed, Mar 26, 2025 at 05:15:37PM -0700, Dave Jiang wrote:
>> So I think maybe a new sysfs attribute can be added to wq to allow the user to choose whether to make the channel DMA_PRIVATE or not. By default it can be set to DMA_PRIVATE to keep legacy behavior. I think that should solve the issue you are encountering?
> 
> Yep, that would do it. Thanks for helping me understand -- I was
> wondering whether I was missing something.
> 
> Easy for me to workaround for now, or maybe I'll just add the sysfs
> attribute and send it to the list. Thanks!

Patches are always welcome. I'm sure Vinicius would appreciate it.


