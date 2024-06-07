Return-Path: <dmaengine+bounces-2313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE4900B85
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222431C2204D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3819CCF5;
	Fri,  7 Jun 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC5dhQ8k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDC19924F;
	Fri,  7 Jun 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782437; cv=none; b=FeJpdx6gFDgRF8xCbyqYRTeDpaRNNXjLerji/2RkAiQFppkuGrVH/5t2JPcb0JX8Dj4+OLT8I07XRA7j/F3qdX6pCxVAoqPNVbCEUGepHwXa+a+dWrBgY5/tab3c/Y4sApdAAddpLivSB+PAPpDDrM4mhFXnlxlgHg6ClUpaqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782437; c=relaxed/simple;
	bh=Ah3xD2VYfWteOXiiI1LPCE0B+4+uVAXtyTUN+YThnGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H2gjsS3YkH08iJYYeA+U+eK+JYVPFP0xWvIRA/d7OEES2X4i0XMApqBz7RTGbjdUsL52HuMB7wJ1YZNcxFk7CnmnKwoSO84nJmOAcT7p+7LZPLRhNoiPStpyw2iHR9w9j2m1S9Uxo9VFjqvkxFWRMx2wHzNfk8VrRepuT4ILggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC5dhQ8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E4C32786;
	Fri,  7 Jun 2024 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782437;
	bh=Ah3xD2VYfWteOXiiI1LPCE0B+4+uVAXtyTUN+YThnGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FC5dhQ8k1oE23ig1HbTMiS4JdLzl6fnAdrdp4nKcndmm9XKwBaMkfQK8RiMPnwayd
	 u4+X0+bwcvil/ueng01fss6gFXTkrGXKRgTR5MsRGSvSn+KA2uxGia8poZvGrzLhLy
	 4cogYwIf2k8joqOd3OuZlzA4xjGAeIOHOyYeh3PV/qaNBrnijf0qX1Nc5V6hhzUz6A
	 vtTi8DBWwNWseCP8uCYgnHWzZ1SesQeu9U0CIQkYsi6LO6d73o/MNYKpIcrODpT7wb
	 KZxaZAL/+MNV+wpG/lprYffVAXLL7vVeNMcZ8ZFpmbXV9Gt0MVI3kl1dRoNxrMkTjy
	 vnCLVcCwwHRsQ==
From: Vinod Koul <vkoul@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240605003356.46458-1-animeshagarwal28@gmail.com>
References: <20240605003356.46458-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Message-Id: <171778243367.276050.5441148149906303737.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:13 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Jun 2024 06:03:49 +0530, Animesh Agarwal wrote:
> Convert the fsl i.MX DMA controller bindings to DT schema. Remove old
> and deprecated properties #dma-channels and #dma-requests.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
      commit: 45a24e40581db95f9c7ee08e0f27874daf7d3e7b

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


