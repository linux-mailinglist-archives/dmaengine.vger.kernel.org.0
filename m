Return-Path: <dmaengine+bounces-5509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419AADC591
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4535216E9D3
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DAF291C0C;
	Tue, 17 Jun 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+ZfMoPu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC5290DBC;
	Tue, 17 Jun 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150863; cv=none; b=r8yjM+01eWvPEJflcLWCiHOOFIqUY+7CHgy8lcrd0A9IIpZ9rTndAKjhLBdyQeLYad6T9gGeUnWdzQc/3XxbJA8YnpijW55qTlv5Jez2cPk0xjYZdPm4hR/97+zKAf/zCAS9MZM1vbIUURSb3xKaMpSvSMZ4kBm7Fpdn7wCr2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150863; c=relaxed/simple;
	bh=R6cDWrNLeIJW3a1+hrWpOXzcEBadxi2F3alk6u15b7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1lBI5v4sirgpsA3E0IBhAj238qjwNLYG2AvqBCYETr5PHyAPKicoLsVajGqd6mRNlO/9uKt7e9N3IWuW5XS4o+lMVqI7wNLUT1d9Xc9Lxoh3nSgoXBJpi2AdgRyhqxmlP0mokMRDjzMA/Ohqs9kUPKGF6k9Wg4xGkPYPJ/BQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+ZfMoPu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236470b2dceso46615505ad.0;
        Tue, 17 Jun 2025 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750150861; x=1750755661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=H+ZfMoPueLSIw23kP2lUWS2OJ+k1CF8gMbkwkrcxC7JifSnKVV9pOLB/pOE0rF3e7p
         ToCJhJfjN8PKnAzjKAmqzlfGGJRwSNjAGajxQ2pQddZr3ayxejFNBbE6v926mHUi8u7E
         AwyG4cPXHfy7Ebhvbkvx77ivn3DyiYcsMXF/RPkK9zGPLJNdQgq4DkLMg2utvwog2MBg
         Ya2vMB5JEF8wFY6Iwf4B5QZ6wvopX8bqs7bMVeq81zrC5+5ki02eav5vsuBOvJyO+p/z
         O+gb0zXs43tWRlbeIK2JdygDhdZp5C4Ks18XTXFjt1UAzIVuAFWrG9T1o2agrU1URVBo
         tM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150861; x=1750755661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=OOUKd+pAA7k1p4YHQm54njxqgYHKO+8vj6au8DA3UT5MUTKD696a6wve76RBRjUF+0
         n88YRk8XRr3h2LfmOphrHeXH7d7rDOK1HchEqGi31p0AeENDruWaSWunLLjDw7feMSre
         QY8se6noDk79Kf7Mp3vvny85X5wRbXD1DLc83FNkh/PqZbcdOoENFEp9xgYOuwmU60Hi
         pNpAc7StI8i2V3jERqrRRah3gn/TLvWaeClM+fTEPEIYkpdrz1TP6UrJkRs4mSiSx9hp
         ZwmdDBzAma/wjsXC94Ov3f37peq3TGL9Ee1nIkkD0xapXyls9k7PQuIjF9tfvCn2/SA+
         FhUw==
X-Forwarded-Encrypted: i=1; AJvYcCUlbQiwEkXYYMfsV/TbCQTO1oTOqAip07VAvuqu03JpgBT3oYE7i1JMmRhqgSZjvSU9JSoXesrv4JZU07u2@vger.kernel.org, AJvYcCVIJrsUsp0DFvkttATipsX5V7/Um2j9eZrtx3l6BvvHYljc7D0cnOv/iI8frl5xjTJ7Y3in2XWz3WDh@vger.kernel.org, AJvYcCVp2qEQ5x9bunPi/NqjkxTuPF0sdf2+lDCEK/hVJ9xgXIQAsGxCYTa9NXvUrertO6qPcvhsXhX/WDAt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjv+kU7zpAUcfT6vu+fAg9bHX8+OdVJjURXTAx/jfPSE0pbcwZ
	rOKtD2ep2FGhipS7sVqepiSQZQzw0GY2WJSxyJK1030HUJTRY5GZamNV
X-Gm-Gg: ASbGncs1PY5v6mE6bjcygKJzczoRcA3uN/Mg11Y7Pvfnv0f/w6SfhSFyZ4CQAvIdUkT
	AOjPCeJj+ZYNtWm5nbEvKcqsHEwaq9Gn7gld6ltYMzawdj1Pb/+TOBnzbxjhc5bMNW9Z+8VvsWW
	tTu35soGhkPkXXpZhBFca84kIzyF+E/oHT7mwEUtICbiZWtSYxBTji0bQj2unlm4hBSzc2yltdF
	lIzodwm4Wz3VvXIioA20ZGiyy7/5t0mYWpQKRtZdE8ppOMPBUDEuZ3lTAoy6R1cGFs0by9ZBc3R
	SPUzaZYOeVmdRLpBtQOm3eZyn6eqX6qMWC4rxraP9wuIEi+/MOJauy1CpjfX
X-Google-Smtp-Source: AGHT+IHs/uJmFUCNHK1QnlXA63q+Sxd5JSmvrmz7VFlZLPBuzdw7ljtu8cVK6bcGcWXbEvy4lVYusg==
X-Received: by 2002:a17:903:1b45:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-2366b32ce15mr189245425ad.16.1750150860856;
        Tue, 17 Jun 2025 02:01:00 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c5fsm8301764a12.49.2025.06.17.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:01:00 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
Date: Tue, 17 Jun 2025 17:00:31 +0800
Message-ID: <20250617090032.1487382-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617090032.1487382-1-mitltlatltl@gmail.com>
References: <20250617090032.1487382-1-mitltlatltl@gmail.com>
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


