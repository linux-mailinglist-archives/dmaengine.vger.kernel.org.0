Return-Path: <dmaengine+bounces-2625-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379CF927BAF
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8471F27ABF
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123571C2DFC;
	Thu,  4 Jul 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET+luebl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435021C2DF0;
	Thu,  4 Jul 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112958; cv=none; b=anf8pfhW8xFnG0BpllDWjTK5Fv73WqXYEA3+iwiYn9uv/qsSpPfRWLFpeCL/SqTX3rJSb8FSvgG6fS0CpI5ukrZ0fHq5ABqITPjSDWDos0FxyLIgz2xXfTR1cvz6c7w6pD8TdhZqMvIFfDTebLqxizEL8yblpXVoyquNA9Ybvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112958; c=relaxed/simple;
	bh=LEsw1djjLDPzbcwHuPkOWyFvHvp7EErfVZzqkRPiIZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CagLF0DEu0H2M7mbRxywZnsukPc0vVmf+3rJuDdYn6GPvYxOhMp+An/0ePD/ad3XbAOlgFpBkA3vRq9LH8Y7F6sKwp4oU3kMtxP1nyepR11qezldvJt/yaoQKhwVQ34/EI/G065Nv6sILdZOpsBMy3UXDcbCz6l8HywBtKeYBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET+luebl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367818349a0so485795f8f.1;
        Thu, 04 Jul 2024 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720112954; x=1720717754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+xE066BndiqNDkiZTJopivcn1cUAHZ+D5Sl17iDBZQ=;
        b=ET+lueblA4j/pxiQvo7SEPNcexxwsaYj8Xj4Av8Lt4DS2VvIFzUwFAScZkChTV4SDX
         HaOV1lF9jt13iOPz45J/x41YuGYV2Enp4TTxMZBB9IvA7lGcpVKkh44aLc3k33ZBWnC/
         lr2oeypJpTRXc9mHUzhFv1VTSolTGD+LIUeGerePrddIFYbokGm9d8v8CBJG10WyUHTg
         cKvrr1j5b0EpWt8SJIYrULwk48o4yn0k8jH52ZjUY9XWybmXZT9K5drTBhkGxLuf0K+a
         AGc0yO7Pw9cARCy3FTC6/uTokvQ8O8JJCkene5jd7KZT5GZachZqNdypzRokT8XFDQts
         /HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112954; x=1720717754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+xE066BndiqNDkiZTJopivcn1cUAHZ+D5Sl17iDBZQ=;
        b=W6rxp99ae8WGLnTvXknrnTOf7qt9twV1BbAA/JzERAws+G47KGpaESTpEkTj5PV0IG
         ei88T1pCOTtuZQQT9FFr1pY4yEIMo6fDMZsIGVBtnbR5of0NpR0lYvWasi5Hea1evNwH
         9bwCWX3HsCfWPaK/kyatNrqG34KoX1LLWp+gyFcpR0U8UXQfScaLP7VFuEX/cFbv3C+s
         T3ExEWZ3GCY0eoH6ILXonrN5cMr4NDJIjkpIJAAMoqKJ30pinjmdiGLY7sf2B7+wioD4
         44P8boOTYbGx0yKC/Z/HcglPiYK4AZgiCkhjZ3qG7Iim/mGSOOdD8IU+PU/5J/SFbHTD
         f99w==
X-Forwarded-Encrypted: i=1; AJvYcCWROJg5l1K2fNGQ81DUltfrvH362Duze88+e6YXiaQsucgpJQLchlFxH6GjmxUBTgOenmqXoAz1Up2Ped88eUsIRcRXX3SiUe1jyJhHV4GDq5P87VhXkrird+bkwNvP28D7xPwkuxW5zpM4BYj6NYWvsN+yrVdsCGeszZPjGvys80dSRg==
X-Gm-Message-State: AOJu0YxRs9eIWgqFBKlGNCeWfrKlAxXFg7z8Lf7GsKVdm+LapTkYpLHV
	h69/z1xtiq61kgnmSEm6xBSfpzuUMPKEDJYEBrMUWDYrG1cG9JGj
X-Google-Smtp-Source: AGHT+IFa+qEhxwqUFnREpYr1xHXmdEfjKT/ZhhbJR8sv4pU9Q+Vr0L28884m3r9nAxQPW2a0gj96sA==
X-Received: by 2002:a5d:4c4e:0:b0:367:892e:c6a0 with SMTP id ffacd0b85a97d-3679dd336f1mr1823463f8f.34.1720112954386;
        Thu, 04 Jul 2024 10:09:14 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a648dd3sm6968358f8f.89.2024.07.04.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:14 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:09:12 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <ZobXOPW33bLHF+Jv@standask-GA-A55M-S2HP>
References: <Zoa9MfYsAuqgh2Vb@standask-GA-A55M-S2HP>
 <20240704-underuse-preacher-b5bb77f92ebf@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-underuse-preacher-b5bb77f92ebf@spud>

Hi Conor,
see below.

On Thu, Jul 04, 2024 at 05:42:39PM +0100, Conor Dooley wrote:
> On Thu, Jul 04, 2024 at 05:18:09PM +0200, Stanislav Jakubek wrote:
> > Convert the Spreadtrum SC9860 DMA bindings to DT schema.
> > 
> > Changes during conversion:
> >   - rename file to match compatible
> >   - make interrupts optional, the AGCP DMA controller doesn't need it
> >   - describe the optional ashb_eb clock for the AGCP DMA controller
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >  .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++++
> >  .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
> >  2 files changed, 92 insertions(+), 44 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> > new file mode 100644
> > index 000000000000..e1639593d26d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/sprd,sc9860-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Spreadtrum SC9860 DMA controller
> > +
> > +description: |
> > +  There are three DMA controllers: AP DMA, AON DMA and AGCP DMA. For AGCP
> > +  DMA controller, it can or do not request the IRQ, which will save
> > +  system power without resuming system by DMA interrupts if AGCP DMA
> > +  does not request the IRQ.
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,sc9860-dma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - const: enable
> > +      # The ashb_eb clock is optional and only for AGCP DMA controller
> > +      - items:
> > +          - const: enable
> > +          - const: ashb_eb
> 
> This is better written as:
>   clock-names:
>     minItems: 1
>     items:
>       - const: enable
>       - const: ashb_eb

Ok, should I keep the comment?

> 
> > +
> > +  '#dma-cells':
> > +    const: 1
> > +
> > +  dma-channels:
> > +    const: 32
> > +
> > +  '#dma-channels':
> > +    const: 32
> > +    deprecated: true
> 
> If there are no users of this, I'd be inclined to just drop it from the
> binding.
> 
> Cheers,
> Conor.

It is specified in DT "For backwards compatibility", see e.g. [1]
I'm not sure if it's still required, I'm not very familiar with this platform.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/sprd/whale2.dtsi?h=v6.10-rc6#n124

Regards,
Stanislav

