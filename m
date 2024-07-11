Return-Path: <dmaengine+bounces-2682-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971F92F24E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 00:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2971F22517
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E31A01AD;
	Thu, 11 Jul 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCTampXI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F319FA96;
	Thu, 11 Jul 2024 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738427; cv=none; b=uElyiG7mDBWX4h+OcJ/Tnon7VC0EEo1w0Fmlp5u0bNE3HZ+CyJ7AyJgPbL1Vtl2X38sPwqoXgyqC/47v0/libc0mg9tSQuuYpGtI4zhd1mPvWD+JcIQ1vScBZuV86S02ce56AYYBJ8QT6A7LKQmRX+b23c5gSgsf/ZwoSOGHmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738427; c=relaxed/simple;
	bh=XI0JQ5+wMzOU7+T9tpSRMedqhV5Ai9rJgS5QcKd8d6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/vDEVmLoXjDyHEGLx583eeYQUlznRDFKjTLBG+AgbeqP9SyeHcU3reoTeESE+sVlpPgVYNuUk264MpUqC8XEbhXAfHZ52gIEFlnPLZ1P7OMbaAx0jLXFEGfnNP5YJzY+DjSgWmLTWEGKzWw0ucqnhD6Td6ndWiuelml4ZfVSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCTampXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68108C32782;
	Thu, 11 Jul 2024 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720738426;
	bh=XI0JQ5+wMzOU7+T9tpSRMedqhV5Ai9rJgS5QcKd8d6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCTampXID1ylnvLTVA6LVYE3FtZ8sabDqQulHG+WSBEzOzwZ0boAeW1pNVVi3b5rA
	 S5a/au/367ajASu4EO7UgcfvAfVk25eu8Ytacf9nZ1zGAHJJ/AUwy7lCPrsvBOdsdK
	 zsus4btiyF5dYTsxDfoDx42IOEcRSi3g4xhfTvOdOtEKqi2cCYJxp68OhWBBvW8frT
	 slIGWeFxNGUy9x7tTjJVogCEieZnj4REmfRRwl/s+wUIUPpL1F+uGwBZZAQ4Ttmm+s
	 lE3AdZFCT53XpbKooUyfkCxVcD6Yn2ecAi/YUF5j1SJGTSqbU7Wyn9TNBvN9Fgnhnq
	 YXh5h22R+8sXA==
Date: Thu, 11 Jul 2024 16:53:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: devicetree@vger.kernel.org, geert+renesas@glider.be,
	conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org,
	mturquette@baylibre.com, vkoul@kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	biju.das.jz@bp.renesas.com, sboyd@kernel.org,
	dmaengine@vger.kernel.org, krzk+dt@kernel.org,
	linux-clk@vger.kernel.org, magnus.damm@gmail.com
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
Message-ID: <172073842432.3270356.13976305487495641614.robh@kernel.org>
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
 <20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com>


On Thu, 11 Jul 2024 15:34:04 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document the Renesas RZ/G3S DMAC block. This is identical to the one found
> on the RZ/G2L SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


