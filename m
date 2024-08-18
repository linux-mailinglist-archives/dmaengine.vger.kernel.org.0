Return-Path: <dmaengine+bounces-2892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C9955CA3
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB71C20C19
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1191C6B8;
	Sun, 18 Aug 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMqg/9uM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C817C9B;
	Sun, 18 Aug 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723986222; cv=none; b=J/slJFPez/Ct+7DGxva636cOhi5Al/eBTDJsOw1SnmnYLH3h486VcDsIyRxRHCau9zgUkhKS3d18ASUvYJNRUXPBvFQSOAzcubKk9JjSSZNwRAMkC7MfTs5MkcqmBP7l85pO/AcV8vWhi1NNT7DkPF4TgSaTHMY41vZ240lKzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723986222; c=relaxed/simple;
	bh=ZvaCRg39vE4Ee6Mny1uj8pWX2qzsse27jru5bmzX+DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvUV01s1SBL99uVFrkLn38cww08F+3simM9Os89TbOYAdWEzxHtqz/m3wJIN3uIJHp1IRDb8LkXhjuVvzF++fD4ZABDuC8iwiqMswuxFGcOtoniolSrFug3iL9TyzSxJqVWrgmtqXy7XA8fkvyhNwHzolm5ZbCF6U0DcQ1FQct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMqg/9uM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-68518bc1407so37280237b3.2;
        Sun, 18 Aug 2024 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723986220; x=1724591020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKuzpVJiFk4xBooodI4VeM4vceNm39MbpknJ/YPFpFY=;
        b=gMqg/9uM4K+s1tCdysxeonKsdrPy761KN8pH81GcQm5krE90bjXzposYKE7T6N/9S/
         4he1W1zVwH+QVky/gY4AtSlKlxQEX4kwo9RP6CoOnvK08xUrFiGSrsRWIqDb+cD4z0cm
         VYkX1N+sO+CdqozTB9HlYmtfTQEbNrTRymCvzO1iJu2aYrj6ggJ7T2u0Mf/D2hoedUWG
         DoBO5VX0Aw3Hu69iyP5BaVOwqxenymXnmI/EcKTubqftybPbxEnSiXTJvrG7qf180Wq0
         4j8DA9T1mhAVW9C0HkESRok2TSVcatmcq3UE5XpI39NYGOdEI71PMfJid/rdo3/Luxc4
         AGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723986220; x=1724591020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKuzpVJiFk4xBooodI4VeM4vceNm39MbpknJ/YPFpFY=;
        b=MtcDl5eWPtqFXtEV9T8Cjdy24bjJpLK3716GEXYnPepsReJDQWdwhtjYKkzFtwWXk4
         7NXWfpqfcga++UFzXbbIu6Q2OfuEweHUjQk0qTyJGyK3V5uLdJ74Rois9bWZaHJx2JWt
         aZhp82SDVPKRG5yGilu6YLFhYjhLFX/Cfya0Xnn4CwFZGY0PMLRYJHeQ8tOivmjQvJJe
         NNoFossmH9OW9BVZGc6+zgP/bxAMMKvkoJmqKNqVSVHHZEEKL0D9ImcPoJ27OPO3BTw4
         WhxYkggn6k21YJHQvIZX7W4YSwCxOwFtJhi8V2QQDHrd/ChovfoTyixeAdJ+7GY74SU9
         viqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmyoCy24BCulNFVdHtIrABx9cN6SYv6kYoEjAy86ovl/ptVTthJNndJaYkmzXOkD/rnVEO+9xoSv8tNzfLgue6Y71Fi42eBWdFf02aPMgkkndT7C3ujTlJs2yDOCKvdg0agDWZ
X-Gm-Message-State: AOJu0YzGw8s7VU+Itj/ziTUTLompM1N1cIIAnx3iLIogCtJH/vmgvdQY
	fvvYlaBaXe3ml7A7Kr68PkVXp4fvC9cEi8hs7S8BJKDipVbjzrL4pN8LCSPZ6jI44Fm3wlwqYsB
	P/QuPmIfBxhD5RHEnk7l+ypatHpo=
X-Google-Smtp-Source: AGHT+IH8ByidZiVyqGayXnG01vIkC8Qa5DOMAddBzWu4pAWk93IAJpzRz6iDuHjToX+hWztAEDdvZT0ZSY3TyVk5BxA=
X-Received: by 2002:a05:690c:690f:b0:6b1:2825:a3cf with SMTP id
 00721157ae682-6b1ba5f78dcmr98563177b3.10.1723986220186; Sun, 18 Aug 2024
 06:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818071757.798601-1-make24@iscas.ac.cn>
In-Reply-To: <20240818071757.798601-1-make24@iscas.ac.cn>
From: lock hey lee <lee.lockhey@gmail.com>
Date: Sun, 18 Aug 2024 21:03:27 +0800
Message-ID: <CAL7siYN5gUgv6kG72paLeoeqh2pic6ZySGf_r90oK_2UyPKjiA@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: moxart: handle irq_of_parse_and_map() errors
To: Ma Ke <make24@iscas.ac.cn>
Cc: dmaengine@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ma Ke,

On 2024/8/18 15:17:57 +0800, Ma Ke wrote:
>Zero and negative number is not a valid IRQ for in-kernel code and the
>irq_of_parse_and_map() function returns zero on error.  So this check for
>valid IRQs should only accept values > 0.
>
>Cc: stable@vger.kernel.org
>Fixes: 2d9e31b9412c ("dmaengine: moxart: remove NO_IRQ")
>Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>---
>Changes in v3:
>- added missed changelog v2.
>Changes in v2:
>- added Cc stable line;
>- added Fixes line.
>---
>  drivers/dma/moxart-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
>index 66dc6d31b603..16dd3c5aba4d 100644
>--- a/drivers/dma/moxart-dma.c
>+++ b/drivers/dma/moxart-dma.c
>@@ -568,7 +568,7 @@ static int moxart_probe(struct platform_device *pdev)
>               return -ENOMEM;
>
>       irq =3D irq_of_parse_and_map(node, 0);
>-      if (!irq) {
>+      if (irq <=3D 0) {

The =E2=80=99irq=E2=80=98 variable type here is =E2=80=98unsigned int, whic=
h will never be negative, :-)

>
>               dev_err(dev, "no IRQ resource\n");
>               return -EINVAL;
>       }
>--
>2.25.1
>
>

Thanks,
Luoxi

