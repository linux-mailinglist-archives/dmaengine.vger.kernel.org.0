Return-Path: <dmaengine+bounces-1524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079388CE79
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC8B24D6A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6C13E3F9;
	Tue, 26 Mar 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/2rzaFz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFE13DDCD
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484656; cv=none; b=NdP3TZu8k5/oFTCwZ1bOrDhMGicOz37NdrcMKBx4JVl+4K4LcbKnw81ILsg/MvqVJkewqHrJKJl9RyUt1S2iQpPs7dSoNXrzh+31F6H/1FpTA26ldepaghUhWpLXy2o9ROFsAE6wo5yIvJNg4gExPSEyaQOMc4cEkGNd6rwdfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484656; c=relaxed/simple;
	bh=qJLPwum/AqfspnIzmOWzjV1qrgzPZNJu8uLTx/4rahU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3Joy7GtDAOfCkkM+Mezh9tbjdcYRNNrdlQHRw9ar2EG3/9q4Ut7umMVNwN6y1m4QypVK8Z65VveBkcQXZMIT+hXVa9DxSBg0Y6JRKKyLaFzKQ5iGQEoNU9zubWRV0oWAvP9JtXXhlkfZ312FCG8sVSZuBVukhkD9qCb3VHAFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/2rzaFz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c3260a714so803595a12.3
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484651; x=1712089451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8vNMvR/OqCzTXRIjmHHetW4mCviwFQpqMvTFrU4HAQ=;
        b=h/2rzaFz8etYmFuESE+xgJ7y8EAtjxXIdBlvXeq4T+krto9Y2POz+/k3mz5YWn38sm
         gIb8bcF1u1AvOtf5LG5kFJdWCbeldOYpa50m+/iZPT/3qwIpakGYk5qmyo8doIeDE/I7
         d81XAmjbXYbcLrgyvTB48fozu/b4hKN5xIRhB5huN1bmynbkJAOpNzCBKbJty5Ye4w48
         ztcabBJbPXiY1QyclVeiSyl6KmKlmsongCQcmFugSgZt2+tQEpYQ+7Hswnl7jai1Y0wT
         JC9X6vAQUTj5Kj6aaDwuSMxMMlaadal8XRkIv1xdt79GbCFm0UczDLR4KDmelFyQOj5z
         ACmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484651; x=1712089451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8vNMvR/OqCzTXRIjmHHetW4mCviwFQpqMvTFrU4HAQ=;
        b=YOWnUrJEPgALcAzQSWOfsEeQwHQikJJMPgDai38A8onm8lgCfZekfgb2/Mab1e4O4y
         M0YB73Si373jvRTrUvOrAeHmipkest0wK7kcN0dZauNLzAZMcxA9CFA83w/7OY/xBcir
         ddf/kiO5A8NsKryRO1Imoj7wIXxiDlr82D8WRoyoV1WwS4MrellKZ2I8PJUH4RM0l1op
         z+WzkTDHm3q3RGY5Lm/GgLzeu0oHi1dlbO0BapCXG8Y7BxCIGYK3uPJjbrcWXf2WcOYR
         2qKX/MbhXiBBseINGh1Q1yLL2pMMfOlEzzB7rsBwOkJcpmOgs3Z3Kyg0FR2ph6w+ieox
         QVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv1hT4UjCRF9D1yxLtUpYPU26HshmGWlBmoi+jOGk3OBD5Nzb4zoUGjDFSBIGE2i3JA9/zk5VP1I227CDYSKSGLfqvm8mzwa9P
X-Gm-Message-State: AOJu0YyKAbvcCge0tFVd6TVQtxT6EdKRvWdFOOXQN406nqpbqqgt6vja
	hDGgyF/abomAOzdH66z1GO3quLBZjVnY8V88lUlofbR4aTXlm1GfuelSZPyanBU=
X-Google-Smtp-Source: AGHT+IFb4JEt2HEwLreIO/b4GLNhMD6s6Nzsjk02Z8m3sgEQ5lUEmRg8HRX0TbD5U8VN/PyYeY8C4w==
X-Received: by 2002:a17:906:1713:b0:a47:3378:48f4 with SMTP id c19-20020a170906171300b00a47337848f4mr534451eje.35.1711484651709;
        Tue, 26 Mar 2024 13:24:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:36 +0100
Subject: [PATCH 06/19] coresight: funnel: drop owner assignment
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-6-4517b091385b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qJLPwum/AqfspnIzmOWzjV1qrgzPZNJu8uLTx/4rahU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7Qj2fX0r64FyoRM6EkM5j80xY3af0pmQvFg
 5BtZqFcjQmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu0AAKCRDBN2bmhouD
 1yzGD/4+JGxstrlsdoGYXZj4Ccq4FlQ4VMQFVLyDR7OuFttT2Y1L6Ak9C3zCZZH3Tb/bTppGteK
 ERowKV3waVO5ki0+f6G1rO3fqJn4srZhbqcx70gZurYIkOx8fX4j2qOJAOeYJtVm3ZiQTMsXQAv
 +cPaJulOwu1vBCC7/VjmfQz3ZWkQzHhV3gOQ/6RCjlmflitrfMC3T3v7bqUf2Jm/4MFTW+vYd6K
 dcOUoVmnwq0YDW+IECWoEawjWsU/IeJb64FZDnTF73pcwbZGi8QLGoC0WFO61LjqAXC0tNK1dUr
 hw/oFUL8O9uuhglMRm6kE0XdanRQUedGCFzK0ouqZZow4/x7EMa5C+X8JvVkrASkB2VfWVJmbOm
 DTIeVDfzcI6hr+ZZbAc1dvIqWf2TMTUKKGt4tPz/pOUwVg1KLi7nsDd+r5P6WZHlqvnhwpzusCQ
 CxPZrqUXumahYa5rssLLQWl8N2pE7qWBeFKJMpagZo409EEo5KuHWjU9j2p3378JVPiiInfmaxE
 JawL+ByFkETQw7RNwMOHJlUY6hQYCaGUmGzyx7FsIQR/86JIsrARRnq2M3qx+sKqHR+e6OFbpGx
 bwqotl6/tN4sf28DppeTKsvCy9FiaYdFjeGGb4FzBiW/sEXNLFoPXIGrmvztGjfYYVstUpVC4Sl
 9Wf5eZ2xqdbvs2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ef1a0abfee4e..5ab1f592917a 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -399,7 +399,6 @@ MODULE_DEVICE_TABLE(amba, dynamic_funnel_ids);
 static struct amba_driver dynamic_funnel_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-funnel",
-		.owner	= THIS_MODULE,
 		.pm	= &funnel_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},

-- 
2.34.1


