Return-Path: <dmaengine+bounces-1958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D258B1DA5
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08459B267B1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686486636;
	Thu, 25 Apr 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agdTBhRQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B28627A;
	Thu, 25 Apr 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036650; cv=none; b=fVRNio49KiCPWu3Dv81RXAGaNSzY6VwFUn72ClYFGh60NsgInuyEwrJmKIrPyoOK3FyjwFaGzlAOXN5T7B7BkAcVJ8dlGLT2VAtkA5UU/TQdmWLgJY5TEfhpG2PFAqze2P8OZ9ODhuorDpmvdEH+x6NqBEtM4o7HO4dN/WRSYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036650; c=relaxed/simple;
	bh=EPIiasXKYTAWquT+sUG/WQiZTN0yIrYU7At0TkV2A3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=soiRzjako6rWnDmO8dgV32aq1YTypGEMGK6FdYLblilGQj50aBfQAV30UdH6BPAzH0JkmxtPAPqMWr9yXJDix57Vg21tZaN6mv257ss99hbMYLjAlsoqtaHJe5icaRVJSU8FOcA/NRTWy/npGVNNM7aq0CbowXvCXyWLNzQC+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agdTBhRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4338C2BBFC;
	Thu, 25 Apr 2024 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036650;
	bh=EPIiasXKYTAWquT+sUG/WQiZTN0yIrYU7At0TkV2A3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=agdTBhRQP0/CjZY0jaZs/r9x+YlWKAtXqF1wKumbx1Puc70WItaeyWDeicLIhm2Ct
	 Tw3k4RgSiimXDZjKFBu5pyyR0YxMbIWmsoim+dspDpMOZjLVX76OvE79sFuWTk77yH
	 t8/4qK4osxga6qHIUNRUGbh9VCDHxe7SGfTda4YmkSAiR9qwXaOKmKVdnKuxemVeWy
	 Yo/+9ddAG/NukpFbpXgSPhe27R7/5rSBCpI5jJN0Q5OUIHO9XFFjyf3w85nolmWwc7
	 3+VuYACWNBdgYHETX7N6EVVNFU56lRI4R189+88zXtSW0qwdiB/5rUqR3WiDxcKmsU
	 /2OIARZRgxhQA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev, 
 joy.zou@nxp.com, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, 
 linux-kernel@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de, 
 shawnguo@kernel.org
In-Reply-To: <20240419150729.1071904-1-Frank.Li@nxp.com>
References: <20240419150729.1071904-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: fsl-imx-sdma: Add I2C peripheral
 types ID
Message-Id: <171403664527.79852.6338713889977075573.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 19 Apr 2024 11:07:27 -0400, Frank Li wrote:
> Add peripheral types ID 27 for I2C because sdma firmware (sdma-6q: v3.6,
> sdma-7d: v4.6) support I2C DMA transfer.
> 
> 

Applied, thanks!

[1/3] dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID
      commit: 458bb56d53c9758ef873b4f373660b1f02b98d86
[2/3] dmaengine: imx-sdma: utilize compiler to calculate ADDRS_ARRAY_SIZE_V<n>
      commit: 1cb49f389d5985bd9ad6ef37f856f368c3120f77
[3/3] dmaengine: imx-sdma: Add i2c dma support
      commit: d850b5bae0f5e435360edf0474ff446622f0d899

Best regards,
-- 
~Vinod



