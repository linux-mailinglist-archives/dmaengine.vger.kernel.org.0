Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754BF3620F4
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbhDPNcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Apr 2021 09:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPNcE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Apr 2021 09:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6A34610EA;
        Fri, 16 Apr 2021 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618579899;
        bh=DiL8azXw7EQ88wcrJFGSG3mIfSvPLDRKS0/YVCn5MBk=;
        h=From:To:Cc:Subject:Date:From;
        b=s97M0mZJ4BCa/vv5ZGM1QGct0qC94FS1x7O9+R+e2ZPgBoAqzrYDDNoBfMrFPc3Fs
         TitjYxG5ipWu+ggNbxFPlIX+JTqpejNgbi/T4UhmHT+W53hQb1NdxjoBVijtnbH3oE
         SZTJ2IE2M+wLzCid31BmRk8ivoxVGvP5FryY0sgTX9s5jpxE6FYEg8RnfUPUKLxwFJ
         uhoWs57jShmw1C8HksFanFzHVpFIbBi2xlCmsFLsKvEJegKA1xk9mWmoldHaurfJAB
         UkBmyAvakruCdHPrV7khVs0HZEKA8P0tKe9s0crUAxlzi8KBUm3AbkEUiGWEqB6JNn
         iQt4ng5DVA9ng==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH 0/2] arm64: sm8150: Add minimal DMA support
Date:   Fri, 16 Apr 2021 16:31:31 +0300
Message-Id: <20210416133133.2067467-1-balbi@kernel.org>
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 72 +++++++++++++++++++
 drivers/dma/qcom/gpi.c                        |  1 +
 3 files changed, 74 insertions(+)

-- 
2.31.1

