Return-Path: <dmaengine+bounces-4291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE52A2898B
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8BE16740D
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32C22D4EB;
	Wed,  5 Feb 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg4UJO5y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BB22B8A9;
	Wed,  5 Feb 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755622; cv=none; b=W/YNId16buvxpddkgnzYkt+qDEZFPoQhYyW86ooW32Z+CBIwdKuA4Uj0V74PV5d6Rf0DDpWI5Hy3gpduqwQczs8dy7Y9yidNn6MxHo/eh5Ru9MDQVNykvnhu50M652MSpCdle/2q6v+TXsoR7zq7ZsOJ9FptuqyH3Lp8hTHUbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755622; c=relaxed/simple;
	bh=QDt7G7gOuUNyLCqEejR8qfOIVWZF+V9T6WAWyoEhZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me1pRU81EOJXr7GcqQDtjH+7dotbFWuMrQHs+79iFVVyrEoPxR/VZKyeGEDOsFPNQoGNSdiNUCRHANJV8L/ILKhOkOIvr24kBE4o5rLP9mcpm/HYjMMdKKYhUvlYbeqAMll7YLKZivlOseJVd0Ekb58v7OsISN+sAZFi/dD8J0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg4UJO5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1213BC4CED1;
	Wed,  5 Feb 2025 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738755621;
	bh=QDt7G7gOuUNyLCqEejR8qfOIVWZF+V9T6WAWyoEhZIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rg4UJO5yReXufNdwnRYqDQ37/CLIMB5yRoJsoZKrJXcnRnQunnnRJHGmJ4RsSmmwp
	 6cZ/V45OSSVdxZCrRaRdG7T8MPuKv6rZ2k6U7LG0vOOKqTFdtWEkAM4BXWQtBwq8fU
	 lb97ybVNng/MdPiHYsB6GxwBGz9xpN4Rdk5CdsUEz24ufcuIbexlDrRAqzaeQTkyf5
	 IyjaX770PqlUYrPwPx+QxmgZLgzg+0vadmP3MusrCpcsMzS4aIS3btWMmgK58XH39E
	 H/ihbdfBCjFfE9H5Rvftadq3SMAQWx0iVHo+qc8rNFJgUh8KjIgSTGXPW48gr0Hhxk
	 LIiVPT497+57w==
Date: Wed, 5 Feb 2025 12:40:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Charan Pedumuru <charan.pedumuru@microchip.com>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Tony Han <tony.han@microchip.com>, 
	Cristian Birsan <cristian.birsan@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Message-ID: <20250205-dynamic-scorpion-of-climate-9e7b7b@krzk-bin>
References: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
 <20250205-mchp-dma-v1-2-124b639d5afe@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205-mchp-dma-v1-2-124b639d5afe@microchip.com>

On Wed, Feb 05, 2025 at 11:17:03AM +0530, Dharma Balasubiramani wrote:
> Add document for the property "dma-channels" for XDMA controller.

I don't understand why. You are duplicating dma schema.

The same as with other patch - your commit msg is redundant. You say
what we see the diff but you never explain why you are doing these
changes. And in both cases this is really non-obvious.

Apply this feedback to all future contributions - say why you are doing
changes instead of repeating what subject and diff are already saying.

Best regards,
Krzysztof


