Return-Path: <dmaengine+bounces-6091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89356B2EC42
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0675C2967
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241E1FF7C5;
	Thu, 21 Aug 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFgtAQ9f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009D23E35F;
	Thu, 21 Aug 2025 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747928; cv=none; b=UR1Dizf1mC1Is7I0t5N/b51QkediqQ4H8YzRb/q1HptZ22fIQzM7UJNQRQSlfrFb+prsTeC1eebXXLkMBeH0lgFJJw/HQOVg1nriW3JrnspxlxOCu3LZYc6rwTNgoo+nbCTBXdL0xG+nyb0TG1zTeodqzzq3LMKoQeDtfToYJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747928; c=relaxed/simple;
	bh=pFnTT1KUiWO8JNisywOJvlEH92p1YQccixcb8UY/FoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyyU9CseWjdqrf75ZjGL8hYpB0yOwAzgBkzgPHLOg+CypR8llEyhGuAdgqnQ1YD9+N4E8OHkCFnu9vzqj5EXDfsv/0pvaoJ3/JujIRZQRs5QD+IX37qJqIqdCLB0UjyXJdKrjaoPOlVebEb/bJU/n7z4Ehgebt88DWsD1jZBeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFgtAQ9f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266baa22so424585a91.0;
        Wed, 20 Aug 2025 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747926; x=1756352726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkwb1ANJvRhUxMlpW2nOBrbBZrZmqLO9Zc1POBG6WCk=;
        b=HFgtAQ9f6tmzm9UjdQwV7H3E1BHnMlDzcdbP+RwIdEvClpujtSi4O6CO8shRyO84KY
         Sbvd9PfdFiV51HeYJnfBzGC8ZHVJ/nffYef59IAK11ljHria5IaHs9sTmcq/Q5CR+roS
         +AtzlvaO44yRhKWatUapCW64l+d+8dZcpGInGsQQnzh667B5tufw/2IfMoP1GFZEW9T/
         RpEJpvmu4CsYQRBjfYITNQhJsc81y2+ptrZkVVlHUNfmmnKwmveYF//xdFOXiV1N+pV2
         8IQdoQPuAhkWPrCrznTtYFUmrp038AtgbIVPnu3I2zPrUaMh/nmVfjSO7Sg6aGgPnWH+
         ouUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747926; x=1756352726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkwb1ANJvRhUxMlpW2nOBrbBZrZmqLO9Zc1POBG6WCk=;
        b=Qhd4DuJhw9Li4MvHLEJqT6wQz4fG44XoddlRefRUMOpeRcLXwRfdQ5BB8vr7ICte15
         nbRlydW0/3pWge1Sf2qy/PzL/8FjVItmKDlMnQamsqom9lWDoFD0gKSFo1zoqibsLCiV
         5Dennf+UgGJwH5IafvlEisFPoMG5XqVvLz0/SlYIf6u0NHGTkGNYjfWRfr5O9aMgmPlg
         bn7DCSwc1pzPU8YIc/g6ZL3qDEtt0uInHO17zVZha8dTg1+98SM9iiw7iXG7IkBu/44b
         6PlGaOclwKjy1DqwFN5JX0n8+b9oePyjKchsi8Byrhar8Fm5erHqFY73jxP9lG5C+NV+
         0h3g==
X-Forwarded-Encrypted: i=1; AJvYcCVIXCoZdKl50fBkqdWA1G7C23CeUNZdCM1HJtT1nWAa0GR7q7T8XsLtlGb+4RLY7ydTqq8VF+5zTiC5dO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSP0xjPM2Ey6kULz5LIFza6OeJVyMcboB4IYKX7YyN4swNoUgx
	iwc5jK3elpBiT4NcZgRaZtuZUM4RKn1WOFwHMmYua2xX0g0KXA2ryvMYpZ+78g==
X-Gm-Gg: ASbGncvmOBLY4sbpXKTVVSuP0RSb7zRvlN+6UO1w4Z4Yn94dl6wREDg97FEPJhBpOJ6
	HYfy3Me6vSS3YjFYicbkmy8gW9UDRzLqzup5xbJI0N+ocmDPAAU6ZQamrMe4eOxT/1u+CEJUFkV
	Yy77Bu48HydUxH7spaYaiO/ygFndswyyJv+LbjgApCSVXrM9UiiXgK+XoYr1z3GKiMn53RjFERm
	uVAFa1pqkY2LhsqsAB9AUcr+vOhxiE820sXXNYjjCs24GpWPkHhxHRRM9TVKFSZ3kg/2gLGcyko
	cDZeKUc8uNHnNV+2SQZ7wWB3V1BQ/NWXSpKcJDiBb98T2ca5rNDYGE8RH4CVT4ULURW3uG+4KuK
	EpVGbCgcgC93oIHc=
X-Google-Smtp-Source: AGHT+IEhUjc5wvqRYn1SEIXAHC/eH0LRSpgfzXf2n4xbOABbBbu7qYbRpMEWjhmznMJuybGkMGUreQ==
X-Received: by 2002:a17:90b:53c3:b0:321:27d5:eaf1 with SMTP id 98e67ed59e1d1-324ed154f18mr1220727a91.25.1755747926428;
        Wed, 20 Aug 2025 20:45:26 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2402c9asm504932a91.11.2025.08.20.20.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:45:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/3] dmaengine: mv_xor: some devm cleanups
Date: Wed, 20 Aug 2025 20:45:22 -0700
Message-ID: <20250821034525.642664-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Rosen Penev (3):
  dmaengine: mv_xor: use devm_platform_ioremap_resource
  dmaengine: mv_xor: use devm_clk_get_optional_enabled
  dmaengine: mv_xor: use devm for request_irq

 drivers/dma/mv_xor.c | 53 ++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

-- 
2.50.1


