Return-Path: <dmaengine+bounces-3415-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5F9ABE5C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C251F23943
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0F146D6F;
	Wed, 23 Oct 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeerwIdR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F613775E;
	Wed, 23 Oct 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663627; cv=none; b=lMxasH185vZIBwB4zoTzld1nxWj8BSZVe8oWTfBKAPcGhdA7q3Sj30ScmoCVr2VjgMlASVhc/LEMFG1ZnbX4n7FpLLiqVuLtWPSPPOXGIHE3GzBml/Z7QhGKb8L1wem4xI4A9b7z7375er3MNyrHLpYx1/M2dmohgfUW4J4Wzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663627; c=relaxed/simple;
	bh=Etz6FWHnhxCv86l8yMlafaB4ks420BvLY/XxVxL/b/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxepSB85ZefJZouow+J75Ai1eWWh09OBf8MCWzK91RLAkl4tD14DF6ECuo5ERmiJG/1D7GyktK5JnASnPPu8IMpATjAcQfSRJe/YAPg94tRacd7kxoxd8BqmxO5mMPDaV0BLmvd71K8wmUWwMQTTV+cB7Ey6oNT3lU1af6trw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeerwIdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DA7C4CEC6;
	Wed, 23 Oct 2024 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729663626;
	bh=Etz6FWHnhxCv86l8yMlafaB4ks420BvLY/XxVxL/b/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeerwIdRDV/6kpZMJpRX54B69SewgeRn30mRSrF4Ee9u3HMO84dfF4Y485JqLtzvL
	 pWqkIOY7kLu3+Jg3oh3jwcTilaMYYv4VsEqGqeI32S5U4vNsLOuKH/lxHsR9p6fhYe
	 3msYBVPBDaceGADZY19TXEHHwpppkk2mCut73u7pd8raeIsLirbqmEmnmddEo38f0T
	 p2h5qSz9LVEmWTF5GBvuOVRRBTfvJgpDzJUVIQzxr2YxEiz0mu3UubW4K+iJ2LoWWy
	 mnQT7O4I59V5+PrTQ1dNX9oyBHr+NEjAa9cj2RetJSOAOJsmRNmBUqBzljdKjc5gkM
	 d2RZUUL9d35qQ==
Date: Wed, 23 Oct 2024 11:37:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix array property constraints
Message-ID: <ZxiSh3PG41zkCtNa@vaman>
References: <20240925232409.2208515-1-robh@kernel.org>
 <172957518656.489113.4975806367588166309.b4-ty@kernel.org>
 <CAL_Jsq+=_9prwcGvM4-sKKNgq6QSsJ=bqfKcVqnbepj1i_2q4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+=_9prwcGvM4-sKKNgq6QSsJ=bqfKcVqnbepj1i_2q4w@mail.gmail.com>

On 22-10-24, 15:46, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 12:33 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> >
> > On Wed, 25 Sep 2024 18:24:06 -0500, Rob Herring (Arm) wrote:
> > > Schemas for array properties should only have 1 level of array
> > > constraints (e.g. items, maxItems, minItems). Sometimes the old
> > > encoding of all properties into a matrix leaked into the schema, and
> > > didn't matter for validation. Now the inner constraints are just
> > > silently ignored as json-schema array keywords are ignored on scalar
> > > values.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] dt-bindings: Fix array property constraints
> >       commit: 72c65390c61fc96cebfb91c300ca774925565383
> 
> Why? It is already in my tree and not just dma bindings.

Dropped now

-- 
~Vinod

