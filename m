Return-Path: <dmaengine+bounces-7064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB7C38D87
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10EA14E2719
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC3224234;
	Thu,  6 Nov 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J755fygp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AC1E3787
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395635; cv=none; b=Tooe3lRcSiyJoIOzVMbvrrFIbIIoTHH5X/TpSJyxHEKk+tspomtUB3011UbFU2OzRpJbEYkKNXCU2eqxNOjYC5aSlpaiKrZDUQZmsIJLeeE8KXLeiTrKLn6vezZwFnv0mHpUfLSiiD8bmObD6gPgppyMfRQkjlMpUMgZgm5Pkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395635; c=relaxed/simple;
	bh=IExuTD4yP3lfLoet8tZrvmXvXyTJ/DV9Z5x3qgVSFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncAreygW1eJem13o752KkkqRLB2NYqzn2+uI11s+3rvSNcqKKg3rjAcz95Hi97Bd4fwahr3sTn+Rbpc9A/xHN86PJzCnnX7cB+qdRN3COUVNB8jnl+8G4rAg5Ir6Mvz33R245O2YlB6u/4yCs5zCyU1eByoMcVYUf2OfDHamjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J755fygp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b593def09e3so250342a12.2
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395633; x=1763000433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APyjP89ZEGyOgpw6IYgPQw/KB5WQid/ruGqpO1r3Z0o=;
        b=J755fygpH9udwp6JQW+2muxZhlEnNOrnbjUt0s6zMdzYLx+I3DXsBDU1tQaA4cO0h4
         sKGVmKginnlYjaBU9LaYmWmpKM01+Zg8DFkILcIGhVIuvCIg0R6Limlt2ehLw4Zprxx0
         9z+PbqY0cH2bhBdkIpvSTQWgmOCfyLQqiinPqOtEleQp6GcwK5NOcrPs5f/OBC30xJn/
         axKhCh20UKYhB0sIcIFyUxr69A84o2GmlCZsV+mbnLueJGcXV5aiVcdhrAtklELG7FNQ
         P2A4JDh5XjPOoX5xsPONExRsXdYhvf2w3OuZeWiOomkgYG/duWAngC96CnTCF4ECme3p
         7DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395633; x=1763000433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APyjP89ZEGyOgpw6IYgPQw/KB5WQid/ruGqpO1r3Z0o=;
        b=dHF1In/QDyb9zu9IpHtoX6lKe0n9/Sd2D5H0jZhlmmvHgLbvSx2W/vtRVBBiuCd3k2
         2oxHhMcAuqtzV+DNRsTdx9CM6ZRG2PDPHSdcv+JbHhdIGlk2Q2J3qW7fm4EzhOy+X3aV
         KugvY4X23DEfiIDrQzCA9uomx9MSMELe3auDEf3zMaRMid16cMpmCbXIt+COQe1HkFuN
         MCQMJi0/2c11gD3Y+ClO4FklVPkUByTSqXss09DY4PfY0wv9/wWo/s5+WPSPB0/o1yNe
         JWlon7EtBuh5gAPiSGp83tsFu/lygX59UEXL7CfQhytNbpL27HuECjc1ja0XuomZ9ke/
         D35g==
X-Gm-Message-State: AOJu0YxwwcF0iszIuJEvo3ICnL+Rdd9qcAHimuTlHkSBNY/aR+S8hSW7
	NDk1GdGzeFRYNqL4jX7MZ5tb0N7Z6k6myUbCUwgJC0spluuXV6uv/my3w1PRPQ==
X-Gm-Gg: ASbGncvLsq6f2rPY1ol9gmGFMlcjH+/th6xGeqXnT5z8naWSQ+Z9BD1Htr5R8kWU8R8
	8/BWfxq0b7Dh4ascHo+vHCfV5uo0vBYhIdszYSNvz3QIbM20jWsYt2t/dt6347YlDcn905Jkutl
	D0b/s/vG+PJ2Q5N3i3uxtKHsiLSaRDAlBiAokMWwn6EkggPZtXCdXlHpFMng3HFNfZXYAva2Ct6
	qRCyQoylNCDDgEYF3e0kK9LbdaxFacJdULsx5p37+lS8hdk4pvGs1tcQedwScto9CngNMMm5qip
	RiB3S4Eki2VONw5S+2mSDZ8cYK4sn3WJHKDSb/KRbTSyo4MRL8MmIY5ac8P0YJLiFfCYbuPSkq4
	oTRE2Ad592+Cga3COglb/3Qj+eCxDUiWBagFfmYEzbYp1dFE=
X-Google-Smtp-Source: AGHT+IGwLwltM7hjFkqW1lSpRRGBPVQlKwEPQ277/7xJAbJDdTTr8KfzmlicE2p3iE7bm1PNBZeJ1Q==
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr6787728637.23.1762395633255;
        Wed, 05 Nov 2025 18:20:33 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd57f91sm830516b3a.23.2025.11.05.18.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:20:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE)
Subject: [PATCH dmaengine 0/2] dmaengine: st_fdma: support COMPILE_TEST
Date: Wed,  5 Nov 2025 18:20:13 -0800
Message-ID: <20251106022015.84970-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit fixes compilation under 64-bit and second actually enables
it.

Rosen Penev (2):
  dmaengine: st_fdma: change dreg_line to long
  dmaengine: st_fdma: add COMPILE_TEST support

 drivers/dma/Kconfig   | 2 +-
 drivers/dma/st_fdma.c | 2 +-
 drivers/dma/st_fdma.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
2.51.2


