Return-Path: <dmaengine+bounces-7370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606EC91DAC
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F93F4E5E07
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A293112D5;
	Fri, 28 Nov 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K/eqeP6R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD73101C6
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330264; cv=none; b=rja2S0dsVLPtA1f819DqonKZn1POaHN95KRSWK0OPBcTwemXsKmE6hCvy+22yI+Xi9RQPJjgDbtW+8Gulh+lqUcpCrrIn0f0uAD1/11USuPNTmYf9wb03VNr8cpxtJ+bgZMpplGZCANS7z2ETWkdsKyqsGVREiRJZV/UuU78mCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330264; c=relaxed/simple;
	bh=gP3sHPK8gXmSIAYj8c0TSwKZzT5w2oMcR+vB+mLVnSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAwhUisue0gkS7SzKF/iWS96w4fJMXlarH7Fg8bVWi8vnKgtR2yshmGhj+CQDEH38js5b1KyhIIfjIuca3EfIdWxPfoTG4a2O1BX684FcHLfGBsxLrb+/tEpKb/RpUjXDsYiY3uamsS9L/ri09Apr5UkPmnfrTyRmJMoUt/5cS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K/eqeP6R; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47774d3536dso14474375e9.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764330260; x=1764935060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHD4rZPwi7RiLdWPbbS8FZM0CItCJ2sdBfbEOh+hWEI=;
        b=K/eqeP6RUZpyLY4r8CzO1H19dlzZgMz8va+OUPO+E80Isu9FuoJFmxegIB4PD4DcTH
         dFe2Eo4GxAFG04jqdZQDSeIi9xBNQclZNFoAh8m5eu0tg6OxiMyGhLRJRSA9YyJM3lFp
         vg08GdXqBEyafj5QyCG8xztCTH3OShvv5wq19Le5r35BpUECcy6eTF9ktt8RCfq7qgJd
         2myci7CiLtlnyqX2UToxd+VcpHBN7a1g5dFM8JftDW2oriqbghZg2fRxDvl8VppEngYQ
         B7p1t5lxS0lOtSh5TnViRSkhAOVbRfMB5QRJhhdT+KPdbwkVEVpGklf4nBIid6Wl+UH2
         6BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330260; x=1764935060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHD4rZPwi7RiLdWPbbS8FZM0CItCJ2sdBfbEOh+hWEI=;
        b=AxphHFMKgebhWcvzSbjLficWqZ14+M+KvytfIbYcWKHadHE/qWlOUgNai5QoA4Wm3M
         EyMY5QCcCoE91kk8w2Wqj8Zoe6AerJZyF8UNaIYR5pUfu/W8RZ1+fr4BjulrWbdU0C11
         gdD9uNfBUh+23YHoH6gRUosNswWmaWYJjJA35WrlSXInF9Qvor8PFaV9MUeujKVL3slh
         vI8vGeHWzJwgUhgGIadZV1nZKvxy/LyRffDdekoMkBp4FOSzmFKC/L8ewo7T6dlUqN+9
         qjLQd3LYj3pJHFP62d20xmvhMHkkgKmCzdrwH21sKA8zthJzEBja7pG970TI7Zgh5xma
         gPAw==
X-Gm-Message-State: AOJu0YwJ3sNC0VGsr9EajmlI7YpXxFXGana9W8h2NewxMEVNutPvs2za
	Grfyu9Vp3GgpsGiYpUBuCWv6Ibj7ZeKq4gXfwEAX+o0b3pStBNwhyEHSzyDKq7IjKss=
X-Gm-Gg: ASbGncsQiaA2kG5f2wRrHta58L9+pmkf9iB770SEta5VIXwIUVp9otlwEbwzkuzVWUe
	xT2Ik867nTwQwgunB/HxTMJnEMMF6VVWvDvljetUY5zRnZemJERHe/I7KJH13TnAeYc9Z6QxiJL
	pNEYdaXJKDwbkxYhCrhbE1l1iCBpgw8qyFm+ppbD1FdhQh+SfSvN7c/XBQ7H6/a6DkP3yzIJ8Sv
	HxRa9e2XR2CD239uxeOEeXdEpXlQ++8LwHjMlQn65y2s0LWjAjmBgNPAQ33FxaqxxgfcxoSbtOW
	2motUge+9mUOqt34IYI9odp511TI7H0GMVUYvWYoguZW57zJ+uJqSqVRpur893/wKXpji9DeK7F
	gTEq7UmSASOecphWN6OU1pITg64BkM8oFT3BrsXsYJvGtKm/HLzn0RRDIYKyE0BWHncQifjr6J0
	UX2eRyDg==
X-Google-Smtp-Source: AGHT+IEZEY1h+B91Cn4WUb1EKEGKqMtgbbknbuwNDpzOB9tvypFejJKMiqNdltD5wwnmIJndrvc33A==
X-Received: by 2002:a05:600c:4eca:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-477c0540a68mr312273545e9.16.1764330259964;
        Fri, 28 Nov 2025 03:44:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm89888445e9.1.2025.11.28.03.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:44:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Nov 2025 12:44:03 +0100
Subject: [PATCH v9 05/11] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-qcom-qce-cmd-descr-v9-5-9a5f72b89722@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Udit Tiwari <quic_utiwari@quicinc.com>, 
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
 Md Sadre Alam <mdalam@qti.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=FPE7sVoSIw1wtmIdKZA+n/AK2oTfpfwCQfrZgNyVmEY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpKYsIseksosC13SJcrBsMoK/GzT9RjKMGRCE6m
 ROxqKj11UeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSmLCAAKCRAFnS7L/zaE
 w8cGD/9VTcW4bLk1by06eHZI/KaNzbm5zKGNUTn2ki3t86bbPtA68kg40hYqXLdv2C7QJUaKWLJ
 c7ZLSCvWSp2x2qDNwveLKOHSKZn71zgu5PiLf0+WL5e5K3BzqK5lrQqexgIe9o+SzV0Qr6vyZL8
 VBS+J4i9ookFkTLflRvBTEDcYsmqIU3rPb6h/3S/do2tct240HGf69aJkBrWb+hyb5j/k3KQ1EY
 VbryfbHdUBaMvULP1pj4kiwLhjo/NofBIoAj3PMN634Iz5Ubaz5o+wKvoBLt6vykch279HqKTb3
 cYNl6tncHpd6YeYI4kJARYuzj7dzzAZeqU8se68jPRe5UB+M4vbZ4qW5rfHVdb9B+kXlaG+YINm
 3C+eH7rKiFUZA93JNi1BpHFWf/dLkB1Bg74hjhL0xIGspU+ZZGb9VqvS7lkhOYt9noZ2fepxJci
 alzIFsYX4j/2V64D1O8YNq3cnA8s4k93PwiPn2+LPgzEPBbgePi8V2ks+2uvZPRbRv9rIcOAV9W
 vVwthqBN9s2IfwISUCJWx2Pb+krbaeI27BhQRjkmcuvHOMAs1bDApdEzY9tO7zAzSNNp+yoAxsf
 zMi0koQkGIU8u48FIjdeGYH7arHa2qf1nMYOIiYIp689RpRHxghf8TZ+l2nnhoVLXNei8rxOIoe
 JlJ3y2kTMNl9KDA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's unclear what the purpose of this field is. It has been here since
the initial commit but without any explanation. The driver works fine
without it. We still keep allocating more space in the result buffer, we
just don't need to store its address. While at it: move the
QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of this
compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/dma.c | 4 ++--
 drivers/crypto/qce/dma.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..08bf3e8ec12433c1a8ee17003f3487e41b7329e4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -41,8 +43,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 		goto error_nomem;
 	}
 
-	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
-
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e12242fa07c2cc08b95fcbd5d4b8c..fc337c435cd14917bdfb99febcf9119275afdeba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -23,7 +23,6 @@ struct qce_result_dump {
 	u32 status2;
 };
 
-#define QCE_IGNORE_BUF_SZ	(2 * QCE_BAM_BURST_SIZE)
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
@@ -31,7 +30,6 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
-	void *ignore_buf;
 };
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

-- 
2.51.0


