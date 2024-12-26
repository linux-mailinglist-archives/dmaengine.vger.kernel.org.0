Return-Path: <dmaengine+bounces-4079-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04539FCCB0
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 19:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5426C162B6B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC331D7989;
	Thu, 26 Dec 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smsO+okr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DF1D63F2;
	Thu, 26 Dec 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237641; cv=none; b=gwrQc9DUqns7u0hqhzfNiaV2x1FAMkyFE8AFgYCthcAQ9e1P9u1PG91sz/8g3MGtgle0SQOQCHRRuZTMJ1nYo4jjvEsakLIHQAz4vN3WVrJY9Zcwl/LJyQGLU4gTbc7J0jR7GTv/wcxCQLIcemr4gWEP9CzvZQUb9tAn3nAnw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237641; c=relaxed/simple;
	bh=n2m8kXLGRWwsWYRgCzhXZOLIZaOIoADs3GBZOHUZN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qv5KjugRylrBl1vP+AhnSagcmPMv5xWGDdmO1iZTPoL7eG2wtx7o85IXv/73TnzCYyq+rI+QM8y6tNQjUiWCGCR66LFu0/7dSJ2resp9Fwl2Z4WIczft4mFtvpSDbY8paM5xsOPqLOXM4kGu/Oi6CrozYopaDO/ZuqdtiUwD4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smsO+okr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4EAC4CED1;
	Thu, 26 Dec 2024 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735237641;
	bh=n2m8kXLGRWwsWYRgCzhXZOLIZaOIoADs3GBZOHUZN80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smsO+okrntGehEf5l5+Dq4dgusWX3LK3+WOB8tK1Sn2wMLGT5MT9+NcU3ysWBERX9
	 6W/CAUH+depD+F1G1YRtOTLN9IZI7F4xLRZng9BtPyFuFTRkhGb81i+5yNZ/h8GhX1
	 AurHYlip9v9az4BxK9SmTh180IJ720ydPMYJxDvo++MxKZ7T5zEoTJmt5x7cTM13V8
	 YWXhpPx3SyrZooiI1kJZf0LUVG0teWMpTguCbCDC6gYPyXZ5Q9LmFcfGYYJgp44S1X
	 fiobcc3cXEJ1wheXCdxBMNMNNidch1TyNVPDRfm69GurE/h9qEatEuMjC6LtiwLo3z
	 I82At2Oq+y8yg==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/2] Add SA8775P GPI DMA compatible
Date: Thu, 26 Dec 2024 12:26:39 -0600
Message-ID: <173523761388.1412574.6635792706072023425.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
References: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Nov 2024 22:41:16 +0100, Konrad Dybcio wrote:
> Fill in the missing parts of the initial submission
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sa8775p: Use a SoC-specific compatible for GPI DMA
      commit: a8d18df5a5a114f948a3526537de2de276c9fa7d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

