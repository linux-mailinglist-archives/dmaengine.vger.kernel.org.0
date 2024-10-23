Return-Path: <dmaengine+bounces-3444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518D9ACE40
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 17:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D2AB2A3D3
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5F1CF5C7;
	Wed, 23 Oct 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW9uF7V8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6C1CF286;
	Wed, 23 Oct 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695902; cv=none; b=bbsVxNWxVeuI4nUIejsaHY25ZorvJ5+jl+sRMmP5l/YnkAh2IHEPuq/WFAqiqWNHrwN2GV1KjENSiEfab5ioa8nl+oDq/GGi+uBbUNsuRrMN2RSEbX4oIqWy96qCTMpTbLP/bHcXEXW18In8ooOnYmcTZqNnbuziKLV2V7MXsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695902; c=relaxed/simple;
	bh=zwm0YdUlkRPFpLJprNcgJfyNzN4ksSJVM/GonbtuotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4nKH951SOgw2LxHV9nUZLe/y3fCjeGQb30eAyo+Y6hN7tma6l5zj/M0CXIRtXZw+GgcLTXjUT3sLwKQPMxTpnQ11mno6WXeT9/7m25Oy3Hfl0T11WZhIG/9L2HdyIz6pTwwQ1RwHzFIKwv4/gH0+nyMjjY3DZHi0KiC/+nzwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW9uF7V8; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebbfcab9f4so2041685eaf.2;
        Wed, 23 Oct 2024 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729695899; x=1730300699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tuzyAe8JQhERe3dQ6ji28tLfp5niGHH7P19VuAauSs=;
        b=WW9uF7V8tmXesaCGZnesnoi8sJxpCYv8w7Rs+nL+0kh6VN5IrpuWKgDLeK51Swisex
         P9DKU7ybKTwQ09+N7GQlaLzTMxxCnXmBh0Sz2KgoiQ0Uk7//DFNETZ344ojsxdJUW1B3
         yMx1xSQTP5pLLaFX3WzFESE5OSUpLvmtNW4kBw+NmbIWWmGLXiY8kPbA0nqrba9WhZtg
         gIBbsEbGnbrW4mdrb0fZWzjILcJbqR9doLDatJoWf7iKlj7SoSkkHAGCih/NrBqFycvT
         jXgqMVU8Yrll9xzhigueU9n3hKEJ6G8nP2RjhXPkSaEaSxqeap1+Y5k+K3Tb8ykFFuDU
         jUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695899; x=1730300699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tuzyAe8JQhERe3dQ6ji28tLfp5niGHH7P19VuAauSs=;
        b=oqvLKG+vZUOcmTSO6ROEogwrYNBJHZ5vS8f/9jYNAxXGrkEI8g6ktBZJ5e4spYZSSV
         vfqe4SmOVzkm+SF4n/VUAPOflBkFwS4fo6oLgyLFSUyZLDsczYKArXI40yIBWZZRcfyh
         DMf/LBBuWX2IMdq7YooaH15d4KzzA0g3qjMgrK2V+tONfKzj+QFktrKZ/cEcTg8OCbxX
         jS0kB92QMT9G97v4OPDmx9pdHGnNirvu+o1aPcxCAHS3jwus83BZcAS2CsCjVZcuDawc
         H3IYKH0cOw7yiL8huNNQlxXvCdOx56GQdYM6ZGl/oVWl38ewfq+Ab/jE6KSyYPUKVpVY
         pl0A==
X-Forwarded-Encrypted: i=1; AJvYcCU3x7oKjlrcKFjlyrNE1aXvVo4GArJW+5gaeDKWtG7V3cIXzoMEpp0HnFTyLE3/z1mYThf0n0zfy4W/95A8DCva/5c=@vger.kernel.org, AJvYcCU8vQKboALyPkskm2GDSb01J1psM8WyASfn4EzWhDpfZypsNFgw3UFBMblZ27ADvujpFIKfn92Fgb/0aQ==@vger.kernel.org, AJvYcCUDK+6AkgaDbeRT9mtDeU3gtnqvfMOEYH3XxYtNevqns1Gdji3yqkM2SLCSk6/p+6MyVna4pbXO@vger.kernel.org, AJvYcCUDfgZwTJsVuxbPEu4gX1z/O2uhWRVYKHnoIlIvyi1yOUqW53jvQc2euSEwPxVtJDGJI71BoZFijZhnV2Q=@vger.kernel.org, AJvYcCUEE4/soKyMGv/IF4TszPMBbP5Vd0qqotohWn+595wgIaQzGRFFOrTx+1HtOUtvlxfm+jB2bFL/Z9fP@vger.kernel.org, AJvYcCUfMnfTypX5M9n3/gVEyTNOeMFdlXw7IfMSlF/JiMqtpthpUAnRvxVX1YZ/myezMYqR9abtKa5GknHQ7gY=@vger.kernel.org, AJvYcCVXRHfOabrIemErhB6K8fzyrd/NqoA+7JR0LrrlTN8JBsLUISBi53i3Hwrfo5UzVZjUklqLzpoNFAc=@vger.kernel.org, AJvYcCVcGu4lIuNPT1/b2yN0WCslhl2Vw4OeHiObsagZMxVVBtwBv+LTeBjhq26UUIsUTC0a3rm7APyPnf61h9o=@vger.kernel.org, AJvYcCVu35EKlp7t1qt9Jg6wee1ld0bsYYO+uKKreS7bl87S8bBM++3eNLQxCi7K5XUGN8sL/ZaHyz5lEQurtg==@vger.kernel.org, AJvYcCWMsq0QDUEPml/6lpFk
 fZNfhcGPXvuTmoMF+KdGS9zclsML5Vz6SwKOboYRjyHCPVxnQvwGBbe0J7Af8g==@vger.kernel.org, AJvYcCWY2GnqWstdNQRz9d4XWc0/xDewkHEa7K5f2h1uUHV1D4FrWha5Xz4js9H9bFw+2inwrcMQN88WrmBZ@vger.kernel.org, AJvYcCWuyWuk73ol2+eNM28lWk88ailytiSZKRVJBwWdnr/IgSevo+DJElh3P+VSqy7S8oeab/TRFWEMdL/j@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSuq5m82TioeBpLIbH4EU7QldioEUdBwoi8kTSbY2mutnhVgs
	H7dtkkc9DtRIC6voGWO85uTRuWlzHVyTbqBvQXnqNW1TcZ9xCJRhophqWcZzvUZMmMeQQBkLZVD
	EiQlUeaM3la3rjbHmey2w/fhch20=
X-Google-Smtp-Source: AGHT+IELnyS+e/TN/dMdHzvAA3dedAZFpyyaBekY76IOdFg+Te4WZUxhJCCdMsqShzs8WjVE+pUlBhArE6QTMefHWi4=
X-Received: by 2002:a05:6820:1c9a:b0:5e5:7086:ebe8 with SMTP id
 006d021491bc7-5ebee308838mr2092425eaf.0.1729695899332; Wed, 23 Oct 2024
 08:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
In-Reply-To: <20241023080935.2945-2-kexybiscuit@aosc.io>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Wed, 23 Oct 2024 17:04:47 +0200
Message-ID: <CAMhs-H_2tnpeynm2m9KNGL1GVU9m+odSnTk6F-WKLruMfEjXUg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: jeffbai@aosc.io, gregkh@linuxfoundation.org, wangyuli@uniontech.com, 
	torvalds@linux-foundation.org, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:20=E2=80=AFAM Kexy Biscuit <kexybiscuit@aosc.io>=
 wrote:
>
> This reverts commit 6e90b675cf942e50c70e8394dfb5862975c3b3b2.
>
> An absolutely no-one-ever-reviewed patch, not even by the maintainers who
> got removed themselves - at least not on the mailing list. Then the patch
> just got slipped into an unrelated subsystem pull request, and got pulled
> by Torvalds with not even a comment.
>
> What about the next time? Who next would be removed from the MAINTAINERS
> file, the kernel.org infrastructure? What if the compliance requires
> another XZ backdoor to be developed without further explanation? Is the
> kernel development process still done in public?
>
> Are the "compliance requirements" documented on docs.kernel.org? Who are
> responsible for them? Are all that are responsible employees of
> The Linux Foundation, which is regulated by the U.S. legislature?
>
> Fixes: 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various com=
pliance requirements.")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---

Unbelievable...

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

