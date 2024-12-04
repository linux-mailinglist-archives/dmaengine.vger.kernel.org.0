Return-Path: <dmaengine+bounces-3887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA29E3B1F
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7943B282B56
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BA1E00BE;
	Wed,  4 Dec 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpIhi9Rk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DD1CEAD6;
	Wed,  4 Dec 2024 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318345; cv=none; b=Ow3sDIzHLShYGdb5IIq9r+FuDKQ0ykIhqKuuLZGj79h7EBqTo/6DFbTqYZ5EYLa5L68UIGAsyjeLOz9n+ow4IKUhkqhZYOz6zCxmqyXjjuWwN7Z+y1n1cO/c28NoC73IDGfkpkjckMwkc1Inpf4+WrJ3K6WkgLUdlTzTrcepovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318345; c=relaxed/simple;
	bh=NUA39rehtYvADj0ngQK4ICqhBTOri7NSzSD38ajApu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cYO5TX3CUZl1JadJPsNqQsH4B1aMtWTYO2bOD4YNAVHdDuKUhwY2UP+tuLkynqzerVrQLT8j1By9TnFzQyrjvvbnqZeAI0ivD+E/tAAnnDtBpxmIZDcwiZYkcMlZYo7pbn2ldMyWdBAVRXu9bebYOTJyfKkY9aOYSc1LM3FwDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpIhi9Rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BEBC4CED1;
	Wed,  4 Dec 2024 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318344;
	bh=NUA39rehtYvADj0ngQK4ICqhBTOri7NSzSD38ajApu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JpIhi9Rk6VDqzd/TCwaIKHRQ9AhtoQ0+q8XLZSuQJodlDw1PDO4pTWd1aV2ZsCtG3
	 JfIGMg787zQKNQdyh/e/HnX2lv+6r/iN3pkBQMFWg+az2yrRDod+yEDDNQk8tM2Ev0
	 x+jCTOlWwzV569YVuQYJeq9keA4bHrpWWJyYeBVewaXXlXYrBT5oMglETZOdivhxmv
	 UWoZWSAXFGLkCZWzz+ug0IyxVQZsszp6xLb23fC+TV+2UBz4y53PcTjNRWZxQ4MbE4
	 01L+XzqHVsdnV5xxTRfhxN9q9+qRt6BdDow+JoTjgZXDreWwM5do1i6VFpoRuXWIWz
	 B9EyGWxrxtFbA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Mark Brown <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20241122161128.2619172-1-csokas.bence@prolan.hu>
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
Subject: Re: (subset) [PATCH v5 0/5] Add support for DMA of F1C100s
Message-Id: <173331833897.673424.223627111827356616.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:48:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Fri, 22 Nov 2024 17:11:23 +0100, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")
> 
> [...]

Applied, thanks!

[1/5] dma-engine: sun4i: Add a quirk to support different chips
      commit: eeca1b60138189ef1b9636709e578d0c9e0de517
[2/5] dma-engine: sun4i: Add has_reset option to quirk
      commit: 1f738d0c2f67ae3551e4543e8dddbfb44cdd9f53
[3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
      commit: 1ad2ebf3be836e62792788f4cd105b30ca9178b6
[4/5] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
      commit: 61785259d1eb4e4c4acef8551a2524441683dbf3

Best regards,
-- 
~Vinod



