Return-Path: <dmaengine+bounces-4782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C1A727B2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 01:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814513B8494
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32DF256D;
	Thu, 27 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3wJSs8V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B2A55
	for <dmaengine@vger.kernel.org>; Thu, 27 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743034543; cv=none; b=MzkfK6R/qRp7PcqFjcg3sgMIh/VmeIi7Pnito+i6ObtzvTkAitY3KAyg5uhde40ACon3IZTdWXn8Ey3t1SDcrzEwVlWHjzosSi+wk5TXW8MV8i3mGZyJ7IQaN553l5FYOREXXqWAuY1yeNsYodwOK1y9TldC9X7VA9HcYDpS4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743034543; c=relaxed/simple;
	bh=yp4+G5KjTQOFdVuBgkw/rWFUfP6b9MwmtKS/0Gh2TZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAz8UgTj31lARSwIhNypPvRBNuXq9X0cQz5arPJfyMD6Q2kvIhr6ftEsVN/q73/vNVb+9wq+j7ZyEHq9xkGah5oiNLf+n/V4ukP05lLVT9iWjvvbOEmT+84FebLWxxqWxHbajhOK1h/k8Bz9YBqNVn4wxuuvop/+JWAcGZVOndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3wJSs8V; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743034542; x=1774570542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yp4+G5KjTQOFdVuBgkw/rWFUfP6b9MwmtKS/0Gh2TZk=;
  b=I3wJSs8VgGIO6M+Ce4NkOIinbOQMIBBCYRRokmEg9xRO26aJb2Dw9+cB
   nzd5Rs817vLeWxZlRpngoYYjFVA9QTPiDVSbhJ47A/aeWIGjJZS8htu03
   ZFgJ8IU6XzNyc2cXcvuITHNAxpNpIvd3xyogmHDsEJId0kAI+a9k1Xba3
   h9ReRpFX+UbwzqHGo2VOJajbjVFgDB+Z8mkPI62A5S1Wr1P+rXHsQJdxX
   oPu2ufJQOT9yG+lQj6RZhyGYmSZDInxNU7e7M0NIwU931N8VoXdJDmtKJ
   AhEjiztG1N8EicXa3RuKSYl0LBBdmrOp1+zkpDuEIb050/U24sS9E/rrd
   Q==;
X-CSE-ConnectionGUID: xEamGEDzSvKUsnXP8AG+5g==
X-CSE-MsgGUID: rC3ynOgpQsudkZzLZoXzBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55713474"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="55713474"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 17:15:40 -0700
X-CSE-ConnectionGUID: tDGfYwGmSN+1K/dCPUMUFA==
X-CSE-MsgGUID: ustTWhT2S1yp8avjw+6vrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125410525"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.8]) ([10.125.108.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 17:15:39 -0700
Message-ID: <3a28b0a6-3c7c-43b9-a592-111692d3c1bf@intel.com>
Date: Wed, 26 Mar 2025 17:15:37 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: idxd: shared workqueues and dmaengine
To: Kevin Krakauer <krakauer@google.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org
References: <Z-SWM-F0O9XU1zqp@google.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z-SWM-F0O9XU1zqp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/25 5:05 PM, Kevin Krakauer wrote:
> Hey, I'm trying to use idxd inside the kernel via dmaengine. I'm
> attempting to get shared work queues (SWQs) via dma_find_channel(),
> which stubbornly returns NULL.
> 
> After a lot of printk-ing, I finally ran across DMA_PRIVATE. I also
> found [1] and saw that DMA_PRIVATE is also set in the idxd driver since
> c06e424be5f51844 ("dmaengine: idxd: set DMA channel to be private").
> 
> It seems like this forces use of dma_request_channel(). But I believe
> the idea behind SWQs is that they don't have to be exclusively owned.
> 
> Is there a way to use SWQs via dma_find_channel()? dma_request_channel()
> seems like overkill, as the point of SWQs is to not be exclusive. Also a
> good chance I'm missing something basic here :)

+Vinicius, current maintainer of the driver.

So I think maybe a new sysfs attribute can be added to wq to allow the user to choose whether to make the channel DMA_PRIVATE or not. By default it can be set to DMA_PRIVATE to keep legacy behavior. I think that should solve the issue you are encountering?

> 
> Thanks!
> Kevin
> 
> 1 - https://lore.kernel.org/dmaengine/9714cb6c-8b37-4fc6-bb09-a1fb4a5bb1b8@intel.com/#R


