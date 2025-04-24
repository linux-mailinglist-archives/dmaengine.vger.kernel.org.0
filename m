Return-Path: <dmaengine+bounces-5017-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12898A9A086
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 07:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2B33BDC9C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06631A4E70;
	Thu, 24 Apr 2025 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdRnFw1U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60E1953BB;
	Thu, 24 Apr 2025 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473017; cv=none; b=sY5LGCcv/FToUP7dzFJjJxkwO4G/YrjwkavzZJrav72UhPElBOfpLd0bm6o5RbtAClBeNICfmozsCN2x8rmQD6DR5bxS+qPaGwOpIUZYIHbHTvtNDuHPQIUWCvFnobTRvkT2paxaMHk8Jm0/fpc5K7PjIziRe9KL5kTxNpFzzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473017; c=relaxed/simple;
	bh=ABXHbVwLQcuJdhcmr+KvmkNayeZgHJI6vYnH8pSInZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pDm94Pl9KV6Q9L/Ke3U6DpMKSW/VRzwqqG9cDmAPSlsoNZeUfaL/COIcu/bvMdqCsEI/vigwZobd3Eh6REiI+ZXv4slYmJ7vTagRo2XdoRJWilkt8ILQmHphgT37hHEA6pOh8uLjhmqAARUJfi7lGTjHRE0ZM/uSJjWrhV0Ym5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdRnFw1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC2C4CEE3;
	Thu, 24 Apr 2025 05:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745473017;
	bh=ABXHbVwLQcuJdhcmr+KvmkNayeZgHJI6vYnH8pSInZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZdRnFw1U4X+JULTVPLk0DVyljEjUvmcT2ItgugX7qm9xS9sPYIz4gJdOBr554eALd
	 j+4av0+YaoM7oTlrpoMegQLy9/rsJQ4U3PW39VeCkAMYOZoW5Kg1ZGMLX7msb9Q7YX
	 8/ObCYsYaqMh5nKJTo4td1HqftSsJV8Sv5IFAKS938ZZ3y3JTMu/l0U4xUcYu2XbEF
	 AFgucCU2c3TN+dh6brkmkxyyw/lA57iw1f9DeTHn3iC8nKJyyF5EZN+9RDJyD0Dw8L
	 4piHM2rI4/0f9qKv7NGA4SzL7n3GCo0XEvvBj0rzBR2mXP5SGh7lccD3ilyX2rgHPS
	 9O+OEWxGfGL+w==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com, richard@nod.at, 
 vigneshr@ti.com, andersson@kernel.org, konradybcio@kernel.org, 
 agross@kernel.org, Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
References: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
Subject: Re: (subset) [PATCH v3 0/5] Enable QPIC BAM and QPIC NAND support
 for SDX75
Message-Id: <174547301233.316124.15937980058360184263.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 11:06:52 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Apr 2025 12:00:49 +0530, Kaushal Kumar wrote:
> This series adds and enables devicetree nodes for QPIC BAM and QPIC NAND
> for Qualcomm SDX75 platform.
> 
> This patch series depends on the below patches:
> https://lore.kernel.org/linux-spi/20250410100019.2872271-1-quic_mdalam@quicinc.com/
> 

Applied, thanks!

[2/5] dt-bindings: dma: qcom,bam: Document dma-coherent property
      commit: 5965fd614b18e77c56cfefbd2d747b6b1edf1497

Best regards,
-- 
~Vinod



