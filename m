Return-Path: <dmaengine+bounces-2765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD894501A
	for <lists+dmaengine@lfdr.de>; Thu,  1 Aug 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FDE1C211DD
	for <lists+dmaengine@lfdr.de>; Thu,  1 Aug 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4A1B3F33;
	Thu,  1 Aug 2024 16:06:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107C1B3F31;
	Thu,  1 Aug 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528389; cv=none; b=mwXi4xrsLQAO63nWy9HVVhP+HIPmszQVg60G9dEMPY015FuAX6P9YwOLBXiHtAzYFmg+u4BQVTanwWJhPKprirNmAZQ8EoS0bBtWCNpVafWqtjJb0BFTA5rjnU0J9ODL0gFA/iC4V0S1wQjRbqvD/Z2CcWMCjSe6yJ/UYjhQuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528389; c=relaxed/simple;
	bh=WTvmxAUSQOJQNm1qQg6JVs25focSaJq5Ruw7UmSLsn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gpa2tkj1GCw7N5F5PNKIsxOYblq77YDBypKlgCJI4X9JhCNL+Q8c7Jf6cRv9SXpYqMMhehF0c/pT0/+8C6aR/fK5ebzjNkKz+s9FTLRjvyj9dGHl/nUUME4P+g6EEF6WfVnVvDym0+IkydjuCJPYcFMAj+jr7VFxtTRhERIHGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5bb03fe42so3841589eaf.3;
        Thu, 01 Aug 2024 09:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528386; x=1723133186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIiBHUVSVQyeAx1VP1+X4MP/YScMCPDDrn+HcO4ZZKA=;
        b=gOxFkw9/cqXJFXKv+HVSURbl62G9ggRQMvA+WJOLt9x3Y9bKzBa0h0sOF2NRHJ3YPO
         shFhXeR6b6kXBLBcLzCfDlrvTo19/H7KXZi8LzoNPey3ml/jWGyns/N9ib8UKbTCye6j
         YQyUkuQvxZhUUL+eDu0oqYy2TSHnTeiOJ9pfSBT3eVxqgP6pGiDtqoSkNzw976qq0v1J
         szI/USxb93EIJ4aOOEsdFNK5CaxGWah8Qr5A3lZYYDoppW8TQUQ0tayhYiJfCHe8jbKi
         djtzeADNPKBWF9HW4WX/fRYDb1mrv5wT7QIkyUZ7bAzvz4Nx/mgtlzDkVSrRWlXtjP6t
         +LkA==
X-Forwarded-Encrypted: i=1; AJvYcCUkhD7Yy47m6WkZhLmRpBOnDG07GKtgJP8Ss6/kakv2SZ5ZBU57CNDmmsB0H5aBcEOfoqpne67qUa1RqtmlYOkRByHirNXF2kOR8BUo01WRf0Mp6OL9AIyqa6z8qnI5Vu6tF8SIpMb/rSsX0Y3EZXrZ+Zizp6xtLr7F/hyok2mOiFhloJ3JW7/qAPua34Bvse60r1d6F6lhVqn6mO5D8Wrm86CERa4uo0bhhCHJUIbeYktVqJcilPojBPZusbPqrLrs
X-Gm-Message-State: AOJu0YwbP2jeCUdWM8tmACfODvbAyK/3aFjCtIGOea7cQtbjdSI7Z79I
	xlrjdiVBD7c9Mkzzf3fyeQoGd9DPVgKTMeX42mx27QHYRIRHjPxM9uRvo970
X-Google-Smtp-Source: AGHT+IF2JbBm6I4mR51gQXeaNLd+KpJcmIcD08dGHLVWebHdn9zXCYoUlIeYEBo9ONowN9YBffMnxg==
X-Received: by 2002:a05:6820:810:b0:5d5:a69c:fe68 with SMTP id 006d021491bc7-5d6636e24f2mr737243eaf.4.1722528385917;
        Thu, 01 Aug 2024 09:06:25 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d76261b9absm8625eaf.44.2024.08.01.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:06:25 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093705c708so7284545a34.1;
        Thu, 01 Aug 2024 09:06:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR7eIPMZx1a44ZEKFPq18GOhMa4o38AslDrKFPnIdtatlN6oQoaZBx4RCWEyw8nG66PiGS2OGgsV6AjhvzgXdmTFfTKwrLBIPMFMp6qvlbD5P7CBesAaKNUpRxalsqbRZYw/j3T6CBO1GDLb0O8eQE4TWmv1yxeUEkMILPCVWntR7QRLEpGy9Mi5qB1xZdDG7t9dQ3G2U/3y74BotGaNXFw0BKiew2WQUKE3WHDWTZbddHonGz50ZMdrz7vgoeNtqk
X-Received: by 2002:a05:6830:390b:b0:709:49fe:5a31 with SMTP id
 46e09a7af769-709b3214010mr769422a34.13.1722528385150; Thu, 01 Aug 2024
 09:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com> <20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Aug 2024 18:06:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWerchdsjuhHn+Pr59UKGLmjNVSPFbD7jBK6G1XTaFwmg@mail.gmail.com>
Message-ID: <CAMuHMdWerchdsjuhHn+Pr59UKGLmjNVSPFbD7jBK6G1XTaFwmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	biju.das.jz@bp.renesas.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:34=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document the Renesas RZ/G3S DMAC block. This is identical to the one foun=
d
> on the RZ/G2L SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

