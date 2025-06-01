Return-Path: <dmaengine+bounces-5293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF55ACA0A8
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 00:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0173B29F9
	for <lists+dmaengine@lfdr.de>; Sun,  1 Jun 2025 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BF23BD1B;
	Sun,  1 Jun 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7asz3lM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C95674E;
	Sun,  1 Jun 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817782; cv=none; b=BNDrysYXep1gW1I8uWTTt+/28EEqbTwm49DZ+jEHVrJ7B9pX7l+wyTHaLZoRavTwXneqoIzZH/0jX9BOpVLrxhlFdJO/Qj7lU/DyhrxLEP4c13ew+OiFKfJl5Yppw3UydX3cbaGDa2wmYKukziaAxwXOhmK/ENFUmncwOxn00XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817782; c=relaxed/simple;
	bh=Qh+NNgy2Htt9SRQ9f/fplZWpWNIBbv9cYrP6I+711Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UofXSl1jZpRrr+ilwSkxQbwyUuhsFbTqdfi9Iy4cVnW0d01tWj3I4Ew6+gTML65HOZs/fvyACz5ITFf4sK4isswFkhsVR54OcvPKZGNEqBXQOw0C8c9gLrOPz4OZsUE/TU4OVVfBez9Cor4ALQ0yEzeEdq1bo806r1QcNAQPy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7asz3lM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so397349f8f.1;
        Sun, 01 Jun 2025 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748817779; x=1749422579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kWWXJ7FZ3GSQ1AVSLuDSr03mU7wdwc2Hu2NuHuHCJ0=;
        b=H7asz3lMqKXTk3of/ndMcZWJW7/a+dK3Z0XB4fKikLsIEZmsu1d+G69ikfn+xgSzNj
         3nzUMtsk2A7MNB4UKbN9843aoOwJxtxpST5WsdQasag5ycgTCs6Dpmk/hhshiE/gQyXQ
         ght7EgRsPuwp4rF334qWKcd11rVPMDlLQcG8r5nhufJhLITRSUBc1iMSLxBAmFAww89M
         h9HVbWZv8Z8Ie4RNw9A5XA7RWB1zF9DvLvvu9Q26tGWWhVJTOWHcI75vNuMHZrateXp+
         rOZIKc3OXjVzxb4eZ9APU9FSE98QnZp10XYs5OPOIe4HkLn6haCZC/pUimqdO9IkoCr5
         2oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748817779; x=1749422579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kWWXJ7FZ3GSQ1AVSLuDSr03mU7wdwc2Hu2NuHuHCJ0=;
        b=G+5fGmY/DvGTYBtMpukzmWsv9njIUSBJFBPC0+CY8RA/IkE+pVvwGeTEN+TAVuKIj1
         60Z95ggZrUJy0aklgcWnqASAfBWm5ZfzUIadoN2a2Fmb3OvLYefa7WLB7RrHW/Rt8EAN
         3vi4pFpWmfEED5mFrjDeeAFyld8AHI/OaPEzi75g5LUpQKF2RWqDYe2/Oh1c+CXs5oT5
         p4PZeKUXTr4//ezdAyAPVgKDr+vdugHVrleJaMyVIBeYcvQaTvkeEfw5R8edBpsyBGaI
         O35vkKybfcifO/JzayeoQvJA7eG8dgrFCfeQK3oCp5Ts7Oa3y2NkDYLZuaNLdmRi6m+y
         GhBA==
X-Forwarded-Encrypted: i=1; AJvYcCWdgyqO+JN8j0NdT59zVB5rD9IBAXLPPv9ZteCTaeZ+ZkuisJBSv+XDXSRkhzl7+FMmKdPEhJd0QWw=@vger.kernel.org, AJvYcCXKZgsCTBp+JMNT0gtLcfnAHMM8QjMMl25hy77qZrWGqAsuuj4eTp4U9qt+B6kWHPOeTJ3LtQzNYE6ED0Ojow==@vger.kernel.org, AJvYcCXPuy8g+v0ThPmqJV+/9rhb1l2Ho9HYBAxVCDKxcXrDCMXz54Ad0g6d716hJFfjKVfa8P4WDkoAOMEB7/Gm@vger.kernel.org, AJvYcCXlq0fyJm5noHt+Tx2Ab6GWc33oT0YToZtvbCmSpQR87WC4Y9dVfeGjFGQmDLce2v1GF0IGaPWk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VW4zgu9EUVtZ+AbXjikfFotjNUsGGNWstjAGs6bJhO5LmUDT
	lDoPK6AXX7dFVF10WiQFOj2iZ3iJB42lyhy9GHHOMMZfws0U91dmDl0/OwwY5Q==
X-Gm-Gg: ASbGncuMWsGbXoZ8VJRpBj4cglIFuP0uYCnNZcMRJ2Zf38MK6qsueNvFJ5uNGmV87ZS
	mwM08DIZJ3/U58FY9zUIfS5Ji9O5EymFVafLcR+D/LY3YKS3oUnk8Fo2LfJ1mvP3/QgdSEkHx5D
	bew0PCCAvhzmDln1pqrn3hNYQmWAwq4APS2h5GDGDz99Ss1lY2vr5WqPLId27Ony61jS9As7GdT
	blAxcSkUQl3VSvIJQgR1jzOPMYzXUqR+W74Zp5I7eIR1JwjGUXlfaiFkxminzuK5/OFNoTwV0TM
	/aeWuQX8xeYY9XgxA/4zVGuRLb+TKpyoUobxqqdeRGPqWx32Nr+pHDYuMLxQfcQ=
X-Google-Smtp-Source: AGHT+IFVzpxyXLCtBRbAQTyeYAjleNHnDwVMGvtUL11IWaYeITMphSowW190mBTSVIH8CGVCZ/soCg==
X-Received: by 2002:a05:6000:220b:b0:3a4:d53d:be23 with SMTP id ffacd0b85a97d-3a4f7a816edmr8112878f8f.30.1748817778595;
        Sun, 01 Jun 2025 15:42:58 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:4518:757b:6751:290f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm12916554f8f.53.2025.06.01.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 15:42:57 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: Sinan Kaya <okaya@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: qcom_hidma: fix handoff FIFO memory leak on driver removal
Date: Sun,  1 Jun 2025 23:42:31 +0100
Message-Id: <20250601224231.24317-3-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601224231.24317-1-qasdev00@gmail.com>
References: <20250601224231.24317-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidma_ll_init() allocates a handoff FIFO, but the matching 
hidma_ll_uninit() function (which is invoked in remove()) 
never releases it, leaking memory.

To fix this call kfifo_free in hidma_ll_uninit().

Fixes: d1615ca2e085 ("dmaengine: qcom_hidma: implement lower level hardware interface")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

---
 drivers/dma/qcom/hidma_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index fee448499777..0c2bae46746c 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -816,6 +816,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
 
 	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
 	tasklet_kill(&lldev->task);
+	kfifo_free(&lldev->handoff_fifo);
 	memset(lldev->trepool, 0, required_bytes);
 	lldev->trepool = NULL;
 	atomic_set(&lldev->pending_tre_count, 0);
-- 
2.39.5


