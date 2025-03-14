Return-Path: <dmaengine+bounces-4745-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13BA60751
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77853BFCF4
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C317BB6;
	Fri, 14 Mar 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKU68edW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AA4400;
	Fri, 14 Mar 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918167; cv=none; b=qJC6EjpS4TSuHFTNWRBeOfXcCDCUAdhvIFYGKdhBdRTRvktGyHfrwAVqcbUbPTrj2fdazZCvWLGTSPyHOl5xnADwEBmWpxZg4WOwIkgeYaavS7dgCJ9VWuf2WpykOZZ59hsJ0xfLtfsmGmyYtdtY0pqxV4lA8GrgJe1XLrY7AnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918167; c=relaxed/simple;
	bh=+ahwCN/MbrAvZFfTfOqQK4jPn/+7f26E5Ddpts2pEDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBV7sCAG5C5bIRVV/2n+SR6x84YNbXxkyWt/UtsfuVAXttDurS5MuKu15JeruY5+o+YDyiPbdjLEblVlnPuBQ5VRBaNYxyKQ6fC40Y3LvgsOw/Jc1wpAsrGn4SrDH9f2AN78RiBMcRO8mV0f/PKr/OYFdRHGHASWBI07UHP4hU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKU68edW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741918165; x=1773454165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ahwCN/MbrAvZFfTfOqQK4jPn/+7f26E5Ddpts2pEDc=;
  b=RKU68edWahMBYTXcAE04zTDlTLbU8fmWT+PJY1Id6wg3aNelOSLBveOw
   kFkJN1Sb0om0jRK22zqhaEj2SBwZWhx347rSUTWY5E79yS0PuircC//LY
   V5HOoea1rskOFbqfmECbhUc4tIeNjUwHZivM79GXVcC4eT93n4W4hRl3W
   OkiGd+EPMucLK8fa3TZQz3gg88fp+1Leoud7auht9VpGD0uyanab8VUw8
   gK2WgPOeAz/jcjKEb5TB20YQfVpLESDhbrM/DDsBxcFJlW2wM70Xk90Cf
   Jv4OGmD+AsevdMGheB1JZbdACxBMwxucZZrYUTnKH5AZUUO54kXeSe/4U
   g==;
X-CSE-ConnectionGUID: P4jrwCefQjqqzS2oZ2QE4g==
X-CSE-MsgGUID: grv0KGWGTUiC78JRGthbcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60461020"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60461020"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 19:09:25 -0700
X-CSE-ConnectionGUID: 4SgI1ZABQzm3hpN2c4M8YQ==
X-CSE-MsgGUID: caBE07hYT8qJgD/oDumG1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="144321717"
Received: from ysun46-mobl1.sh.intel.com ([10.239.161.21])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 19:09:23 -0700
Date: Fri, 14 Mar 2025 10:09:20 +0800
From: Yi Sun <yi.sun@linux.intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to
 ver. 1 only
Message-ID: <Z9OP0F43CboAIxrJ@ysun46-mobl1.sh.intel.com>
References: <20250312221511.277954-1-vinicius.gomes@intel.com>
 <3ccbe50e-e47e-4406-885e-600bd193a23c@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <3ccbe50e-e47e-4406-885e-600bd193a23c@intel.com>

On 12.03.2025 15:18, Dave Jiang wrote:
>
>
>On 3/12/25 3:15 PM, Vinicius Costa Gomes wrote:
>> Allow BATCH operations to be submitted and the capability to be
>> exposed for DSA version 2 (or later) devices.
>>
>> DSA version 2 devices allow safe submission of BATCH operations.
>>
>> Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reported-by: Yi Sun <yi.sun@intel.com>
Tested-by: Yi Sun <yi.sun@intel.com>
>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/dma/idxd/cdev.c  | 6 ++++--
>>  drivers/dma/idxd/sysfs.c | 6 ++++--
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index ff94ee892339..6a1dc15ee485 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -439,10 +439,12 @@ static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
>>  	 * DSA devices are capable of indirect ("batch") command submission.
>>  	 * On devices where direct user submissions are not safe, we cannot
>>  	 * allow this since there is no good way for us to verify these
>> -	 * indirect commands.
>> +	 * indirect commands. Narrow the restriction of operations with the
>> +	 * BATCH opcode to only DSA version 1 devices.
>>  	 */
>>  	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
>> -		!wq->idxd->user_submission_safe)
>> +	    wq->idxd->hw.version == DEVICE_VERSION_1 &&
>> +	    !wq->idxd->user_submission_safe)
>>  		return -EINVAL;
>>  	/*
>>  	 * As per the programming specification, the completion address must be
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 6af493f6ba77..9f0701021af0 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1208,9 +1208,11 @@ static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *
>>
>>  		/* On systems where direct user submissions are not safe, we need to clear out
>>  		 * the BATCH capability from the capability mask in sysfs since we cannot support
>> -		 * that command on such systems.
>> +		 * that command on such systems. Narrow the restriction of operations with the
>> +		 * BATCH opcode to only DSA version 1 devices.
>>  		 */
>> -		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
>> +		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe &&
>> +		    confdev_to_idxd(dev)->hw.version == DEVICE_VERSION_1)
>>  			clear_bit(DSA_OPCODE_BATCH % 64, &val);
>>
>>  		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val);
>
>

