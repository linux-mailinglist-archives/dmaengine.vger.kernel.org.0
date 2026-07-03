Return-Path: <dmaengine+bounces-12018-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NLrsKBxuR2qzYAAAu9opvQ
	(envelope-from <dmaengine+bounces-12018-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:09:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F716FFE70
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:09:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=nhM+maWT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12018-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12018-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A99301E96B
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C47360EF0;
	Fri,  3 Jul 2026 07:56:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76602352010;
	Fri,  3 Jul 2026 07:56:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065390; cv=none; b=bKS0IFNCXR4w79Zoh4eYQngdaCUQxconAH2vCk2zP173r6a9gCQZD4YPk6ED4hRhXRXHMcdOkfwVEbeqjdjWXn5f3EFXKJqvLhVhOIgn4qcXufffbymiQgSWamWcncTD+gc7lWIqqFHYL5qTk2EpdKUGFKO0XKDlDrQa8XgnMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065390; c=relaxed/simple;
	bh=LKcOlov2N3SHTXapa/nmcCUUNrIagP3wwg5tJkgrfWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NMfqEWkiFT4tcX26bcORWYV9MWuk9AqFev+7jQsWcVb2uNmCqGoLLHopzUnXgckkJKONmpt1DrXCs95jIuaG/scan9M2LbazuznJWIFCa+xNvzigXGHUGKl7LPyQJpyrLLospUDlUvAkObyyTR8T2tBKwrXH5dtwm8OP551zADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhM+maWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F17ECC2BCB8;
	Fri,  3 Jul 2026 07:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783065390;
	bh=LKcOlov2N3SHTXapa/nmcCUUNrIagP3wwg5tJkgrfWY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nhM+maWTKUaMKAWfzOHz4ItAd5ZLx8PQFJ/IJgwso1JF5okfC0hOAQ6QDCo8Nbo/Y
	 uTwsEvv36QvCmd86xoXIk4YM/yrM6l8AZu+JfCcJ7WfuimHvHaJMzSW/LjyX01EUs4
	 vS69Aehc0ZETxfl3R++215UPbmHs5N9FPQomfyqD90ATh13TsmG6nedvIT17WrgWLX
	 d/hwTySzVlkn3W0U3YYjaRmPX/rYG3vUMx/yc24QOXu1YORWAwr61BLWBVLoSm97P8
	 AKSWEYGxu9z9ZOL6aFtTNB1zYn1ezM9UY6C0AVzzD3F9QtGbnu1tOJpRB6N+7TEhqe
	 YL2eTkP3eDylA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF348C43458;
	Fri,  3 Jul 2026 07:56:29 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Date: Fri, 03 Jul 2026 09:56:12 +0200
Subject: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
X-B4-Tracking: v=1; b=H4sIABtrR2oC/42NzQ7CIBAGX8VwFgPUUuLJ9zAeKCztmv4F2lrT9
 N2FevSgyV4m+XZmJQE8QiCXw0o8zBiw7yJkxwMxte4qoGgjE8GEZAUTdBrC6EG32FW0KwenF6Q
 zpyyTZ8jyXDuVk/g8eHC47OLb/cNhKh9gxmRLixrD2PvXXp552v2MxOPUWQVaqYwZ0NcnoG0na
 BrwJ9O3JKVm8Z9MRBlIK0teKC0K9S3btu0NT+qR4iEBAAA=
X-Change-ID: 20260702-upstreaming-nbpfaxi-v1-0364e355af85
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Carpenter <error27@gmail.com>, christian.taedcke-oss@weidmueller.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Christian Taedcke <christian.taedcke@weidmueller.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783065388; l=2324;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=AyxnLI/6ejAzATGLnoVUg8vFQg+Ck0fOd3H2NJ7M7M8=;
 b=hllzCXN0NijWy0Y1HV7Qfpucv5LSEaUdngpJMKNEDHtwPxaYQoFbfjggxY2WJDRoddmGxiwNK
 WXZO34LAmLsBLEGCGICTZR4ym3hh4s7bCYmM4CZL0Y5aZExoH7I7tMR
X-Developer-Key: i=christian.taedcke@weidmueller.com; a=ed25519;
 pk=fVCoBhFV3uMogA2nxIOU/rynNY+O2TDJgWvWjR06TrQ=
X-Endpoint-Received: by B4 Relay for
 christian.taedcke@weidmueller.com/20260702 with auth_id=847
X-Original-From: Christian Taedcke <christian.taedcke@weidmueller.com>
Reply-To: christian.taedcke@weidmueller.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12018-lists,dmaengine=lfdr.de,christian.taedcke.weidmueller.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:error27@gmail.com,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:christian.taedcke@weidmueller.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,weidmueller.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[christian.taedcke@weidmueller.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,weidmueller.com:replyto,weidmueller.com:mid,weidmueller.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04F716FFE70

From: Christian Taedcke <christian.taedcke@weidmueller.com>

When one irq is used for errors and each channel gets a dedicated irq,
the total number of irqs is num_channels + 1. If the error irq is not
the last entry in irqbuf[] but an earlier one, the loop assigning
per-channel irqs terminates one iteration too early and the last
channel is left without an irq.

Iterate over all collected irqs instead of num_channels so the
error-irq skip does not shorten the effective channel count.

Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
Changes in v3:
- Guard against out-of-bound writes to chan in case of an invalid eirq.
- Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com

Changes in v2:
- Advance chan only when assigning a real irq to fix out-of-bounds
  memory access.
- Remove now redundant ARRAY_SIZE(irqbuf) check.
- Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com

To: christian.taedcke-oss@weidmueller.com
To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/nbpfaxi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 05d7321629cc..b1f06f0bd0d5 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i < num_channels;
-			     i++, chan++) {
+			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
-					i++;
-				if (i >= ARRAY_SIZE(irqbuf))
+					continue;
+				if (chan >= nbpf->chan + num_channels)
 					return -EINVAL;
 				chan->irq = irqbuf[i];
+				chan++;
 			}
 		} else {
 			/* 2 IRQs and more than one channel */

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-upstreaming-nbpfaxi-v1-0364e355af85

Best regards,
--  
Christian Taedcke <christian.taedcke@weidmueller.com>



