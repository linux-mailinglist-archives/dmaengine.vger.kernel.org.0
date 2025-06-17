Return-Path: <dmaengine+bounces-5506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B4ADC326
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 09:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E9D3ACED6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DF28CF77;
	Tue, 17 Jun 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc+wNf3/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83A86331;
	Tue, 17 Jun 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144764; cv=none; b=bL5XIfY/UTxl7hZlzqY9LBkgTreByb0uliQref+pwQTbAeApvohVOsICcwxuyAdcnC6vrT3dHxLmHDcoM3oqW5/3L6VDfudliv9KG6CXM5BtPr1ck6AyL3+YiBgDTx0Gj1kOFUzFMgo1Lqc7whBNVl+THKbmTFm6173mpwyGW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144764; c=relaxed/simple;
	bh=Phf1sRy8XYB4YNoLwthL5sOcMYnwQzL1a67ORD47Jbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7AYMR6L2N/U+nI3OXs+Rkuu1T4WLxA+IrB8NuwLCOz6DZxNUuvKHoQjF0xd4N3hGIDXarFzz8KWJ/dCuJPTcVSmtu+X38Gcv8JYGBn/h8KxRxlhhuON6JS0swZqmOeLJ1ircO34RA25FN0hMUG3ps9tvA0TFyN8hmo+KkXeFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc+wNf3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F477C4CEE3;
	Tue, 17 Jun 2025 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750144763;
	bh=Phf1sRy8XYB4YNoLwthL5sOcMYnwQzL1a67ORD47Jbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc+wNf3/4s4RWGBb4BxYtONT9gEX3L309QzMhaWrfMERSklZtXLDgNHIAn32pxJyq
	 o9iDJQqh79fsNvC2H1dDVMn7p2GTIWDYbFg5XU78XQI1SszQ3hl1W7n9v0/pfcR0Rm
	 i5lQLTW1gjr5cQj9EQzyLBpc6CugIEFx9uPFqD8wL9S1EBeE+amH/3Wmt9Oztnw39I
	 X+W7Khdaum6V162bwBIcEASmORIM4wCtIDVhxDkQejKGpT10+Ac81osZTLyhDmdPsv
	 I6kOWVPEHN4sVKf5NBGf9EIVazFxU09S28P6BolJ16LLVlHUgNkdYbeUFjKR2sikRE
	 2aL9mDktAui4Q==
Date: Tue, 17 Jun 2025 09:19:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: mtd: cadence: Add iommus and
 dma-coherent properties
Message-ID: <20250617-positive-saluki-of-music-a0a326@kuoka>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
 <8787d4b22c801a18662e32e247665c2d3dcb0410.1750084527.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8787d4b22c801a18662e32e247665c2d3dcb0410.1750084527.git.adrianhoyin.ng@altera.com>

On Mon, Jun 16, 2025 at 10:40:46PM GMT, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Update bindings to include iommus and dma-coherent as an optional
> properties.

Why? What you did we see. I don't understand why device which was not
DMA coherent now is marked as DMA coherent.

This applies to all your patches - each of them does not explain why you
are doing things.

Best regards,
Krzysztof


