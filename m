Return-Path: <dmaengine+bounces-2551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1B91A48E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B01C218DD
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116E1487FF;
	Thu, 27 Jun 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="fBhAyFjK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040E1459EB
	for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486369; cv=none; b=UYL5ftY6ud434kZ8G45+y5/5AyjMIbX4sYXQJQlQ7UxsWXTRa2IBDTYEXB8fUPI4shYryjwHa6cwN0tpTBoEXAPJOycYMbVThLSfvNOB+ahnSkcmxuoSb+7xw25r407n5Xje9yxN25/9G163UbBe3i8RQJ5aTChR0FI2U4FUlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486369; c=relaxed/simple;
	bh=q8pm1cQ32txw1WRPKTanNTmvRox3c7g4AlMuHhl+D20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwwDwZuiTsVtsWbVtEas02bBA2QEJmf2Z4yax6O2h0/lTehIuhYeYx4uUy5RB6EZGatMsf7wj1KD++6Ul/q3jFbNUNQtEhdEO/KfKK7/zmz1woV0p4Qkl0eoq7l1fBtNUdRtjMwTBzzIGQ8W2htlT8cF9Y9Zt7O2fBC4JGAOU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=fBhAyFjK; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b593387daaso3608536d6.1
        for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719486365; x=1720091165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8pm1cQ32txw1WRPKTanNTmvRox3c7g4AlMuHhl+D20=;
        b=fBhAyFjKVQH9Q7d5wuaZPgNCYT5JZ3kprAQjwr592CkBHUhnX3a5lAKlC+LXqlNXK6
         IKK8qoY5lh5I5yR79PDRkGPX/5QQU+UXnW/wz+RYa/Jl6D9eDMGTT2zTYn9BxKtqPQvv
         Sgr1yE824hNKoxfryHz8F8/9KFp9SALgaX0ApbIIi/stoOt+V6g7RGoCQ6LoBfr9loHz
         9JV1cvDWtjwK0C4A6+1DlYe2isjwsVZmtHoPVYtVx+6k/T2WtcYngryOKSmglxBONKMj
         kkhYSnsqi9hes+wu35KzkfUeFxqPQIjZBifRRIbZYREauaV1ZbL/e0JeaYxaWrwRLYq0
         4ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486365; x=1720091165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8pm1cQ32txw1WRPKTanNTmvRox3c7g4AlMuHhl+D20=;
        b=Ilvtz3yhKjZ/St+D4Yh7rgymoEWu+WQpywdlpzMz4kjyJbdzDbfhLzlNPAF2/Y5Ctm
         535HDA4yo1rR8rLg7Obf9khJwTAt2ZBoTYno5DS22grhEwi1CrjosVwg07wDlLzpOibP
         rVPTsjU1qWdyPMdHyVNjn+0x52dnWjrKAdwUIKMRPBvUEP1gWpnSnVvnxg+H9nrImMNm
         rfA/+x+D7WXc2jel46qYH0vdYH0Y6VCnNyEuQqqGVomaDLc2gCukYloY+hWTg3Za+PtY
         uOzGUDqr56o+qRBfdVg92S6gNyL+c5Vuvfjm/iRhC+E8jMru+Tg+T6JfsL9HHMGzbf4Q
         Ar/A==
X-Forwarded-Encrypted: i=1; AJvYcCWYiRdTOC7ZHT58IlINPjMKyVLXfCIUKVU+VqmZD+Oe215NIfX4+kKGQOZYjRwN4hLf6NTDhsa+idfM98aivhKgDAIvpRxDT4mE
X-Gm-Message-State: AOJu0YxBUtq/m1Ok0l8v+ifv8Om9Lz4fEp/Hy8fb++Yo/EylFJ3xordu
	nFnNZITvpXc9cZ7S+SOzWouBi19wLcBRijOLdq4U4lg+1xEgn1XqR/c5IuphIDel8ZRrvMdDgwV
	er9NR9cmE/U7H8tBzHZ8adKhMGu3z2MgIY6DsMQ==
X-Google-Smtp-Source: AGHT+IG2MNKNNOGC761uBwvpqX9lGsPO6rQNPCNWhEy1V6ZqnINWb303gmPma/KMWKNSmIVuRVUQ+Leug+4DoYkVHJE=
X-Received: by 2002:a0c:f2cd:0:b0:6b4:f7bb:6d69 with SMTP id
 6a1803df08f44-6b56380939dmr109313566d6.32.1719486364821; Thu, 27 Jun 2024
 04:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-11-piotr.wojtaszczyk@timesys.com> <jgqhlnysuwajlfxjwetas53jzdk6nnmewead2xzyt3xngwpcvl@xbooed6cwlq4>
 <CAG+cZ04suU53wR5f0PhudgNmkxTRtwEXTS1cWH1o9_rTNM94Cg@mail.gmail.com> <73yvglxha45d5ft74m3y5fdmkgatm2yftvhza2msg4ombjz42f@wz43pubhbpdz>
In-Reply-To: <73yvglxha45d5ft74m3y5fdmkgatm2yftvhza2msg4ombjz42f@wz43pubhbpdz>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Thu, 27 Jun 2024 13:05:53 +0200
Message-ID: <CAG+cZ05uam3LkvLXG3xAc8FY_p6jx4p=zinNeWbkKUbcLxSTrg@mail.gmail.com>
Subject: Re: [Patch v4 10/10] i2x: pnx: Use threaded irq to fix warning from del_timer_sync()
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"J.M.B. Downing" <jonathan.downing@nautel.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
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

On Tue, Jun 25, 2024 at 11:12=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org>=
 wrote:
>
> Hi Piotr,
>
> On Fri, Jun 21, 2024 at 02:08:03PM GMT, Piotr Wojtaszczyk wrote:
> > On Fri, Jun 21, 2024 at 12:57=E2=80=AFAM Andi Shyti <andi.shyti@kernel.=
org> wrote:
> > > On Thu, Jun 20, 2024 at 07:56:41PM GMT, Piotr Wojtaszczyk wrote:
> > > > When del_timer_sync() is called in an interrupt context it throws a=
 warning
> > > > because of potential deadlock. Threaded irq handler fixes the poten=
tial
> > > > problem.
> > > >
> > > > Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> > >
> > > did you run into a lockdep splat?
> > >
> > > Anything against using del_timer(), instead? Have you tried?
> >
> > I didn't get a lockdep splat but console was flooded with warnings from
> > https://github.com/torvalds/linux/blob/v6.10-rc4/kernel/time/timer.c#L1=
655
> > In the linux kernel v5.15 I didn't see these warnings.
> >
> > I'm not a maintainer of the driver and I didn't do any research on
> > what kind of impact
> > would have using del_timer() instad. Maybe Vladimir Zapolskiy will know=
 that.
>
> Your patch is definitely correct, no doubt about that.
>
> And I don't have anything aginast changing irq handlers to
> threaded handlers. But I would be careful at doing that depending
> on the use of the controller and for accepting such change I
> would need an ack from someone who knows the device. Vladimir,
> perhaps?
>
> There are cases where using threaded handlers are not totally
> right, for example when the controller is used at early boot for
> power management handling. I don't think it's the case for this
> driver, but I can't be 100% sure.
>
> If you were able to see the flood of WARN_ON's, would be
> interesting to know how it behaves with del_timer(). Mind
> giving it a test?
>
> Thanks,
> Andi

I took some time to take a closer look at this and it turns out that the
timer is used only to exit from the wait_for_completion(), after each
del_timer_sync() there is a complete() call. So I will remove the timer
all together and replace wait_for_completion() with
wait_for_completion_timeout()


--=20
Piotr Wojtaszczyk
Timesys

