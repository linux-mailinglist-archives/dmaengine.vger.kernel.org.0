Return-Path: <dmaengine+bounces-3869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6D9E1C41
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05211667B2
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691291E5005;
	Tue,  3 Dec 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpQ6Fxna"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0204F218
	for <dmaengine@vger.kernel.org>; Tue,  3 Dec 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229361; cv=none; b=qhuLgrRCUeeqIKrsO3BoCjhxYYASEae1RlDg3bu0Xp5/gAIR/q+KxtO8TxyWF60sSwytFm7dZT0Bt3SLzgNV9Rv7eG+A401pSdIINn/royR/4SNSFmJ5b9n/tSKX0JHe++kY7Dj+ys42/Mkg2tgrmPmmFa22m3JKoAFEqIAPx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229361; c=relaxed/simple;
	bh=3oUVtZF8kZIzVMvN08YgBEGeO3a7ESEXo5LZmlblAog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud5SYTW6OIfZrzQuMQ0Zv3syfqWpUmxqd8UUuS+2aF+l3sPHSqIgKUcokMQuZdCPFVYaoI/+vF9Evi7eAj+yrVPwIrgeeG1fwrxtxHVQ/kDvuaV5G96K3Q7Vyrv52oysnu4bjVB27zIZGNZOE4QRu93ArMKzWZa2CjLP+PSxueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpQ6Fxna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733229358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/jA4+syt73xHRzh3CLLPIf2LQnHDc6Mp3Wfo7HZ894=;
	b=OpQ6Fxnagnm9UA6D0OYO/9VW3SSnWvNHrC0jJerm7Ey6/NVRnoSkG5goWhS2jG0X7JJb+n
	WfHLri5w+6MAyAdbIrCQvCrZgERIp2O3mexI2tTeLACQL2EHa4ycBTCjxERjTOMb7wXnYr
	8YZvwFmUGIxx9BC1GZRWDz3uMZlNk7M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-_QB0MqSjMH2Ovm9iFOx12A-1; Tue, 03 Dec 2024 07:35:57 -0500
X-MC-Unique: _QB0MqSjMH2Ovm9iFOx12A-1
X-Mimecast-MFC-AGG-ID: _QB0MqSjMH2Ovm9iFOx12A
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ec1c46df37so621849eaf.3
        for <dmaengine@vger.kernel.org>; Tue, 03 Dec 2024 04:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229356; x=1733834156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/jA4+syt73xHRzh3CLLPIf2LQnHDc6Mp3Wfo7HZ894=;
        b=uQogbkVrZqDQNvY6pM/Ph8IR57Scj6T0zhcw812GfQztwT6nejqzPiwlwm/fTIxFMG
         iVVC9Ki8kHXdEEW14lm4Vx9Iaw1nQxo1sq1fDvdq4C+iCzPe7L5AAnfDCxdpqxj2H/ca
         T4+BvAAJhu/pJiWQmCK29rJ+8UVTu2OQ7XtIkFbzk9XaeRoZw4ZgefxuQq/TQweLTY/T
         LHT7IoyqDSjDj9AtHBB5seImX32z8QpxpW9y/0huYGBHCy2A/Byo8a+m/xnvFD7P3L1G
         bqQD7qKWlfRDX1Jh7ThBWNwwKXd+41swoT1vHgglMAg9cvveRolMeOF/+vM2bn8FhK9o
         gRJg==
X-Forwarded-Encrypted: i=1; AJvYcCUPvbE0QLxxlNKa3v52tGfayDubez8mQxxu4Jz34/hLwJ21EdRNQJG0+uKpFiL2oQLWxG33IBvvUm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG76dJHUGKLPNkWxU2PHGplQIUPAko6JFvNWPCcygUg2W0gk5X
	f0Di0/tz6rVhFxDCvdKyiSNOGQVnyWqxlUJrJQyQbx1wwZFy5j2lRNaMz/sqZoZKR+iWTYuDAl7
	KNdbCDoCpR3+71CDJjuOCVBtPKQ8CqYIgkSDDIdNBdxU7j3zQ0XcXcB6vtSoBsZaw3lLclnsfvy
	//Yjk2KPbHTVfZ7jr5BN9Mb4qV7kMQ0/UG
X-Gm-Gg: ASbGncu4VsVUClOrSHkFhxazCy556Kbgo0cQIQWjQe7F9Xi1EqijKekzrmSA4SliwFK
	iymvpf+CrtudLBAS4/vhaDRDg0OtNOLdN
X-Received: by 2002:a05:6830:3c87:b0:71a:20da:f85f with SMTP id 46e09a7af769-71dad717461mr580410a34.7.1733229356362;
        Tue, 03 Dec 2024 04:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzevS3kCzYIexPOiCGrpWFJcklXeddetaq+wX1lpF3svUb/DPOth1TMgPRMkwfxsBqPiCmaSW4NFvRKKtkrK4=
X-Received: by 2002:a05:6830:3c87:b0:71a:20da:f85f with SMTP id
 46e09a7af769-71dad717461mr580399a34.7.1733229356086; Tue, 03 Dec 2024
 04:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
 <4dd1caa7-4b95-4e06-a5ac-e2d33ce88d04@arm.com> <ffccf100-469f-4e5b-a32c-5c06e196aacd@ti.com>
In-Reply-To: <ffccf100-469f-4e5b-a32c-5c06e196aacd@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 3 Dec 2024 13:35:44 +0100
Message-ID: <CALE0LRt9W41Gr0dvDXpt3fV-=jMvrD1X6e4bS9+EMy8J-Qv14w@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dma_request_chan_by_mask() defer probing unconditionally
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	u-kumar1@ti.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 3, 2024 at 5:35=E2=80=AFAM Vignesh Raghavendra <vigneshr@ti.com=
> wrote:
>
> Hi Enric,
>
> On 29/11/24 22:14, Robin Murphy wrote:
> > On 2024-11-27 8:23 am, Enric Balletbo i Serra wrote:
> >> Having no DMA devices registered is not a guarantee that the device
> >> doesn't exist, it could be that is not registered yet, so return
> >> EPROBE_DEFER unconditionally so the caller can wait for the required
> >> DMA device registered.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> >> ---
> >> This patch fixes the following error on TI AM69-SK
> >>
> >> [    2.854501] cadence-qspi 47040000.spi: error -ENODEV: No Rx DMA
> >> available
> >>
> >> The DMA device is probed after cadence-qspi driver, so deferring it
> >> solves the problem.
> >
> > Conversely, though, it does carry some risk that if there really is no
> > DMA device/driver, other callers (e.g. spi-ti-qspi) may now get stuck
> > deferring forever where the -ENODEV would have let them proceed with a
> > fallback to non-DMA operation. driver_deferred_probe_check_state() is
> > typically a good tool for these situations, but I guess it's a bit
> > tricky in a context where we don't actually have the dependent device t=
o
> > hand :/
>
>
> +1. There is no explicit dependency that can be modeled (via DT or
> otherwise) for memcpy DMA channels. And the IP (cadence-qspi) is not
> specific to TI platforms. Its very much possible that a non TI platform
> may not have memcpy DMA channel at all. Wont this end up breaking such
> platforms wrt using SPI flash using CPU bound IO?
>

To be honest, I didn't take into account this, so yes, this patch will
break such platforms. But isn't it already broken in such cases? If I
understand correctly, if there are no dma devices at all, we're
already deferring the probe [1].

        if (list_empty(&dma_device_list))
             chan =3D ERR_PTR(-EPROBE_DEFER);

[1] https://elixir.bootlin.com/linux/v6.13-rc1/source/drivers/dma/dmaengine=
.c#L892

Thanks,
   Enric

> >
> > Thanks,
> > Robin.
> >
> >> ---
> >>   drivers/dma/dmaengine.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> >> index
> >> c1357d7f3dc6ca7899c4d68a039567e73b0f089d..57f07b477a5d9ad8f2656584b8c0=
d6dffb2ab469 100644
> >> --- a/drivers/dma/dmaengine.c
> >> +++ b/drivers/dma/dmaengine.c
> >> @@ -889,10 +889,10 @@ struct dma_chan *dma_request_chan_by_mask(const
> >> dma_cap_mask_t *mask)
> >>       chan =3D __dma_request_channel(mask, NULL, NULL, NULL);
> >>       if (!chan) {
> >>           mutex_lock(&dma_list_mutex);
> >> -        if (list_empty(&dma_device_list))
> >> -            chan =3D ERR_PTR(-EPROBE_DEFER);
> >> -        else
> >> -            chan =3D ERR_PTR(-ENODEV);
> >> +        /* If the required DMA device is not registered yet,
> >> +         * return EPROBE_DEFER
> >> +         */
> >> +        chan =3D ERR_PTR(-EPROBE_DEFER);
> >>           mutex_unlock(&dma_list_mutex);
> >>       }
> >>
> >> ---
> >> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
> >> change-id: 20241127-defer-dma-request-chan-4f26c62c8691
> >>
> >> Best regards,
> >
>
> --
> Regards
> Vignesh
> https://ti.com/opensource
>


