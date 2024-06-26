Return-Path: <dmaengine+bounces-2540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80425917BA6
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B152D1C2444A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906415B97E;
	Wed, 26 Jun 2024 09:03:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA313AD11;
	Wed, 26 Jun 2024 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392598; cv=none; b=MuBB31mbgQikoKn2jvMH1YhknXt7Pao5HxaPOb8zpmyOKTL8fbuecp0MVbXrfxTk0l0TpkH7tfwLMpkQcipGDWD1L3rKiBvZ1ipakPQzmE5YxoILNgPalOFxlsNea2LkU8MRFZ+bJUm3ewhPrbOrUhZG340AGfUZMrTBs4IRZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392598; c=relaxed/simple;
	bh=+uAQo1kpc0sdXv8OzH4qsb+avgPuT+WnRZfCMKpvkP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgunTeu+6/4vT3XdHfZ3UeFG4Iaa3QdLh8epfTyKQ3aGDJpesgBbqyeqsRmkeDwJWk0C8LEZ5tWTQnVptzPtF06/dM9QWpATuV9G+NX/EGRWODr8jwB4ciLRYzH5xOCf++z45DPGkiQQnUYhyyDyaGm2T880lKSFKiP5hgK9gKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64361817e78so38415617b3.1;
        Wed, 26 Jun 2024 02:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392594; x=1719997394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Hb7alC+wUdx3aArLM3djYbFuoOGjIM8R4U6uD+biRQ=;
        b=QCg84lYNUyR0juhbL6EE1p0YkkdpB4QsFgrTlWK+85mci+rsanOfb9CKBS1t0e79CA
         phBROH5uXbvJZcJN4PFX4o+pijsL2SWw6KhEj1raX87uUpqY2Fcmq+h8GootFCaMPwWl
         2zPJwiClYgoZKrO57aFvccWl21dWI3b6RnL5qmA8lC6EhJy1FmZYv+5psg/frG+JYT05
         TDYnbLL/rzOxmf8jfliizo/4an+eXRAaNVUMuCWXLwOgmFhZeNAi5jB2VPtUm2Pn29xS
         wDR9reBmoLc8brTORy/8bT/WZGClrOHCJEq/DkmHbR160XpC4F+jesMbKZXOh+2XSgix
         OG1A==
X-Forwarded-Encrypted: i=1; AJvYcCXZj2czxfNsRIyOc0dfrATYtlDNxvAunm75/Jhip2QAmkogFpWUjwcwE/0ljBrFsGYaJBfa8nhjZp10m0b0UqI+mdjxJPmxK1riaQV9LdSC5UC5seUe9Ko0Tl36iHZLYN0sBR3vGu+my4Ml7IE=
X-Gm-Message-State: AOJu0YwvWrROog/Oc2EF2zbK/SJLQeU4DiKMz6q5eYuFsI/sr0KzTUhN
	e6dGbkKtv2ErMbn/ibT7MUQq6RaOgwJXntNc/lPMxiR1naVfPzGfCndNMH2z
X-Google-Smtp-Source: AGHT+IFT9Qcmm3SLkql1tx7AIXGuRGGClX3orKJhBhaVnL11I7FDNI8Aqfrl9nOve0N7cj4mj8Ekjw==
X-Received: by 2002:a81:7344:0:b0:630:163b:4700 with SMTP id 00721157ae682-643a9a0254emr100066587b3.8.1719392594593;
        Wed, 26 Jun 2024 02:03:14 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-647b0836accsm3388907b3.87.2024.06.26.02.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 02:03:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64789495923so12642677b3.0;
        Wed, 26 Jun 2024 02:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwLRsCJ/45zwf8L2r6KGxt8nOOz/v+H06bfJQrCZpJSxfyS2ESekl5yFMdsg17GiIi9rldCHltNBr3lqYWan9cMVF3RlORwPevapufXBkAb8P6WZPMWkgza65GcxtWGJgNyElA+B3fKazwWTg=
X-Received: by 2002:a81:9109:0:b0:627:88fc:61e4 with SMTP id
 00721157ae682-643a9a02542mr90746817b3.1.1719392594078; Wed, 26 Jun 2024
 02:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625170119.173595-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240625170119.173595-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Jun 2024 11:03:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX99_NMgRVDhVgp-GTec506nYntOKc0a8d2ZMHaRVFvtw@mail.gmail.com>
Message-ID: <CAMuHMdX99_NMgRVDhVgp-GTec506nYntOKc0a8d2ZMHaRVFvtw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix lockdep assert warning
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Pavel Machek <pavel@denx.de>, 
	Hien Huynh <hien.huynh.px@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	dmaengine@vger.kernel.org, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:01=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> Fix the below lockdep assert warning by holding vc.lock for
> vchan_get_all_descriptors().
>
> WARNING: virt-dma.h:188 rz_dmac_terminate_all
> pc : rz_dmac_terminate_all
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

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

