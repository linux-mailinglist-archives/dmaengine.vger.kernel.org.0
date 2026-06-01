Return-Path: <dmaengine+bounces-11078-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCM6FlXUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11078-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:37:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E56187A4
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C9A301CCF0
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33193199949;
	Mon,  1 Jun 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNQn7RlP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341F135A53
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274174; cv=none; b=Ll1BtMU3ksKr7522DE+2WiUx+ttpWM3XCXMmAV1Gn+QDEl8dDqvIhhi1g7l42gZCbijLe7F27QnxCJA6u3vGlMCzAbZ3f6c/I7AMFD5srSRm4NHXXqTD9sfh+uNbLH2qHeyuHFT29Z4Kqp8WR6EkU4iQy4dMjzYmve8tZGBhuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274174; c=relaxed/simple;
	bh=hx410UHSdlgBtjJ9H09sx+B50T4kbh0WwKJI7BtUBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV8pe/2VgOC9hY9Rfsm2xgLvDSNDa4fP2iyPRmL/75RQ7n2f3BwNz7AF4Kjl45oVuLordow3FuGf4KFf5O6Tk7mGmtAEcwNGJsRtGqgj1SeOU9lL+Mss2iyal4PdCtyCuk4hRJ4HO5og3vx883Qs74sY5ug+k89DM56/dTh7rEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNQn7RlP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c35980fdso8319325ad.2
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274172; x=1780878972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=dNQn7RlP3PtQEZlRmGSPx/WZo/y8U68kVPvnveuJnSflkfIayFRBa2QoOXPrVDhdnq
         aa5UCbLqP0Bh+xr1nRur6A7moz/zd1CEqOJjTkjklXu+xHxAFmcnvx08HhL4XhxuIv9K
         OD7Me1g2RDiW+8r025EovUXGIGwNhIYgoSX0AMrwsXc4gUJM176u0yJKcxsIA1PT/R2X
         CjpAK84VNVRc/gwuC9ZnfFEuD1H4u+fG9B52LIs8xyRGxNsTdHogztv821ggbl9qd8tb
         RkqYnNswOZ0Lm+redcdOJR3H73DzqHUTKr+eUaUurVI3f1FLuIIuh0n5VlvHs8spmvDx
         lN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274172; x=1780878972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=dP0b5n37ekWex55CtRcX0t/18vBq0j1ppV+OQnohOSU2yB5NqEVmLgfGg7GI5GFjkc
         9gQ5TVQ0Xjop5B6ZRLyYycyWhCevFO23Z+1DSTbvGqe3b+crZYehNdR+6HRpfkbxMcnw
         La33s1v4O3gtZBBCJjp86sVt7bpF95w0j200ZM7oyIX7fSgjQwdF3QMbObokhoYUgg4T
         1hcnmImOvWXo3yPir6/QNYRffVtEw2t4P7gYhRUQzqV3urvE400Aee4j1qIESUBJZDqu
         27vj7Y7PlXC4eF6w3rPhsm7zcQFUGvOUa6S1cyP70cQy450mMS8Yk7lzIkm7DboAvtxp
         BM1A==
X-Gm-Message-State: AOJu0YzBKkNSOaAQlUpG2Qt4tPPShstXR8KQN8wx159Ss1dEGnX/9IJY
	e9ws2J1gZDq8Elo4K8qQ8nQnxa4Tqk19HoWUAgU3q3D8lHNSOYjWt/oCPrlfQg==
X-Gm-Gg: Acq92OGK9FFW4gxURo/rH+ius6a7qNfYgTMo0oYPO4eokgAccDM9ACZzUb/+0x+CX9x
	k3MWYYIby8AM/Sf/9dvrZB8VvJXA7S5egrC3mSjYfZbvgmeiCXSIPdGAXoTofD0as9AMUG5ctiC
	/MrOrYU/MGM0Kd4QFCU5mSEB3lLvsLHyn1aQu2f873ZcUhTKuna0fxUE88i0Ezqkefvg1jC2B9U
	jBWeWc9TVyeQjokoGnAzBHG3j3eB1m854o8bUkjZU/vzBQC7K+9IcGJYDE54LYqqyuiE3ucuFdv
	rxvtBExsB80fwVDyp0YwgYSVZQ0PigOsmhkoW+ISisz2NseaX3w/IHSpHjZX4wjM/qgfVX3qNGo
	BkWfW5HkDVojQLZ47R2EzHd7YiozpNKE3w3YTJ+uODfYBNfRvH+fmBU6OgG8nPfTEu47RTrKqxM
	W23J7rVu4G6id+yE+N5IdiFUTwjYVHqY/r3t3JRUyBFqG1j4fnF0XErn+9MReecHx0Oof9s871+
	esK6MER9cJ6QczMy5mpYH+BAPs/4l5TBwwtp4U5voRAOw==
X-Received: by 2002:a17:903:244e:b0:2c0:d097:51bb with SMTP id d9443c01a7336-2c0d0975539mr32384195ad.1.1780274171867;
        Sun, 31 May 2026 17:36:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/5] dmaengine: ti: omap-dma: fix missing return in probe error path
Date: Sun, 31 May 2026 17:35:49 -0700
Message-ID: <20260601003553.72573-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601003553.72573-1-rosenp@gmail.com>
References: <20260601003553.72573-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11078-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B1E56187A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If of_dma_controller_register() fails, the error path omits the return
statement, causing probe to continue (and eventually succeed) despite
the DMA controller not being registered. Add the missing return rc;.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..0f6dd6b0a301 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
+			return rc;
 		}
 	}
 
-- 
2.54.0


