Return-Path: <dmaengine+bounces-4245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A575A24521
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E8162628
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29555192B66;
	Fri, 31 Jan 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtfqOBV+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBC2AD20;
	Fri, 31 Jan 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361781; cv=none; b=Sh1ss7fJuF2+AheaFZI7PjNex/SLWfoFM/GnziDQ/oUmGt2lt7Lb/5ir1wvyHVZpCWPHyqo3L6vW6HRvj7gMeW3zfujK6b/zqe9zqhMiUZpyzOFZ/+/5bTDrOME/b142fxp1+eM+9nGQr7Qg567MopcvAhL9A7HQKq1dtaNG+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361781; c=relaxed/simple;
	bh=24W6Dps3y7DxZ6YhfkzynKPlf3swLWZxkwFai0Y3sBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS+eG9p6wctucV4wMH4Pgv4EU2OMHn74HYUw7653v/SQXGioF6n9I2zLAILZ0fa7R/MXhqC7NKcAKar/jVX5kNFhSOiFHi/uPKxUW9gV84rb3VLIhK/3eeQv5K3y2Dujt058Zww4mYYefcMGirid9L8kEKRA2DJcWmx5g7f5paw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtfqOBV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5C8C4CEE2;
	Fri, 31 Jan 2025 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738361780;
	bh=24W6Dps3y7DxZ6YhfkzynKPlf3swLWZxkwFai0Y3sBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AtfqOBV+hgn5E2OvcJZHV5aNQwRoYZB/CgESGBejHG/zkhQV1sAuR0NIwBLg9xAnH
	 NMF7ihG8arT55ilvdLTKTWJmugXTWXqCJSDlTZeS2zxMmwQFLqm8D5VukL5YR/EcBJ
	 mghfb/3SO3dWStF5RQqNApP46SZDdaOsLZ08uuh/lqxQcZeBdoAPNo9gglpGJJlJBa
	 6d8A+j+Z5Ei31O2xP6t7GYTdzHI8rFqRWRC6V6NAruBJpu/X9qlSJBZZtbTiSe2K0U
	 95VqbK3A1v+Ko/GNl3nXSzntI4YcNvUJuqPzC39Twtw/FyZPNjLEwB4c+7+1U/hjuu
	 +Zc2srHyIOMnQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so4761781a12.1;
        Fri, 31 Jan 2025 14:16:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoDGXIql06RButv7EgOop4qS3j/BACqzomJXaalPacrnSgOXRSqCsviGh/yjmIrCmrtyu34ehI/7zv@vger.kernel.org, AJvYcCUuoJotdYp0dgt9sRrj6AY0kQeDhLbK08PEYpVY07YshMtBOH5eFRF9IHE5ipljEMXiMmS3PFzty7nq@vger.kernel.org, AJvYcCVWozPOAOyqlkmAR6uoS9B+GSsUzjDGlR+V4K3NiazlmgtKAL58hKRtuU2oUA50rKypjtJsl+jSW020TxQF@vger.kernel.org, AJvYcCWplzKe2iz25Tbjbwxv3zZYBPZzJKHBfIP/Zf0npcK9SI7DD1GKrvzH9239OlmjKhXKXtj59fb0mQU=@vger.kernel.org, AJvYcCWwa3DsmZejGwDwlId6GFU13gwR2QUXFCjql3wyKdq2PUaUoHH/zpJmyM+MALDzs9SkpFKktpTtlk9H@vger.kernel.org, AJvYcCXjYHaWnmwsVUouBC198Y04mAfKODGo58t6SP3lTquW0dMpPyjzf+wXDTuFOB5/40bDPd81fq0DkgDTC2sqX14=@vger.kernel.org, AJvYcCXl8HO6SMhwaCzPokccij3qQJLK0OMVwqbzCgHelm/+rft6uTapT7Q7khmlJoJpDqV2yUmOpfhBl13v3O0D@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiWmgfXmuPrr9Rdt1Xjzb/gndtWkd6HeEb1tGZj/KNn0WX4bL
	8Dud5l6rBOaTwGyWDnODYYHBPKmF+t2R8K7bm2Pub2RXetUxfFJiSxc28ISIw4VzLn0+urSIGVB
	m+KwSnOBo6SOk08m0N1AAWT+IHw==
X-Google-Smtp-Source: AGHT+IG+40Vie6I5qh4Xa+hjwERq+fPWo6Sglqt6y5ghUP/X8RySc2w5nt0i3mGF0G2DQOmC/TQjR33KPq7ga7buNyY=
X-Received: by 2002:a05:6402:2390:b0:5dc:72e1:63ee with SMTP id
 4fb4d7f45d1cf-5dc72e1647cmr7162768a12.6.1738361778979; Fri, 31 Jan 2025
 14:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-5-50649f51c3dd@posteo.net> <20250127044735.GD3106458-robh@kernel.org>
 <Z5zYGdZU-IXwIuR6@probook>
In-Reply-To: <Z5zYGdZU-IXwIuR6@probook>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 Jan 2025 16:16:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJAX1QbXvG16NV2g6DGece6KiG_V-uyKQQLA618Oq9miw@mail.gmail.com>
X-Gm-Features: AWEUYZlhW5XoGn0HVU0ENeDHSySI0kteJDy_cGfJFvW15zruGH8F_vZTC5Jh93M
Message-ID: <CAL_JsqJAX1QbXvG16NV2g6DGece6KiG_V-uyKQQLA618Oq9miw@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: dma: Convert fsl,elo*-dma bindings to YAML
To: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 8:03=E2=80=AFAM J. Neusch=C3=A4fer <j.ne@posteo.net=
> wrote:
>
> On Sun, Jan 26, 2025 at 10:47:35PM -0600, Rob Herring wrote:
> > On Sun, Jan 26, 2025 at 07:59:00PM +0100, J. Neusch=C3=A4fer wrote:
> > > The devicetree bindings for Freescale DMA engines have so far existed=
 as
> > > a text file. This patch converts them to YAML, and specifies all the
> > > compatible strings currently in use in arch/powerpc/boot/dts.
> > >
> > > Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> > > ---
> > >  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 129 +++++++++++=
++
> > >  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 105 +++++++++++
> > >  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 120 +++++++++++=
+
> > >  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 -----------=
----------
> > >  4 files changed, 354 insertions(+), 204 deletions(-)
> [...]
> > > +patternProperties:
> > > +  "^dma-channel@.*$":
> > > +    type: object
> >
> >        additionalProperties: false
>
> I'll add it.
>
> > (The tools should have highlighted this)
>
> With dtschema 2024.11 installed, "make dt_binding_check
> DT_SCHEMA_FILES=3Dfsl,elo-dma.yaml" does not highlight this.

Actually, it's the top-level 'addtionalProperties: true' that disables
the check here. That should be false as well.

Rob

