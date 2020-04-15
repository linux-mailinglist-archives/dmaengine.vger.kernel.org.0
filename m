Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED41AAC94
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415054AbgDOP7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 11:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415051AbgDOP7c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 11:59:32 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FF3206F9;
        Wed, 15 Apr 2020 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966372;
        bh=Y4GG6sDSRHVjxwm8Nr7GE60mSfeA2NOAS6Iko0grEV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPvtEEN9/aRRp8Ray2JcwZucCry+K+rrpjptY/6UbswH5SbauhOjp7LubVN95gost
         awcmceH0hCqrQCxh1Y6CJ66//k8fx0l1aJpBWV14bPGr667auNpMUekLscBni7sEJ9
         acSAYRw5oFbTJTuxdXSBHKxmWGcFuxBirJw7dpNM=
Date:   Wed, 15 Apr 2020 21:29:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: export hw version through sysfs
Message-ID: <20200415155922.GV72691@vkoul-mobl>
References: <158594715310.27813.14140257595400126459.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158594715310.27813.14140257595400126459.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-04-20, 13:52, Dave Jiang wrote:
> Some user apps would like to know the hardware version in order to
> determine the variation of the hardware. Export the hardware version number
> to userspace via sysfs.

Documentation update?

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/sysfs.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 5fb6b5cafb55..bd05a04d3aa3 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1377,6 +1377,16 @@ static const struct attribute_group *idxd_wq_attribute_groups[] = {
>  };
>  
>  /* IDXD device attribs */
> +static ssize_t version_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct idxd_device *idxd =
> +		container_of(dev, struct idxd_device, conf_dev);
> +
> +	return sprintf(buf, "%#x\n", idxd->hw.version);
> +}
> +static DEVICE_ATTR_RO(version);
> +
>  static ssize_t max_work_queues_size_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -1618,6 +1628,7 @@ static ssize_t cdev_major_show(struct device *dev,
>  static DEVICE_ATTR_RO(cdev_major);
>  
>  static struct attribute *idxd_device_attributes[] = {
> +	&dev_attr_version.attr,
>  	&dev_attr_max_groups.attr,
>  	&dev_attr_max_work_queues.attr,
>  	&dev_attr_max_work_queues_size.attr,

-- 
~Vinod
