Return-Path: <dmaengine+bounces-7646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED3CC18EE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94089300FB38
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35B348479;
	Tue, 16 Dec 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnPf5Gv+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2334348458;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872202; cv=none; b=JEvO5rJjJkUVJf//ONIPHT+E6Ko4QTi3p+AwiQTEuahIIDBugxMzP+66eUxfh0wb+nQiHKMMdE/m9cx1xRCFdQVoHVSeynrTaLpijYkaItfTWT5p5oJzCINHryCCxL8bh74QbEmmLRer5/kRUsIzXFzPw8Zs2LXbVZO7FLUz6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872202; c=relaxed/simple;
	bh=uqORFx2rOlGaU1rPovioax/w0dRcQGqNILNOAxN6eUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPkyfeYAYSyM943Cw/658XDL8DT1HJm5WRH1lFrdWDkX+jFOiTznNqIixFOyb9hgvsYtJkp4ixuA+vHwG4+gGb1ASR4F66ZWt5Zkulwcs6TGr7JKPZjgjOXM2vSvF/eZqsmu7ks43LLr8vFnlsR8OD0AH49oJQZ0k5VSkYJLWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnPf5Gv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C80C2BCB0;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872201;
	bh=uqORFx2rOlGaU1rPovioax/w0dRcQGqNILNOAxN6eUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CnPf5Gv+/gj4b4XzQiZWd7V26J+0IAtigmCzuuxhwCvZPthj9k75Uxrtyzq0eEwUw
	 XBX3uILfiNA/kuLhisga6pQjwFzwm/QU7OF8P6B4RjNOmYrkDFTspUW7NnLVbVL0vI
	 sL9NsIhrkrjlWwa8/lbqVwu7eM/saKGSIy7C7iQULoNPNq9J2rS+BfDG/aiL2PMJT0
	 AIRnQGrB3leg7OngwF8WnDJWhMG1ljGSDq/afM7lGZfXRifO8Rl2g0eYk3RouPBgIu
	 hsr20YdbAhGlA2rZc3JtPX9VsOqWmG4JSeAfnfcmw23LxrWRH94jusTWaPe1csL195
	 GYJp2m9jvG0rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FCD5C0D0;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 16 Dec 2025 08:03:19 +0000
Subject: [PATCH 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-amlogic-dma-v1-3-e289e57e96a7@amlogic.com>
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
In-Reply-To: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765872198; l=796;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=gtytR4NUYl71zEdxW3qz6sET8405pfbFKpANdMYABG8=;
 b=3oYzCundtIihsisvn6/mvf0uZASrPiKzqf4iJ4R33WfBYEDEpv0qPCL4lp4j5YJqYcBLpJwRO
 vUiH197Ico/A61qhC0l2iPk6K5PaFf0MWw7Dqp7P7dGDNYtKTbNnkDh
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic DMA controller entry to MAINTAINERS to clarify
the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..f522a34c780c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1305,6 +1305,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
+AMLOGIC DMA DRIVER
+M:	Xianwei Zhao <xianwei.zhao@amlogic.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/amlogic,general-dma.yaml
+F:	drivers/dma/amlogic-dma.c
+
 AMLOGIC ISP DRIVER
 M:	Keke Li <keke.li@amlogic.com>
 L:	linux-media@vger.kernel.org

-- 
2.52.0



