Return-Path: <dmaengine+bounces-1533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45CB88CEB7
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80553327859
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957413D626;
	Tue, 26 Mar 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+dwhjnU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A31411D9
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484675; cv=none; b=PMsw9VdX7PxlnlctAhHHW4qWK3LE7J4a2XOuyUj6x5ZrdjROYtEpNaDcg4dECsT1YFmJHDr38xtYzGihJHgTZaddGmjp7Y5mul7THSyWfjs2AbJxRPNqCtDZeaO32o4Iq/HleEFrd7t584FshUB5qzDXKitR3GoHcMH+y/WKH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484675; c=relaxed/simple;
	bh=kLMu95DaVyD3knCLGVkowZHpAylz58hzFrQ+URJH4DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DG+S/snKAU4xIvonf019CxWAz5rndjp+X5DGsLMRByaYAWWri2Du5G823UHmyIvH8gl7BBOAGrVVS7ylS7anNPG+YdHDUA+ADsjtOOPfk89agRfPiOnuhsJoOtSnS1L2cOA0kNJNMJfuAoEJMNvY1mBH/f4X43pnsvcSFpAcEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+dwhjnU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso716486566b.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484671; x=1712089471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXijxDwurJAwpy4OgwF7Dn1W0Fknvemik+ebgBgDuPM=;
        b=v+dwhjnUILkSj//6lNq9+rDA5Xa055k5PZSWktC0H7v3bl6U6xQOwl9XtqFwV3B++5
         4KiGHSAjYEmuyspwueiPyj8qnsFc77Sn7SNqrJP3ARqYPNnsqcqvgViUt1fSMpIrLYKo
         FBbiB0Oa0isGT6H7e6+eyAyFfSae8UiHrO1aVjCFvU0f04AAvh09e/EIrqMqz+5YZu80
         XaWg4WvIJngjk6QskS6DQf2l1pAx744U0x2X/Z9NkG0pIuiggD7uGaLB4lAfPFFaxO1T
         TIHY90hwuEkJQGUwd0p3ZDyaHJlnNm1LBoG/k5BdCNol+M3aT+OPdaI/COH4zTiMywxv
         5v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484671; x=1712089471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXijxDwurJAwpy4OgwF7Dn1W0Fknvemik+ebgBgDuPM=;
        b=aliDGJV2RBunP3iE0qCG4zQ5/bVL/0HKFJ0RpHkRO8ORsbVdA9eFVa3SKgD3HzHs2n
         TSv/RQ55Z0PwAnwUufJS6rmSci5QbdOwCJEZ7seSXS77JwZwOS4LRzDOVgLuH7Y5X31W
         23mJE9Iwlx1q0sDyaLrnWeuan0xeFfDwGpUztZDf0HehjphaRP/K4tXcEF9PqxYmIyK5
         L6ciRIRyCvIhf04j1lQJiefvO5Cv/b4dNHULL57gGay8AEleNxoLNJhDUmCKSrCh3+7b
         kSI83rx05lE2iB4h+nCrzG3n3chU+ZNDDLbjoWWhZhpnApea6qEh8+PPBy1+jJogFrcJ
         vEDw==
X-Forwarded-Encrypted: i=1; AJvYcCUXXQkZrOlyN7xKCBtV4gHbiROlz9IjxVMEq2ifuREQ2myOieHT29ZZz+FOY6+EE9bmhfcNmlOpIFuPwsvDwtr7kEnFVAIvDGDr
X-Gm-Message-State: AOJu0YxfCEqC0xR25qzQq2oqNzqiDLgZ16fhuawqX02VGzquugGgoEXe
	qHcb/972psvwrdaEz6NTWddnF3ygg0bfGO3AEXIN4r8mGLQqWznNfI5Qiq4vHiM=
X-Google-Smtp-Source: AGHT+IH+MF6HMAlumoucfJgmT6Y1hg8bse6cOZfY4xpBVKLtIAbnvV6kQmywSZQ7rPfpLYzfDM9UIg==
X-Received: by 2002:a17:906:dac9:b0:a4d:ffda:be73 with SMTP id xi9-20020a170906dac900b00a4dffdabe73mr355431ejb.28.1711484670790;
        Tue, 26 Mar 2024 13:24:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:45 +0100
Subject: [PATCH 15/19] hwrng: nomadik: drop owner assignment
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-15-4517b091385b@linaro.org>
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
To: Russell King <linux@armlinux.org.uk>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-input@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=691;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kLMu95DaVyD3knCLGVkowZHpAylz58hzFrQ+URJH4DU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7YBe/M9Df6IUB55QNaFLqs4yC0bdwkUCg/5
 Jk7IlEkDvKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu2AAKCRDBN2bmhouD
 1wviD/459VuBb+pLzNupwEbp8Ij//1Y+Vs9Tou4sQQWi31pSfU/O68/wT5/dcaul7V2krx74O3I
 QXA9TAp2MScshnl7KPtr/+DqaB8/YCwTeJsUXCUrpw3rMldXYrN20WqH4OKsqMUV7Xbuf/PnQNO
 eoiPiRMsugqaTklPZrKxb/QMSgWs7G8gxZSWBNJoZxDS3/UicggJ+xxCKea4lenCf6Uk2jAQJVm
 11k7+/l1DjwA7p+LlX/wcc0GGclkinVoB0VCwg6kJe0aOxmo75YSXswBXARpIKS+4HQhjOw9ioM
 D1BzZMGN0yEx47DqH4MWncC/nO2W7s0gQArwR2UrKvEequzAgg80RCn2K0ErfAdWoAYeBi/I2+2
 M6elzx3MxUCPVyfmzk5Sr8f5ttLWw5FG6HfMXhJssTakm64iA+Ww9cWDiqXfwr3LbYMSEP68ku7
 Gr0bhl89HYqS0neDfUUDVgrkZbWEUffQLTc9xNv5OBE7ru9kBD35W2MxILrUx3ZWziAj7nawXuD
 5kkkpSN5Iyf27d2RKscMZdvLbu4k3CyNMiSE5oNpUYVnMB2mRl/Yzyed0mCmtHoKeRQPVvo6byA
 kjWxRB9EthpBvPLZB88ZgaWDaNWQDCGRzn2/gloP/oPmf55XX2Q6cDxOKp9E7jiu9R73vNmV7og
 gcdz3VNwvGxMJ0w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on first amba patch.
---
 drivers/char/hw_random/nomadik-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index a2009fc4ad3c..f2a2aa7a531c 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -78,7 +78,6 @@ MODULE_DEVICE_TABLE(amba, nmk_rng_ids);
 
 static struct amba_driver nmk_rng_driver = {
 	.drv = {
-		.owner = THIS_MODULE,
 		.name = "rng",
 		},
 	.probe = nmk_rng_probe,

-- 
2.34.1


