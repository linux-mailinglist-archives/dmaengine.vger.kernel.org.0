Return-Path: <dmaengine+bounces-2223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22A8D6064
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1981C20C8A
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F72157466;
	Fri, 31 May 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1KkYP+/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A632156F5F;
	Fri, 31 May 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154045; cv=none; b=luwsPJrNlthuFimRInWg4uYHlksbGIrsD7WgNUPjq0PIe5YPgmkTAFCTlWMt3RoJ58mxWjhFRHhI0JbdASRkMpP7gXiUop+LNAlZfCSJDIbjR3G+Bff/zyk5PMn15ea3iYI8Qzrjl/MoM9/UqtDxNI492KBB20qaZYkwVfJF6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154045; c=relaxed/simple;
	bh=5JDD33qRorywNmQKPBbyh44Bl11dNVa+Lm3wUWF09Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZd+MB6AtS2EaA96VDKn+vbaVum8S4cqrc83ZvY38fDWxMjP01IoZnJWzTLM0Cl4DFRWcuvYZjesELSU+g+VC/SC1yqH8/5aW+olHRAuG0w4P0elUd2C0G4t7m3C6PRvXFWUavmADsZ1ToKQncwlcqcD/Rjq09LM0xea36F5ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1KkYP+/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25074a27485so771588fac.3;
        Fri, 31 May 2024 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717154043; x=1717758843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXBg1IIKOFylKo+rkqsg8yzt/arKbmHAdUcO7p0ZR7c=;
        b=G1KkYP+/GW4iy6fFCRqFaxAbKgrzreg6lhK6Sw0OS6cHiJ+AkGbZqAS1lFG43vx8Fi
         TYjHPaWR83Jsdh3lwGxb8jGzPIGpzhmJ5ZqPODFNW5Aq67UOaBy6XmeQxZQAVx+Dlvku
         Pvey8mty55ABDkq5HA7+rJA3ThVjqkQ9ETfu0DBIFgaQc6OxcIbNK4g8t+F7IRVNug7V
         jLvUwW6E5qROPbl3s6CK3PFf8Y09YfkhL8plJQmfFS/xpNpt04eSxqjIRL9M0xJebosn
         zhFp/MRrsDwC0cMXskhhJTwJ5LBZvzRx2/ZqBPmH0/ERrdOMeAKskccJ1jKXz+jGnuib
         KV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154043; x=1717758843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXBg1IIKOFylKo+rkqsg8yzt/arKbmHAdUcO7p0ZR7c=;
        b=nUGudwTvhOGphlDluRFtq04uzIz7yi3oqJ2FI5ejvQNuhsmqslF3ifYSltmNx6Kz5l
         q4DuL2xnc+RtVZL26vfzXuHGsF0yNhjWh9IxLk0NewPCc1C+Q0qiw9nAj7unpsiaxovT
         2a62u6jmpr1BZzRXYITgfG3lBqhRJTz7UhTYS7EtCtC4YfjmBideh0+3lL6gDhAHGhP9
         fkWEiXQJcGRKWpBEV2FVEouKVym7fahpVRVCTOujXJFboN/ZXP2iScQhePcD90Ofp0dR
         sprbLq0tf9gndmXVXod6/2j2I+4PQk3CZHd5QETendGknp9tAkPD5CF83g3cktuQcyT0
         xk+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJieifmFH2zBlqb164LfRQI4zqe/X8L8PkpKaaXwGyDPoVzSIndKBypgSOr/00k8ibxTl7Sw2oChpOsLNBPZnxHHMWXAMAvKTBeldzJVJV+zadhxckV+SyL/g2ctYx+Mi3nXvMg/i9ou+OJXS8JpKg36zSUTwtH/qGHg9ef1YmyHmfOw==
X-Gm-Message-State: AOJu0YxtEzqeyvTKeYCWXuRh6fPB/+OxE8zylwslcM4NNjaXsyoNzkaq
	wfPKNDRxRIdeB68xu11YbV0e665m3kLCcFyOhP1L84xEG7B0KNsa1E0z3A1muuasoOFLKadHXlU
	I4ukjVeMdvCRFSkTKL+nvvjaqVos=
X-Google-Smtp-Source: AGHT+IHxpK+grLpjn8RaNCKVuk2asXOqwaFS7gBD9s5FbqdCZLTtq7o51KMuQ/gD9ZSt6PBAA87mn9OqOkvS9K3F1PY=
X-Received: by 2002:a05:6870:969e:b0:250:8141:9219 with SMTP id
 586e51a60fabf-2508b7f15f2mr1716934fac.18.1717154043442; Fri, 31 May 2024
 04:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531090458.99744-1-animeshagarwal28@gmail.com> <a472e8ba-bf54-4a62-9b05-ea265a83ef1b@kernel.org>
In-Reply-To: <a472e8ba-bf54-4a62-9b05-ea265a83ef1b@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Fri, 31 May 2024 16:43:52 +0530
Message-ID: <CAE3Oz825RQg25PxEbnb=ui7+MtH0ssS=i2HAQK-yOJo+v8JMMw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 3:49=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 31/05/2024 11:04, Animesh Agarwal wrote:
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +  dma-channels:
> > +    maximum: 16
>
> maximum or const?

The txt binding says it should always be 16. Datasheet says this
device has 16 channels of DMA services. I thought specifying just the
maximum implies maximum=3Dminimum=3D16. Sorry for missing the changelog in
this version it was cost in the v1 of this patch.

>
> deprecated: true
>

Shall it not be
"#dma-channels ":
  deprecated: true
?

> > +
> > +  dma-requests:
> > +    description: Number of DMA requests supported.
>
> deprecated: true
>

Shall it not be
"#dma-requests ":
  deprecated: true
?

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dma-controller@10001000 {
> > +      compatible =3D "fsl,imx27-dma";
> > +      reg =3D <0x10001000 0x1000>;
> > +      interrupts =3D <32 33>;
> > +      #dma-cells =3D <1>;
> > +      dma-channels =3D <16>;
>
> and drop it from here

Is this really a deprecated property?

