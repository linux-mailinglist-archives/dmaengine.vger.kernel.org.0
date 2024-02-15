Return-Path: <dmaengine+bounces-1019-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A03856927
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C19D288AF6
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3F13342A;
	Thu, 15 Feb 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpqIRu28"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EE131E23;
	Thu, 15 Feb 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013247; cv=none; b=ewxra0tTOkfolzVKDORMGFuacIMCBeLlhzla1Lo8ut+Ro8qrD+mR+K4zsz4UYjQ0JW3ogu1Zfatu8jcgvXUo7oWxBh6OU5kb65YmHHpGIbDe/4P3cxpUpM6HiH1F6F95DlOmHJKA3rCoiAdtVoSAugp3mjw20kEJUu66wIOmpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013247; c=relaxed/simple;
	bh=bX0WSp5usPgKDpNCMxLWwyyg6EnfaeMFJnUbjbX+wh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkQEIOHFvaWipJ7a68etz+o8xeDoTB4hjRESvLUbuhI157x1n/6vJsbHrJB2JczCAaV0XlwfPVHleRaR1iBHvJCmy40/KeoTQhLQDVtU+yDWogwFE+WNWMZBqR80PFKxTn5R+BE9yRMhGJb2CBQ2w/H97SzauTEqWQGS9k+obPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpqIRu28; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708013245; x=1739549245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bX0WSp5usPgKDpNCMxLWwyyg6EnfaeMFJnUbjbX+wh4=;
  b=YpqIRu286QUrZnSaGnXFNkwdiEbH8xKimsYPReRDItRQ7f/InuKlPr1F
   Tiq01NBc1qaMmfkAMHOfqvN6CNo3kl4qi/jSrWJa5YKpm8Hjqy0Zw1aHL
   D/rmgXOXmP/7AQ+HhFU0VZACwkbrFSF7qQutYSvdSkC1MrjQ4qAW0ZQcQ
   oisCsnLxsek2z/hn4NMHaPe8QUiXUzSzM6zSrkLKTZWtor1BZyKDSj6qj
   8EQOG/NgAdzuo2nqFTKwXEnL7N4aIhr6cBXxApQelxYfaAc4sDWd0hQ5P
   0dlFGdL30t8qnEndR863Z4JENxn0wvQd05n6PliA20v1px9JCF0CNlIS4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2234965"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2234965"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="26725514"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.87]) ([10.246.113.87])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:06:29 -0800
Message-ID: <57689db8-3793-484a-9c85-bdbcec1d36ae@intel.com>
Date: Thu, 15 Feb 2024 09:06:27 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: Remove shadow Event Log head stored
 in idxd
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240215024931.1739621-1-fenghua.yu@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240215024931.1739621-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/24 7:49 PM, Fenghua Yu wrote:
> head is defined in idxd->evl as a shadow of head in the EVLSTATUS register.
> There are two issues related to the shadow head:
> 
> 1. Mismatch between the shadow head and the state of the EVLSTATUS
>    register:
>    If Event Log is supported, upon completion of the Enable Device command,
>    the Event Log head in the variable idxd->evl->head should be cleared to
>    match the state of the EVLSTATUS register. But the variable is not reset
>    currently, leading mismatch between the variable and the register state.
>    The mismatch causes incorrect processing of Event Log entries.
> 
> 2. Unnecessary shadow head definition:
>    The shadow head is unnecessary as head can be read directly from the
>    EVLSTATUS register. Reading head from the register incurs no additional
>    cost because event log head and tail are always read together and
>    tail is already read directly from the register as required by hardware.
> 
> Remove the shadow Event Log head stored in idxd->evl to address the
> mentioned issues.
> 
> Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Much better fix.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> Change Log:
> - A previous patch tries to fix this issue in a different way:
> https://lore.kernel.org/lkml/20240209191851.1050501-1-fenghua.yu@intel.com/
>   After discussion with Dave Jiang, removing shadow head might be
>   a right fix.
> 
>  drivers/dma/idxd/cdev.c    | 2 +-
>  drivers/dma/idxd/debugfs.c | 2 +-
>  drivers/dma/idxd/idxd.h    | 1 -
>  drivers/dma/idxd/irq.c     | 3 +--
>  4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 77f8885cf407..e5a94a93a3cc 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -345,7 +345,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
>  	spin_lock(&evl->lock);
>  	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
>  	t = status.tail;
> -	h = evl->head;
> +	h = status.head;
>  	size = evl->size;
>  
>  	while (h != t) {
> diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
> index 9cfbd9b14c4c..f3f25ee676f3 100644
> --- a/drivers/dma/idxd/debugfs.c
> +++ b/drivers/dma/idxd/debugfs.c
> @@ -68,9 +68,9 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
>  
>  	spin_lock(&evl->lock);
>  
> -	h = evl->head;
>  	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
>  	t = evl_status.tail;
> +	h = evl_status.head;
>  	evl_size = evl->size;
>  
>  	seq_printf(s, "Event Log head %u tail %u interrupt pending %u\n\n",
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 47de3f93ff1e..d0f5db6cf1ed 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -300,7 +300,6 @@ struct idxd_evl {
>  	unsigned int log_size;
>  	/* The number of entries in the event log. */
>  	u16 size;
> -	u16 head;
>  	unsigned long *bmap;
>  	bool batch_fail[IDXD_MAX_BATCH_IDENT];
>  };
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index c8a0aa874b11..348aa21389a9 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -367,9 +367,9 @@ static void process_evl_entries(struct idxd_device *idxd)
>  	/* Clear interrupt pending bit */
>  	iowrite32(evl_status.bits_upper32,
>  		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
> -	h = evl->head;
>  	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
>  	t = evl_status.tail;
> +	h = evl_status.head;
>  	size = idxd->evl->size;
>  
>  	while (h != t) {
> @@ -378,7 +378,6 @@ static void process_evl_entries(struct idxd_device *idxd)
>  		h = (h + 1) % size;
>  	}
>  
> -	evl->head = h;
>  	evl_status.head = h;
>  	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
>  	spin_unlock(&evl->lock);

