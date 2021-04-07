Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDF357539
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 21:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDGTy5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 15:54:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:56888 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233205AbhDGTyz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 15:54:55 -0400
IronPort-SDR: XlANkbp2f4utYePHEJTRoDz/nc7NqiJUG8OB8EvNEJQH+pSKEXEDKQTww+/cnVxJ1rKwHjGwbA
 hL76TZmlbitg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193430192"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193430192"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:54:45 -0700
IronPort-SDR: 1qCa0UrwSTE7L9h/7wUZIMUb0Kmlfjlt3/wHDBEgpRt1sOaenx7/SPaL/PSvguLrwez9NElcKK
 2TBiSSoq50vw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448375741"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.185.156]) ([10.254.185.156])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:54:44 -0700
Subject: Re: [PATCH v3] dmaengine: idxd: fix wq cleanup of WQCFG registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <161782510285.106717.15904886797025412090.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <cb946c24-5e69-e237-d62f-8fbdc3852463@intel.com>
Date:   Wed, 7 Apr 2021 12:54:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <161782510285.106717.15904886797025412090.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/7/2021 12:52 PM, Dave Jiang wrote:
> A pre-release silicon erratum workaround where wq reset does not clear
> WQCFG registers was leaked into upstream code. Use wq reset command
> instead of blasting the MMIO region. This also address an issue where
> we clobber registers in future devices.
>
> Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
> Reported-by: Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Remove unused vars
> v2:
> - Set IDXD_WQ_DISABLED for internal state after reset.

Forgot to set cc to dmaengine@vger



>
>   drivers/dma/idxd/device.c |   36 +++++++++++++++++++++++++-----------
>   drivers/dma/idxd/idxd.h   |    1 +
>   drivers/dma/idxd/sysfs.c  |    9 ++-------
>   3 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index b8939e7eccfb..eb313e0e0e9b 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -276,6 +276,23 @@ void idxd_wq_drain(struct idxd_wq *wq)
>   	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_WQ, operand, NULL);
>   }
>   
> +void idxd_wq_reset(struct idxd_wq *wq)
> +{
> +	struct idxd_device *idxd = wq->idxd;
> +	struct device *dev = &idxd->pdev->dev;
> +	u32 operand;
> +
> +	if (wq->state != IDXD_WQ_ENABLED) {
> +		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
> +		return;
> +	}
> +
> +	dev_dbg(dev, "Resetting WQ %d\n", wq->id);
> +	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
> +	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
> +	wq->state = IDXD_WQ_DISABLED;
> +}
> +
>   int idxd_wq_map_portal(struct idxd_wq *wq)
>   {
>   	struct idxd_device *idxd = wq->idxd;
> @@ -357,8 +374,6 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>   void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   {
>   	struct idxd_device *idxd = wq->idxd;
> -	struct device *dev = &idxd->pdev->dev;
> -	int i, wq_offset;
>   
>   	lockdep_assert_held(&idxd->dev_lock);
>   	memset(wq->wqcfg, 0, idxd->wqcfg_size);
> @@ -370,14 +385,6 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   	wq->ats_dis = 0;
>   	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>   	memset(wq->name, 0, WQ_NAME_SIZE);
> -
> -	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
> -		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
> -		iowrite32(0, idxd->reg_base + wq_offset);
> -		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
> -			wq->id, i, wq_offset,
> -			ioread32(idxd->reg_base + wq_offset));
> -	}
>   }
>   
>   /* Device control bits */
> @@ -636,7 +643,14 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>   	if (!wq->group)
>   		return 0;
>   
> -	memset(wq->wqcfg, 0, idxd->wqcfg_size);
> +	/*
> +	 * Instead of memset the entire shadow copy of WQCFG, copy from the hardware after
> +	 * wq reset. This will copy back the sticky values that are present on some devices.
> +	 */
> +	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
> +		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
> +		wq->wqcfg->bits[i] = ioread32(idxd->reg_base + wq_offset);
> +	}
>   
>   	/* byte 0-3 */
>   	wq->wqcfg->wq_size = wq->size;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index eee94121991e..21aa6e2017c8 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -387,6 +387,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq);
>   int idxd_wq_enable(struct idxd_wq *wq);
>   int idxd_wq_disable(struct idxd_wq *wq);
>   void idxd_wq_drain(struct idxd_wq *wq);
> +void idxd_wq_reset(struct idxd_wq *wq);
>   int idxd_wq_map_portal(struct idxd_wq *wq);
>   void idxd_wq_unmap_portal(struct idxd_wq *wq);
>   void idxd_wq_disable_cleanup(struct idxd_wq *wq);
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d38bf9034e6..0155c1b4f2ef 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -212,7 +212,6 @@ static void disable_wq(struct idxd_wq *wq)
>   {
>   	struct idxd_device *idxd = wq->idxd;
>   	struct device *dev = &idxd->pdev->dev;
> -	int rc;
>   
>   	mutex_lock(&wq->wq_lock);
>   	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
> @@ -233,17 +232,13 @@ static void disable_wq(struct idxd_wq *wq)
>   	idxd_wq_unmap_portal(wq);
>   
>   	idxd_wq_drain(wq);
> -	rc = idxd_wq_disable(wq);
> +	idxd_wq_reset(wq);
>   
>   	idxd_wq_free_resources(wq);
>   	wq->client_count = 0;
>   	mutex_unlock(&wq->wq_lock);
>   
> -	if (rc < 0)
> -		dev_warn(dev, "Failed to disable %s: %d\n",
> -			 dev_name(&wq->conf_dev), rc);
> -	else
> -		dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
> +	dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
>   }
>   
>   static int idxd_config_bus_remove(struct device *dev)
>
>
