Return-Path: <dmaengine+bounces-3693-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F69C2713
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6327A1C2129B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C91C1F2B;
	Fri,  8 Nov 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUXaO3hr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D329CF4;
	Fri,  8 Nov 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102083; cv=none; b=YpjCb+bP+pGApuW12mTsQ3jKC1ntYKUMK/KFdnZv8dT4UnII4vatFHEc+p3Iyt3MY3n8Yed15bEHPHCBVcb4S6M8iLbtM2HUTAv94RJjxsOM3/zFLMkRa70fkjcDY8dpJXZjRLax4lLWtRSLFGXlW9jcT0zv+42d0f/V21Vpb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102083; c=relaxed/simple;
	bh=Fc7x2e49eRNe2PcnnAqLpxs6d9cdEu0pLWh8RwaMBfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XJ8pfjv1zdUVSIG9nkC1YmhZUjEeaBw0EP1PR1ploMrlpbvszoLbUuTW+rFh3+e2bIdnU2OZe1hHvMOSygqojmFvIxRaJ/0S79e8PZ8asIasKL1mEbFyrLx4UwHFIzHRSaQpTqgehJtdtpE1laNY97eP5SGc8pXs32krhfSUjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUXaO3hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47066C4CED7;
	Fri,  8 Nov 2024 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731102083;
	bh=Fc7x2e49eRNe2PcnnAqLpxs6d9cdEu0pLWh8RwaMBfo=;
	h=From:Subject:Date:To:Cc:From;
	b=GUXaO3hrUddhIbiP209FXXBqdYiUnp3m3f758LE+F5JFiUiDzbyrjWofAHvl9/92c
	 yN+vajjmmDiq+ADvDDBPUz/DGSmU2NZ9gcN/rCf4qzfaCyYZ/dM6aq6uR5eSvUVCCx
	 Qclqgut4uU/XcIfITTcXniwbGst6oDAr4BAi1rBwJkKvnWiy1vBacTaJ8zja7442AB
	 lIE5eqdkwYFRH+flvHjCd3F1fkpp/NtJoIJTQbFXmFi2SU9Lcx5rbXlC03gilXNjEl
	 0oM4K19M/Lemo6Yf3NDvlzgYeVkm+D9IZKafYsXW0pe3TfwKyG/3LF6eHEzfhjNI7M
	 qIrueaOU+Clwg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/2] Add SA8775P GPI DMA compatible
Date: Fri, 08 Nov 2024 22:41:16 +0100
Message-Id: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyFLmcC/2WNywrCMBBFf6VkbWSSPiZ25X+IyCSZasBa22lFE
 P/d+Ng5iwvnwj3zUMJTYlFt8VAT35Kk4ZLBrAoVTnQ5sk4xs7JgK2PA6Xm4pqCFHGJ9iD1ZbR1
 Y33WdCxRU3l0n7tL949ztvzzxuGT1/C1VzyL0UbfFT4x/Yn0z2mj2TVkyoAfA7SCyHhc6h6Hv1
 zne3zwJ63eR5rbACitDUIPHTSxNdNFyPmMDIpZNvWkiUOOt2j+fL3TdMCj7AAAA
X-Change-ID: 20241108-topic-sa8775_dma2-2802bfff8cac
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102079; l=791;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Fc7x2e49eRNe2PcnnAqLpxs6d9cdEu0pLWh8RwaMBfo=;
 b=PRZIDdsEil2u0ih14ylgtr8AgvXPzinOh7j2IGgR4mj3QA9CpbmL3f3ZQDVXhXpwKEcXz6Bt5
 2GcB90QlSQlCBBd8MAy3+4QLyiSnVd7lgVhXv2ze9P7QKlGaPrUlpDL
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Fill in the missing parts of the initial submission

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (2):
      dt-bindings: dma: qcom,gpi: Add SA8775P compatible
      arm64: dts: qcom: sa8775p: Use a SoC-specific compatible for GPI DMA

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi               | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241108-topic-sa8775_dma2-2802bfff8cac
prerequisite-message-id: 20241107-topic-sa8775_dma-v1-1-eb633e07b007@oss.qualcomm.com
prerequisite-patch-id: f4eea36e64f43f421b6f1bae15d802f7dd514768

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


