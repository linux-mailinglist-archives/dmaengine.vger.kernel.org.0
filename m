Return-Path: <dmaengine+bounces-4540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCAEA3CCD3
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 23:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641431896F31
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53925B688;
	Wed, 19 Feb 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rozmEAw8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6B2586FC;
	Wed, 19 Feb 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005948; cv=none; b=Yt8oNegJfjKhQRTzypp2OZPWPCdTZPT/+/t/BY3NYrRCXxJnuELCUHoqHnoF9gnlOoTvuPJiPwAidKASyAuAht6j1UGbQr+/drXJorwQurG4g7TnD7ViGT/p7MA1lz6v0A7Q82MLdSYLfirfP6LCGi4mi7ka93bpaXFbDCTgocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005948; c=relaxed/simple;
	bh=r+7eAlT4+3FG2hpqxWqAqIl6I74a1KunJgrKRdfmESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOHIwIBlLyd5u7vAnwS+1UQfx7svP7SWfY7OatWsqAQ1vlPiSOqzUFGY2W95x0Vqniv9qbeMH0GQGIT6zXBfEH4/1oFkThvYKrjKXKQP9h6rFz9UfnGDw9GjJOndUqaix2vuTC3O4tivIUn+HX081C7DU/Dm0APJUyXVWKwa2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rozmEAw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3840AC4CED1;
	Wed, 19 Feb 2025 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005948;
	bh=r+7eAlT4+3FG2hpqxWqAqIl6I74a1KunJgrKRdfmESE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rozmEAw83f9qN1WR6N37zTgAhFm06zr7zVBHVZ7y+or4MmkdruMiEWiuOzrMOpRuV
	 l4AMrvBcoyVM93kJc9rGPJtsdrHxCpojBD5ch5SLtWxz+OC7wLcLsRaZexRhwZGnMc
	 hcjxny1MR9SNU+Oak7xcIdtLyOKigmefhVZ7ZxdTdYLTM0LycMZY76nwbFPb77GLGW
	 ydGe3l4iSRZfvhiya2KxtCXdWFprFX6k9PAdHT5mMI9eRg+5Ij17VvrAVGgMuN+kwO
	 WpTSMJswJRTBhExSmW0eEAIr1XEjGKYAZUb4g44v43pzKF1FHtVMnTxNoFmAs9q03w
	 5m/tbrgRvSw2Q==
Date: Wed, 19 Feb 2025 16:59:07 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	vkoul@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
Message-ID: <20250219225907.GA3124757-robh@kernel.org>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <008e4e49c9fd315cc96a185662b31eca1a64a614.1739555984.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008e4e49c9fd315cc96a185662b31eca1a64a614.1739555984.git.Ryan.Wanner@microchip.com>

On Fri, Feb 14, 2025 at 11:08:14AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add compatible string for SAMA7D65 SoC ChipID dt-bindings.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

But please convert this to schema.

Rob

