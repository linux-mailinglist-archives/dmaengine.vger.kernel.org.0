Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A93954AF
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhEaEjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhEaEjD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF76C61009;
        Mon, 31 May 2021 04:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622435844;
        bh=zFz3lrX1eHBSPQ2WKO0P9L2TWqh3+jvi2kELdtRui6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kP1K5IpxuyvI9AukrALH7dj1ErK7EYA4d1MGxVg926Y5x+37mIF94sNFIsoSuV5zu
         ZUrdgSULsYj7oOpmpztDTiGTFOM2Nkzdu6DuYkLSkXnlnwGXghock8/DO3dbFBtoXt
         ZYqBO1Heggl9mIE1jfE4/j3O3cosXjSczHzYjqWwtU9hFdl8EURRULj6IQpXVxAg/R
         HaazjHQPPybPh0QNpVeEnCjrFcoFNFeVOSkTfexrSteSuOlR5TPTQewS3Ecf4SMGWF
         cy1GK4ONZYd8GQ6CF0u0OCpBmZ/Ll+dcr1Ic4h92bJDlCbP3x5MNldBuWR763Ee0gc
         qF3W3UxZaRnbg==
Date:   Mon, 31 May 2021 10:07:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guanhua Gao <guanhua.gao@nxp.com>
Cc:     Yi Zhao <yi.zhao@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: fsl-dpaa2-qdma: Remove the macro of
 DPDMAI_MAX_QUEUE_NUM
Message-ID: <YLRoAamgPzLJeUk1@vkoul-mobl.Dlink>
References: <20210422084448.962-1-guanhua.gao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422084448.962-1-guanhua.gao@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-04-21, 16:44, Guanhua Gao wrote:
> The max number of queue supported by DPAA2 qdma is determined
> by the number of CPUs. Due to the number of CPUs are different
> in different LS2 platforms, we remove the macro of
> DPDMAI_MAX_QUEUE_NUM which is defined 8.
> 
> Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> ---
> Change in v2:
>  - Add new patch.
> 
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 43 +++++++++++++++++++++----
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  4 +--
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.h     |  5 ---
>  3 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index 86c7ec5dc74e..3875fbb9fac3 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -314,6 +314,8 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  	struct dpaa2_qdma_priv_per_prio *ppriv;
>  	struct device *dev = &ls_dev->dev;
>  	struct dpaa2_qdma_priv *priv;
> +	struct dpdmai_rx_queue_attr *rx_queue_attr;
> +	struct dpdmai_tx_queue_attr *tx_queue_attr;
>  	int err = -EINVAL;
>  	int i;
>  
> @@ -335,33 +337,51 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  				    &priv->dpdmai_attr);
>  	if (err) {
>  		dev_err(dev, "dpdmai_get_attributes() failed\n");
> -		goto exit;
> +		goto err_get_attr;
>  	}
>  
>  	priv->num_pairs = priv->dpdmai_attr.num_of_queues;
> +	rx_queue_attr = kcalloc(priv->num_pairs, sizeof(*rx_queue_attr),
> +				GFP_KERNEL);
> +	if (!rx_queue_attr) {
> +		err = -ENOMEM;
> +		goto err_get_attr;
> +	}
> +	priv->rx_queue_attr = rx_queue_attr;
> +
> +	tx_queue_attr = kcalloc(priv->num_pairs, sizeof(*tx_queue_attr),
> +				GFP_KERNEL);
> +	if (!tx_queue_attr) {
> +		err = -ENOMEM;
> +		goto err_tx_queue;
> +	}
> +	priv->tx_queue_attr = tx_queue_attr;

Pointer is set here

> +
>  	ppriv = kcalloc(priv->num_pairs, sizeof(*ppriv), GFP_KERNEL);
>  	if (!ppriv) {
>  		err = -ENOMEM;
> -		goto exit;
> +		goto err_ppriv;
>  	}
>  	priv->ppriv = ppriv;
>  
>  	for (i = 0; i < priv->num_pairs; i++) {
>  		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, 0, &priv->rx_queue_attr[i]);
> +					  i, 0, priv->rx_queue_attr + i);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
>  			goto exit;
>  		}
> -		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
> +		ppriv->rsp_fqid = ((struct dpdmai_rx_queue_attr *)
> +				   (priv->rx_queue_attr + i))->fqid;
>  
>  		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, 0, &priv->tx_queue_attr[i]);
> +					  i, 0, priv->tx_queue_attr + i);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
>  			goto exit;
>  		}
> -		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
> +		ppriv->req_fqid = ((struct dpdmai_tx_queue_attr *)
> +				   (priv->tx_queue_attr + i))->fqid;
>  		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
>  		ppriv->priv = priv;
>  		ppriv->chan_id = i;
> @@ -370,6 +390,12 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  
>  	return 0;
>  exit:
> +	kfree(ppriv);
> +err_ppriv:
> +	kfree(priv->tx_queue_attr);
> +err_tx_queue:
> +	kfree(priv->rx_queue_attr);

Freed on error but you still have dangling reference held

> +err_get_attr:
>  	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
>  	return err;
>  }
> @@ -733,6 +759,8 @@ static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
>  	dpaa2_dpmai_store_free(priv);
>  	dpaa2_dpdmai_dpio_free(priv);
>  err_dpio_setup:
> +	kfree(priv->rx_queue_attr);
> +	kfree(priv->tx_queue_attr);
>  	kfree(priv->ppriv);
>  	dpdmai_close(priv->mc_io, 0, dpdmai_dev->mc_handle);
>  err_dpdmai_setup:
> @@ -763,6 +791,9 @@ static int dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
>  	dpaa2_dpdmai_free_channels(dpaa2_qdma);
>  
>  	dma_async_device_unregister(&dpaa2_qdma->dma_dev);
> +	kfree(priv->rx_queue_attr);
> +	kfree(priv->tx_queue_attr);
> +	kfree(priv->ppriv);
>  	kfree(priv);
>  	kfree(dpaa2_qdma);
>  
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> index 0a405fb13452..38aed372214e 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> @@ -123,8 +123,8 @@ struct dpaa2_qdma_priv {
>  	struct dpaa2_qdma_engine	*dpaa2_qdma;
>  	struct dpaa2_qdma_priv_per_prio	*ppriv;
>  
> -	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
> -	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
> +	struct dpdmai_rx_queue_attr *rx_queue_attr;
> +	struct dpdmai_tx_queue_attr *tx_queue_attr;
>  };
>  
>  struct dpaa2_qdma_priv_per_prio {
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> index 0a87d37f7a92..f3a3eac97400 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> @@ -51,11 +51,6 @@
>   * Contains initialization APIs and runtime control APIs for DPDMAI
>   */
>  
> -/*
> - * Maximum number of Tx/Rx queues per DPDMAI object
> - */
> -#define DPDMAI_MAX_QUEUE_NUM	8
> -
>  /**
>   * Maximum number of Tx/Rx priorities per DPDMAI object
>   */
> -- 
> 2.25.1

-- 
~Vinod
