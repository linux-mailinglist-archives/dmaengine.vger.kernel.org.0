Return-Path: <dmaengine+bounces-3413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D99AB7E8
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FE21F23D4C
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D451CC886;
	Tue, 22 Oct 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoQvUNkg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B11C9ED6;
	Tue, 22 Oct 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630014; cv=none; b=od9VTBsWwN0+PufRYrSxtE9wCeL4wCYOsPQ+IU0DIqeiF69DDja6bBZqgivzluZOINciv1mXdKvLIE4zRYqrQHYQDXbBOjo/UB2HwKR7wucEugekg087PaITh9gq1+IfLqS2AOYCQSRAj+b6E9Ske7rM5KXgjOz/+3peGu6ydpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630014; c=relaxed/simple;
	bh=Zn3g/rsmjAnDQhjuWlSialZd2N8hudka0aK2MD88RIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHLuVUN+PHAEG8t623G1tGnknG/CSFQ5WxmIJCrta3uwFh6T/IJdGuPNm3gckgt0TV0JiMV6tbV+TKkLKxWWRrVGQReuEz8WUT6nCgzdSt5WPrE38Knrc//vkKtgrAe8yGVrhXTX5G+xqC4Pew2yG/W0qgaNFhSd0pni5PJw/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoQvUNkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7513C4CEC7;
	Tue, 22 Oct 2024 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630013;
	bh=Zn3g/rsmjAnDQhjuWlSialZd2N8hudka0aK2MD88RIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FoQvUNkgYJcOW5aPFEgdSrDVeXvX5QcUiGgnKevOhRdl3cNmPrn8ubp46XbOvqgfY
	 QjWYO88wvIF3OgeYOej7ecpGDpjy7WQYJ2lvkxRz6lQgCE59gcF/ge/hm8ljPYMfZG
	 v7XqG8cT3Ls/cbgeBTHnVXQzkrflXBIBnNq0DG8CL3jgtuXx23Q9zz/ytvSjuGqoAQ
	 IWa1fhVHoidaozPgTKOI+v+vP81b6lJ1CipGte11Ybl+WqSWYxAkJ8MTChZQj1+1bt
	 Q+VWPk4QEYqc8/V6YFBoDfXQqtJ4+gy8KmNpU0ng224ha7fZuAmH7tywyI1s3BHxju
	 kfx2+Fq2MT/ag==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so6646839e87.1;
        Tue, 22 Oct 2024 13:46:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbRuLP37VMhVERUiWt5oSroqsH64ocxcyNDz9Hpl1Qqgo0JE0CxT7KD4DdR/27ICdznPJFtu0oc5O/@vger.kernel.org, AJvYcCUwg63QGyNDHgdCVqDY1TO4S1BFGvjyRyngtsQEFCUAsmFjgYyYf9x5dJCsxfVa8EZaJUfXHBenBYgFM3I=@vger.kernel.org, AJvYcCV8X+sso+g7uFk3wt90y7kYJMgBBN3NkI5/QCULw2KjxK6nsrbUzYXV0gidjcwx1SSTzKzR/C61+kVrFHQUEA==@vger.kernel.org, AJvYcCVKArYRELoVRJOWeDItt9EPd/fONZcYkTXCh+sqLxBGzGXYQCf+xMYzEIDgBDRNP1HhUnRvkRKhlwC3@vger.kernel.org, AJvYcCWldbjeKtzMV8SIJg8micS/MAzVu/shDoooDC071SQpZoJ2PMUfMUQ6fJaCeor2yR6zCIc7GgMeDyjg@vger.kernel.org, AJvYcCXnH271UrCHmvQb/ce3LtSkUhFngm39QdrfL36iC8/X9Qm88h0PrlHqm4cLyRydRCliTMFd0Gn/yaeoARJj@vger.kernel.org, AJvYcCXtdn3jg+2K1jxPV2hFXSnQCctA76746pWJWfRpoU4xD/oLjAmO1OuSHuH96LWwz7/hShpVElvBqAvcEME9/OH3mII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LYsU/6cVRS+IZSoazOWJGsW0F50Ecm2MfLBOD7zdwCBHQrkK
	RjbGxl1cDJ01uB6jPRbQTFwTPnTFvFQWh/kRMVvTyOltbdgkUsWbgdZ2LEYuzgLfFY/zauoBYGE
	1wmZxJ0b93avkLyjVP2wa5baYWA==
X-Google-Smtp-Source: AGHT+IEO+TmoJNpkBRko2njnTuoGDOOp8xk5cA0fj0xWt4Uui7DHRbRD3cGMhGi7Qb+vFtNs4gUNwWTLEMBa9HTb5QA=
X-Received: by 2002:a05:6512:1109:b0:539:9524:92bc with SMTP id
 2adb3069b0e04-53b1a37ce3fmr102061e87.55.1729630012208; Tue, 22 Oct 2024
 13:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925232409.2208515-1-robh@kernel.org> <172957518656.489113.4975806367588166309.b4-ty@kernel.org>
In-Reply-To: <172957518656.489113.4975806367588166309.b4-ty@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Oct 2024 15:46:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=_9prwcGvM4-sKKNgq6QSsJ=bqfKcVqnbepj1i_2q4w@mail.gmail.com>
Message-ID: <CAL_Jsq+=_9prwcGvM4-sKKNgq6QSsJ=bqfKcVqnbepj1i_2q4w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix array property constraints
To: Vinod Koul <vkoul@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:33=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
>
> On Wed, 25 Sep 2024 18:24:06 -0500, Rob Herring (Arm) wrote:
> > Schemas for array properties should only have 1 level of array
> > constraints (e.g. items, maxItems, minItems). Sometimes the old
> > encoding of all properties into a matrix leaked into the schema, and
> > didn't matter for validation. Now the inner constraints are just
> > silently ignored as json-schema array keywords are ignored on scalar
> > values.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] dt-bindings: Fix array property constraints
>       commit: 72c65390c61fc96cebfb91c300ca774925565383

Why? It is already in my tree and not just dma bindings.

Rob

