Return-Path: <dmaengine+bounces-3802-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C631D9DA3D4
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B8B21317
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC071494C2;
	Wed, 27 Nov 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux0J972R"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08A29CF2
	for <dmaengine@vger.kernel.org>; Wed, 27 Nov 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695850; cv=none; b=T5eBJTb2N2QTievCxuIqWLurieFSh4/MKgzbp4WgO96srfUgZ+j+4MMsG1p1MbaITKO8pnrky+jUE9p50ho6hK8qtslyc2wlPLMqjBP6D6qIMwWICKUIFDbwhRFvZyh69svaOWb+TkOmSJ3Amrt/c2zs5P94pRrhrGOaoBvtmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695850; c=relaxed/simple;
	bh=D2zCNvv6RwYiCqPdzLthSS1rvZf7x6Pd4PMS/3lR1SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mGcIUee26pJSZXrSZwjvZ/eWuCswDJ4y9eqquPPjrLMenV692n/L045XUAJXEvP99KC9Marn0mykN33dUDPQ0Y0dqeRXusvQTtetfnjC5ziDu7l7og+sDhtOr/CAR2BMl5rYesgN3VdlrM38bfBbKmLHq1xNaQ12irYAgtHg7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux0J972R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732695847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DLdQSuBYZn4bZL0sD7tkxRgW+8xJC7aPjWdDJFdluR8=;
	b=Ux0J972RTlud/oF1bZN6uo0XVPe3yA/zuwCVgFABRyi7C6/T0RJFETeG06dVGfeB5lys+9
	fC3s+w0QvfYtM0HBtpzK2svySYPKSjg/x0jkAHEgSl3p01+M865V5OsVOfzXJ1+1vxDZDT
	PQm4tVHNH1yjoVgLQiVsOcoRPFsWNzQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-53Gv5x88MPu2o2SztX1QfQ-1; Wed, 27 Nov 2024 03:24:06 -0500
X-MC-Unique: 53Gv5x88MPu2o2SztX1QfQ-1
X-Mimecast-MFC-AGG-ID: 53Gv5x88MPu2o2SztX1QfQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38233403611so216301f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 27 Nov 2024 00:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732695845; x=1733300645;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLdQSuBYZn4bZL0sD7tkxRgW+8xJC7aPjWdDJFdluR8=;
        b=xLFzj9p/wDFhKsOOfKNgd+WKmyXxCXAd8AmV/8nv7pvYHmF+ghDqj9yIQYYp83MU/C
         3nN1bVSEKpP+88qRQ5sCKn394eOYNFBDyzzcwRzyOSP6e88q8T0G0H6jPhBiv+mpxRvg
         DVaSVJ6e800gyW7LC0jN3YYYnUpJpeTYVXo/3E30yr/9dleY1HQlGY3aRG/hbAvTpHVn
         S3l5hN6X41hcomk74rY9Rf2kTDULP5XgN7HLaqgDu8x55kP0yNUnQQWdRSyyGh4dJl7G
         EuO6NnvsYWj1jCxNIBj8XONUICkkJR723wGPBVmUk7mquzBlmK/pgyEYhGuynyFrJ03y
         abFg==
X-Gm-Message-State: AOJu0YyM+NRHs1cVobn+ok/6296z66//c03nadpKA0onLAKKZl58/vuW
	IwW79XUVlB8UWFlhWMDWQqBHgFFgIjarJmZ5ZxZn7CnUePE+jmKoDXBB67OqUad7eVLHPAkEnBA
	hK+N9zAjU5rTBrc8DNR4bFYXaXnZKFOrflaKQ4r6k4Rc6bbSbMTr7nLJPxg==
X-Gm-Gg: ASbGncvGC9XqWm8r32mBvXeb0nhB5BVk+SKAgbA2BwrivkVXsEpOZ7LSQEtdxiTcT3L
	kVhtSIpzI3i4j8BBpqQnBwQEth6EhM/O++v/bCZGaKYlppjFiFmArIb2RUsmK1bHoH3kwAfrlDD
	SvM331RxGcrPcTCy3/eVYjbwpU/oXrV3QGBAgfJGyZ8oE06XmIMtWpHC8JjNZzQwYXYdckpsAWH
	EL2wcIKhNRB1R4Ceb9qndC9TpnokVVyJhffGpS2b00xy4CUjq6lExJX2eS3yUYW43PaiM0pnW0a
	4jjo+SL/qOx+yEMDUVc=
X-Received: by 2002:a05:600c:1d1e:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-434a9e1ce8emr6680165e9.8.1732695845283;
        Wed, 27 Nov 2024 00:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7GbyJq6Op0/kUh8of8dCHY9qLEVFtAu4wzuAcMAOzg4JRz58ZFg7QoPddZ13kWOBq1Symeg==
X-Received: by 2002:a05:600c:1d1e:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-434a9e1ce8emr6680045e9.8.1732695844985;
        Wed, 27 Nov 2024 00:24:04 -0800 (PST)
Received: from [192.168.1.51] (200.red-83-45-89.dynamicip.rima-tde.net. [83.45.89.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78007dsm13105145e9.19.2024.11.27.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:24:04 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 27 Nov 2024 09:23:51 +0100
Subject: [PATCH] dmaengine: dma_request_chan_by_mask() defer probing
 unconditionally
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
X-B4-Tracking: v=1; b=H4sIABbXRmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNz3ZTUtNQi3ZTcRN2i1MLS1OISXZA6XZM0I7NkM6NkCzNLQyWg5oK
 i1LTMCrDB0bG1tQDXiOkqaAAAAA==
X-Change-ID: 20241127-defer-dma-request-chan-4f26c62c8691
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, vigneshr@ti.com, 
 nm@ti.com, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732695844; l=1509;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=D2zCNvv6RwYiCqPdzLthSS1rvZf7x6Pd4PMS/3lR1SA=;
 b=d6wKUqj3cMQazozorTN/arh1KBjFhAOsX/bo5B/+yX16/O3xEFZDPS9LxlOHt5vht7alVetvp
 xFILBftgKA+CalsReYgGnL7FBDHKW0w9RGtqrFjTXoQ/tTKeMyzrop2
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

Having no DMA devices registered is not a guarantee that the device
doesn't exist, it could be that is not registered yet, so return
EPROBE_DEFER unconditionally so the caller can wait for the required
DMA device registered.

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
This patch fixes the following error on TI AM69-SK

[    2.854501] cadence-qspi 47040000.spi: error -ENODEV: No Rx DMA available

The DMA device is probed after cadence-qspi driver, so deferring it
solves the problem.
---
 drivers/dma/dmaengine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6ca7899c4d68a039567e73b0f089d..57f07b477a5d9ad8f2656584b8c0d6dffb2ab469 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -889,10 +889,10 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 	chan = __dma_request_channel(mask, NULL, NULL, NULL);
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
-		if (list_empty(&dma_device_list))
-			chan = ERR_PTR(-EPROBE_DEFER);
-		else
-			chan = ERR_PTR(-ENODEV);
+		/* If the required DMA device is not registered yet,
+		 * return EPROBE_DEFER
+		 */
+		chan = ERR_PTR(-EPROBE_DEFER);
 		mutex_unlock(&dma_list_mutex);
 	}
 

---
base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
change-id: 20241127-defer-dma-request-chan-4f26c62c8691

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>


