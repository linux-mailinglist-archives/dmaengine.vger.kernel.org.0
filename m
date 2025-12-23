Return-Path: <dmaengine+bounces-7932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62035CDA8D6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60FFA300AB26
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A229D26D;
	Tue, 23 Dec 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5FFVeM8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF9199237
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522582; cv=none; b=j8ZvFQGxqTx4hdfIqileqSR72UkCa7nnHAYuK5ayGcpAXfgMNPRPQAhOILaC5HKJzCyylsbIp3S0FJa7M8YWX8LIK3hs4+si90DyMCxeL70Y3z+LbrrBxVXAO2JN86BQ8rw6Ynfdu3IpV8Xs5P1o6jJApu6bCi1az5JptdkkmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522582; c=relaxed/simple;
	bh=ke5dwxLStzlgB9Q2TZ20Z3uVixoRA+6j4APoiTgBCCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJUM62hxf6AcjVvrtoITpUIVPMDMUY6djv/+YscMwTMKHkxOgBbEfUQQqGUAFQQkIFZXKOlFHEh5eY6CJOTvLYxEHJQnCSfYMg9R/a1CUpsaaZkegfFj4u/CxpWZfaWK6zS5jHkSz4AdpbFsMJh2377OJ0WJq5pZno03hAc9/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5FFVeM8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c868b197eso5646391a91.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522580; x=1767127380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sT4U6DOd6mDMboAudt6HQ4qyoh0vyVygbQfQGUrAe9U=;
        b=m5FFVeM8kAMNiUe1XxUO/Egs60D1sNdc1ZrO+mSn3Sh5Qon6nmwN8vqTjptQ6GYQYQ
         gur1ORdjv75DKXli/imZbwysW0e57JrOED72SIztZxVUnRSj4af1K/EkgMyYb+6CT5+x
         2amWYd+e7Y/wzRlCHpHJRQ8hhnk/s0eNQblZSIpQil0CfyrZvWAfm9P0LgUdbF/uRIs7
         /XLwpTiYg5d6ZInSQjlJH6JTWkTymt0qBZPROYFnVbgTgaNl/oIddJq8isMEREVA5xj7
         uhm1boL+lXkCfJm5s1E17LUB/P+m7IKDIdbH64X5qxuShWngSPjKjchfKIcNR818/tyL
         36Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522580; x=1767127380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT4U6DOd6mDMboAudt6HQ4qyoh0vyVygbQfQGUrAe9U=;
        b=Cp/SPqOGnVpnMA6nmJMr/lOwOCuqgrJSQ5a0cNEUYc0NcY+b7two3s6hHHkvn3XBYu
         h6kOEdqu5DYmSSTwl/3sCarN06LjS4gSP0nSgPhbJYK9jeQOFsJMdVxPkexGdMDhYF4v
         J4qpQ1Fx5Z8Q4DzneqSVpuLJGJhO1q3Pv9wDpUp9W8HUHu8zUZ0Jgar1D/0Z/d7RehO/
         60N/mHT2XBfJHkjanXhllRasqb52IcEhPKePr/2ZunFTgaC4WVq8+dAUQsWlNAmwl+Q3
         LUSrelWJM16TWDavMP6FSsx5eBG6qRC7SZ7UXjwCJuVnMxh/vUDD7f2N9r5sjpefTA7v
         MAfg==
X-Gm-Message-State: AOJu0YwKX6WdfE/HvslXIqb3L537QaegOy2AP0EmB1j00IuqkRhxCFmA
	yGbTG4Rrgal+qmjvpg5cgAxtk8kWcB6MArfWvRkOCJ6mSQosUMcgl6Hx62MDSw==
X-Gm-Gg: AY/fxX7lIpXLUka232k83nnmUVpP4lY9fTJpgBkI/A0IOdps5wi/IeUIaw6+0Z5Xyvh
	stle5yKuKz5mfv60EZGD5JL4qP5FvjwdmwGwPSN/HK5ivTUBkE7ahuR9GNxsGEy+B3/0I4pH9mH
	hNjfN9gyu7w6O4SuJAAOCvGBcF7wHbNTj0Fm8urN5Hyw3UNWtSOEZFiTNGibuFtHyMlrUvKsgbA
	YnWAnwdPn4oyw0RJjheIKvRwVYyhrs3uX+SxvnpkogxUX0I7HYd7WNHKZotPbzg2bKqlskSB+JE
	YVNha+ez/GLZom0N5vOCb8uvGYJLPFPoveVH/gvhTda2bFJ1D072j+tK7m590pfoCFWFB8KFRCe
	FMVu35gAUkjF3IFgftysXg81bKYuKHnHWO5GonOlVFickzQMvc3QSYORYDQ==
X-Google-Smtp-Source: AGHT+IGAGU5WOIZBv7dWSwohHa5A/sayVJ94rNHy9AlqVIBAdCUcxWqOB0xEVfSU1jovngNMPkaZJA==
X-Received: by 2002:a17:90b:3d90:b0:349:3fe8:e7df with SMTP id 98e67ed59e1d1-34e921be5demr11096959a91.22.1766522580083;
        Tue, 23 Dec 2025 12:43:00 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e922278a4sm13931871a91.11.2025.12.23.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:42:59 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 0/2] dmaengine: mv_xor: some devm cleanups
Date: Tue, 23 Dec 2025 12:42:40 -0800
Message-ID: <20251223204242.3415-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: resent with dmaengine prefix
v3: add error handling for devm_clk_get_optional_enabled to potentially
handle EPROBE_DEFER.
v4: remove request_irq based on feedback.
v5: rebased.

Rosen Penev (2):
  dmaengine: mv_xor: use devm_platform_ioremap_resource
  dmaengine: mv_xor: use devm_clk_get_optional_enabled

 drivers/dma/mv_xor.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

--
2.52.0


