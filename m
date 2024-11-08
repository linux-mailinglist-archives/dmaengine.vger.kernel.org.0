Return-Path: <dmaengine+bounces-3694-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD99C2717
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 22:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7952A1C21603
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F11F26FA;
	Fri,  8 Nov 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP9U93N3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06229CF4;
	Fri,  8 Nov 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102089; cv=none; b=Ajy/h9k9+k/85DPSildla8gsg8P/QX+Un5DECblje7/3hJVn+2ytyjCOHyvb5IIdI9F10DBeJGV4tL6ZFP/L/ZnOSmQgLJ6WAxngTR/FWVpICLAIGilI0uINwcGi7/BRi0mvh0R8epuhKmZgeZG+ZxT7X0G6JtLJ+wDhu+6vz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102089; c=relaxed/simple;
	bh=IoKztgWbNOoL7KlRiSF19oXjotrVWn+kGWq92CRe58g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atuTG1aq7u1Ku5Z0zYaV0M+75gqIXwgrVjZEG8m3bpkNoa0SNQMk6MiN2wCd/3YH5UBByLwL2zKX6RY7r8CSq7kxR64lt3C7NxTV1Mi3fLp1EbODSd6VUCEijOoFGu9PA6Ycf5nrsk1AM0yokealUbw969GQmgsT4c+wvESPv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP9U93N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E96FC4CED3;
	Fri,  8 Nov 2024 21:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731102086;
	bh=IoKztgWbNOoL7KlRiSF19oXjotrVWn+kGWq92CRe58g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GP9U93N3DdwWPo5O4NSQuhP0TqSV+4tj1H8uYg9YZwVYtfCKMwvDg1Vt0jP60vbV9
	 TEnSHPAyUL2otwS83PavMUtfCweLeahQCaotBADcgKksV1Dp+CnAANWNeSUVurzwJr
	 oC6qfvgGQXyd9lNphzhC+W0YYWGNDhXQzL7Nj8HTWjv/Oq5YeA1o2OhyAXvLvQz2ae
	 mglFZ/TXBkwpaPMC5yM7bHk9LVhGbdoEkoHu0HVSGrkD2dAoTsQ/QPI65fC+FiVElp
	 aktIVqYFy+J/6B4DPR555H/Bj9Emm7lPLG4hVnWisq3zGlo6Vt0sYakuktXKDgGtwl
	 9HsbBggf2o8hw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 08 Nov 2024 22:41:17 +0100
Subject: [PATCH 1/2] dt-bindings: dma: qcom,gpi: Add SA8775P compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-topic-sa8775_dma2-v1-1-1d3b0d08d153@oss.qualcomm.com>
References: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
In-Reply-To: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102079; l=855;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=r2jtRxYU4022/w2i/eF+lTpYIrVvypLb14IpDahmeJc=;
 b=UX/jqy9aRUBJAKozQ/15OAJ9+JKrNOTgMl3luYUhKHLzJMelbatKSWy19PXt/P49ZfstA4UNd
 G09+/fUdM5uA0CS6O9sO7xwTU3/oGZaPDeSEPazqaiBjZ/wJJIwS9hH
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add a compatible for the GPI DMA controller on SA8775P.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4ad56a409b9cace94a3a4c4ec94d3ad16232f5a1..b5b815519c6c1b248110a55139571a12cfd94f5d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,qcm2290-gpi-dma
               - qcom,qdu1000-gpi-dma
+              - qcom,sa8775p-gpi-dma
               - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
               - qcom,sdx75-gpi-dma

-- 
2.47.0


