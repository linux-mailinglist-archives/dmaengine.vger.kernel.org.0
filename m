Return-Path: <dmaengine+bounces-6677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D34B926DF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC931446130
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D8313E3E;
	Mon, 22 Sep 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3O2u9Ll"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1183313E36;
	Mon, 22 Sep 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562140; cv=none; b=egXwTEkL9hPV60RrChMFHpVBwLeYqAsliRX+C9sjhtU2bMKGztbX6p0R/gI9IXuv6wctEJ2LOa5HY0D47WxRS5NYYSPI3PFOnm55G9+wPaMWKUtFlBuuJGolERM8TuhfJSUoG9K5quWp0yAIf7FI6M1Bx5oXc1Dp3Coz053e7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562140; c=relaxed/simple;
	bh=qKTWX8YQX6X+VVQHqmpTLZSqhVSgkJOvRciy4qdPVhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNunKbqG0tFFbsau/WqXB6JvzRWZtzf84h7EydefuGfEZy7yC0lnLoUGA1X0WTIQLb4wGMGwUSI7ShCDzHQV/0k+DdP0gQHfGfN76Gk2gu9rxh24rZSkqtzYcUeeIhQsuk5Fktox0h46UZZn9ohdNVFCBtmvM0gyxg/NgDywSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3O2u9Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DBFC4CEF0;
	Mon, 22 Sep 2025 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562139;
	bh=qKTWX8YQX6X+VVQHqmpTLZSqhVSgkJOvRciy4qdPVhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3O2u9LlA4ijIwdwrHLx9dR79M75QwjSNeFvs9gqVIUyDJCAeuQFqXYwtdijYDxhd
	 HA/jdBoCIiQ/J+Fwc7+5aeHkZDs49U1vk4H4lrs6yr9+2TL1j1YlRGyZiQY3/+DSEb
	 K9tWMhSPIf/Xn2cv+va4cTFW6qaHBHNKuR80EfaYuHmLbSTEzZcznYhCKCTvgRGg/B
	 CLFfzCLuO4PVSBOwRi73tcGj2txB11POIDZSpw1jfrRyFovex/T/HevzUYXjNR4VEw
	 WoCEtDKtEACBUpy2QQmisg7ttpLY7GAEBYtCBnYXJCztegLkIoFp4SByU3ne2fCUPk
	 khxtR3RuYJgiw==
Date: Mon, 22 Sep 2025 12:28:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
	dmaengine@vger.kernel.org, quic_varada@quicinc.com,
	andersson@kernel.org, linux-spi@vger.kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, konradybcio@kernel.org,
	vkoul@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332
 compatible
Message-ID: <175856213782.505730.4378140102296298296.robh@kernel.org>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918094017.3844338-3-quic_mdalam@quicinc.com>


On Thu, 18 Sep 2025 15:10:10 +0530, Md Sadre Alam wrote:
> IPQ5332 contains the QPIC-SPI-NAND flash controller which is the same as
> the one found in IPQ9574. So let's document the IPQ5332 compatible and
> use IPQ9574 as the fallback.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


