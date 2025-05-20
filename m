Return-Path: <dmaengine+bounces-5211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CABABCD20
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7388A2F95
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79D25D8F6;
	Tue, 20 May 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa214EZq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F91519A6;
	Tue, 20 May 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707324; cv=none; b=PEmmHjEKM8P9LqZRn6uBP4orgCvS9TSxDEn01k06aDarq/8L6ESmaHz9iicp7TAzmsDsr6xWrN1bvMrIzB6wYlsrXIhvVo2zm0oSm22o+/nZ40OSYkeUPGAvd/HI0oVVdyy1K28jo+Py9qO77X2KQX+1GZhn/jfPasgwX0ElR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707324; c=relaxed/simple;
	bh=EPiQV0+RFQ6SbjXgsSYabKbALscwJInqg1lm97yoZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWsQcAr9mlo3gkJVEASbrGrk+BPMJzf6ardGPFgHygHJs3IlBdw9PcCW5gvmUhW6b5p5Jec4KkNZYphCOohkR7QFKAQ3Ipg64jkwNGGG91yQDkka2SKcehLa0aPrJvOdb5TW0ajYNN2UtG+Z5ykGevcgTiKa/BfpQk0lqFw3B6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa214EZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0430AC4CEE4;
	Tue, 20 May 2025 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707324;
	bh=EPiQV0+RFQ6SbjXgsSYabKbALscwJInqg1lm97yoZBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa214EZqr7yeyORFF/dO6socO/YzFt2sqs2SSaN+xPqZA/lO8wIo+3LoJiCcVpjXz
	 dSClB5qk6rhS59EBXVhhpvg+ju/RT9GEMSa05OFHjMtCLJ/ZI5ZL1a71LZEnoDvvkk
	 bQMFCG9UTPmaZ37NPv4ynUcplOKhuvl3v/XlrIP3kWVadN6SAshYepHOqKI1+L1KOH
	 /Q6q6WpfpbAnlknhsw7RMJQ1sYA+sW/VjS6vRiImw9zgAC6zxeEhr9dY4L7rxGbbJt
	 OETprUUxa8F70bshPdD7FV8loFeSbsq/iZu8S2S1ScPG9UPmct5yZwzhfqIHjNB1kP
	 ZXpdQT9nOHogA==
From: Bjorn Andersson <andersson@kernel.org>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	konradybcio@kernel.org,
	agross@kernel.org,
	Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/5] Enable QPIC BAM and QPIC NAND support for SDX75
Date: Mon, 19 May 2025 21:14:51 -0500
Message-ID: <174770727729.36693.10794691902044161695.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
References: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Apr 2025 12:57:51 +0530, Kaushal Kumar wrote:
> This series adds and enables devicetree nodes for QPIC BAM and QPIC NAND
> for Qualcomm SDX75 platform.
> 
> This patch series depends on the below patches:
> https://lore.kernel.org/linux-spi/20250310120906.1577292-5-quic_mdalam@quicinc.com/T/
> 

Applied, thanks!

[3/5] arm64: dts: qcom: sdx75: Add QPIC BAM support
      commit: 5cf0ebd4800dc5b67a332c9f56d20882c41d6099
[4/5] arm64: dts: qcom: sdx75: Add QPIC NAND support
      commit: c25dcb4d42a9506d5270179bb32cf538a1a28423
[5/5] arm64: dts: qcom: sdx75-idp: Enable QPIC BAM & QPIC NAND support
      commit: d838ac6903eede0c2840bebd8788afa95a5aa0fb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

