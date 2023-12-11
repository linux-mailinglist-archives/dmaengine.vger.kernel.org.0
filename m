Return-Path: <dmaengine+bounces-433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D180C155
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 07:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22BB1F20F12
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F911947F;
	Mon, 11 Dec 2023 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id1d1h9c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAE33C1;
	Mon, 11 Dec 2023 06:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96050C433C7;
	Mon, 11 Dec 2023 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702276274;
	bh=1UR/8Pgn6x9/GIOen//ufXC9UJE3MESdFkpeRuRU6eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Id1d1h9cPtfeRpQh1xeNBJ7U16PgqN5ObnLGNB3xt4Z5F3Xv8RLsyLlV7Dh2ccO6H
	 px37LqnMNQbLXatiUKgNjWZd5T/OqoXec89+sYipmc8iN/qWucaU1T5HJBJDL9z5N4
	 Zre26yqquDl3RBofbZofoU/uc0w6coVBJvuxDjwkIGdSkYO6DfIbQ/0QItE+yKfZh4
	 uk2xzqjWZzS9gsOMPFAKM0CGODsYOzOSKC1EGRllmjNG0JvllzfB96Hijt54EEuweL
	 2aAyWFMpEvT/iVVvRj8RUmpBtwMFQBv5O5zEK9hM5TeijIaCrAkHLUKYwbHR1sBNuJ
	 E+mTG07AAJaFQ==
Date: Mon, 11 Dec 2023 12:01:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-ID: <ZXasrcpZ+ChRsKpz@matsya>
References: <20231122235050.2966280-1-robh@kernel.org>
 <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>

On 07-12-23, 14:59, Rob Herring wrote:
> On Wed, Nov 22, 2023 at 5:50 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> > by a schema which causes warnings:
> >
> > Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> > Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> >
> > As no one has cared to fix them, just drop them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
> >  .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
> >  2 files changed, 26 deletions(-)
> 
> Vinod, Can you pick this up please.
> 
> As pointed out, examples don't document anything. "ti,omap-sdma" is
> not documented at all (though in use). "ti,dra7-dma-crossbar" is
> documented in dma/ti-dma-crossbar.txt and there's still an example
> there.

Sure, queued up now

-- 
~Vinod

