Return-Path: <dmaengine+bounces-2186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0128D12E8
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 05:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E4328359B
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AB613F458;
	Tue, 28 May 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkUG/Wdl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D513F44C;
	Tue, 28 May 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867193; cv=none; b=W8cz54gTZ/pwdfPM2AMW53GZxJK5RLpXBMDlerKnu1PGYMlr/rGX/iOHMaV/3VIwi1zP6DJc43s27sGQDUNkyyP2CEeijQ9JHTNkrK1zS74f+KPghVCtbF6imvPLLP+vzHzDu8FyCH28qsozF8Wb1hquAqvDOO8m9g68pUKA0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867193; c=relaxed/simple;
	bh=xB+JPer9B5FxmyGoXFUdxxsSU+BeUDcsb6psyhM0XRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjAHVNw+JVfG6AOpKoD0d3KZPeUrtYWYyL7PzcC9ak1LJqMaH41ST8Vi5yJXkseIUAC0S5+I6dnlv11p8moDgo0v49enZxZyypkTCCD+WCf9VRQ5DFdvAKGPQ4vRhebetpFjTyWqUCkWzSiER9FyhHVnskF/v04TJJBOdGwruTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkUG/Wdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE2BC4AF07;
	Tue, 28 May 2024 03:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867193;
	bh=xB+JPer9B5FxmyGoXFUdxxsSU+BeUDcsb6psyhM0XRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkUG/WdlKUzYW4E5VDyFMQABpFcTkYgNU+3TGdi8IMJbf1hX07pFY7BVvA8GnxhRI
	 hiPkioXs0DMVG5EAimdGUVm8vYhvhtFRmTmzgW183ykB7EBs5g7NYRREUMRYsPykm5
	 U3HDNED8kp5YmVp7qGn837iT8V4Ei1CKLsggqLaDVy4X4efGCX5HlMa0RyxywPMJvk
	 MnjJtJmCgC+86H/Hwx2KGXs4NguYu+K/9dSx/N84GooOK6oCEcdlf0r6XYashW1l/B
	 zE1cgYM9oQaTNwsAHXMfpN98B3pyr5urLrzBM0DfUFgJneol8xoitCXkFctoIIFA+J
	 NxpnWfUm/vTLA==
From: Bjorn Andersson <andersson@kernel.org>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add I2C and SPI busses for SDX75
Date: Mon, 27 May 2024 22:32:32 -0500
Message-ID: <171686715151.523693.6089743486707412009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
References: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 May 2024 15:34:21 +0530, Rohit Agarwal wrote:
> This series adds the I2C and SPI busses found on the Qcom's
> SoC SDX75.
> 
> Thanks,
> Rohit.
> 
> Rohit Agarwal (2):
>   dt-bindings: dma: qcom,gpi: document the SDX75 GPI DMA Engine
>   arm64: dts: qcom: sdx75: Support for I2C and SPI
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sdx75: Support for I2C and SPI
      commit: e07c4a702eb0abbb200c07593cfc429338ec42bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

