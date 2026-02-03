Return-Path: <dmaengine+bounces-8677-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJafBgWVgWl/HAMAu9opvQ
	(envelope-from <dmaengine+bounces-8677-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:26:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C7D534A
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BCC9304BC03
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F65379966;
	Tue,  3 Feb 2026 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdLn2rfl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890F3793C9
	for <dmaengine@vger.kernel.org>; Tue,  3 Feb 2026 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099891; cv=none; b=gkKING8cYf+qMuSiwpr0FpQ5F18U8rApizdP1WLzw1DxY2vmkkO/WFx22vdoaJA0S2g2dsE8Z4YUMvJzpYnTw6io5FXdknsIXubpEtZ/M/RFxEbTo0ZOghDMLKeLra3N+ZwjN0fSz9SQE2U1Z9k4kLBuz8TF+JY79te7VEVG0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099891; c=relaxed/simple;
	bh=i0uE/26nt7iUIdkoFafdlq22CMKs5RxxZlCz0fRpFZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiCzgg3ot0PLzPelEm7R9B0scYcxIcWaQTfyIOtBTmJrDey6m2P2VwwrvZ0d74h3tDb3NT78NScLQBkPLQpZp77shRQUnxHFdGCPCgYw08RsHFwkDe02O58hAk6lsULtEvp+uExgP+4TpcaPcs9nipwC4eJy3Xggvwcaj8VnHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdLn2rfl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59dd490be5fso6785777e87.2
        for <dmaengine@vger.kernel.org>; Mon, 02 Feb 2026 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770099888; x=1770704688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmP87Dxran5/1UxGC1xq8Fh2q7bON67JLudsohWgZgY=;
        b=YdLn2rflUJWZnZvlPz++ho/qDgfk1O0FTlkXnrF8BG5ZK2fIVKE5Rqf7mTzFV+CQo1
         76Z7IuDxexU+6dZpkLtOjNx157Qws6VMIDasXda+7mmOzrQaJeZ0aE3ccG89n+sPm3yY
         QLeM+z0PIPO5zyOdisZh1GQtgz1RzDybQxtlU9eAAIjMo3LA42dXLxEjSubtiyhR29k5
         XysYi2wxk5pEO5XkolZc0v4JWydr34Z1/jT1VLXc041aEmu09LaEgG7xX/u5dx14bCu+
         dDNPArhobHOLZkGdB+VOGhm00p7SZK0tBShgr86sA2KCFChET0EYZYYT76Q541DyADZn
         Bk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770099888; x=1770704688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmP87Dxran5/1UxGC1xq8Fh2q7bON67JLudsohWgZgY=;
        b=CQeDxBF83lxULazWc6jHB6H+Nxa/RUb0ELvDgiIitlNPVwYvHIg9Kmwp3TnErY056D
         LnmApZJR2huX4fT4mYAmnxrayMKl69DIEt3S8u6esLsGlzVa0i0R9ZyjgbzAqvWUysEy
         eO/WghWPE3hCr99KAaiVwnYJU7BJedTucoy5Y3HYkcmV4f9kE8KDYHmJeUbbnBzupL6L
         a+6obP/B/zHUhNbf/UwngzXJxA2thvjN5JDqm/w/J1WYQWpGR8XIswsx3cjQmp5hKB7b
         msVo2i/L7hQ/j0xMRjydbLmckk7R0SQC/QzyYJ601nUqoUWYWtqBk3R5u1F/z9mvILQQ
         GvPw==
X-Forwarded-Encrypted: i=1; AJvYcCVekNu8euE96lzXkkLMj4NMw8Lg5WQwjkEEa1Vw+rSul7OPnGJjl1Jm6z27uuodi4cAoyffnEd0KKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUL7PenziCnglLczlJRTk4hSdz3xSW4Ma5LRpfoa0vyAg2xbD
	75SzD6xU4FUZziXNE9lFiYPJD+Cuask77OnH/Fooj7dmuGZjl3L5sj9t
X-Gm-Gg: AZuq6aLUULBgAI6EhQ/iuWBMyPJvrHTU44MRO5Wf/JZTXzA7zm8sFnCbxU2mieUzJ3A
	aG6+lnBGeTE4xCHleB8rWdKQBpKvsIHXD8Z5IwKhVbPC0SRo4drJs5UXLXiYZ1K6jPUy0SazJI1
	UrdYe8IGPxHDOK/dzRmJoBsTX+svxC0ZPfibP/yR+EqWM+aV3HcS1fL6MZdMsFjzZbw1xspjWh3
	db7pTqKNGhdb7TrSFFNpuzOJfROXWH2ARl0qGtTpWUNm0Xe4InQGNyPF1KW74ejndNbxYqdg5Qz
	tjLOPcQlGFF9abTIhOcjCoQwFey/RGzn/a/nvatA195rAWdLKVVYhz4KfLZXLavrGqx57PAsvd5
	4iC00X8h0GCx5HVVx5fSv64QwnlyxeK4SWWgzFUPRNK0JHKeoEWwPiAS57h90Ht9fvklRi1jlid
	d2eFUbWenBjjOs1+h79eM8Nm7oIJisNNhvMKSuJGcVaslscH6vN9LfS91fdoWHxRZX2ZPYmQ==
X-Received: by 2002:ac2:4e01:0:b0:599:11a5:54fd with SMTP id 2adb3069b0e04-59e163f57c7mr4754837e87.4.1770099888139;
        Mon, 02 Feb 2026 22:24:48 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b6fcfsm4002019e87.69.2026.02.02.22.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:24:47 -0800 (PST)
Message-ID: <bb476db0-1421-4fdd-9415-85839425f9b9@gmail.com>
Date: Tue, 3 Feb 2026 08:25:59 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] dmaengine: ti: k3-udma-v2: Add support for
 PKTDMA V2
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com
Cc: r-sharma3@ti.com, gehariprasath@ti.com
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-17-s-adivi@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20260130110159.359501-17-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8677-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterujfalusi@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45C7D534A
X-Rspamd-Action: no action



On 30/01/2026 13:01, Sai Sree Kartheek Adivi wrote:
> The PKTDMA V2 is different than the existing PKTDMA supported by the
> k3-udma driver.
> 
> The changes in PKTDMA V2 are:
> - Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
>   needs to set in the RT_CTL register.
> - Static channel mapping: Each channel is mapped to a single
>   peripheral.
> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>   directly connected to GIC.
> - Remote side configuration handled by DMA. So no need to write to
>   PEER registers to START / STOP / PAUSE / TEARDOWN.

Plus I suppose..

> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/k3-udma-common.c |  29 ++++-
>  drivers/dma/ti/k3-udma-v2.c     | 219 ++++++++++++++++++++++++++++++--
>  drivers/dma/ti/k3-udma.h        |   3 +
>  3 files changed, 232 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index ba0fc048234ac..d6459bcc17599 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -2461,12 +2461,21 @@ int pktdma_setup_resources(struct udma_dev *ud)
>  
>  	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
>  					   sizeof(unsigned long), GFP_KERNEL);
> +	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
>  	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
>  				  GFP_KERNEL);
> -	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> -					   sizeof(unsigned long), GFP_KERNEL);
> -	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> -				  GFP_KERNEL);
> +	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
> +		ud->rchan_map = ud->tchan_map;
> +		ud->rchans = ud->tchans;
> +		ud->chan_map = ud->tchan_map;
> +		ud->chans = ud->tchans;

It has single channel space and the TX/RX functionality alternates
within the space?
chX: TX, chX+1: TX, chX+2: RX, chX+3: TX, etc?

> +	} else {
> +		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> +						   sizeof(unsigned long), GFP_KERNEL);
> +		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> +					  GFP_KERNEL);
> +	}

...

> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
> index af06d25fd598b..6761a079025ba 100644
> --- a/drivers/dma/ti/k3-udma-v2.c
> +++ b/drivers/dma/ti/k3-udma-v2.c
> @@ -744,6 +744,146 @@ static int bcdma_v2_alloc_chan_resources(struct dma_chan *chan)
>  	return ret;
>  }
>  
> +static int pktdma_v2_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	struct udma_dev *ud = to_udma_dev(chan->device);
> +	u32 irq_ring_idx;
> +	__be32 addr[2] = {0, 0};
> +	struct of_phandle_args out_irq;
> +	int ret;

Nitpick: revers christmas tree declaration order.

-- 
Péter


