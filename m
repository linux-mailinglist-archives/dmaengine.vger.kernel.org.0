Return-Path: <dmaengine+bounces-2206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216738D3B93
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CEE1F28BA2
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BA181BB3;
	Wed, 29 May 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbmVeews"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586F180A92
	for <dmaengine@vger.kernel.org>; Wed, 29 May 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998388; cv=none; b=OgHWKuitJm+4gQg0av7nbWvjfT3PDCEIJlPUPgstS9h9/DrSi315SvPLk+abv31fL0m5uUnj/vrJVwKIbz3GNtMV4sLeOFzksGt94L+eqYaGRC+ggrRIDr0XteiRRvr0u5toVmQZ0elJ5ggoSvAvSzhUV8imq50DcCv0gs4CTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998388; c=relaxed/simple;
	bh=ntTPRd1wPazSgVJYdTAmKqNELKCLlNfYcCG1CKdR140=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cMN6QB0RTuiSaZkIkFhSVoQWOZ9PcHb/CmkqgwgIF7QJL/XAUQ5g97+45v/MXdmwYapPw3xS/u1SJfi0bDQeAOgN/4pU5WRfcfM5kFqeIwVOaxNT4/SZpVsv3XQnA5u9FBRqHIwLY5VMm+DwUgjBiYbIratkmJ/yh4JPWugCKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbmVeews; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716998386; x=1748534386;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ntTPRd1wPazSgVJYdTAmKqNELKCLlNfYcCG1CKdR140=;
  b=mbmVeewsnwWg1YSHucQTrx4VGXtopcasohKUl7JoeDj55Y1fdSgtCfbe
   LBLONYlrPaaaZOR4baSPnsIU1kHrX2IFAx8m8uugUpiqku9E+Tj0WijIa
   VWplKTIQemzYxQIYxj4hQshNJhVFDehwf1mi4kBXu1xJNEmvll7JK43Pz
   4yW6hEMKVy5vdxGrJJmXsikILBhLUf0rkNaSEbGqRRL/DdSzSCUyHsdvU
   CB3tcUrdRHURv3/2SDkV3srVhPtkhpcVftddNOUbCU+O3swXqw+23L+7u
   g9/FJWh1/ILOia4GxjiHM4Sj8qL7MWMzSADyO4Et2Yc2LUkrwvU+MpIOr
   Q==;
X-CSE-ConnectionGUID: 7qjbs2JkSpaI/GmaIouNUg==
X-CSE-MsgGUID: 9axgpq5/T22TKq21V/OENQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24067589"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24067589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:59:45 -0700
X-CSE-ConnectionGUID: gN2DtPa1TfqyYHYNhRV7lA==
X-CSE-MsgGUID: 29wg+MUzQYWc5DGQvdurag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="72940478"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.117]) ([10.125.111.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:59:45 -0700
Message-ID: <a68ea6a3-848e-4e99-a58b-00f72b11d448@intel.com>
Date: Wed, 29 May 2024 08:59:43 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
To: Li RongQing <lirongqing@baidu.com>, fenghua.yu@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20240529091828.40774-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240529091828.40774-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 2:18 AM, Li RongQing wrote:
> list_for_each_entry_safe() should be used when the descriptor will be
> freed in idxd_desc_complete(), Otherwise the freed descriptor will be
> dereferenced to get its next, and always deletes freed descriptor from
> list firstly
> 
> Fixes: 16e19e11228b ("dmaengine: idxd: Fix list corruption in description completion")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/dma/idxd/irq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 8dc029c..5571de1 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -573,6 +573,8 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
>  			 * Check against the original status as ABORT is software defined
>  			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
>  			 */
> +			list_del(&desc->list);

I don't think this is needed. The iterator is working over a detached llist and nothing to do with 'struct list_head'. Otherwise everything else look ok.

> +
>  			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
>  				idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
>  				continue;
> @@ -611,11 +613,13 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
>  
>  	spin_unlock(&irq_entry->list_lock);
>  
> -	list_for_each_entry(desc, &flist, list) {
> +	list_for_each_entry_safe(desc, n, &flist, list) {
>  		/*
>  		 * Check against the original status as ABORT is software defined
>  		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
>  		 */
> +		list_del(&desc->list);
> +
>  		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
>  			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
>  			continue;

