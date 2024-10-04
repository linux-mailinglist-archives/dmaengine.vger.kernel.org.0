Return-Path: <dmaengine+bounces-3265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4869906B0
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7C2865A4
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592821D2CF;
	Fri,  4 Oct 2024 14:47:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9E21D2CE;
	Fri,  4 Oct 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053223; cv=none; b=dscqaRCfDbDWRoDfDKx/aB/ZRpAkCbfnNhOJ6VBy4SDK9yCQU+OoLs9d7moGaSKSZwGdzMdWUmogrU8oJMUPxaktF1iQb18jGBk67CKwKvL9cTGxaBo3ftGRPgIA0qnCR7cvjoDA+ldnVV/+eGOy4xVqdz4JPRvuuMtF1B3eWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053223; c=relaxed/simple;
	bh=fXVXU0yrJEXsQ8rTipPZbIK+5y9WrehKar+eQfFeDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p20xskH20G+4oX7DwvwbL7EXhRrehdt1/qH/OWB2FojCAKPaxK1hUyfTX60OeuXYkb8PNrUGPsPV0670xOY0p42f7T0c95al8dynluTk3H2J/ptbShUKVO5pKh0R2z/H97uhkFfazo7lvtPp5ZsETXPpvLw59ctgwCNTpAdwTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e255b5e0deso18139587b3.0;
        Fri, 04 Oct 2024 07:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728053220; x=1728658020;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FORJaa+PC6XgWmZ3+HuLQ/PUAtT0bstVrHUADd2wy9o=;
        b=T43OADgkIVrFrm0htkLmrEDn0ZFqm8kHmwuhOz2Y4KAdI+GvwKjHW7UNbGJ8MKgOmm
         AvyTOKvgzmu3eJ6WCS2ABkuopHFqJy+6GecWLH48TP+M871fni1v6ruu6fJF9KOtDJAZ
         hsOiXzIlilPb7/VP3DUO0R/UJZjU+zHxwAYZbJANp5a3zq/jauYa3z2YOyVFwpkIN00l
         lPCtVLZrT5mE8MLtnM1azL1wbe0GAj3jMwOf70Ph1OnG0fOJoRyztFS7j/clPvvcEbIL
         wGG8nsqO6BJKYgBuOyJAT4FUsMnzCtkMch4vDc0105xJ97o1Zj38PG2qbEcj9w1GcNcq
         XoEw==
X-Forwarded-Encrypted: i=1; AJvYcCUy/d3yIexxxXovAElqzjJARqMh4ZIiHhFuNGZZ1HSeg/j8biNyaBdJUJ/Uo6SpMNAHqWsA3NoeQ/uNnki7wZdpPmk=@vger.kernel.org, AJvYcCW4fO/k0Oi2jP99SXuZuBvBfCPC3ApOVvyoUXR5UVm6Zr+Scyr54XUolvpr9Tv4k6PSv0LYNb/5RuYp@vger.kernel.org, AJvYcCXw26nrBDzrQkkwpgC7s+FbX9InY6v1ruTq4QWdqEx61HvAxz76OX0V4x5YYmwj5bNlRlg5BMyTJDV4@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbAPZhbfFpe3UYmjjtjS8gJryyZDPe/m50F7BmcQmFPdzPg8Y
	8+0/kEm9l40U0mEaN+5lsRVY2VmRC/a/mEa8AENcxQrMVmadETL2vEmc9i3bIUE=
X-Google-Smtp-Source: AGHT+IERjudnJ3eywXofwnIcobV75dWLRRY8407CE4NURgtqgi7gc+We8AwHuPMam8y17BNErqzfQw==
X-Received: by 2002:a05:690c:6ac3:b0:6db:dee9:f6fb with SMTP id 00721157ae682-6e2b5367883mr52637687b3.11.1728053219684;
        Fri, 04 Oct 2024 07:46:59 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bd1ce863sm6449927b3.143.2024.10.04.07.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 07:46:59 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e255b5e0deso18139217b3.0;
        Fri, 04 Oct 2024 07:46:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcJNgIpKOSjCyc5dh4SsjC0k3iy6QlyiY9froYZLekQ1WOyjmcYPo0YxQOM5Gj+qwzMtVDKfvNZviJ@vger.kernel.org, AJvYcCV23lhZ0emcAgsWsA9Bh1VwAvUaO2dGMY24ETG9qmtVjoj4Du5pNHOkQI4JfxlaQYfTw/mHSMiF6C4acUG+bTnr7OA=@vger.kernel.org, AJvYcCXz4Y+xaHkNrcts9tU1C69ZbgTvCFY/sxvsnRiiPRbQH30pQHzgHl+cZPyQXLvpxxkDDiIgxVSpTCoo@vger.kernel.org
X-Received: by 2002:a05:690c:6185:b0:6e2:2684:7f62 with SMTP id
 00721157ae682-6e2b534de12mr49693767b3.8.1728053219005; Fri, 04 Oct 2024
 07:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <20241001124310.2336-3-wsa+renesas@sang-engineering.com> <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>
 <ZvzqPkUPmurHf-fu@ninjato>
In-Reply-To: <ZvzqPkUPmurHf-fu@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Oct 2024 16:46:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzCYBn+MPz-tdcP7wJRkdQspU0ZmszMv4Uj7VWpTYR4A@mail.gmail.com>
Message-ID: <CAMuHMdXzCYBn+MPz-tdcP7wJRkdQspU0ZmszMv4Uj7VWpTYR4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Oct 2, 2024 at 8:37=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Does not require or does not have? What does it mean that device does
> > not require clocks? It has its own, internal clock oscillator? But then
>
> You are right, it requires "clocks" but not "clock-names". Seems I got
> carried away when removing the reset properties :(

According to the documentation, there is no bit in a Standby Control
Register to control the DMAC clock.  The driver doesn't care about the
clock or its rate, so you can use P0 if you want.

Anyway:
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

