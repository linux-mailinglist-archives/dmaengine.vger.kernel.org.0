Return-Path: <dmaengine+bounces-3336-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CC99ADE9
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 22:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F20EB24568
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2741D1E73;
	Fri, 11 Oct 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+JUOZDf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7F1D172B;
	Fri, 11 Oct 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680297; cv=none; b=WFf2VFKVP2pdLg/o5mh/ieZP1/WxU9Dpg/tF4b9GZhCyGqg8xZWxY4CO/xcDxO9KjGDesz8ypgwQnDdOdkMSm4F1ofGTMLESGtdB9i4Yl6q+3424nME3tWJ2jnBIOheaaG2JVI7PcSrmV+In4DwIF8DyHIlFZhIFOjPMAHylBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680297; c=relaxed/simple;
	bh=uUNQk/Mq4fzyjqilGErg+9k7fkR99qc+DJ8G3u6dptA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrJBBoBSrW/CcWW1OeVFWnB+gZHBhnSzgwilS/QChqKBnCjXLHjdJyxNSAT2VP8DT/Etwe5O2jPtdKzuq2iRCVf/MyqQAO9ncRavH3ka/QepKwDhtabVlViq4SLK9b0wC8eRLduXHs+5e5+RNP2gsDD17YpFQqNfR63hh/wN0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+JUOZDf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so18060385e9.1;
        Fri, 11 Oct 2024 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680294; x=1729285094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUF/BYXWqa73w1Ptjg2Or8FJx8zKQF+pmQV2piWya60=;
        b=O+JUOZDfl9vmqGN5bp1yJFvNXi61d2zoF7Z/6QfpDpHKxAc67F15OaRq70wqquW8P5
         Kh8zVnHXw8vGOGgGKBsVSezScMIU8MvVyzu7anFvIMfN+1yLM4zb9+JNib/Ryp/fqW4d
         jdR7YJbDoz3sap/5a7wWRrj2ckcnrApcDxULZhiYsMxyQOaOp6D4aOpjRA5VZmx2/eig
         udA8eQx4Gj5gyAwP8RcpwVz9OP/IXcdjxk9xT+cMhz4+J5LMhp/g+CnnIbsnoAc2yqHq
         w89mXw2abNs5YxQvJON1FOwb8EZUJev6Nk0nSD1+sQUQU6EzKgIkBmDtw5xlfbwmWH5G
         ZivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680294; x=1729285094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUF/BYXWqa73w1Ptjg2Or8FJx8zKQF+pmQV2piWya60=;
        b=WsPrdZF/62/3wCYMmoUuI2hbMfh5t3WYZVaBLuRKv9u5wN4ODlOcPPbmpYNPIQ7kDL
         nUM2Kwq+xm5SlgWdELbUZPb20qNiTN57KxeO6/XZQAGDNnP4KJralvd0czhZ1nTvAKHs
         xSjTdcZzJzpe38Zf4qFmR4NboEu/uTbcRbflayBWMdbH73b3crO0Gv/koK1mYDpSHdMi
         Hm7bz0OcVbHZVTWdHj9d140B0oMbMWD9TfSEum70d+RN34ReA3e5EQPpf3xpr5xEkMfQ
         OIa0HMbhvEkDTdXY77LRA4VRsULNdvuzumx/HGUt3uvvDIvO+MeMg1+a34UzrytqitG4
         /sBw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUToisu8nKxMUGI8EL192sEeRz2cyw/dERTPACAZWI74qU3YwhmbCX+7giicdU9vhsgdSRfVIoNJnCkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUGcNI50ds3y7JeOyUHQjH0F2mnw8lnNIbs5Q9j8fWn4xVIlH
	iPR1f+ENE6SYJlCJchZoQ6fhkNy1/JSkbJ/CdWpGUApxJ8FSOWeIwN/42DQN
X-Google-Smtp-Source: AGHT+IEKkm+3IwlgPeSypTq+yOa7pUD5sQvJe8LrR4+l/DjQQuBVLSYLqTZgoLWoIS1gqk/iaxVYyQ==
X-Received: by 2002:a05:600c:3ba9:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-4311df47018mr29023535e9.26.1728680293933;
        Fri, 11 Oct 2024 13:58:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835c4fbsm50984055e9.39.2024.10.11.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:58:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 22:58:00 +0200
Subject: [PATCH 2/2] dmaengine: mv_xor: switch to
 for_each_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-dma_mv_xor_of_node_put-v1-2-3c2de819f463@gmail.com>
References: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
In-Reply-To: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728680289; l=1349;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=uUNQk/Mq4fzyjqilGErg+9k7fkR99qc+DJ8G3u6dptA=;
 b=TNQQsqADQyWmGYtdCojYUrwgmdHLIx1YAHmvSLTsQjx47H3UOH0qdeZFwaaFcFhEREQCUo1nj
 MePh7e80dDZCg7lEQ4M2m71xrOwCFC00t4m5UqNbUOJm+U+En+kMJ8e
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Introduce the scoped variant of the loop to automatically release the
child node when it goes out of scope, which is more robust than the
non-scoped variant, and accounts for new early exits that could be added
in the future.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/dma/mv_xor.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 40b76b40bc30..fa6e4646fdc2 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1369,10 +1369,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 		return 0;
 
 	if (pdev->dev.of_node) {
-		struct device_node *np;
 		int i = 0;
 
-		for_each_child_of_node(pdev->dev.of_node, np) {
+		for_each_child_of_node_scoped(pdev->dev.of_node, np) {
 			struct mv_xor_chan *chan;
 			dma_cap_mask_t cap_mask;
 			int irq;
@@ -1388,7 +1387,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
 				ret = -ENODEV;
-				of_node_put(np);
 				goto err_channel_add;
 			}
 
@@ -1397,7 +1395,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
-				of_node_put(np);
 				goto err_channel_add;
 			}
 

-- 
2.43.0


