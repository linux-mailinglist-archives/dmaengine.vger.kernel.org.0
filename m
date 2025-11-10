Return-Path: <dmaengine+bounces-7107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE61C45E3E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDAF1891A68
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929A24BBE4;
	Mon, 10 Nov 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgH64gcS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AF2EB847
	for <dmaengine@vger.kernel.org>; Mon, 10 Nov 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770039; cv=none; b=Z753CY11HAD4e2e3x5KGNGQmKNV7QR0wXQpd7OwXMMMO3g8Xx1OQHOnOfGqv8O8c52SQRT5XQdPux8vVS9fICcZ5yAIgULXJWt63UnO0aGr6BsX33aPmaBE90MIAiRDF5QUtPkXxqxXWhfXq4I9su3TT1kEEyWtrSHYRLENt2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770039; c=relaxed/simple;
	bh=NwuE0OymVSZ9Pgk9z4LwcFOxB4oAvyBUKaNACTeODX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhSbZEol7HB4uiaEdJPgqGkb0zrn5BCO5MDc8BpPWuQvLh2WJJRwz1FycaUCqbv1ggzepW01Bs1hdzbWQGYsx7kIxWf62vNT16yJOSMjr6Ik6lbTnsZrlUSQcDWzE+s0ysmd5vjHsc7VK0q44HSlwYgt6RIFdnU+fFG91oq/owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgH64gcS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4774f41628bso13134175e9.0
        for <dmaengine@vger.kernel.org>; Mon, 10 Nov 2025 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770037; x=1763374837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHN6hT4IBJzArtDOwYIufgC/ZHeLt/dXS4u8pqqIeWA=;
        b=IgH64gcSLPPAGDGicIAciGdy5cZdAb613AYJ/+Ui+EHrNfsBZzxzrVD9zmNijjCbr1
         8FXLdU6R8v2Wc7VlIDGx9ZntmSdg65xKYXqenKZ3EsLGJ8Ref1UIdGwOkxNnoquxaI5d
         dSGLCxKA0PTFVB/SnlTUXvS0XNWILHQj0/y5KafOaP1lS/EAEgJnLnVr68XHvgDVTahe
         IrOauZRCF3qKXgsDUaUMMjrxlMGIFF2u0akRPRz0/LeBZju3ePgmF1Bo9hdpRo1jjtHn
         XqjbwIrchn9cYzTRLRumNwlL7/EBh+0QlZTkwja0vX+urixmuggPfWhwIEXU7xE9tQ0N
         FySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770037; x=1763374837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHN6hT4IBJzArtDOwYIufgC/ZHeLt/dXS4u8pqqIeWA=;
        b=mv1WDEHcxtpiTPrFUh6IoAMrd6MPWFTQW+QHMZMNTYIQmN7R3YupYBrvev+Er3ytfw
         SxEMCQNL7Cwb1MHSO1+l5BuFEOzSWKkEhw2EmCctqQM6uDfiQC0cu1Aer92SBbRjt6FQ
         H1lj/QebDxc2Uo88W3lJTChHnMfCwK9PE4sJeJDKVGCZSinaZov3mSOHgKPvSqyaFhqe
         bRDyiStOsGhb0NqxMLQUQTyn1M9ql3PVoSgRE07BYVC3iliK7NfHvkUtGRFUGOWlrL0C
         ngivTFmyxGmtJro91uGw0WJZH2SPPJxtJbCmrtbBjJsmppF/tI7p8DfznDjBtIZPAcMv
         2SHA==
X-Gm-Message-State: AOJu0Ywuxqn8JFwSu5VPvRUNW+uBm0jFgQ3DmtZTmHqqvB+4YCvaqmIm
	PORc7U5ENO+DSVhHIOzeN7M877x9YWMkpZF+J2MI8RQR8ysG2ZMZDkh3xYgAhZNR
X-Gm-Gg: ASbGnctyGw0/8kVaitQg7plBjtMj69YxArtHfj5NsknP4zOJf+2Puixa+kAdHgj2EXS
	ke0myT1xmRNco6RIWpH6w82kS0exH3mluPlnDva3PAfLjsnU5Ut7x+q69IeF5hol8iX8ZHFONUT
	qgWXq7mDbW4KZTOH5sCp7ElIRuEt1j1CQXYA6BElXrdveXr3FfvXuMrHwc7QXcDzEcwSzilCtNe
	WBHm6xfMpiL3VOz+pR0Sy2/+2ylbBdyp5MTgRXmYJB8sG4uaK9uT3ElmWA6HMZ10OVor0IErzaL
	SSZ2Lka9dNXUo5QR/ED13Cb7bjf8MJMh+sEKLX+5HW6uVAcsO92XvTQ4NxHPqqNdl39Y3AY3rOU
	6bxDkCSZBOb9z7P1EfIqwDAAImkdlGmtUR76TYlv+OZZ4Uu8oiGg6iUq+6BydgqyeX0CjgQ8dYI
	cfq92V5h162lG8qQ8uDzoYcs6GrQk5EHWvx/VHtFdZnZ6q3Dvz0XOdYlnPsro14b50PMGfeJLHi
	Z8=
X-Google-Smtp-Source: AGHT+IFP3O2YUEuoot/+M0fJaUnySlBCmO85Z/WipYoF1i2pacbVS7QKl7uZsAR7sKgw63LPBf7HNw==
X-Received: by 2002:a05:600c:3b01:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47772deb36bmr71489405e9.11.1762770036422;
        Mon, 10 Nov 2025 02:20:36 -0800 (PST)
Received: from u67f9ca6e60d851.ant.amazon.com (54-240-197-232.amazon.com. [54.240.197.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm24159885f8f.44.2025.11.10.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:20:35 -0800 (PST)
Date: Mon, 10 Nov 2025 11:20:33 +0100
From: Praveen Kumar <kpraveen.lkml@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/3] dmaengine: Use device_match_of_node() helper
Message-ID: <aRG8cVly3b7sR9Vw@u67f9ca6e60d851.ant.amazon.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
 <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 09:47:44AM +0100, Andy Shevchenko wrote:
> Instead of open coding, use device_match_of_node() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index eb27a72cd4c5..e89280587d5d 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -765,7 +765,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  	mutex_lock(&dma_list_mutex);
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>  		/* Finds a DMA controller with matching device node */
> -		if (np && device->dev->of_node && np != device->dev->of_node)
> +		if (np && !device_match_of_node(device->dev, np))

I see a difference in what device_match_of_node does vs what was
happening in the previous check. And, we have an unwanted double
check of np.

int device_match_of_node(struct device *dev, const void *np)
{
        return np && dev->of_node == np;
}

Instead, I would recommend,

        if (device->dev->of_node && !device_match_of_node(device->dev, np))
                continue;

Regards,
Praveen Kumar.

>  			continue;
>  
>  		chan = find_candidate(device, mask, fn, fn_param);
> -- 
> 2.50.1
> 

