Return-Path: <dmaengine+bounces-4070-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A629FBCA3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410C3188354F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3D1D6DA5;
	Tue, 24 Dec 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8F9zG9/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA61D79B3;
	Tue, 24 Dec 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036945; cv=none; b=aEKShmjSbpXlBdbaFZWgkWca38dAcRiLlsvY4xFUo5Axyrwd1+TdnGuGRrJtZByq0SbEN2kM6yzW3CNxKRyluU0Kx17fDv6voSIl0c1Ivdmnfxz34Qrl/cuKhGruqHOA/wfzz6xML4nCs1irMc8hyh7B49lHv2TAMlV8M2bx2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036945; c=relaxed/simple;
	bh=Qc3IowgyoTkUUcx0ynuGqKSfWfJ3v/K+Qt1ctCaL0TQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CpDVepyPvX6/qd7g+nlxx6PkrOq1oQeww6r4ywwgkm2iSLszB5auZBF4XX4rJjQbO4/YpsemkcG6rdRSlY54/5eHK++gupapf1/31tapkyjAiLwidxV37es9qUHcuvztDnMBK8z68tniE+L/q+tdtiz6RFNCQ76cOIODqCv8e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8F9zG9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E59C4CED0;
	Tue, 24 Dec 2024 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036945;
	bh=Qc3IowgyoTkUUcx0ynuGqKSfWfJ3v/K+Qt1ctCaL0TQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k8F9zG9/lAVA6g7KyOCZYYJqBOrj1XaKRVy97a/OSuWs8q8fu5R09/3yGEWkA1G/e
	 ap7TkWGT1tIBa2kgcgUtTCenSIrfvHe+71xS5GbDLxLXhBoBlG5zrnO+YfCdRRzgAI
	 aKtQ8DHXIAs+XPbycMgd0es0+cMIp6SDZ1DLqx4jDjvusN61NvAm0XBz/8dSow9lIJ
	 MQuMNLuHbD7p1KrO1LvomFu4LVo0UYc6BaokMgK+Jr5GDXEPL6Js1ntziE/LZwzgSl
	 T6if62BgmvqhuKw5Yx4Cl3XmcXSGKIpKGUzlEmO2bzoTKbnCSVwI5n+qFohUofL7mi
	 uX7KlthbS0jig==
From: Vinod Koul <vkoul@kernel.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, 
 quic_vtanuku@quicinc.com
In-Reply-To: <20241209075033.16860-1-quic_jseerapu@quicinc.com>
References: <20241209075033.16860-1-quic_jseerapu@quicinc.com>
Subject: Re: [PATCH v5] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
Message-Id: <173503694298.903491.10995123391235816729.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Dec 2024 13:20:33 +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom: gpi: Add GPI immediate DMA support for SPI protocol
      commit: a131169dfa48d6d40da45bca67d1e4f54fa130a6

Best regards,
-- 
~Vinod



