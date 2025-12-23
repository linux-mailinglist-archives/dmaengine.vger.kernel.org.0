Return-Path: <dmaengine+bounces-7884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B365DCD91E9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB69301A1A7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD53314D3;
	Tue, 23 Dec 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc8UEWTT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6606327207;
	Tue, 23 Dec 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489316; cv=none; b=NIcX9NZN5s+zAkIoPN7IGV8qcRC6H+Dn2W+JXdwrIQxPm/RMerXmStzlwiOqnpFtWgJkUngmjkZ9UC7Y9kbcVf2/xgfvYQZCpLL4NjPalrGfTXiTJQcBLBl2Ef1r3Nqv8thtQJxeC/cWpDDWLZhNowlnhg2sh7pCsEtwocrhFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489316; c=relaxed/simple;
	bh=GX0JpN8LsbXoeT78MivzRUSzOyN0t/QpJ0vaPvpj6Vw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hm7VwunfIjyTwv3iztI5OKfPzjt+NyDZnMT0UKkabAkh8SR1wd5L/x33Fr2BSaoNFLGGnKpSU1tMBa9RJTa/RFrNjiMmD/Q+0a4Bf0EeoXjr79I70Z832JBl8BvCZupKp1junZGev7FbLHB+5/02l/OStqwJ2G05xwra2cEKZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc8UEWTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4BFC113D0;
	Tue, 23 Dec 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489316;
	bh=GX0JpN8LsbXoeT78MivzRUSzOyN0t/QpJ0vaPvpj6Vw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yc8UEWTT5CZtLjvvq3rLBtGaMqeKi5RX8RY99EwhU31zy5c9YaoxEPcLVeeEsBu55
	 oxjT1rK0jU1J9Pu89JtHkOgpBHBwoE3J691FKauSv4Cu4Un1TW3w1sMk4OmH/kPjdC
	 BswFL9sCIGfFm5h0inuX5s1nhZcRV/Qtvu6MvKAEZNFSFc7vp90L/lEJz5nMs3KjnF
	 fXLKpYPCFHshhe/QNurG88gfP8gW2/Y9dauqK39tinWl27jPIryilDmcpKV5HXoUyz
	 t2D66E/J+gKUcU8PtOuMJ14qVF4IgGNaHsbNjMd9v++QQMmanOr+PEAxMq+WV5aoPQ
	 hVixx2qEp04eQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
 trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>, 
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>
References: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Kaanapali and Glymur SoCs
Message-Id: <176648931260.697163.17256012300799003526.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Nov 2025 19:00:42 -0800, Jingyi Wang wrote:
> Document the GPI DMA engine on the Kaanapali and Glymur platforms.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Kaanapali and Glymur SoCs
      commit: b729eed5b74eeda36d51d6499f1a06ecc974f31a

Best regards,
-- 
~Vinod



