Return-Path: <dmaengine+bounces-5705-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3EBAEF1B4
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD85189EA1E
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AD22CBE9;
	Tue,  1 Jul 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EvZITTKY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C761FDE19
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359734; cv=none; b=LyVXdr9VIDA7vXtuWGobUoSMslrLoYZal5hDD7D6MhGkH5bhOB6NV1ZpSNSddQs2PTiexVj23KKZ3XceUnBdap5ElbQfauJyaoqgPpuBZ8pjk5H5G1hju68Bwm2wj/I4pG2FG8JZp5Sdn5dMHdR2HmqyPmTZHpxn8Kcfl9mZpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359734; c=relaxed/simple;
	bh=DGBHFGIQFj3DI57v/KergKc6+HMEaz+DP4HpyZ/MxtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW5+AqVb5dfqsh8cejjAJSHZzxWd6YYGjWcokO3U7TUaRTvJrwq5wQUNR3P+H+KGdJqFddfDbiPVM9Qa7O2X5O9RQEjimDHU1hyrfH+JKsBjcZ3F9fscX2AnlHa5Jbt+SeVyANC6GnPwa2b5QiqHOL2fApikvJscySObZZPlOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EvZITTKY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso2511335276.1
        for <dmaengine@vger.kernel.org>; Tue, 01 Jul 2025 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751359732; x=1751964532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ham4MleQtpYSqIWPo8fq/MuoFtt+t8Ya59SZXOm39+s=;
        b=EvZITTKYDl5uL1ve1wLJnipv0bkLmS0L6fx3chyv8BvSs70JiIxRsLqL1cVwFUWFZm
         ebyxm0YSMkZtuTns9B0jtC757l7bd1gJM8CIOVMI3gO2+pg9X4Z5yAKrn4g9UXc+9IyC
         CT4t/PFh87odls6yrrlbaGp6E3rr73GVlhSdbbWtkSIGnrpi2DsQ8BIGzfJmialYSVNd
         1gYU4eKxe7vPsnBZ894SqyXviLAZH8SvsByGStG4vued3wd6wH8DiNcWWKWf1RMt02rv
         rKZa3L/9r6Ikb76GXd4f6tnKn5/YlGWXqCVEAbmm8bYvPzF3A4ewfOtj5O/MXM2QMhAC
         mAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359732; x=1751964532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ham4MleQtpYSqIWPo8fq/MuoFtt+t8Ya59SZXOm39+s=;
        b=aRxZqwwvNqq//RK+D5Rx9tjRlSKU48miZOUcneKAgNqed0q/WBPk5SQ6EgC9DPXZEi
         0jZtjEHhsGuD0nTq7o6epLdaWBUy56X6PCDiiu1UK5XyFBDgdP/jzSuAl0QTvnkEb8DX
         t868gMUMddCI3h6QPmYJRiFm4UDTmn3Ht0GKm06MSEftGm334Dqlpy8VKzGxH4XLFpBM
         g3Ji31reonbOkVu34kOi4efnMNnwSSI9sGCtjPFK5eG2q7ZkGlMDTyih3bbtXHubiL2+
         9jX9+xxCK6jrEVmx8awfjy77rgoqa4ad0cBiJIO9r9oQQ/HOR3la5Eph42FlxYybQQNz
         DwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVNC3z15VIg1wF4X/LrtoLCz3MaOPtw260eDmEI9jjGlCXrQM3a+E1WTGEh4AYAoU1KdOTezy6VIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUe+FLmu8bqVTUNE3zXlgecJS0/aa0mkvY6XhqgvIeoRKnrS4
	OlSZa1tXS1xAhhfc2dr/RH5PF0G8TXJSKP5sNSIg7sjC8FQ/yFro74SHEREvwQKB+F9BZ5JfGjY
	5XvOz2PrjUbdPaTFe82HZnrwaONO1M2eo5MFig6TpUg==
X-Gm-Gg: ASbGncv9voEpHNn6FJcECZDDIpFamowb2+tF62E76FEXmOl7k8X5mUu+XaL+7KfTNqZ
	pFM3lZM1/W6l9F70I/MINxgmEsJBANLj6vQ+aagT02+q5NVluHkAnnOzyoX9jJEQjlQn/sMyCG0
	ipgvxheao7oqfyI9kfOtSFG3NVriKwAvJu30LqqQdPov8rwLIX
X-Google-Smtp-Source: AGHT+IExwbxuXz67r7i2U0Hj9e39nnEuFRzklLDURAXbWXk0DV903xSBiVjsaBHg1u3FdNeBklfefUYYXWQaY3P289M=
X-Received: by 2002:a05:690c:45ca:b0:70e:29af:844a with SMTP id
 00721157ae682-71517196047mr247551697b3.18.1751359731954; Tue, 01 Jul 2025
 01:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
 <20250701-working_dma_0701_v2-v2-7-ab6ee9171d26@riscstar.com> <ebc16dbe-2405-4956-91a0-bcce9f199326@kernel.org>
In-Reply-To: <ebc16dbe-2405-4956-91a0-bcce9f199326@kernel.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 1 Jul 2025 16:48:41 +0800
X-Gm-Features: Ac12FXzG_24euqC2ksqQUMdli-9vCkce_uhDVNzQHQHTjfNnkSCnW6ua-Xfs0vo
Message-ID: <CAH1PCMa2dB1fefzGgo-kKfgAdou_KaDSvTDsvYPjsGKODHETCA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] riscv: dts: spacemit: Enable PDMA0 on Banana Pi F3
 and Milkv Jupiter
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:36=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 01/07/2025 07:37, Guodong Xu wrote:
> > Enable the PDMA0 on the SpacemiT K1-based Banana Pi F3 and Milkv Jupite=
r
> > boards by setting its status to "okay".
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v2: added pdma0 enablement on Milkv Jupiter
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts   | 4 ++++
> >  arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/ris=
cv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..39133450e07f2cb9cb2247d=
c0284851f8c55031b 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -45,3 +45,7 @@ &uart0 {
> >       pinctrl-0 =3D <&uart0_2_cfg>;
> >       status =3D "okay";
> >  };
> > +
> > +&pdma0 {
>
>
> Does not look like placed according to DTS coding style. What sort of
> ordering Spacemit follows?
>

Agreed. We should establish a consistent ordering rule for SpacemiT board
DTS files. According to the coding style documentation, there are two
acceptable approaches for ordering node references in board DTS files:

"When extending nodes in the board DTS via &label, the entries shall be
ordered either alpha-numerically or by keeping the order from DTSI, where
the choice depends on the subarchitecture."

Refer to Documentation/devicetree/bindings/dts-coding-style.rst

My preference would be alphabetical ordering for easy maintainability. Howe=
ver,
I'd like to hear Yixun's perspective on this before we standardize the
approach across both board DTS files, BPI-F3 and MilkV Juptier.

Thanks.
Guodong

>
>
> Best regards,
> Krzysztof

