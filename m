Return-Path: <dmaengine+bounces-5477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4DADA31F
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 21:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8859F188FA7A
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAF27BF84;
	Sun, 15 Jun 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPvkF4yr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9F2620D1;
	Sun, 15 Jun 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750014917; cv=none; b=m/MJf+SKTVHkvibk5xlygha3iBFV3Cep/xOAxCTi9Js0QsJSU/D0vqFPr4r6kHPgy8h6kFESf607cDFdEKO77FuCDDqKZRUJFTlN4qkK3EmBCykouSwJgmLNbGfVSRk5hvffZ2vKcuSmKWyLmiNr0OmmRk5BTz46wjZuLi71GcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750014917; c=relaxed/simple;
	bh=AEPHeQ8ow5bQ+OwuQX3dBueDKyaPEcN6FkEiyQXj2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8yVlWa6l/42lv8IRUCSXPbpJnIgGNr8g0NiSBzSbvm8g/MsCWSFLHT+5lmc7QC2Q5t6Q9+dCCcfbnUY8QtwQ0GA4/PNmzPBmJmGeNmQExPV9hjdTx4SwjWFALSBqg9TwOJF0NEL+c/UYm/DhQOMR9OG3Y81pXFFWsvHViNSvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPvkF4yr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so46075895e9.1;
        Sun, 15 Jun 2025 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750014914; x=1750619714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FlPzMKu4igdnQzEXLhlv+B8h95JnIJGKPzIiOmsd940=;
        b=hPvkF4yrhNyMLA8YKoE+dT+YXGsLi12xHWKwozb1RsWMcE4a6YwV6091LyzsukgJTu
         Tga6pVTCUhkfM0FGs7ltGx9Qy6VYVviGtmhHgbSDnGXlDkga3d2SXG8z1LnNiLd7Uxsq
         C0IZI9Fg10nyqyd6ZWL+Rkv+wJ2WjrRdF3UyW8XoRJ4ehXBKxu7U8/+XMpZjOcNJ8F01
         CD32hZKoNbsiInbjFt93eGpkt0+NQLSPK8Oaw0TPVr8uTldhd/bQwlCySja91Chi4Ld3
         foZ0elIwjaLJeTrBjAzxCy4wGgegmRlaXfi5qcXYqYdQHOkNDE08J8PzN6Jxm5L/LnDs
         ldzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750014914; x=1750619714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlPzMKu4igdnQzEXLhlv+B8h95JnIJGKPzIiOmsd940=;
        b=jiyXvUk/IVOdpAVIk3BLYT0c/BHJs70oMo9Djyla5psDxsuGJRXk82xeC8Zpgno53F
         HzQYzOfgUbBF5j0XnoXr1vwyl9r2yOlhrffPkRDpOXgQUFd7oevceNxIAzI+vyW+fnrf
         BPG/Ts2XsLV+98w8BvrM+NrA4Y2n3jmghclPcuhWiu7qsMkTMgVEsKt8vbMZjwMV2lvS
         UjdqMWZMJxLJOomw62KFahSnQVjRE1+9FLd73jkq3Qy5GVGX83sPOeiSTfkWkur9WvRF
         p78wpKJi7JnELMkmrtkvk8wr0k+wucvaEVvlY+pSUJCiThCeHYQ1Mvwt+66IRBvu5BEV
         Qg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgRFpjm4mNxi4h4tGRU2UOAqcZd/ATvV0cYO11v1YnBJtIiChby7Ff9jJx5tENikSmCtj1CYzA1+bn39Xk@vger.kernel.org, AJvYcCV4yAFFOIGTz1gYkro54Jfev6CljEluE5Wk5UrznUDZqeuzWzmI50FoBCTn1gtK9arkkDZPpu2A@vger.kernel.org, AJvYcCWKRvQPyRxfsR6a5zC56WC8tAxQdGed+Kj5afBkJ7xVpvXDZKdqSatvFIUzh5tZ+6fAdykE+ZqqjsA=@vger.kernel.org, AJvYcCWsoHYV4SWdG9wUKTh8hOgm/SU1jzeJ7lfUMGV7tIWwWv/NzZ5YB1fQo3uJTfOPDcLv01TIeeOb9+wyOzTy2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9+0yI63IRiBLmYrDkac/L7l3HTn9WjmtF6G56N7xZRgRoQnT
	2t46+8v0jch+nReO+0m9irJb9xLdC5LB5c/wAvJ6l6t4CDMppEff0U38Cg7imw==
X-Gm-Gg: ASbGnct336u9dM3LxK2UrW25dCjg0N62nt9svJcg59ejLMDa3lnfRFbU/j9NAUbS1AT
	7kbEBy9HyQhgqwYYTnRt5Qqv8eQM6X7+A32EfZRWdiNgfE2e7cSjkXR4xbsyLiS5v92QrhSXF6X
	Jmm1CeeToTOKUUXpOWF21ss7TA9JbliK4oHRUFJbI6B+m6cx+Jn1GCVNaT5BU4yvPUXSGc+/Co+
	ZR98dMs5ZL2bCIrjtl5/Z1DxE105T68GPkTU+BohhxKflMCTCcquJUIuObJDRb6mTW+GZKdlCl5
	0E9Ypyw4qRgLHqEUp05UfohsRov/reOjAZmO6YhfoOMVXq+DBGhjMhcZPw==
X-Google-Smtp-Source: AGHT+IH2bJWppEAVzSL6erEhSao6ZwWSsziOevhXh5q8BLnlA4Nj/np4851kfzIOx/I/qjbdaicjSw==
X-Received: by 2002:a05:600c:8b65:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-4533ca6e6a8mr72032075e9.15.1750014914236;
        Sun, 15 Jun 2025 12:15:14 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:f4f0:900:5194:623a:df1:d4bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13cfbesm118671195e9.22.2025.06.15.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 12:15:12 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:15:07 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Sinan Kaya <Okaya@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: fix handoff FIFO memory leak
 on driver removal
Message-ID: <aE8bu2woUe96DVo-@gmail.com>
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-3-qasdev00@gmail.com>
 <3c6513fe-83b3-4117-8df6-6f8c7eb07303@linaro.org>
 <7649f016-87f1-475d-8ff7-7608b14c5654@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7649f016-87f1-475d-8ff7-7608b14c5654@kernel.org>

On Fri, Jun 06, 2025 at 09:35:44AM -0400, Sinan Kaya wrote:
> 
> On 6/5/2025 9:04 AM, Eugen Hristev wrote:
> > > diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
> > > index fee448499777..0c2bae46746c 100644
> > > --- a/drivers/dma/qcom/hidma_ll.c
> > > +++ b/drivers/dma/qcom/hidma_ll.c
> > > @@ -816,6 +816,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
> > >   	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
> > >   	tasklet_kill(&lldev->task);
> > > +	kfifo_free(&lldev->handoff_fifo);
> > >   	memset(lldev->trepool, 0, required_bytes);
> > >   	lldev->trepool = NULL;
> > >   	atomic_set(&lldev->pending_tre_count, 0);
> > Is it possible that the handoff_fifo is freed, then we could observe
> > reset complete interrupts before they are being cleared in
> > hidma_ll_uninit later on, which would lead to the following call chain
> > 
> >   hidma_ll_inthandler - hidma_ll_int_handler_internal -
> > hidma_handle_tre_completion - hidma_post_completed -
> > tasklet_schedule(&lldev->task); - hidma_ll_tre_complete - kfifo_out
> 
> According to the documentation, the way to guarantee this from not happening
> 
> is to call tasklet_disable() to ensure that tasklet completes execution.
> Only after that
> 
> data structures used by the tasklet can be freed.
> 
> I think proper order is:
> 
> 1. tasklet_disable
> 
> 2. tasklet_kill
> 
> 3. kfifo_free

Hi Sinan, hi Eugen,

Thanks for reviewing the patch and for pointing out the correct
shutdown ordering.

If you’re both happy with it, I’ll send a v2 that calls
tasklet_disable() before tasklet_kill(), then frees the handoff_fifo.

Just let me know and I’ll resend.

Thanks
Qasim
> 
> 
> 

