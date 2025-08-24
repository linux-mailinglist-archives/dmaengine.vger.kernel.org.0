Return-Path: <dmaengine+bounces-6182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3534B32D9E
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 07:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507FD7B1D55
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6181E51FA;
	Sun, 24 Aug 2025 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D65XegTn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594361DC198;
	Sun, 24 Aug 2025 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756012895; cv=none; b=jYIm1kjSIb8hiZfGEOWbZCmQvEn+7nQ1VFXKgOq3k+iVFfK1PbB7FXNftsKKO7ng+q/x9Js/8aTRwOgRUVHVT1LxfKv/cy/KdM8H/RhRJdQb4EhJRn+Wm74y0J+ONltE74q8H2VeJkNLd1Kpg7HV6FxbkLZuz1gHG/KGDzVzYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756012895; c=relaxed/simple;
	bh=xaKVk2d4jA0H8LTFcT/QZ2QQRuxTsaHXqXwnZLeGb7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYK4WK82/OMJO8JlIgq+bNijDGzl/9kU1UwFOTIf7f5MlAopQBoomBiKPWbfm273O1woGadxGzGgOvABP8l06PxxXCaDSxuny8zf5KBhbUGdVIgHkovepYOrIJU4YplhPoGcDFWm+LK/zl26hqo8SC6kjg5mydDOIaFjBKpzXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D65XegTn; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89018e97232so1068858241.0;
        Sat, 23 Aug 2025 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756012893; x=1756617693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK18U80jXCyoI5xw2mPid6nmfVek8LToJTaruDflWhM=;
        b=D65XegTn5Dc/LGsJa6V3JT8NMsXdPDkarAohe91vvtCP4Cflz7SeUUG15YM20Pyjto
         NVVIQS6QZsqTBpL4Ed8+9GYaXRPNyM985NZj4zTs3RJbpR0+4DSlwMDyPW25O6tGfQBW
         Tj5VYXDAo2b7rC35DulKEcORo5wRLZk0ZgGy7vWYyKNvgvmg7VRINGgBW+2DMTmvpZLf
         JvKNSWSDR/ChSYqt4Yye4i32sIa4ySAcqt4PJumlTkel3fssCNCortY9ngfgnydFB4U8
         Wmlh34EAl3WEZNc01wpzng8VjAtoK7/mi/EtNyXpANae1shR6iY6XUxh+W2177LfG6Oa
         vSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756012893; x=1756617693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK18U80jXCyoI5xw2mPid6nmfVek8LToJTaruDflWhM=;
        b=IZU5GKWNmvC9tr1x04b74WB/AjhDmYcmsDliahsTu1RjEO9TzvLtXOAsOZ7bau2KSr
         UURNSpw2uUFgdwmPp+oGmVKxdnWYrUa27PiLFL1iL5CApa8oK1Y0D8JeRchNzp4ZQbtx
         gfRsMY7+n+UlShhxVyHK6766j5anEJlGIeOsnWEmWrgcPN9Da/4bMpKqgQ8sTgiaygVO
         imAGzVIw+IZvmz/21reB5QH3GKIETp3qguOEORot51LNvm4e8PiNwwx/f89LuBelV2Xz
         dkmAgU6tYqdE6SHmLtT1SODWsLlLjleQh1uugNtkdtCUnBIdeZ4uiYnXAZEF884R44I7
         uSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vPTLUV3MisyYlkZoJVHgOXb+YkPxQcGWklHrKgpM3KpS3bPTEv03QjSKreOfXnFYeAJwvJaxj6Y3@vger.kernel.org, AJvYcCVToI7ZOIjaE08AniPufKGNJqbiu7W/0u5Dv/UVl3ksxiP8ZqJ9SC7rQRD2M/1rJdE9u4eaTTNSWKJd@vger.kernel.org, AJvYcCVbQsznGXE19QGYztx8jiYy8+OrigMM45x2y0+VvNr0uxsew1GQjI1y7lq64WwD1mlxiRNkTnk2ESyr/ZrV@vger.kernel.org, AJvYcCXYrPKyAlwXGqaMgrbK2R8HKCyylGtYVruW9G9zyYicNJz/mEqV0GyruQya+vhzYuHX4Ch1neSvg9yZ8fkTLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmxoT2M6ZlUqVhCxfrvzBO25nRdWFmDWIfq8dS1R1mc9GAQMC
	Q3JsJHOxdfBq5ANIE4dm+DEA1fm13XcoYTNRh7EHT1e/114nlf7YRxNCnG8yCwQdwazIxOtq1mA
	3hpp/TOQPynSxVYLgR8ByMLy2xxXFuXI=
X-Gm-Gg: ASbGncsQGj26EGPvhe4THmZ/e37YIq9RxlAcrov77kXWx+zACL8Lzbd588UdFC/0I51
	6sYsBZ2sWkqwRWyLIDVT9KHVDZ6Qsjxygwth9WbpBEgsQUAvAT+GATitPaVAKn1Yzwc86B+tB/r
	+90UuuwDMkx1hwwxbiUFwNTvb2kEWJCbr81G1/FCKU9AUCovbdS8HZO+M2AwS6qrN+eEBsFAMom
	almoD3qal5LOhXV3Q==
X-Google-Smtp-Source: AGHT+IGp0uAe+eS/vePF3H0zdoLpIBdWhB3VDrMnjvN6j3sGdMU/rwTJriGSVIzjFVUln6veT4mMIj7hx+odRrkXW78=
X-Received: by 2002:a05:6102:3754:b0:4fb:142:f4d3 with SMTP id
 ada2fe7eead31-51d0f0ef701mr2589378137.25.1756012892751; Sat, 23 Aug 2025
 22:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612075724.707457-1-mitltlatltl@gmail.com> <175600415270.952266.1079016155668636872.b4-ty@kernel.org>
In-Reply-To: <175600415270.952266.1079016155668636872.b4-ty@kernel.org>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sun, 24 Aug 2025 13:20:33 +0800
X-Gm-Features: Ac12FXx5BRcsZcKvo8Fmf4VVgB38VhKI1_hW-o9EWJXtg4SKzEdvOLZ8e3LaGSc
Message-ID: <CAH2e8h5s5YA00EM7mdDUFNGTz=CL0bsm3_6bbHF5QhVyTq_GsQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] arm64: dts: qcom: Enable GPI DMA for sc8280xp
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@foundries.io>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 10:56=E2=80=AFAM Bjorn Andersson <andersson@kernel.=
org> wrote:
>
>
> On Thu, 12 Jun 2025 15:57:21 +0800, Pengyu Luo wrote:
> > This series adds GPI DMA support for sc8280xp platform and related devi=
ces.
> >
> > base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
> >
> >
>
> Applied, thanks!
>
> [2/3] arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes
>       commit: 71b12166a2be511482226b21105f1952cd8b7fa5
> [3/3] arm64: dts: qcom: sc8280xp: Enable GPI DMA
>       commit: 013d01811a1ea4ce0f676e4110f94c80271586b9

Hi, Bjorn. Please drop them, this version is outdated,  dma channels
were shifted when applying it and reformatting it.

I am sending the new one, please check this
https://lore.kernel.org/linux-arm-msm/20250824051756.9031-1-mitltlatltl@gma=
il.com

Best wishes,
Pengyu

