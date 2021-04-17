Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0482362DF6
	for <lists+dmaengine@lfdr.de>; Sat, 17 Apr 2021 08:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhDQGUX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Apr 2021 02:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhDQGUX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Apr 2021 02:20:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BAF7610FC;
        Sat, 17 Apr 2021 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618640397;
        bh=XzacGwZkbkzEsDYL6tQRR4fmj0U6QvXDRhCs/UdP9nI=;
        h=From:To:Cc:Subject:Date:From;
        b=b33i2tNnvDRnPZSjwBWGD0VSuTsJrwRLlq3MJMCQBVjk/fziUQBPY/6BjvOr6JHdf
         +KHBxYCtX03VuhxBeIi8HNIHRfvP/LuPpNYPy+Rm4Zv+67KUBUi3DDz53RmYxBV38x
         ZZQbn5+ziSzwH4fmZyfX7X6l2o8Z9JSrFyswpdnHYL3SnH6P8q8Egh5nmEdM35dNLW
         t7Jv7D4xVBoAPye0/DOyGXmJX/DW3CwNDfcrP0nQ00Ox/46KjcLhXXomUmSrtl/Q/W
         ajitBY9R4G1zWZqMAbZl6ZyrWy1B1OpMmiX54tNfNXZo6z48aEow4ZhmmeJPPrFSDz
         BC8qGHnkoA1cg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH v2 0/2] arm64: sm8150: Add minimal DMA support
Date:   Sat, 17 Apr 2021 09:19:49 +0300
Message-Id: <20210417061951.2105530-1-balbi@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

Hi,

With these two patches, GPI DMA probes fine on sm8150 (well, after
setting gpi_dma[012] status to okay). Future commits should come to add
relevant DMA channel mapping for the various IPs.

DTS patch a dependency on I2C patches by Caleb Connolly and SPI patch by
yours truly.

Felipe Balbi (2):
  DMA: qcom: gpi: add compatible for sm8150
  arm64: boot: dts: qcom: sm8150: Add DMA nodes

 .../devicetree/bindings/dma/qcom,gpi.yaml     |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 70 +++++++++++++++++++
 drivers/dma/qcom/gpi.c                        |  1 +
 3 files changed, 72 insertions(+)

-- 
2.31.1

