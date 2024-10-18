Return-Path: <dmaengine+bounces-3393-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D39A36E9
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37822832BE
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54018628F;
	Fri, 18 Oct 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni+3IfnH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1C178389;
	Fri, 18 Oct 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235928; cv=none; b=o9wuKUOBTzlMrW/LaX1isaQ8/0ZUmUqEDm1RDIJyPrkS+zqLwU3bIou00WFjbVwXeeBT0EUuV5r6LqCQ8S1w8vxn+9obR9YKpr9axYelXUTyJoYNLfJ01p6J6AUaFi7wEMYF559AppMKt8O8O+7L3420nYl76JzJKMW551SLRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235928; c=relaxed/simple;
	bh=b/vRRpZD0tVS9QkoeHm0TfAr1ehiXF+fy7FyWAkaOmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgI6BlwHiI/016oGtv8kQunYw0lkSSd/yZ/Fna+mhbbVFWL3y5ydy3ULDqVzb7RCSCKqsg+GknWM+siesmeXCuVxsJshBrZq4MSET1Jf1nikNuJ8umRkinsxhLqJKGFCP8FC6NsFwCXpHH/GEQFwcsQJ3TkqJ3WWfZ1/MtpurCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni+3IfnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB98C4CECF;
	Fri, 18 Oct 2024 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729235928;
	bh=b/vRRpZD0tVS9QkoeHm0TfAr1ehiXF+fy7FyWAkaOmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni+3IfnHz2c2ib8h0ASO7A+JYNtojj6E4X+bZ3hPqC6w13hmzQwRWj2vOEQrNyLcX
	 cyVDbIWyMdUsEvOXoW3UD8wJjiWUcrkx+uQ3kzgoe6ZTZRBZLrN2S7FPNryiZ7lw6b
	 2dbJKpBUdK3ZO8ni68POHYrzBHfInfNrP4jO7vHh2QCsbAY0HoEnsYZYc733JH8a+2
	 zXUvftZ6o7Dq4eUuFu8ULLcTbJifCZcc9IiCoBLdW//Ib0YdcvoxWTj9ar1qLdgOAb
	 rHp1A7F0DD6Altk6MsDzSV8GDPfmbK6LH6KOn3bTOfIQmwAb/nwkEquBpdHtcOyzKe
	 yOQZQ7fddGnzA==
Date: Fri, 18 Oct 2024 09:18:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Add SAR2130P compatible
Message-ID: <mskc7k4yk7wnmtqofbiybmdxr3giqkxqvrfj5fiswxqlf5ohje@dyim5fqrcryd>
References: <20241017-sar2130p-dma-v1-1-e6aa6789f116@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-dma-v1-1-e6aa6789f116@linaro.org>

On Thu, Oct 17, 2024 at 09:11:49PM +0300, Dmitry Baryshkov wrote:
> Document compatible for GPI DMA controller on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


