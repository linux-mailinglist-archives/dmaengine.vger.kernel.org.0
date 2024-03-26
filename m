Return-Path: <dmaengine+bounces-1505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E888BFB9
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0E91F3EDE0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BC23B1;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn+Q1loE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB864A24
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449471; cv=none; b=qBkyy89EdagtAqEVUaJietIsoehcDY0Iq9ADXZdKz83ZBvCKgKKdqUDre+zmATB2CbL1HohxT4lAWpr2PQis27QJscmmn1m4ZmrNgeVvcfvU27bfEEMPUTlu1f6+YBIewyHrrTRH90DlBt1mFHVykbE6tXscjg2YV7sfvfMi48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449471; c=relaxed/simple;
	bh=PZVb7zjh3JdVqIH/S+UoQcM1URH263b3kRIUQSdkCGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJQNF+rhUmgIp4n0AkoWvToecHuQ8IElfnkVkFswRbana1bl0YRjZGlLYRLHJrsHoRxwg79b9qrVdvouXFt3tZmy5Y3JLZbSKoTfvShUDIsi/YK5dNqhBnUKb4vdRgj1IOcZ73c7h66btAcZnv+9HbdvJtTWA9deWbmlA5qV3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn+Q1loE; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d8804a553dso902442e0c.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711449469; x=1712054269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Uqf9CIhYOeBiLLa1TqVmY6QTgOmZY56sFewHKxn8bQ=;
        b=Zn+Q1loE4OQXGjeuWjVAS5OrMHIIB8N1+41bxNf5a9ifzu91BA5CeBhL4CJTTeokCg
         AzSDerghGRu/EgBsaowfmbpBBNY4OPEaGYccpla39TPvcIxBHbqD77ppzWB1zEmUxxI4
         oFv203CNe6Hvcxl+4DBvOs3kSu57qEh/CaOHE36xB+XRGuSVJgeSmQ/+GNJq8Eyy885e
         6mpz0gq7+Dq31eu/NnH13Bv7/9G8dkyjcBy8Itx8eLKzTyLVrDTrDxqhuKsxD9PE2AdQ
         XTCcWeCeAZ9xAhhAwkaqH/3IFh59c7Mo3uYjH0PXcVR/XT/8vsEg45B6gbqXJ2Wa3eAD
         1rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449469; x=1712054269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Uqf9CIhYOeBiLLa1TqVmY6QTgOmZY56sFewHKxn8bQ=;
        b=WhYBUu6pKau8ZAQqhWtZ9wVsZE8jWPB/iZG/gFz6vnUMypTaxG019cONeXlhec+mOl
         A3qqOxWaNYaMK4vkSIp8YpoA8Chv3wsNZiTzfDvD91EhC3KBcXd81j0KeprnPH+Gu6Lf
         RuWnD2qr8d/ZT9AkejvgKk01kVV9XSWePeDZufwjgGNourpxAZutQPAwlB/UdtYpE6rp
         9LqelgEugjWawasQK+cd1ZpPBYIX1W98HOt0VT/3xFw0ILXjJ99otJyv9Wc/JkXs6LON
         WUC/ANEHnuKQJfjAkN0UJ6kPhVSo3djgLPlFlLDRZnyY1zHN7NChhroF1cQj/ZyAF/bX
         D7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV7tSW2UQaMFJvYKgyIoR9ddgAZeDouEBbHt1XcZzt64l6xEY+iJN3lGt9cKq5q2rgbm002VpZkteRW6x2G/u6nVOmVH+lXPYYN
X-Gm-Message-State: AOJu0YyRoIMropkwItMiaNuVOrHsx3ZvZaI7Vz0BL7DfR0hw7ugAWKNZ
	I8BGt9ZSYJvkw28LyKgbjjACPnHV+hXZXBk62mK/ECd0ESKWNeaZ
X-Google-Smtp-Source: AGHT+IHpZBdLuvYhpeAQOSG2+sUs5jwYOGuNWmwQ3fxXKtVjeNvj8GQgVUu98sdqbHM4UzgVoVgVFA==
X-Received: by 2002:a05:6122:32c7:b0:4d3:398f:8633 with SMTP id ck7-20020a05612232c700b004d3398f8633mr7688893vkb.10.1711449469062;
        Tue, 26 Mar 2024 03:37:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0069687cdaba3sm2651872qvw.36.2024.03.26.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:37:38 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:37:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer
Message-ID: <7g4plcoqnjjyc3snjq4dtpdw6cn72np2ortwcnad2mitzmknaq@bukqv3xznk56>
References: <20240326085256.12639-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326085256.12639-1-manivannan.sadhasivam@linaro.org>

On Tue, Mar 26, 2024 at 02:22:56PM +0530, Manivannan Sadhasivam wrote:
> Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
> And there is no indication from him expressing willingless to
> continue contributing to the driver.
> 
> So let's drop him from the MAINTAINERS entry.

Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..9038abd8411e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6067,7 +6067,6 @@ F:	drivers/mtd/nand/raw/denali*
>  
>  DESIGNWARE EDMA CORE IP DRIVER
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> -R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  R:	Serge Semin <fancer.lancer@gmail.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
> -- 
> 2.25.1
> 

