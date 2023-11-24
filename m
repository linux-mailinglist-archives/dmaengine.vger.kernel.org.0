Return-Path: <dmaengine+bounces-226-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BB7F7536
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EFB281A92
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696E28DDA;
	Fri, 24 Nov 2023 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJbGuOTV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F520324;
	Fri, 24 Nov 2023 13:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDB3C433B6;
	Fri, 24 Nov 2023 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832790;
	bh=w2vrWaY2W1yyeyUd3D1xtc1/2feKd+9XpwZav22IVlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IJbGuOTVoZzGgHzL2n3+pqidFq9URhPJ/Z74tDEhQME9qO96fE/lBLvaBvhHHYVow
	 j62I0B+icdOVufbwe1Uq0HgF7mNs0crKjyHQo3b6hEiNq7Y15//Zxsq0JqKmN2psuY
	 bi2shCNMbeiz0iFAwJ8fv/y1kiqwUEyxfYwuHsSRW8XTkHhjB4E25dldS4k852x6aw
	 7Y180+UXqyyh5nnfyxo27sZhmyPgqLz1U79qr1bnNSgA9TxZmj23djEl9nacAPD59Z
	 U1pluRi6tCjo0Jji7PvaD7Qq3SN1GQCwKuVHvuY4q/8okDH7Yq6SGdL5WohSbs5TeY
	 S/fimnwjjLo/A==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org, 
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: agross@kernel.org, quic_gurus@quicinc.com, quic_rjendra@quicinc.com, 
 abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, iommu@lists.linux.dev, quic_tsoni@quicinc.com, 
 neil.armstrong@linaro.org
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
Subject: Re: (subset) [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu
 for X1E80100
Message-Id: <170083278459.771517.8795954738266891145.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:04 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 24 Nov 2023 15:36:03 +0530, Sibi Sankar wrote:
> This series documents gpi/pdc/scm/smmu/soc for the Qualcomm X1E80100
> platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied, thanks!

[3/5] dt-bindings: dma: qcom: gpi: add compatible for X1E80100
      commit: 66fb6eb6fab63ee80fd26cd5bdd9164aead0d207

Best regards,
-- 
~Vinod



