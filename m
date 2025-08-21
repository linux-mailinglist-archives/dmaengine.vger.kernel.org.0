Return-Path: <dmaengine+bounces-6093-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C3B2EC46
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 05:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2803B0B3E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A712E7F28;
	Thu, 21 Aug 2025 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOp9sIaz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BE2E427A;
	Thu, 21 Aug 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747930; cv=none; b=GKHXqx9YhL4hRIdDQ/SwXWoRBk5aArJ2czbvOAtj35XsWTp9GVLAOhplGI18VrWnXQ/DSA7C0H+PV9s9e3PtMyft86d8qVgL6Dfi61twbvtAj4v8tcfFCxpvceK01t/0sqm43STCLYbzyuhkr6AZi62cWbOV3N567TCd0j0N/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747930; c=relaxed/simple;
	bh=bSZ/6A9ca22KIdWF880fraUW1VKu75WPdtOWX65e+wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMqOjmhMMLxNk0FvJjwqBZ8hDkcGo9EMKj+fjdXSV9n/sZvAGIPTSkqd4ZfbtGbHitvk+NjyWi0/Kx65LgGNK57q5xg00YeWz2AwzC3jIVoh1yKfn4ZYoMM8cMiqLe1WZInSTyNRUFvUaqek/TnhdsdErCZ74KL3X5wIQvO5rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOp9sIaz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so532999b3a.1;
        Wed, 20 Aug 2025 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747928; x=1756352728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AY1pxYngEaSnRiBwXk1Rg1ZCKUm8lNc//QGnhj66Ts=;
        b=OOp9sIazPTUdvddC4ClzdcBSvtV/rwk4+LIwSbdtEhJ923hn7kBJdFXb5eXFbJaoCZ
         vkGJpkGXv99z6vCBguvAFS4q5kSPUzxYnwPu34gB6H1veMJsr41qKZriwAOynHth0ofv
         QMEyv/SHlnD3YPVwJwbObt2fWj/ss5ehCfW6mA+opoC07G3ZSYvuszq/WjsD8Cxvof1q
         xFz0H9Yvq8ipTL0BO82iOtUr6sDqDSYYs+4YrtABTahnjrKdgwNnw+IHhoZZ9EZbtak/
         LrbVVTInSXdJGBs30u47G+uQTkm0plwuwc8IQsVZo9DkJRxeUYdkQ4HpjUYiDF6bW+Dx
         cx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747928; x=1756352728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AY1pxYngEaSnRiBwXk1Rg1ZCKUm8lNc//QGnhj66Ts=;
        b=FG1qsM0omiG1/cFsrVqs0eSIZrV/yT4a4WljqQOp5iqvDRVN2oUwaZ5R18y8t9AfGv
         02GgXTK+ptknD61mYzlDH2CPStlrG4HVw8gdLKQvD/thTfmVMMvlyASgCEVGYVHOAbXB
         sKOb9yu5H8l+zUCYWgyEPizkZIMiVmR0kthJPgGo+/k61KVc/S1JQnQUSShKCB0TvZkW
         Z7QUMPwO/fyHzLeqInOItuGTfr8rU08UXbcWTdBJo8clxACSRBJeM1e1Oy7YNLwFcGIh
         V22aFsR9bQ6eBzEb9Ieel2wlqfCAZ5Z9KLozxjAw70UaLid89R/+LYbLdGlQ5gZ7DEnL
         uvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWUNPyZHSW/6h+I0+cPGYw9DhHA+KfoudUlH25NiePa/7/WRMW/QGQ/RwXlwhWfPzpMRlVoIZ71YBrXdcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7QZUVmECk29XT88cXDEPOJgOJYzsuJVo/OeNfM5bItfCvCFz
	MM8B7mEpU+L4KnAiX7vqegu9qJQ5hkGX/uIjdkkoKN6ccrBlj3pENneRaimy8A==
X-Gm-Gg: ASbGncs0ssju3RJ40lzHODfulpWbGoeb3TSogQi4bMeuRB4GDNd3/raAV+f/Wcp99BC
	mPhCkgnaYIcqLLvyjGBj6LKSBb4VapL45NH6Nu233WN8bBZ/4n96YgEGRL1q1CtiBElgnykwC6q
	j1K3kg+kE6dZKrpLNIo1M8Dlv4gBwxy7qUI/cOzHNYHVC4Dq5AGDcCdc5mwIgbNcSHK2Y0T0rgp
	p8MU4quCfeNSmFk3w0SsCesz2dls3L6GbpeRGIRYKC5GMuHM//WWuEORY8Ci5W/eQztIeho4bP6
	3XVwUpHNnVycCdS+YCNZMDpBbZmYwA9ZM16XDg8H+zyWbdaISfcgKBcp/vKNESKPvf5pHPs/qb0
	tSDnX
X-Google-Smtp-Source: AGHT+IFKgIzh1zLe2D4revW/YG3riHbKMNnktZ6vhnEoDL0LTZJuxxm2guN2TwQfNTffUvaV3NlN9w==
X-Received: by 2002:a05:6a20:3942:b0:240:30c:274a with SMTP id adf61e73a8af0-243307c1df3mr1330784637.18.1755747928377;
        Wed, 20 Aug 2025 20:45:28 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2402c9asm504932a91.11.2025.08.20.20.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:45:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/3] dmaengine: mv_xor: use devm_clk_get_optional_enabled
Date: Wed, 20 Aug 2025 20:45:24 -0700
Message-ID: <20250821034525.642664-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821034525.642664-1-rosenp@gmail.com>
References: <20250821034525.642664-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver was written before this was available. Simplifies code slightly.

Actually also a bugfix. clk_disable_unprepare is missing in _remove,
which is also missing.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d56fd130173b..8f0c3bfc60cb 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1351,9 +1351,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 	/* Not all platforms can gate the clock, so it is not
 	 * an error if the clock does not exists.
 	 */
-	xordev->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(xordev->clk))
-		clk_prepare_enable(xordev->clk);
+	xordev->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 
 	/*
 	 * We don't want to have more than one channel per CPU in
@@ -1441,11 +1439,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 				irq_dispose_mapping(xordev->channels[i]->irq);
 		}
 
-	if (!IS_ERR(xordev->clk)) {
-		clk_disable_unprepare(xordev->clk);
-		clk_put(xordev->clk);
-	}
-
 	return ret;
 }
 
-- 
2.50.1


