Return-Path: <dmaengine+bounces-4005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E69F4D7F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACED188AD13
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E71F1319;
	Tue, 17 Dec 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3iESB6s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E33398A
	for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445290; cv=none; b=ons6nMdB9kqQp2Y7MnRicFzzFD7CrmPlDrFq37NmBpAkMPj8kfDpWmYL8GF/lSsP23/M6DfTylZXgIgbIYzt/1wweg82CLgeQb+UjISDHYJXPtECQB9uvaLzArRB4vT4iAkILQIpQejx5LM2V3X+S2WhhNr0SxhEheyCyTLK30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445290; c=relaxed/simple;
	bh=xC0bhkf1wcj9Rx1+MdU8ewe3mIzSbhbg6uwqzBb8REw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoxDIp6Wk61Dvm3/i1iKQfGDn/RVWl+zzA/OamOJNbsr0cQcgoylr2eEHosAIQzjZVNHSDL7qhlw9F/k9IvHo6HyRoWe6S55pNUVyh2cAQqWGrk9rmvVP2cFidZP+o8hBmbNqh41/Triy3+s5/NKatCTzsKeU7lRmUhMYDsUrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3iESB6s; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1077179066b.1
        for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734445287; x=1735050087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0Q15owfJFpJjOp7Av/AkzwbATWIlDXcJSTz7ev//Go=;
        b=O3iESB6sVVquUyQzOf/u/+mpj9ne7MUqyF5zwoDnLmks8JEdnEFOq9VFIwuStWUfhk
         ilZS116YxYobqIp22HEYGKUfmGiAQMYR/ts3cMVmvsLG0lvV7+XVOVOnJo9D2BRDnLKn
         J9FGyooen+MScycO1PbA0Sx01jzxFUOH5uB73SwFopoKP3kz0l1cwPZQXI7hnWB1O3IK
         T1NZG7QyP8yu/qAPbJro1oFhGFMdxOA2sSixpqKjOt3tNXoB/Y9GKC+DCYYxNWWd9SXN
         rRhzYrVZd5Qp3O+YV5nkW6DLAtMA1sklNaUtuWD7Bi0GiCDNzxf2CROi5BPI5c3kJruj
         MGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445287; x=1735050087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0Q15owfJFpJjOp7Av/AkzwbATWIlDXcJSTz7ev//Go=;
        b=FPB3rtz/ooNR5PqZ7csE3PRuY6AdRKVkjQbnIKsEIoYjJ0yj0aRrfrCgfvXMsAHI4J
         XHwFu7tvCRTTLQTIfpZWkq9RRs6G3sSA0Lo2Q1SsO+OEDnIIRAcD5NAG4UjnLXcRx0M9
         hUZ2ZjEmYgteG3a0amAg9sII1pR+eB1ZWk6joNAFqmUmkdEAd3JIaqSVLoNtoFP3h3Ew
         +iJKN4skkN87oWdxydO/RDtZz40gFPqTOuFIy8vAS/NSkQcfboakQ8pBUxgATEuhPgqm
         uC6GA9Zsic9oY0HdMcI+2vMFck/Bb4tLb30VwWGUSf0f7uhaysQEjsWkx+u0pY5a05rN
         ADZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCPNsUyDTIoJQosgQjcnyMa2nMhpIhB5Tr2bJCWhASgE3CRoX6LZNTPCIbDH8HrvKQnusaNdV2dLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tJ3cO57XP80gzC7F7TyyFvKF+4EFbACxyqxHfc3D/siUGJvR
	Kkns9ESm3lP6BamsUjYhPJawe5AAWGmdCx0KCjKIhT1mRADnKPnjCPZHH1zy12U=
X-Gm-Gg: ASbGncsy+DZqy53/YuDESFICvVO5UnyhygWZIuVAVgkJs+M6E8UuxHDvqqlvEiztfxW
	fUZrX0HWJVOCbyezsXV010h2B1Rob1SZCsbpbusQLFKH9gQ0A2PjeJfRF8QNu3tF03QL/IBrYMD
	raV5djK87zMUHzEigsTQxMIVk8ymTGgckLmqlWlIQ6xQdyOu2hr0/N76m+gE4T+q+I6PhrBIdqS
	DcNkNFxmbXdKBRTVHpLECc7tCt0LcodAMikpg2Ed2sxYrgNH97dLOlyfDXvOw==
X-Google-Smtp-Source: AGHT+IG9lo5hxlekEpTIb3BrFdhbLri8kM7oTmyX5afdbNi2S1qhGCdbZG5wyGpXjDFBF5Q+OXg+lg==
X-Received: by 2002:a17:906:d142:b0:aab:9608:4d69 with SMTP id a640c23a62f3a-aab960852cemr1257881166b.27.1734445287315;
        Tue, 17 Dec 2024 06:21:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068d8bsm460725066b.65.2024.12.17.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:21:26 -0800 (PST)
Date: Tue, 17 Dec 2024 17:21:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: fix OF node reference leaks in
 edma_driver
Message-ID: <5e126db0-00b8-4989-ac5a-b79561f2c6e8@stanley.mountain>
References: <20241216102609.760571-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216102609.760571-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Dec 16, 2024 at 07:26:09PM +0900, Joe Hattori wrote:
> The .probe() of edma_driver calls of_parse_phandle_with_fixed_args() but
> does not release the obtained OF nodes. Thus implement
> edma_cleanup_tc_list(), which releases those OF nodes, and call it in
> the error path of .probe() and in .remove().
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/dma/ti/edma.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 343e986e66e7..e6eee6cfa94a 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2279,6 +2279,18 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
>  
>  static bool edma_filter_fn(struct dma_chan *chan, void *param);
>  
> +static void edma_cleanup_tc_list(struct edma_cc *ecc)
> +{
> +	int i;
> +
> +	if (!ecc->tc_list)
> +		return;
> +	for (i = 0; i < ecc->num_tc; i++) {
> +		if (ecc->tc_list[i].node)
> +			of_node_put(ecc->tc_list[i].node);

No need for this NULL check.

In a way, it would be cleanest to just get rid of the .node struct
member.  We never use it.  We could just save the .id and call
of_node_put() right away in probe.  That's really how it's normally
done.

regards,
dan carpenter


