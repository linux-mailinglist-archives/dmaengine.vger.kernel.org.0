Return-Path: <dmaengine+bounces-4902-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E434A90706
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2414F3A8B3C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051561BC07A;
	Wed, 16 Apr 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeP50EyV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688A7E110;
	Wed, 16 Apr 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815179; cv=none; b=NIAL0Caa3H75bx5nAv5neo3p2Cgf7wl9mTwcSU4qp8RiJrpinoaAZEklKrFWJsQ/08ThdoGko0YjSTfukPshWUygh70QuAbm/NM/IQhgWP2Yb8ohZ4QJSN76gXNN0CsZOVNCV7fxpHWQCw5ZAqCz/w9ZM8iRa9VQXvR84ny1siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815179; c=relaxed/simple;
	bh=dQRzDOCOWeAZI269O7mZBC8YUADbKn6yXSiEb9sxGto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pXNx1kxrF7dYphJzER5b1kv4sirXE0usSti33Zz0U3vKt5kjyvJkonmeGlM5zJcu2ca8EnZGehV6zQjU/OCVolqAgWVqqgYlqVqjj06ML5G1Xd7jfCtliJWnkHN8YDv25OU7ny0NhIgBG+NfIfvDNM3KG5poIBc/4Govdp30+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeP50EyV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744815178; x=1776351178;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dQRzDOCOWeAZI269O7mZBC8YUADbKn6yXSiEb9sxGto=;
  b=SeP50EyVXCFPAfJeRb1sYWTs4s0Bc5T5TFOA70YwtXqBHeXHyR1wtAQI
   lbSOV6VIdh51DDufIATJHHSENEW3er/vCIGW097TK4yPchLWDWQfupo8W
   +sjMKk9pA7m3BsZG8F4LSHJt7MQXgJOz5f5OhWHtRXSW3VPUzqwIYjMlr
   63NkzhHZ1yIkaexOsi/epfzA7RlZBJFnrdEXvK5zeFtgdLniRy9suk3Ug
   ncqArcvzDXP3IlYe04uZ9nlIPV1sxOMArUnoF3oHrRMbNgLgtd9oz2xgb
   By0Ag8CbJPqzr2mi6T0JzW12T2/XvR+ZaZK2o+miShPXpf9azLHseX1a7
   Q==;
X-CSE-ConnectionGUID: uKHlem3kSRGpK6rugHMCgg==
X-CSE-MsgGUID: v73st26LQNq8c2auSAL/ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="45598332"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="45598332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 07:52:57 -0700
X-CSE-ConnectionGUID: d3NVo1dAQLq/G4H/xcPMDg==
X-CSE-MsgGUID: SsFmfosuROuFFFXO4pEkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="135492165"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.230]) ([10.125.109.230])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 07:52:55 -0700
Message-ID: <cb441778-0e22-4f83-bc02-ed139199c9b7@intel.com>
Date: Wed, 16 Apr 2025 07:52:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: idxd: Fix allowing write() from different
 address spaces
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250416025201.15753-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250416025201.15753-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/25 7:52 PM, Vinicius Costa Gomes wrote:
> Check if the process submitting the descriptor belongs to the same
> address space as the one that opened the file, reject otherwise.
> 
> Fixes: 6827738dc684 ("dmaengine: idxd: add a write() method for applications to submit work")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/cdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..373c622fcddc 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -473,6 +473,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
>  	ssize_t written = 0;
>  	int i;
>  
> +	if (current->mm != ctx->mm)
> +		return -EPERM;
> +
>  	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
>  		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
>  


