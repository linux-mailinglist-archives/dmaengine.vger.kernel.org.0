Return-Path: <dmaengine+bounces-2346-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B521A90439D
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C699B1C23EE6
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC47D412;
	Tue, 11 Jun 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEOECfqE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72D155381;
	Tue, 11 Jun 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130499; cv=none; b=Nre3GNuwjz2QewKbQWaJWgpfR2x4RYxYoCDxxBMs+WXZaEsJE3++ABo2YhHeybX1rIOthxlC43LqraaydKwiUA405JXH4COvPjsBPP7pLviV6yXDwI7VFXEz/WbqbnVUjkInMxODykFlfv8aOSVudN/YFAg+PIFGRoPrHN2DX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130499; c=relaxed/simple;
	bh=M8VvlnlUjzh3Qu8nJHCfsOa6/1J5iwG41LtzZqxWHm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aU401MtauN2EggQN/s0wMqeHlzVmxlGe0+x0kWUwQJ69ajVd6jtlE6XAeugA+Z+ro0DNHwaSGd3WYE0e3SXNXOhY5R/XR6U2LSc/vB4Dhx81pTPr1Z2EKp7Bs6tenRV68+yuBPzzZefpzBTyQdfGF9znTnmvnL5/6qKuBSECbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEOECfqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03089C32786;
	Tue, 11 Jun 2024 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130499;
	bh=M8VvlnlUjzh3Qu8nJHCfsOa6/1J5iwG41LtzZqxWHm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HEOECfqEBC5j/q2OiERUKWFJxR5y54QbznP3jsIBdNaNGLfkfPxJk3GwHEudo/0ot
	 UlWuOi2uMdo4qlZEvgsTV7JryMg8M0ZinRe2Vrv96KyeVDlgXvNVqaQgDODtrfIPTA
	 8xIE/3HfiId0owOZZT6dUa45MYdbntPtGBAVYpWBHNOv6QdgRy5Vhvx4tMsYBWIljb
	 AVd10qke6TVwR5/c+DF/qBROpQwATpYw0pt8/gzpoWB0Pj5ALNLceGg+TxtwX1L6U9
	 JtUoNUxfLFT87J41+4ofil1xIidaBygDlD8C36pvaOdMYCSZ4hBK4Hfuy9uCZYqcVF
	 RU4eY8awZh7Dg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
Subject: Re: (subset) [PATCH v4 00/12] Introduce STM32 DMA3 support
Message-Id: <171813049557.475662.12255622136346083429.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 31 May 2024 17:07:00 +0200, Amelie Delaunay wrote:
> STM32 DMA3 is a direct memory access controller with different features
> depending on its hardware configuration. It is either called LPDMA (Low
> Power), GPDMA (General Purpose) or HPDMA (High Performance), and it can
> be found in new STM32 MCUs and MPUs.
> 
> In STM32MP25 SoC [1], 3 HPDMAs and 1 LPDMA are embedded. Only HPDMAs are
> used by Linux.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: dma: New directory for STM32 DMA controllers bindings
        commit: 8494ae75dde4495c73b7425543138d088133f75f
[02/12] dmaengine: stm32: New directory for STM32 DMA controllers drivers
        commit: 76178a2c49a7c01ef684b0d689f3da4fd12e0154
[03/12] MAINTAINERS: Add entry for STM32 DMA controllers drivers and documentation
        commit: 81d09bb5249e5f844ee342cc1419e97fc9108cda
[04/12] dt-bindings: dma: Document STM32 DMA3 controller bindings
        commit: a204f64d9f834bdf7085c617aed229eb7500e331
[05/12] dmaengine: Add STM32 DMA3 support
        commit: f561ec8b2b33da6a07cf211e43c8eb35b2dd97a2
[06/12] dmaengine: stm32-dma3: add DMA_CYCLIC capability
        commit: 08ea31024ab9cd512c4a897bd1afd2a5820c53e6
[07/12] dmaengine: stm32-dma3: add DMA_MEMCPY capability
        commit: b3b893a937764731c41423aab4cc0c1a6821e31e
[08/12] dmaengine: stm32-dma3: add device_pause and device_resume ops
        commit: b62a13071cffad03690ee19656248077cb388a14
[09/12] dmaengine: stm32-dma3: improve residue granularity
        commit: 2088473802ab9641114681bee92ba902bccdc19b
[10/12] dmaengine: add channel device name to channel registration
        commit: 10b8e0fd3f7234a38db2c8d2c8dec0bd6eeede44
[11/12] dmaengine: stm32-dma3: defer channel registration to specify channel name
        commit: 49b1c21ff815168eca44e81ab0612b1f00759efb

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


