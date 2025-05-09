Return-Path: <dmaengine+bounces-5126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D46AB174D
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B29167662
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB450213E89;
	Fri,  9 May 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdiQzP7Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B172110;
	Fri,  9 May 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800637; cv=none; b=FIa0DD16Ly3YYI5czjAfnWJi6yY6Kro18XNDxGU6z1TcnqEO8B/yOkeHSVyLpgxIuvolWUeboCYVJ2pkYu9A+IhQFGSAXLK+uRxKQ1DL47MZEf4cRD/7fXx6ZmTS9Zz8K22LFacEgBgmu+RGytgCsaumpSc4bCMFLDLkRAco/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800637; c=relaxed/simple;
	bh=mKXdWzLrmsTTnENNjShW0XhnUXX8RfpTZL/UWCfCqlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M26h9w0FshqM+KQsphFcg8VeLs7tqjrcCx+UmnpfMXpzKLT9b5urMs988qAFakb7nlExdMNC3SepGwo3oQpyx108a/t+EKqwmLFoE+UsPPvXRIuKoqtljmYloBb0EaYE42bqns/3OMz2z0+KaFPq2T0yq9F0PKcLNT0c5+63NpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdiQzP7Y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b159c84cso2597563e87.3;
        Fri, 09 May 2025 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746800634; x=1747405434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MoaHVq8f5uoSyjjX75HEcA9MREgvZcIUuW4iFJxdZ4A=;
        b=jdiQzP7Y1xT51wHqo8sE/9TtyP6qj5QA3e24pRsUmyWOeoSGesTrRSULKV4OmEy5qL
         cF0BojXBsKkC5orJu6A3qRXHqpvJsYFGp/Y/evHPVtx67ni6ouoWP2Q3xnZB+XpdLnqM
         bSg69TPuwGbjI/SxXm0io8KQ2HkDhVYsnl+gbGE2MnqDtxWfu5HvBnQyjyUA0hf+Tgfm
         wk7Bqm7qkFrGijm2ttzuwX2m+U4TdWsYkxBsjptQHRoZGP0UYmJy7q831yQF+fuKCH8z
         tBTtBo2/8uQx9XKmDKgDCiMFuVXo74fwMH/kMtr0WZwoIgz0mg1GQF5aSezV0eBhvQWj
         UdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800634; x=1747405434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoaHVq8f5uoSyjjX75HEcA9MREgvZcIUuW4iFJxdZ4A=;
        b=qA5VraabM6e4E8n7sAqo9oPbEU5+S63NgRiE60/yYynUxBTLf3ry+wZNVNBQxdSnjl
         ZGPvtdl+p0HSQQiDsEd691CNbPbjSHfn7nf5BkGDd68RQZijnY/fTs3fnC5Yxa8H/OGz
         ShnhgekO9Sh5NNSG4ieo+PWyN6z/a0iVqZTEEYJZP5CGgtyCzGYxsfLXSq7AdZZ790KF
         ccDaB3iOdLIcGa/GXZxOR2h9n/HwTqFPwgbJ6EU6F3nTgpmzM2od4CmgDACLA/M94UxH
         BsIJBNcd4vAeNmUS299Rak8CLRI/du2lHrRmYeIpF0jXxpky+4RjndYBZ09ndBksQy2Z
         eXnw==
X-Forwarded-Encrypted: i=1; AJvYcCUu0P5J/mPO9IUDa8movOeFCjvRZ78hPBMzoOsrrkxaUCLV5CKvk/jMIKntB8tOFMDKTkVeIC1jvVsM@vger.kernel.org, AJvYcCVRhUdT5nxyZVXjxkTVubXffvmLoEVeJ2Fm6vT+IHQffldHnWN4/F52YG67U2CsAgxueK37O5KaDE8b@vger.kernel.org, AJvYcCXiyQ+dBN21H0ULDmehkrUlAwneBICKZFy9Z5SwEU4afcPdtK04+gjOFfR428BcPAnF4B9jopyP6BNDeWkF@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnIesFAgQ9wKeNYiwk08wmvhSo097dPY8xgsw1mpPGGGJ8vp+
	OFh72yc9Kr3r7BFYBuQnBIYGFKO+tybfwR7W6LiDlX+TBU1mmigT/DFdneZZhM8=
X-Gm-Gg: ASbGncuYxKRjD8KmmkbUhfyCAuuZYMHh6sfs8I0UKl/n4383YgfIb2gOeLMIwGERBKs
	kfjp60QpobU0n3cEeG+1BrrQ6G0BiM1uNz03XgzE7rECDAmOHyAuk7NWlKC84afNags9ggNX8vD
	BV8StQKqfASshI/OoVCYGil/fcp6MYXSxrtsFum+x+iwMDQNk9RZOrqOUXBLLg43AcPY4dKRiCB
	dzw2SUZw3LPbtmq/u1DV2AZKnOkf4si62+xu0apyUnMcoANjyecLIadGPT6pBTv0LkkhabzxYrt
	mt94wOLJnyvmjng5AvlHUcNxxrx9vSr3u1E5w4tydEIpmrxuFiQOgk+WHTg0wwqUhq+bAXqI/0J
	Zke7MRdFbzc2pAydv+WSAuvigtmb08q9V4MgHXe8w7C3LOD+kt6zpQ5Z+Xk0d/b6YYVLxJzPe
X-Google-Smtp-Source: AGHT+IEiqJIsmXnH9dNxGfVEY7/IBx5BdjSAyjSugSQ904/Pvglv5wzXp+SHaqKYougS4EZvpuYKRw==
X-Received: by 2002:a05:6512:2913:b0:54a:cc75:3d81 with SMTP id 2adb3069b0e04-54fc67b4624mr1116687e87.4.1746800633673;
        Fri, 09 May 2025 07:23:53 -0700 (PDT)
Received: from ?IPV6:2001:999:701:52e0:b498:b01c:c3ac:ae69? (n7kenj77twmhzm8jtyh-1.v6.elisa-mobile.fi. [2001:999:701:52e0:b498:b01c:c3ac:ae69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64b6ebesm289857e87.137.2025.05.09.07.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:23:53 -0700 (PDT)
Message-ID: <e823a43e-20a8-4142-875f-a3575cbb0d0b@gmail.com>
Date: Fri, 9 May 2025 17:25:06 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drivers: dma: ti: Refactor TI K3 UDMA driver
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-4-s-adivi@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20250428072032.946008-4-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 28/04/2025 10:20, Sai Sree Kartheek Adivi wrote:
> Refactors and split the driver into common and device
> specific parts. There are no functional changes.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/Makefile         |    2 +-
>  drivers/dma/ti/k3-udma-common.c | 2909 ++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c        | 3751 ++-----------------------------

I'm affraid you do need to break this one up a bit. It might be doing it
correctly, but it is impossible to check with the churn, like ....

>  drivers/dma/ti/k3-udma.h        |  548 ++++-
>  4 files changed, 3700 insertions(+), 3510 deletions(-)
>  create mode 100644 drivers/dma/ti/k3-udma-common.c

...

> -static bool udma_is_chan_running(struct udma_chan *uc)
> -{
> -	u32 trt_ctl = 0;
> -	u32 rrt_ctl = 0;
> -
> -	if (uc->tchan)
> -		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> -	if (uc->rchan)
> -		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> -
> -	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
> -		return true;
> -
> -	return false;
> -}
> -
>  static bool udma_is_chan_paused(struct udma_chan *uc)
>  {
>  	u32 val, pause_mask;
> @@ -643,189 +88,73 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
>  	return false;
>  }
>  
> -static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
> +static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)


These sort of diffs.

>  {
> -	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
> +	if (uc->desc->dir == DMA_DEV_TO_MEM) {
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		if (uc->config.ep_type != PSIL_EP_NATIVE)
> +			udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	} else {
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		if (!uc->bchan && uc->config.ep_type != PSIL_EP_NATIVE)
> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	}
>  }
>  
> -static int udma_push_to_ring(struct udma_chan *uc, int idx)
> +static void udma_reset_counters(struct udma_chan *uc)
>  {

...

> +struct udma_dev {
> +	struct dma_device ddev;
> +	struct device *dev;
> +	void __iomem *mmrs[MMR_LAST];
> +	const struct udma_match_data *match_data;
> +	const struct udma_soc_data *soc_data;
> +
> +	struct udma_tpl bchan_tpl;
> +	struct udma_tpl tchan_tpl;
> +	struct udma_tpl rchan_tpl;
> +
> +	size_t desc_align; /* alignment to use for descriptors */
> +
> +	struct udma_tisci_rm tisci_rm;
> +
> +	struct k3_ringacc *ringacc;
> +
> +	struct work_struct purge_work;
> +	struct list_head desc_to_purge;
> +	spinlock_t lock;
> +
> +	struct udma_rx_flush rx_flush;
> +
> +	int bchan_cnt;
> +	int tchan_cnt;
> +	int echan_cnt;
> +	int rchan_cnt;
> +	int rflow_cnt;
> +	int tflow_cnt;
> +	unsigned long *bchan_map;
> +	unsigned long *tchan_map;
> +	unsigned long *rchan_map;
> +	unsigned long *rflow_gp_map;
> +	unsigned long *rflow_gp_map_allocated;
> +	unsigned long *rflow_in_use;
> +	unsigned long *tflow_map;
> +
> +	struct udma_bchan *bchans;
> +	struct udma_tchan *tchans;
> +	struct udma_rchan *rchans;
> +	struct udma_rflow *rflows;
> +
> +	struct udma_chan *channels;
> +	u32 psil_base;
> +	u32 atype;
> +	u32 asel;
> +
> +	int (*udma_start)(struct udma_chan *uc);
> +	int (*udma_stop)(struct udma_chan *uc);
> +	int (*udma_reset_chan)(struct udma_chan *uc, bool hard);
> +	bool (*udma_is_desc_really_done)(struct udma_chan *uc, struct udma_desc *d);
> +	void (*udma_decrement_byte_counters)(struct udma_chan *uc, u32 val);

You can drop the udma_ prefix, it is clear that they are for udma..

> +};
-- 
Péter


