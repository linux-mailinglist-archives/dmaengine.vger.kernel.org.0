Return-Path: <dmaengine+bounces-4751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369CA61C00
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 21:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5EC3AA6D5
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0422FACE;
	Fri, 14 Mar 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBuR3Dw1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7F22E40F;
	Fri, 14 Mar 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982528; cv=none; b=fhEJUtAtQE6UguGfu1mPQHOCPPrFhTHdI/HeG0gpqB7PBrn51Kb9n6g85R4GHccFUrR/sApyaxB6Oa707mJuPIFwQeXN0lsuvwlGqUQv0m1yRs9dUmAL0sHLwb3f4NUF6wVejWDxMQW/JTkwx9oF7tB0kHydS73p9bs9OIyVgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982528; c=relaxed/simple;
	bh=1noOD8bUEBFW4A9ly0qfYxIGnvsqDOBrrUmrgt/x26k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUwFtYgy/ITlFOQBHRdl40/ApUVpAuArp62iZOlB+rinV3Uj1D0A2kWQoOlXFHNMD4niVwtBhjzbBmYOseYRodpEtmuH6UZtW22b259wkD/btVo+NqBUmEFvsxl9cdlalzLJDB9K20s+AgQ9O/ogbnhvG3yAlFNlyf2bFztagzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBuR3Dw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65503C4CEEF;
	Fri, 14 Mar 2025 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982528;
	bh=1noOD8bUEBFW4A9ly0qfYxIGnvsqDOBrrUmrgt/x26k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBuR3Dw1/3JHWgpS2gra5lXKcvXBvXdg99lrGhUUzvMQRCoqbrTJSBmiIgY02Ai7U
	 1YAzWU4Jt914QEcbu4jTbiQovnRhUzKXguoiXqvC2iSzS23Es2PaqeUCTm+s5P9PB1
	 MpZNxavtK/+ao1Lax56I7aIv5eo6yj4Jx2RhArQnLLt2YSWRvLmieGsAdWznQ2DmuJ
	 okv8FyUMcoLwOjyxCeaA2/UUqU/YVNXFmCKYiIUMLU9Bns0Hj/9vHTmYrR66f/9125
	 BgKcwkRWuLEgWh87vpmOD5spaofHzP5mAN8gmG6ZtnIKhs6LIVqUyTNQDrild2eEzW
	 9ntJEDQtUxH4A==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: (subset) [PATCH 0/8] dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees
Date: Fri, 14 Mar 2025 15:01:20 -0500
Message-ID: <174198247869.1604753.6993934195072852246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Feb 2025 18:03:46 +0100, Stephan Gerhold wrote:
> num-channels and qcom,num-ees are required for BAM nodes without clock,
> because the driver cannot ensure the hardware is powered on when trying to
> obtain the information from the hardware registers. Specifying the node
> without these properties is unsafe and has caused early boot crashes for
> other SoCs before [1, 2].
> 
> The bam_dma driver has always printed an error to the kernel log in these
> situations, but that was not enough to prevent people from upstreaming
> patches without the required properties.
> 
> [...]

Applied, thanks!

[1/8] arm64: dts: qcom: sm8350: Reenable crypto & cryptobam
      commit: 75eefd474469abf95aa9ef6da8161d69f86b98b4
[2/8] arm64: dts: qcom: sm8450: Add missing properties for cryptobam
      commit: 0fe6357229cb15a64b6413c62f1c3d4de68ce55f
[3/8] arm64: dts: qcom: sm8550: Add missing properties for cryptobam
      commit: 663cd2cad36da23cf1a3db7868fce9f1a19b2d61
[4/8] arm64: dts: qcom: sm8650: Add missing properties for cryptobam
      commit: 38b88722bce07b6a5927f45fbf7a9a85e834572c
[5/8] arm64: dts: qcom: sa8775p: Add missing properties for cryptobam
      commit: a2517331f11bd22cded60e791a8818cec3e7597a
[6/8] arm64: dts: qcom: ipq9574: Add missing properties for cryptobam
      commit: b4cd966edb2deb5c75fe356191422e127445b830

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

