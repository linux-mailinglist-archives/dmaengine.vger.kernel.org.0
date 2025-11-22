Return-Path: <dmaengine+bounces-7303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF5C7CB70
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308E54E3E03
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3632F1FFC;
	Sat, 22 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQsqXTRv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9E2F068E;
	Sat, 22 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803833; cv=none; b=Lh+wir9t4iiqWkuXwgMeaPxWMfsBgS6F4xOs5FT3LSbJWIq7j1jm7Gu5iLLQJtuI8dgOTCR0CkhLXIz7v/2PXVb+GIhKi7dxzQmLygCTQ0wajhF9X6UKzjFk/yH2n+tOQFtwjawmtIdKYiYEoMRcRR8hx46sMzsb18AJDbQAswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803833; c=relaxed/simple;
	bh=Mna69aGIWTG040yDqYFP32iKOKMkmBLp/YLju5u8/i4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GBdXb0Rsl4eIE8puI4zHQUVWwjjcPsiSMeS2GJOksbVADc0Iuqpx7oGY+t9HAViC1Ma9KEyt+0GN3/Hpc6Txf42T+EDZMXunSHnL89EV7PveDZ69LEjIL1TKy8eJ5PyX5Pz7W9FTP35BNOIh/uTUH1rNVARdaV9xco4WPHD5RBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQsqXTRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7FDC4CEF5;
	Sat, 22 Nov 2025 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803833;
	bh=Mna69aGIWTG040yDqYFP32iKOKMkmBLp/YLju5u8/i4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=XQsqXTRvU2jmY+FoyVriMGIM2lCY/KGpCbk0y3rLair5sClbL38j7jpbS/9Xa6By6
	 9urj36wQOJ22rrvsgTiARRudTJOScq5kxreMKqhssWrpmgGkE2RVZcHIWM4Poy4rM3
	 QdLKmLm2cJZ+SpVnztqc2EICsb3CjB3WI3xiZQFx4YiiJk5H6+PZbKDGajbH9yIMAP
	 Qja9x7pBlaOo4Q5geVfJX/UKekIgfOD3D4wKYlQOZbLbajzYrFAdLb7TK0Drx6vuzL
	 hMY2356p7MuHpSBNd0NQN3YQK/NdYia/2mVTfcnbYfX1DFlpZrHj8MHLZiU+VJG8AY
	 rL2dgSGlSiC1g==
From: Vinod Koul <vkoul@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Harini Katakam <harini.katakam@amd.com>, 
 Shyam Pandey <radhey.shyam.pandey@amd.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20251115122120.35315-4-krzk@kernel.org>
References: <20251115122120.35315-4-krzk@kernel.org>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: display/ti: Simplify
 dma-coherent property
Message-Id: <176380382732.330370.6897973722386830708.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 15 Nov 2025 13:21:21 +0100, Krzysztof Kozlowski wrote:
> Common boolean properties need to be only allowed in the binding
> (":true"), because their type is already defined by core DT schema.
> Simplify dma-coherent property to match common syntax.
> 
> 

Applied, thanks!

[2/3] dt-bindings: dma: xilinx: Simplify dma-coherent property
      commit: 2b11e7403a8ed816fce38b57cb88e04d997aa7af

Best regards,
-- 
~Vinod



