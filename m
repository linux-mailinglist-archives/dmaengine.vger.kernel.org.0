Return-Path: <dmaengine+bounces-4725-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F77A5E733
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 23:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3443B1728F9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AFC1E2823;
	Wed, 12 Mar 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPo1n7Zx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D51E230E;
	Wed, 12 Mar 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817914; cv=none; b=IBYZj2lUsjy5+k7rAVYU8h2AviS0aIXAJ38398qb25nZeq5o4iun0ZgGWuinkQVh27uxDR7EsGyD6HiH7R1e+aDstgh3rU5fXKgXuJLsqp/WOJj+Yal5/0L7i6mgOe8spXvE8aixTjGyTMt5TAfR3F0709Drqg93tAMh7msJk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817914; c=relaxed/simple;
	bh=umGyd9dGgG1iVdZfeR9uRIXl4JoSVzVfIc6kq+8w5rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFyPXzRFTvkEDzkkYRPNV0iXRw9dvF8x8m+xtZ7xSC+FLXIh++TSnUmfqiuUSv9riJZl2Nf1pDAIiUyCWFNRtdIMPlFn4SSRgkhDeOF5LkGsJ/VmpD1WWq7Ar0pmnZC/b/hDAd4sdz/Ys1k2IMCSiurF9d6yiai18iZsmCB55rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPo1n7Zx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741817912; x=1773353912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=umGyd9dGgG1iVdZfeR9uRIXl4JoSVzVfIc6kq+8w5rU=;
  b=RPo1n7ZxfsmdSV8WdQuPkF900nz/yGUiWr9VFIsJ9r3YLv1l5VUzUf+x
   HTqjicRfERWVrGe2K0WRHL+03ZDv+xsEibVVJaNdK0NODhcjctMzKPFvf
   jvX+Nq3P2Ugl02QH6tFfwXniApd+fCXRQhIbjFaLvN3wQePlvoh8wIrq3
   Hk3JmrfiMotGW/AZDJ6uL7Yyl+n99x+lw9joQps8ElLHGPRC+ij0hN5in
   thtoPl+8nYdOPrZO41siM6WwzVFm2YYeRUXBbc3xEskBocGoo4aQ/8XCj
   knHsnA71GIiBLOcu+Vz+nV/05FBZ8TOI8+SKZQsFHZf+sow+LhDhekj0X
   Q==;
X-CSE-ConnectionGUID: UbVUZ1C/Qj6kxE21r0HtkA==
X-CSE-MsgGUID: DwkrvRv6T0CP1sVnNzgEbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43118858"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43118858"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:18:32 -0700
X-CSE-ConnectionGUID: /m2r7D2hROuH6A922KqJzQ==
X-CSE-MsgGUID: vvpG4q3UTdi1iiwfZXYEbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151591246"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.8]) ([10.125.108.8])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:18:32 -0700
Message-ID: <3ccbe50e-e47e-4406-885e-600bd193a23c@intel.com>
Date: Wed, 12 Mar 2025 15:18:28 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


