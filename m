Return-Path: <dmaengine+bounces-5940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761BB1A1DF
	for <lists+dmaengine@lfdr.de>; Mon,  4 Aug 2025 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E014A3BFD71
	for <lists+dmaengine@lfdr.de>; Mon,  4 Aug 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A0D26A1AD;
	Mon,  4 Aug 2025 12:43:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6F2673B0;
	Mon,  4 Aug 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311411; cv=none; b=XBXIVslJyMislR7nYZoVgMOmBRNh0dX7p9QIg7DxRqlLQdnd6fye9Xo3G9D10aUNfrOhiFz4L+ydPYpwbEmFooNf9VXbPupzyhLRMPr94u2pXi4SiacxtBRTAtW2SO2x0SmE7Ev3pFhFDNsdAUZ2PNrqH7dCN99AgCO6won19Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311411; c=relaxed/simple;
	bh=AwIB8d/q3k4NIHWqWxhwujek8W+jlfHNccY7uEjmU7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJDagDkZZoHuJEa5+V6fyqvVYiyyrCh8e4AMGmkNUsiGqadZ8y/t9HKUhJjXhULAi/ysFKmUYS4JEmTv7ivrRxEVC1RguQqYWqaer077u8RmMkUINM4Lw7PG1IiSvLGxwVC/tdaZ92Tt/Zt1nveUoRgS0ExvAKUfxAnfbwRPAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4fc042790f1so2154870137.1;
        Mon, 04 Aug 2025 05:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311408; x=1754916208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+ksWIFzKcuowT/35PUUtmV4Ltd0ZzS0T02cXh+GQLo=;
        b=DIDUELFWNsaVhqwTdyshBp6adSMvAATYCF60nfBZPM0Zc8Po1l1b36nSUdVWaM00QT
         Epb7JIMMIkOTC7ZWwZoqKzOqT9QrMZlEZqT/sJ8Zx9Gh0OVg3PCqI955G8UIFl3WXTZV
         JH+aU68yFa6pDR7Vcb7LICiztrbmt4x+YPqRgGNtSE0fp10eLtO9Si1rXmSVErHQ3enx
         ahvg3blq5GfrYuq8ihjTyBNH0fMcAGkycPfZD0CyFwJ5qQttTIa9fJ7BzmTP0/5DJq+a
         GMvQpRxT/P9QQXmgAqGUzT71Ug5O9t7eILbb655hUCDzmngBRYrId58WiGG/TBZziXiX
         RV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkU8A7JpOj/2z1Iy4vpQE2qoFHiuiZcx86XMylKX9kDRyeUhZdOe3sOXSXxoDK96LTwvXbRop+erKE8XVBn/a7q04=@vger.kernel.org, AJvYcCVljvQ7r1D3LeFUZ0bo0st8fPdZjslSOeLp0J3/qoRgY0OvzadIFGMqsMBCoqmnqYKHg74rOUl8zJtv@vger.kernel.org, AJvYcCWMB5OoICEFwctVVj8FdQFPHMN6nsVNzgfGQvBsXpFvKVNi/AWFi1BW8Qqfc4+Zk9DthZuEaL7K1FWf@vger.kernel.org, AJvYcCWyQW6EGVLD+mL/TGAVaPJT13ukzfU0D9uT7RIutY6Wd3OBvd4h1DuTj1dTw41+xtcnVygt7VHy1+w2@vger.kernel.org, AJvYcCXzmUGCyEgus5k9JxN4O+NmufDFYr/Oec5toOvGudg6Mr81sTeo+r/olLrVEzEz9v+pEiDtiGjUhi/iEKnh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywux3B4ZjpAcQT5a9bgLm7hIQ2/y6B7y3eYSusveBt5V4bvQdyY
	VDpZ6USy3b8Rr9gCl4bxMVbnI2zTMrMh3XYXEWSixfAN3MX25/zSDoq/4nT4M+iN
X-Gm-Gg: ASbGncuOgqtQOe/EOPYrr5WFocKP7FYRuRFPUyGQZ1KPE7nxMaplOtn2M2dIjBNBoxS
	TmiWUSmGnCQfJDbpDEoEoYsowUuLulK50puo8tBb/pSZfRMxx3d85WHsb4joifuWpQm2uvIX0SD
	QlkwEj0N2L2pXXtS195C2VvuTJsCRUpTDBu4Cemu49c11LICQzMVweXq/eg0DYjDaM4n6It7C72
	jc0OMry7dQGRePCtHD0k0GfG5pqnrLiOUAsmGq5igSCy4tBtQX+LHqNOhqQOxFGXZRIZ8btC6TM
	gmLVJyZLsR8uaSE29+IhkS8cyc17yPgz8oarQsnTvJSRTjSJobZYTuuWl7Yg+H2aRFzzI8B/vR3
	Jlh/gLUn97v3DBP50bsLZDFpKw7dqAfJf4w+odiL2Gqj2ZceY+eH+eYN4zV2l
X-Google-Smtp-Source: AGHT+IGTgxWsBjpTpbgCKbt0cM8L7Gwal/1XJCom1WhuwcIKr8hxJtHYSss+lZ8MbqSqJlVUZFZKbA==
X-Received: by 2002:a05:6102:54a1:b0:4e5:ade7:eb7c with SMTP id ada2fe7eead31-4fdc2957724mr3200743137.12.1754311408155;
        Mon, 04 Aug 2025 05:43:28 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f3263d6sm2209773241.5.2025.08.04.05.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:43:27 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4fc10abc179so1958281137.3;
        Mon, 04 Aug 2025 05:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgJpfT3qTASCAUSdTNo5b1BsU95MckWRTqMZ0kNg2+zM/E2Hjn3VDgzxbtSGmNMKeUH/GMARXNTDAk@vger.kernel.org, AJvYcCV6CHctLjJ0g9PQw7GdwB615pAc1liny4npjS4f/4HXjXUB17+awAjfhiiXE6LjeszxkkhYEQfuMcSz@vger.kernel.org, AJvYcCVJ2mBBfPZv2Z3NUwyPIV6DhiGaDBVcJAoyupYEguGLD4btG2DkAi6T9rhFzt/ywd0/9uENQPjU0bB5q+UyrmtkyK8=@vger.kernel.org, AJvYcCVtfq9AdnDHdocCTjXxD2wVutr3Bll/OINC9BoQPlknW+OFgJ03oTMBLD43XumeDGtAD0So3vzDygLYFBRy@vger.kernel.org, AJvYcCXjimYLQP+0NvQkw81Y4Zfyw8Y0PB00Tl0vWVvJlSf7qonRqbVxRPuR8BvLnbhpgaMAFICj40qk3h+I@vger.kernel.org
X-Received: by 2002:a05:6102:dcb:b0:4e4:5df7:a10a with SMTP id
 ada2fe7eead31-4fdc3e179d8mr3547288137.16.1754311407222; Mon, 04 Aug 2025
 05:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com> <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Aug 2025 14:43:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoqSJEzEZsNkOtpDwCytQHGWxS4WBfTiJNOdC3v3ACEw@mail.gmail.com>
X-Gm-Features: Ac12FXxmuJu7VAAwl5EVX-3cOsTXnZkIIiE3nPUF6WDs0EYHBcEOAFk9RR_CHsc
Message-ID: <CAMuHMdUoqSJEzEZsNkOtpDwCytQHGWxS4WBfTiJNOdC3v3ACEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 10:49, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> The DMAC block on the RZ/G3E SoC is identical to the one found on the
> RZ/V2H(P) SoC.
>
> No driver changes are required, as `renesas,r9a09g057-dmac` will be used
> as a fallback compatible string on the RZ/G3E SoC.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

