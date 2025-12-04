Return-Path: <dmaengine+bounces-7506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B2CA57E4
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 22:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57D993063A33
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717192FF159;
	Thu,  4 Dec 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlPdaAfa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222C2741AB;
	Thu,  4 Dec 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884196; cv=none; b=P6EGAkCeV+Kv0A8JpZcOApgiqz3JJmRonNkuSpZSnGgCrL4aYr3KS6sj8qPITDhzyJZ8EzXfM0Fn1iuPLt2Ty6tGbV2GuIEA3HUl24bEYeibCVW/WboEtO7OD3VF9lMa5TXt98NyjewLmY7fXooVgpcEa0gBvYz4dw/ofcIOxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884196; c=relaxed/simple;
	bh=364uo4R19wBUN9DtJRd+36+KuRNDgwgor8/CpcvYBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s03oP++9pHmFugXwJT2dwx48dGSNE+VWqIzVjxT0YBT0a3U72DnZJRXXOpUhgyceFxxSqDksV6euaYV9Qv9yZoX+0c3MhYv0ENQyM4w5VAis6BeFZlz3OUX2FCs2x99deP4oXpmaDwfp5wR0N+773CEURizfxKWE8SaDT0AN8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlPdaAfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE1C4CEFB;
	Thu,  4 Dec 2025 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764884195;
	bh=364uo4R19wBUN9DtJRd+36+KuRNDgwgor8/CpcvYBPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlPdaAfa3UGOjholSMCtQ/6wRaYnVNVJNsCyAQT60lcJbq3kf+DbkJ/3C8hOq2Uz3
	 1X6kR5poAatjS/0AVJwtbTWyoTCmGTd7w1kQUn6eX3HGYb6aLaUeLcz/quK3KBM+zW
	 PdvNZ287lYUqMxM8E5Pj3UOf8PpWO0x+/c7ZbYtvF5FEGGIkWrKFyKSH20BJh1fSyV
	 Fc482g1rp8+pJCpgl9bP6/iadbqmpsEWj8mq16YCBDGQ0ARWdINloyK5EfKp/xRgSm
	 S9u7ThvUg9hkp0rua7wovI0oBj0wKVGVRhzejeoFlPazW3/UFrS9/I5XzBwQ0otwRh
	 b/A/UrfMeEw/A==
Date: Thu, 4 Dec 2025 15:36:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent
 property
Message-ID: <176488419217.2206248.9983976146883123306.robh@kernel.org>
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
 <fa3777579d15a803c4330c2a536f0026ae6f9fd1.1764717960.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3777579d15a803c4330c2a536f0026ae6f9fd1.1764717960.git.khairul.anuar.romli@altera.com>


On Wed, 03 Dec 2025 07:47:33 +0800, Khairul Anuar Romli wrote:
> The Cadence HP NAND Flash Controller on supports DMA transactions through
> a coherent interconnect. In previous generations SoC (Stratix10 and Agilex)
> the interconnect was non-coherent, hence there is no need for dma-coherent
> property to be presence. In Agilex 5, the architecture has changed. It
> introduced a coherent interconnect that supports cache-coherent DMA.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Rephrase commit message to describe why the property is needed now
> 	  and was not needed previously.
> 	- Remove redundant statement.
> ---
>  Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


