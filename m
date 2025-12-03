Return-Path: <dmaengine+bounces-7497-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 876EDCA1DE1
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CCE530053F3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D42DEA9B;
	Wed,  3 Dec 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+GTFvC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E272DA75C;
	Wed,  3 Dec 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802355; cv=none; b=kLacxUn92mNRoqOwcwMIprrsYyJrkXgu3qNL4dVECZ9hCaAOuDF3A3G9B/KFaCM0pQcMzm4RsmHqzKfdNCruYQZrgBjVE9PwxRBpkENa7u75iSaYyq6hNIJNMhjkf6DZsbWUYrWSbkosOMyOzxbNafliYBCCRPSrW4hMpuGpGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802355; c=relaxed/simple;
	bh=sI020P7qBWnq5Hq6FRxOGSZbde2bx3Zr3sKIJs+/pIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW+JHAEDcmMjOhOwZ8bPiSKK5IZshMiNnEDsefuf+b7RK0nHVafYfxC8P6nGNfgAarwrM4fvmsJTDTPmHd9NTrV/IDs5QEBbLTWKxGcE25J7p/6gbucjbxRf8wHRpveX9uvTiJ43jKoiEZ4PIqtWptPQH87ErZZ+Z7aFHCsNiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+GTFvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F34C4CEF5;
	Wed,  3 Dec 2025 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764802355;
	bh=sI020P7qBWnq5Hq6FRxOGSZbde2bx3Zr3sKIJs+/pIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW+GTFvC0+oEcgbGRDu7WA0iwVy92MJ3dFIQsXlAWyCID8DnLoJ9dx946maZhUFWl
	 SK5U04QG6D6jRDVUJr8CmLPyCnG+5goV7jVBdiwOkUcU5QsChUoQjCuUkByn61+3Oj
	 EhjCoenHT2iHXMaKV2ZSshxaI81kVEcAB6hKntwHNHRPTuVHEtyr1xGkVMhW7VMC33
	 pqvEyOer0oTpMgGZClIP9yX/jlF1Mi4Inr9BL3tFsIgnRZX1GTDAdZMNIBgL7wo9qS
	 pk3TSaHoIpi+Rzzpdt12w3tbbceh+ji2BkO/q0i13Fm+heSXLZ32UmzNmlIMXwsUSR
	 vjKwlX4WfpuWA==
Date: Wed, 3 Dec 2025 16:52:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Michael Tretter <m.tretter@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Harini Katakam <harini.katakam@amd.com>,
	dri-devel@lists.freedesktop.org,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jyri Sarha <jyri.sarha@iki.fi>, Michal Simek <michal.simek@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-mmc@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display/ti: Simplify dma-coherent
 property
Message-ID: <176480235071.4159178.4317055893040212478.robh@kernel.org>
References: <20251115122120.35315-4-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115122120.35315-4-krzk@kernel.org>


On Sat, 15 Nov 2025 13:21:21 +0100, Krzysztof Kozlowski wrote:
> Common boolean properties need to be only allowed in the binding
> (":true"), because their type is already defined by core DT schema.
> Simplify dma-coherent property to match common syntax.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 3 +--
>  Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Applied, thanks!


