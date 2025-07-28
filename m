Return-Path: <dmaengine+bounces-5876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B814CB13DBD
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8BF7ABD64
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4726265CA7;
	Mon, 28 Jul 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2uKYBqZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF034CF5;
	Mon, 28 Jul 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714610; cv=none; b=d1Hxjz+gsjcg8wKuJXjiqkeD4QEjA0evo7NEapgFrNse/O9stguIKKONy9Z+zWdvUQnbTwYF9ZIyxg7lBrTXUM/YHkc5+7NK/pivIP87lqD90lXuGiaMBZ7fJYwqMzGW104W/v/lgKnndFxIwrKG/UMWAyh2qciwOhsWmZHDAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714610; c=relaxed/simple;
	bh=lemBY4l6wdkMDk5M3ocSughZIWxUtsJj/ImE3tE5Gk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns+a/Y/6PArnE9ZHZAccRSm4Gw2LeuAzYgjbCzGxNLFxNwaR4CkEff0xc4ypbpNcmgyeX4KoACjoDsGEq1JZNwnaBYm+t3U9QgfzdrrmEiWJeKAwqEhfr1ar8d66IswFFTGQe17S7kg5fVSjpbT5I94CiGtdcmJ1Zrj4tsDjzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2uKYBqZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753714609; x=1785250609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lemBY4l6wdkMDk5M3ocSughZIWxUtsJj/ImE3tE5Gk4=;
  b=Z2uKYBqZVKcOKCY/aE6m2w4VsO6p3KzAg3bg/WVZsc6YWSYHpbsdw8Lu
   V9j1xRaT61HJWN7Ybazb1uvj18VYXbU3pPA17Gd5hdXIItbIkBoeQZ0I3
   4LwP6mHpaoImHw/8sxMBmOX+TRPoHaTK3vYgzBv4yjWW6vuj8jPPW+a3d
   TWKzVVYYbKHR/Ly/Vhn+s1sCUb23DGQORR0ikUlZr0riJIpGde04N2o4S
   uYhNJoAi7lyc+BO0+lHzC45xKgooyJ0z5LrOLSrOTyfSXhdY77ixBlCKP
   feW74ReFQyEbEsWGI81g13/IujlrkFSacgqehtmZUICXiv7Q3CB4dwK2M
   Q==;
X-CSE-ConnectionGUID: VQOTsFUtQ8uW6jrSZQX8zA==
X-CSE-MsgGUID: V4cABbMLQXqrf181t9iA4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55665952"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55665952"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 07:56:48 -0700
X-CSE-ConnectionGUID: HsJ9OP1EQF+feIAWl2YFsw==
X-CSE-MsgGUID: Oo/zI1FuTJ+1tDjTQZFQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162903412"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.240]) ([10.247.118.240])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 07:56:44 -0700
Message-ID: <9539bae4-dedf-4495-bd6d-5a6120362250@intel.com>
Date: Mon, 28 Jul 2025 07:56:39 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] dmaengine: idxd: init: Fix uninitialized use of
 conf_dev in idxd_setup_wqs()
To: Ziming Du <duziming2@huawei.com>, dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkoul@kernel.org, vinicius.gomes@intel.com,
 liuyongqiang13@huawei.com
References: <20250728115128.50889-1-duziming2@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250728115128.50889-1-duziming2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/25 4:51 AM, Ziming Du wrote:
> Fix Smatch-detected issue:
> drivers/dma/idxd/init.c:246 idxd_setup_wqs() error:
> uninitialized symbol'conf_dev'
> 
> 'conf_dev' may be used uninitialized in error handling paths.
> Specifically, if the memory allocation for 'wq' fails, the code
> jumps to 'err', and attempt to call put_device(conf_dev), without
> ensuring that conf_dev has been properly initialized.
> 
> Fix it by initializing conf_dev to NULL at declaration.
> 
> Signed-off-by: Ziming Du <duziming2@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 35bdefd3728b..2b61f26af1f6 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -178,7 +178,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  {
>  	struct device *dev = &idxd->pdev->dev;
>  	struct idxd_wq *wq;
> -	struct device *conf_dev;
> +	struct device *conf_dev = NULL;
>  	int i, rc;
>  
>  	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),


