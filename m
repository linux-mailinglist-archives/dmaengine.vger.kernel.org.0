Return-Path: <dmaengine+bounces-11968-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /eFCLh9rRmomUAsAu9opvQ
	(envelope-from <dmaengine+bounces-11968-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:43:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB36F875C
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=puN9zfSn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11968-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11968-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5E963014661
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6554A3408;
	Thu,  2 Jul 2026 13:43:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F744A3404;
	Thu,  2 Jul 2026 13:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999814; cv=none; b=Tdmz1J1Uw+96D6/8pb0/erSEjJPjwq0J9Nh9dlCgHurZWxBO47NvVgKCpHbU2dD2oiUzezSWtpcTSJwCuPg5Kd2ijmjdhWe2zvzzdXGQ/8OhgHegl7LnH16syt/2JRzpY6KRBsQTE7rc2Xv08EvbzwTjqgn9OxErMnN74ikXeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999814; c=relaxed/simple;
	bh=3RRAGJ45DI3/d7faCnQEzBes1sMD0GozE0Iva04Bm/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pbsNPc6heDR4tYzBpGtSo5Nx8VZRIYuMpfA9kqY36gqec7fEaflvpdcw2TkWAEKGkWoKSlsU9ITHc4fUi+N7tN0Abip+KC3pRDy8t8X3uUHUwVW0pBSoxxp9/jV8fKAMZhVwpwnohrsvssGhWSdnnrCMhzZ7FaCQIwGaNGxpE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puN9zfSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61823C2BCC6;
	Thu,  2 Jul 2026 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782999814;
	bh=3RRAGJ45DI3/d7faCnQEzBes1sMD0GozE0Iva04Bm/g=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=puN9zfSn6UrOklH5SbCgtRQBtzuuE6JBE1/Vj4CibMnRnZ8rqJ7+30lGftIOjRjdx
	 4lXal+3Qe5N3voqGoAUOBXRb9sL+X30ZOI3o93fsw0+yZU2FNRy52ainkurSLLdZ2p
	 /hXkgGdiILRyt7RjIS7fNfqkcga5CpuCc+kGhhXIYbfWaqSFrJkQokYBH46QtMZlaC
	 z/anfZsEy0wBQqcfEdcRtqqbepQRFTEPZXUTyjFDpy2W8FJTYSoGZLtS2VOvsaIXdo
	 zwYbyn/u405p2evxurzCXLK40+mBclwHRUkgWurJpAJVXc+Cx1t2wtCPqoq0R5gV7H
	 FweyhKCvxoG3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D0C43458;
	Thu,  2 Jul 2026 13:43:34 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Date: Thu, 02 Jul 2026 15:43:29 +0200
Subject: [PATCH] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
X-B4-Tracking: v=1; b=H4sIAAFrRmoC/yXMQQqDMBBA0avIrB2IsbHiVcRF1ImdgjFkVATx7
 qZ2+Rb/nyAUmQSa7IRIOwsvPqHIMxg+1k+EPCaDVrpSb6VxC7JGsjP7CX0fnD0Y9wJVWb2oNMa
 62kCKQyTHxzNuu79l6780rL8bXNcN7C8/RnoAAAA=
X-Change-ID: 20260702-upstreaming-nbpfaxi-v1-0364e355af85
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Carpenter <error27@gmail.com>, christian.taedcke-oss@weidmueller.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Christian Taedcke <christian.taedcke@weidmueller.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782999813; l=1388;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=Y9B/MscRS+aViEQu67zlX3/v5KCJOOqQmYwRkuMIXkk=;
 b=TSvP0rZyf+DIpaVyWev2dPFYoKXBBM9HKVYYLQQ/m26InhmavFJeRlorKWP9ariFOgOeoXKdP
 jaI36yxRwSsCRZb3bRB0yOyasZQhjQv9fUkHfP2dM+/Fe18iLRjoSVZ
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
	TAGGED_FROM(0.00)[bounces-11968-lists,dmaengine=lfdr.de,christian.taedcke.weidmueller.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:error27@gmail.com,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:christian.taedcke@weidmueller.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,weidmueller.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[christian.taedcke@weidmueller.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BDB36F875C

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
 drivers/dma/nbpfaxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 05d7321629cc..74ff7bd979e2 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i < num_channels;
+			for (i = 0, chan = nbpf->chan; i < irqs;
 			     i++, chan++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-upstreaming-nbpfaxi-v1-0364e355af85

Best regards,
--  
Christian Taedcke <christian.taedcke@weidmueller.com>



