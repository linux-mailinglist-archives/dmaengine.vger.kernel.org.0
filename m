Return-Path: <dmaengine+bounces-2766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC594508F
	for <lists+dmaengine@lfdr.de>; Thu,  1 Aug 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CD81C20F63
	for <lists+dmaengine@lfdr.de>; Thu,  1 Aug 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376D1B3F27;
	Thu,  1 Aug 2024 16:29:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC523A1DA;
	Thu,  1 Aug 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529774; cv=none; b=Yb/3nbkqLlgVKCzDhlX5XuPk2NUG5F5vAQii+qAH3OaXIsHBcG1t9W0yxPgmDK43MSfVKAcC9n/psuMYODC4AyJm2Pp7zWOALjGdFAz4UiMaibQeWi+27K7sa3XbCbT+PNSrAmMJ552hR7mCOeR3oDKszc+cMZO4gKRdGhVRjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529774; c=relaxed/simple;
	bh=QsvCNio+3zzxchq5fzKn3o83VQzC4bk3D+jsQv4Z/4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdkYI+yg51ORQPfie+h4rs+2PGB3qcpMO64r+Dxmt/grJ033zeAlOGPt+2L+/A5pmnBYNzhJDDG5K2sJ4hFVrIqPZAGHzbYyJyGg1SAx+W/9H9JmNxvkzjmi40bpAHeRJsSxV1Kh0TBVTbYOZWxtH24z+KFZN0w2xt26MLAkV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0b286b922eso5228284276.1;
        Thu, 01 Aug 2024 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529770; x=1723134570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8+kc5F3GMejqWVlpNJDpHQgkOH2t0JJ464cT8v7PXs=;
        b=PJ2GCsINKBJER2I3Pa2e2kP9qwVeHr5P/xwq2G1IjIKN+WMxoNzPKLtx3Py0e+cRma
         0wsbYhhR4auV8q+fqehg6ubDqfHXfkY7uXmmWDUxHMnhPnRI8FpCPSMwtePzBtE+FEhe
         OtX6Fi4Tt4u5NX/W4ahlY13RJpw7SYAKZoKPkrLPwJal22U67s8apRoS/eD8Y2HzbuIS
         waujHmox2aVvdXNqEbkj+5udmNK4q9yVyUavNZTc28zZo/Hu16SRnAyVlHla8XKWhKJu
         EpXEORK8dCa8jcdWs3eZHCbdTPbzPHq4p0Dm0d6i89+zurOh2rliXF2zHGos48mzv0pQ
         IH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVn5PRKZYauBmo37CtEfehoUspKtXHSQoAFqWzuNf1YFipxUMV3G6qUvfWhBiYWJgFozbqQoJGM1X2CjrCsU7ihd6KOI4FTX01jqesNFmhCK0gUqr0X7lSEApEHUhvscZQBR73Yk1uWQHVBiy4+zUYZ1xhuw5N+d+PI33mHO/0T3e+HRAfIRqN47odHkZ3TVucgMRg6TGt7vE2jmAujf0XvwgG+r16DfDkKW5UdS8b0c+oGj8U+IeMvypbNyxXgfC7d
X-Gm-Message-State: AOJu0YzrrOSZRgplx/ee5SMYurH2kf1PBeBm8bCHLG57f+xOXHOJTU5X
	fScLjAcBgOMeXsGK+NkWyS6wOqo2OxnKTa8SrA2EXZz6uP3PXqjnZa/x0Pti
X-Google-Smtp-Source: AGHT+IF3UR4ctJqF4dv1x5CADGAyHth2iWUQp0VMFhr+jpA7GGfWdUhdF8HSTvzfymvymsO0ACuNTQ==
X-Received: by 2002:a25:183:0:b0:e08:5791:4864 with SMTP id 3f1490d57ef6-e0bde465acfmr843983276.51.1722529769878;
        Thu, 01 Aug 2024 09:29:29 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be0e45cafsm8071276.36.2024.08.01.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:29:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65f9708c50dso63085747b3.2;
        Thu, 01 Aug 2024 09:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfPj7FCPOdJVi8VgeeHmStiZQgTXcdwl8IP8ajoeKF5TracoY2xSleOR6e1paCxws/eq5D+ZTMmJE/omWST8lGSDw1rkvKpwbXKvK0tSP4lVsi+I5hKMRdSUeKBlL9HW/S+k1PzUgdrxZ1SKbLinu4wyMGjCP7jfA0X36bb91UpZKXArTcC4GY0NaEMiF02u6tt3l5G0wzQSYSrXWfeIeKUJHvlljf5qvOtvDvh2SHLt5Bv25bG632Ez8FqrQ00iCQ
X-Received: by 2002:a81:8a02:0:b0:627:88fc:61c5 with SMTP id
 00721157ae682-689608712bemr5781657b3.14.1722529769028; Thu, 01 Aug 2024
 09:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com> <20240711123405.2966302-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240711123405.2966302-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Aug 2024 18:29:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjTw1NFaZhNiskiA+BQV68B61H=iwZbeV1qpVdKCjTjw@mail.gmail.com>
Message-ID: <CAMuHMdXjTw1NFaZhNiskiA+BQV68B61H=iwZbeV1qpVdKCjTjw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r9a08g045: Add DMAC node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	biju.das.jz@bp.renesas.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Jul 11, 2024 at 2:34=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add DMAC node.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.12.

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -363,6 +363,44 @@ irqc: interrupt-controller@11050000 {
>                         resets =3D <&cpg R9A08G045_IA55_RESETN>;
>                 };
>
> +               dmac: dma-controller@11820000 {

> +                       power-domains =3D <&cpg>;

Updating to " <&cpg R9A08G045_PD_DMAC>" while applying.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

