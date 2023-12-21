Return-Path: <dmaengine+bounces-611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E081BBAD
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE81E28E74C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0920627FB;
	Thu, 21 Dec 2023 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THy9I8gu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267C55E64;
	Thu, 21 Dec 2023 16:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F58C433C7;
	Thu, 21 Dec 2023 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175236;
	bh=n2/uLWpjh2wZRMXJuKHDXAa3gaxHUDqxFQmjrE23LiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THy9I8gu3LEqHP46W6i8JJ2kcs3okxkg/u6YwaNdGX27WJg2fX3jQkRMCiCSCVJW/
	 FUDio7aZg+gnXb3yWkktt+KDUTylPLHEROk+DyW806DspK8fu+KfYMc70x8awwnOce
	 cba8cRIMJh7DJTfgBTRH35gzFCu2aR1gckJljCpRJUqEuhYXIeTPx9CNSQHd5oxU7v
	 rdt0SLDB+D+OS2TEdTWj5WGk3D8fdUDWWLxpP19puvs8bONpJQbeEt7/QHarOgqWDI
	 NO8zBCMtUQCsWGwPWWQ+Se4RQVOKzRo9ct9pomRwoGerVtf8LJuapH9N5gz+exdOn+
	 jF8bkMQjKhZbw==
Date: Thu, 21 Dec 2023 21:43:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: add channel device name to channel
 registration
Message-ID: <ZYRkP-m_sra8qUNZ@matsya>
References: <20231213174021.3074759-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213174021.3074759-1-amelie.delaunay@foss.st.com>

On 13-12-23, 18:40, Amelie Delaunay wrote:
> Channel device name is used for sysfs, but also by dmatest filter function.
> 
> With dynamic channel registration, channels can be registered after dma
> controller registration. Users may want to have specific channel names.
> 
> If name is NULL, the channel name relies on previous implementation,
> dma<controller_device_id>chan<channel_device_id>.

lgtm, where is the user for this..?

> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/dma/dmaengine.c   | 16 ++++++++++------
>  drivers/dma/idxd/dma.c    |  2 +-
>  include/linux/dmaengine.h |  3 ++-
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b7388ae62d7f..7848428da2d6 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1037,7 +1037,8 @@ static int get_dma_id(struct dma_device *device)
>  }
>  
>  static int __dma_async_device_channel_register(struct dma_device *device,
> -					       struct dma_chan *chan)
> +					       struct dma_chan *chan,
> +					       const char *name)
>  {
>  	int rc;
>  
> @@ -1066,8 +1067,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	chan->dev->device.parent = device->dev;
>  	chan->dev->chan = chan;
>  	chan->dev->dev_id = device->dev_id;
> -	dev_set_name(&chan->dev->device, "dma%dchan%d",
> -		     device->dev_id, chan->chan_id);
> +	if (!name)
> +		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
> +	else
> +		dev_set_name(&chan->dev->device, name);
>  	rc = device_register(&chan->dev->device);
>  	if (rc)
>  		goto err_out_ida;
> @@ -1087,11 +1090,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  }
>  
>  int dma_async_device_channel_register(struct dma_device *device,
> -				      struct dma_chan *chan)
> +				      struct dma_chan *chan,
> +				      const char *name)
>  {
>  	int rc;
>  
> -	rc = __dma_async_device_channel_register(device, chan);
> +	rc = __dma_async_device_channel_register(device, chan, name);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -1200,7 +1204,7 @@ int dma_async_device_register(struct dma_device *device)
>  
>  	/* represent channels in sysfs. Probably want devs too */
>  	list_for_each_entry(chan, &device->channels, device_node) {
> -		rc = __dma_async_device_channel_register(device, chan);
> +		rc = __dma_async_device_channel_register(device, chan, NULL);
>  		if (rc < 0)
>  			goto err_out;
>  	}
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index 47a01893cfdb..101a265567a9 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -269,7 +269,7 @@ static int idxd_register_dma_channel(struct idxd_wq *wq)
>  		desc->txd.tx_submit = idxd_dma_tx_submit;
>  	}
>  
> -	rc = dma_async_device_channel_register(dma, chan);
> +	rc = dma_async_device_channel_register(dma, chan, NULL);
>  	if (rc < 0) {
>  		kfree(idxd_chan);
>  		return rc;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 3df70d6131c8..cbad92cc3e0b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1574,7 +1574,8 @@ int dma_async_device_register(struct dma_device *device);
>  int dmaenginem_async_device_register(struct dma_device *device);
>  void dma_async_device_unregister(struct dma_device *device);
>  int dma_async_device_channel_register(struct dma_device *device,
> -				      struct dma_chan *chan);
> +				      struct dma_chan *chan,
> +				      const char *name);
>  void dma_async_device_channel_unregister(struct dma_device *device,
>  					 struct dma_chan *chan);
>  void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
> -- 
> 2.25.1

-- 
~Vinod

