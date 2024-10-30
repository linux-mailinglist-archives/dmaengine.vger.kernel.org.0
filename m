Return-Path: <dmaengine+bounces-3650-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA49B6EA0
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B839A1F2276A
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA51DD9A8;
	Wed, 30 Oct 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSBxgvzt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91011BD9D3;
	Wed, 30 Oct 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323104; cv=none; b=lJcssM1ump6Yf91Cmnx8ibBXQHaXYIYhnlWE+wAvablYQwcKhopaIyDQCFMtzVl/pH2iNNq3nz4d0yFxDFjJFJxzdTrX1g7zXgrhLHjveXKuOXzLlF4n+MezYNFDDfAY/EWdF6xswZ+ghSuH6+mVax6M2TG6pE+oHMR22b4P1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323104; c=relaxed/simple;
	bh=3BBANKyeKVKDGcIjEeL8qVZENm0DzfnsMr9bdNswKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mowtLP7j1KaXbSIXlg4wryRXoClF9b75zjKB8R5K5HH4eKeJLmWOl7PVG/BKdYfDfnIHn7vJXwziPeN3XtTSBzTlFUPgLTsvpdd66xa5Z2bIB1LPXVJ5AwkyVitLoqhqpCrQGnEeKQXbfEKvezSO0oZjOk210XvNia+NtsBkF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSBxgvzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BBBC4CECE;
	Wed, 30 Oct 2024 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323103;
	bh=3BBANKyeKVKDGcIjEeL8qVZENm0DzfnsMr9bdNswKeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSBxgvzt+6RXr87w8QiDOnWep2kzSZeJQQIrnJ1xuD2GoDmLlgh9SMFat8LUyq03W
	 HDYU4lgCK+ldgMN2GO+7Wo0wrVknbDGuD5574Nx5H7H4BseZIHkx+blLtBix0dc8Om
	 1OaX8G68eS6pd6KsDu1WCvt+elPcrBJvvkWeAresX7wXCti2cdd94ORlDlkhb/9i+W
	 MoinRU4i+fqEoG4JqMe4S9tBtxtTULKLtE7TtebiOyYjtPEgcN7xtxnpYLjMUt8hTH
	 /KaHmIK9r80Gn1Si8VHumZOTlDjp5NH7WPgdUHZY1GbUHbsoJ//26GvUvKhcd12HFd
	 rIUtI10h17kyg==
Date: Wed, 30 Oct 2024 16:18:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Nuno Sa <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema
Message-ID: <173032310079.2048575.8476862949520338048.robh@kernel.org>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
 <20241029-axi-dma-dt-yaml-v2-1-52a6ec7df251@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-1-52a6ec7df251@baylibre.com>


On Tue, 29 Oct 2024 14:29:14 -0500, David Lechner wrote:
> Convert the AXI DMAC bindings from .txt to .yaml.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For the maintainer, Lars is the original author, but isn't really
> active with ADI anymore, so I have added Nuno instead since he is the
> most active ADI representative currently and is knowledgeable about this
> hardware.
> 
> As in v1, the rob-bot is likely to complain with the following:
> 
> 	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
> 		hint: A vendor boolean property can use "type: boolean"
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb
> 
> This is due to the fact that we have a vendor prefix on an object node.
> We can't change that since it is an existing binding. Rob said he will
> fix this in dtschema.
> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 139 +++++++++++++++++++++
>  2 files changed, 139 insertions(+), 61 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


