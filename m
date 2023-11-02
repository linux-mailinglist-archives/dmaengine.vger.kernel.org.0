Return-Path: <dmaengine+bounces-43-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B77DFBA1
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 21:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015F31C20FBB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Nov 2023 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98104125B0;
	Thu,  2 Nov 2023 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3R5u0l6"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FD208CC;
	Thu,  2 Nov 2023 20:39:34 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A922181;
	Thu,  2 Nov 2023 13:39:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so19453081fa.3;
        Thu, 02 Nov 2023 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698957571; x=1699562371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grYQIWgbXucL1+7FC1aZjuyPVvNYgF4xifW6xFLOhH8=;
        b=X3R5u0l6B4WCxarz67HYg8Wky5p7NHsh6+0oQX+0KTj35uRkeaYnD/IAy+SmcylRmH
         +0MjnjmdiHZMQ3/CI5MeD8QcVzoaTKAQ5RdhSCr/UPjykBDS8c3vZO3lGAv+6dGOcMaC
         YEMlHRNKe/M53qdWOlXchJpWuoHIMxwOm74/C/D9AeWRsVSwCSk04YMiIe3fVnuuodzY
         lE8z9lUk/7avYqtY+ZkmRkc9V+soRGO6sdtbDJHtzszsKsJ44hcR7Wq6dqUWRz0tpxHN
         vbYry6WgH2S7KqGdg6O5fXN0e7ktPuNdl3v6Fa0O/RNCO1iwvI2/MFxItPxg+BiIndoQ
         N7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957571; x=1699562371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grYQIWgbXucL1+7FC1aZjuyPVvNYgF4xifW6xFLOhH8=;
        b=Xv+Ge+FlmMGGru3QhpwoOcAfDuyndovIAjuDeTLdjrYmRjHwGVag04M80bNh4LKv3v
         lUGy7aO4l4/gK+v4xe5y/K+uvZxN2oMURxhDP/yxPx07DuAEYIyoDCmnvGfsM9g5FPj/
         ZE0WaJbS0NYebVgaNguO8KehWVqYhXLcMuQw+pqEeK8r9mH7DNjWuZJ52Qit3UwIWFEr
         xSk7Zx98abjIEXA0svpkIuKcRTkcfMtlrSwgsVCR0IBPnPRoJoOfdMXVQcIRu8ELSEFO
         P6q7GhnUaOPwa/Gss8aDLrSWNg6bLtZrqZom2KDdz/21fdYSfIemtFtUgWskh0U5vcsP
         mhhg==
X-Gm-Message-State: AOJu0YyhKvankdyQdOwHz/+kEKBc67C6ht8RJ6uV+p6LVBF6Ge5k/d+b
	oFcl2f/rPwjMLsFRx1I9J2o=
X-Google-Smtp-Source: AGHT+IF78CK3Pd6QAPRZgbcYPcc9m7luJi71eDeYjOsgXNFou2RfWXhSxNNo4RMpfDsdPbxLJmKuJA==
X-Received: by 2002:a2e:b53c:0:b0:2bf:b133:dd65 with SMTP id z28-20020a2eb53c000000b002bfb133dd65mr14376270ljm.38.1698957570956;
        Thu, 02 Nov 2023 13:39:30 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc00:5a9d:a85b:5d31])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b0040770ec2c19sm270175wmq.10.2023.11.02.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:39:30 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
Date: Thu,  2 Nov 2023 20:39:22 +0000
Message-Id: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index c284abc6784a..a42b6a26a6d3 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -16,7 +16,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-dmac # RZ/G2UL
+          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-dmac # RZ/G2{L,LC}
           - renesas,r9a07g054-dmac # RZ/V2L
       - const: renesas,rz-dmac
-- 
2.34.1


