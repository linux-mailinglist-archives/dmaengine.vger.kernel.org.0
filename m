Return-Path: <dmaengine+bounces-1560-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7B88E4A0
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ED22953C9
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADA1BD5D7;
	Wed, 27 Mar 2024 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y6U0j+OF"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F199130E26;
	Wed, 27 Mar 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542548; cv=none; b=Tw/iOa/8uOggQaCwblsebKzAV/egqdOMxtBaYH4RsyT51yNl318X4S02affT/5jhLxwgBXKzxiT4TX/ov3zi7V7RUQpEDdDeC2jlivQ3n6NQQats4A/kLkQR3VEurO4ua8HqPs4JUcpVTYK5eJT9l00KSo6B6OtHJjz8wqBJ92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542548; c=relaxed/simple;
	bh=CO5GH4EA8whWcoaMAqHIvlMBS85gT/fzeKfIasWL0u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nx2GuC8AGoqsOyrvF0Gq10GXvbhkpRA0V+0svAweb2rGZhwWYg4PR9luow6WN+lzK3F7HbEyznJh1KrZLSSTTgXHvHtDgZAViiVkPwkSBcUJ+IMAExxOvbd2LrOeAUjDRL42xmj5j5VJxqjA4Ho0+twwy8a6REhMG+NClBdudCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Y6U0j+OF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D157F1803;
	Wed, 27 Mar 2024 13:28:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711542513;
	bh=CO5GH4EA8whWcoaMAqHIvlMBS85gT/fzeKfIasWL0u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6U0j+OFBoERo4NLXOKKaj2rQdhlzROnRmG0SPXr0BzC8cPgxX5eLyopVOCtZ6Fg1
	 PdY2shE1BVORLLodPIwDAcXWP69d0OZeMT+rgHTlw+QeUn/nzAYXhlfCy4qxAFWDop
	 6QEAlXuKLNUlooSiAoK7/AfWsIUZNemcLT3rMPlA=
Message-ID: <a4053c39-3781-4fc4-9c5e-45f32b5525ed@ideasonboard.com>
Date: Wed, 27 Mar 2024 14:29:02 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dma: Add lockdep asserts to virt-dma
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
 <20240308210034.3634938-4-sean.anderson@linux.dev>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20240308210034.3634938-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 23:00, Sean Anderson wrote:
> Add lockdep asserts to all functions with "vc.lock must be held by
> caller" in their documentation. This will help catch cases where these
> assumptions do not hold.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

>   drivers/dma/virt-dma.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index e9f5250fbe4d..59d9eabc8b67 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -81,6 +81,8 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
>    */
>   static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
>   {
> +	lockdep_assert_held(&vc->lock);
> +
>   	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
>   	return !list_empty(&vc->desc_issued);
>   }
> @@ -96,6 +98,8 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
>   	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>   	dma_cookie_t cookie;
>   
> +	lockdep_assert_held(&vc->lock);
> +
>   	cookie = vd->tx.cookie;
>   	dma_cookie_complete(&vd->tx);
>   	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> @@ -146,6 +150,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
>   {
>   	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>   
> +	lockdep_assert_held(&vc->lock);
> +
>   	list_add_tail(&vd->node, &vc->desc_terminated);
>   
>   	if (vc->cyclic == vd)
> @@ -160,6 +166,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
>    */
>   static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
>   {
> +	lockdep_assert_held(&vc->lock);
> +
>   	return list_first_entry_or_null(&vc->desc_issued,
>   					struct virt_dma_desc, node);
>   }
> @@ -177,6 +185,8 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
>   static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
>   	struct list_head *head)
>   {
> +	lockdep_assert_held(&vc->lock);
> +
>   	list_splice_tail_init(&vc->desc_allocated, head);
>   	list_splice_tail_init(&vc->desc_submitted, head);
>   	list_splice_tail_init(&vc->desc_issued, head);


