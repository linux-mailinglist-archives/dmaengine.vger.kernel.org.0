Return-Path: <dmaengine+bounces-3685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B59BB8C1
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 16:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14F91C2217F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2761BD4E1;
	Mon,  4 Nov 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzx66vva"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877431531EA;
	Mon,  4 Nov 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733507; cv=none; b=cF+A9d23N37uEPdG6kU6OX4K/i6yiiD7Bi3gWqoeRjM8nk4e0OQl8E/5uVr3691UtEvnn9I01fk1FgC1uMmdU2qjx4qvQNJExSTMXoXZRbSffGDqgkrb0Cs7O5+in/4maLDB7r/XDJkUQkqZGK71kgdzilOHtdiWjs+VLO4XIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733507; c=relaxed/simple;
	bh=qWlIxJlDQefOcYZezqv3pTjAXZOrS/1t8kQimOUSHg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo8Peo7R7yTznSoZtVQ+erhK59u2sSTPcahmj6gW2MFqMP2HZCr71/d8aL+wY23IyRPhyBYPdAdB2Zyq5Fqat0F/AhWKfZTAXGtJO3AKZtSzheC00ITkUdq6Whw7DbMtcauAmN2isJbIbuYg5HdVSM8eCwmbo9wKIJxOws+XYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzx66vva; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730733505; x=1762269505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qWlIxJlDQefOcYZezqv3pTjAXZOrS/1t8kQimOUSHg4=;
  b=mzx66vvalcmFgtJ3bg86UBp3dbiLZ+JjkJ79Q+P/4xyrmAamm6wAwXw5
   UACgEQiCNjgbNTxtkyVglAnS9SDgG9B2QR6eTe4eFfJ4svabqzljt2Wot
   u+qiuJlksHAL+gUtf6fILcTdejbK6iDkyuAvBFUeZYiRDNU8ZT2E9HnwL
   zj8gggPFVRuaVN+XIaLh8qQXoHJ0wxiUMab5eS7oBAeRabqYyYOTY/5Tc
   kcFfjfm99wYftfEtBhrq442R4LzUFM1x8zP6VPbBtdhCHoubm/MEK7DgC
   29JyYfHqnsd0bvSDZ+OmXOMI8kG+iio5RoX6YLYg5r54QM7LI1UfpIuej
   A==;
X-CSE-ConnectionGUID: geQ4wmbnRA2zqsv1PS0Cog==
X-CSE-MsgGUID: viWa4IRCT1+ouGUx/+XwbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33272953"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="33272953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 07:18:24 -0800
X-CSE-ConnectionGUID: RAGfsD2fR8qeKt25UpePUA==
X-CSE-MsgGUID: LMK8OXWhRiK4et3Y7Cqkhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83797907"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 07:18:25 -0800
Message-ID: <a9d10969-0b74-4fa1-8f3d-6fc2c7a475a7@intel.com>
Date: Mon, 4 Nov 2024 08:18:23 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Remove a useless mutex
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dmaengine@vger.kernel.org
References: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/24 4:46 AM, Christophe JAILLET wrote:
> ida_alloc()/ida_free() don't need any mutex, so remove this one.
> 
> It was introduced by commit e6fd6d7e5f0f ("dmaengine: idxd: add a device to
> represent the file opened").
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> See:
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
> ---
>  drivers/dma/idxd/cdev.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 57f1bf2ab20b..ff94ee892339 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -28,7 +28,6 @@ struct idxd_cdev_context {
>   * global to avoid conflict file names.
>   */
>  static DEFINE_IDA(file_ida);
> -static DEFINE_MUTEX(ida_lock);
>  
>  /*
>   * ictx is an array based off of accelerator types. enum idxd_type
> @@ -123,9 +122,7 @@ static void idxd_file_dev_release(struct device *dev)
>  	struct idxd_device *idxd = wq->idxd;
>  	int rc;
>  
> -	mutex_lock(&ida_lock);
>  	ida_free(&file_ida, ctx->id);
> -	mutex_unlock(&ida_lock);
>  
>  	/* Wait for in-flight operations to complete. */
>  	if (wq_shared(wq)) {
> @@ -284,9 +281,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	}
>  
>  	idxd_cdev = wq->idxd_cdev;
> -	mutex_lock(&ida_lock);
>  	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
> -	mutex_unlock(&ida_lock);
>  	if (ctx->id < 0) {
>  		dev_warn(dev, "ida alloc failure\n");
>  		goto failed_ida;


