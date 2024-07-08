Return-Path: <dmaengine+bounces-2659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0108092A99A
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820C71F22456
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592C14C581;
	Mon,  8 Jul 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXDbx6tn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDA143C47;
	Mon,  8 Jul 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465839; cv=none; b=Er1iJyDtntBFDNMC0EJOjsgHDLpzCnMq5pQUaXEA96NB5uIJDiQ/RPprlOupwIqhUfZnr7aOQn5a6Nx9GnROdoxa89+ZYuyDAFmI9PdNI5PGZiHYlX1P07m3jiF6f3+U6EaHDb6EsXte5AaC8DItZsHeFY7QN1a15MT3JLqAgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465839; c=relaxed/simple;
	bh=wTRdVhhGGBiVJK8BHn08SZ7h85NIsA55xyfHO8rjY+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0S+/xP2cu/NTdvJ0sEc8DoHYUJGx9edvuWPmmHoVByWFIlelnomLmAHI+/biBW7zvpL7zkZKyf9qWD21Gtmf/LPdZBt4XolREoy74gijAQOiEzfYvwc98/jtdboJKGzg379Zk9wnF1cBkPQ2Qy9PBQl3AyjXlC1tAU8T08snuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXDbx6tn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720465837; x=1752001837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wTRdVhhGGBiVJK8BHn08SZ7h85NIsA55xyfHO8rjY+E=;
  b=KXDbx6tnqhbt952fihw6MCnjQwJGAQ4UeU+x0SgucRyCm6ZOGIyLKFut
   D+eVSv4n26ToIslXoFrj6SW1H1/1U32ClD2J3l02SCO4IM6uOX31ha1u1
   lbOG9B40jVorA7vc7tfB7lBFCXvUl2M1L+Pgb37jjsKX5Vw28lSd40ZW0
   ZCE1tpNSEYhStfrY1BZ2rrwbPXloViA/cGPmUSnGDd7wMpqlwGd/sRT2e
   CdylWspAbnPGeCdZrsbkoSqLVZAgyNHp3k4SsyD2+N6/qFM3Yb0zJD8N/
   hwv4k292yJLXVzR/F2PxW7+4C/kAptb5kYJx2o5CbAa8bBiLyBtQfGrL1
   A==;
X-CSE-ConnectionGUID: ILXGkjMJTueM7NtFdsbYoQ==
X-CSE-MsgGUID: ZO6lqrENQQubbNUldsASfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28288990"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="28288990"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:10:37 -0700
X-CSE-ConnectionGUID: i3XDM3oRSNKccOHE3beRWA==
X-CSE-MsgGUID: Z5m9nhJ7QfeIorYqkZvj+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47571606"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.203]) ([10.125.108.203])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:10:36 -0700
Message-ID: <fe57cb13-8a00-4a38-9ae6-b362007d03f4@intel.com>
Date: Mon, 8 Jul 2024 12:10:34 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dmaengine: idxd: Add idxd_device_config_save() and
 idxd_device_config_restore() helpers
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240705181519.4067507-1-fenghua.yu@intel.com>
 <20240705181519.4067507-4-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240705181519.4067507-4-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/5/24 11:15 AM, Fenghua Yu wrote:
> Add the helpers to save and restore IDXD device configurations.
> 
> These helpers will be called during Function Level Reset (FLR) processing.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/idxd.h |  11 ++
>  drivers/dma/idxd/init.c | 224 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 235 insertions(+)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 03f099518ec1..4f3e98720b45 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -377,6 +377,17 @@ struct idxd_device {
>  	struct dentry *dbgfs_evl_file;
>  
>  	bool user_submission_safe;
> +
> +	struct idxd_saved_states *idxd_saved;
> +};
> +
> +struct idxd_saved_states {
> +	struct idxd_device saved_idxd;
> +	struct idxd_evl saved_evl;
> +	struct idxd_engine **saved_engines;
> +	struct idxd_wq **saved_wqs;
> +	struct idxd_group **saved_groups;
> +	unsigned long *saved_wq_enable_map;
>  };
>  
>  static inline unsigned int evl_ent_size(struct idxd_device *idxd)
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a6d8097b2dcf..bb03d8cc5d32 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -749,6 +749,230 @@ static void idxd_unbind(struct device_driver *drv, const char *buf)
>  	put_device(dev);
>  }
>  
> +/* Free allocated saved wq enable map after saving wq configs. */
> +static void free_saved_wq_enable_map(unsigned long *map)
> +{
> +	bitmap_free(map);
> +}
> +
> +DEFINE_FREE(free_saved_wq_enable_map, unsigned long *, if (!IS_ERR_OR_NULL(_T))
> +	    free_saved_wq_enable_map(_T))
> +
> +#define idxd_free_saved_configs(saved_configs, count)	\
> +	do {						\
> +		int i;					\
> +							\
> +		for (i = 0; i < (count); i++)		\
> +			kfree(saved_configs[i]);	\
> +	} while (0)
> +
> +/*
> + * Save IDXD device configurations including engines, groups, wqs etc.
> + * The saved configurations can be restored when needed.
> + */
> +static int idxd_device_config_save(struct idxd_device *idxd,
> +				   struct idxd_saved_states *idxd_saved)
> +{
> +	struct device *dev = &idxd->pdev->dev;
> +	int i;
> +
> +	memcpy(&idxd_saved->saved_idxd, idxd, sizeof(*idxd));
> +
> +	if (idxd->evl) {
> +		memcpy(&idxd_saved->saved_evl, idxd->evl,
> +		       sizeof(struct idxd_evl));
> +	}
> +
> +	struct idxd_group **saved_groups __free(kfree) =
> +			kcalloc_node(idxd->max_groups,
> +				     sizeof(struct idxd_group *),
> +				     GFP_KERNEL, dev_to_node(dev));
> +	if (!saved_groups)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < idxd->max_groups; i++) {
> +		struct idxd_group *saved_group __free(kfree) =
> +			kzalloc_node(sizeof(*saved_group), GFP_KERNEL,
> +				     dev_to_node(dev));
> +
> +		if (!saved_group) {
> +			idxd_free_saved_configs(saved_groups, i);
> +
> +			return -ENOMEM;
> +		}
> +
> +		memcpy(saved_group, idxd->groups[i], sizeof(*saved_group));
> +		saved_groups[i] = no_free_ptr(saved_group);
> +	}
> +
> +	struct idxd_engine **saved_engines =
> +			kcalloc_node(idxd->max_engines,
> +				     sizeof(struct idxd_engine *),
> +				     GFP_KERNEL, dev_to_node(dev));
> +	if (!saved_engines) {
> +		/* Free saved groups */
> +		idxd_free_saved_configs(saved_groups, idxd->max_groups);

I would put a wrapper function around idxd_device_config_save(). If error is returned from idxd_device_config_save(), then you can just call the cleanup function and free everything allocated. That way you don't need to keep calling idxd_free_saved_configs() for every error exit point.

DJ

> +
> +		return -ENOMEM;
> +	}
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		struct idxd_engine *saved_engine __free(kfree) =
> +				kzalloc_node(sizeof(*saved_engine), GFP_KERNEL,
> +					     dev_to_node(dev));
> +		if (!saved_engine) {
> +			/* Free saved groups and engines */
> +			idxd_free_saved_configs(saved_groups, idxd->max_groups);
> +			idxd_free_saved_configs(saved_engines, i);
> +
> +			return -ENOMEM;
> +		}
> +
> +		memcpy(saved_engine, idxd->engines[i], sizeof(*saved_engine));
> +		saved_engines[i] = no_free_ptr(saved_engine);
> +	}
> +
> +	unsigned long *saved_wq_enable_map __free(free_saved_wq_enable_map) =
> +			bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL,
> +					   dev_to_node(dev));
> +	if (!saved_wq_enable_map) {
> +		/* Free saved groups and engines */
> +		idxd_free_saved_configs(saved_groups, idxd->max_groups);
> +		idxd_free_saved_configs(saved_engines, idxd->max_engines);
> +
> +		return -ENOMEM;
> +	}
> +
> +	bitmap_copy(saved_wq_enable_map, idxd->wq_enable_map, idxd->max_wqs);
> +
> +	struct idxd_wq **saved_wqs __free(kfree) =
> +			kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
> +				     GFP_KERNEL, dev_to_node(dev));
> +	if (!saved_wqs) {
> +		/* Free saved groups and engines */
> +		idxd_free_saved_configs(saved_groups, idxd->max_groups);
> +		idxd_free_saved_configs(saved_engines, idxd->max_engines);
> +
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		struct idxd_wq *saved_wq __free(kfree) =
> +			kzalloc_node(sizeof(*saved_wq), GFP_KERNEL,
> +				     dev_to_node(dev));
> +		struct idxd_wq *wq;
> +
> +		if (!saved_wq) {
> +			/* Free saved groups, engines, and wqs */
> +			idxd_free_saved_configs(saved_groups, idxd->max_groups);
> +			idxd_free_saved_configs(saved_engines,
> +						idxd->max_engines);
> +			idxd_free_saved_configs(saved_wqs, i);
> +
> +			return -ENOMEM;
> +		}
> +
> +		if (!test_bit(i, saved_wq_enable_map))
> +			continue;
> +
> +		wq = idxd->wqs[i];
> +		mutex_lock(&wq->wq_lock);
> +		memcpy(saved_wq, wq, sizeof(*saved_wq));
> +		saved_wqs[i] = no_free_ptr(saved_wq);
> +		mutex_unlock(&wq->wq_lock);
> +	}
> +
> +	/* Save configurations */
> +	idxd_saved->saved_groups = no_free_ptr(saved_groups);
> +	idxd_saved->saved_engines = no_free_ptr(saved_engines);
> +	idxd_saved->saved_wq_enable_map = no_free_ptr(saved_wq_enable_map);
> +	idxd_saved->saved_wqs = no_free_ptr(saved_wqs);
> +
> +	return 0;
> +}
> +
> +/*
> + * Restore IDXD device configurations including engines, groups, wqs etc
> + * that were saved before.
> + */
> +static void idxd_device_config_restore(struct idxd_device *idxd,
> +				       struct idxd_saved_states *idxd_saved)
> +{
> +	struct idxd_evl *saved_evl = &idxd_saved->saved_evl;
> +	int i;
> +
> +	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
> +
> +	if (saved_evl)
> +		idxd->evl->size = saved_evl->size;
> +
> +	for (i = 0; i < idxd->max_groups; i++) {
> +		struct idxd_group *saved_group, *group;
> +
> +		saved_group = idxd_saved->saved_groups[i];
> +		group = idxd->groups[i];
> +
> +		group->rdbufs_allowed = saved_group->rdbufs_allowed;
> +		group->rdbufs_reserved = saved_group->rdbufs_reserved;
> +		group->tc_a = saved_group->tc_a;
> +		group->tc_b = saved_group->tc_b;
> +		group->use_rdbuf_limit = saved_group->use_rdbuf_limit;
> +
> +		kfree(saved_group);
> +	}
> +	kfree(idxd_saved->saved_groups);
> +
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		struct idxd_engine *saved_engine, *engine;
> +
> +		saved_engine = idxd_saved->saved_engines[i];
> +		engine = idxd->engines[i];
> +
> +		engine->group = saved_engine->group;
> +
> +		kfree(saved_engine);
> +	}
> +	kfree(idxd_saved->saved_engines);
> +
> +	bitmap_copy(idxd->wq_enable_map, idxd_saved->saved_wq_enable_map,
> +		    idxd->max_wqs);
> +	bitmap_free(idxd_saved->saved_wq_enable_map);
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		struct idxd_wq *saved_wq, *wq;
> +		size_t len;
> +
> +		if (!test_bit(i, idxd->wq_enable_map))
> +			continue;
> +
> +		saved_wq = idxd_saved->saved_wqs[i];
> +		wq = idxd->wqs[i];
> +
> +		mutex_lock(&wq->wq_lock);
> +
> +		wq->group = saved_wq->group;
> +		wq->flags = saved_wq->flags;
> +		wq->threshold = saved_wq->threshold;
> +		wq->size = saved_wq->size;
> +		wq->priority = saved_wq->priority;
> +		wq->type = saved_wq->type;
> +		len = strlen(saved_wq->name) + 1;
> +		strscpy(wq->name, saved_wq->name, len);
> +		wq->max_xfer_bytes = saved_wq->max_xfer_bytes;
> +		wq->max_batch_size = saved_wq->max_batch_size;
> +		wq->enqcmds_retries = saved_wq->enqcmds_retries;
> +		wq->descs = saved_wq->descs;
> +		wq->idxd_chan = saved_wq->idxd_chan;
> +		len = strlen(saved_wq->driver_name) + 1;
> +		strscpy(wq->driver_name, saved_wq->driver_name, len);
> +
> +		mutex_unlock(&wq->wq_lock);
> +
> +		kfree(saved_wq);
> +	}
> +
> +	kfree(idxd_saved->saved_wqs);
> +}
> +
>  /*
>   * Probe idxd PCI device.
>   * If idxd is not given, need to allocate idxd and set up its data.

