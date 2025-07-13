Return-Path: <dmaengine+bounces-5783-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D63B02FA6
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDDD3B0C24
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68820485B;
	Sun, 13 Jul 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4yA6yoPi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF242046A9
	for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394080; cv=none; b=nwQIUUVloO7/RiScp7ca9BSkfAWgnqorbWtuKCDLcrvoanjscS+ab7ZTKPkF/NfVW0NYFLBwcG7hTXPLnRPYuJgXzFq6cSNuWhXWVS9+SHKGxvoLy4kGt6bkfCLs3WQzaLE6MnfHxKNA3N7E5J91Bd8mlzOPU8SOuxGNsBca23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394080; c=relaxed/simple;
	bh=yPJZUHzJ6XbbvDpc1ODgE88aN81oenBu6+oDbLZi6Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o32odOIctPxvZaW4gJhDpTl9bONeoM9T9DUFthoeoY0wvw6mjs50OOCGEMIjLkcLgBYR0rKy+EF6VTP0/PRl1Gf+6JShpK6L/pXHzkoKjdXnML0mzdMI7NFSqV7ADHMxhqOF+AF5kHbMjZrmM9oqMQqNjsrnnldv3jh3gkGqssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4yA6yoPi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1861677f8f.0
        for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394077; x=1752998877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq6707S6F7Ph6Bn24TeKW5JdfT2AUuElQEXV+Ub8YnU=;
        b=4yA6yoPi6nA8XogS+h88iocKe8iUorOKdq6CEkffaek4fVuzES58/+4wvxf4x2zBOH
         h59crMtSLFTngxNZTVnn3T2+r0RaaubOUyy/rCr9X7EHaEvR8u8dK4bP29Z9kXPsmXcL
         qsTZMyMKkwoUzPhm01bf94RJC1DYW91N0qEd9E36BjrCNJGG/BZCA1g5b4BPL5vWaKOl
         uPr3IYx0cfY0J7Fmfx0E/FKdGV1OKeViBvmU59kMdXChP9JwoHjoKRR9udVx+fZOHArG
         IaK0ix0NWG2L8t6MA2HJfTri3/UBOq2gwxiE4MIvcuxNb+bfTT4DI9mTVTMIieuUxwXW
         PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394077; x=1752998877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq6707S6F7Ph6Bn24TeKW5JdfT2AUuElQEXV+Ub8YnU=;
        b=nyuG48OgJgIdPl9mGF5jvH8HRm99RLQdP6OLBW2cHJiq5Ry3Iq2SATyXJQo/Z6c5rL
         DOLNLHUikIhJSoc+4z1KFRJXZmf2Pw9Zy5bt89h/FWf3yZ1CeEzPQLOOkXwhH96SXoa+
         C94Y2RmQWgSWh2mYdYugoK51PwTrrOaE7rtSvKBEDNSryrFPFs20zzK5v8wNUZDAoAFP
         r9VF01jPwcZAJzNpezK2ZQDOiW314TiuHUircG6xyW4Z15+Lyn+Wdxg3+UlFrP7cvdcx
         IQNl6V2toRJS/5QzQKDMcZMZRWU/qlxu0xeM2/Ta1txe2KMkOKObM5kI3WLfTV72Q0IT
         hdUg==
X-Forwarded-Encrypted: i=1; AJvYcCWsqWIkIHuBF6cvOcFUE/Z0N1O2xdoKZoEg866U/4JgCKgU/xYrEKVIuzUY0bJLOepKyONED+PZ1do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQoQ7PZeOjeHq6bYrwCVw054AW9LBbRXbHRVUjA6hIEMwR44c
	z2/2ZrEZuY5f3XgtSlDuSRd8zIwT4b0SnXe6JofeIlD8C04svirEuzYzeW3ZntLY6p0=
X-Gm-Gg: ASbGncvNL/dChxP9ZH7FryIcYl3slL4/Cy33tinDkjcdJqJXoD/qMJoJMS75b5hqcXl
	4gFjd7tsK1KreTStTDdi9LC9aiUNgUL5KQq6lOJFIRshxPGAJQvXgga4qlwunOGit2cYNp1jF8B
	bpolZ+5zre5m9yI0vk0chB/+hhDSLf6l9l3VndKnWf+kR54NFIOVvfGhfXRTbu/DcfZPA+Eo1l4
	xyNCUhlkJAXp3qcqdW7uzeqIrqzjsCjuLrFxmc7Mg1wNvh+M+e1si9KAtrAniYWZqNTBMnBEWJe
	aU4OTymUki5YgS9PNSlxIj3UDPiJGwtxm/OB2x6ENjkrvM2Yf7Cutdgwx/u3+v2xhDkHuAmeIEc
	nPsGBxW0uDNKtmv1JX1yvDOEpg1pnxq/oUc1Q
X-Google-Smtp-Source: AGHT+IGMCdx7d+JV7VT+NDUL2DlG4mtQQoySy69Gfp3Ds2b0lZ7KbU9s/Vv3M69/0Uqu3iIlOqMa4w==
X-Received: by 2002:a05:6000:490e:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b5f2dd49c9mr7880135f8f.25.1752394077215;
        Sun, 13 Jul 2025 01:07:57 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:56 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:34 +0200
Subject: [PATCH v2 12/15] dt-bindings: arm: qcom: Add Milos and The
 Fairphone (Gen. 6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-12-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=994;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=yPJZUHzJ6XbbvDpc1ODgE88aN81oenBu6+oDbLZi6Fw=;
 b=ymzq2LdMSZzjV86mE+IAARRAmbShVDeXvVgWjbmxw1Q6I+K7W0/9mujh7mmVhB2ZPk3JCIpSp
 C8m500WFnKfDTPHOjcBz48HP3rjsUZ2kL+OAwZmfz//lxGpiwkj5SEo
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos-based The Fairphone (Gen. 6) smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 56f78f0f3803fedcb6422efd6adec3bbc81c2e03..38871129f8a271bd5005a01f174ff5127a3faefa 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -34,6 +34,7 @@ description: |
         ipq8074
         ipq9574
         mdm9615
+        milos
         msm8226
         msm8660
         msm8916
@@ -155,6 +156,11 @@ properties:
               - qcom,apq8084-sbc
           - const: qcom,apq8084
 
+      - items:
+          - enum:
+              - fairphone,fp6
+          - const: qcom,milos
+
       - items:
           - enum:
               - microsoft,dempsey

-- 
2.50.1


