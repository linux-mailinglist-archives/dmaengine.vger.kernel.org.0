Return-Path: <dmaengine+bounces-5038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0361CAA0FE7
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6360A189C8D3
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD221C19D;
	Tue, 29 Apr 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hotZoS6z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21047218ABA;
	Tue, 29 Apr 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938901; cv=none; b=pxGAAEDr0Ub/mI8XqxRJMxzY3BCokzAVNbzJts5MD31FHKf4K4hTI+mfYDPFbNiIt2y4wRw5swx+aRIbNA6/s2gBbNjh0eYiSrGLxZgcmzh/BzP1ZFMD8bVQbo3/bKMagbhPKLwk9A+YkT+H9Bd5Fr3vGOvTSM78DCTzPbM4C20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938901; c=relaxed/simple;
	bh=WBGO6qtlYT2Z2kb+cLP+HKBVjtRmQwQarszBCne1EsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8zZHYarSkDPd1YQ07H2N7QvropDBVWlyiGk87yzL+aTGeJf6IdpxGttXewjBwjsNkWFhVAifzw610J/G18hizoHc2FWGWCynt4QXcOCh+lQP7QnTKjyMBSxtjhJK8kHRa/wTW5aw9BfJMgRSLbBextkLknAI1LBahVgGhyNKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hotZoS6z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745938899; x=1777474899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WBGO6qtlYT2Z2kb+cLP+HKBVjtRmQwQarszBCne1EsQ=;
  b=hotZoS6zygXvJp3ywf1o8F4AyTNEsQZZK21niUcF4XNo6jKd9oThdvew
   gsEKlvVqliLKJmL01EJpbeOdagGfjZCqR6oXMmoHshRGiHOkZ8dE+eis5
   Wd5Ov9u7Hjd6D2TjmnJZSE11ZdpakHEI9qU+6udk3GVrnLXqt9BbTjTs9
   8FION1JgrubQU6O4wOs+5xAlQ99J6t5Jp8k3pknf/32baIYR+zsESZdjH
   wpj7yk/KLAZFBb8H/nMABUTjedWpE0ndMaSJVtC0xZGBaZy7FOQ0Gf5YU
   KzQvWSU23XT7n47MH3wyuPie2/wSPbMp3EcgJ1ynVLn7LCpiI8QlasNNB
   g==;
X-CSE-ConnectionGUID: xgVn5NvUS0ubLszGL6RUdw==
X-CSE-MsgGUID: fykfJbW5T9WnnnFkmcyq1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47705635"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="47705635"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:01:38 -0700
X-CSE-ConnectionGUID: S3y+EOdjQrSRIEXDqfKYwA==
X-CSE-MsgGUID: taNjQ/q3TrmTxWceNp1oiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="133798041"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.191]) ([10.125.109.191])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:01:27 -0700
Message-ID: <c27685af-f308-4432-a380-a79cc9ad8a36@intel.com>
Date: Tue, 29 Apr 2025 08:01:24 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to
 ver. 1 only
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
References: <20250312221511.277954-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250312221511.277954-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/25 3:15 PM, Vinicius Costa Gomes wrote:
> Allow BATCH operations to be submitted and the capability to be
> exposed for DSA version 2 (or later) devices.
> 
> DSA version 2 devices allow safe submission of BATCH operations.
> 
> Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Hi Vinod, is this patch ok to merge? Thanks!

> ---
>  drivers/dma/idxd/cdev.c  | 6 ++++--
>  drivers/dma/idxd/sysfs.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..6a1dc15ee485 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -439,10 +439,12 @@ static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
>  	 * DSA devices are capable of indirect ("batch") command submission.
>  	 * On devices where direct user submissions are not safe, we cannot
>  	 * allow this since there is no good way for us to verify these
> -	 * indirect commands.
> +	 * indirect commands. Narrow the restriction of operations with the
> +	 * BATCH opcode to only DSA version 1 devices.
>  	 */
>  	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
> -		!wq->idxd->user_submission_safe)
> +	    wq->idxd->hw.version == DEVICE_VERSION_1 &&
> +	    !wq->idxd->user_submission_safe)
>  		return -EINVAL;
>  	/*
>  	 * As per the programming specification, the completion address must be
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6af493f6ba77..9f0701021af0 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1208,9 +1208,11 @@ static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *
>  
>  		/* On systems where direct user submissions are not safe, we need to clear out
>  		 * the BATCH capability from the capability mask in sysfs since we cannot support
> -		 * that command on such systems.
> +		 * that command on such systems. Narrow the restriction of operations with the
> +		 * BATCH opcode to only DSA version 1 devices.
>  		 */
> -		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
> +		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe &&
> +		    confdev_to_idxd(dev)->hw.version == DEVICE_VERSION_1)
>  			clear_bit(DSA_OPCODE_BATCH % 64, &val);
>  
>  		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val);


