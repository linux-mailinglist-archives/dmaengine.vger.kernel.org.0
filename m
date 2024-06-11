Return-Path: <dmaengine+bounces-2333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F146D903DE1
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CDE1C23A66
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C117CA1F;
	Tue, 11 Jun 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mywbSxRw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898221E4AF;
	Tue, 11 Jun 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113672; cv=none; b=tKL7z2bW3pamCGBlQ00z1YK+bhAnui9PMtgK0E8t1gdR0hW9Vw+lSXDH/DC/5ta4kta4eZ5+aAZd3DABrqvwCBJkSWdoNbc2LaQ4X62/fp8/y9Ic7OngoeSN1tFVNzsNgrSIUv+Mzt1+ZYkkHx6n9aSfQgQr5FLZFSO9MI1ZvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113672; c=relaxed/simple;
	bh=vziXDxPFWpaRQe9ayJKRHJKfaw7h6fZZuPvRk72BT/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaSuDtrb7cEfdDYDBVxt4zFHtuDstC4bzFGGIHbpPJwYlU+j/wKeDAwcY6ZKtUtnvtJQDX3h9zE+StIZgtG3v9OQ7HMNyMEZsc27GwcGhKN0hOe1xLEdptYwyI+53/vXaOY/qh3ge20LKRT1M4YMo0wIMvHA8MoaUEj22JwP8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mywbSxRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA408C2BD10;
	Tue, 11 Jun 2024 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718113672;
	bh=vziXDxPFWpaRQe9ayJKRHJKfaw7h6fZZuPvRk72BT/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mywbSxRwEZN69ovXG9suAFZtgFowPVp9WB5S8xnTenWiFUmXTRT8f/7kNpkB8k0YF
	 xCdGdbM2PbejW2Y/RXbbXjkItLfadQMzcwnyjHSoEQXSZjrgkKAeYdOySqvF98L9CZ
	 JhCnyG6jH1lHCF/1txD7AWQdxz0zbcypzABVj/380+GPi1NyCqRzQBXscviNVhvkGM
	 4LlJrYZ5TN83Nl23YTF7y4kZuo5Gl32PZwrctRiYZh5pIX9qw/HI+XE0znX+LuudPY
	 gN4cXmRmPFar40ZDRAM12EXybrblNsAcKdJZelMGM9XJPdG94grvR19esazdVVgaNJ
	 tvG77IVrFWf4A==
Date: Tue, 11 Jun 2024 07:47:50 -0600
From: Rob Herring <robh@kernel.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: vkoul@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: qcom,gpi: document the SDX75 GPI
 DMA Engine
Message-ID: <20240611134750.GA1800425-robh@kernel.org>
References: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
 <20240517100423.2006022-2-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517100423.2006022-2-quic_rohiagar@quicinc.com>

On Fri, May 17, 2024 at 03:34:22PM +0530, Rohit Agarwal wrote:
> Document the GPI DMA Engine on the SDX75 Platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Looks like this was missed, so I've applied it.

Rob

