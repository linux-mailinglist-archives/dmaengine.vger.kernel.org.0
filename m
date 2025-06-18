Return-Path: <dmaengine+bounces-5532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A909DADE764
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DED53B9833
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CE2820A8;
	Wed, 18 Jun 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRyAipns"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00627FD59;
	Wed, 18 Jun 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239764; cv=none; b=C6ABQi4UmDtkABPlQYpkcy+In1yw1uzsUU4Ncxrm77zcELq6k9Jc8jiOg7F5ikWTdc67A9Iu87kg0u8ASlS5Jc4ZVZ36CwFbmzwiR1kJbADKufHttV2LnwGfKCIoXV51Gf2ZW0TIYeyQbbRFUlTeAN4nXhTj5J+nzONxMSe8Wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239764; c=relaxed/simple;
	bh=QFN6YR0t8F3HIowOt0b4TfDFzltjdytD41c1NAiofmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNXNc63vFyLGRh3cpYTxGihTB24KnwnuitylzaQaR6X8E0m9UVBbqbpxpkkeRfKrtU8/KP+2/rs5vfCgOhub13bXEvJHArkjisHnPEbj0dHy8KAo/vw4cCUmBI+KSbo054pyO/CuNJE8aOsyf+nNWMA/nrm/A4R28gseXuuC+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRyAipns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DBBC4CEE7;
	Wed, 18 Jun 2025 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750239762;
	bh=QFN6YR0t8F3HIowOt0b4TfDFzltjdytD41c1NAiofmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRyAipns3EE9QymXHgam6qF8i7LcjuO/rCWLRQiPMJduifseTTZveIqdTG3AKCiMN
	 xWsh1m38ltECia1PTOK19E3njW5SFLk59A7wKtnS1ZtzdGaVm8JSqFzB70A1JAJmtb
	 Pc9PXdCQOTFbtyOp/Iw8H/3PeIRHP5l2M3lO+ldJLcKMwNvCmtuPUCCdthUXf0pYpG
	 2Tu91FedF+AmU5h9bKARQz3albMdDg7GWhKSD8ZV9DclwE71Hl4+NO5mepbfsap3T4
	 Xkh9p1EEFqxKfCanoZHBfQqFVDkx4hh14bQp2xf9hMrpiATivq8ggo9ovBThEHUaRa
	 3pyFEoeDvDKjw==
Date: Wed, 18 Jun 2025 11:42:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: qcom,gpi: Document the sc8280xp
 GPI DMA engine
Message-ID: <20250618-rough-optimal-dragon-3358a4@kuoka>
References: <20250617090032.1487382-1-mitltlatltl@gmail.com>
 <20250617090032.1487382-2-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617090032.1487382-2-mitltlatltl@gmail.com>

On Tue, Jun 17, 2025 at 05:00:31PM GMT, Pengyu Luo wrote:
> Document the GPI DMA engine on the sc8280xp platform.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


