Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969C2282FA7
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEEfP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEfP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:35:15 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4661B2080C;
        Mon,  5 Oct 2020 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601872515;
        bh=+HupEaWT4/dqA8wYF4MJxdQS3FGdvT0Db+DSpHVqWDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MfQpbgr+RASWu0kjaSPDOfJxjkHLTz6+N66Kwvjq3uNcqvZZmwwqnkdp66GoBXFX
         mPMR4+BSRRj9xZCHn35tUYIUS7NW49EitfJQ9KrVZvqdoruplSxvIYRcea6KjMCNmy
         W1pWS/gYYPUqJfZ3ZfKe70oSV/If+eqfpb9jwODQ=
Date:   Mon, 5 Oct 2020 10:05:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@aculab.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dmaengine: idxd: Add shared workqueue support
Message-ID: <20201005043510.GE2968@vkoul-mobl>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-4-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924180041.34056-4-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-20, 11:00, Dave Jiang wrote:

> @@ -1154,6 +1268,8 @@ static struct attribute *idxd_wq_attributes[] = {
>  	&dev_attr_wq_mode.attr,
>  	&dev_attr_wq_size.attr,
>  	&dev_attr_wq_priority.attr,
> +	&dev_attr_wq_block_on_fault.attr,
> +	&dev_attr_wq_threshold.attr,
>  	&dev_attr_wq_type.attr,
>  	&dev_attr_wq_name.attr,
>  	&dev_attr_wq_cdev_minor.attr,
> @@ -1305,6 +1421,16 @@ static ssize_t clients_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(clients);
>  
> +static ssize_t pasid_enabled_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_device *idxd =
> +		container_of(dev, struct idxd_device, conf_dev);
> +
> +	return sprintf(buf, "%u\n", device_pasid_enabled(idxd));
> +}
> +static DEVICE_ATTR_RO(pasid_enabled);
> +
>  static ssize_t state_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
> @@ -1424,6 +1550,7 @@ static struct attribute *idxd_device_attributes[] = {
>  	&dev_attr_gen_cap.attr,
>  	&dev_attr_configurable.attr,
>  	&dev_attr_clients.attr,
> +	&dev_attr_pasid_enabled.attr,

No Documentation again for these new files! Please add them as well

-- 
~Vinod
