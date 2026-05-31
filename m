Return-Path: <dmaengine+bounces-11064-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHjWBxeYG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11064-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0831614357
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B4E303D357
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64C363C45;
	Sun, 31 May 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBqfiYaq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C47360EFA
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193159; cv=none; b=EBAKX+2jNYfBZzOBHVhuuQj2XCKw/x++7b4VTOubyNFm/ChpQQXBqXIugEyvDsisfV3gmPf0S0tUDoxAGFqfSb5aRyEwnM6/F+HxvXkF0jsrVQ7gp0iNo0aJk6UN58ZnmoGgIhRK0Jlf1q1TxiyCX0PbZpuyJaK8DYHWA5PMBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193159; c=relaxed/simple;
	bh=hx410UHSdlgBtjJ9H09sx+B50T4kbh0WwKJI7BtUBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+CIDS/haNlzacbr0rDRZqm/+OMRQsny4Z9xh02xTkQQvCCf8ICHPwF54uwiJYfSjiYV8EGWhAXUN9T7M9+wtDI+xOlo8u1TQ27x8KoZTePOLRnxT/d9LNbetX1UZhX3rYeQq93m8Qu948m5/lUe/Z00iAG5QFFs528+fX8/ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBqfiYaq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914bfa75911so958536785a.1
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193157; x=1780797957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=OBqfiYaqU0iP+4aNyA78RWim8fQyGCq9UTG7B+W5qs4U1kUtEqydL10F3GpKIvM58b
         FnHXC4LZHiIRE7droMY2iEv537jr0aVDX9mcJmbQbqKVE0RQFfVmrmkdDA7FzPBjoF76
         bP4iyKNHYkFRh7S2cB5ziMvKDLpxZ/QBYjjHFIQHPrOL3PWuicNqoMPExKuGclt0pCSZ
         MvDTC3M98ZwTZkmTKPb0kzj0d/rrm0B4kcgwBEC/r9fuS7WjXUhVN3rO5+crAQxTq43D
         gdBDNyDaQ77DK6Tq4s0eihRha5k/i3HMFLyZTGRbgtgRisKEHvXQ5qCMdd3OsP4/W3AK
         B5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193157; x=1780797957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=dW3OA2v1+SJ5UUZfLaHkJa9U2wnMOXyL4ZjJEZiaTE1WC/+hg4t0qP5RrVASiD0WD9
         logEob8efC03rb+9g3x68ReDemOKNuhlVzmvABz2L4X6idpcBDbEW0/mofPDYPSzPuNv
         wlILjzyB6+z3d8VmRd9Ew6p2zyQC4qLCzb9PF4huiij8T1yct6As4Wp46IbGj9KC1+t7
         0oQ/zBNzHqEABKAPU3HV+NsBF1NZth7gjvbz7GlGfI22ujS74aZa6OimV5xK6pWJeDWx
         I2GiJE/Jh9B+aYoc3T9jzhwoRhWk4xlx7xEafmYiHuzlP+F1RmQkT6Fv5Ic3LpfZ9366
         ZE0Q==
X-Gm-Message-State: AOJu0YyvXePuvKT/ZoN6PAOQFr0Y7G13G/ezDEV/83cPSRIdjA4Rta+d
	c62Oq50GkjYH46FtC5ruTU6UI/GGJoa0w+6Z6sipWp76s2nGlnEeQ8srB7s83dQy
X-Gm-Gg: Acq92OHG+MMs8IP4sX6hTS3kC6ZQneHl6HpvkMylEhEGQiTKuHBBB0WvEoVHCKfIkO4
	zNcciiMa88kSUxqFCP119WaQ+no2w3jAX0VjOkXGGlxvF9J1fTsQAKSKk4ugKBjJ/g1f2asZ444
	GMQOVHgzyM8ZB+9a5v/1C2zjteHEacyzJUEfzEtrtxLOpTz0271zTdrZFB6iIamrcV4PnPKyph7
	2uSj0Xx/rjFnbPpHG2vdIexaGnmFeIENi4L4PyoubY4J+YEGhwMQF6E9xzD/LhT+eYsSPrvfRc/
	/UjF0ArlhtYfz6a7RWRr416v9Fdza4YEaplKxDrazGxl1ZvVzinry4uzzjO4zfRF5l+y8si/Vwo
	VtSGqq1JWMjbnDu0WVvisPpNGvMw2uwYa3dz0zFV556hqoADWGI2rUWxUshiokHCLw/3HuOprwf
	3i5KVTLRi4I3+1PenXJUV8ytF7bc6HSbkd3UnPGxYEaUNNRicO3TN6xg1JUKsXP4iJnQ7Lu/thv
	m8aa/ZJcld2iM1jtraTax+s5USdMm78OayAm4oMGqLIEQ==
X-Received: by 2002:a05:620a:28d2:b0:912:5d2a:4bd1 with SMTP id af79cd13be357-9152fa2f46bmr1103657385a.40.1780193157311;
        Sat, 30 May 2026 19:05:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324745cfsm620246285a.12.2026.05.30.19.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:05:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] dmaengine: ti: omap-dma: fix missing return in probe error path
Date: Sat, 30 May 2026 19:05:32 -0700
Message-ID: <20260531020535.594460-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531020535.594460-1-rosenp@gmail.com>
References: <20260531020535.594460-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11064-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0831614357
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


