Return-Path: <dmaengine+bounces-4506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51314A377DF
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 22:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748BC3AD4A1
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3001531E9;
	Sun, 16 Feb 2025 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6mJrIko"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F663CB;
	Sun, 16 Feb 2025 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742475; cv=none; b=fzEG6AEfuPUYGagypGVbTBUz3I8kuQr3g51CXs9mTdeRy/qGYmJFF2ftHaOsXKPUYQsf1Gfqk7v22AAlwN6/PQxsXR6CI75f8gHB2uGquEIrrpq3eIEC06QdFmKfM30555jdCjI2nfcsTciusSGW7lbQgCzqHBLSvinT3Gp3GLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742475; c=relaxed/simple;
	bh=u2WYpcM9BCJXjNp3SKVCCE5A3rCfkJz6U1IXN4Kvj+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YslgLnWgbK0AcG77n0AM2J6d42PMS28shjBEUA0rGMSu+s3UxqPtJYfnW6LZ32M707YG3LM9+SALeoCYOM7Kwv0eysL0obv3mVzZUS+39G7Ev3nbWVtVvggy4c8sqfUF1jjkCMyoocu0yzRGWxTSXY/ec8pdninwq29veH+CqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6mJrIko; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb4c542b18so625857b3.3;
        Sun, 16 Feb 2025 13:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739742473; x=1740347273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p783hvIVw/o5boJwSSZRc/hbn6fHiwwp6qm/7jRcEsY=;
        b=W6mJrIkobCC1GHRjZH2DWMw+E48xpcQ+fxMiJe8kx3sGNIouEGqvnU7V90d0RUhoLe
         LOAUsZJxAERs9oGFFTi2o07HRD4PyH9iG0/gsC4Z2WWeXvb9xznVzWRd2Fd80KmtyIBZ
         ksvHESyAoe5pCXU1OOG4gsa9yDco+S6H2noC0/ycs9ATaePWRO+SBwVV25xZDH/MiBiJ
         kvKnPMTAciHKTRKxjbsjwgpsgxgrc6gT/qUdnWYddnKfWeF1MofcocbI9uYrgsOXER3K
         cAx84msz+dqvwIHfSgEzY7JuNlMDJm3ot1yQt7kcF6SN7JS3ossH5rXHle0Pog3VRfvC
         d5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742473; x=1740347273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p783hvIVw/o5boJwSSZRc/hbn6fHiwwp6qm/7jRcEsY=;
        b=MNUjd7oX4vy1Hg1a01sT2wQWyY6dDqGLAu/7Lv+E0rryT27/m3JkQWIeukhP/I4gvV
         y5/ZkxM0m/G6+vTPscblX/tmi9+f/RWlPPPSFld+WtqMJ1v1S5KWWDV6soBQx75Qrap8
         bzgyPhTV/gAO7eLSaTUD0QBJSM0ULsb33m1SvYapEk0koLNvK4JrrHhx+fV/mkHUINv+
         rkhBQ5GPCQ1RYVaFB2GZgXpe+z5YL4LTKu/vvi1bGFShBfka9HT0hDWyTy3Mb+1+GV7m
         Y6d5RSQ+4r7UQay3BQTzZgUyAK3bHD5M0OEiff3xxYYGEIGsHXWHRBNnOImUqya1lFKC
         qBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCN/OUvXVAZ+afmMe6fQUNmz7vwfYQng9mncWdtXj1vlnF0IFv9CiOm0rgds3mvvxlgjqg27sUsoFu0iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHA1kB7XdQEmFpizyJqgVZvQTmvrVNHK5e/UqlM6xT311VoqT
	Ath8MGaq5I4Y6be7juBmCToXPwoNMtB9+6miUNC3VecQ7TyFXj2saBI0RQ==
X-Gm-Gg: ASbGnctn7mIXV1sR/GGRGxYfPcJnO1sxaERBYpW9FQwGKlWJOl/0BoJvhv1YovZ6bAt
	sptQzOg8XbhS9X/mlFN/Iqyj+atKkUyh5AgSEz8xzFq9v1FEnpFzhSJxHvYIvUTbB/K8xeWGa6P
	mDjPupGdN5RwMwTtlJW4+BVFL6vucyrZC9jTl1HOulGMpC0o7UXFV6nfK02qO4jYUr1tes8gq9J
	MhLDCIWDzq8vSTw+s0gJdEFyHcER+ZT1oQmlTv9ApoW3h1M11z6R4UWkwIqXnk+QRRJlAmcgfza
	AwC6SbX4CQ8UMRf/t9MUCnmdmZiQDzwDaSCJkMDrRe8qRnCIvjJIMOCglw==
X-Google-Smtp-Source: AGHT+IHqCRH/qZ7fEsooLcY+t2IN8eltukx9jZefMzzahIoIKa6mv+hKDlXnYJDUjUEBYhcdy95tAQ==
X-Received: by 2002:a05:690c:6012:b0:6f5:be28:632c with SMTP id 00721157ae682-6fb5826a563mr25830567b3.2.1739742473159;
        Sun, 16 Feb 2025 13:47:53 -0800 (PST)
Received: from matt-Z87X-UD4H.mynetworksettings.com ([2600:1002:a012:af06:21fc:84d0:18f3:93d5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360acfd7sm17913367b3.65.2025.02.16.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 13:47:51 -0800 (PST)
From: Matthew Majewski <mattwmajewski@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Majewski <mattwmajewski@gmail.com>
Subject: [PATCH] dmaengine: ti: edma: support sw triggered chans in of_edma_xlate()
Date: Sun, 16 Feb 2025 16:47:41 -0500
Message-Id: <20250216214741.207538-1-mattwmajewski@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .of_edma_xlate() function always sets the hw_triggered flag to
true. This causes sw triggered channels consumed via the device-tree
to not function properly, as the driver incorrectly assumes they are
hw triggered. Modify the xlate() function to correctly set the
hw_triggered flag to false for channels reserved for memcpy
operation (ie, sw triggered).

Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
---
 drivers/dma/ti/edma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 4ece125b2ae7..0554a18d84ba 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2258,8 +2258,12 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
 
 	return NULL;
 out:
-	/* The channel is going to be used as HW synchronized */
-	echan->hw_triggered = true;
+	/*
+	 * The channel is going to be HW synchronized, unless it was
+	 * reserved as a memcpy channel
+	 */
+	echan->hw_triggered =
+		!edma_is_memcpy_channel(i, ecc->info->memcpy_channels);
 	return dma_get_slave_channel(chan);
 }
 #else
-- 
2.25.1


