Return-Path: <dmaengine+bounces-5776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733FB02F78
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 10:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16501A60206
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7120102C;
	Sun, 13 Jul 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yrzg/RZS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EC1F03D5
	for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394005; cv=none; b=Pao+0TSL/Kry7OJM69rEgJrXr25n/ShW/LRIQjntZgXSWsb/BUCY9jvAadqaP5+A5oAg3B36HgEfaZxKj+DoB8B33scXFJRfbBqUto68C3PoXMAk7lZMcgWc/QJpoM3Q+mwvrNTfr96xDIe9bVDVKXb1T1dNF6/80jriFsKkBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394005; c=relaxed/simple;
	bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH5UtS3E5TH7XMC3+L/NmShIDJ64sXe+CwTAbphAtJyHK7Ut5WD3W4OS4tvetu6Qquk/DQobu0klQR8cUeWUyfXmoeAMIf6qTWYCBXSDAZOrFSXThWV0IvGp/FEGWGd74GgDUO+PJ+QnsTJ0LcgN8ZQKeyqyTHFkThzfhAXWcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yrzg/RZS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so4680805e9.0
        for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394001; x=1752998801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=yrzg/RZSbkRCAWDNuAre/ZMEHVwFjv3P+GTZ7YwKmqhwz1U/ldqpMjXeO6cwdnMOaU
         iPSgc1nJthruNehCsXOtSuQWw8rHRyeciTvxrnt/vhPP527EA1v8RqqKjsJVcgT2b1dz
         GNvjfxWp7MNXlHMiCAkxk86nsYypGD0BgPVHpXsodf4biaCOpwgE2Ss3/WxHnQB55r5U
         R3AV37B2j2HY8h18JbYzT2pJELqfPuKfm1YZm6sv/Hk2BdTbFSOt09ltWmodaPYFvfAF
         JzTu9h1Xw5w9RJSPZRHKDOE+epZQIlyCjyaki9vyKFrkZfLB0BHRLrGRHLQvogk3tGA3
         88uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394001; x=1752998801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=vwQnpmULTj+Ro1nmJFRGhALqLXyaFWay/hyU0SIZ+C/deSwCLJMrJT1sMmWl6QAYSq
         1FxVi1dYkkm3+4PvRcyT2Pw0mjlpY7gz+HLNnoyVxrajeVTahcBT2W+xvaD9SfRIFO/H
         BTp+yoqnVIzjtxAU/VpNbG5aosaEV0ecXcBV3slpigXKNkZFL3j7Cw4Yjv05mG2FDVbq
         20qWXymX2+VQaxdK/hE8zUgcPamS5ox7w7/ejxqLkaYvM1wB6iX9C1OmWMONasePnZs4
         owXfmdYTSmeZLn4T1XvlhHOcq9XVSvwF/DQUkY9me4CHD+9UbGMvzWNFxr6WMozMJvl/
         g+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUchefLx9U+J3RTcbLBu4/t5ou3N6sDTGfblOLMILunEN3smSJ7gQoy7yTioAQwntafN23y6dvoOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbAPDG/1V0SyiSvYiVg5oGnNz491C1lLqX+JWidyMelPxp/yg
	qoakpddV1Mn6GXSnWTuglK49rltHmzHOvut6oXCdjNn3HvYBFs+u+O+R3e+nSriRN9s=
X-Gm-Gg: ASbGncsjq2TTn37MWqH/Ik+0+WlvGhSbT43RWB0ASDqMoUcg38nWEsTxa0aj1XUHohZ
	fSS9pe4iDXgOXeplAh+2aXPC1O+ehAxJj5ENnTXobzPootSqbVy2AAAifIWdmZsZj4woIyy1++x
	dmiCTF7uLx/pMJdaQ0oTtWCboG9bBwsTbjn5cCbf21eXHUoIbbycL3yxCOpJpbtTjvH8IbGuOX4
	9mX4HFkK5gb5z7/2D3vtkGhbqcCU5Bm/d+b6sYAgAj8gUKWD5DpKK+fTwJmFRO6DJ9ym93OiwQR
	vs70XaNde8qwkgOOwJHr666y3muY7JEmrhfAUC4iCNDv5tAUuvgXmKg66RSfPLsspNOpg7CI/F7
	kMdjx2mSuRhIyxjKMrosDkoZ6wcd3O/Z0t0wg
X-Google-Smtp-Source: AGHT+IHyWnqMEVpaRvOXMO0vblvM86y2YgLw6BQSvoG4RgYbH/Ui7SAEt4W5s37bEA/xrCAo7hGufA==
X-Received: by 2002:a05:600c:3f07:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-45615a19f78mr8952975e9.13.1752394001510;
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:27 +0200
Subject: [PATCH v2 05/15] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-5-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
 b=XFV7UWYTfrWv1RcxcWxJVUHuCP5Ysa43LHrg+BrPBDS/KgoKimDYxgTjN9ghI3i9G3ovnwPgG
 q1r+xiIEV0UBYOCual5XEBtwmgOfedsf3RrNLH/7nc4A/rgd1Nrjzie
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..3f90917a5a4dd9d068ec472565f5009690ea2c5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

-- 
2.50.1


