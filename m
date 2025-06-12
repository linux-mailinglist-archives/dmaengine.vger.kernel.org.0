Return-Path: <dmaengine+bounces-5408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75BAD69B3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07761BC15E9
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0869221734;
	Thu, 12 Jun 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL5W68Mj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5B22156B;
	Thu, 12 Jun 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715073; cv=none; b=XYg5yo5MJJILkzI6nic/hSB0BBGNlDWz+auvf/JabTwDnG9/qS9ikoundA+xI8qmzXVjWyHZntzzFtSj0BIrMPteyaN8en2r9cwj/onv2/5H3adiyfK3aUM6Hzw3kd1zqhyUQdKNpLPeoyImQKTX/xjyWmpxwgbOepBfnPRbeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715073; c=relaxed/simple;
	bh=R6cDWrNLeIJW3a1+hrWpOXzcEBadxi2F3alk6u15b7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpYY8s8aUzJSXysi1Y7eMVNUO5WmUqf/LWjPGasSS5xgDCQL9HID2WkEn7pAqmp7k6Or8SmEiTJf7e6J21yx5CjBQPmTqh153IMRQBYtTo8KFNIvIeqqmTPVKyGaIdi4Y28salXEwth30YPe7fe7fj1ZnNoSI/8HUzXjswv5a+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL5W68Mj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c41acd479so360374a12.2;
        Thu, 12 Jun 2025 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749715072; x=1750319872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=NL5W68MjLZXSzAG7sAWph0VJcl81FOwOe27DeAtLEqWTTwHhn/85ntj3nRqgKIDVrm
         XyF1kliCJnQaMKdk3zyhPwuTL0/MvwQ/TL6pLewPXFQuJc8gGLz7KPvyF4q3LtHQnbMA
         9J8Q2i1KeDwbopN1HM8R80Mt/hzgs4itwvtIPia8ffORmrHXp1ddU04WLYWfyuEgijB/
         VrBOGJ+Nx5IsB5xW2G85Yj4HhWFdiOyrqvoCLQeNo0rdqj8pBa9XqA4sTqGT/DHCXafG
         gzjodEzaLW2IIhIN2HIgzOLE8Y5TdykYJjmpHo8ELf+6u4Nrc5JgGGFAKw/DRJ3p13WU
         BbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715072; x=1750319872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=hF7aJUuTle5YDz8ln0zA0/X/ZmkFkOWqbR+Baug9KdLQnM9NMXlfZ+8sWaArth5UYN
         HA1Zsf+12NXzTLT0F87AaUVuoxfStytEDvqCWj8L1i9llSqSkxLoC1Axxl5Ys9UIP8gO
         fMLuyZ3TJKeqFEvr0DrpOMIUjsKtS/+OWZP7dzXOcL+xc+n4UVb4JytLC4S3J0A0wx84
         IgIA0+UvH8ZMOoqDNH7vn/XyHABCIRWBOBT6urHfUDQ+Y5Zomn/xkKmxPQQGsKsTjdbD
         R4Heb4PLnKd/5r/ZD2Smmo0a07Stf4pcfFCwQPOsmqNZj7SQq/Q8NUlFi00DDQLgMI7D
         4JIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0if1L382Zu1I8v9d76l0J+xEVjS3r+5Cg2YFlaihFRYBr4ERVG9iitUdKed47XuLnfHDQXznr2JgCipGa@vger.kernel.org, AJvYcCUFlPuMnxpO3tN7xQvbIA/G03qj1Gx7y457YZXpEtm0HOWqzuIgWHc5r7z5+3jO5OlMkymzUdPTL0d7@vger.kernel.org, AJvYcCWvZLBJ22tfeovi7qFY0AUmNxuXJ5Xz6F2WL6/AOP9k2P8Gf8zltTqAp69XF2YKOWC2mD/l/fGFoZ5n@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLLO4O6CCnLBdXoyc3dsA+EnVuY7zkTvsTwPrlqQuGUVbhQ4T
	drx7w6+ARORbGNDXRhAkxd6zusDuhYukOm/bKrRYeAVTBJ6vnuLcVv80
X-Gm-Gg: ASbGnct0OiScrHP81IVpk4wbn6DklZL0zW2qIFT/11AwckiEVllD40hjyiRciwz5W/B
	dW0xpoviFVfgzm23zVp6cRRC7O7ZEKQnIndd8o1cisXfZvRdiw2wzL43cAxDKsayC4c7HoUgMc0
	HR8dBn5Ow/Q4HmeG05MMS2JVCWvtgSRhJwazwIMFVXAzNlHL9BNZ+/qk6GfTtW1uibPaYYHrGM3
	Qfuf0wfzILkCbH6es2nkyvSFZhf5CyeCDnIergq8BII0tcB2b2P76S7i9/5xpPEFjPBGwOecj+U
	200VC3C5z8uznYuNCTyE/8cfiKXJW138iO42lW7N9+V/FMdK9ylk4GZzZeMp
X-Google-Smtp-Source: AGHT+IHwN4jsDS/0xOuAgpZSjFB/2VBlT8k2vD4hhYJ2rd2lmdwwgde9/vuOmYHO4+Q557xe0+1pWw==
X-Received: by 2002:a17:90b:2fcb:b0:312:959:dc49 with SMTP id 98e67ed59e1d1-313c068ad09mr2970028a91.13.1749715071781;
        Thu, 12 Jun 2025 00:57:51 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e7345basm7880235ad.245.2025.06.12.00.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:57:51 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
Date: Thu, 12 Jun 2025 15:57:22 +0800
Message-ID: <20250612075724.707457-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612075724.707457-1-mitltlatltl@gmail.com>
References: <20250612075724.707457-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the GPI DMA engine on the sc8280xp platform.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b1..19764452d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,sa8775p-gpi-dma
               - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
+              - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
-- 
2.49.0


