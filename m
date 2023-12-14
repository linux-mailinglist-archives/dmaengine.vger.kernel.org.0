Return-Path: <dmaengine+bounces-531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F0813507
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9891F217AC
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FE41776;
	Thu, 14 Dec 2023 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOLnNWQt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884D98;
	Thu, 14 Dec 2023 07:41:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50c222a022dso9128454e87.1;
        Thu, 14 Dec 2023 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702568486; x=1703173286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7HDmzsaHFHq+DU4TEpp0WIaGVnds4w3KOhZMOHkczk=;
        b=LOLnNWQtwwz1iSTsZLikzRosDO+aPu07JcohVfUEwVf1kYlbVhSupe6TKwC7wOL5F/
         kuloYclUce1gsa0Aq66VJ3M7yqkxbFu4/XeDKsMlCiEc5ZPAGl2t9kGJ8m3aPl7DWbQl
         Zw0A1LhFsDkJbzxD0qrSsLGNyuhufS0/kH3paXxNmF8PwJRbWxtpV8g+Xde0uET4gue7
         Ii4zGTMD0/14XHYi5y5s8MPF2p8lqvg+vImZkKQy/mAWD1V7HRNj6Zz8x8s52ufq4BVg
         KtdGtz2H93KJONty65v5uVo3n0JbB7LDH2gHUxq2XYvoXoWWWeJm+EABSaWti8xmoeGT
         vIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568486; x=1703173286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7HDmzsaHFHq+DU4TEpp0WIaGVnds4w3KOhZMOHkczk=;
        b=IZ+orzjiWtOT0Tb6rN6hQv2tA23NTCH98jN5YxjBHLTy6HtkAChluODEJtwaqnK8jb
         yPHA5jKFVFTlrE7wGX3DuM4yWw+6y2AZihWtjYkUkFSt4VkUy2l3o/frhZqGVFiUWe0H
         LDfiN96GG6ODE0rBLYlhfHgkRCBE/isYULqzH+cHzia3WXizk9bbg+iBb5vJJlhgktyf
         4x5KCQX1pcJYiezxaG/n0Jy5JT8WL2l7FzZwVdff+QI2CcgqbRSewsBhs6lkhJrUTLYU
         vyjI9iJ4pw5mwTxvyTuQF+E4R3Vr4X7OA+KkdsmOcbNqoOExigJwlVDK2R3gzPrneurI
         7SAw==
X-Gm-Message-State: AOJu0YxwdCY2pOU8LbT+bbzrZWt+VFz3hZUAZ4PhBL/68sR/4j3gZf6C
	IeMJxGNOZHZvYfo9YwYsn4JW0cRK0BVwyZel
X-Google-Smtp-Source: AGHT+IHl7aZiwhhSRVsewhLH5eWdMf5cDNNTiNfsCc2LqT324H/ylI7lzlHhqRDqjAn8UastjVE5aA==
X-Received: by 2002:ac2:414e:0:b0:50b:ea8e:b42c with SMTP id c14-20020ac2414e000000b0050bea8eb42cmr4179283lfi.97.1702568486367;
        Thu, 14 Dec 2023 07:41:26 -0800 (PST)
Received: from ?IPV6:2001:999:500:b28b:4dc9:e5af:1ee1:c18e? ([2001:999:500:b28b:4dc9:e5af:1ee1:c18e])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651206ca00b0050c0beaba37sm1900526lff.154.2023.12.14.07.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:41:25 -0800 (PST)
Message-ID: <800ccf2e-65cc-4524-8a42-1657a5906482@gmail.com>
Date: Thu, 14 Dec 2023 17:41:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dmaengine: ti: k3-udma-glue: Add function to
 request TX channel by ID
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
References: <20231212111011.1401641-1-s-vadapalli@ti.com>
 <20231212111011.1401641-4-s-vadapalli@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231212111011.1401641-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/12/2023 13:10, Siddharth Vadapalli wrote:
> The existing function k3_udma_glue_request_tx_chn() supports requesting
> a TX DMA channel by its name. Add support to request TX channel by ID in
> the form of a new function k3_udma_glue_request_tx_chn_by_id() and export
> it for use by drivers which are probed by alternate methods (non
> device-tree) but still wish to make use of the existing DMA APIs. Such
> drivers could be informed about the TX channel to use by RPMsg for example.
> 
> Since the implementation of k3_udma_glue_request_tx_chn_by_id() reuses
> most of the code in k3_udma_glue_request_tx_chn(), create a new function
> for the common code named as k3_udma_glue_request_tx_chn_common().
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Changes since v1:
> - Updated commit message indicating the use-case for which the patch is
>   being added.
> 
>  drivers/dma/ti/k3-udma-glue.c    | 101 +++++++++++++++++++++++--------
>  include/linux/dma/k3-udma-glue.h |   4 ++
>  2 files changed, 79 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index eff1ae3d3efe..ea5119a5e8eb 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -274,29 +274,13 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>  	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
>  }
>  
> -struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
> -		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg)
> +static int
> +k3_udma_glue_request_tx_chn_common(struct device *dev,
> +				   struct k3_udma_glue_tx_channel *tx_chn,
> +				   struct k3_udma_glue_tx_channel_cfg *cfg)
>  {
> -	struct k3_udma_glue_tx_channel *tx_chn;
>  	int ret;
>  
> -	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
> -	if (!tx_chn)
> -		return ERR_PTR(-ENOMEM);
> -
> -	tx_chn->common.dev = dev;
> -	tx_chn->common.swdata_size = cfg->swdata_size;
> -	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
> -	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
> -	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
> -	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
> -
> -	/* parse of udmap channel */
> -	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
> -					&tx_chn->common, true);
> -	if (ret)
> -		goto err;
> -
>  	tx_chn->common.hdesc_size = cppi5_hdesc_calc_size(tx_chn->common.epib,
>  						tx_chn->common.psdata_size,
>  						tx_chn->common.swdata_size);
> @@ -312,7 +296,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  	if (IS_ERR(tx_chn->udma_tchanx)) {
>  		ret = PTR_ERR(tx_chn->udma_tchanx);
>  		dev_err(dev, "UDMAX tchanx get err %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
>  
> @@ -325,7 +309,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  		dev_err(dev, "Channel Device registration failed %d\n", ret);
>  		put_device(&tx_chn->common.chan_dev);
>  		tx_chn->common.chan_dev.parent = NULL;
> -		goto err;
> +		return ret;
>  	}
>  
>  	if (xudma_is_pktdma(tx_chn->common.udmax)) {
> @@ -349,7 +333,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  					     &tx_chn->ringtxcq);
>  	if (ret) {
>  		dev_err(dev, "Failed to get TX/TXCQ rings %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
>  	/* Set the dma_dev for the rings to be configured */
> @@ -365,13 +349,13 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  	ret = k3_ringacc_ring_cfg(tx_chn->ringtx, &cfg->tx_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
>  	ret = k3_ringacc_ring_cfg(tx_chn->ringtxcq, &cfg->txcq_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
>  	/* request and cfg psi-l */
> @@ -382,11 +366,42 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  	ret = k3_udma_glue_cfg_tx_chn(tx_chn);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg tchan %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
>  	k3_udma_glue_dump_tx_chn(tx_chn);
>  
> +	return 0;
> +}
> +
> +struct k3_udma_glue_tx_channel *
> +k3_udma_glue_request_tx_chn(struct device *dev, const char *name,
> +			    struct k3_udma_glue_tx_channel_cfg *cfg)
> +{
> +	struct k3_udma_glue_tx_channel *tx_chn;
> +	int ret;
> +
> +	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
> +	if (!tx_chn)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tx_chn->common.dev = dev;
> +	tx_chn->common.swdata_size = cfg->swdata_size;
> +	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
> +	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
> +	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
> +	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
> +
> +	/* parse of udmap channel */
> +	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
> +					&tx_chn->common, true);
> +	if (ret)
> +		goto err;
> +
> +	ret = k3_udma_glue_request_tx_chn_common(dev, tx_chn, cfg);
> +	if (ret)
> +		goto err;
> +
>  	return tx_chn;
>  
>  err:
> @@ -395,6 +410,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
>  
> +struct k3_udma_glue_tx_channel *
> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
> +				  struct device_node *udmax_np, u32 thread_id)

udmax_np is not dev->of_node ?

> +{
> +	struct k3_udma_glue_tx_channel *tx_chn;
> +	int ret;
> +
> +	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
> +	if (!tx_chn)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tx_chn->common.dev = dev;
> +	tx_chn->common.swdata_size = cfg->swdata_size;
> +	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
> +	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
> +	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
> +	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
> +
> +	ret = of_k3_udma_glue_parse_chn_by_id(udmax_np, &tx_chn->common, true, thread_id);
> +	if (ret)
> +		goto err;
> +
> +	ret = k3_udma_glue_request_tx_chn_common(dev, tx_chn, cfg);
> +	if (ret)
> +		goto err;
> +
> +	return tx_chn;
> +
> +err:
> +	k3_udma_glue_release_tx_chn(tx_chn);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn_by_id);
> +
>  void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>  {
>  	if (tx_chn->psil_paired) {
> diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
> index e443be4d3b4b..6205d84430ca 100644
> --- a/include/linux/dma/k3-udma-glue.h
> +++ b/include/linux/dma/k3-udma-glue.h
> @@ -26,6 +26,10 @@ struct k3_udma_glue_tx_channel;
>  struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg);
>  
> +struct k3_udma_glue_tx_channel *
> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,

I know it is going to be longer, but can the function be named more
precisely?
k3_udma_glue_request_tx_chn_by_thread_id

For TX/RX: a channel is always for one thread, right?
Probably:
k3_udma_glue_request_tx_chn_for_thread_id()

?

Other then this the series looks OK.


> +				  struct device_node *udmax_np, u32 thread_id);
> +
>  void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
>  int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
>  			     struct cppi5_host_desc_t *desc_tx,

-- 
Péter

