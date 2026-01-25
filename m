Return-Path: <dmaengine+bounces-8473-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AgqcAcx3dWnDFQEAu9opvQ
	(envelope-from <dmaengine+bounces-8473-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:54:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843D7F762
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B903B300A118
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93919D065;
	Sun, 25 Jan 2026 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7sZx4bd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D0185E4A
	for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769306054; cv=none; b=ugYcGksr2+z74rX3Dskp9Ctp/u/CATTShGceWIhV3X/Uua1TYLlvTz0acSFNqN31+W0bGnzu66f8GRrPmUN2rfQRt0k3uJdUsez6vgphgMTllgjokUzQrIsxkhpOo3tBlv46RviaGxJbtkghp6FWbcoBXVEKwF/py7bbNfIN4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769306054; c=relaxed/simple;
	bh=HQ3wzub+L/ifybYzm/GjD8OStEr2ofhILrOHtEPLYSk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Wsa2mP9RdRZz0sf6IFKWfjjcHzwlFX/M918qfHydLLhTdeswIES0/YAzACdn6SYaVu1TOOgjC5vbE7xbe5QPTeYXKw7jwWe+/bArUUd4Siyrwc9bN3lBCyMuiBSFJ3XKBLQ2/NGsEtXtQu+6Dm5opqpTHgPz0zkF8yhQlssKXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7sZx4bd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1883082a91.0
        for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 17:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769306053; x=1769910853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7chXvtueo/uKvm4DCuUzByiI3NqofSBosyRQenwLes=;
        b=E7sZx4bdXMVlixiCIrlXsOaFR9oC5ePUuuwE40fFqk+8H5bARocc9xUSxzpVvf8Ojc
         XP3S9uSlKPpwOnoJpRB7bK2nFt0STE8aFQELPS+IQHbvCa4wIvJ/vM7efGpY7R15V4FW
         ei6/+iYFLDeM4EY/L21BLG4h07ku8eA8NN1s2bKbGAlIb0fts9BOtvr1JEClvtNdp2Mo
         Min6GAH1Orqiy55WFTiG6Ymegj2dR2Q1O3WiL3f1TGINxxEMbUpSt/XJ+4lClhKZ2Toh
         sOzV97PrIqar9q896wjy3fTY5zatHeOe0MpS5RDuGgx++09WIFfn4fOzeHxiwPEQxqL9
         T0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769306053; x=1769910853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7chXvtueo/uKvm4DCuUzByiI3NqofSBosyRQenwLes=;
        b=kL9uw1d4AoYN24emkb6N9QyhA7+lopTYnPWUDKbuQ40PE0VPcoUjSNviH0CwtFvicC
         R3WsCq7Wotk2EJubrkJQsLtFj1zpvI9Kq9uqPu/iuKv3kuKQops24lb94lgv0YOpegrU
         ookWWYjOXFYEEeOSvWEvWxkzGBwzbd1+V526bTjy1fqet6vOSG4rk8jac2Lg3FUOhEus
         T2TgjdzJnVh3t39Mlp+hLY0XPk6J70tPPIn2JKAlYXwDgyIId0Z6Nimbvj0uyWKlrOPb
         LHtsmEuIA3SVHWFWiNqu+BlccjRttEfo3fK1TOLq5GPZfjV1lYmgof4DqSo9ULzuZvUH
         j7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWMRO6YOt2Q9sn+YtTqK+vo4HD3+YgXyWfBq5n8P+OxqOZ8C71WLffjwyvQJnmeNguBmy+J6dy8mpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+ItGHh7+E7Kb9qaDYKMy3ZVbG5XWmPWHTWaI96GAa28RuqBB
	WpgqplCauVUXIK/VK4ed/a0MdrQZ1czqjb0FJQSwBqsqK5P80TdG5MFv
X-Gm-Gg: AZuq6aJJUu5zyqyypcw/YgNwEXFlFcTZu7Rt8BBPDdooeLgHXGXSOaBz1EjnFzHMN9e
	GhPoFOB3Rm/Lj2nqbO7JmhbOpuKs2YaxYtvamxlQm8s+4kMQ4cSHxv2BXdK0J96zsNojOELdPIV
	s/T0qSpnipGv4jDbQ+SXEdYs0apZLt+BwGeRCvJYB9JOGVaI03FQZYgWvqEZKEquoyNXbkiOg3j
	ecuDt5PLQjNHyOJmUEioFpRDtnGFUTl0riWS3si398N5CmcxG5Y8xI4a+Qo2kV9Ylq5TK7dvBWe
	AnkbTwva5zX08k1BjqQJ4769MNDAb5/k8UmYdHy5747vA18Z6aelNZQvl68Vcd/OW169Z9/hRaa
	1dO62Qu1Mr6nuqO+Jrq0YFvK1gDdg16lrjV6/zWedSQIilsOguRMf51DQvu8XZRRBgtlnMWfPqk
	eZDu44A7biQGUNfNKJoudZTgbNdz1K6/LfUJQ=
X-Received: by 2002:a17:90b:1f88:b0:34c:37b8:db34 with SMTP id 98e67ed59e1d1-353c41a9f1fmr357977a91.32.1769306053045;
        Sat, 24 Jan 2026 17:54:13 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536b0300fcsm2689584a91.1.2026.01.24.17.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 17:54:12 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v4 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Date: Sun, 25 Jan 2026 09:54:04 +0800
Message-ID: <20260125015407.10544-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8473-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4843D7F762
X-Rspamd-Action: no action

This series contains a single patch that fixes minor coding style
issues in the Synopsys DesignWare AXI DMA Controller platform driver.

The changes are purely cosmetic:
- Adjust indentation of function arguments and debug messages
- Remove an unnecessary `return;` statement
- Add a blank line for readability between functions

These updates improve code readability and maintain consistency with
kernel coding style guidelines. No functional changes are introduced.

---
Notes:
This patch series is applied on dmaengine maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Changes in v4:
	- Improve the description on every patch.
	- Mentioned the commit the patches addressed.
Changes in v3:
	- Split into smaller patches based on warning type
Changes in v2:
	- Rebase on top of newer merge commit
v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
Khairul Anuar Romli (3):
  dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
  dmaengine: dw-axi-dmac: Add blank line after function
  dmaengine: dw-axi-dmac: Remove not useful void return function
    statements

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0


