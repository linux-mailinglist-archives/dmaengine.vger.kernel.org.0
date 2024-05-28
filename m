Return-Path: <dmaengine+bounces-2198-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F248D21A1
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36CC28715E
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ACB172BC6;
	Tue, 28 May 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9QplL1m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E018173343
	for <dmaengine@vger.kernel.org>; Tue, 28 May 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913677; cv=none; b=XG9KWfzS2tkAEgjW7pPPbT6hgSPBkPLDqfCiuILzhKzMK2JNRdwx2hC58XoiZ9ZIF8dviU0LT4yyGmEvlKx8geLr0OY+6ou6eXfoY0AAUQ4Mev614jr0iIiL2+8Q0FTsOguWYDn+0Kk8ZJZ3rkprg36T6onnvdIBqsleEBhtblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913677; c=relaxed/simple;
	bh=xLxJeV1ZJwAhynQefY8tugyNuEtfKI67l/d8IIMM7/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XDg1grPL3Jq3K77YTrF9/0M6JyyRvTWf+2y6JBki8oCVCgGU7IMW3W8ry8VexZj00c4rY7KNB+hTZb5DoPhy67es9S5mBSAr9MmWdBeX4TGl6n3ggsvhcB9VEPT++e4U+OBWbXzvwV8bnmGUgfuGG8bs+Xezz2LlCCF12NOITVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9QplL1m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716913676; x=1748449676;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xLxJeV1ZJwAhynQefY8tugyNuEtfKI67l/d8IIMM7/k=;
  b=X9QplL1m24pl5FiMuhiGcpSFjOVF7kZVp4PJbpGovyEbEv3Fl+j9MnNd
   zo6jKTRsmLinBOnM2Azdq8JKvgmdGMhaGJP5al1G5jZUrIb2JWwuPpigd
   Q5G/L48Aj7qJyvpTkTywYVe/J+5f0mHcs9RusL6iu5v9h2IoAzpveVXyi
   TZSlJNSKrHrKFE1WH4eLJBk9imHtRMcRjZnjiZ+PX6RdjB4WD26hwZxGp
   ABa2rFvpDisgnKe4IwP7Crdxdn10oSRoG/M4CfzMMeZGwocvvzhvBj/xK
   8e/doiMSw+qiK72SPfu3QT+GkENrnYj9M0G4hcdFpkQuv+n077TQLKrA3
   g==;
X-CSE-ConnectionGUID: czFTdfFZTm6asMoL7iExdA==
X-CSE-MsgGUID: 97/s9LIsSra2RWfY9IV0bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38654226"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="38654226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 09:27:56 -0700
X-CSE-ConnectionGUID: +IOPkmYHQHaLj5V+19teWQ==
X-CSE-MsgGUID: ylPdScNKSWCIVYcynMYfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35105109"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.9]) ([10.125.111.9])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 09:27:55 -0700
Message-ID: <7b96aa7d-4e23-40dd-81de-1e60660c02dd@intel.com>
Date: Tue, 28 May 2024 09:27:48 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
To: Li RongQing <lirongqing@baidu.com>, fenghua.yu@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20240527061920.48626-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240527061920.48626-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/26/24 11:19 PM, Li RongQing wrote:
> I think when the description is freed, it maybe used again because of
s/description/descriptor/

> race, then it's next maybe pointer a value that should not be freed
> 
> To prevent this, list_for_each_entry_safe should be used.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/dma/idxd/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 8dc029c..0c7fed7 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -611,7 +611,7 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
>  
>  	spin_unlock(&irq_entry->list_lock);
>  
> -	list_for_each_entry(desc, &flist, list) {
> +	list_for_each_entry_safe(desc, n, &flist, list) {
>  		/*
>  		 * Check against the original status as ABORT is software defined
>  		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.

I see what you are pointing at. I think you will also need a
list_del(&desc->list);
immediately after the comments.

Because if the descriptor is freed and given out to a different thread while the code is still walking the list, the iterator may hit a bad pointer due to the freed descriptor pointing to something else.

Also, please include a Fixes tag for the fix. Thanks!

