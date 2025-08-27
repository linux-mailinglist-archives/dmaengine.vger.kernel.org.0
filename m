Return-Path: <dmaengine+bounces-6231-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27865B38BE0
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 00:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7903B06F3
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF92F28E9;
	Wed, 27 Aug 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLZCInUZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8E2DE6E9;
	Wed, 27 Aug 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332009; cv=none; b=dRJiUbySjJW2GWQfRJLJ71/p6Gs26PSGijl58X06WloIl6+I3inSxJQJl7dtRerF6kGnJhH8wjbWfdphk/Okv4F5FUnCQClyfbCdLdClMkhsVKfxGoKzkbFJ2ra6cek7GfnmAVK735cBSUOZFNo/DNK5NHNOVIbvBmZnZ7uTgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332009; c=relaxed/simple;
	bh=wXKXdoJQvnsbBeYljfQBc6eX5Fyt5ALOZ/Ch8feCzl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3DmluJon2pp7WfONFLHqg4Wtp6bk/E9vhFyOR3eeezl8KUwKppcVFRtvaM4p8Rje72OWgHrmrkX3pFGGP+abc1+qe5/NNxzyLJ0I0u3IbYcq8ncH2qyt3MSV8uqNwcaMuMqiGKCzhdbq2DNopB/dco7AwsC/jlFDxPpAbVTsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLZCInUZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1071635a91.1;
        Wed, 27 Aug 2025 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756332007; x=1756936807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8N9Ka0sjDJ41y6OsH3MYJPj1Ld+iZ88dVwWL8rYw6A=;
        b=LLZCInUZZp8hTyG6WM6vaRrXNh3i5wPQVw6wOQbVY1Yb5hRvemiNCF+nZi/9OqaXhD
         iRKl6U/5tKkZmSQxNzEyl2v8irQlyTgGz5NXqyMXdYrKjCOPmFPrp21f3JvDrpX3WB3/
         +PnexneBFySyc/zH8ht6UJwNXHMKUSZSSsI+Tsp8gvTEWZ37oND0fUsLaQvwQkEjsyQQ
         d5H259iV3qvp43/uTI5cVyIhCrasOTxjZFfS9ZjT1K6c7kAmqB2py8wqyIjj0olWGWd0
         yQYyxS1oKDaloW+xRIH31EUs64ZRgrBCxWk2r4oGbNK/soIhtljgiTOEu9jdVcO7Rtir
         xXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332007; x=1756936807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8N9Ka0sjDJ41y6OsH3MYJPj1Ld+iZ88dVwWL8rYw6A=;
        b=BvS5P/2cLxPDTrgr3hBjdHiLKHElv/FLFjI8ir0eepWBrp01WLLOPjuBwA2Y3zsEWR
         7T9meTcNSgN/eZ9m9kMezhkv5s1cEd01REZEwWTF3V3RTwJFXETrDott7Yc8saqhzzlK
         wrjGoHmqMPtly9iQTyCaTDqE3fX4mrEXUNzMKE4u9a29tiLzYDugZMGl79viFOgDj7Tm
         udnnGb8JfH7QYolIVXw2dBkW8PRVLz3HJMdDfagsAqMNvNC95dnq1OrqKTsrP4jG2tYe
         c2tgbBAuqyWLJiU0sFJS1LJ8mOFSb4etn5pt2iYrNtJHP+vGPpLJKiEHKgCnh0xHhsVk
         fC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFHEFUj0g7i8PwSRQZM2GJSzdosqzkd1S97yvKQGwV+hbvazOdCH4X7yU6/kISwlTWNhVKufXuS2zVdqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJi91p8bJI9gagqtwqfEX9zdN8kP60m2laGam+5spQM9xypGQZ
	T8cn/0KAopCfwJWdpYqmw19VMi9OxG7GjGhQJBwCBgsxjvR3/0nSZQ6bliDYEA==
X-Gm-Gg: ASbGnctXO/6Zdxvy4zSre8o78fIIhhoiJMHWxF6LHDWda8/pFAKpX9ihPvIP3hCebLv
	3+jsUzTpsci8Vwm7ETrW9l4t80xjrxgVTw1J+1kAzBEgdbYG8I6xbmbDh8n7dKsLpctbT3ouBD3
	GXddYNFpAw1ecVZscfbGzjHXyKnoLmq+4EE5gXNS79He2bYVORWozlmQ1EH3+AGXSpHYUJ4e4sK
	D2UPTVePFp0ShhZSCRjPx73k4X3sLHL/Ds9VHiRBaqH/qJQ1bREZksBeCuYQ4K76t0uZoxh/XpP
	mKzt1JvD2f/jNSNidOtMW/KaMXgyXhSE/aM8GpaENyI5+GIM+cEcinsJmHfWZw6pKIxzL3C3T2L
	ozMqQy4qcYDiyKR6+6fzH/JJpyRgM7TsQNtEwQRuOqfGLd+wF5G3qhx0life9j4kVGw==
X-Google-Smtp-Source: AGHT+IEm92Ed7oO2tiMQjnXEn4LDzOFWjZy6i3e1X3+q2jTg3iufyWXovGaNFgh9zTwqmKCotanCCw==
X-Received: by 2002:a17:90a:da88:b0:324:ed79:c822 with SMTP id 98e67ed59e1d1-3275085daeamr8121571a91.12.1756332006881;
        Wed, 27 Aug 2025 15:00:06 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7bf2dsm12389128a12.31.2025.08.27.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:00:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 0/3] dmaengine: mv_xor: some devm cleanups
Date: Wed, 27 Aug 2025 15:00:02 -0700
Message-ID: <20250827220005.82899-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devm cleanups that are now possible.

It's interesting that this driver lacks a _remove function to free its
resources...

v2: resent with dmaengine prefix
v3: add error handling for devm_clk_get_optional_enabled to potentially
handle EPROBE_DEFER.

Rosen Penev (3):
  dmaengine: mv_xor: use devm_platform_ioremap_resource
  dmaengine: mv_xor: use devm_clk_get_optional_enabled
  dmaengine: mv_xor: use devm for request_irq

 drivers/dma/mv_xor.c | 55 +++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

-- 
2.51.0


