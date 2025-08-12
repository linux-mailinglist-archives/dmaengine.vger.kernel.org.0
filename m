Return-Path: <dmaengine+bounces-5999-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C0B22316
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 11:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BA91885C01
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA92E8DE7;
	Tue, 12 Aug 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2G46ypI2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE432E88B0
	for <dmaengine@vger.kernel.org>; Tue, 12 Aug 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990598; cv=none; b=H72YcalmJTUqgZWcmQbcrvwVBUurTOFdNHfkwVNDDmcfrtzGnvG/Pt90JBPQ6qHlf5zPiBHEh/zIiBlfgVFJUMitugk3GsCyD4nh8x0+V7ywP0mT0lGbmegKvRNQvPC3aj53lLA6jbYaMrqibg16j02aiOnfZ+SMmp7qtVjx8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990598; c=relaxed/simple;
	bh=1t64m70/Ydj3TYOPyqgd4kW/vb05YEGXJfg6UGYXmh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZg1gBSuJD2KzRZPj/zfFhpkmnXvO3lmCwaL+j0EkdM+1Ew4pvYSTXcSxF3rTwzIeHEqXOdcGfKCPSKXw+FRGGvj/enSkvxFQ1Z/YU7dDadXVgo7UKdqkqx6u5pHieDehoej7o5Z6okv0+rywr9/seUkvNmRJ2YaajZ18f9cQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2G46ypI2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-718409593b9so54087177b3.3
        for <dmaengine@vger.kernel.org>; Tue, 12 Aug 2025 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754990594; x=1755595394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oXbJx6E3ijqdJvhjzvA4M+RPwmHgHT1829C53wx0lE=;
        b=2G46ypI2o5927P/xAkij0LpBuTFJGF0IxP6wwd1anAJlR5VHYNsVyuEMKcHMYPb3uZ
         BQsysbT0HJ0rMYVCOWbYY9p5Sn5MKwcUJEMouQa9Vi/XQAprD1rK0afWAcgCsjy1hx7y
         aZjG5Sx8KC7aBOa69R0E5K9yBgWzUJp9JcHRcFg+4bBjazDKX1gDmIRJLAZvUiNExfFO
         dusY5USbSj6oii0+Hz5ijX72cICrfRsJNM+LIuXoiJE4jpFNF3KYbHVyV4tuTZtsCfwA
         41Sr+6tVZG4KUhhcnKIBnwxTEa96SpJ4EbL0h5GAFKefmOm1EZj/oXbGl4zNfi7DfWur
         nCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990594; x=1755595394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oXbJx6E3ijqdJvhjzvA4M+RPwmHgHT1829C53wx0lE=;
        b=VSich1PGZVBRpA7NfUxysAf3SREpz5MtSQwPyK9Cz+wvmnjTCPF88VlFPFhph7NjPF
         hRhO3JyVlxW6Pc2hmRr/jc8KcJrWAClydYrMBhq2b9XFEPbkL/8qszlRaoEoISFwM2IU
         mLdLepskI5LUDrCFEPDKGA6jzkYZUeBQG+nqAddABHy8iCjX/cZpEuLBoYeZpvKAc6VS
         6QyeYjsfwFQsRlLoobhN4fUBIj34KfSLYez/v6VGG8rnnw2S1LeoY7Mu3ozyWjAgzJTM
         hIUulXhaxjaYZ9ddJCCyAHzNEGafDvyDA7wvB+Ml1RygxfHYNcGjgkTXjZ5hMAhmmhrN
         wyMw==
X-Forwarded-Encrypted: i=1; AJvYcCVGo1IAaD3DmxH74u44fxgPjY63gpzMRPYxJ+HxuuIBGw8+CvK+IZRo4JjJAsSmpuKECNtAY0fjNWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHCL+AjWq54agh1ydljANbEDBUN5C3GSLKWIfw+gDg63Z3h78
	bhNN6reQF5zsV1RorIYAoWd8qLpnqHCrJ4nMcO6BHhlblI1VwF6Jmy5oLkPmmKwNzNnPQYjuF45
	9XkC+K2Sblka7Evq5ldk6ykSoKTsunSqJrQlBIcswbixyOzBfmBAVaR4aPOHD
X-Gm-Gg: ASbGncvQajBZWl9kiNXLoWsI4Pa4lZ8DrChsL2yu62bgb9ze0FY6ikac+pe6sm+u5Q2
	8o7xHafZrLfZsnvsSv0AYlkVVbKpEY1ivKa+6srfdWjkqRELr5AiFjNoba5iu2NepUuxyDi7+2Q
	dyuvlTj1dgyVgXOiUCCnSwHN02FN/2kYnwHT9pE7U0d/kYHzotR1hqui7Jgwtr7/JDfnWh+d0Hc
	D9uMw==
X-Google-Smtp-Source: AGHT+IH77Kjt8YC9sfRPn8ADNNC7hjxOUoD/Dna6Dolf20ZY+41dtteIkmZw9xyyoKWcmYqmqjNzYuop1VYhnZfQUKU=
X-Received: by 2002:a05:690c:46c9:b0:71c:1a46:48d6 with SMTP id
 00721157ae682-71c42964fc4mr37731957b3.1.1754990594494; Tue, 12 Aug 2025
 02:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com> <20250714-working_dma_0701_v2-v3-4-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-4-8b0f5cd71595@riscstar.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 12 Aug 2025 17:23:02 +0800
X-Gm-Features: Ac12FXzwCXGXSKiwmxKY93OBxvFdFv-jw-xOzVu8Q_eshKd5oaEN163nC5iHGgE
Message-ID: <CAH1PCMYtYfJYAt_Ah4WW_ps3tPuYLMvanKExhk9t_VRHkRwnng@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dmaengine: mmp_pdma: Add operations structure for
 controller abstraction
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Vinod

Just a gentle reminder on this patch series. I've incorporated your
feedback from v1 by splitting the work into two independent patches:
 - this patch: [PATCH v3 4/8] dmaengine: mmp_pdma: Add operations structure
                              for controller abstraction
 - next patch: [PATCH v3 5/8] dmaengine: mmp_pdma: Add SpacemiT K1 PDMA
                              support with 64-bit addressing

Could you please take another look when you have a moment?

Thank you very much.

BR,
Guodong Xu

On Mon, Jul 14, 2025 at 5:40=E2=80=AFPM Guodong Xu <guodong@riscstar.com> w=
rote:
>
> Introduce mmp_pdma_ops structure to abstract 32-bit addressing operations
> and enable support for different controller variants. This prepares for
> adding 64-bit addressing support.
>
> The ops structure includes:
> - Hardware register operations (read/write DDADR, DSADR, DTADR)
> - Descriptor memory operations (manipulate descriptor structs)
> - Controller configuration (run bits, DMA mask)
>
> Convert existing 32-bit operations to use the new abstraction layer
> while maintaining backward compatibility.
>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v3: No change.
> v2: New patch, introduce mmp_pdma_ops for 32-bit addressing operations.
> ---
>  drivers/dma/mmp_pdma.c | 187 +++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 156 insertions(+), 31 deletions(-)
>

