Return-Path: <dmaengine+bounces-6871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2682BE451F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827D619A3DE4
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4602C21578D;
	Thu, 16 Oct 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMgVxrMf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB61FC110
	for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629594; cv=none; b=uot8zZJpIK/5v9HW5B9AahZ6U89r/yQxfT6I00RTJdluoNfn6h1hP042GfFQwWrxUlw5ZxOXsfRp09JmIpRMckXu9Pp7upBoo+hrZE7Wg11sCcUDoPtSW0ngbg0ZTDB700jdTiH1p33ORvEA7bULD/fPLvlinaH30Aq1biw2TK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629594; c=relaxed/simple;
	bh=hKyfEzjFgM6gVDw5rNLNPi1mlTz27NLVHsHOOnG1Mj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJY6/ei6dGfOBRjWt/TEBmJ/E4O2PpscVI3aM/EMDZbErZhPfsQ0xsjXVNIXu1CmEHGCUfTUhHUYnX/Jihmea5wNQy0/SzBQXgwe6vBfQdEIF+viazDbn486YRPTHJmSjwlRg4WGh1nUVqu+wJLiIvT1m6Kw46eicUdmIQ7xZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMgVxrMf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bd822b007so1568774a12.2
        for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629591; x=1761234391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TWktSmOYD0YxtezmHYMgLXWGztB80rGJtdvycR/nII=;
        b=UMgVxrMfB+ucn8Z/udl7jq1+iEC4aSmdiXB+zvWxuud1qu/jDFCOcMf4ZaDOIob7Ui
         hFHhYXIqJozBPmZpcfBSohakh9uw1K96MWLjww8rq19+tq8sGMTPx1CkecRkkToR9ifu
         MEI6szIXpbygv+rY8ebVuvpUnSmUquhleYZe98uInV4icdgIePXmVWILi82jPrUXQBQ/
         ilws+kvY6nKi6BJV9DCVANMQ61vZYqLMO57CPjC4HItZCAEopSQa0p7BOPfO0pcPwiPj
         KzWmYwQlN9vvzpk4WtVZ7YUOeNP4ClI25p/ySSAFDXaUCB+pfldt6N/BX3tBCHKswq6+
         lwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629591; x=1761234391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TWktSmOYD0YxtezmHYMgLXWGztB80rGJtdvycR/nII=;
        b=ADbml/Do4uPGFc+at26RC2EC9HHqlAgmalStQSmkbj7Oe0rZA7sE8LKUZUdJ7D5Jqu
         lK3P8Pvo9nhZZkjDXrA3ETklxjeHAWnqQJV2kbUMqsqxPPS1IqBgm+/PwddvOKq3Yyzm
         5sdoCUUf+kN642zlKnSbjY6Bt9PB9mCiv9/Qt6IjolbvFLw5vmxHswLYZ+G3IrAPR3Ot
         kSHI0eliZrNx6IpAmI6KNDy0TNULJ1m7wXkNK8aCqDN2RTWMjPdV5AfburJjnGs/3kKI
         kF0lsIM6NyC2A9ZHsgED3c8Hpu0n8CWZhxN73MM/woocJfKf2H6yQkAdvYobyAlfoZ7/
         eDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs9etCURnBS9uOBQq4vgYP/AEf+MJQHLbhPeEzPkNczPriBLx/YFVhypWQYQvEEQ3DTJferEcWbVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGdvX5m9Sbfi3a7MxxXhuHhShxC5Mgn+x15rEhykSnFmpx/VM
	oZGC3f0NGIZI3tXvUSqj4uOZRAgtiixh0E6nts6RCs+Hwq7O2M2FLHv0
X-Gm-Gg: ASbGncvfUEixSpt7D4jedYAd2JTVIEtkoYy5KUVvt2PwCV59AHDlm36gtxG9q9eFxFg
	tmZn1aQejkqxugveJjFNBzeQgnYJUiqtLubsy5sYGhU6eJercthQ6w4pCrYIVGguVFuyiVG/d7j
	AXVoVk5U5hLRGER2s18IX26r2NI1npdwW1CgQ9LvxHg1GLN2xBsXHQG7G4nNGNQ/n5DoWeRBrL6
	ZPBcKGGUKBtHzNHs+xlU5jt1GHhdPwBKd5brkTjIG/4U1kBuhR7z3paBRCSby+1+opTu+mvzTnt
	Kk55NWI4NW4MRKNQjmsjZh7KCmhvFYMVJJ6XnhTYwiTU3XliMEAEAhGYEmYIYETW7D8NmphQVx9
	gbrV6udavsrW0/YyeayH/N6Zq3E4eHziKU5cMAfcb87J6kVLpWdinAVDLWJpCPYkitU+Ev4OeWQ
	PA1oh4vIXULu00zXHqXYpBxMosLAv8
X-Google-Smtp-Source: AGHT+IGnqHL2OMLoVxnVXh78lstigDZESWT9J4TLCoo4obMWx1jVNLwRg34WrApclt+fzUU3eDNMKw==
X-Received: by 2002:aa7:df90:0:b0:631:bb4e:111a with SMTP id 4fb4d7f45d1cf-63c1f6dbea3mr228409a12.34.1760629590473;
        Thu, 16 Oct 2025 08:46:30 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c12279a54sm1237989a12.11.2025.10.16.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:46:30 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy.Paltsev@synopsys.com,
	Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Thu, 16 Oct 2025 18:46:24 +0300
Message-ID: <20251016154627.175796-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

This patch series improves the dw-axi-dmac driver in two areas:

Patch 1 simplifies the power management code by using modern kernel
macros and removing redundant wrapper functions, making the code more
maintainable and aligned with current kernel practices.

Patch 2 adds proper reset control support to ensure reliable
initialization and power management, handling resets during probe,
remove, and suspend/resume operations.

For debugging, I used dev_info from the suspend/resume functions.
Before pushing, I removed dev_info from the driver.

Suspend:
echo 0 > /sys/module/printk/parameters/console_suspend
echo mem > /sys/power/state
...
[  195.339311] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.350274] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
[  195.361223] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_suspend
...

Resume:
...
[  200.669945] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.680975] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
[  200.692108] dw_axi_dmac_platform 100NDA00.NDA-axi-dma: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c axi_dma_resume
...

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251012100002.2959213-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * https://lore.kernel.org/all/20251013150234.3200627-1-a.shimko.dev@gmail.com/T/#u
  v3:
    * add reset_control_deassert() to dw_remove() to have access to registers in
    case if reset has been asserted via suspend

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 73 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.43.0


