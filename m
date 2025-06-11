Return-Path: <dmaengine+bounces-5347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F9AD4E3E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2273A684E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9193239E91;
	Wed, 11 Jun 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNeZNUmp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A2231825;
	Wed, 11 Jun 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630296; cv=none; b=FuuQ13y5Qxw/xz+WuaPMOdzEF9/gQ9RhvEgbeE1j4YziruAx3mOxrqAEY+ItlvnDUVdDfiS6GqHIb7bcdv51XeblPQ5oFWVCv7+5QbcnG48NuU/4EH0wZrGXfW0hix+njkAsUDzeoRX/D32t90fsOAnw8BwO1wCNO2srAnOY55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630296; c=relaxed/simple;
	bh=B1Tfjt80+dGutPeeGdC8bxfRXEk2YUaC3CwohjsKd50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8w9vjJ1xGdGYLg2Xz/1XHkwNyBIoyGsGuk2EHsWdcgPTvt6bhRSPzJNiOS4Vr/ScsZDP5jzbxn0v7PzIBepNx6Bl6yr24QO12vZuL15ZlLVCAbuUjwIftvyXqyXKBWGUByR+jcvBL+Q25juIbiErNRAghSqre/SDcTPpeFlB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNeZNUmp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d09b0a5050so385245885a.3;
        Wed, 11 Jun 2025 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749630294; x=1750235094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BidLvrmOmqABz8QFweaiXGgnxn0STrjzzVlTkfXyV+8=;
        b=ZNeZNUmpPTohzLfX4UwEEFAFGTbJunkhKbfugUQtNR2fJQeZHRun7JIX3wL+tPQ/dr
         xr+2B1HqEKGuqC1Ni5+Qg+XqZhpHfOi6a7bhnjQHDvLQB14xcKmEtWOuzizJhwjicLB0
         jJBy81UZJg/Wncok6WHgLZSPw5EP9PY5sizpHghNK9rE/QaJ14nBSDa6vKgMK0b5GHrh
         VLmNfUEvZfMcMmJyEHHrVnFRP6YuYY5g+igZtPDU45L6axtnMjAU+Xb9uE4rZ+hJWVAl
         6w6nTZoUDdZIK4YDg2ViJvyrf0zH1TsptK7zahUpkgumBwuQwjy0qycVsO77ehjvTj1A
         YSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630294; x=1750235094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BidLvrmOmqABz8QFweaiXGgnxn0STrjzzVlTkfXyV+8=;
        b=dC+0AWot/wPru22VioV+QB8ilIutHgEqEZ7QRwpsQN2MSljmGRD1rVGbrZafrVJnyR
         l1aiwXR1u3txyWScFUEPawi5TfzV+7JZkBGUwPhv5xoyd8qxx0COeUsilqulgqiq4WN4
         0e31xwOjw3vsR/a6+p6Ap4dAfYKM2Qi/b2xNEZN3zrtWHpcWjkgvU79U6WtOdpaOgVY4
         AWPdMjtJn3s6WYT0oTUs6fztXbPeQgfWsV2MQMOrodRNjWbY3W0D1zfA4/mS4Fh1jqbk
         OIsgFhlkpDZqAK5pWk+z44XsfabjjXmVIDH+Kfo1iP9Xz6XwVAKl0qUR851hos7DxFHY
         yKfg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Oa1GHQDgvy1qwOJdLGuN+XFqRNXlsDI/db0YX4ivVctcrqaTn0nU3k5fLgjUDgpLKf7lQj2zvdbr@vger.kernel.org, AJvYcCX12P1oOaMZhqqaDGjosykqWU9BwoWxF4H0EDd090AAN32Klvj6rZj4dUZF0E4BMr3Cb4ULTweY6myD4noL@vger.kernel.org, AJvYcCXjRki5IkQdNPvJj44yDd9go/Wc5Aw2U5zq2Gl9DFnFpPazFzs4GBM1/5NlCK9YAx8gMBoBEjvM+ina@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4XzVHWPvhZutWsktVPUHICWCQNuqrbxGIwTck68g+hJ8lWCf
	JEaE02QSOt3DVfq6pwW5JEQp0LCndXLp+4ELTmyy5J7CjqaMlK78/wRY
X-Gm-Gg: ASbGncs9/Dkj23kz2vyAVV67M7nJHkYkNojlSm6ShtsqwDL3F8gvZWw+fCtjTIQ/wZf
	kd7FpxzkmVSp09pOdpcD0Sj98zCtUBdd1o1xvvCGv+iGtdFLEPWT6GIehJh85IN/4GVQ5nmBzHP
	8aX13qV0sDTQuW6qJn6ZkXXOAswg0HuHiOLIvEiMh4wVmnL9JiqxpURD+0ZGRZe3BqtbQUm0+kM
	2kAZ0XeOBKO9glg0aJvq/GlN5PwsEMf9f5hkOnNGMgBwf7fuolUtPuFAJhMsIGlX0GBDJty0YRb
	oAL8Rw40fmqmMOlKoQBs7yihSBRnNNYHMdmFPA==
X-Google-Smtp-Source: AGHT+IHb2MLjUBYv7CB4OtR5rJJhMMfCSImfLyf7zcPSqR4AyQunE+RrQVFB6oFjHFdz9IskAQDceQ==
X-Received: by 2002:a05:620a:2955:b0:7ca:f09d:1473 with SMTP id af79cd13be357-7d3a88ae947mr345558185a.28.1749630294098;
        Wed, 11 Jun 2025 01:24:54 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09ab8a31sm79287166d6.7.2025.06.11.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:24:53 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:23:45 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: Add CV1800B support
Message-ID: <ycnj5ke42kpqjwgsjoo3vs4gibyr2i3yr63jfwbeajo5unqqmx@xdt4xwhcjbna>
References: <20250611075321.1160973-1-inochiama@gmail.com>
 <20250611075321.1160973-2-inochiama@gmail.com>
 <20250611-brown-turtle-of-election-87c324@kuoka>
 <f74e217e-4a6e-4ba8-a89f-9518e2f74fda@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74e217e-4a6e-4ba8-a89f-9518e2f74fda@kernel.org>

On Wed, Jun 11, 2025 at 10:21:07AM +0200, Krzysztof Kozlowski wrote:
> On 11/06/2025 10:19, Krzysztof Kozlowski wrote:
> > On Wed, Jun 11, 2025 at 03:53:15PM GMT, Inochi Amaoto wrote:
> >> Add bindings for the reset generator on the SOPHGO CV1800B
> >> RISC-V SoC.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> >>  Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >> index 1d1b84575960..bd8dfa998939 100644
> >> --- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >> +++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >> @@ -17,6 +17,7 @@ properties:
> >>                - sophgo,sg2044-reset
> >>            - const: sophgo,sg2042-reset
> >>        - const: sophgo,sg2042-reset
> >> +      - const: sophgo,cv1800b-reset
> > 
> > Keep alphabetical order. That's enum with previous entry, btw.
> > 
> 
> Heh, it was an enum when this was acked.
> 

It seems that I have made a mistake when rebase. I will fix this in
the next version. Thanks for reminder.

Regards,
Inochi

