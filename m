Return-Path: <dmaengine+bounces-1652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA5A89125F
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 05:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278DF1C23768
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132A2B9BE;
	Fri, 29 Mar 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5wZV35a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34C3AC25;
	Fri, 29 Mar 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711686341; cv=none; b=A2s7xXO7gOKuPNb/6i1wo0z/nEsn1YmY0bt0RvUDai2rTUHMFXNN36LxMuBcJ7m8Ma/UAzTWe+RrmqvjAtiMyspTEKDyY6FAWnmyVNYMCAcVWew4zr4mHMSoC7KZfCUo/09zhPUEdAmXWEID4E9yRlzHONXF66tWnA/lgBDAkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711686341; c=relaxed/simple;
	bh=7IZ6TQHzHNNntSBebLRFQSFiXdqxcUmk7UYW3JKtsJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELfU3I/+qlNsMZHBsQBHzx2uMDzTvNXEGRP8J1tdKPSXaVyzAp657QJrUWueAdxwXMlRwpOD4ygvmzegGy/UYE+iD//I+Z6qCiSq0dxTIo53AqtNiMayJibP2uN9znRrBlJN5BhNBkrRMXS/aBCbiD7k+GxotVJKFtXQdxpZsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5wZV35a; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3688ff3ca52so6774865ab.0;
        Thu, 28 Mar 2024 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711686338; x=1712291138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ37qzu7x1RT4FhH9Pq0w6AEDnJWDjXnQkreRgUC0As=;
        b=V5wZV35aF7gY0v8BTSWgsIIm2ziynFaXRHnO0UxEV+29aZnSXGueIq0g/8iUiIKpBB
         16Ge/1LWlyrArhi7Ho2FW1FY5P1KhsWFjAqPcopfjuUSIq0IhqXknNvUSAtxSn5hnOyF
         G0wMA9h+EUrCLQdoKpYDl0JpzB/tcf68fW/49g+KmOYbhju8ZzgqR5ZM67Q4JU7NtBjT
         V5Zf/cmlEDpt27T8yEk3HubZnfFb9bT7LTCMCNyjliyutFVJkSO2TBqJfWmuyww1+ZeZ
         aBJcaHJbnBMY/qeq06fFU+Y3g1+CGI3W+3qTquWFCzlUXG999rTUNPavspvPv7JT2a/+
         OULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711686338; x=1712291138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ37qzu7x1RT4FhH9Pq0w6AEDnJWDjXnQkreRgUC0As=;
        b=n+L7XtNbrul7AQDlh3LTm3s1RJ3fOiOfoWVMfdzY+z9RDF4lzjfqtH5T5OnFHPpzKg
         H9GLreA1vQZiNq0sXY3ypmK48WZYvx0hJRsjw6MTvx16gpCAnrTiz17pv+DGPOR0un4G
         6dmfDXkNRvfqT+0LhsGnho0qqABNAkZtOA7mmVBjJvFAeHs3J4JkCVmLdUNHHnp/2fnO
         ZRnHBNfEh64EGnJLn6qwl0PrQo9H8LnqjawGwFObYrnaehPI9YU5059BeqvaRN1yestq
         v76Uj2t/JWgZSFHB5qpOLdIX2mDr8Gq+moJiNr5aqYgS2oklOHatUCerBsj0xXlywZ4K
         dcEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDKobthXi56JLs4sEDRZK545YhUxP66zDTCO7LSCBRK5+6R6vHwdKPYIiFMSUhRQZVrqp1PnIHvJMErbbhtAK5zhD6gg1zmCXdCkHTh42vYg3puOTO8DQ8kupI5OHfPvUKTOuDPO+a
X-Gm-Message-State: AOJu0YwM9gr84225gt9SeqY7TB7LNVEbrUbSU/Ht5NYRfGF/yvEMuiRk
	tta8OjSWKsA0hPhjXDV7P4SDbjiLzAVQ7WJFsaLFuw6f9VcLGRPwl6kB3Pr2ethZ1RGJWdTdkR8
	4NCvhF6NPQdehIrK1rP+GC8+TzMo=
X-Google-Smtp-Source: AGHT+IFPBNrPz2Mqe5xoNxdfvTWN/1rO/cx1RiqAvIgUhy/WtGLP7XhI5A97GYuDTi7AdbNfcGzOUxPoWL71kIj81FE=
X-Received: by 2002:a05:6e02:18ca:b0:366:bed3:a218 with SMTP id
 s10-20020a056e0218ca00b00366bed3a218mr1237240ilu.32.1711686338112; Thu, 28
 Mar 2024 21:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711682887-15676-1-git-send-email-shengjiu.wang@nxp.com> <ZgZBH/HsO8YmgFZx@lizhi-Precision-Tower-5810>
In-Reply-To: <ZgZBH/HsO8YmgFZx@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 29 Mar 2024 12:25:27 +0800
Message-ID: <CAA+D8AM=1syyawLu7Wna5jHqzVsOuVvTKpTsaNUK7LCXMciL7A@mail.gmail.com>
Subject: Re: [RESEND PATCH] dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:18=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Mar 29, 2024 at 11:28:07AM +0800, Shengjiu Wang wrote:
> > SSI and SPDIF are dual fifo interface, when support ASRC P2P
> > with SSI and SPDIF, the src fifo or dst fifo number can be
> > two.
> >
> > The p2p watermark level bit 13 and 14 are designed for
> > these use case. This patch is to complete this function
> > in driver.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > Acked-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>
> This already in my sdma improvement patch list.
>
> https://lore.kernel.org/imx/20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.=
com/T/#m59e4e03a527103de7bf1a7fe86e8fbc570454970
>
> This have more nice commit message. Can I take one into my patch series t=
o
> avoid conflict.

Yes, please.

best regards
wang shengjiu
>
> Frank
>
> > ---
> >  drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 9b42f5e96b1e..079e6e8f4f59 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -137,7 +137,11 @@
> >   *                                           0: Source on AIPS
> >   *   12              Destination Bit(DP)     1: Destination on SPBA
> >   *                                           0: Destination on AIPS
> > - *   13-15           ---------               MUST BE 0
> > + *   13              Source FIFO             1: Source is dual FIFO
> > + *                                           0: Source is single FIFO
> > + *   14              Destination FIFO        1: Destination is dual FI=
FO
> > + *                                           0: Destination is single =
FIFO
> > + *   15              ---------               MUST BE 0
> >   *   16-23           Higher WML              HWML
> >   *   24-27           N                       Total number of samples a=
fter
> >   *                                           which Pad adding/Swallowi=
ng
> > @@ -168,6 +172,8 @@
> >  #define SDMA_WATERMARK_LEVEL_SPDIF   BIT(10)
> >  #define SDMA_WATERMARK_LEVEL_SP              BIT(11)
> >  #define SDMA_WATERMARK_LEVEL_DP              BIT(12)
> > +#define SDMA_WATERMARK_LEVEL_SD              BIT(13)
> > +#define SDMA_WATERMARK_LEVEL_DD              BIT(14)
> >  #define SDMA_WATERMARK_LEVEL_HWML    (0xFF << 16)
> >  #define SDMA_WATERMARK_LEVEL_LWE     BIT(28)
> >  #define SDMA_WATERMARK_LEVEL_HWE     BIT(29)
> > @@ -1255,6 +1261,16 @@ static void sdma_set_watermarklevel_for_p2p(stru=
ct sdma_channel *sdmac)
> >               sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_DP;
> >
> >       sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_CONT;
> > +
> > +     /*
> > +      * Limitation: The p2p script support dual fifos in maximum,
> > +      * So when fifo number is larger than 1, force enable dual
> > +      * fifos.
> > +      */
> > +     if (sdmac->n_fifos_src > 1)
> > +             sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_SD;
> > +     if (sdmac->n_fifos_dst > 1)
> > +             sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_DD;
> >  }
> >
> >  static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdma=
c)
> > --
> > 2.34.1
> >

