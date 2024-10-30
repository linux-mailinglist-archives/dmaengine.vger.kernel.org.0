Return-Path: <dmaengine+bounces-3651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25659B6EAF
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE451C21A88
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730231E0489;
	Wed, 30 Oct 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppG9l/CR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D21DF732;
	Wed, 30 Oct 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323177; cv=none; b=NNyIvbCTke8kDlryfm968l3kncgNYz8f55SLUwhy2kL8p8RWNTs0ezxvDG7IdxfiQ+eK+L9N+SKoC56OHtqyHfBlIkaBuwYZJ88IVnG+ppWm6et9IAVlLArHlC9zD4+BXtZhqKQCjfO+ercZpY+FSn1ZA2ytYNySLX21Do/x9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323177; c=relaxed/simple;
	bh=lZ6GCBtJasAOogYq75Nmv+J2ej0+lI7N5bwySHOHTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=comqXfMicPFyLlRNhG0XeucB1SApsBiS/o8hDxvsS7aJI61ttgMvKCWs0CY+Ee+l2sNnmkNX4WwuEOvqARS0Kp8nRL5E1E45r65geOYjW8BXlAX5JmygGz9yUiivjbzh/cC3I+2sxl9fGtmUEEZCREaY9h0c3kf+L+P32WqzPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppG9l/CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62DEC4CECE;
	Wed, 30 Oct 2024 21:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323176;
	bh=lZ6GCBtJasAOogYq75Nmv+J2ej0+lI7N5bwySHOHTEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppG9l/CRQ/bTYHKdnv3wTUCAhwbtzhMxWzyjXknz0FwV/UpUKY0BBGJH5wSOvLww/
	 MXDDvUQcjayVsPCTW3A1du3wmej8181WM2A0E9PpwJG0qThSiQAxy0ghYs08o9bS6V
	 4m5Lp4td8XHLb6wVXgj2qcxSvjKcE5ZBWlSz+akvnK0V6e5fjBC5TL65+Yc7j4RQvC
	 tL722lFNMhj4bYbguFSE82A99ESKBNMRG/VRT08oBGIyQ37jUB41Pg1Znm9VYBaOmg
	 31qxfS9isGvJOhmO0N2ST1XjyJgbTpVEIQ0uX1aCFqgBLRx5JcJBW7d8kVIHlP4QQJ
	 sshou2iVRxKlw==
Date: Wed, 30 Oct 2024 16:19:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node
Message-ID: <173032314856.2055121.10271317801673936435.robh@kernel.org>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
 <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>


On Tue, 29 Oct 2024 14:29:15 -0500, David Lechner wrote:
> Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
> IP version 4.3.a, this information was required. Since then, there are
> memory-mapped registers that can be read to get the same information.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> For context, the adi,channels node has not been required in the Linux
> kernel since [1].
> 
> [1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
> ---
>  .../devicetree/bindings/dma/adi,axi-dmac.yaml         | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 

With 'required' fixed:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


