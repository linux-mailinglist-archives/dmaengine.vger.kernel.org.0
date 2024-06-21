Return-Path: <dmaengine+bounces-2503-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E129125EB
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95281C2370F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2415B99B;
	Fri, 21 Jun 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="2/nYqkgF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED115B55B
	for <dmaengine@vger.kernel.org>; Fri, 21 Jun 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973875; cv=none; b=SodLc53eCgCvwinefD1Mly9/3dDhi5f246I+L4Z3Jd2NYsWHn00eYrcRvqD+M/FFXmIh1uNklIda6maSkL4+GNnWFZCRi1ywBfkclpogKdXXpspuIbrMHDKBA4YHQ1RF3sLORzVG0lwON3L4UN55fFZdjYXEBITaYeaYtQ3GL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973875; c=relaxed/simple;
	bh=5l08J6QwTAydc1Q035PbR16J+Enp8p+H6+DUEul73Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY4dXmRzp9wSBM/6MZbtWwr7Mv/VifLoMzaXmQ9rYanJ8MV0NGgZDXfAJCHY1p/wWAgQeOQW9tpmy44WeaXnsOHYm7kF0yMhQRrQiVSumbWGV5HWNJ1h8VE+f5/6dw8RjY9hpE6HR1w9hrRgMQmqQWlSMZp4mXRxLJVLu9H/qR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=2/nYqkgF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8d0a00a35so1810393a34.2
        for <dmaengine@vger.kernel.org>; Fri, 21 Jun 2024 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718973872; x=1719578672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l08J6QwTAydc1Q035PbR16J+Enp8p+H6+DUEul73Uc=;
        b=2/nYqkgFh4BQX24EVE1GiO4QA5l4varwH8FB9cvXPIIdwe98n1tSYgA3wlx+UjAcOP
         bXpOE8hgn+VVvYi0oDw6H3kW3c0/5CL3YPGx9bB/TNvpuJltFR/DCgtrMP6XwIYlLeTk
         dEnuhX8skNCXatglG3kR9wUX9qiG44IgnVNqbRltj5gIwRA8oCI6xneka5XjZPqt+Gab
         IeynXAaaRfMRChGOIBEZut1Vy0i/cil5+t9ahnzdhC5liwDkonxFkJWQ3K0JBPe/z+jp
         PsFfPxPFqQOJw4N+gXp7LEulfX8/7V15sHvkKI63OAK+3cUOHDwM+Y2zOO44WDT/8TOH
         AHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973872; x=1719578672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l08J6QwTAydc1Q035PbR16J+Enp8p+H6+DUEul73Uc=;
        b=g7FJfiUQ81n9U+XYWkwwQUEywMXtmDK2Bc6owfrNmehzD7mrG6CqOvcBlj2WGisBb8
         EJvoHKslUDYQt5MdLKhB4MTUaZ7tHLvkyk8avw6Yz08eEPTkrqNTtPCj2+Q3DDEGBlIC
         vexo9wh4YIzkHY1ZU630zRaf2z7spJbAotKeCLG0SNfj5nMOEgMJ14qp0mb75W2zzzjf
         PgwW0mUJH1TgtLCxTqstVg7uBYA/w4GonXh/xhU0up8UCa1x81CcBRNaWpM6ERBJIzIy
         trq17juD+rqmh3/LWv5pZscauijiyyymuq5yQev+tyDn9fxDxQpwmOyTzPZ97tdRVdFY
         6viQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoxdCVbg+0X0r+G+5er2bQC21DP8QsiedoTzzqh//8DQpWd65V4OAgRfOKldL0pt4PVNA/SKZYFwM4PI1J9MgbZevpog42U0uw
X-Gm-Message-State: AOJu0YxsAtZ8BCFj5ThODKF2iVyh+/VE0znNdk0LLgkWOBqSxdLWD9re
	ru/B4/UzF2vg8gigp7eAY2I+18xTaf/F0svTlZJgIzYpCUmThFg76cSvy3wZvmtU4Jj3QqGNiAq
	8dFiBAlyRRGOkh6DRJJtnhlQRV67LI8dACgKm8Q==
X-Google-Smtp-Source: AGHT+IEOZNlyLp+OxVrBD22Lk7qV9DoUmsFRWzsrduGbMG3NGbu8paAH4Nzg2EEG9ozpibJTiN4vqzTSJCMR3pLWBf8=
X-Received: by 2002:a9d:76cd:0:b0:6f9:e6a5:dad2 with SMTP id
 46e09a7af769-70074dc525emr9327837a34.17.1718973872714; Fri, 21 Jun 2024
 05:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-9-piotr.wojtaszczyk@timesys.com> <20240621103019.783271f4@xps-13>
In-Reply-To: <20240621103019.783271f4@xps-13>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 21 Jun 2024 14:44:21 +0200
Message-ID: <CAG+cZ06GSxPsTzRLXSk23qWXMkp-qxYq7Z9av5-2cPHSJmVAHg@mail.gmail.com>
Subject: Re: [Patch v4 08/10] mtd: rawnand: lpx32xx: Request DMA channels
 using DT entries
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"J.M.B. Downing" <jonathan.downing@nautel.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Yangtao Li <frank.li@vivo.com>, 
	Li Zetao <lizetao1@huawei.com>, Chancel Liu <chancel.liu@nxp.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, 
	Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:30=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Piotr,
>
> piotr.wojtaszczyk@timesys.com wrote on Thu, 20 Jun 2024 19:56:39 +0200:
>
> > Move away from pl08x platform data towards device tree.
> >
> > Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
>
> I don't see any change regarding the NAND controller node in the device
> tree, is there any dependency with other patches from the same patchset
> or may I apply this directly to nand/next?
>
> Thanks,
> Miqu=C3=A8l

Yes, this patch depends on "[v4,04/10] ARM: dts: lpc32xx: Add missing
dma and i2s properties"
which will be splitted into two or more separate patches per request
in the comments.
I'd like to keep driver changes and corresponding changes in DTS in
the same patch
but I've made a separate patch for DTS per request from v2 of the patch set=
.

--
Piotr Wojtaszczyk
Timesys

