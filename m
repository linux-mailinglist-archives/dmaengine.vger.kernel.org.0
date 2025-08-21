Return-Path: <dmaengine+bounces-6096-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C37B2EFC7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 09:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E05A1CC3EC0
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C02E92D6;
	Thu, 21 Aug 2025 07:32:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE482E92DA;
	Thu, 21 Aug 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761576; cv=none; b=tAXWIIQ3EbI6awy64KFmJQDO4vSZLclBKFAyb+3BWONfDRlkQrGcgeYEVPWzo1aEZwdETJOAWtL1Gs82+JG6OxRBVEP+pJ0Ir8nrxFCBceX8tTqAo/+tgksMhE0WXdfdGu8h3U9RwdaDgFtGsJcmuDJZSpHV2gCucs0bs4csBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761576; c=relaxed/simple;
	bh=iR7W9OBIg/YoAAEk8o+v4Qww1X9xHOdg9QT6r7jtb8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH1aduXjMi6nSRI1OxQVVjZ/TPekA5SlFAZzcntvkpXN8tQJ75cvgvYIQiKCZmrRMfGig2yWiexmv9Oqj4r11jffHV9+0T5uKrGGGJkp+a3DMzkUJKx+zjShDuUeYZ53Kkgbujs8CTs5FCBnKeuslri88/T7Tw6GG9iMq1ebJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b17534eeeso266060e0c.3;
        Thu, 21 Aug 2025 00:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761573; x=1756366373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5G76ZiP1l04eRnUL+woGlRNtcvSbJmIHOuwOKU1fo5k=;
        b=W2M+vthg7R5KQMSTVFl3oLmKAKn/fuKJHZpSD+ROejCkEop3pnePpyjzpwmEUtFxct
         cqQMDZ8K2JwWiUn9mP0KOnjTATA85zfwaOb18eKJgnbRrTr4wjT0b6bA2YdDCkg7Ujgh
         HaBk5iWQYV9D13BrWfnvWEOy3aeXoObda1eiX/WEAkgwoLKLs+DIDasTNsQM7GLEIQLi
         Nuj5+JNn0fJRyeTd+CSaF+gSfmcgBEatnD6/OPc9ag2TyxSFSe2ZszftI6TDF5+H29DO
         x38/Q6FRH3dqy6+AvMYQ/yNle5z/tC4o7g6W8Yzzp8iF6vxgwdNrxCWxGYy32So9cM3/
         2TRg==
X-Forwarded-Encrypted: i=1; AJvYcCUtYAdXFXggMDgt++Ut4uQYCZ+XTdbhPcMr224V0rM85pUZC/Y+LZwc06vrtkKl2MnKIe8BNUZL2Bhx@vger.kernel.org, AJvYcCVYlRKHqQns4m57nTccw4ckVTktO62QJCtubr9ZTswEgGkJURew1N0jNp03iLCAkQ7UJ4svDxcaoUoZwKRAv/QO+38=@vger.kernel.org, AJvYcCVa9NlV7hcK5FSPOyPc1Gcl9esc8Pprf/Oc0BTlbb2HLV+l57GPt7FsJqAArhmZvRQUz/j9Ar5/fg+I@vger.kernel.org, AJvYcCVh6oGiuTHxA6slMG02LlEinoo9EChj+U/EK4EJqFjGPjVYlG72VVXnruRb0IslXeI5g8HKEXPw+8o2@vger.kernel.org, AJvYcCWzwNOXuSbfKfkr388loriLI8C7E+uaLwtQ8J/Pg4nwiel7vKYew7aJoo3wHCYgXDdC5Ya1xJXP/SmbzgEi@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5830RzXEjFOHQC3p3IfoaE8qhTOR4UKh+O1O5+O4A/xzb+4N
	rH7pvphK6G1CRKVQ7cktQ4pnS9Wnrb0jzW5Eatk6S2qcZNVD4Al8Ie3akORruhd3
X-Gm-Gg: ASbGnctufC5J498dPThQf7O/U4vdoqyys/5p/eppwaY5a5BguaM1PVRqp0HMOJNvJrW
	69IAMj6bXVDHLHAsurJxFc5B2h16eHYJe36Z2kiVdv91T0hfJ/yMuMmsWEZBm7uFKgwvm79AV/z
	eJ4BOt4IRRLPp668R7iZAWRcxd3sAoOeAEu4eae0SzON0m583PbB5EEX0Q/9TpqR1OYvRJ6Dfn2
	OY1eXKrAmWcwFvTsIQKVjeNCXxBWqq9fBF1YYGcvvCcAhFFU3eu4mYLJ+L4hw1nIvF+ZOOtxDrj
	M6aGE9W8mR2DAUrg8D3y2iglNBYTGUWYetEZ/qjugHjLW2Oi3uDDwPmEwTxRYG2+iQiNwTRVvP6
	umKegE6XULva8hiTaAZMY348Eab0pC1Rw+r3UTIbir6Pex5kQ0PwPw4idMf8V
X-Google-Smtp-Source: AGHT+IEvPadvvCjlqTkLcsVvoOxXWxY6JCaIK9t63EjMOycQ80Ax647sJDgibdZedCRW1cb95Z9VSQ==
X-Received: by 2002:a05:6122:3d0b:b0:531:188b:c19e with SMTP id 71dfb90a1353d-53c7d83aac7mr297981e0c.2.1755761572460;
        Thu, 21 Aug 2025 00:32:52 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed8eb8sm3623728e0c.21.2025.08.21.00.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:32:52 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8921eb4befaso44655241.2;
        Thu, 21 Aug 2025 00:32:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbS0hbWotO+4kXM8mHWKp2BoXZTZzO1s9qWJJkW0rr81km4QIrkScBV5sI2zIlFehtoLYpHrFPbKA4@vger.kernel.org, AJvYcCVvkXtNfttsJdleJ+tLAjLj+UJLkpYIuu7DbNyo3+oMZXUDEoD8y/XsYRXCE7ZSn9vHw5cn8Xp8NvSZ8wE2@vger.kernel.org, AJvYcCX2Ttsyf/Vr8QtRU0SaFHBlxjLoIXJDk6jqVPKwvgD6nFZ3hq+qzOcPzVu6axqsbN4uzxMd74SZhBInVwmwrhE5ezk=@vger.kernel.org, AJvYcCX9NsqebSswSAJBIMIs/cNTcGKT1WVNX39y2xArnC9oEpNAc5gfl5NWoJmEWxlzwukZC0RoeejTyOyk@vger.kernel.org, AJvYcCXxfvUoXynw5afkjv5G22uyV+3tsCgFaeDQZ9IOQrGzBYyg5k1avP7kj7iGKZvpZUvAfem10/kfv6F2@vger.kernel.org
X-Received: by 2002:a67:e7c5:0:b0:4e7:5f31:7443 with SMTP id
 ada2fe7eead31-51bdf241ebemr427508137.9.1755761571596; Thu, 21 Aug 2025
 00:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com>
 <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com> <aKYG-ph43pjgiHF_@vaman>
In-Reply-To: <aKYG-ph43pjgiHF_@vaman>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Aug 2025 09:32:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWEspGvAvrm1T_hSjHmEhqAO4+OPfRWRZP+PTP-EO=5Q@mail.gmail.com>
X-Gm-Features: Ac12FXzPw4V06_RhWFxxZjKCzjwq7JCDGr5NyUZSqRo7upsFc1Tlulg44uQr3Mg
Message-ID: <CAMuHMdUWEspGvAvrm1T_hSjHmEhqAO4+OPfRWRZP+PTP-EO=5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
To: Vinod Koul <vkoul@kernel.org>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, tomm.merciai@gmail.com, 
	linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vinod,

On Wed, 20 Aug 2025 at 19:33, Vinod Koul <vkoul@kernel.org> wrote:
> On 01-08-25, 10:48, Tommaso Merciai wrote:
> > The DMAC block on the RZ/G3E SoC is identical to the one found on the
> > RZ/V2H(P) SoC.
> >
> > No driver changes are required, as `renesas,r9a09g057-dmac` will be used
> > as a fallback compatible string on the RZ/G3E SoC.
>
> I seem to have only 2/3 w.o cover, nothing in pw too...?

Lore has the full series:
https://lore.kernel.org/all/20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com/

Only patch 2/3 was meant for you.
Patches 1/3 and 3/3 are clk and DTS patches, which I have already
applied to my renesas-clk and renesas-devel trees, as the new DT
binding is straightforward.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

