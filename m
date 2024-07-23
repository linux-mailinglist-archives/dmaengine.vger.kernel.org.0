Return-Path: <dmaengine+bounces-2732-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A531A93A8A3
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 23:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4761F22126
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155AC143C5D;
	Tue, 23 Jul 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DicJMZHY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4F142E83;
	Tue, 23 Jul 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769840; cv=none; b=IjSQqoWspCePAPU1ld5X0iBbJcy+mrJklHCBDv9jDKtsQEwkcAyPI8lw5DK4GwZypeBiM1lxci65zwohGM6UGvmMXCrgVTblG2XlPsS7va+mmI+yyzfFxEZr5k3Jk/anR6JEQ2KGLolLWgXjD6X3XMy9A8sDMqSLe2jmFmd8ayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769840; c=relaxed/simple;
	bh=P9pr3+m7t3wp6988hnLFFKmyPOf+kz6tG11Ln4YfwpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p73g5vbGCUFVfxPa39wBb8YDNfbV6vLKhL9P53CMmtNEmN0dXQTvi+9BfwuNSSN7QfNM1yOzCs3Tb52kY/FY3IOxSqmBNChOXiB/kxfWvPb9l6J6Vp7lzTL8L9vG8K6tU9gUYkrbsprm/Jro0FCvpwoNfveojD0PReNUJuwKkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DicJMZHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8864AC4AF09;
	Tue, 23 Jul 2024 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721769839;
	bh=P9pr3+m7t3wp6988hnLFFKmyPOf+kz6tG11Ln4YfwpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DicJMZHY7CQqLkXZzq5e7D9FUoNGkx/RFZBusN6tlOYQGx7twHJEk8MGa8NroQFiI
	 0y10xqvPAz6xJFTP6awQTjCsq/n8HfjBBUxlFWXlJSNWU1ReauVHqTWzBIfKOCYKMu
	 7ly0cAqAZ9THtJU2hHtEULMIhdMhGUxyFIoyxKpokPqDxqMvER+fHCi5WCOVadMUhg
	 56JrS0snC9oDgUgeHL/xc1JNDC3lNsgkgJO/vzYRI17lpiHq1+LYXAYYfAAGOLVUFw
	 ucZGqCxu0zjCqfB/e0rd7y/2eoaMhE5Ci3/wxZhgiXbEVUXMSLFf0RQ1BiOE4P9mGB
	 jYQF8DFTzq46g==
Date: Tue, 23 Jul 2024 16:23:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	andrew@lunn.ch, dmaengine@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: mv-xor-v2: Convert to dtschema
Message-ID: <172176983632.1127918.8468061614483310922.robh@kernel.org>
References: <20240723095518.9364-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723095518.9364-2-shresthprasad7@gmail.com>


On Tue, 23 Jul 2024 15:25:19 +0530, Shresth Prasad wrote:
> Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
> for validation.
> 
> Also add missing property `dma-coherent` as `drivers/dma/mv_xor_v2.c`
> calls various dma-coherent memory functions.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v3:
>     - Change maintainer
>     - Simplify binding by removing `if:` block
> 
> Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
> and `marvell/armada-8080-db.dtb`
> ---
>  .../bindings/dma/marvell,xor-v2.yaml          | 61 +++++++++++++++++++
>  .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 ---------
>  2 files changed, 61 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


