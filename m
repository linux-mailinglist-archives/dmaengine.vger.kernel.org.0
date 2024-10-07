Return-Path: <dmaengine+bounces-3295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16B9935B1
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D56B1F23B06
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E31DDA3B;
	Mon,  7 Oct 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaLnx8vS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66201D95AA;
	Mon,  7 Oct 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324490; cv=none; b=sk+W72BRRYWd42vrlZpi6++epLeqF2h8jZ9kvuUqyuHkturvAAy9PQGlFZYDitPkNd2NsGy43Vq6+EWr1hNyRpzxyW8/vOj70mk0H0EcgxQxG3SchObEsiCJ9hz4utqcHZJXwlwtMiPR048efwAGKSIge5EEjdzIhkdwAsoim4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324490; c=relaxed/simple;
	bh=IPFzDLsNRSoWt9fPZCpVLASQuqXJrcbJbWblJUCSip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh0ez1jJHJGGZIPe1hWDiK8eXW6zEWjzUN51vPsmk7Dv2lmMpsY5VKAGtjp5Ft51fD+kr425WcWafGIQRfi80dDQLDxS115Z46iyJ/ykfYAuZTJ5vYiELg1VkV/tSXLuJ3Xfs7tpke7yTb/j89Zb0TB+DMP5rfQ3NBG+qCdXuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaLnx8vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6359FC4CEC6;
	Mon,  7 Oct 2024 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324490;
	bh=IPFzDLsNRSoWt9fPZCpVLASQuqXJrcbJbWblJUCSip8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaLnx8vSRPvdlfdFmNY6Ib3431crAq0BHC9b5nr2iqZWlTkpl4ArN15NlzJfMYus+
	 LH829641fIYY1kSuo0+jXlHhbxq+3OkYVnWPajVYQUcZv8qSHWgNZJIxnnc4W9lY1U
	 kUD10Y4S39WDBZW469EttkUQjH8bU6hyvk8VYGHrDLguEvr0okMWKBYDUPWwCVXzHq
	 iz9kJL4fKon1XmSjCCvYHX82hsctxo8ouoz6Xg2Bf4f2pevj4KSDL4YLyQpVeLApUd
	 O3KCUy39YZSTFO57WaXFyghmy1HW3fLvJ79Src52MZ9iU0Hi/JCM+rj6si1A8b4/w5
	 Sngftn1hKnjSg==
Date: Mon, 7 Oct 2024 13:08:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
Message-ID: <172832408385.1743213.11072081852329207450.robh@kernel.org>
References: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
 <20241007110200.43166-7-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007110200.43166-7-wsa+renesas@sang-engineering.com>


On Mon, 07 Oct 2024 13:02:02 +0200, Wolfram Sang wrote:
> Document the Renesas RZ/A1H DMAC block. This one does not have clocks,
> resets and power domains. Update the bindings accordingly. Introduce a
> generic name in the header to make future additions easier.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 29 +++++++++++++------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


