Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAD45893F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 07:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhKVGTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 01:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhKVGTa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 01:19:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F1960E96;
        Mon, 22 Nov 2021 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637561784;
        bh=6sxMNzuZe+y0w0uJw2Wy5Jy1EhboMkIR7W4MfbqG8tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raeUGNspZejd/cZ4J5nn2gn73TWI5vEqw9n0odwlJnDv9Nte5Gyl6wKOo5s6e55pP
         xYL256FbhRYVjjElFXanh9N/raOKcmyrmplCmP6DYpRjlnQFXg04HBCy49ojGOGHos
         FHNoh1xDHWyqETrU/ljSMToMANFoSWv0fIc3mNbTreebIbTora8Q2fow8/78GRbniL
         h1+eBXERDL9iairu2YAjn1Ik/WtHqDzo8e+pKoujwe5xbGSk6fhgdTJbxxdNdBhO+k
         6dXTnvDlgO2N+HNvpnzGZ+0fiiSZesEiY4f3xCiEZ4DpKPZE345RC1k7ci7l9Gd4zC
         z1KCW7o1NvUTA==
Date:   Mon, 22 Nov 2021 11:46:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add knob for enqcmds retries
Message-ID: <YZs1tJgKPIfUb0Ok@matsya>
References: <163596021257.928002.3977423972243944934.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163596021257.928002.3977423972243944934.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-11-21, 10:23, Dave Jiang wrote:
> Add a sysfs knob to allow tuning of retries for the kernel ENQCMDS
> descriptor submission. While on host, it is not as likely that ENQCMDS
> return busy during normal operations due to the driver controlling the
> number of descriptors allocated for submission. However, when the driver is
> operating as a guest driver, the chance of retry goes up significantly due
> to sharing a wq with multiple VMs. A default value is provided with the
> system admin being able to tune the value on a per WQ basis.
> 
> Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-driver-dma-idxd |    6 ++++
>  drivers/dma/idxd/device.c                      |    1 +
>  drivers/dma/idxd/idxd.h                        |    4 +++
>  drivers/dma/idxd/init.c                        |    1 +
>  drivers/dma/idxd/irq.c                         |    2 +
>  drivers/dma/idxd/submit.c                      |   32 ++++++++++++++++++-----
>  drivers/dma/idxd/sysfs.c                       |   33 ++++++++++++++++++++++++
>  7 files changed, 71 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index df4afbccf037..fd1a611df510 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -220,6 +220,12 @@ Contact:	dmaengine@vger.kernel.org
>  Description:	Show the current number of entries in this WQ if WQ Occupancy
>  		Support bit WQ capabilities is 1.
>  
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/enqcmds_retries
> +Date		Oct 29, 2021
> +KernelVersion:	5.17.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	Indicate the number of retires for an enqcmds submission on a shared wq.
> +
>  What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
>  Date:           Oct 25, 2019
>  KernelVersion:  5.6.0
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 36e213a8108d..5a50ee6f6881 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -387,6 +387,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>  	wq->threshold = 0;
>  	wq->priority = 0;
>  	wq->ats_dis = 0;
> +	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>  	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>  	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
>  	memset(wq->name, 0, WQ_NAME_SIZE);
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 89e98d69115b..6fe9c7bf78ac 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -52,6 +52,8 @@ enum idxd_type {
>  #define IDXD_NAME_SIZE		128
>  #define IDXD_PMU_EVENT_MAX	64
>  
> +#define IDXD_ENQCMDS_RETRIES	32
> +
>  struct idxd_device_driver {
>  	const char *name;
>  	enum idxd_dev_type *type;
> @@ -173,6 +175,7 @@ struct idxd_dma_chan {
>  struct idxd_wq {
>  	void __iomem *portal;
>  	u32 portal_offset;
> +	unsigned int enqcmds_retries;
>  	struct percpu_ref wq_active;
>  	struct completion wq_dead;
>  	struct completion wq_resurrect;
> @@ -584,6 +587,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
>  int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
>  struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
>  void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
> +int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
>  
>  /* dmaengine */
>  int idxd_register_dma_device(struct idxd_device *idxd);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 94ecd4bf0f0e..8b3afce9ea67 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -248,6 +248,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		init_completion(&wq->wq_resurrect);
>  		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>  		wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
> +		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>  		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>  		if (!wq->wqcfg) {
>  			put_device(conf_dev);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index a3bf3ea84587..0b0055a0ad2a 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -98,7 +98,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
>  	if (wq_dedicated(wq)) {
>  		iosubmit_cmds512(portal, &desc, 1);
>  	} else {
> -		rc = enqcmds(portal, &desc);
> +		rc = idxd_enqcmds(wq, portal, &desc);
>  		/* This should not fail unless hardware failed. */
>  		if (rc < 0)
>  			dev_warn(dev, "Failed to submit drain desc on wq %d\n", wq->id);
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index 776fa81db61d..dd897accb9fb 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -123,6 +123,30 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
>  		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
>  }
>  
> +

This blank should be removed

> +/*
> + * ENQCMDS typically fail when the WQ is inactive or busy. On host submission, the driver
> + * has better control of number of descriptors being submitted to a shared wq by limiting
> + * the number of driver allocated descriptors to the wq size. However, when the swq is
> + * exported to a guest kernel, it may be shared with multiple guest kernels. This means
> + * the likelihood of getting busy returned on the swq when submitting goes significantly up.
> + * Having a tunable retry mechanism allows the driver to keep trying for a bit before giving
> + * up. The sysfs knob can be tuned by the system administrator.
> + */
> +int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
> +{
> +	int rc, retries = 0;
> +
> +	do {
> +		rc = enqcmds(portal, desc);
> +		if (rc == 0)
> +			break;
> +		cpu_relax();
> +	} while (retries++ < wq->enqcmds_retries);
> +
> +	return rc;
> +}
> +
>  int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> @@ -166,13 +190,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>  	if (wq_dedicated(wq)) {
>  		iosubmit_cmds512(portal, desc->hw, 1);
>  	} else {
> -		/*
> -		 * It's not likely that we would receive queue full rejection
> -		 * since the descriptor allocation gates at wq size. If we
> -		 * receive a -EAGAIN, that means something went wrong such as the
> -		 * device is not accepting descriptor at all.
> -		 */
> -		rc = enqcmds(portal, desc->hw);
> +		rc = idxd_enqcmds(wq, portal, desc->hw);
>  		if (rc < 0) {
>  			percpu_ref_put(&wq->wq_active);
>  			/* abort operation frees the descriptor */
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 90857e776273..7620cf00dabc 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -945,6 +945,38 @@ static ssize_t wq_occupancy_show(struct device *dev, struct device_attribute *at
>  static struct device_attribute dev_attr_wq_occupancy =
>  		__ATTR(occupancy, 0444, wq_occupancy_show, NULL);
>  
> +static ssize_t wq_enqcmds_retries_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_wq *wq = confdev_to_wq(dev);
> +
> +	if (wq_dedicated(wq))
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", wq->enqcmds_retries);
> +}
> +
> +static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct idxd_wq *wq = confdev_to_wq(dev);
> +	int rc;
> +	unsigned int retries;
> +
> +	if (wq_dedicated(wq))
> +		return -EOPNOTSUPP;
> +
> +	rc = kstrtouint(buf, 10, &retries);
> +	if (rc < 0)
> +		return rc;
> +
> +	wq->enqcmds_retries = retries;

Should there be no upper limit on the retries? Surely we dont want
userspace to write max and let it keep retrying...

-- 
~Vinod
