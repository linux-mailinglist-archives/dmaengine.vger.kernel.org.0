Return-Path: <dmaengine+bounces-3392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5309A2BD0
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2024 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFF21C20958
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C21DFDB2;
	Thu, 17 Oct 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1CDtvXJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D41DD539
	for <dmaengine@vger.kernel.org>; Thu, 17 Oct 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188721; cv=none; b=lv50yeOz3wB0bEe+gZ8XlFGtzk3ZFc3RhGKP5VYuDxtdCzq0oLaKVtkmm0K9SwCo1LLzf8hC+0TxZ1DcqWvh/Y72oAkX7h5yUDvEfNGQcZp+xrex9D/DHfbrpB6/M9AIGqYLG9R++1Jfuj1EVEALgs91azoQcISmRKVB5OJAy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188721; c=relaxed/simple;
	bh=z9gullE2/djCQd7k5PGKfGuUrtvUKf8lsI3Xgek9AFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UQ7kQ+2kgzxH/bkIjqY2JcFNQ75NZKPlp9cAXuhgWt5vWBDE/vIRbrD530dmoy2kb/jeQa6rf9MN30FBJ/X+SHVAvMwA0X02AquTc45FvR35zLsD83MKHrW9NDZHToM4nB/nwfZt+3uj50XXalFrlaPyXaHHBoDkJaeGpP05TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o1CDtvXJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f53973fdso948753e87.1
        for <dmaengine@vger.kernel.org>; Thu, 17 Oct 2024 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729188714; x=1729793514; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZxiQQYnnLiYe1NRYLfa18e4fbcMTEYgNWx6js0FYHU=;
        b=o1CDtvXJGzTGMDnruAs+abheYhVExHZd+snyzA8Owl3nsSaWVMAl0zSEu/wau6V4Y3
         qkSAX7BSL9gHjcQSZb9r+SI+DOKtWjgEnXWRFW7CgcDOuv2F8oE7dUMIzKgqHtdNmKC+
         I5j1o9jAsHxnwN1XkQsxZmLIc/FSXsqKejNZQlCQliKB4CG8M0GPRSbzMmTik64vnoOg
         ldRr919Ume2g3y1V4IEM35SoFiKvuP6XvVZnsQmHPgnuhKvuPBgeWTMj2xF82TXzcvD8
         nPUVdy70tQlAq8uvvEdWY/h1XtURKr6jkA4J74Hk+WBFYrCRmFKZBEQ5T/ly8X8eA8Dw
         43Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188714; x=1729793514;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZxiQQYnnLiYe1NRYLfa18e4fbcMTEYgNWx6js0FYHU=;
        b=fNebF9+C7E2z8RYn3hNo3G6yzw/yjJDFSv/HKPbkHeFfXyv1Bg0DT8NXEq9MEoVYC6
         qfopXP8hexe5DJI42gPN4DNzEeMSc3a4IE8t5GSsV0hqdEGl7ht1kpt85A3CvJQG6eDY
         sPOLWR3yxtuTEozZW92aT09DOmp+38JaR6ehy4B/FmBx3kgmRXjW/XlMODVMziN0Zpvk
         U1YTw4otEP1ZLtyOBjtJUV0w+vtE8bHkisMVkYuiRmIAKjG1218241Sc9uldc0ubcACg
         c903/ZigIqf3f6PhWDa8xWKMIwlKOTXM2tt9Kq1OWGvy2liIMRCEflnoUnTuf/mnmRhh
         t2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWR5fvnlqSDCENnx2ftDq+BVY1HRHBEdVh14eDbbxpF+JQw3USJXtz/n858QWTj64tWxDJTUtsllNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1zfBpWFRzSx44EsPjLmRCsdvSsb0c18lD1FEiFqHJJYqqsDk
	tT6NQHIwQdqS3QosqFefjm8ZqWq1YVuZVFVJWSMFluiJSoovcIma03KWxn9H5cM=
X-Google-Smtp-Source: AGHT+IE5cnTqQ5nNqL9y5fKWUoLBqqEK62VLizium6/dxI7EPCeyNqDLop8VMZBt9ejWsGJejoilFA==
X-Received: by 2002:a05:6512:2c0f:b0:539:e2cc:d37c with SMTP id 2adb3069b0e04-53a14ff6cddmr12725e87.3.1729188714046;
        Thu, 17 Oct 2024 11:11:54 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb232fsm841113e87.109.2024.10.17.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:11:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:11:49 +0300
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Add SAR2130P compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-dma-v1-1-e6aa6789f116@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGRTEWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nz3eLEIiNDY4MC3ZTcRN0kY0vDFENjIDawUAJqKShKTcusABsXHVt
 bCwDDVe4EXgAAAA==
X-Change-ID: 20241017-sar2130p-dma-b391d131d108
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=z9gullE2/djCQd7k5PGKfGuUrtvUKf8lsI3Xgek9AFs=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVNlS6PCgdeyOaFQx3n6iIhMvdxOmsyJUyi/Q
 UzIwVb++ZSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFTZQAKCRAU23LtvoBl
 uGpWD/4k1swyZNeHRK7hgB70TpyATfXe1b/wlp8gNQ2MFbcIrH6+/IPk8cWQdMpqaHrr6mB+Jry
 BwKAqikkOmKT8rvkl0xWEFyD8HI7vrbouF7hXcFCHxi+w2dqOCls6jdQqm0j+XhNIObhaxVg46g
 JeBMVdMtya9WhCtLOapsfupqLB0PXcWijqiPX2dKtJlbDRSY2RMZD+wlgwxA/zuDS57amFVzY44
 eATUu6FxPADBt3efcBvsqWJquia8ayWxETC0ybG4rjEI1p5S1Bu4JbehMDFhMzTZx71UOMEmK0u
 SiWyW6CQt/p4w8F1TGIafHCXpkYlcvj7etxMslgewL3fBnEItXsiSfhaqcqZDpuybP5N/Vw6L0z
 5zV+e90q9OeNPtIk+wD2JbAYzRfwOX3KJ02Gnd01vStMlnEmoIXAe3HlXznqUSYoJuZFZkd5doC
 xvtH1+Mpps/blQOyoBkNAR61wRw6azLYxSpY0cS0vZCFg/Ig7IBzFdLrm26vpMZ9xXW48PtcRBp
 HvMI/gx0AMXsO51vE8dttlDkKwXCuQhKiI9BHKkdOifcTMoJ2kpvWKU/WDgkMUHtu7RqEdxKheP
 aJNa/4IUo5SkPbG7vjCdY+Bbm5U93oVLoUsxUOsJfjWGp0riSm/MaYWwgTbTTIE4UvNNaOOcsMX
 MS66c/OucR0fBVQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for GPI DMA controller on SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4df4e61895d2129caf7f2ad9b426d78b60f9c32b..4ad56a409b9cace94a3a4c4ec94d3ad16232f5a1 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,qcm2290-gpi-dma
               - qcom,qdu1000-gpi-dma
+              - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-dma-b391d131d108

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


