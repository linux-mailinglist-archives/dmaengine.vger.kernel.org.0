Return-Path: <dmaengine+bounces-7940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE24CDBFF7
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8193F3007C87
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570D31691C;
	Wed, 24 Dec 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QkflirsL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC52B2D7
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572229; cv=none; b=OWG7ICsZ70oO/+1RNxlKwVEd4XVQETfaGWQRoiFBQTcQKv4iDOIEn03lorgf22XEsAF3/gzbvO8ja3zOczDVCAb+G2vR8VMDK8tuf3A4UxTTg4JP17mJSL+VG+zdWnfpwnjFKjoHVqQv3Lk0dsf9ZpVsuRwHYsYAD3GQGHn8RyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572229; c=relaxed/simple;
	bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiNe+0sj+wagXpIromUCfahf04EST4bnMi8bFku7PAXgcbQwnIN5YdJjrO6tKhWM8JxcMRaQrQZG1qelC0XQ/E6u8w8aL7oNfNNxrVAVF/99LDH1IIBC8LfVa1n2IkBvZjDw9D8cCx849w1WfjY9mWFwCgMwG1KY18HXbgmm+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QkflirsL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b73a9592fb8so1096720266b.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766572226; x=1767177026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
        b=QkflirsLWgw6/rIVLUiHc+xA6dek2yABjKGT4i+A+L5IppltKVDlUGSuOMevhCMgcK
         ckCLksZyu0cznkJw9n+xpMrIVsyQ3Vziem1/pZP0tLUIfK9BDzN3rwJgG/wSnpHiLBmn
         TbECIwlIAMkmtsBG4zMVFVhSwlOxuJaxJtFPNAujXepGgZdMwiScXo/ikP27cH5mMmK5
         QdxyunnKgaVS/qXTP0+3piJErhrQ7gDnG6FI1Dwa1lihHSqS/wyP5Uwz562Viur8V2EB
         fBVLF6esy6inerOy3NioZOYB5LpnIbIj1uwUN/K3fkNamRPUqXKSwot/bT8w1TYli6/g
         f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572226; x=1767177026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
        b=dKSuWmFfBwyNja7uvuWu27tdT8q5Mvfofi92BHyympYAomPUzAhMs+Dtoxi+gc9/QV
         8JVWgdODoDLHDozURUzNB55KpuIXu8k/p60Qrj+nX7LnhLc1M3pVoEgFdludmenwfMcZ
         X/kQXTgF0hTZaTRsQSmhwTqOs8qqgQw61Efx7M8XqI3oJQLGonu33ssFfUmUzRlHQLDu
         VbQMLFSC+eM+jF5vvcE2xqQdC9rNL3McKJPAj1WFgK7y779xyA6S05XjYJfxNhdG7A8O
         edAcciDIfyXuAph1Z46lJFgLNdQbMInzRZAbS1kq9RxWav1g+Kd6VGu0NNWZ9JF1/Iiv
         sD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvV1Giq9NKrDt2MOUMXDat62ZO1DIsajXs4ISCDw60sk2nArDWHFgq0iseJX19BfnC+b6C4CJ4Dt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nqp/PwOVQy7j0T/Ej+Eyfl9och90ChJeMplDzYx2CyPKeULx
	oD9MuSXqHTSQ8OXRLDA5ywV60Nnh3YgYwk9ofpbHBpO4wA+LttYcULS3hB7UrIX2+zddunuN4SS
	syYVFV6TKJjSGTHjvDNcGXuUDE/Hk/CUpyZAsuhvpAA==
X-Gm-Gg: AY/fxX4j6GqHjjnTnnFcTeShg1wInRyCFJEwEe/xpewW9pEB/7NjwW6kEji5O7bLAit
	Gurt14WXYhlmXregwDPe6Gl0GqT1pNMUgTESqsBoSWK1i8cvyKQHNJ1o/cooRQgq8GlJxrlvSGn
	G/OkKG0LhviWP2UuY0Eg4Xf0Z0ZLH0ly01LS7uG64ANtlO0bbe/ywX1fFhtGYCV0tBcDImiQaml
	udBmuETR7uOtgKafWwB0BQA3LsQ0CK6UshC8LabCGwfLLZZRFrmyv/W3dTNl/vsj4vJRpVpbpSb
	oRngA7FiIJA3Wg83SPULt7Pm+x3kBQwh5vwDiIIKZOL4F2oEdufKNa6+Dm7o
X-Google-Smtp-Source: AGHT+IFeflXA2mce6O+1rdmvPjP/12/Umt2Y99WbRQ8cM3OEzOcKAWgIne20UzsSB0V8xKjPoflCDtb5j1Pn52N5SuA=
X-Received: by 2002:a17:907:7f01:b0:b71:ea7c:e501 with SMTP id
 a640c23a62f3a-b80355b2523mr2261188266b.4.1766572225170; Wed, 24 Dec 2025
 02:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr> <20251224-berserk-mackerel-of-snow-4cae54@quoll>
In-Reply-To: <20251224-berserk-mackerel-of-snow-4cae54@quoll>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 24 Dec 2025 11:30:14 +0100
X-Gm-Features: AQt7F2rVNXRXeSbgmjkb2SKB7p5AiaNihNvuJMBrgMZ7XIKTnJcRJJO5brWpKNE
Message-ID: <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	vkoul@kernel.org, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 11:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> > Add the required LAN969x clock bindings.
>
> I do not see clock bindings actually here. Where is the actual binding?
> Commit msg does not help me at all to understand why you are doing this
> without actual required bindings.

I guess it is a bit confusing, there is no schema here, these are the
clock indexes that
reside in dt-bindings and are used by the SoC DTSI.

I guess I should have titled this something like:
dt-bindings: clock: lan969x: add binding includes for LAN969x clock IDs

Regards,
Robert

>
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
> Bindings never have a "include" prefix.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18
>
> Best regards,
> Krzysztof
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

