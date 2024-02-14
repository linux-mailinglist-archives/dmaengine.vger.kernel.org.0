Return-Path: <dmaengine+bounces-1013-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E848549E2
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 14:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16A7287C39
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868352F82;
	Wed, 14 Feb 2024 13:00:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA552F86
	for <dmaengine@vger.kernel.org>; Wed, 14 Feb 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915647; cv=none; b=G9Zg/zXsU5anpTPwJz+PsFFcg5fEF9mb+tjYqF+n283dShKhzHfH+z6LP1CUsF6CfALaThdT8NsuYv27vnqomeWcl2fUGDqOapAPTOVwWLGhEzEY/ueSeuQMEKWC8nL0x8yZAFAYVLRFoqV1q3I1Y2s2CMK0kjPLckJcYvic8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915647; c=relaxed/simple;
	bh=LzxoTaWp9eedO8hmt9+Sy4tlj/1LNVZIECA5zijI2PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fA3T/5L1i7N2KdNxQ000i6hKBm35OK+9FzzDZELN4DZOoTWSl6M3wmZhP2N7toCfY44BGwpD7FWi58aC7vgK0Zoef/n5lT3uWrM0m/eSS2BU3MkKPVteGVgTUG3eJbgZX34fgHmFjElIfb2PwLaj/ZcwxCSll/HiJB6grtOI6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by michel.telenet-ops.be with bizsmtp
	id n10b2B00A0LVNSS0610bA3; Wed, 14 Feb 2024 14:00:35 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1raEsG-000d4T-Dn;
	Wed, 14 Feb 2024 14:00:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1raEsN-00GpXd-0R;
	Wed, 14 Feb 2024 14:00:35 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
Date: Wed, 14 Feb 2024 14:00:34 +0100
Message-Id: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Direct Memory Access Controllers (DMAC) in the
Renesas R-Car V4M (R8A779H0) SoC.

Based on a patch in the BSP by Thanh Le.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Replace items/const by enum,
  - Drop changes to non-upstream rate-{read,write} properties,
  - Drop unneeded Channel register block change.
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index 03aa067b1229f676..04fc4a99a7cb539a 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -46,6 +46,7 @@ properties:
               - renesas,dmac-r8a779a0     # R-Car V3U
               - renesas,dmac-r8a779f0     # R-Car S4-8
               - renesas,dmac-r8a779g0     # R-Car V4H
+              - renesas,dmac-r8a779h0     # R-Car V4M
           - const: renesas,rcar-gen4-dmac # R-Car Gen4
 
   reg: true
-- 
2.34.1


