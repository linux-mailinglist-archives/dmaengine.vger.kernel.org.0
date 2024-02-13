Return-Path: <dmaengine+bounces-1007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEE853366
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2581F22986
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17F58103;
	Tue, 13 Feb 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bGiYtAd4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD157899;
	Tue, 13 Feb 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835361; cv=none; b=SwUmPLUz3omkb4z69qnEVCgJUtH4E+aMR2hUOVU3AFnu2bW+kSuvI+MIX03IrVyPPI3oBjBGunfH0DQ0Q8cjTrJEY/UMhKMymKeDbgLO/WzAgcWl6fqv7E5txFNmU9kn+E4E/Z6znu2h0Et/k2cX4LYEBliPXsrHoUm93Zre/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835361; c=relaxed/simple;
	bh=qx1rU47qp5SxtB5/of0+ajlZlnqS9KlZ7Xr19U+lVpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OOE+RS/ghZ/jUQcbp6ZYc4sV2W/7QtA0qimyxEAASEfd0jmsxC/uOFRl+06S+ekZenRRhdMTBvRkON7jI5Qd0DH3q0XPriEnanKwPdk3XiuqF3QBbonTDiPlFaygHJKOVV2MMnqtDfmwSJPEJoTxWO1tQQTLHGWDUApTNTKJWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bGiYtAd4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8da50bffaso18515855ad.2;
        Tue, 13 Feb 2024 06:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835359; x=1708440159;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxuGEKv2vwSIUHy4n7Mz5CLswGcccldauEpdNmNdUUM=;
        b=Ez+6t1FsSpZPW22LviNQTfgvzxuNDQl2qW8Zx3lSKqQv+sUJ6uAYgBQHJPMmD4XaE3
         W78gqTDSsmCo/1g4pkrnqu7pHxbjCEAntE0/GRJGUk0ecsv+qTwbJ62rp30UP3DBQHjZ
         VBfR5OwVTdTN1IRHyrFH/QLpNfLbqA0SqtU2pWOsqw2szDx3r170c30z2JShyB867oll
         jS56YnOIFdlhF2IRRxAOHv0mZMSGJY4hNvdnRYlpkbNGV9misvCeN/506+kczqvSO1O6
         9THgu3h+IxksID1yEMu0xnQbBEOqtkyyvi/WO01tsWE6tQ1KR0v0Z9k2AOCVK8SO5E59
         7l9A==
X-Gm-Message-State: AOJu0YxhE/SoCH1+eFdLZCGRaXIF3wc5buOI0rbJ/r6RqONd7Fn2Z6bK
	P4WEVWPyad+luKstZK+2H+m11LEfIFJCP0Js+DVyY2BmijKNJ8vD
X-Google-Smtp-Source: AGHT+IGdk73sv1uqFOWt/SjvaqGyOsWsH6lHsQtY1bs2jDjceO619LloI5Yr0wzSUTdu2O6UknX4+A==
X-Received: by 2002:a17:903:1ce:b0:1db:4b42:ce7f with SMTP id e14-20020a17090301ce00b001db4b42ce7fmr729213plh.8.1707835359251;
        Tue, 13 Feb 2024 06:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZVMIdUeSJ81vLJoYvAoVbenJwn0AjPQgwaGjaqYVnfrSUug6IVOTaF5+DYc74P6OL6K5LsZda1EVP7A3c0J6dWVz8n/nA4ZHzlRa50ZkmcNf5JPpPoBvdKku26pcq90MPuyPgNQI1LY73hkGjl+KKquGj4L2MhaYb6E9EM0zUh55Hij2ZGIM33FiUYsU3zI0=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kj12-20020a17090306cc00b001d9773a197esm2155334plb.209.2024.02.13.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:42:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QxuGEKv2vwSIUHy4n7Mz5CLswGcccldauEpdNmNdUUM=;
	b=bGiYtAd4le2yypgeqY4HcQa5cf+bUV5RX0nLBtwWAPVfQp640jI4835vi7GbeuxJb0ji6J
	cm5U5m8LG3TLW30czXlAPcJVCfIQ6CvdGYrfQXXYWm9qZIVB98qc9ez9qwk1tmniDFu1Ag
	vvkyuLeT6TLMzMwgY7eq2fxfda9h4y74FR7CYR9+FU4xd4k9W1JP4/QqTgLjhSDBPw9EqO
	4yHReqKb3z7LiDsDI6Wd2xOq7ag3Nq44/ktlGFvLkki0QXOMq3LSBwCbyPzqt6S8mbO9uo
	E4aD/eB2TmM0aKlqQrd9+9zAO1nkrPnD+1cjgg0Vj6ZXWoaDTFwslGyfMvWVJA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:43:15 -0300
Subject: [PATCH] dmaengine: idxd: make dsa_bus_type const
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAKAy2UC/x2MWwqAIBAAryL7naD2ILpKRJiutRAmiiFEd0/6H
 IaZBxJGwgQTeyDiTYkuX0E2DMyh/Y6cbGVQQnVCyZZvOa3mRO1zqKpYPjrUTmnXd4OEmoWIjsq
 /nJf3/QDBE4A3YgAAAA==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=qx1rU47qp5SxtB5/of0+ajlZlnqS9KlZ7Xr19U+lVpU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4ADS36vQF93+0pXIsVYMlI7hG/r7uf9ssBSw
 QiwAJrTz8uJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuAAwAKCRDJC4p8Y4ZY
 ptHdD/4n4SVsd1trzl4F4F2fAQKO4DWSVPw9jvc2Fc/CsncmwoT2vteYoMQGIT5T5rnZ0n4QO09
 hWoRXSBExqYpNshXECiUFSKWzc++9Dmkkv90mNqe7DCw1ozuazzvvHZaViTivA3wKG/dLAV7Eo0
 Om5SpAm6v2C3gUGspaiws/tfy+eZNXc6sg9E+fu7osyvXmJKU2NyEaEpy8vL9KyydTyx6qw/jPv
 5d1EUVd6slGHWD6AVmHc9+4zKqRVsHvfoUg88kEn+3S0jDhu/WNu9r0VGTAY58AJj3UOBoz4nJ2
 6m5y7QhZotnkKp+4vtjieAEb7BmEsBBgS/1ddfXVr6v1atXJOv/zkeeNWw63OAxCXzxAZgxvqaU
 XtgLstYwnybarNFxzqWzuTGpdLH/leonMc9c5cSrkcMmWkzlXXP5OO1jZfUpnomadjnrzelPwJC
 kMKELYHMtUhHRtaMX9sUXAWxdcmrElIHTEexzAGs2lnMd8fPxb21tHXQfaFrIPDMJbQXp5n5vj/
 kPi+JVP/pRaAXOg/wAQ9uOt8IGBWjaajUTQIbjBRbeBPpLS3Fzvap2Y9NV5OTi26M8XdDQfyveX
 no2UhrhJBRxnSdqTw+oTn4vUVZlogDqPXaxpy5wp1YsItP9kOrRI6eauFDfzcFon78Ht/74eto/
 6mJgZXjcbkHqPtw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the dsa_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dma/idxd/bus.c  | 2 +-
 drivers/dma/idxd/idxd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
index 0c9e689a2e77..b83b27e04f2a 100644
--- a/drivers/dma/idxd/bus.c
+++ b/drivers/dma/idxd/bus.c
@@ -72,7 +72,7 @@ static int idxd_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return add_uevent_var(env, "MODALIAS=" IDXD_DEVICES_MODALIAS_FMT, 0);
 }
 
-struct bus_type dsa_bus_type = {
+const struct bus_type dsa_bus_type = {
 	.name = "dsa",
 	.match = idxd_config_bus_match,
 	.probe = idxd_config_bus_probe,
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 47de3f93ff1e..f14a660a2a34 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -516,7 +516,7 @@ static inline void idxd_set_user_intr(struct idxd_device *idxd, bool enable)
 	iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 }
 
-extern struct bus_type dsa_bus_type;
+extern const struct bus_type dsa_bus_type;
 
 extern bool support_enqcmd;
 extern struct ida idxd_ida;

---
base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
change-id: 20240213-bus_cleanup-idxd-8feaf2af5461

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


