Return-Path: <dmaengine+bounces-10956-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H97FKC0FWpxYAcAu9opvQ
	(envelope-from <dmaengine+bounces-10956-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:56:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D55D81E9
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD333003413
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636453FF88A;
	Tue, 26 May 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE39uIiv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072B3FF8BE;
	Tue, 26 May 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806954; cv=none; b=p9NU9udrjIGuurm8ta/B2pN4jIn8mXcmBFmb5j9h7df1zyJN0dNr56govBbMZ9znLrej1fonufdD2FyiftLgdU9/yURI5vm9Dxbgr+sMGXQ5ENNpym+BWHbYkG/iXIb/7bBaA4Chqsb7YlKIcMsQKPEgqZEWqCArdwDZsCI/D2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806954; c=relaxed/simple;
	bh=S/bbYY63e2x5qHcXV3JnvP/utXpDTgekaSGUMFwMp4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UytnXwyvbnruFXWN/+o4S5nfBkWV3tvLNE/wo1TGJUxloBVcsVFsDkX+liCecSFzWhwLIoIG5w9UjvYn2woU0MLEDkJHunAriHiMZx2HA7HDe1jzlVTpGklwAaqRUwp/VgDBb9ITQihPDNjB7knm5nv2FUT1nMMOepXpCZ/+W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE39uIiv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779806953; x=1811342953;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=S/bbYY63e2x5qHcXV3JnvP/utXpDTgekaSGUMFwMp4g=;
  b=gE39uIivpncrFZdGdV0mUz/G6wZQ5PvFGNiV6PLnfJGxTfpylMDzvtdk
   yMFgMy6c8fmYh3YLDc2AA1xwhA1yCiWnyVV1bda9sDpzsj7R1RKA58jun
   dUYrBkTrSPYM/rvT3Psk2t9JFXgpc2rvdFlUWvTaO3Rg7SfJyk2pD6dgR
   OqQlstVcWwoOMw8Y/hLXW/CDiTNfY1iDJhUSo4e0RCqX5h2CA2Dvs4X1s
   b7cX3Klyx0iGCfqpoypQHawjsv+ljY52qMvsCBF/c9kq63ap8mYYDClml
   +bKIKKVIEebaNM1cgzt7RgqnZbA3cRvQMkSq+rA9oMWtvNZU9Ocwe8sam
   w==;
X-CSE-ConnectionGUID: 43xCK37uRZ+Dr+klxa7Suw==
X-CSE-MsgGUID: 0ZjK8UDrTiqYmFcfjbV9Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80680229"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80680229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:49:12 -0700
X-CSE-ConnectionGUID: v3H7+Q7CQyax5/H0NfgCfA==
X-CSE-MsgGUID: CNLe7ZNwRK+uy3GuQ/HptA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="265796824"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:49:11 -0700
Message-ID: <9461e4b3-d42b-4550-a931-19532588bdbc@intel.com>
Date: Tue, 26 May 2026 07:49:10 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ioatdma: use !kstrtoint(), not sscanf()!=-1
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Ujjal Singh <ujjal.singh@intel.com>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260526061321.6123-1-grandmaster@al2klimov.de>
 <20260526061321.6123-3-grandmaster@al2klimov.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260526061321.6123-3-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-10956-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: C15D55D81E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 11:13 PM, Alexander A. Klimov wrote:
> Depending on the user input, sscanf() may return 0 for 0 success.
> But intr_coalesce_store() wants sscanf() to parse one number,
> so expect 1 from sscanf(), not any int except -1.
> 
> While on it, fix typo in %du by using just %d,
> as this interface expects %d or %d\n.
> Latter made scripts/checkpatch.pl complain,
> so use kstrtoint() instead of sscanf().
> 
> Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  drivers/dma/ioat/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f..f59df569956a 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -144,7 +144,7 @@ size_t count)
>  	int intr_coalesce = 0;
>  	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>  
> -	if (sscanf(page, "%du", &intr_coalesce) != -1) {
> +	if (!kstrtoint(page, 10, &intr_coalesce)) {

looks good. We can probably use kstrtouint() since we are expecting a positive number always.

DJ

>  		if ((intr_coalesce < 0) ||
>  		    (intr_coalesce > IOAT_INTRDELAY_MASK))
>  			return -EINVAL;


