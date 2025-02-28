Return-Path: <dmaengine+bounces-4623-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44FFA4A52B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 22:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFE3A433A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A61DB361;
	Fri, 28 Feb 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BApyKuhX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6E1CCEDB
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778797; cv=none; b=gbYB9ZtJ8ZWSJIEZyfQ0IxDpWYXdBDLxhdfw3a6erF66TnTMyvBRUjfG/w3PvrA9aNQHSioCWZCWqSKLvT50h90yYigdWPJSVbHJj2oZpw2UmR6pAqnoQ5z2XLQa0dTNddq58ffi93qnDIKSqDSm4bEhiIo+lRIJ18UUmb4dxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778797; c=relaxed/simple;
	bh=EthtB24kxQxcfzijkjY6PWpENzshrzU0taNs4bamVio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O6xPcsRA/6k2mc8XeEKRQxr8hizpEA0OlKP7zenVVHuM6nVUt0Oa0a9s++EWRqXSaZocpWsBLCUjGJ62s+S3ycJW9V2adgJ1BMHf0qYhoC+g4K2qlU8TNHkKFxkKMrg0neGlTK/uZDD/tq0sFKdGn/YP2SgX8LT59Rhgw6EeHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BApyKuhX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740778795; x=1772314795;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=EthtB24kxQxcfzijkjY6PWpENzshrzU0taNs4bamVio=;
  b=BApyKuhXhjGYaoAy9CBGUnPl/u//hRxdYjNZxXSIw/9SZtm1uooqfopV
   tzYd9FyINJeuVPHKMsLw1iWPzzV8dwYEUvJlOQwLKulB9tmSMvB3RaLzF
   oeia3LlzH9ViwNTJbpckZ55sL/dJqQlaXFCWOYnD8b694dHVkNk8ZO6PO
   fwMxHipN6JIq/tWm5IvBukoov9iLnRfBiIqZ3lExGfZFAlJUo+CxLcRl6
   p/6g38N8EzD0KTkp1r94yQZCL+lfNa+BH9k749VtBgE+PI2oIyffgEiEp
   8ApiDY/VJGdNWplx98Cdmbu/awuSEdUED3J7FZr9A+VRMmX8cT5lsaLhP
   Q==;
X-CSE-ConnectionGUID: 2scKAJhJTd65Ly2tCrMNwA==
X-CSE-MsgGUID: JZN+K2LORn2k59n9FNIeVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41848994"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41848994"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 13:39:55 -0800
X-CSE-ConnectionGUID: D8W4kaCIQEWAu3+N9e2eKA==
X-CSE-MsgGUID: qTExyfCwQcWKxBrjRbQexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117437599"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.153]) ([10.125.108.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 13:39:54 -0800
Message-ID: <4e32d831-b4d1-4a5a-905e-05858ce0be2a@intel.com>
Date: Fri, 28 Feb 2025 14:39:51 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_find_channel(DMA_MEMCPY) on ioat
To: Carlos Sergio Bederian <carlos.bederian@unc.edu.ar>,
 dmaengine@vger.kernel.org
References: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/25 2:23 PM, Carlos Sergio Bederian wrote:
> I work at an HPC center and I've been trying to figure out why the
> knem intra-node communication kernel module stopped being able to use
> IOAT to offload memcpy at some point in time, presumably a long time
> ago.
> The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan so
> I wrote a test kernel module that tries to grab a dma_chan using both
> dma_find_channel and dma_request_channel and then submits a memcpy.
> dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
> dma_find_channel never does, regardless of order. This is on a Debian
> 6.12.9 kernel.
> Is there anything I'm missing?

Does dmatest work for you? Also, make sure dmatest isn't loaded when you have your module loaded. Or any other kernel module that uses dma like ntb_transport isn't claiming the channels. 

DJ
> 
> static struct dma_chan* dma_req(void) {
>     struct dma_chan* chan = NULL;
>     dma_cap_mask_t mask;
>     dma_cap_zero(mask);
>     dma_cap_set(DMA_MEMCPY, mask);
>     chan = dma_request_channel(mask, NULL, NULL);
>     if (!chan) {
>         pr_err("dmacopy: dma_request_channel didn't return a channel");
>     } else {
>         pr_info("dmacopy: dma_request_channel succeeded");
>     }
>     return chan;
> }
> 
> static struct dma_chan* dma_find(void) {
>     struct dma_chan* chan = NULL;
>     dmaengine_get();
>     chan = dma_find_channel(DMA_MEMCPY);
>     if (!chan) {
>         pr_err("dmacopy: dma_find_channel didn't return a channel");
>         dmaengine_put();
>     } else {
>         pr_info("dmacopy: dma_find_channel succeeded");
>     }
>     return chan;
> }
> 


