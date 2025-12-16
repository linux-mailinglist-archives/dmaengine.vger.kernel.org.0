Return-Path: <dmaengine+bounces-7708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF4CC488C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD4D303D26B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138023191D4;
	Tue, 16 Dec 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HUR0c1oP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4B2EBB98
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904593; cv=none; b=JhEh+AMX40vkXW9ACJmeUoeKCq3O6s6V7QvuggB9rlG9ouJpc8EkXS07n5sgJQojXEsYmyxElBhPQ59zRAk9SeAh2cwaZv7+KhSG9+lbQzI2iws5k6Ktr3EWC3AVfVvRh7I3rpjqE98LmJbsHqwyuIBIZFHNkSSOiwyH9Gn3djo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904593; c=relaxed/simple;
	bh=F5ummgPhzVwfH3aJi4+uY671i9nGNbXpL0FkgxynloY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmuQ3pYUKpHz3FLfyofQCX5hiUxA29+zuFAGdg35x+r5O5oWGarS8Z36u37WBy2nFo6QrTpA8KL1mriMxOpE1cn6xWef3a1KrCQJ2knzfSByX63ZCXmW/ZMM1jpBAtbMBMsKvh7gJOfBf/WJAnpgJJVFz+lltFoIERPrcVLjXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HUR0c1oP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso7092081a12.0
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765904589; x=1766509389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ummgPhzVwfH3aJi4+uY671i9nGNbXpL0FkgxynloY=;
        b=HUR0c1oP2r19YIGGQc967WfYD/smuI0IJPFKrMRJYAdsvIaZyCJkMtulHBsm50ODwb
         JauGSBBPrDXsSq6QkLWzTbFOO2IIL4lhNSXyLb8MqULUXURDfgh4GPvBYCnxfqO/uGNH
         M7T/KWr9FIkE5Oj2EjHFjl5VFswk6OifRQzQIZh7me8snBfVDzURqctiIcbpDzzWfl/X
         ALEri3nkrW2HWDbC3o0fNTuIobUwibSu89QPHCHEcc1P1KG8qKwBmI39JeSZVzimFedS
         2b5iNPv4DU/s9e6srUZGkRWZB64tCxPJenC/s7w0P87DEsXXQyZLfIfqFHTWLG0iZxY6
         DQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765904589; x=1766509389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5ummgPhzVwfH3aJi4+uY671i9nGNbXpL0FkgxynloY=;
        b=jJ4038uLDYSw48QmTgTFAI5qfuN4pceugWcw8IcZYKpgrSAGm/vqqZcRueJ5lvGPaa
         f5qPMlfPdGzywnxuaPmwEyj4mD0nRwPGA9Xz+0vI9oZtO0jdV96w0DGI5rckjjfg9xYU
         v5s9CGVGU5SXXFsyY9azAD1fHn8HaywXewy2ogKnq9bIr/Ox/JdDgKr/+9z672TfJNG4
         UrFCyAzr3WkMCm8uJ2ElBOEGdbeD5oedX/Md2Jp2AdWiqzQ+XHoMb/Nc0wx5qnP5kO0c
         2P9SUOyvXD4UIKecTD47HTtaR7v2CNZBSPXY1+qYZnyi9ExZohIYY9p9c6Cm30jZamZy
         y3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWagr88zTL6c2kwcU3EFVLlQ3xncPq1vdOLAMbpf1weFUBVUNo3mOUVfzEC65UTszE9+F2EedLTGY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrm46aSLRn8gtX8sIhHDHEf5UFiqaZL3hCbn88qCUqQ4Wg+Ar
	LR1YwplPTC4gTjl7TfFmAhoUnb6QTB9HSI9luaAolCOAoAfHvQLw4lrxmZzufN+TM4v4OrZ6tmL
	tPOLWwD+SFfMHFSyrK5rZ68+3blHG7VvNYAJSNppz0A==
X-Gm-Gg: AY/fxX7VhvE7vXFzO+n9vjdgTx/3aHZGR0YCH+lF7yCaB+hkD1eHR6tOgbQQFEu6zJU
	c11UTAfRNezIKdkCRNjlSPkc+C41sP5uD1a3+nPh4iMyKkFtCTsnUQ/7a9y6Bar4FhcsXJeFDbr
	xc6AbAwAY5o1Y1QyGcqk0SOZ7asWoIk9d7a4bAQAOwW1S7LjfcChJOhvCImx5olCtZOIrsx7iMf
	rmF0dLeoC3o9QLrtTswoIJZI/cHSIQLVwzfSx0FIIHdfHU6tkO36DLD3RcTJvMtG5TQ1giv
X-Google-Smtp-Source: AGHT+IFN/waKvJ1dk6OhR5cf+U/bNCur64fqPTgP6eIpNT5zthYFXF01jY49UDISUGnP6m+DUwrvZmTGOhEzi55R+Mg=
X-Received: by 2002:a05:6402:1ed1:b0:647:532f:8efc with SMTP id
 4fb4d7f45d1cf-6499b31266bmr15476133a12.33.1765904588965; Tue, 16 Dec 2025
 09:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-3-robert.marko@sartura.hr> <d9665340-5a96-4105-88e9-ec14a715df5a@kernel.org>
In-Reply-To: <d9665340-5a96-4105-88e9-ec14a715df5a@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 16 Dec 2025 18:02:57 +0100
X-Gm-Features: AQt7F2rU23EYA-TATIPjguH2zW0uOL-rOKCV2dD8OGkl08WLSt_IEutVu0MO3jw
Message-ID: <CA+HBbNF2EeP=miC9GpEm2HpPTmZAefV2fwxKjm0vHB6tj_1usQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] dt-bindings: arm: AT91: relicense to dual GPL-2.0/BSD-2-Clause
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, richardcochran@gmail.com, wsa+renesas@sang-engineering.com, 
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com, 
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org, 
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-clk@vger.kernel.org, mwalle@kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:55=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 15/12/2025 17:35, Robert Marko wrote:
> > As it is preferred to have bindings dual licensed, lets relicense the A=
T91
> > bindings from GPL-2.0 only to GPL-2.0/BSD-2 Clause.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> You need all contributors to ack this...

I understand, all of the contributors were CC-ed.

Regards,
Robert

>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

