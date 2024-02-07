Return-Path: <dmaengine+bounces-976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EF84CF32
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246C6B20FE6
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD68062A;
	Wed,  7 Feb 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="KKJB/fpK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139B7C6C1
	for <dmaengine@vger.kernel.org>; Wed,  7 Feb 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324269; cv=none; b=sS5OKKSdaaLiUP1iV3Tv6NMwrKM5Rh1KGep4/6Oq6snBJg5wkuT8qAYc/fa7+XTl+oVfwo5W/LKB2iqTN0Kadcx/xrurZ/sBQDnO5r7zv2gTenRud+K8rEUjm7edyYawYoI851xV+RLl89Gz4u52ODgcyA2d7uwloe3T2o+Od78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324269; c=relaxed/simple;
	bh=pHvxWlHT5tbBvvgdrmFaft0ZfQlTbXtLALbmsWeUDYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkdJqLrEMtsKynAWst10KkK1b6BasxQgze61THLCR/W5j4rXNFya7Gs2pFHyV6qv4kVGHH2Lfba2ntCNdJjHVyjuvfg5wfk+2H8pi7yidmuVXd7uF30fgXiBzZDWzHmHSRjnC7Qdeqi9asH73SzY0JZFTaOZBOpexJfSD2dJRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=KKJB/fpK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51124e08565so1277905e87.3
        for <dmaengine@vger.kernel.org>; Wed, 07 Feb 2024 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1707324266; x=1707929066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHvxWlHT5tbBvvgdrmFaft0ZfQlTbXtLALbmsWeUDYs=;
        b=KKJB/fpK4YNuWIvz+yI/ZL2NNJNApb+BS81/46PY4BLcuL8o5NbsktX71PLQBNyK1h
         NTb6ad9Hx7GgyjCTqz/FBT34asLpODd75K621ULk10+ToaXRBOuEbTTT3rkc2Y7Ks8Uh
         GBZwS6XhNeYXfSjBL4MDuk8UvFSITvBy1tD9++BuX7X/ZWg6/hRa0nZTXW2NP0Dv98T1
         EsOlM4v5edGlV5EUtE/fu+yL31d3ABoByriWiOyOJcpCs0yWEWh3ZkTttH9/1Bx59J6A
         6orr1j1/msr2Mh/0RXJ349reCQ6LWJoU5g9yQItzK/YFyLWNINkL4SAToiOLrMoN3hiL
         DvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324266; x=1707929066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHvxWlHT5tbBvvgdrmFaft0ZfQlTbXtLALbmsWeUDYs=;
        b=WiZVWsohwDGMPBSgkCwUGuWycew4xHwwhe66MwbCtJWWBtdgDk+1o9dFGeS36zIXz1
         n/dZfJoEUB9HdsSp0AukFxQHQ8E+wytCzqOT4YA7zCGcgeh3uKBbddm0feYi8slo+dZW
         7zjkX2jeMPdYcOvp660/zIVL/71AeQXKOJIppiMFj9OYKKYMgfYoReTvoxs8+ydKK1G4
         2yMSHmjilQ83/NcElJYFIbcSadRzZQELMamuwpaOSMir425QfeajPbbVeTcZhPwjHRKh
         UzMM7+L3s2rvwm2zLK9HfcgZi7/TQdBGgC3QtJN8dXGy2lKbkEiT9g0YezmiyU/2xdjz
         GFmA==
X-Gm-Message-State: AOJu0YwKHlpjZCLaPKcmnvJqSo9HFWJYU86NIK/8uKwAK57xvBUis6Pk
	Kjzi9yawvsJK/hd0q9aajkjuntoBl6HrwSoACSjDQ0qJAVS2DyaoKLMSXpvh2QP6HoK8cHvSBrY
	V/M8yjs329BflO/J6EMCf7KM3Ok1Gq0ldvq1TgQ==
X-Google-Smtp-Source: AGHT+IGniPJE68H/fnFg9EJf6Birfg7P7KbGb+GwAIG+GJe/KHH/sgP7a/Hczyhwwj1K/6UEoqRg/UPB6T8mRIhBQBA=
X-Received: by 2002:ac2:4284:0:b0:511:4c70:2136 with SMTP id
 m4-20020ac24284000000b005114c702136mr4704882lfh.9.1707324265646; Wed, 07 Feb
 2024 08:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f0cdf3c-be91-427f-86eb-4982de13e446@gigaio.com> <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
In-Reply-To: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Wed, 7 Feb 2024 08:44:14 -0800
Message-ID: <CAOQPn8t0YNGsMO-RsGFBxAGcOjwwgL2m8=x4mi-toyW6u-knEQ@mail.gmail.com>
Subject: Re: Using PTDMA driver for generic DMA
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Tadeusz Struk <tstruk@gigaio.com>, Sanjay R Mehta <sanju.mehta@amd.com>, 
	Gary R Hook <gary.hook@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, dmaengine@vger.kernel.org, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:26=E2=80=AFAM Raju Rangoju <Raju.Rangoju@amd.com> =
wrote:
>
> Hello Tadeusz,
>
> Sorry for the delay in response.
>
> The "ERR 39: ODMA0_AXI_DECERR" is a Decode Error relating to destination.
>
> Please note that, the PTDMA DMA controller is intended to be used with
> AMD Non-Transparent Bridge devices and not for general purpose
> peripheral DMA use cases. PTDMA engine can not talk to anything other
> than NTB device.
>
> Thanks,
> Raju

Hi Raju,

Are you able to share why the PTDMA has that limitation? How does it
even know whether it's talking to an (AMD) NTB device? Is there some
special handshaking or flow control happening that only works in
conjunction with the AMD NTB?

I understand if that may be a company confidential thing and you can't
disclose, but it just seems odd that a standalone DMA engine would
only function if its destination address represented only one specific
type of device.

Thanks,
Eric

