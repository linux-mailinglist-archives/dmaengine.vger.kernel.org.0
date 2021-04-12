Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F349535BAE7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhDLHiq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 03:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236837AbhDLHip (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 03:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 936B4611F2;
        Mon, 12 Apr 2021 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618213107;
        bh=xJGoVfaNyrXo0ihIK7Jc/nBXsLbeiXTSqXpR5eiZVMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ewkk1qU2EJ7XqFxcoF9UQEk2gXueJzotWuVHVINHhjDlOeiipRq7EMkSMw7xQevFO
         RP94DNluLSGmchdX1QJHa01uzWu+VCQuPq72EKQVqYRzOToUf4YKf86PvifsrcJaCQ
         mehFu7VmsEnvr0gbIsEoy3Lp4cUEmp+v2/u4I6IyLuM7KNSyU0voRoTQmKOfofPLt1
         lrEjH4eXY+cF8AVxtVgPvQXcuCqJuklSaVHQYqKCwtMmnvRMpxlDe6kF8uabYOpPB1
         VywSV4xllU8BDjcm6rHY3JFjX5XPV1wRunx9nBGfGp2rzaWjGlrFvetzKchgYVfbqt
         P3r4zD4AxKasA==
Date:   Mon, 12 Apr 2021 13:08:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 repost] dmaengine: idxd: fix wq cleanup of WQCFG
 registers
Message-ID: <YHP47/rRfKaGmqVq@vkoul-mobl.Dlink>
References: <161785385072.113280.16444287329349568724.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161785385072.113280.16444287329349568724.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-21, 20:51, Dave Jiang wrote:

> +void idxd_wq_reset(struct idxd_wq *wq)
> +{
> +	struct idxd_device *idxd = wq->idxd;
> +	struct device *dev = &idxd->pdev->dev;
> +	u32 operand;
> +
> +	if (wq->state != IDXD_WQ_ENABLED) {
> +		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);

should this not be dev_err?

> +		return;
> +	}
> +
> +	dev_dbg(dev, "Resetting WQ %d\n", wq->id);

Noisy..?

> +	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
> +	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
> +	wq->state = IDXD_WQ_DISABLED;
> +}
> +
>  int idxd_wq_map_portal(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> @@ -357,8 +374,6 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>  void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> -	struct device *dev = &idxd->pdev->dev;
> -	int i, wq_offset;
>  
>  	lockdep_assert_held(&idxd->dev_lock);
>  	memset(wq->wqcfg, 0, idxd->wqcfg_size);
> @@ -370,14 +385,6 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>  	wq->ats_dis = 0;
>  	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>  	memset(wq->name, 0, WQ_NAME_SIZE);
> -
> -	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
> -		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
> -		iowrite32(0, idxd->reg_base + wq_offset);
> -		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
> -			wq->id, i, wq_offset,
> -			ioread32(idxd->reg_base + wq_offset));
> -	}
>  }
>  
>  /* Device control bits */
> @@ -636,7 +643,14 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>  	if (!wq->group)
>  		return 0;
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
>  	/* byte 0-3 */
>  	wq->wqcfg->wq_size = wq->size;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index eee94121991e..21aa6e2017c8 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -387,6 +387,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq);
>  int idxd_wq_enable(struct idxd_wq *wq);
>  int idxd_wq_disable(struct idxd_wq *wq);
>  void idxd_wq_drain(struct idxd_wq *wq);
> +void idxd_wq_reset(struct idxd_wq *wq);
>  int idxd_wq_map_portal(struct idxd_wq *wq);
>  void idxd_wq_unmap_portal(struct idxd_wq *wq);
>  void idxd_wq_disable_cleanup(struct idxd_wq *wq);
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d38bf9034e6..0155c1b4f2ef 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -212,7 +212,6 @@ static void disable_wq(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
>  	struct device *dev = &idxd->pdev->dev;
> -	int rc;
>  
>  	mutex_lock(&wq->wq_lock);
>  	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
> @@ -233,17 +232,13 @@ static void disable_wq(struct idxd_wq *wq)
>  	idxd_wq_unmap_portal(wq);
>  
>  	idxd_wq_drain(wq);
> -	rc = idxd_wq_disable(wq);
> +	idxd_wq_reset(wq);
>  
>  	idxd_wq_free_resources(wq);
>  	wq->client_count = 0;
>  	mutex_unlock(&wq->wq_lock);
>  
> -	if (rc < 0)
> -		dev_warn(dev, "Failed to disable %s: %d\n",
> -			 dev_name(&wq->conf_dev), rc);
> -	else
> -		dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
> +	dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));

noisy again

>  }
>  
>  static int idxd_config_bus_remove(struct device *dev)
> 

-- 
~Vinod
