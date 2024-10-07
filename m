Return-Path: <dmaengine+bounces-3272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72D992613
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01F91F236DD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE5176AAE;
	Mon,  7 Oct 2024 07:30:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F7184522;
	Mon,  7 Oct 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286236; cv=none; b=helLB6d2LapofAp0w4N0/qHc+HPkI+fo3JanKnI/BZ+gvW3YNAUhAK2KdTFupsrqIw4zwVU/OFdW28N9wr3p/S1qHy8kQX5LY1Y1jWcVMdSAQsyX7lpK7Hx+JDZgEmONqJQBeJusnP25DiRx6ZeUFOgGPIRlu9APUfGCKGx9nuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286236; c=relaxed/simple;
	bh=QYJ4Pk74JBvLeTt1g7Zq8N+WhO8Svs4yuqzbIbWPwoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrfQIUt5aARwNayZXZ6wBlPuhq3bXn+LSu885w4Nt2Cz9CDD4stY7w/y05inugZBqxbEO5JI7OXg/t4yi9Gh9e3FZaxVhTC+PgCuSms5gjludlPk0xTSIx142658//QjDVJgx0UGpidDgzl1coclZXAnl/RFrJSbN9/Gt9A9l1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3116016276.1;
        Mon, 07 Oct 2024 00:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728286233; x=1728891033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXt5YyE/H8U5pS85ePoCsy9Z/yFe0vEQxA6JHvHG1Zc=;
        b=YcoyDlVvbnMXB5zRVqYJ6SwBJFgWNs60g6DIW2Cr9Pdup1K84t7g9bK2/JI7JZf2fe
         3I5zsq6yHJIg3BsiEwMqE4o0fH0dBrnZrnjjVQkweYUwARSHod6PrWxyY40mmvYkg15t
         cny6QBFE4ZyJLNK8Fpbransl6LgAhiO3LB9dVSt/MQpH2zW4Ma/p0jp1kbTYsUa1znMb
         JSzGYS+Imjwt0w9UxhIjmG01aZNrOTVfC6TzfP8we0lUWAoqZKd66+5TBCyHLcOnFh5x
         36b2XsINSvfjI8OG+9+tImByUGGTM7jEiLxn24xJMAIaMex6BOKnNZMRU6cHMCLXqlaD
         bBqg==
X-Forwarded-Encrypted: i=1; AJvYcCVHk37R5pdc4jVnbjqSh423HkvPX/Nsmd5zkTJhgQjGokakSXiKNcOfEm/ZxnCAySBUNMH9ya2FqOWn@vger.kernel.org, AJvYcCVcTtzAbwJIVjUzJKSxyyyAeKjkfAeoaRcYT3KMTGfaMojeQ24oxtBVyoqzfgRm9yV+RqJy4fSs49Ax@vger.kernel.org, AJvYcCW7IcoE4Cbdlus3gZvUTpFg6r73nfMxBvbMLjvS9bHK9a5mwo/g04rWJoVZzBDS6amWDn2A1XL3zSb0zjOrbL3yswc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EYBJoP1uJI8cAHwmkzvDUSfrHpsM1Iqm13FSXgWZYrQFQBVU
	WzOyXS/c96iSMcrBaY76ExQ7JF7W/nAcK+4f06H5WAE8IJuOO+2v4R5tqiFE
X-Google-Smtp-Source: AGHT+IFSfvcwF2fJeOIQ8F3CwI2r3OX6nv7FRNfpcZWEGGuhokf/PPhFDqwl3EkRnLfQC3M6iSZGIw==
X-Received: by 2002:a05:6902:18d1:b0:e1d:318c:74e8 with SMTP id 3f1490d57ef6-e2892fd9a69mr7416927276.2.1728286233622;
        Mon, 07 Oct 2024 00:30:33 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c4f923sm882235276.27.2024.10.07.00.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:30:33 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e235a61bcbso33131647b3.1;
        Mon, 07 Oct 2024 00:30:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbSi3MAYHlTvOtn+80YVDwa2NQE/EKypHSYW7AF3S2qZXvyEag87W4jKmSNFrpj5xby6T4k3tyh2z2@vger.kernel.org, AJvYcCWM+ihSJqd+kcKDHheFpbfb2vlijms3I7q1aSSuGyFJDEUiStSWEw2iwMc1MA+jgZGGv5uHKg01JzKo@vger.kernel.org, AJvYcCXau4x44lZvUgmaAGTzi7eXBKeXa258EbrWs2WmQybcC/KrVBRMfE6dAXwbfTknjtgz5sOBra1mqiK3NsISSJgQDrc=@vger.kernel.org
X-Received: by 2002:a05:690c:60ca:b0:6e3:1e6:d9c0 with SMTP id
 00721157ae682-6e301e6dd5cmr5249917b3.6.1728286232750; Mon, 07 Oct 2024
 00:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <20241001124310.2336-3-wsa+renesas@sang-engineering.com> <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>
 <ZvzqPkUPmurHf-fu@ninjato> <CAMuHMdXzCYBn+MPz-tdcP7wJRkdQspU0ZmszMv4Uj7VWpTYR4A@mail.gmail.com>
 <ZwBIk0DZ6on8eEIm@shikoro>
In-Reply-To: <ZwBIk0DZ6on8eEIm@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 09:30:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOtJrnbytGp65+kxB1Wf_rjA=dzGXHXREO3Xfd8igvtw@mail.gmail.com>
Message-ID: <CAMuHMdXOtJrnbytGp65+kxB1Wf_rjA=dzGXHXREO3Xfd8igvtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, Oct 4, 2024 at 9:57=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > According to the documentation, there is no bit in a Standby Control
> > Register to control the DMAC clock.  The driver doesn't care about the
> > clock or its rate, so you can use P0 if you want.
>
> Would you prefer using 'p0' or leaving this patch as is?

Leaving the patch as-is is fine for me.

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

