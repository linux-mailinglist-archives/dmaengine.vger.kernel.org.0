Return-Path: <dmaengine+bounces-4024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445979F6FD8
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 23:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF14F18898AA
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D6199238;
	Wed, 18 Dec 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyK+2aaB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D55156885;
	Wed, 18 Dec 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559436; cv=none; b=la1+a7/zqof8OUSU5NwJ2seYZdZNRNMLpkjKKLyFra1FKSMGpTHT+JcGLDdUhZRiEE3udsDQYwpX1z4y+KTUJrIJwOXWFdZ1hcHe2hmD0BWk1ptiVJ13KmBzAQWWc2YI9ydhxqNMXMc735T+DT8ew2zcdKq0xs3nbfXA/Thgz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559436; c=relaxed/simple;
	bh=K4YOhn/ChJ4vCcI602YiuN00IxDm6SWkEmnEIKkGhIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvxpnBCesmUmtyapsCdnRgCAS5QlVKrm1D7IfrtctlvyPPm7hE6ssC7J/vN4IHdj/rS3XDDj8DTia2GkxhSEfHibTFnUW9GUwCCs7ZB19x+pzx+PYi5E5Rmn75rLT9sz+wklBe1Du6JovR6l5ZmrrTdswIhin4yfUL+vEti9GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyK+2aaB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30229d5b22fso1926251fa.2;
        Wed, 18 Dec 2024 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734559433; x=1735164233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEoEJVitFb92Tvu3XfpVjcUrJl1abp1soj3soQ40D/g=;
        b=SyK+2aaBeLXewBic0Rc/oZP0Enq//pft8wHfTgPW+D0QXGBeKxCiatJylu9b3QRYfq
         2xJh6UP57xybMS+YRtx7EJN3u4v1VZcra/KFnwf02hvMTs6x/DFIot6m1+toWifiaKAW
         V+h49G8plUj5eMNtWWKIVVgBX65Y1HJIAQe1WZ/gfdOfd5rFURDRkn7lw6HLXg9KfiXc
         aIbjtRMr5h3xVdXd0A6LBlQgasSRhjGpNrifmVCIvgFgxUZalVQDf1O4nyZQEx3sfK1X
         nlDq/DIzahmxAjRa5h86ehKGf4voBpj4BG/mFXSmtGi5GNZwWWLWbKxGqNd5xZvdToie
         bo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734559433; x=1735164233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEoEJVitFb92Tvu3XfpVjcUrJl1abp1soj3soQ40D/g=;
        b=wN6E0TO5XCEKAbUR9vEwe5ZtPFSqs7pb8FqyCVVZabjP//+8k1AzNf2ZCKvXY7J3Bd
         IoAcX0VBi6Gcs7faH00CJZiiRVlad/KfRde3Fx9vQTED/xsdb9UzN1tSnTw/C7x8cq26
         qx4fmVYcjk67uksNDDHmKrlBqIz00ZctfRGZnDWQfXRkxqAj7vplBYfS6jvQcENMtE1M
         SA+8W7mo4ZLyjcwwLHRHyre256Uz57tYACEDxbKnW3f2ROBaRwjVxigRlcoPW1UMWlKR
         qfmFRYWSsnhe97S0GbcGb5K9UfUyHokgKQgys5RjilKvjLVSbPp8v+8GVjfVoFEemq0z
         3s2A==
X-Forwarded-Encrypted: i=1; AJvYcCXItUMhuR7QHkzvQBwZry4Hq81N0cVIWpfueFvjgkzabaORMzVqLYkeNKk28Of7OlGdMmqt5F4p8YPf@vger.kernel.org, AJvYcCXkbzq8rBj/aL8S6P71s0F2YnXueJnew1zJIq01weUDhA2QhNvdbsieHwnDl/NHTwdpMnL3fx0+EOGy@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkQeuOdlGctbfM8XsBsaTpr6694ClpdagOnZmNqWKwT3xgbDi
	0Zw1E0gEaUJ/jAe6umYP1YwZPr1+3yxAR8aw40L9lZ5/LqY5JK+dVZdlafoALf+pAw==
X-Gm-Gg: ASbGnct7OsGZ37da5BsDFQelxxYRA0CUCFVtgLNockRK6sH9F2HYAjfP7PzWyguK3qR
	yyoifPBV60tOiC+9K71tRNQMMRfp4B11rTkVwwgfHUudDx7fhC664OLQ6YDBqbldry4KRucS/tf
	teMoM5cPyuubp6dsNGyoa08bovqvDdznrcdAEQXLj0QKhTZrkon+02IL75sQg9LPLkFxkTFTXVu
	6hvb5z6E5JM+YVXfcf57OUOkY9QmSi8Z9fRDrKSELWgJuo+g1JrTvCIwAu6wqCWbSylZBvU9K/h
	Tsl8VLbTDZC3dhy+NE9O3t6Tkw==
X-Google-Smtp-Source: AGHT+IFaAsqs6JUJBRXlAesO5yue6oNlZZp02NwSZiRj//fTgx1Jn7mVgIo5VoqfRQwsNOicu/8wjw==
X-Received: by 2002:a2e:a592:0:b0:302:40ec:9f92 with SMTP id 38308e7fff4ca-30457a42e4emr4457051fa.32.1734559432343;
        Wed, 18 Dec 2024 14:03:52 -0800 (PST)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d930sm17131841fa.14.2024.12.18.14.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:03:51 -0800 (PST)
Message-ID: <913e1081-26c4-4991-a557-609aa4064e89@gmail.com>
Date: Thu, 19 Dec 2024 00:09:49 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: ti: k3-udma: Add support for J722S CSI
 BCDMA
To: Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u-kumar1@ti.com, j-choudhary@ti.com,
 vigneshr@ti.com
References: <20241127101627.617537-1-vaishnav.a@ti.com>
 <20241127101627.617537-3-vaishnav.a@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20241127101627.617537-3-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/27/24 12:16 PM, Vaishnav Achath wrote:
> J722S CSI BCDMA is similar to J721S2 CSI BCDMA but there are slight
> integration differences like different PSIL thread base ID which is
> currently handled in the driver based on udma_of_match data. Add an
> entry to support J722S CSIRX.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V2->V3 : Minor edit in commit message.
> 
> V1->V2:
> 	* Add new compatible for J722S instead of modifying AM62A
> 
>  drivers/dma/ti/k3-udma.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index b3f27b3f9209..7ed1956b4642 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4404,6 +4404,18 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
>  	.soc_data = &j721s2_bcdma_csi_soc_data,
>  };
>  
> +static struct udma_match_data j722s_bcdma_csi_data = {
> +	.type = DMA_TYPE_BCDMA,
> +	.psil_base = 0x3100,
> +	.enable_memcpy_support = false,
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */
> +	},
> +	.soc_data = &j721s2_bcdma_csi_soc_data,
> +};
> +
>  static const struct of_device_id udma_of_match[] = {
>  	{
>  		.compatible = "ti,am654-navss-main-udmap",
> @@ -4435,6 +4447,10 @@ static const struct of_device_id udma_of_match[] = {
>  		.compatible = "ti,j721s2-dmss-bcdma-csi",
>  		.data = &j721s2_bcdma_csi_data,
>  	},
> +	{
> +		.compatible = "ti,j722s-dmss-bcdma-csi",
> +		.data = &j722s_bcdma_csi_data,
> +	},
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, udma_of_match);

-- 
Péter


