Return-Path: <dmaengine+bounces-3278-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88500992A9C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C91F23799
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84B19A297;
	Mon,  7 Oct 2024 11:48:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760D18A6AD;
	Mon,  7 Oct 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301696; cv=none; b=tDwB7kx3r9K1ChnZdQ2QPlQPEBMUdkNqpXL7lTShu51DUfZEihfabQH3p4NURo6HS3oqgPRR7E6dY4wprv9yMm0oPnzm8lq1rksHiV1CSMFiKFJ4OuuQbD8pnxEAXF0l3GFcPejGHXBuaBdOzIGwMicgHOB59qrBFfz/7o1+jBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301696; c=relaxed/simple;
	bh=Q5wtA7ec4Qou26xJgtEWx/rXBB99xnqHPn3CTW1ILUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0NYvarf+4uTyYbBxiueo6FPUKHnfWl/yUCWgxn4gaMvpBXp3gUGk0pKZs6kaVsnTJp4VYVj/mWXkGl5VuU+8aI1ssmLWmWxjPYCRrHvJyC043L0LWqUgYWc1xWs2oO45cE5XuthfAbYpsKm7qRkTXrux/3LArHYwrZUj7HBKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6dde476d3dfso32605457b3.3;
        Mon, 07 Oct 2024 04:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301693; x=1728906493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MTg99+DmaALnsyDNIw+mp2qSvQvNPEyHLZzUnFVk4E=;
        b=SlabyXBOnB6++JBdAGAIYYOGZM5Z1kgZQiR34Ab4finnAXE5sWDDPkvZNB/QtWWWRI
         phOu58ZTpka+FF5hhWTAFZseIVcoqqa9WOQzOMrCWL75t+RE5mrfM1Kkswge7WJk7cRz
         rTZEZaRvKskQOqFtPrbvZ50EIJm5BokAED989GK5tbhj7fRZmWe+0ZcrOQfeeynpnudG
         pCVAl2itbGEja1SVGWhstJiTn1dkMjitPY8qry5mjUlC7NnyI4wVrIKTk4od1x/ZIMef
         KDpj5T1f7VxhJTGxTcbiDYfczhMStmSoe1BvHRfhzlMUwNn2WNvQD+xBuOEadTT+L1u5
         kI1w==
X-Forwarded-Encrypted: i=1; AJvYcCVPWBZlMdmUBr0qTxn0/H2GtcuSoiLm9zRIelQH65ePQWyYLfkOzMOMEWJ1THEQiLTsJktgAQbpF74p@vger.kernel.org, AJvYcCXix5QKbHjvGI+UcOtkz1tgKG0fTyPgI2IUyN5tULHGhYj6Dkon/dSWlGKaEHzWKr5p7ICit/M2v9w+@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgW0++esxpXA8x6uJ6GpFxpw9JHX3AX8U1DLYfWD8/nDr0RT+
	D9VcdNmRFgYo9mvQnx/IZNa+MCV0mv8U2S46+tmDWC+nJnBHAqTaddRtbxc0
X-Google-Smtp-Source: AGHT+IE+EDE2i/4idaANL3mw7H5NNTuQ0gQPrkSKMlL/pehOj8fhKjpkOnF9t65Tx9aGr0d9Erx3/A==
X-Received: by 2002:a05:690c:6f90:b0:6dd:ce4c:2f4c with SMTP id 00721157ae682-6e2c700084amr97961467b3.16.1728301692902;
        Mon, 07 Oct 2024 04:48:12 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f3c8sm10062197b3.38.2024.10.07.04.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 04:48:12 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2b9e945b9so34280547b3.0;
        Mon, 07 Oct 2024 04:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURjuQYrdzXDppkY6sYzXTgxBiMMkOjPknkwpkhjQZtfFyMgJAXiwWbrqwqclmvAjqxMGBntB+Npghx@vger.kernel.org, AJvYcCXcXYrpyPJGgTAVZl6unobHonuheuNxocsg8+jh6WZg/va0ankBoMlDyasjKsOvp3Xx3hcycbA4i5Fa@vger.kernel.org
X-Received: by 2002:a05:690c:388:b0:6e2:71b:150 with SMTP id
 00721157ae682-6e2c72968admr99151907b3.29.1728301692479; Mon, 07 Oct 2024
 04:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007110200.43166-5-wsa+renesas@sang-engineering.com> <20241007110200.43166-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241007110200.43166-7-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 13:48:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUL2GyG_HUPEVaYqXK_SaksiaJSjDPFQ11ma5iB6yE9ag@mail.gmail.com>
Message-ID: <CAMuHMdUL2GyG_HUPEVaYqXK_SaksiaJSjDPFQ11ma5iB6yE9ag@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:02=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document the Renesas RZ/A1H DMAC block. This one does not have clocks,
> resets and power domains. Update the bindings accordingly. Introduce a
> generic name in the header to make future additions easier.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

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

