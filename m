Return-Path: <dmaengine+bounces-1536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EB88CECC
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BBB326AAB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC061428F5;
	Tue, 26 Mar 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5qpCE3z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D01422DC
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484681; cv=none; b=G2VyBmjKQifR9wTmzn+0h0DS7VBldt2xAgQopaz+vWINSSE8+gP/U1SPjJAgdv3h14k3itrVRkizHJrfPct6K0kNQtqf38Lg/iDAuFFNUe7rW09hoZ5QZEQ93ObV5PbjicyOjDgf+tGCyIXv6NIlNKrQqMIWKnH7G8lRxNkEs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484681; c=relaxed/simple;
	bh=INljxUCSw+yVREcFpthVyGE5rYMeWITztmBOHKglJhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAQ7QbwgXDfOmGtSRHKi30f5yCuvXg+aUP8atbr/DldtnT4zRz8TnpbrFjA5qpJy5QJTiYu09zUOeSGmzj0KWgaqEhv76pueXVAJ7Q5WE/AiiHJemmZIBCCw39tGr69aDzTzcU5ujSMIUwWnnrBjTyizbSwyHlTkC40VoqEKwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5qpCE3z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso315124166b.2
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484677; x=1712089477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwMQZ0nF23w//xAHnzD/oAWHiNTRM8AzxRIOUkQer54=;
        b=u5qpCE3zBOYX64htzdaWtvaQ+5lf9AFcQXwAiI/rrBpfSZVes5SEcs9ZZXegrbu1J0
         dDg3gb/HgXRipG/K68wZDvDux04Vqj/iybJ86c2BT+kbnCMFdHY8rtcGABZRTopmp2Ln
         8F+878m8MhgOAGxvASzfk4ZR6f4ukjImfiHeIv7Iz9siR9/XzBKtCsiewuUeFlJQBpxz
         w/rzslA6LmAtC1JC1YjmoMhEC56tgm46osnac3Bk+O8lrMjuCfamMuRn+aGERdt5wNrZ
         X1xHI3j7a4g7NA1lHNKbBNAyaKpKHAZm2iZJqKmk2E0oTeqxrlDS3xYto2NLYN7zBl+I
         b+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484677; x=1712089477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwMQZ0nF23w//xAHnzD/oAWHiNTRM8AzxRIOUkQer54=;
        b=WQ4KoIex+D+hfZ6Fp2cgsc7Q+RwlOU3bLUKFI3eeTEApUpkoxMh5qcF5s3lQsPuL++
         Rjej3G+nAMvRGFVXbWlRwlIT7HMBUfrZlFDLqo0dBef+mBZEDojXaxb+06iWIgP/63GH
         +b/kVU5QB9cxbHu+R4ev2JBJ8toIGsJQ7bD8d4sxhrHlY4r9/05T9vMbFpMWJLsBkTSI
         FNUW21UYnTaKOGPiyKiy4t9RJ1R9gtiYMQyOq9v6BjoTyiQh+le1Mjuu7mrUeUsUPlUK
         xA0IW73pfRdSCIVTMho4SVvkOGVag1Jye5WmLYMmrdZ5dPiLd88Mk1xCkgZxeZ6HRw/E
         midA==
X-Forwarded-Encrypted: i=1; AJvYcCWGa2aEHdmQ6RLkiRshyUCz4IxQE58laiZx/sb1QyBk81t4/SsgQ0q1Pr80SIhu4ybCPmpaONg55irjgmDpjwdvkpSjg9/RzXtK
X-Gm-Message-State: AOJu0Yy1eeMzFFwPiJzz2pbDCSi359qRLefxCZI7xruB0DYbv/J88x1B
	RgkBSaJV/lyW8EuahYvm2CHmC7IEUszngceZ5JG5OEChEGGu337KTU7EgtzNVfQ=
X-Google-Smtp-Source: AGHT+IFS7eYAhT+0AUpcj5ewpNo7OFKsTCoZ3JxCFeHwDILA0YZF9b4V+IaNGjXTAqigOEH5hMb4FA==
X-Received: by 2002:a17:907:a42:b0:a47:7795:db82 with SMTP id be2-20020a1709070a4200b00a477795db82mr7398894ejc.34.1711484676683;
        Tue, 26 Mar 2024 13:24:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:48 +0100
Subject: [PATCH 18/19] memory: pl353-smc: drop owner assignment
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-18-4517b091385b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=711;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=INljxUCSw+yVREcFpthVyGE5rYMeWITztmBOHKglJhs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7bfvePYsjxBuLD9vY3zAenH82u7tT/SAlQL
 Z3EnQYXLHCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu2wAKCRDBN2bmhouD
 11byD/wPpXiOrbOF/vSfkJBrTVrF0LZH7r75M7Vz/+aPxzvKY8FKsSOw2SmV92MkLf4QuOdFOdd
 IMhZX1fpOObZ/FD21xlOjv+QFmb7DExusNcalkxdRxZKYEpCCvzYR0byulPTkfd/PDoCr4R5RF3
 bWRSvd16bNGp3ourlRN+o1Cki1isMO2ab6YQUCXal2ZYM3uWqp8uFBEAtGq0i4KErceJYGTDk0K
 yU+bGCWdUCDmVBIXQktl1gdxTJJeIshTNLGc0VbYhdQ5/144yeDXYpj9JxZj+kEd0MhBSgeyL+y
 qnx8vkit6hx7qw7DwYQbpqqsjvf89L401ck2ZHokDx5WQF/O6gUuXqJj1lkj95RKuAUY9iMAgEK
 wpayvepNRgr3xnMEhn8g8/BQllMQBHmg04Men8h09jhg5TSmEJzO6lkQpzd4wAIpwYWe4pGd22q
 QUnRxrhNWRj/GsSaPG5T8QJsROjVv+a/6Qt+0+KRsJCWt/uMricJD+r6L/VL2THandxryixg5yg
 qRL2e3R3i8BvYEj+k76Goc5dxAzDMCylHnG0Ksya2oTV74WPS8ZCSvY1wLAhBD/F0pL6M0MRWTg
 hAo/aTuE/uXOEvWCV88JCz9nnTmGnOYhJmVG2P0xSnLg2K7iNg0jYh1qiVA2Scb5rSklBBc3z7Q
 6WZIljKIBnSxNMg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

As memory controllers maintainer: this has my Ack. :)

Depends on first amba patch.
---
 drivers/memory/pl353-smc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 48540817e046..56e51737c81f 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -154,7 +154,6 @@ MODULE_DEVICE_TABLE(amba, pl353_ids);
 
 static struct amba_driver pl353_smc_driver = {
 	.drv = {
-		.owner = THIS_MODULE,
 		.name = "pl353-smc",
 		.pm = &pl353_smc_dev_pm_ops,
 	},

-- 
2.34.1


