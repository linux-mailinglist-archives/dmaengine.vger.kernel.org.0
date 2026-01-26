Return-Path: <dmaengine+bounces-8495-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK4uNs9Dd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8495-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:37:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BD87162
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D44A8300399B
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B7330B06;
	Mon, 26 Jan 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMoT4Sar"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB244694
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423820; cv=none; b=M6RwZ1q1fRPlUCfwb1IuODPzzMquHZZpPskshxtv1REixBNWpKJaY026iQgzKdKbuW7QUfFjUM2EZ2BcBpWTnDTt7pYK4MgptT1bE2W4crie2yxzMm56h2LC9sX/wQuqFoP7NE5XRVNeXSkLAQ9vsveVdJg28cySAnZ0muyazbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423820; c=relaxed/simple;
	bh=f7lxoxbY3x9854thhkZq/IOzMyp8JT/p5G8jDzb/eBM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jvyiy5DmtXVr87PNIclVJz3RxfLtMsFe/+DRnwEJNtOodgmOSGoYuqZ3qFeF3+vXnivBXkUGuGJPnHwaxkMxXEGmUBLOenw/orJgeM4eLfH4TA0G18Bvkd3MkRYssjLEHY2QOAc+MchpxaImBtwAEWKqF4VentDKLntKIF31yT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMoT4Sar; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7bced39cfso48622115ad.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769423818; x=1770028618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8eE0H1Ug3/M2+Ysmnh0jiU/RqWcPrEb5e9O9uOFt6ng=;
        b=GMoT4SarW9L0tChg4A+b54m2SgFBXGHxUvWjC/k9oxRYvggmf/XgBUdSZmPAjfCDME
         SMaMsBxmkbMXgfyvRIA3Kbqt5WFSOGBbhNaAgjUU1aNcx9rNwEvBoxPC/kjxbAZ3ZRew
         C45/qkpNwdM3Em1xPx47pmF8taSMW5DOrxlD1dj6IUa7eLBrghhJEk+kCwdMhr/Q2YmK
         ISbZI0De7BUxlyk8xqzSPE23kmGROzgbDz1W0lkziWn94XAgcdnYtaMN8XCCRZTK7twE
         ZmAV06IzoAgfuAMi/el1AbEBZHuV5ceW7NrNrWSSEaaG7DtnC+WV+m46+C+Ay+UiZ2px
         Kb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423818; x=1770028618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eE0H1Ug3/M2+Ysmnh0jiU/RqWcPrEb5e9O9uOFt6ng=;
        b=eHx86i8lXcRp7nOQZXyVq63AFQ0IFpDcPbiQ3W+hAAcPSqHWCzrNps0xMDVhB+TYT/
         /AA+maF5pVBo9/WlOPjqS5GCf/e3XB0HLF9xhRw3OGuRtoPVk/JzwD+F504UO0627ZK+
         PWu2r2MABgRbQWgVv53wMVVvQqK+iYIXeX+7Bt0ZowOfvwZmBxvQdAWnOQ4Dl9c3JjOz
         qSqh0Vs2d2t8KdYEZvLqgIPQlXasXk57d7Zm469hdGcvXLfuNIALz+qznB2cV4DUYuHo
         VWWq4GvFYHh7wsAT9FWdja2ElryA3r/MKOTtP4HfWp0vwzJeInuSu+noV8yjDwOtC58T
         lTOg==
X-Forwarded-Encrypted: i=1; AJvYcCUBzVuS/qDLfM/aJypo1HtWCCDQnfFH/w4e3rHR/0jv1HxbGeN4q+b6kcnjEcWb/akZezA3TCxvgaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCvpPNQeSqJTHTnISRQaUraikejvHdHLuhBDhjELbxpG5ZxPR
	bGu5456URPRTPvlSVEY3Lmc6fduRalso4jR1HNwweipqk/6g2ezmFZxx
X-Gm-Gg: AZuq6aKzJNLllN4uxIFHbefwWKPeFI5TaZQoe+lkE4qvdWGtdzI/hPB+mSJKiliiC4z
	Iab6IvulThA4LvetOYwtR4WGXAsd1hsvcshRuTE6F/C3b7TL+EaYIy0XyUpMDf0ilcjiDiWexbN
	C7Rj74ZsvwAqseYXHFrwDqoXAVA8jgN0OdIro/b6DBEA0uFq2Y391gkSTHmL14W2I1e0JIG550K
	jSA1/YnSISDv36uWXQevRh6X2Q+k/GGuB8ZfwNv31G899E8M+ibpO0o7kH9U+cZfVbPQr4ip7Zw
	MoqMRNz+/qJupeD8UuNaCad+fn7KkuQqNHM624op7HyLqiDKQ2pirHRLSH+OuCFktJUr5PnH8T0
	17Sgd1efQpUMQuw7ZhzH7P73HcYHQbFxBizsf4zN5GICqv/hSCAOAxX9sePWMCVj8SsCChRW20M
	MNANEzO4NW3CThS5fso4rSZPKVjxlWr4IQz/0=
X-Received: by 2002:a17:903:238b:b0:2a0:b02b:2114 with SMTP id d9443c01a7336-2a8451f9ef2mr37753385ad.11.1769423818056;
        Mon, 26 Jan 2026 02:36:58 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f9762esm86827545ad.55.2026.01.26.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:36:57 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v5 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Date: Mon, 26 Jan 2026 18:36:29 +0800
Message-ID: <20260126103652.5033-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8495-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 791BD87162
X-Rspamd-Action: no action

This series contains a single patch that fixes minor coding style issues in
the Synopsys DesignWare AXI DMA Controller platform driver. This adjustment
possibilities were detected with the help of the analysis tool
“checkpatch.pl".

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

Changes in v5:
	- Refine the commit message of each patch to mention the use of
          checkpatch.pl analysis tool for the fix.
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


