Return-Path: <dmaengine+bounces-373-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8424804D81
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE11F212B5
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC83E47B;
	Tue,  5 Dec 2023 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cclanZ6L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF2183;
	Tue,  5 Dec 2023 01:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701768108; x=1733304108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=59iQKEDl6X80Ax03Nq5CpaD02G8tfcF3NvfxIuhVihs=;
  b=cclanZ6L24/3h6MGwFC2QoqnvinXwRPYsHlidEv0SzMFhlDr8Tl/WcAt
   BjbojHGC6wxRljnQ++2jPywL37T3VQCzkZwxCcj3aDdkQRq/lSu0wY89k
   vefXnJ1k5+vSr+ImiznprO9To2cIoKpkX69yPzciFA6Zy1ft48omW8DJR
   pgNReXxpD9aYZwYcRnGpMmabNtTgQ5Of2fBJyT3BE5Ml5AbdRsfL9Pvh+
   X9+g2zBAOBDuq7L/UsY9kg9JgPYPEy9/+k10ffYVLebtAUcfq9YDgec2Z
   zRDW5+nCGkqwWuNJ5wrAo1GlzBLxoDBDVn1TLaKCTilV1Rc+zOJOlvHTI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378893727"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="378893727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841387858"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="841387858"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 01:21:42 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: tom.zanussi@linux.intel.com
Cc: dave.jiang@intel.com,
	davem@davemloft.net,
	dmaengine@vger.kernel.org,
	fenghua.yu@intel.com,
	giovanni.cabiddu@intel.com,
	herbert@gondor.apana.org.au,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	tony.luck@intel.com,
	vinodh.gopal@intel.com,
	vkoul@kernel.org,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v11 14/14] dmaengine: idxd: Add support for device/wq defaults
Date: Tue,  5 Dec 2023 17:21:39 +0800
Message-Id: <20231205092139.3682047-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201201035.172465-15-tom.zanussi@linux.intel.com>
References: <20231201201035.172465-15-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tom,

On 2023-12-01 at 14:10:35 -0600, Tom Zanussi wrote:

[snip]

> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct idxd_group *group;
> +	struct idxd_wq *wq;
> +
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return 0;
In the virtualization case, it is not configurable in guest OS,
then the default work queue will not be enabled. Is it expected?
> +
> +	wq = idxd->wqs[0];
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	/* set mode to "dedicated" */
> +	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
> +	wq->threshold = 0;
> +
> +	/* only setting up 1 wq, so give it all the wq space */
> +	wq->size = idxd->max_wq_size;
> +
> +	/* set priority to 10 */
> +	wq->priority = 10;
> +
> +	/* set type to "kernel" */
> +	wq->type = IDXD_WQT_KERNEL;
> +
> +	/* set wq group to 0 */
> +	group = idxd->groups[0];
> +	wq->group = group;
> +	group->num_wqs++;
> +
> +	/* set name to "iaa_crypto" */
> +	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> +	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
> +
> +	/* set driver_name to "crypto" */
> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> +	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
> +
> +	engine = idxd->engines[0];
> +
> +	/* set engine group to 0 */
> +	engine->group = idxd->groups[0];
> +	engine->group->num_engines++;
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 62ea21b25906..47de3f93ff1e 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -277,6 +277,8 @@ struct idxd_dma_dev {
>  	struct dma_device dma;
>  };
>  
> +typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
> +
>  struct idxd_driver_data {
>  	const char *name_prefix;
>  	enum idxd_type type;
> @@ -286,6 +288,7 @@ struct idxd_driver_data {
>  	int evl_cr_off;
>  	int cr_status_off;
>  	int cr_result_off;
> +	load_device_defaults_fn_t load_device_defaults;
>  };
>  
>  struct idxd_evl {
> @@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
>  void idxd_wqs_quiesce(struct idxd_device *idxd);
>  bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>  void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
>  
>  /* device interrupt control */
>  irqreturn_t idxd_misc_thread(int vec, void *data);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0eb1c827a215..14df1f1347a8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
>  		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
>  		.cr_status_off = offsetof(struct iax_completion_record, status),
>  		.cr_result_off = offsetof(struct iax_completion_record, error_code),
> +		.load_device_defaults = idxd_load_iaa_device_defaults,
>  	},
>  };
>  
> @@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err;
>  	}
>  
> +	if (data->load_device_defaults) {
> +		rc = data->load_device_defaults(idxd);
> +		if (rc)
> +			dev_warn(dev, "IDXD loading device defaults failed\n");
> +	}
> +
>  	rc = idxd_register_devices(idxd);
>  	if (rc) {
>  		dev_err(dev, "IDXD sysfs setup failed\n");

Thanks,
Rex Zhang
> -- 
> 2.34.1
> 

