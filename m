Return-Path: <dmaengine+bounces-4017-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D59F6112
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4023D1894DB9
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA7116B75C;
	Wed, 18 Dec 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heXA8KDi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9D198845
	for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512999; cv=none; b=KEB5jTPAm25Q7vH1++rK1RL/pb8RHDXKhOu/383e3Xqu3o73fY3ZlHQ+n+n1QTa3mfjlllfFofCPoof8r/JzeGYNEfp45SnUDbldWq8wufTBPkunE4VV9ZbHekuw8qkfYNVbbpIpFCK7qrRUKdZ3NNL08rZsQGuO9cqPvghXsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512999; c=relaxed/simple;
	bh=b1JShOcfx4OC/H4hCSqJnlWA50vVcPx8LGx5EefXNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKRk+qAETPKEw+rvE8mM1BUK5ekM9hPdVSXX242mpsJVhpWFJc6wube9ju3QcTn8F6GJLaPjfzE2VwQeioGDJpE8nsGArAh7Bl15ti4qBtdTIU8au4T9w+TgGPWUOBViesbsD/+ahneFLhra8LbFoEUS8Y6p906ccv+UD5tN1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=heXA8KDi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aab925654d9so871773966b.2
        for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734512996; x=1735117796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZtPf/+ebVZm8ipbL1vunx0JwI+fsXr0ZDHnyMidv2w=;
        b=heXA8KDiRmtNlLlPKSPhJ5A1sm1VOtsnuPxXUm4VryNPt+H84tUdn36jY234wjTDp2
         yAZ/DR5eSNu9wf8CsGkS5er+6HxP8D2l33ECHiBy/TF/9igqCur8Gv7/7uQJFeYJ6P0d
         4HnQ+lcICDrOvsIiUoTgehrCg8I6MtKwDPI6BYBPN2MPoVSBl+bXd87NpJ8Y215Am+wt
         RL5hNY0Ou0dVNV3ytOxo8mpJL8FJd8lpSGhOUIFyXjcPZ9wNOigmMM5c+gthQPGsD0Gc
         5yYcsMcNWo2mr681pbSW34DLJ4+Ji4auwuyBfQ8FDzeQ0CyUNMWNRoPQYXMHHoG5dzzJ
         jp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512996; x=1735117796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZtPf/+ebVZm8ipbL1vunx0JwI+fsXr0ZDHnyMidv2w=;
        b=SHUXAhKBijGQfs/OJLMqHBBxBXSKUY93PsVW3TOFG/lDpqBrny2TPjjDs27c0a5PHF
         DCyJzXLSQY822lQf33GmJuhbmXsl3BVJ510zCie52D8v18/Zh3on4Qfa3oGJK0jMkOvg
         gcn4lMuobA5dxVFqzUsldgbq6hvU0kg8PTE1vHyXQeeyAK3sVKdB2jQXbRmbpKaV+LPP
         UZcAlFKr57aWuN/uYveHALuGjhV/8T1+v/RQejyy6sGd8pjjgWnMW8CSNzCMD05JcFwT
         jAEFl/8BINVNuuzrdSRdYl1K2S8VwmnFWhATE2yajq4cFjDDhYFa0RV38B81B4rkVzAw
         6jFg==
X-Forwarded-Encrypted: i=1; AJvYcCV2m18JilqUspqcCCE5GUsxI+RdoODR4mc9h4XAqpwrz9LGbUYT6zzHcE13WcSl3a64+XHG/j4/gZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LeogUOCmIj+863MRDnE8zQQ9GQHEj3LT9zoQTgrMezhjTfQd
	GyZhPKwMhHZdzOXq0OM4B1Bj2pA8ZpiN7LxMGlPJ6+BObVrJW2dHcqcRsmIS62w=
X-Gm-Gg: ASbGncuXZvTOAfjP03slNx+d/srx5RfuHM/GYrCIJ+BcoZRfL+HxsRDJ8gEUH1TpcG9
	16yiWi21K7Xlxjyh/kdqoPQxMLxtdg3QU2vMHLxJTW0/JXy4sBiYCJ/+sokpk+N4KaZs3cyzXAq
	81hMiB/yog3PKLJG21LxsXsNgC6nSLTTvC4DzQjuBjkhmQOTq8p9gN2BkJ5toygSSkVF/vS4Dvw
	JMrAb8CJGU9l8K5GT5vIolI471l43pKxijclF2kMPvRl3dAeqd+yUpTs8oW6Q==
X-Google-Smtp-Source: AGHT+IFVKz02gEGfzeQ4Ftu4OsejEwEWE0jlAKx2H6Un2qihMOeo85Rto7Hm842V3UrxPPgMuAxsqw==
X-Received: by 2002:a17:906:7313:b0:aa6:2fdc:db1a with SMTP id a640c23a62f3a-aabf48d513cmr147829566b.38.1734512994513;
        Wed, 18 Dec 2024 01:09:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabcab0431dsm278251666b.196.2024.12.18.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:09:54 -0800 (PST)
Date: Wed, 18 Dec 2024 12:09:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ti: edma: fix OF node reference leaks in
 edma_driver
Message-ID: <b9662dbc-1503-433c-ad85-35c2c765787a@stanley.mountain>
References: <20241218011520.2579828-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218011520.2579828-1-joe@pf.is.s.u-tokyo.ac.jp>

On Wed, Dec 18, 2024 at 10:15:20AM +0900, Joe Hattori wrote:
>  drivers/dma/ti/edma.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 343e986e66e7..4ece125b2ae7 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -208,7 +208,6 @@ struct edma_desc {
>  struct edma_cc;
>  
>  struct edma_tc {
> -	struct device_node		*node;
>  	u16				id;
>  };
>  
> @@ -2460,19 +2459,19 @@ static int edma_probe(struct platform_device *pdev)
>  			goto err_reg1;
>  		}
>  
> -		for (i = 0;; i++) {
> +		for (i = 0; i < ecc->num_tc; i++) {
>  			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
>  							       1, i, &tc_args);
> -			if (ret || i == ecc->num_tc)

I feel bad for not saying this earlier, but probably this
"i < ecc->num_tc" change should be done as patch 1/2?  It's sort of
related because if we didn't do this then we'd have to do this we'd
have to re-write it to for the i == ecc->num_tc to add another
of_node_put(tc_args.np).  But really it needs to be reviewed
separately.  It's such a weird thing, that I have to think that it
was done deliberately for some reason although I can't figure out why.

The rest of the patch is nice.  So much simpler than v1.

regards,
dan carpenter


