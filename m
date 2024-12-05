Return-Path: <dmaengine+bounces-3911-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D09E5ABB
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 17:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846FF1882E10
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DBF1B218E;
	Thu,  5 Dec 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b="KssXXnKL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B3191F66
	for <dmaengine@vger.kernel.org>; Thu,  5 Dec 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414853; cv=none; b=ee6R/7Tlv6vtD8fJ0U6PAN6wUGKRPN2u1tA9twBXaZaEctALCgNu9Wzs5GLiFklrUC+VCxBNuQ/RvA8fLQwlKaVXvh4GPJl7jt5AV4XNLPKLN3W+HSKPnZZXP6bhsy+A/Ip9hSMTDJZlWduZ9NX3bmrIWHez8IzO+YYHvo82ORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414853; c=relaxed/simple;
	bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8vc5KCl3ozvqa0l8YFaE0A43bQzZYzwf2zwcrCk7O+h8KC3M2SWkKdjOMu+9tBsxM8wHg1NQqLtWQ/q2LjHEYQu8ceYGpfrOfkrBY+ihW+qo6S+n88ZLpXCTHOfiLHiKT7ReV6a4aacmw4GNOz6CnTkNsSBXcwFoJf9Ojk/Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com; spf=pass smtp.mailfrom=cornersoftsolutions.com; dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b=KssXXnKL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornersoftsolutions.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2965e10da1bso363141fac.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Dec 2024 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cornersoftsolutions.com; s=google; t=1733414851; x=1734019651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
        b=KssXXnKLjSzDbkwDi6QArPLrpHMWryNsr44YocM3Djj7WjuPgnFEqHG3srma7I6SY9
         Tp8nOrHwRgaPnegnVODTpNBjJgoDc/kqWcG9j3bfKem4uEORtABqgMRiTLS1CQMcqrQB
         BMVKw4kTvbTuCRwc2TkePE2i1+O8FtmxzCTMJKsD/aA58oWK7sa6uGXNyL+3GnkcRz5Z
         jkPVLkNpamltrB95eX2/hOnsUXqI25KCLqfBfB+oKSPQzWNdOZTjbZHnFgSC6oQSdFfg
         RLdUwRPFmVQ/4BPYCx9xReHRqkRREvGLmnpttkKPPXsTDX8p1mYYjVe2VwxfixnxbPDj
         l04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414851; x=1734019651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOckcNe8W3RQKx65UzBFy6XStXAxVc8nCNjDX8cXNw0=;
        b=w3LD4zPHDpuRtEeNjEm+pK3SHzph/wc2dkCSZFK9YpILfN5L0ogN9Z1EEW+utFO9Oq
         u2aDgL61pchisQzo0nPlI+v9ebl4GIKwO6URVlx6LEhnL9s2mnRR4aoMBXgvdXpi3y8s
         5pzt9mLZ/tp9Z5JfXJZUeyjxMrwQVbkmiIb0zQsF2Mhzh17aXeT3Sit+cDtDiIMo2Z+0
         etqZXMPTTmX9UIGuEXRq76s6+XWWAxdaO2++V1+lTr+UcJQNhPj34ljPrCaWiusl4zI5
         roTVQTVybyoCJc00jk3l+38BtMM5bo7mRxqtJ/LOMzcLdlyVo2vyGQ5m3MtfITkC1HqX
         IfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWUCCx/gBN4RkS+S/CQ0fYSkv6zn7U1iuQuTjP6AalwTnk4gtstcmfhKpTfK3mV7eReoZlHA7W+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3GG/h3kNWgtj9u3Be7o1IJaCXoJdHKIcIRPB70L9twwgNDF0
	sxXIJ8eQnbpAl8x0ivViehkewbqqUkKqqUdmjNbEh4wJ059JenHfnZpM0niEqSIJ7xajUCECxsp
	L/H+TEJoiQlTQEsSHAbSVQ9YZ0lNqJS8YSEGekg==
X-Gm-Gg: ASbGnctLmDi4PcNWv0wGpJkDMcRv9AGnEjvuoyH/a0zlReCVas+fOnUErJY47+p9cX6
	HMUIusxGNMLo7T14kGCm+nig9IKTG26h7
X-Google-Smtp-Source: AGHT+IFc4uqMYZT0SxPqLKcDtYnZCPI05fbA21AsNVCAy81bsUwRL7Rs+7Wfd6hN5qQc+lT4SQo91gDOIfd4QY1CTs0=
X-Received: by 2002:a05:6871:4b83:b0:29d:c832:840d with SMTP id
 586e51a60fabf-29e8890d522mr10222701fac.35.1733414850886; Thu, 05 Dec 2024
 08:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADRqkYAaCYvo3ybGdKO1F_y9jFEcwTBxZzRN-Av-adq_4fVu6g@mail.gmail.com>
 <d53538ea-f846-4a6a-bc14-22ec7ee57e53@kernel.org>
In-Reply-To: <d53538ea-f846-4a6a-bc14-22ec7ee57e53@kernel.org>
From: Ken Sloat <ksloat@cornersoftsolutions.com>
Date: Thu, 5 Dec 2024 11:07:20 -0500
Message-ID: <CADRqkYDnDNL_H2CzxjsPOdM++iYp-9Ak3PVFBw2qcjR_M=GeBA@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: dma: st-stm32-dmamux: Add description for
 dma-cell values
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com, 
	mcoquelin.stm32@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, vkoul@kernel.org, amelie.delaunay@foss.st.com, 
	Ken Sloat <ksloat@cornersoftsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for reviewing

On Thu, Dec 5, 2024 at 10:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 05/12/2024 16:32, Ken Sloat wrote:
> > The dma-cell values for the stm32-dmamux are used to craft the DMA spec
> > for the actual controller. These values are currently undocumented
> > leaving the user to reverse engineer the driver in order to determine
> > their meaning. Add a basic description, while avoiding duplicating
> > information by pointing the user to the associated DMA docs that
> > describe the fields in depth.
> >
> > Signed-off-by: Ken Sloat <ksloat@cornersoftsolutions.com>
> > ---
> > .../bindings/dma/stm32/st,stm32-dmamux.yaml | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamu=
x.yaml
> > b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > index f26c914a3a9a..aa2e52027ee6 100644
> > --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
> > @@ -15,6 +15,17 @@ allOf:
> > properties:
> > "#dma-cells":
> > const: 3
>
> Your patch is corrupted. Please use git send-email or b4 or b4+relay.

Sorry about that, I will do that. I will wait for any additional
comments and then re-submit.

>
> > + description: |
> > + Should be set to <3> with each cell representing the following:
>
> Drop this part, const says this.

Ok

>
> > + 1. The mux input number/line for the request
> > + 2. Bitfield representing DMA channel configuration that is passed
> > + to the real DMA controller
> > + 3. Bitfield representing device dependent DMA features passed to
> > + the real DMA controller
> > +
> > + For bitfield definitions of cells 2 and 3, see the associated
> > + bindings doc for the actual DMA controller the mux is connected
>
> This does not sound right. This is the binding for DMA controller, so
> you are saying "please look at itself". I suggest to drop this as well.
>

While logically it is the DMA controller, this doc is specifically for
the mux - the DMA controller has its own driver and binding docs in
Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml

I can reference st,stm32-dma.yaml directly, but I was unsure if this
mux IP was used with another DMA controller from ST on a different
SoC.

What do you suggest here?

>
> Best regards,
> Krzysztof

--=20
Sincerely,
Ken Sloat

