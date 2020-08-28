Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E925591A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgH1LGi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 07:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgH1LF3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 07:05:29 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0084B208CA;
        Fri, 28 Aug 2020 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598612090;
        bh=3CKsivbRub545FembOVMv1q87p5F6oratk+HzV+HsYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEpSZ8i5dRVYfZcudFrTIDjKF5nq6b60Jx6XjczlXifwxEMeH5llwDCujanZ0fj55
         +WwBNnFACgZs/+kpMIUGJXKq25r0zc4UKbLEqhkkCrheiMp0bpFe2N+Z8APluuT+l+
         wObeyL/BGXrzux8tULVfXKimfD5kNRJHY93z19ek=
Date:   Fri, 28 Aug 2020 16:24:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: idxd: add support for configurable max wq
 xfer size
Message-ID: <20200828105445.GU2639@vkoul-mobl>
References: <159838710214.14812.7574610309412397859.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159838710214.14812.7574610309412397859.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-20, 13:25, Dave Jiang wrote:
> Add sysfs attribute max_xfer_size to wq in order to allow the max xfer
> size configured on a per wq basis. Add support code to configure
> the valid user input on wq enable. This is a performance tuning
> parameter.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c |    2 +-
>  drivers/dma/idxd/idxd.h   |    1 +
>  drivers/dma/idxd/init.c   |    1 +
>  drivers/dma/idxd/sysfs.c  |   40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 14b45853aa5f..b8dbb7001933 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -529,7 +529,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>  	wq->wqcfg.priority = wq->priority;
>  
>  	/* bytes 12-15 */
> -	wq->wqcfg.max_xfer_shift = idxd->hw.gen_cap.max_xfer_shift;
> +	wq->wqcfg.max_xfer_shift = ilog2(wq->max_xfer_bytes);
>  	wq->wqcfg.max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
>  
>  	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index e62b4799d189..81db2a472822 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -114,6 +114,7 @@ struct idxd_wq {
>  	struct sbitmap_queue sbq;
>  	struct dma_chan dma_chan;
>  	char name[WQ_NAME_SIZE + 1];
> +	u64 max_xfer_bytes;
>  };
>  
>  struct idxd_engine {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index c7c61974f20f..e5ed5750a6d0 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -176,6 +176,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>  		wq->idxd = idxd;
>  		mutex_init(&wq->wq_lock);
>  		wq->idxd_cdev.minor = -1;
> +		wq->max_xfer_bytes = idxd->max_xfer_bytes;
>  	}
>  
>  	for (i = 0; i < idxd->max_engines; i++) {
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index dcba60953217..26b3ace66782 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1064,6 +1064,45 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
>  static struct device_attribute dev_attr_wq_cdev_minor =
>  		__ATTR(cdev_minor, 0444, wq_cdev_minor_show, NULL);
>  
> +static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
> +
> +	return sprintf(buf, "%llu\n", wq->max_xfer_bytes);
> +}
> +
> +static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
> +	struct idxd_device *idxd = wq->idxd;
> +	u64 xfer_size;
> +	int rc;
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	rc = kstrtou64(buf, 10, &xfer_size);
> +	if (rc < 0)
> +		return -EINVAL;
> +
> +	if (xfer_size == 0)
> +		return -EINVAL;
> +
> +	xfer_size = roundup_pow_of_two(xfer_size);
> +	if (xfer_size > idxd->max_xfer_bytes)
> +		return -EINVAL;
> +
> +	wq->max_xfer_bytes = xfer_size;
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_wq_max_transfer_size =
> +		__ATTR(max_transfer_size, 0644,
> +		       wq_max_transfer_size_show, wq_max_transfer_size_store);
> +
>  static struct attribute *idxd_wq_attributes[] = {
>  	&dev_attr_wq_clients.attr,
>  	&dev_attr_wq_state.attr,
> @@ -1074,6 +1113,7 @@ static struct attribute *idxd_wq_attributes[] = {
>  	&dev_attr_wq_type.attr,
>  	&dev_attr_wq_name.attr,
>  	&dev_attr_wq_cdev_minor.attr,
> +	&dev_attr_wq_max_transfer_size.attr,

ABI update for this?

-- 
~Vinod
