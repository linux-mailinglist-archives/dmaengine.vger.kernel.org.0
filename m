Return-Path: <dmaengine+bounces-2686-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C892FBBC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677CF1C2266B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7B16FF5A;
	Fri, 12 Jul 2024 13:48:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5823FC12;
	Fri, 12 Jul 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792107; cv=none; b=VL0H2yhZjWWUD4g72P9ZZKBmw8wAX+PgiAnTFCDhUBQc63aFLIWPFDZkbr9c+3Eow2mlOSe3sfa1UOmdp5cm/gxkdrUdSHlDIsR/jRrCDFATqDgfMo0loAZj9vVnYwyxt7Zz7gk/6rV15Jsde72olddsToFvHE9LVe/Rm6z99fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792107; c=relaxed/simple;
	bh=yYs7MkrW0+QU3QEsKi7sNmspymkEpf3TgBrnpt7kn1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+CMY4OwMKxp4Kfbs8j+f0yYND0sumq0iG/Y83k/LDT++ilZAmKbRf1/nbvSn3ZLI0hUXxjSfZFCH2kzQM40aVpdzOGWoaSfwmftRPEIVN1vou0ABHsJJ+03iirzh1NMe9x1NGzr6RUVgLiRP6xBuLZx2YYZc58VSASs1ullu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-650469f59d7so20977387b3.2;
        Fri, 12 Jul 2024 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792103; x=1721396903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=442BdvzCkNEPOCEKPQXbGDECLpFWinxKnjTci7pd9gM=;
        b=ev01vbGDqCrS42q0fS7XeI9QU1v0GNoIcC7ezufc0Mbvdf/j709IowAZgh5EnnHdfw
         0ChtM6uOKiFSzFG1zj/8VT5MfiAVxUxJ2aNldCKxq7FNYvIBcRj2mljF+9kH6QhIv4q7
         btUZpOuRrm/eSwxh8T3H3gCR8Vxgj8guSFDSHRQHfPKdfyxs2s0H7Utl+Qq5jc7VyftW
         F3OH91edlYW5ygHhFq5RBQ0uUx4tqrwUnDXk/UxqJviR5l5zIBnm9Tf2bHKwSGZvQK8J
         SdPfF5cOlNCExv/Fk1r1rNaQz7biaM4WG9viOsIfyqsny1zUlelTmJ5NgkntYi1na4If
         KDtw==
X-Forwarded-Encrypted: i=1; AJvYcCVGsKZyywnLzmRNCBX63JhIdm0j/OAmktny1pnJgOWNJmqsXgsHx0aRAKTpzxk5JAPbrzKwGxZ1WF/jkF43s9yd+R5EoOrANVjdWgG4nsgJ9bbp8J1ljRyWserCUQBy1MbYQ3lFjhM3Tf/eIF3MJbZpo03si/lAuglQHAdZnkwI3PsvCSlBTefYrFa6VnSVV2SDUjoondM44ky979gIk35qMBQGL79679V6uZEb0tJcpYX2eVTdc4WI5U/lGgvkr7M9
X-Gm-Message-State: AOJu0YzJOvO8hzC1Jbzok5o9lo4cdaISLiBx2R5vc97DPCRmFzn8LlFH
	f5aSDxGC9V7acODwptOJ6JkIVS7BY64l/c7CkwDSxKSbGoGugsublgG5DfSS
X-Google-Smtp-Source: AGHT+IFFB42VJP8fv6OfeFMKry7hjXAB/2QigIi6hGKgTuUFG4230MziGertmjharB1YUmo7HubHxg==
X-Received: by 2002:a05:690c:45c5:b0:61b:3454:8941 with SMTP id 00721157ae682-658f07d74aamr152888327b3.43.1720792102817;
        Fri, 12 Jul 2024 06:48:22 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4d2ad85sm14943267b3.41.2024.07.12.06.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:48:22 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-650469f59d7so20977097b3.2;
        Fri, 12 Jul 2024 06:48:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiK/33p+YvTqqY7cX11H+cJjJGXSXa2erXOxErAa8HTvB/kGL03fKHu3ET5qn8U4ZFyT4r2qv/jSxyKC7XeDhCzTyMPYyzhHYS5LWJ34rglK2K493JLqZAXDOgME3Mo+FGAHbfnDeLbjKm0EN1RJemIZEQ7sR0Vy5Dmsj+aJG60DI9zRjGGwKo4mZ4KbHCcPFaZIHRZK9TSZWWJgYV+Wk1pRZl5hwrBzOg+Kb9bG4MZbA0Ya3lnOWwRxHOvWnG/pWC
X-Received: by 2002:a05:690c:7442:b0:64b:9f5f:67b2 with SMTP id
 00721157ae682-658ef24c009mr138713557b3.31.1720792101940; Fri, 12 Jul 2024
 06:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com> <20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jul 2024 15:48:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1hqPeD91WhcY=JwUho6suwE1gRi6iWdOpYGvchioJLw@mail.gmail.com>
Message-ID: <CAMuHMdU1hqPeD91WhcY=JwUho6suwE1gRi6iWdOpYGvchioJLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: r9a08g045-cpg: Add DMA clocks and resets
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
> Add the missing DMA clock and resets.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.12.

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

