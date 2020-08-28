Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353B32558BF
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgH1KnG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 06:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1KnA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 06:43:00 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF03A208CA;
        Fri, 28 Aug 2020 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598611379;
        bh=seVo+Jc9ZX6zdcRswNAzDxVLNJe6ZifiyIwOPrVnfVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECXEbT/UId9KrT7QNNZ5pKzYrHsq8TzXnzxnwhq2C0zu+bU/mFEZmH++BMiYaIwym
         dSJ++O9OOnB2dpbuyc2DAGVzk6gzGuwS3FZh36AFDyRysKWR92rV4ffGIkxp4yCrqU
         bzL7Nzs3Nb+MbqHuqx1s1kmqomL0DDy3QrqbQAFc=
Date:   Fri, 28 Aug 2020 16:12:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add command status to idxd sysfs
 attribute
Message-ID: <20200828104255.GS2639@vkoul-mobl>
References: <159856348828.3418.7745506843326238999.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159856348828.3418.7745506843326238999.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-08-20, 14:24, Dave Jiang wrote:
> Export admin command status to sysfs attribute in order to allow user to
> retrieve configuration error. Allows user tooling to retrieve the command
> error and provide more user friendly error messages.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c |    6 +++++-
>  drivers/dma/idxd/idxd.h   |    1 +
>  drivers/dma/idxd/sysfs.c  |   10 ++++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 00dab1465ca3..bdca1bc55cfa 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -368,6 +368,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>  	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
>  		__func__, cmd_code, operand);
>  
> +	idxd->cmd_status = 0;
>  	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
>  	idxd->cmd_done = &done;
>  	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
> @@ -379,8 +380,11 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>  	spin_unlock_irqrestore(&idxd->dev_lock, flags);
>  	wait_for_completion(&done);
>  	spin_lock_irqsave(&idxd->dev_lock, flags);
> -	if (status)
> +	if (status) {
>  		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
> +		idxd->cmd_status = *status & 0xff;

define the magic 0xff and use GENMASK to define that!

> +	}
> +
>  	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
>  	/* Wake up other pending commands */
>  	wake_up(&idxd->cmd_waitq);
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index e8bec6eb9f7e..c64df197e724 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -156,6 +156,7 @@ struct idxd_device {
>  	unsigned long flags;
>  	int id;
>  	int major;
> +	u8 cmd_status;
>  
>  	struct pci_dev *pdev;
>  	void __iomem *reg_base;
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index c5f19802cb9e..1db8d021f5ae 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1395,6 +1395,15 @@ static ssize_t cdev_major_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(cdev_major);
>  
> +static ssize_t cmd_status_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
> +
> +	return sprintf(buf, "%#x\n", idxd->cmd_status);
> +}
> +static DEVICE_ATTR_RO(cmd_status);

Update ABI docs for this?

> +
>  static struct attribute *idxd_device_attributes[] = {
>  	&dev_attr_version.attr,
>  	&dev_attr_max_groups.attr,
> @@ -1413,6 +1422,7 @@ static struct attribute *idxd_device_attributes[] = {
>  	&dev_attr_max_tokens.attr,
>  	&dev_attr_token_limit.attr,
>  	&dev_attr_cdev_major.attr,
> +	&dev_attr_cmd_status.attr,
>  	NULL,
>  };
>  

-- 
~Vinod
