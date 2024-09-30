Return-Path: <dmaengine+bounces-3241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B198A84F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F71C228D4
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77029187FF4;
	Mon, 30 Sep 2024 15:18:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C320B0F;
	Mon, 30 Sep 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709522; cv=none; b=usgXAL2JPDqDoanIaNcJ2+ylk00lwaN0DxwW2pwhTE5o/0XiC0qv2YNrpFErSHqTuDK1IwiQJDDpDWgyRq0V8tETPoMQgVBNoYRrmvThDW7t8Hc6ON+KmaxYVZIBF9ZRxZvPH4IBDv2D0XYR//m0gLp8GIMW9RTZBTbt9FVnjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709522; c=relaxed/simple;
	bh=kwrBPpdJTUt+Eyt1rgudzzcjjYAGqYuG2lb+789Z/Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYbanmazWnVSgpbrV67M0DRd/9f9kT+KXobYWTX94eCpxWB0IW2iR9D7mgOHwcQ6RjzI87Ri7Znk2yeng8mGhnmXQBDVNH1uJHomVVHGgGojVCR9BxhhLK1XYnGutA52x5E5d/4mGRwMq34QE1XRyJ6ItBCFlJU18wka7i6kl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d164854dso3652108276.2;
        Mon, 30 Sep 2024 08:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709519; x=1728314319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qLjXIFOvxfXI8WNtNjpNj1QzNPYduZSH+sMM8qEjWI=;
        b=La/3CVkHvlsSoJ7EDoW09BYHs6FM2oRiWl4usWcWd1jqMX/4lboJe95Suar1J8sl+1
         vEP+NLWCRD9w7636UvybIA+Ob0Gn2ksYGPpoZiBv/vwBSgVdmBmb8bBv79kPncE3Ta0S
         TGM9BB3dPdasgI/rbB4IWeo3CpMiNVS3QU0rVNx2WwZ0p/RowXTezL4oTxBycOdmFZH/
         pK5V+pODwRDktzPvn4vHUOcdOQuepcRma9yevcIuuN3rdiTtmSNtgWm4e724sKfsnww1
         sJ8/xTVXqOjlw+9xv0Ws+qjR3vGQVYgya7zy54yJRXcHOBuJO/W0kPT2zrkPBsn0QNO6
         vpPA==
X-Forwarded-Encrypted: i=1; AJvYcCWpo5fRM5Js5aQA5zuVjQ6EQuh1sSNcmwFxD+swYzjUbBNH0Wtq/33uMndkqkBZJjOm5TBe5DTcNz6W@vger.kernel.org, AJvYcCXwAvGs6oPPJET7RGtsm+dw3HQ9ubYCP6mzW4L1VhlEP2k2Ul84USGQTzlf2REgmdkuVvwKQ8ovsw21@vger.kernel.org
X-Gm-Message-State: AOJu0YxczX8cZT3U/isLQQ8P0Aj65hABocH+VXyhXjxmglxfP5XRE0E3
	QA58sUn/Ne68uL5tP7/EQ9TQUfSUe8vL9FCrrthXIGfu97B76seFbmjxcdua
X-Google-Smtp-Source: AGHT+IEb4jBvKR1SgGtHG2Up90mMYY93ul1WCfmuPhfwVZOOPe8FvlMegI08+Nth7KR1ycohvS9e3g==
X-Received: by 2002:a05:6902:1022:b0:e26:46f:967d with SMTP id 3f1490d57ef6-e2604b3c107mr9299203276.23.1727709519031;
        Mon, 30 Sep 2024 08:18:39 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c31679sm2296923276.58.2024.09.30.08.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 08:18:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e214c3d045so34872247b3.0;
        Mon, 30 Sep 2024 08:18:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzHzaX6gy79uZG2C0SUVeIMFGrO5jwVIw2I2ZuN8U+OXp+LnEhVoWoLLfWWGlfnZvWmJ7lFv0w8C+S@vger.kernel.org, AJvYcCWb8CeLmdkZb9v8ZQV25R+4Zguqbqrc/PzNQhcQUAz4GO0QtUnrh4IkD+a7QVxpnU0/48cwaS9T4/2v@vger.kernel.org
X-Received: by 2002:a05:690c:102:b0:6ac:d0ac:f74d with SMTP id
 00721157ae682-6e25426fe19mr59332797b3.26.1727709518681; Mon, 30 Sep 2024
 08:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com> <20240930145955.4248-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240930145955.4248-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 17:18:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWa7QXU+Ka6FipF6sbcn=UOnVtYa-+an4F7thprNt6ALQ@mail.gmail.com>
Message-ID: <CAMuHMdWa7QXU+Ka6FipF6sbcn=UOnVtYa-+an4F7thprNt6ALQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for your patch!

On Mon, Sep 30, 2024 at 5:00=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document the Renesas RZ/A1L DMAC block. This one does not require clocks

RZ/A1H

> and resets, so update the bindings accordingly.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -4,18 +4,16 @@
>  $id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Renesas RZ/{G2L,G2UL,V2L} DMA Controller
> +title: Renesas RZ/{A1L,G2L,G2UL,V2L} DMA Controller

"A1H", or perhaps just "RZ-series"?

>
>  maintainers:
>    - Biju Das <biju.das.jz@bp.renesas.com>
>
> -allOf:
> -  - $ref: dma-controller.yaml#
> -
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r7s72100-dmac # RZ/A1L

RZ/A1H

The rest LGTM.

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

