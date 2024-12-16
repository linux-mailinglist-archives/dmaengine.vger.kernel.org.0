Return-Path: <dmaengine+bounces-3970-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA59F294D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 05:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BC1885537
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2013D516;
	Mon, 16 Dec 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="BhyM9mo9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C593A41
	for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323521; cv=none; b=CtB98nBTuwXwshnXYzoGGtGrqL1jtVUHnTWGkskr+iATe7cDh4pNTerzQJqndsLq916agQhtOdOk1j8JtnrVVls5jDZI+UDRIn0VSkLq4pF3HEFUysF/km+AjR5L64GzJMZC4HzqnLoEjsuPLq76wuKMrLSP0tjLTutRMzrg73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323521; c=relaxed/simple;
	bh=DAjkgAiTbYc0f5ZpK6lavHKalEemfrTsv9xtzZ5GRtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mk1iM/UJ2I+Cea11R9yQTZydJjW3bKb7R+PHFrL8uNTWLfGnnJ03VxG25n8C69hCnSlwlj6UfNbjzxfccHwXO3MLI4ngO5ALBN53Kq7p24xgsaPwh3V/IKmbx8Y187BwumKYfSXOU7YUi6RBZJ0bkjrNbY/l5IEi8qslY5+0E+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=BhyM9mo9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3267989a91.1
        for <dmaengine@vger.kernel.org>; Sun, 15 Dec 2024 20:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734323519; x=1734928319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQE+i3VJtOjYL/tRnAskwKhkCH8QJn6lrn6bmgtafQw=;
        b=BhyM9mo9I79lJRXeG4e+ZQS2oQRsjZ2gZCXO5yQjahQQFA3pNujYOYHIx+yjtMUZA9
         i6OJAqbVmYo1dllZDVTAG9EpOBulH97mnGu1JM9gpZZI1gsIKwJm4IfyDrx3bJr9B5sT
         XKRn2mc4YEO4Jz2hPdtqqetQ61FvDeAZqYgWKIIlYu53oRH47fI3IEzVxAUul+ek+YzA
         PqVeziGtI18RXNv4xxzRHQMJ0qIAnxVkyr1liqk3u8endYtnwXqGyHAWaft+u8tJlier
         m/FRSFupXTHEN3a+0YwyCdIMfY9+Nkc4UPKVsZ9xKqi+aOPL1IFAJdTB3/E/IiMiqAxn
         J+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734323519; x=1734928319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQE+i3VJtOjYL/tRnAskwKhkCH8QJn6lrn6bmgtafQw=;
        b=bbFGhPWxvQsB9804eGFSzb2eQvxBy5lZWQxh/3Lzf10kU4Q1lcJnaO4p9q2iqr0PWg
         53TGdtvCPoo36bIGYUeKVHx0vbULsQNMtPraafTHoHZ/SPo0R9OkMxbaHyEOuc+muL67
         05EPNR4QoBvPgcim+T4nMJnt/czMuDtLwowuMr9P8M5rUyVwFgwe4eGhy4hnBeXO/eqL
         q6+cSM4i39eZgBubC/xsnbT3m9cotaqgjm1RzZp000Fz77OT8NCZHoc1hhpLw2sKvEeM
         ALl+vxSSjCJsK4OFPwgRoPdx2cXvY0frRJ8WIVffnQ+PTgMVrq5t7GOwGQs6dIa+00EF
         akVg==
X-Gm-Message-State: AOJu0YxB+W8/le0JaSG7ux6aAazbejRyfNg6FZAjE8bkP+ykeKQWlbHd
	PAiPPU8YLACIEQq25aAIfTpNnfLGF2og3ypQWJ6cg4QkYJB107pYk8h1bBRtk5s=
X-Gm-Gg: ASbGnct3M6jnZCV/4WKYXtm7NZ3OPmNYold1pIsyzqo5LVGFijE/nE+NCt6q0BuGS7s
	m3uPqHXGaLp90QISnZIrXGo5AGYQMKFBTyIxVTCcyNZBHn+3xrflgn86WKdFcmwQcXATrSa07hs
	iiedMd+Kc2qY6LiUXCEL4oie6wPYkV0XQEkH86nRE8TyTwyXSoR6GTfW37bB2VJOIf8WvlgC+Ay
	Ld6kOq3EaGdcoVKkJcglFNBKI5whMg5QyX/otuLPtBZdklkz5woUDmgXEIwlmG3dQ9kUdb9BXrq
	W3ei
X-Google-Smtp-Source: AGHT+IFZwMdNA4dFqE55CscXK7Bk7G6P1PUx07tgp5obaY/qBwswLnc49lgKN6njm6GPhm1Yyksd+w==
X-Received: by 2002:a17:90b:4b01:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f28fb6effcmr18518889a91.15.1734323519495;
        Sun, 15 Dec 2024 20:31:59 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:11b4:f79d:62a5:8fff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e80a35sm3679831a91.4.2024.12.15.20.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:31:59 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] dmaengine: mv_xor: use for_each_child_of_node_scoped to avoid reference leak
Date: Mon, 16 Dec 2024 13:31:47 +0900
Message-Id: <20241216043147.503192-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of mv_xor_probe() leaks OF node references
obtained in for_each_child_of_node. Avoid this by switching to
for_each_child_of_node_scoped.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: f7d12ef53ddf ("dma: mv_xor: add Device Tree binding")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/dma/mv_xor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 43efce77bb57..fa6e4646fdc2 100644
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
-- 
2.34.1


