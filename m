Return-Path: <dmaengine+bounces-1519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE788CE56
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949541F81594
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC913D62D;
	Tue, 26 Mar 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5Rcpmjv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1F13D523
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484645; cv=none; b=N6XjZlRGII3amxbXZ+wIb4Apvop4feEEnq4dggBxm1ocEr6m5ITmp+zadlDV0Rq/RruUzfHPVyhBPXhDOkbg6jaudBxrugNneUStj6StsSqCz0S4aJT48nJGeFOO2K/oY9EiqMD+UVyN7LpExPzyTY1OmxLLv3UJU2HJbXzrWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484645; c=relaxed/simple;
	bh=Z0l0OnzgFtpbmIReqfYeehApq3f4h0o4aClKc0Rot+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dr0zDAIuJX8junfjuylJzXLriiO80JQG760f/5g6fkkCTD7rYThsy8b8lUMSJZEQ0yFHdEmSmE1VXgThw9MBAWzKYfoQP1qpRQahXmWvkMr2hQQJDmiJ6ak8iNpW8V2i/A6szX3fQr/KtXGWres2wSecg10zIXJCIRJJ0TD1KvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5Rcpmjv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so7618574a12.2
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484641; x=1712089441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzOtSbwk5HJ+2n5ZSOsaMRKkDMm+dhZPpBfR72UdRjo=;
        b=n5RcpmjvphjIPg6P/hGqW9RuG3knFbd36OMsOdYfmOogUDDPCn+YRJx6MFBaTZE8j9
         PAg5io4p+bAD4RbdVSWfeEBpuyFnhpdJkvlqxacqQfB65MFPweDlBfYYu/Br9NfvZWtR
         Cibw+oFiUmp6dPBxWohAJZjnk6ua/YmGJ4b45PyVNz/r5hIkUsWGS+EY6SliGwDHfvNW
         KgM1gNMjoWpnosGkZMNU3DTR/nfVOULYmv474PRzg6o/MOFoX/hExEd634S0KmI1cXyz
         ToW1eLk/Swu3/rWYb7QGi9U487HOEvHygzeUD1aDmlVEAH7rXEjYhvOFBWfplUg+1KRY
         4E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484641; x=1712089441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzOtSbwk5HJ+2n5ZSOsaMRKkDMm+dhZPpBfR72UdRjo=;
        b=V7qwveitJgsFWeT13fWKyFqIfix65Is6T4tH6WMgPWUd2bZdLHlSu3DMLjuj25TPMn
         xxbd48NBL4MkjcYOkvqyKmV/XM22+T5gm6jTKX/WfN8G0lFDsN74cRRuujan/TvPWHfG
         Pb+rhTv2nV+idsv1JxHRu/yeeUYfuBYyWsLJMovGRQrcsvYNu8p9q9vjp49LNGAJPjMM
         Izag0r07iaRQax3hwCh51rt1FpJmiPK5ZDvCPjsa0qw6ZtdIO0cqkplLSctbLIoIv5tp
         osETnOmlekccx8sByqzdTQzqrSHoFY6wA8WkcphcLD1rS8jLTLoVe4bhNBWHvkt1txlR
         vd3w==
X-Forwarded-Encrypted: i=1; AJvYcCXcw+oUlsI6d2sQJB8imLKzCzcGLruuBrcwVQ+WowxFF9AHcEacBANaJogQMlSjrHHdDjkKx6VMRBVCdOp3fkmHv3ohHZ4f9s16
X-Gm-Message-State: AOJu0Yzbm6K/zZo7TxS+TegHs8GRmB/6l61voVLSA5roQxlfKhYTCLtM
	D2P8EWBPLlL2ttX4uei6fpXICQFcb/PX9KypfRXTYoPISkEO/M3rmzXSw3Z058A=
X-Google-Smtp-Source: AGHT+IHfUSgEMWZC88gEg7F4GxZ/oDXrRdeKiGsGX2j66fElfR1zUubE+AJU7degaWuoIw5rscdz0Q==
X-Received: by 2002:a17:907:9958:b0:a46:7794:2c00 with SMTP id kl24-20020a170907995800b00a4677942c00mr7550207ejc.40.1711484641253;
        Tue, 26 Mar 2024 13:24:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:31 +0100
Subject: [PATCH 01/19] amba: store owner from modules with
 amba_driver_register()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-1-4517b091385b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2900;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Z0l0OnzgFtpbmIReqfYeehApq3f4h0o4aClKc0Rot+0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7MRPDu5a+3xwWGiZHE1/r7AY6a/x3KWTzHp
 77I8uZh33qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMuzAAKCRDBN2bmhouD
 1yOyEACSnqUPFtIIdUyjMgTJS4Qmh0Be5ij4MNrmGJi0DcwMoT/FYoqXDwowpxlx8KaNnjkytMS
 g87s0XhMJrEHtMgWgKsIHNH4CR36WyN/wPZWxgZBQUNFMGEWA4SRWXI6ciqjqFDdtyOcOiiNDOB
 fjlML1z9zLk3ZgS69LBDozVDoKYqATgEivZnXVpH+fYyZH+dwGJ+wIWFDHNlD+D5ESopGYbvVrI
 acagfRKmUyn32IZtpsKAzxWP0N0jyuxvy3o/gzmIJODgXUbai5pWZ9SvmdjW6mwJQhZNLP0wEAl
 FeGgVZHmuZxZx7b50T5L9HutnGId15TIfFk2kigt9tvxzJbK9faRqNrd3xPSO1StxHVdgGUJdhH
 7qBOhl3cKy8P6d8w/bhMwsG2qPnSlPtB5xqq1/bP2I/XoYMc/on3ySbT/UAXPZoN3sy7RHJf4Dw
 uDA4cdhkQv/dmkCXI5FKEnH9QGC67ZRvyiDn5rMeab2wksV+iRV6DQFivjvzwDjyaLWH5tj9mGI
 bYUhU4iOTf16YgQ+zkq2tJPAugQ4AnoGofp7J62i2Ixb7zMMsLRSul6x9/MJ72BHumZ2WNFG/yR
 1b32qFSAKFBJxacXSMluhq8gmBg0FrD5qiNxFc1KPUJsvZxf8X0Yd72wwm0dvcV2BerN8HUJRxj
 PN3v05nOHA22Kyg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with amba_driver_register() often forget to
set .owner field.  The field is used by some of other kernel parts for
reference counting (try_module_get()), so it is expected that drivers
will set it.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/amba/bus.c       | 11 +++++++----
 include/linux/amba/bus.h | 11 +++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index a24c152bfaac..aba3aa95b224 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -488,28 +488,31 @@ static int __init amba_stub_drv_init(void)
 	 * waiting on amba_match(). So, register a stub driver to make sure
 	 * amba_match() is called even if no amba driver has been registered.
 	 */
-	return amba_driver_register(&amba_proxy_drv);
+	return __amba_driver_register(&amba_proxy_drv, NULL);
 }
 late_initcall_sync(amba_stub_drv_init);
 
 /**
- *	amba_driver_register - register an AMBA device driver
+ *	__amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure
+ *	@owner: owning module/driver
  *
  *	Register an AMBA device driver with the Linux device model
  *	core.  If devices pre-exist, the drivers probe function will
  *	be called.
  */
-int amba_driver_register(struct amba_driver *drv)
+int __amba_driver_register(struct amba_driver *drv,
+			   struct module *owner)
 {
 	if (!drv->probe)
 		return -EINVAL;
 
+	drv->drv.owner = owner;
 	drv->drv.bus = &amba_bustype;
 
 	return driver_register(&drv->drv);
 }
-EXPORT_SYMBOL(amba_driver_register);
+EXPORT_SYMBOL(__amba_driver_register);
 
 /**
  *	amba_driver_unregister - remove an AMBA device driver
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index c60a6a14638c..958a55bcc708 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -112,11 +112,18 @@ extern struct bus_type amba_bustype;
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
 #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
 
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define amba_driver_register(drv) \
+	__amba_driver_register(drv, THIS_MODULE)
+
 #ifdef CONFIG_ARM_AMBA
-int amba_driver_register(struct amba_driver *);
+int __amba_driver_register(struct amba_driver *, struct module *);
 void amba_driver_unregister(struct amba_driver *);
 #else
-static inline int amba_driver_register(struct amba_driver *drv)
+static inline int __amba_driver_register(struct amba_driver *drv,
+					 struct module *owner)
 {
 	return -EINVAL;
 }

-- 
2.34.1


