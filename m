Return-Path: <dmaengine+bounces-2357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D871990699A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A610B25DAE
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAD140E5E;
	Thu, 13 Jun 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMusOiTf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB01411CD;
	Thu, 13 Jun 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273125; cv=none; b=r6ZbX4QPLItyxcybpHGfVT1x83psqHBHoNWruEy65q/nDBeX8XmfkNnoDohm13gjVVuR9fpa3Ht3LN3HjZPCrog1XDRxvumGUWowmbPSd+fnjJYRexuIV9i6fkxpyvPPeQPlyc77ORT7S44E5GI8T4SNRd0LkezMmi0/s5EzIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273125; c=relaxed/simple;
	bh=xHYxVuD6tuy4oqLjz4QtqAvbrs/IlxyEpGE3iqAjKXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcoVR2RDwA+MtvWP7swbC7jswFXRga5kDvL+d7Wf7wiCogqI9WbW8C9kd3u5/4JAzLJGdQsT8jFuwknKwMuOzXU2/gyTLes8Q8PC6GMwH7iLkUelyPpZHW4vkcJHiUx42mSrwJVvR109br2nBIGLGtOtMheRNlXQiI5ddKxKWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMusOiTf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so780592a12.2;
        Thu, 13 Jun 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718273122; x=1718877922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHYxVuD6tuy4oqLjz4QtqAvbrs/IlxyEpGE3iqAjKXU=;
        b=CMusOiTfSNTJ/jBtOKeqrNO2iEFkZaEVhQHB0S/lhHYSvaG1B82Sc+LGCvadpxjwF/
         /0mTT4d7xQT0rITrulUodroWt8Z4YwiviyS2gFiA6Qt1JFP0VxZ7yjwIXkHiuBLbVFUy
         4PBAEiv7TS9BzajEbcKyWuxDBKx5zXgHqZ3lbj9OO41XreYFC3Dl9CPXP1YgM1tvTtfZ
         DmfpV9EFdVSTtfkaX3pDuhk2joa1AscCOUG5dKOV92f2vy41BOeFqlb1OuIIlc/PDmH1
         y8K1XnHnLk3GkmvxbWzTgWrudYAfAXMDh2fGgl352bOrAPgi0xknx+3TW1tpyR+wnDP4
         +j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718273122; x=1718877922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHYxVuD6tuy4oqLjz4QtqAvbrs/IlxyEpGE3iqAjKXU=;
        b=VTzthkk36bnvNXJp0KFoLLVMKWvGTTQsilNFBAE/n7f5BabATstB7pTf+q+FY5jMi7
         JPpXZAnuJkpP2rQi+mCDNvQPcCi3Y1YEqdegC8YA7NL/6QAy6nEvIGDNN0E/SzBjUHTu
         IeAQbATI/k1WebGicZdqbxJlcUsxe85Z87wNTZmpCB312lYigEXjvsIlqVMUp4t6U6Px
         1zP+ML+3ESC5QxJJ+sqmUFsOQOxSCscjk3J9TxM3MmV2fIPHcNNJljW+5Gp+HuJNDrgg
         Rkpmp26RACtoOOKMzI6ZerKhSiIrzuEQ85d6r4Hp12hfb6DLqoCKZLsjGtlupRTQ4ojf
         OdgA==
X-Forwarded-Encrypted: i=1; AJvYcCVl/Y57Z3U0Oax4/ynsbuSlnSUI6oKS9gm7P6WPPJIEFTrq3GsKFuLX6u99tAA3Ils4wV6TOEEr0WvcTHo1C7KHhphaxdonFKOzHuf4FLMl2l/aiB6sHHHkXiRV+YeowCml1AZKMHaB7XKqDvxT1E6CJoR9K7rdU9oOVxUgYZm0dhCPtrQ1DwavjtxYshR8AA5hZ/jGo1EplYOJytITvUY=
X-Gm-Message-State: AOJu0YzqCbT6QkpdZ+dcumTz8/VtEp8Xcj+uDwRlufpgeC4tmyO2/unX
	hJhQsoLTlfzostwF9gwsIFTACPTgvUWxUCi7akYUVYBo/YzbHGA6VGDUDW+cusRCNULwZWwbc4F
	VT/okn3If0c56GvHHsp+t2Kf/uD0=
X-Google-Smtp-Source: AGHT+IE9HDje36svQw6XiP4SkSWNbNFq+XfiFXwtcW7jd/Rn7W2QugI1ga+ZTOGKLQgW3DB3KVTzBPv+APqx793tLZM=
X-Received: by 2002:a50:a692:0:b0:57c:6000:88e1 with SMTP id
 4fb4d7f45d1cf-57ca97496damr2697320a12.6.1718273121554; Thu, 13 Jun 2024
 03:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com> <ZmiYGos4MFJWd-bL@matsya>
In-Reply-To: <ZmiYGos4MFJWd-bL@matsya>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 13 Jun 2024 18:04:44 +0800
Message-ID: <CAJhJPsXF8LEgZFDToVvWPiYb2JvducD1YKeR1yqOahGbmbhpLQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add support for Loongson1 APB DMA
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:31=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 07-06-24, 20:12, Keguang Zhang via B4 Relay wrote:
> > Add the driver and dt-binding document for Loongson1 APB DMA.
>
> I get build warnings with this. Please build with W=3D1 and C=3D1 and fix
> all the errors and warnings reported and update
>
Sorry, will fix this ASAP.

> --
> ~Vinod



--=20
Best regards,

Keguang Zhang

