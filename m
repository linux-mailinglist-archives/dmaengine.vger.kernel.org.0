Return-Path: <dmaengine+bounces-4924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EDBA94A16
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2EA16F57E
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64E12B63;
	Mon, 21 Apr 2025 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVQfjsaz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E694400;
	Mon, 21 Apr 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745197333; cv=none; b=kaeKKHKfWX33PQVm234xk9c+e+DTsbZRA+Raa4QlNVIDRdkKNgbRDr1BkJtCAu4udpvehd7LZ7qwhCu6HB+6zRVrAd0JUebOmcBr+9M/QT4Dc7wCOD3H8TMspqyxX/nP5P/TmTSTJm/NtyCwoCnSpc4bf0vsNW2cdH2tzeCwccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745197333; c=relaxed/simple;
	bh=+8krUSN/aTblTRTse2hskxk9rA9iZ5WkgdyBagYVGFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPHJLFqonSqD0MAuF9vl8b6Q6VIg0wM6CBlLFrpV38SuwPWv34mMpCuuFONuOxtz6JZC/e0LFW+RFih3mpzmhj8EHniTOqYawJyzLZmyuroz/G9ccy60zJWBIPJ6R8OleH5LjuSZrBgLVzaqbnyUrzrgXt8cRmeTMzy1WufXWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVQfjsaz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e589c258663so2779638276.1;
        Sun, 20 Apr 2025 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745197330; x=1745802130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFghJE0Wf69fQgKSMTxJiuzgx0DLEfewWc1jQGsTHzE=;
        b=nVQfjsazOVQX1SD9voQu/Jgn1O893H1VPxDuXlpaoxTOjomlzNtQdFcpdWR+NsJNuP
         pRi+l40JOruvQQ/+y5rpPDeI8V21wGdp7xkOf5+Vtnxfudwnl1b9vhowu0gj+AFRqzQs
         k/rpiUP7kesfLDyhGtGJctqWx9XvT+go7smnMh/82waXewi00v+cvy1AVGh6TMauz5Qu
         gqp6TyTBhYwjew7s3O0ZnBBwqpwohFv1/APOQ7zMObFGMCVBAtRm4PDJQ0gp7dHiuT/d
         0u4K53VMGcw1PA1Z3VMcxelLn0dmlVk4TKMLBn0AuBah8Vru79IKMShuRulut19Ow68l
         y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745197330; x=1745802130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFghJE0Wf69fQgKSMTxJiuzgx0DLEfewWc1jQGsTHzE=;
        b=ZrBjLFl1qWlMdJ6SPR/TUuePzUr9p7UyJob/HITuN+vAFw7omeW/gbg67hEnLCTxGk
         xrtGQ/bIEqkbVvaX6rfZThhxqtnq5GjroHz5DGi1j1CxK5gdzfepDnEFMxFe44W3oSu6
         g1OQJpz8/hj0lIm+MqdMhZ2VP3hUQcxlzJizms7JdZyu4/gFdGbhobhoa1wt9lACiU79
         Xa5W2XmbcCVZUt4XJAj1TPMeLweGusHt+WegN+tSUCCCZJ2ZtMAh52CV4jdp6qEeM5gO
         ildA4appRKPhyDcA4jhXJ1QcJjedYKKZA91zuqYVbYT3XUDpjc3kywwatgT4gZ7ZfLZL
         bkrA==
X-Forwarded-Encrypted: i=1; AJvYcCWB1EeBnnK4veosGoxOVP1omZnJsSTaNRI+VrKpXUvfEpAXu9ZundPdg22LypVCnA7QjqPUZFMUxvs=@vger.kernel.org, AJvYcCXSlF7TeLDPkuUs50FkRDMvIOO393KMv+3a8h9S/+5YoFqptimHH7+I1BmOpXbMwDyDyD979x7RAusgT+Tw@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcu+UsYIeD72rKQkMGDUdvqOsTUtDvbi9ojVcYmUmKNKcDpGJ
	DH5z5IE5apVSGReDquGYN91E9t/Y/ciDhmRzHgV/1Rna58YJHbjKWSB8elzb
X-Gm-Gg: ASbGncvT5xyn3f/h+YqH0+0cmHprI/oEA2B6zvF75G498YOVj1FQLtZOiGqrAZUqiL6
	RSV8mGM2uiVZSr9895VNCaMwPXPEYKTABc2hjBzghOqwZ6rCz4DAitMQEtyd5/sFkP5nTeYJLMR
	f4ZkUm08u9gbVD7UshGWjrKHYiFUin637aRKRsjgCVAjnhPMGRHyazg2Tsx7LJcEkN9LfCPzafY
	UjbDbaGpwGAOJFefLdzVWyU9+WDlkmerDzUb0h6deoo8x5p2RyOXrkMjNjqRh3MKLirmZGWc6DD
	OC8r3XtXM4oGkT+c8kZXH90Whv33FHUjeiq4g2PZ1AUJ7SsZNiUkhnZgtHc=
X-Google-Smtp-Source: AGHT+IF+UZBfUXn/UpvOy309rJXJqu1NXWiO9nxP1cHKFYoE9PfnMOKsTLo81UkXPFt7byXZpnZWNA==
X-Received: by 2002:a05:6902:20c9:b0:e72:9612:f78f with SMTP id 3f1490d57ef6-e7297eae2e7mr12731645276.37.1745197329864;
        Sun, 20 Apr 2025 18:02:09 -0700 (PDT)
Received: from localhost ([64.234.79.138])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e729589a6bfsm1564277276.26.2025.04.20.18.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 18:02:09 -0700 (PDT)
From: kendrajmoore <kendra.j.moore3443@gmail.com>
To: dmaengine@vger.kernel.org
Cc: vkoul@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] docs: dmaengine: add explanation for DMA_ASYNC_TX capability
Date: Sun, 20 Apr 2025 21:02:05 -0400
Message-Id: <20250421010205.84719-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kendra Moore <kendra.j.moore3443@gmail.com>

This patch replaces the TODO for DMA_ASYNC_TX in the DMA engine
provider documentation. The flag is automatically set by the DMA
framework when a device supports key asynchronous memory-to-memory
operations such as memcpy, memset, xor, pq, xor_val, and pq_val.

It must not be set by drivers directly.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 3085f8b460fa..aac2a18bd453 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -217,10 +217,12 @@ Currently, the types available are:
 
 - DMA_ASYNC_TX
 
-  - Must not be set by the device, and will be set by the framework
-    if needed
+  - The device supports asynchronous memory-to-memory operations,
+    including memcpy, memset, xor, pq, xor_val, and pq_val.
 
-  - TODO: What is it about?
+  - This capability is automatically set by the DMA engine
+    framework and must not be configured manually by device
+    drivers.
 
 - DMA_SLAVE
 
-- 
2.39.5

