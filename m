Return-Path: <dmaengine+bounces-2527-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65588914729
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CA728459F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAE136663;
	Mon, 24 Jun 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw0znWnr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4F5380F;
	Mon, 24 Jun 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224092; cv=none; b=hRkZz5cDLvbXeGlNNswwfPIjLTXaZHr38haG9Ww6sEstL/Rb8FKzJQmCNN6bTiHkmDLKjpk9DenlBXsfQQ+uq7ReaDAL490gQ8knZ/zH1+MPc8Vb9RO4WyLNN3zaDsHkLCaIfjEL9FVxcV+pSoR9X5eJAYZ7MPttRRz2bHl7wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224092; c=relaxed/simple;
	bh=RE24KLqID2EC6vA+5KK6hVTlaj0wsAEo2phM0U2W/ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZyhlpmD33AunyKotF+V8YdC4p3f0unp0hcV/VriL2jAVW1ifpwxAWpWhrxMnTrTyfAZrFpk38zrUTy53dTLu+EYjNJgUPVRBhrag9dhPNQ2MQ5d/kTfrMhC9NgjKBPw1kHsQfnny4adQ7/2miu1Bp3poIq/NeCuPFHQ4Ylge3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw0znWnr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c84df0e2f4so945254a91.1;
        Mon, 24 Jun 2024 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719224090; x=1719828890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCbtAJmIzGDqUkK6LAUHtM0hWFXhplCtNg6zF/80eAQ=;
        b=lw0znWnrgnfl9Wvu7DCm6Hag+M+v3uDqn6Kq5Q9JInPvrxcShMlNNNh63E6CS1yB8P
         ji5wXL0OM8kZIXOSVnfadLt01MLPBwqmQWqh2tL4WJSgJYGhf/FH3ujib7cF8/l3qEHg
         GIHV8TNg+m3PsFnTQ4a/cU+W54k3sWASp5YlUS635sZcN6Nhk8zZcr81ZqZQmiLCmrmu
         xIGmUV3WNypm3797TTO9S9jiHwT8S0EU2CMhiqaQMJMjBxDB1nRkj8d2gFd/k/RXPpFc
         EaOILeEK6ojd4bPf1YSCohMSXrFgEtEsrWUSNHRdYdn8yEukYqo9iLd0dYL745dABa9y
         x2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224090; x=1719828890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCbtAJmIzGDqUkK6LAUHtM0hWFXhplCtNg6zF/80eAQ=;
        b=AIaIlT1FHw4rGPcBTJTzat1RGtJNsnpmEvA3SGLtV4g09AwDTvZ4QRIqdd/UcJ3WHb
         SthRdAqfJpn3EIBokFmOTTjbK2qjqu3RV6PgTlcJSelbK+HlwrwgFfxYHwBVT+6HTxuU
         3YYpcMvqvC65YlYLV7nc2gYrh8MF5h3IU9YzVDknlJFFqe4NYqx9zvWwm324HOlNUisP
         JihKfO6nsk5qmDj2OmB+mKxaCI05UoONLSd7ptL0bcKCpgUM5ZsVT6UYjFgiPKz0hGbq
         c+rWzUTiWFSPvDkYxZfDiki5Na3bTJO3eyWrM2CTzwlv8vqpmdEV1V5mUx4Oi7zvjVxF
         VWeA==
X-Forwarded-Encrypted: i=1; AJvYcCXjTa12iRcmvmMVwcelucEsVV8340JQNkUOtKlKPQGG4mm6wRmKD60+P9vuU0jQBpNIDhuh/BW1LOuX9lkJkG/9RodXEOdMO0JvX6E0hWqzE3ex5hs8OkXGAOiz9kUJcd699wcepgNhOrcvgKzltTPzRwPUuXKWMPc/QOCMtncf0QEOxA==
X-Gm-Message-State: AOJu0YyWJte3k68h89SRp0s2H9QjRMf0Z3cCmMdfK6/YpcctuN4CA9xk
	xqcz6HdZQqdAxMOJbLReB2479jxj4DDYx7eAPB9++0pwhx0vcAIrp8ZRffS1NFiRwRUdrTlhg3o
	G2nf20peXzuUD/HmP8JFdokPIXCQ=
X-Google-Smtp-Source: AGHT+IFzFiRLl/5gFSYk5S5BLFBGj4iF9pD+4XnLnZj+Li7/qTVD4bPy+jBR9mZRCKfO0rRQBbb3vKQ9sQxLTuXyYO8=
X-Received: by 2002:a17:90b:d85:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2c8a232c548mr46096a91.4.1719224089949; Mon, 24 Jun 2024
 03:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623124507.27297-2-shresthprasad7@gmail.com> <62c05c34-0b69-4091-8c3a-d0b8befa9150@kernel.org>
In-Reply-To: <62c05c34-0b69-4091-8c3a-d0b8befa9150@kernel.org>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Mon, 24 Jun 2024 15:44:37 +0530
Message-ID: <CAE8VWiLXS1gsxjk7aK335QtZJk7Se+k5VsFzmUpQHfaVJnKa7g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: mv-xor-v2: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:47=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 23/06/2024 14:45, Shresth Prasad wrote:
> > Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
> > for validation.
> >
> > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > ---
> > Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mocha=
bin.dtb`
> > and `marvell/armada-8080-db.dtb`
> >
> >  .../bindings/dma/marvell,xor-v2.yaml          | 69 +++++++++++++++++++
> >  .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 --------
> >  2 files changed, 69 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v=
2.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml =
b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> > new file mode 100644
> > index 000000000000..3d7481c1917e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell XOR v2 engines
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
>
> Should be rather platform maintainer.
>
> > +
> > +properties:
> > +  compatible:
> > +    contains:
>
> This cannot be unspecific. Drop contains.
>
> > +      enum:
> > +        - marvell,armada-7k-xor
> > +        - marvell,xor-v2
> > +
> > +  reg:
> > +    items:
> > +      - description: DMA registers location and length
> > +      - description: global registers location and length
>
> Drop "location and length", redundant.
>
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: reg
>
> This does not match number of items in clocks:

I'm not sure what you mean, the original txt stated that `clock-names`
is only required if there are two `clocks`.

>
> > +
> > +  msi-parent:
> > +    description:
> > +      Phandle to the MSI-capable interrupt controller used for
> > +      interrupts.
> > +    maxItems: 1
> > +
> > +  dma-coherent: true
>
> This was not present in the binding and commit msg did not explain why
> this is needed. Are devices really DMA coherent?

Sorry about that, I added this because all the nodes I looked at
contained `dma-coherent`.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - msi-parent
> > +  - dma-coherent
> > +
> > +if:
>
> Put it under allOf: in this place.
>
> > +  required:
> > +    - clocks
>
> This does not work and does not make much sense. Probably you want to
> list the items per variant?
>
>
> > +  properties:
> > +    clocks:
> > +      minItems: 2
> > +      maxItems: 2
>
> Instead list and describe the items.
>

I did it this way to allow for `clock-names` to only be required if there
are two `clocks` present. Is there another way I should be doing this?

> > +then:
> > +  required:
> > +    - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    xor0@6a0000 {
> > +        compatible =3D "marvell,armada-7k-xor", "marvell,xor-v2";
>
> This totally does not match your binding.
>
> Please, read example-schema, other bindings, my old talks and other
> resources before doing conversions, so we can avoid such trivial
> mistakes. You enumerated compatibles (enum), but here have a list. A
> list is not an enumeration, obviously...

Right, thank you for your feedback.
I'll most certainly read up more on this more.

Regards,
Shresth

