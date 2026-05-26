Return-Path: <dmaengine+bounces-10892-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJGZOh86FWpETwcAu9opvQ
	(envelope-from <dmaengine+bounces-10892-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:13:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BC5D11D4
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24B23008446
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 06:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F13BFAEF;
	Tue, 26 May 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="AHaq0/gf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AB3C0602;
	Tue, 26 May 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776026; cv=none; b=IsO+tAwsWsqMNUAa7Fq1m5euS9Do+u0eq/mFxxphBpt5UhJ+JB/5r+d5EfMc48B6ihzj3lGiGRyXONlr7DLfZNtG/TTeK3+qdESzqZ4YTFE7PHNl5ey/7vaD45DuH1abvjmDObPxM8J53xvz2lZA5nIKEwz3VuhMzmIhmptesu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776026; c=relaxed/simple;
	bh=UWoMs7WVQoGSmSi/0rQmo0+uN8uahYwGCaHIi35TQC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvKi7/Uil2G2/nR6SyMaxr8B+91XGl8ZIOMtu5zpMbhLUqNbnbebvFyGNvKTEX/AoVNs9v9VxRlOCWfzrNZCBYyQrtqqi0avkVS7zatN+noAzqi5Y+INNJLSEIF+UwY5BDrVJVyJb9rZu/Owb7uNEyEAm6Y4yRiz0/b6KpvcgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=AHaq0/gf; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=UWoMs7WVQoGS
	mSi/0rQmo0+uN8uahYwGCaHIi35TQC0=; h=references:in-reply-to:date:
	subject:to:from; d=al2klimov.de; b=AHaq0/gfH4b8fmrwIfZg5uWHptFmWY0/PpC
	Ey4HCWA9k2Ddesv1FsZBCyHcTBu6NIeRSykSbVV8kwDpcxl/9C47I6m+mZbo+5eKHhAcrY
	Mqmi52F6yRJg3+cwMtdr+DOJuivgb0gi3NLDOrY8TGBCZe0zFct1p1VowqIvHYHc/6nlZ3
	T/the8nczEwKnQdqagmen/3+Na+noV+OA91SpWDXGypxUyedAHySgC2DQgDKejgX4So4V2
	sTGTnVIgoX2JgD0fcHhesu3yx/M3Sr6ajTMgsAGDVY1niBSSpDcTPXmn4vJUwr7WRJdoLl
	dfhT80qsF/Wdn5wghElTxlee5sw==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id b5769de9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 26 May 2026 06:13:40 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Ujjal Singh <ujjal.singh@intel.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: ioatdma: use !kstrtoint(), not sscanf()!=-1
Date: Tue, 26 May 2026 08:13:14 +0200
Message-ID: <20260526061321.6123-3-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526061321.6123-1-grandmaster@al2klimov.de>
References: <20260526061321.6123-1-grandmaster@al2klimov.de>
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
	DMARC_POLICY_ALLOW(-0.50)[al2klimov.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[al2klimov.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10892-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[al2klimov.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grandmaster@al2klimov.de,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,al2klimov.de:email,al2klimov.de:mid,al2klimov.de:dkim]
X-Rspamd-Queue-Id: DC2BC5D11D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Depending on the user input, sscanf() may return 0 for 0 success.
But intr_coalesce_store() wants sscanf() to parse one number,
so expect 1 from sscanf(), not any int except -1.

While on it, fix typo in %du by using just %d,
as this interface expects %d or %d\n.
Latter made scripts/checkpatch.pl complain,
so use kstrtoint() instead of sscanf().

Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/dma/ioat/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..f59df569956a 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -144,7 +144,7 @@ size_t count)
 	int intr_coalesce = 0;
 	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
 
-	if (sscanf(page, "%du", &intr_coalesce) != -1) {
+	if (!kstrtoint(page, 10, &intr_coalesce)) {
 		if ((intr_coalesce < 0) ||
 		    (intr_coalesce > IOAT_INTRDELAY_MASK))
 			return -EINVAL;
-- 
2.54.0


