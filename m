Return-Path: <dmaengine+bounces-3267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82237990700
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE40EB226B0
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8501AA78D;
	Fri,  4 Oct 2024 15:00:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C61AA78B;
	Fri,  4 Oct 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054039; cv=none; b=DY4+imlJkZt2Qen/LTO/J8EokViCKACj62I1/QKID1GFj5XvuGY6q9BaTpg+NbFsbmEnUmpSGAV+815pPYo8T4TUcthrd52CfObYS8O/JhLttPxyNZ91UiyCsOYg+lGFnBqQUy4CN0+kJy3ApiUWSXKco5OgRZOXGXCwJ5ChS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054039; c=relaxed/simple;
	bh=GwOYGJu3eX6bc33QqrPmR+QP+pyTPbVKKg5pRMr5lmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYn0xWzus0r77O5lXnHvNWm2OdH8O3AtZL2s/u5JqhTaRRLbgKi2J6wilGFBORknHU2dzCD1s60JC0u13UCUnnff5KgNlmXUacp2XlkPCRp4dtF8PWlyQoqyk5CevSlkkOX19uXGOUAGW2NdnHsBYokjmodtwsJ+UWYaRbTRdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6db4b602e38so19105337b3.1;
        Fri, 04 Oct 2024 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054036; x=1728658836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK6G0mL3dSXB4RzZkaceGmbokQDNOiEtUOfSWXlVgx0=;
        b=TdNZvoZtFbzZhY8/K/1cv9KJyk7vGjyKNMQ56vC4zKeXIEkiA7U0E2M7sFHXhpSCZL
         Qz1vh9oDZUdAZcvNbWnLyDQpT/BKxlBemxnksYIOMbqzZNsrd779+rN6ncbv4l/3eBF6
         KuxCFP7lhR3oLrG5bM9O4ztSCkfN0Fd1RsN9jIxCTcY3EAW9SHadh7kUtr8Tbf4Yoept
         41T9j1ju5OITJ0WohnjYoGIyK/g4udFwt+HaZySMUwQZQ0UsDpqbmQplbF99FYsZIwB+
         aO7OyIPlg80566o9dU3dwXeQtR7ELWqvV4cdZXakjko8kKXMPiXF3M7mjeIskLLk4EhO
         Oiow==
X-Forwarded-Encrypted: i=1; AJvYcCXyvtCihzRQHOe8OU7WNXrfK//+XomlxxNifYgOokJNw1UaqEmHO4i/ZvzOtrIFWdGLmShg4XzMLE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4PO0jxB+6xX/PIzuuElh8CI2zJcolKODgO1eoieEjEKhb07H
	ZUTyAIndJywkUarQLhc2P1u+Em4JhtC2c7qU7a07QgoopMIU3OADDQuUMau6/8w=
X-Google-Smtp-Source: AGHT+IGZ4ryNjvQs/TQOmzRvIhYO2Sci1B5fo/6znHxqhoVCqU0KxGXyj+ZbGHgU/g0XVFVheFrh3Q==
X-Received: by 2002:a05:690c:eca:b0:6e2:11e4:2f58 with SMTP id 00721157ae682-6e2c6fc7e0emr30849697b3.7.1728054035568;
        Fri, 04 Oct 2024 08:00:35 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bbbb7838sm6758647b3.20.2024.10.04.08.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 08:00:35 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e2c4ffa006so11168627b3.3;
        Fri, 04 Oct 2024 08:00:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUtE4jfU7kD+oefKk/a9YQ+4D3YpZYSwjqdlirJ1Qy3TghlE5lZ16zezpgFyDjHNhX71058brwWY0=@vger.kernel.org
X-Received: by 2002:a05:690c:3407:b0:6dd:bcfd:f168 with SMTP id
 00721157ae682-6e2c702501amr22265427b3.18.1728054035195; Fri, 04 Oct 2024
 08:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com> <20241001124310.2336-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241001124310.2336-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Oct 2024 17:00:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcMOZQ8Jcq_j-onqSHx5grBjtgiK1b2usJd+tnoSVTfw@mail.gmail.com>
Message-ID: <CAMuHMdUcMOZQ8Jcq_j-onqSHx5grBjtgiK1b2usJd+tnoSVTfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for your patch!

On Tue, Oct 1, 2024 at 2:44=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Configs like the ones coming from the MMC subsystem will have either
> 'src' or 'dst' zeroed, resulting in an unknown bus width. This will bail
> out on the RZ DMA driver because of the sanity check for a valid bus
> width. Reorder the code, so that the check will only be applied when the
> corresponding address is non-zero.

And this didn't trigger for the single channel audio case ("dma_rt"),
as rz_ssi_dma_slave_config() always fills in both addresses.

> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

