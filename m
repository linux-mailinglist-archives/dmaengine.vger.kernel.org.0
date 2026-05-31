Return-Path: <dmaengine+bounces-11075-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEXQCEajHGrtQwkAu9opvQ
	(envelope-from <dmaengine+bounces-11075-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 23:08:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E0617F85
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9283020AA4
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857C36920C;
	Sun, 31 May 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+8qzsYi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B16351C04
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780261687; cv=none; b=WZwrNDkEZr+Zs01XJNQLifuygm//0dFBQN0jG3kjd2G8ceYR9fXrH/Fq+gID04MlAi3IBD0YIIS8o+dGYUOZFzbtVGqOQ4DWZm1BFp7Cz9I3xwsfPp0kiY+z2mzQCAthu9FijrR9mffKReoc2tfz+R+ibwA41YFyvrLMk2OgPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780261687; c=relaxed/simple;
	bh=2HRbvaDZK9BVEeVl1UP5SsQ2sfrtpB1oNY/Z/uphSwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nw29lgOAhDf+phNkHBJtBT96CCW+0/U7+K3+83uvGS2NKaeeHeNu7sppYHYcSci7xUKAPSBJnN4KuOL4U8FHNVCOIW7zljhRXnM4oUZQMB4GzEyyy9uVaC1/yeFt46F6KIk9fH4g8sfpJT3CGfwryfIHSh4xJ+/yj187t33LGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+8qzsYi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so500287b3a.1
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780261686; x=1780866486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzLqQR6G4kyvk+M7E6iPCt77xQ+4XBPvUj75BQ/swwo=;
        b=k+8qzsYiMfZ8pbn5SiyllrP3QgWDfKTnXX3OF0RonOwYMPSl1DRezh3O1VX9QSADrR
         1gyIVeI7/nhiYMcdBytiQeQNB0llNEAr6E1w9zZZJd4RLFacPA5Oyp0ZlW2/jgvS8i5q
         xYSkqzyg2Ny/LU8M4GnzHLP9qlxztjxKcPBxfiQT1QrjBgXoip5HksWL5YgB7fYaFD+S
         Ov5sm/tiADKkRX3iA5oq7/pvy2CIXCrMoFlcEOQrRTQYzg2z+6nLhBD3MHSFXbFy5s0G
         0cFnNl4JbBS5mwQ/u5K+HikomgcOi3gmDHr5j4gH3BZXrzob8Bokx6un7EgB3fFAwWM2
         CJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780261686; x=1780866486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzLqQR6G4kyvk+M7E6iPCt77xQ+4XBPvUj75BQ/swwo=;
        b=RVoegJJFPLF5kdo8x+zs3XUbK0eQ0bFRFJpqsu2adKuS6XdpHs9cyI2CFHW8kbsL6q
         c5Qnokj/9QQAzr5ySESVd6aW05KgWUurSuL8nZPbLkZnlrOrmbJH6C3LEn5FENxByCUu
         Spz0InvH7n5yeYJskn8SEIoyO/AN4h1tHrIu48QI+LnTb35p2yQHtWU6vCvGRtxqBeJH
         elySYeTyPjs55/jFEVzBeFD1g2mm2e7jLT3lq27/zKpwLheSBQOJotQP2Oz+AwXsg041
         ap6ttGzWMXx9pb+wCI8Lttiknr+vAMfxcjng/50tvkaB9FPUeONl5LqDz+MshWS6thEn
         WxgQ==
X-Gm-Message-State: AOJu0YwYzUO2Hd99QZfmwOm0SdWYWCbBzQfyhlJcPgNNNW6SeVzbz9vd
	3BXcTHmpAxHdbsVt+r3dh5lX7TXtH5W1AIxdg0wt6ae7PyIOXfsU3YsFq2xmww==
X-Gm-Gg: Acq92OEq2+9FGKmk5zcxC/MYgGKrm/DX7IMgFUVpV/JuVEJYnL+2G28+i3mlzwiZS9i
	2DKTJ52bJvHD//+cVaWf+oXPghGGUei8/YXZ0w+qJkeQ012kr/a9Gu/bKR9AQO9tWdj4Y/XjeIn
	kX3ezIasfTkx+/NpwrZJD2GE3Ev+ZMVcXQDTByWHQeGODuywVbcdKGURyb8A/DjeO+x4EVEGV6i
	PXYFEBVVZNVvXc0arQeQU0g9iyK6hF1U67g84k3Bfn4SlrjRk16BmDnN/MQp/nYs1HzlKrsc2gg
	vZahZuabYiCMx1lfOmjuNCSOMJFMaQWBC73hD/fcFeM6oQy0FcsJJRg7VBx1gelcuoTKDRPHNBI
	ugHSYZr4LHDcZ/ghBkKE/iTzCQaoKPHVjtwpk96iijpODFM8xUWy3HZi09shF0JUfIkXLfv390z
	E+YkzaKc0QMoiUYWszChalYu86JsfQAsE6Zb92e6u21ziXxa18QdCxPYUj1DnUkkKENKffDPc9i
	SJU5el0O/mAet3BUJHqWKVDWSaleaAhhbtcu7UBlttXKA==
X-Received: by 2002:a05:6a00:23d6:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-84210b3a471mr8981456b3a.19.1780261685744;
        Sun, 31 May 2026 14:08:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm4857400b3a.12.2026.05.31.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 14:08:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: ste_dma40: fix out-of-bounds access from D40_MEMCPY_MAX_CHANS
Date: Sun, 31 May 2026 14:07:47 -0700
Message-ID: <20260531210747.11401-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11075-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 793E0617F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

D40_MEMCPY_MAX_CHANS is defined as 8, but the dma40_memcpy_channels[]
array only has 6 elements. This mismatch causes an out-of-bounds
issue:

1. d40_of_probe() accepts up to 8 memcpy channels from DT
   (num_memcpy > D40_MEMCPY_MAX_CHANS allows 7-8), then writes them
   into the 6-element dma40_memcpy_channels[], corrupting adjacent
   stack memory.

Fix by defining D40_MEMCPY_MAX_CHANS as 6 to match the array size.

Fixes: a7dacb68b35a ("dmaengine: ste_dma40: Allow memcpy channels to be configured from DT")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0d9ffa3e2663..c45643b7f415 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -86,7 +86,7 @@ struct stedma40_platform_data {
 #define D40_ALLOC_PHY		BIT(30)
 #define D40_ALLOC_LOG_FREE	0
 
-#define D40_MEMCPY_MAX_CHANS	8
+#define D40_MEMCPY_MAX_CHANS	6
 
 /* Reserved event lines for memcpy only. */
 #define DB8500_DMA_MEMCPY_EV_0	51
-- 
2.54.0


