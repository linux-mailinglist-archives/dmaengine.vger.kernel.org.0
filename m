Return-Path: <dmaengine+bounces-5645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C157EAEAA0E
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF255188CA40
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA282367D5;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETqRs/Lf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF3235063;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978091; cv=none; b=IgO15kRdccO0Ce/ZlbNc+lkfllfr2NtjmeL/fuYrF/99KNtOhsTyD2ZrQ1kaZGASe16lIN4xQY57E1dza/nMXeqXD1UJGzFdexK6nbJEcdEFU2ocvCiqP1N952OB3JJb0I1DkQrAJJioeJYF8isOlpQv+AR9IsFeVWHgwFrN+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978091; c=relaxed/simple;
	bh=zdGBKNeJ+/hIA/7fUPuQSM9f0Yxq0CNLnRS5QR9roZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xpui0WuXTmmT99pS/qsO8ZwqNDZou6oKc0fG+EcNpcNaqzXX+KAd06QKcrg5w4idQy0IJ/2ahaGgSVhtBcJ61aSOA9ZQ52jc8dy/MrnNYIUus9dQghUQy82b4RJe1nNURBeW/dq7530d+MVbtxvw8P4gkfIBx5jyaV1OfxC0jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETqRs/Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705AC4CEF5;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978090;
	bh=zdGBKNeJ+/hIA/7fUPuQSM9f0Yxq0CNLnRS5QR9roZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ETqRs/LfxAGzcr2doFDOsju23P+1XbtUv1kZEW/AK2uj5m1+pzwg+p6p9SDQ8J1Hd
	 U/+bnsgfeUy3HCliTruFnhN+xH/IShiu5Jlu/yOmcinka0ImvxW3d6iyHeBFhjXu7L
	 71fZWIwCi52VCQleDtfKHamUG5ocgBnEGOuAE2loi9sO7AkMVF2i4c4DlPLfV9e+ni
	 utCtxka8eO2lYmq5zi0HBV3GVUi774bvRhC74SyblyzsGdKDGxaEAIcqZF65LopS7k
	 4JVTPk9RfLI587jy5sYFyYFTUp4JvfzZ+gRXnQcO5l/OHt0FWYUyPWcB3lLrh+R8bK
	 Uym29+EBU63XQ==
From: Vinod Koul <vkoul@kernel.org>
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
References: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
Subject: Re: [PATCH 0/5] dmaengine: Minor fixes and cleanups
Message-Id: <175097809044.79884.11756443958851138870.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:10 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 25 May 2025 21:26:00 +0200, Krzysztof Kozlowski wrote:
> Just few cleanups and fixes.  Funny thing that the reported cast error
> I fix the second time.
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!

[1/5] dmaengine: dw-edma: Drop unused dchan2dev() and chan2dev()
      commit: 06b80ad4ffa5e614e89f04dffc44b85377c7ee24
[2/5] dmaengine: fsl-dpaa2-qdma: Drop unused mc_enc()
      commit: f0368c23caba175e07062a3f24e58a2b4ec5bb1c
[3/5] dmaengine: qcom: gpi: Drop unused gpi_write_reg_field()
      commit: 24c13df655ca1fad5fc6fa4fbacb828f4a6d4f2b
[4/5] dmaengine: fsl-qdma: Add missing fsl_qdma_format kerneldoc
      commit: 85a4ca2902c1d3b8ccea03837b10e178405192c5
[5/5] dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast warning
      commit: a0b1589b62e2fcfb112996e0f4d5593bd2edf069

Best regards,
-- 
~Vinod



