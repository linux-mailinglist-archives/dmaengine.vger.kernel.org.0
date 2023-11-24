Return-Path: <dmaengine+bounces-229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D47F753C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B82817E5
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE928E17;
	Fri, 24 Nov 2023 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDT+ydXh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F3286AF;
	Fri, 24 Nov 2023 13:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE4C433CD;
	Fri, 24 Nov 2023 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832800;
	bh=a5c+eNFRWI1rPiXFiX1qkJlP9FBi0Vr2npPbeXqFnqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GDT+ydXhwi0T3I5Av3tY7zmJAAkmRvHxo1YU5PuP0py4GdE/pCxNRuN0upFrKQhUF
	 iAm109qGDKI4j9rZPYSpppJsREnI2lcD3t3BLHFCPDd1VuXSlEcqWsVVzUTeSOpydt
	 wIMDPeoEW8a61FiooIAyh7mHsKgc1MNneUn5oEckEwGTnTWSOVZToln2FsXBtRphxF
	 rlTcbFHir6mbDSJU03mIl4TOPVqZum0A5B9G6vBJWgCuJLsYUpt3aKfTYpK9Tsy5O2
	 o58Ocp6ulabpGEA28Dfnnm4L1cQVB/CNIyP9cby+KQZASUWyrzZribujI6SCC2U0bg
	 v6bcoSjXkn/kg==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: document the SM8650 GPI
 DMA Engine
Message-Id: <170083279691.771517.11496206562841467676.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:16 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 25 Oct 2023 10:23:04 +0200, Neil Armstrong wrote:
> Document the GPI DMA Engine on the SM8650 Platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA Engine
      commit: 375ff42c4c9825c19a53b9095ae4b3337cc83442

Best regards,
-- 
~Vinod



