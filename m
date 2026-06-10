Return-Path: <dmaengine+bounces-11408-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qodoDWW/KWq6cgMAu9opvQ
	(envelope-from <dmaengine+bounces-11408-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 21:47:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7966C930
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 21:47:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b="gIVE/1I6";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11408-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11408-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3130A300DEF0
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2B3446C0;
	Wed, 10 Jun 2026 19:47:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AC29BDBF;
	Wed, 10 Jun 2026 19:47:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120865; cv=none; b=LY1UaAigAVK4iCP7BEBCTWk+VdmeP4jjrFZujP5LVBsyYOpZRjW4+BxhkD9cxtqtie1bSQttY3FYlkGKBNLAdVivTv3AvQefhjluku/CPmnnNeYnehf/S/jyE8a7t1bSoN8/Dy5Xuc9q+lVav7u2jl2mL36w3OBfJubJx1VeFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120865; c=relaxed/simple;
	bh=jLniwTyLCa3Dv3Jd17GH9h5u4CQdQdqkgIABBCgQzKY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oRyZNUjYalLK4zAGZekjjsGcQNJ7It7dISk+B/Gj6amdPQBd5bDKqpyOK5c7RaCOKtUwsqV9j6aFRjwlJHFFq+L54ED9tDwEprU1dZ7mUVE5bsVZmjpqLtiBotO2BUDZoovJaHqdvw+QuSFqJH+5IeCg1CbGPI9GMDDQ6djjQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gIVE/1I6; arc=none smtp.client-ip=212.227.15.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781120856; x=1781725656; i=markus.elfring@web.de;
	bh=aJfpW8Qpi5M+NgXy5TVTeHJlqtwTQ6JGThRqEf3tzTk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gIVE/1I66qK3PCs5y651+mI9/fO9bNixbC7leAWdyikwzO+EXUSJXIAplAwy2evA
	 zbru/n5ORtotecvlqFq175uPDTBAaAFY+rBBkZwvnxllkMbrIYhcEOaAKQzkThk9z
	 xlZ9zNFpi9C2R5ZoN4EJei3TF+eH/R2Txsxfl+F+Af5C8GqU6NMimaFtdHpY0O9az
	 sq6KIUdtkKKNKDg18OqtpshQ0OoBVgoXewAri0VdfudiNDx9/SwMQAIAWG1zTFkdO
	 YJZ4tJpdo6QK969DhU4bRtf2couoVxkXqVeNk5NR93TJcYbNOg86WrWhKrbA6WjqX
	 WdehoYtTc/Ex8w+UYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmymp-1wyzl92Vwl-00q1n4; Wed, 10
 Jun 2026 21:47:36 +0200
Message-ID: <225b97d8-425c-46ea-bee2-df73753bca8c@web.de>
Date: Wed, 10 Jun 2026 21:47:35 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmaengine@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: ti: k3-udma: Use common error handling code in
 udma_prep_slave_sg_pkt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MiA8H5Md0wX+vyRFll2o6I7wllYYTT6mCSAuwCtvHoEsxSbAqzo
 ChogxE/rGK9tbpYb9YwlLmq5iFcXm6mfRu/Cmh3cGZ5q5UaUZp51l1a/sfH7OCAXBmTE1w3
 8m2ZEKclH9fP895aCEWBlLrhiEQslUGyargLA5PHgmsm2aXGl9q+U/N2Uanl4y5AfjEo7sD
 6g1J0aTc3KYZaJCTEv4KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+L9BtjbDJg4=;r1eQK6eDkm7tSNK/Sk8lhpquqJp
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11408-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6F7966C930

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 21:43:12 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of an if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/ti/k3-udma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1cf158eb7bdb..1ee779d73921 100644
=2D-- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3270,10 +3270,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct=
 scatterlist *sgl,
 		if (!hwdesc->cppi5_desc_vaddr) {
 			dev_err(uc->ud->dev,
 				"descriptor%d allocation failed\n", i);
-
-			udma_free_hwdesc(uc, d);
-			kfree(d);
-			return NULL;
+			goto free_hwdesc;
 		}
=20
 		d->residue +=3D sg_len;
@@ -3309,6 +3306,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct =
scatterlist *sgl,
 		dev_err(uc->ud->dev,
 			"%s: Transfer size %u is over the supported 4M range\n",
 			__func__, d->residue);
+free_hwdesc:
 		udma_free_hwdesc(uc, d);
 		kfree(d);
 		return NULL;
=2D-=20
2.54.0


