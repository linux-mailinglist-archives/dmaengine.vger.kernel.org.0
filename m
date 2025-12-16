Return-Path: <dmaengine+bounces-7643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC7CC1939
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621B3304D21D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1C347FE3;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMkSjah8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784A347FD7;
	Tue, 16 Dec 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872201; cv=none; b=gk2ywLjzUIVATq2sPWcSXSa7DC3No5iNPqp7JU8zCU7xNoazhFfBQxzWZNIG5acZsTTweJknmx4hYtJtlM9ptgW4lffhBcrWI89A/nptWC5wif1rdocdyG1M0jTtsC0jGcuYgXSXN6QA1MHWpQPUi+e3UZG5kUhKT9b6tEtNNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872201; c=relaxed/simple;
	bh=5OeYvXMSFntRvGG5qfE6GBqZZ5Co1CPYfzo/K+UvU6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rKoGdXwvsw0l76bK+OXwFpE4RaW9FhdfXK1szs6xYOYUukzKI8qEh0tl96ADT/XVqpdIz5DiqrGDcIxazq5CORJShRadSiRBOWPCiBjzxUV6IOA1MOgiFyopycnl8WSWMJmRSn2LywLimv+FxkQw0xMZjVPgg3Fcdg15P+WmNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMkSjah8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91513C113D0;
	Tue, 16 Dec 2025 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872200;
	bh=5OeYvXMSFntRvGG5qfE6GBqZZ5Co1CPYfzo/K+UvU6w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aMkSjah8vnsdLaFUzroWf0jvqN1ZvuIuEICVU7DNc7L9zybmy2P5Gb3y6/NCee6iX
	 oUj1+003mOAtr5NRXY+QSS784eo4dcFYJI9OPFiYICGHr0eFW0GkmP2MZK3uF7IkyE
	 3x6+ie6pTkTU75mqFfKXCMlnjvcPVFNfKlkZLbNcljn+I3M4BHmWDq4vXbeDRuIO/n
	 aC/12ae1uID564LQ2Lm8Kys/LLXSWzx7wjzjiZHEqeUsoJwj5fdoePgVh0jcz/SIaF
	 3nCT2Ml6RDq8oKvCgmPOVs1sV8QIqZuk6MWZqlmCk35Ch+qhoi8RC/f8okjwlJ82i6
	 pA+D9yuIXyp9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687B9D5B16C;
	Tue, 16 Dec 2025 08:03:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Add Amlogic general DMA
Date: Tue, 16 Dec 2025 08:03:16 +0000
Message-Id: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQSQWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NT3cTcnPz0zGTdlNxEXXNLE3PzFNPkFCMzEyWgjoKi1LTMCrBp0bG
 1tQAShWYnXQAAAA==
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765872198; l=826;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=5OeYvXMSFntRvGG5qfE6GBqZZ5Co1CPYfzo/K+UvU6w=;
 b=wWM4MMb1w1IBw2bhpp5tF6jlfbiSZWVDh/2dF4DWMbv9j6YXf0iFkErQOd59LS4px15OCDLq6
 r7c5aLSdljMBKVGwXcMBrmumCstimx/SqopZrkCoRZLQWYEzlw7Ci2p
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: dma: Add Amlogic general DMA
      dma: amlogic: Add general DMA driver for SoCs
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../bindings/dma/amlogic,general-dma.yaml          |  70 +++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   8 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 567 +++++++++++++++++++++
 5 files changed, 653 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



