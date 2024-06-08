Return-Path: <dmaengine+bounces-2318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 485759011FB
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88F21F217DE
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA3179647;
	Sat,  8 Jun 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOjx4GtE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AB27457
	for <dmaengine@vger.kernel.org>; Sat,  8 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856557; cv=none; b=nBd9NBlvM7Pf+ESmKgdq2eo+AT0FgRyFv3yEsqk1FepxjvnCeYTGRKpYUZREjXzb7xvjTTOk2oLq+283t3Nuy2GmB6OmOv6Zsu+doQJJILfNXLyhkMl7f9FL8QCAXgCanmYBIpI4My3QWHR7mqpbhQmtb+Eappb9gQrVIcEMmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856557; c=relaxed/simple;
	bh=RSSH+YhJSm227YbuJs6YQCoN7W4xOz8yJZaPSOUZSEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JXp0h/EOjg2MRQaqKhQkwFXe6eTCKcftx0cJhxw+xBVEpWRJOmSqa3ehHVAD1mhL8EhbbSQXgTI+Zzxt4uRR7qyQ3Kg2BwaQ1uqYp1JJl31uM5iVycMz1L7JmsiG8R5+39aX1OCPAqcuG0nORojMiFvDQWuGTD8Wq45TB+9x65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOjx4GtE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421792aa955so7483655e9.1
        for <dmaengine@vger.kernel.org>; Sat, 08 Jun 2024 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856554; x=1718461354; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kINEbRVv4zaJy/qjvFx+VwKp+LV0DZXAa+ALLU4d41o=;
        b=EOjx4GtEr8hyDhF7obfhn+cvv6FX3HOzO/W9HR/dI0toC3Ovspjage5uyMcZnCZ+90
         N2HhC2CSVUMyz62UOTA7I/2T9wGu3v4eIBgNQHS8V9ueUo/oskIrDFg+rR1wlusJQWJ1
         fBKPohq2S3367YdvyRDAZvU7YdSeDPoZFNUFKlnz9LZe7cAd7zz5OU3gDFfo5YU2VKzf
         QkChkLF1RJEhGkeA9eVbk/uLjfMokyy2IInV65eL1FtVsmJVkZLmiZOR3XeSOBnLeMvO
         sh9b3lgGb2HIdls5cscoyNXcAdyJhKuMCkWbAnCu/z+TknqcRxGKjO8wiVrS+4Bu/EQv
         4saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856554; x=1718461354;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kINEbRVv4zaJy/qjvFx+VwKp+LV0DZXAa+ALLU4d41o=;
        b=g0y6RQrWOeo3voUCyslLVWeKZGZ+e0XjEg92nzTwBwsx0a2nfvSBAzPu+05Y1NbvK7
         sSRLhhskSMy9wcgv9ZlQYQicgVqNjkT3Ddvf8IlH46ANGZfVJVzhLuChZMv+fX22Lk02
         buvFlckCzEiRy5zGl/tfNB/NiblysidbFezXEoPUakstI2EoUVPC/Z8EqB2tU2+yoHKl
         7VzuBJ+9MF1Wrxt4j063txq7Ur8pOeOsOIvq5NpU+jxRo3Px2aZDj+Jpljy3Tbl198tf
         w/R4eQlUwu16lHXlthh80Imlaakzqhl4RXS6ztpUDp7EGfVMyMv4zUyepxzksGE5RX+x
         k1lA==
X-Gm-Message-State: AOJu0YzlJo+8plPwu/cI2OxVJFHVMPqrmfYSepdfn1wClnvI9K+C8a7M
	0wGD2UiblnZaNa4SZypCq1NkTZusck1uNdWhjrjhfh27oKg9Ul6YSJ6paQlJLX0=
X-Google-Smtp-Source: AGHT+IFbWUh/nE+DXtjyL3Qmz0NjYYhk4y/ud7hRmzwxQb65z7ganJ1GL4aXW/gD4wTDGjw6mm3IsQ==
X-Received: by 2002:a05:600c:3149:b0:41b:aa11:29b3 with SMTP id 5b1f17b1804b1-42164a3710emr40887825e9.35.1717856554311;
        Sat, 08 Jun 2024 07:22:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe37csm120878865e9.3.2024.06.08.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:22:33 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:22:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: owl: Add Slave and Cyclic mode support for
 Actions Semi Owl S900 SoC
Message-ID: <c3dba2df-999c-4ce6-b3f5-d7f75a843efe@moroto.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Manivannan Sadhasivam,

Commit d64e1b3f5cce ("dmaengine: owl: Add Slave and Cyclic mode
support for Actions Semi Owl S900 SoC") from Sep 29, 2018
(linux-next), leads to the following Smatch static checker warning:

	drivers/dma/owl-dma.c:764 owl_dma_resume()
	error: we previously assumed 'vchan->pchan' could be null (see line 757)

drivers/dma/owl-dma.c
    752 static int owl_dma_resume(struct dma_chan *chan)
    753 {
    754         struct owl_dma_vchan *vchan = to_owl_vchan(chan);
    755         unsigned long flags;
    756 
    757         if (!vchan->pchan && !vchan->txd)

Presumably this should be || instead of &&?

    758                 return 0;
    759 
    760         dev_dbg(chan2dev(chan), "vchan %p: resume\n", &vchan->vc);
    761 
    762         spin_lock_irqsave(&vchan->vc.lock, flags);
    763 
--> 764         owl_dma_resume_pchan(vchan->pchan);
                                     ^^^^^^^^^^^^
If only ->pchan is NULL then it will crash here.

    765 
    766         spin_unlock_irqrestore(&vchan->vc.lock, flags);
    767 
    768         return 0;
    769 }

regards,
dan carpenter

