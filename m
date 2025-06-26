Return-Path: <dmaengine+bounces-5639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91BAEAA0A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A521C1885120
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5332264CB;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdkwpipH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409A2264BE;
	Thu, 26 Jun 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978088; cv=none; b=JT3EtkyemTTsbjAaFiNV4S2hJT1sU8UwfImvx3tw6DlnnFR04pYTFEMe4zaUmL97u2iioYqzcnOGfpsqTHQU3O06OeZgFDNakaa2kWS/p07AM60DGY8Ctq0yEFup22q0SUSiSVfRZfnYUc9S8dcFXwEFiqY+8u/fdZJNzZhLF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978088; c=relaxed/simple;
	bh=74tRgRyzUdH97iXrqvLAwp3+I+AkyJCcT0uVquQrKgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ul+ju5yg92I5PT+lR9TWqE7LniGx2DEQtcQPgoMa9a9WPc21taJi7zoGMI/ZFIeGkAi2PK7QUQZ7eQsppSFPhMUztpFS/NdGghNyzKImm8M1fvcw/FFGtoha6mtuDSkk8gR8o1TEEogvt+uHhLtusCYGPDsc5t3KveLeH3T6Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdkwpipH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5BEC4CEEF;
	Thu, 26 Jun 2025 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978088;
	bh=74tRgRyzUdH97iXrqvLAwp3+I+AkyJCcT0uVquQrKgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pdkwpipHKaiF+d5pMuf42HxFj55b/cPwdg+uKcLZ9zxyhePT8RWubttjzhz/hfj3A
	 63410EWF55ILPlb46JOP5PuK2vC0HMeTrVa+jnABmQ4SnaQTZsWSY7Q9vTiilq90S5
	 qhX0ZxLHpGKb/DVENZC+BZeqiiphW6rqoZGuNFKP8BtbN1iCw2VZicHnI64OotnGCD
	 1BFsdRa3Ug1kyXZTUBBYc2ReyqiWJk4uoY7G5CCBG+DS63x0dlbtW0COibMWv+F12Y
	 7GqGwYWYlFijoObWSaa/LzIf5jEyhsid3raTgrhk678icHjWopjYQuYc2/vAHC8KR3
	 QWBym6kse06jA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250617090032.1487382-1-mitltlatltl@gmail.com>
References: <20250617090032.1487382-1-mitltlatltl@gmail.com>
Subject: Re: (subset) [PATCH v3 0/2] arm64: dts: qcom: Add GPI DMA support
 for sc8280xp
Message-Id: <175097808791.79884.6630733557400720199.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:07 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 17 Jun 2025 17:00:30 +0800, Pengyu Luo wrote:
> This series adds GPI DMA support for the sc8280xp platform. This option is
> required only on devices where the touch panel is connected over SPI.
> 
> base-commit: 176e917e010cb7dcc605f11d2bc33f304292482b
> 
> 

Applied, thanks!

[1/2] dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
      commit: e54dd5059d46e44606395cb6ab15f022dc5a5902

Best regards,
-- 
~Vinod



