Return-Path: <dmaengine+bounces-11182-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hyyZNGWUImr9aQEAu9opvQ
	(envelope-from <dmaengine+bounces-11182-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 11:18:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C3646CA1
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 11:18:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=h6AqytLy;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11182-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11182-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C19230214ED
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29C4B8DE5;
	Fri,  5 Jun 2026 09:05:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC24B8DEB;
	Fri,  5 Jun 2026 09:04:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650301; cv=none; b=ftZ4hdJHzSuikIeSL6foJEcxk/9ZFrwWKowHGL77nxw6HCL4BVCkbGsrCo9jawEAXY2jrjy/EUMovsdc8orZlCOqESZ4A8AYbvY2ssaGxcDprpqXETn55IyNjOmbwCMmER+RPmk1LHrIhDTGSGHirly9SJ6nWcVuBfjMyC5nSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650301; c=relaxed/simple;
	bh=itExg1VT1YVkEOvMBMn+Jdc+WLVpBG+pdYHqtBf+0nM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h9SeuQvT22/rYsNtYtwvVnVKbHue/2Desxa5MiuVZ27MpTH015HQmXWUnDgDbx5cPhTb2aW/qH6szcbW8WEqQYmb1zf9eJ8uF08gXSbNigrhsL8X6ZLD/nkx/F+u9cEbr+kWod+FWL/FmlQywpW1JnQDZFMVQKl6v6mNYQTLtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h6AqytLy; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780650291; x=1781255091; i=markus.elfring@web.de;
	bh=9jyIbFPAHQytYHH+WH7syznGJK8nTnZehpXlIDR5Uo4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h6AqytLyBuGtKXPzoF7fjS9xXw/k2AFBB3G8nglpBvhkdRSQaBDr2q1RjWWivEBi
	 pZrGSSaDvBYYW3ZTrq7Rzq4AcMfQpEBODVazyNmTUGnzZrpl2gNtHp+AyhDWJk9/y
	 9smYitVW2/ZchG0AIgPrkYoykH/xHW0IaGLmkp/nXPa4rifE1/BXvvMVoRipoWVF3
	 0Kpa3PIatvhsvsMpMkq/IM91mi1H25qZ44Dzc4gDkQjoxwp1X2dW47AgJw0i/8ox/
	 2HrvlSZwldCf24iX6a5zyGdasSCJo3HFAwCeSYnZmw1jkksLPH1pTBRM426MfS0Cs
	 GWu6QDn8GSe4velQyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUlDP-1webQp3lVx-00Ib6W; Fri, 05
 Jun 2026 11:04:50 +0200
Message-ID: <42c86c97-9476-4a4c-a831-9ae28d77bdcb@web.de>
Date: Fri, 5 Jun 2026 11:04:36 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmaengine@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Frank Li <Frank.Li@kernel.org>, Vinod Koul <vkoul@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: ptdma: Omit two seq_puts() calls in
 pt_debugfs_info_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Efs8bBQZwQpS5Uwhz8Ei2rghmOCQYBMv1RFoo9FShUR/RQfretX
 Ule1Djf2c6NvDv2DHjgdOFD8LvLLB04+5b6fiagXSOkHnrzDyNje/Xcbkzd3GkGpkZH1b2n
 0YXjFysbg76y85Ouz3KJUTF3hXFgX+zi/UvsDn6WquttKl7uJHdQmhFGShu2+C5lgESrQ9A
 mv6qBHSm1SAXke8jYpBRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nJdsarBAF3g=;qYNpe6DcksHWhhjFH3TZlyBNxEG
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:Basavaraj.Natikar@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11182-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B5C3646CA1

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 10:55:59 +0200

Move data from two seq_puts() calls to a subsequent seq_printf() call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma=
/ptdma-debugfs.c
index c7c90bbf6fd8..6323e27a6f0c 100644
=2D-- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -41,9 +41,8 @@ static int pt_debugfs_info_show(struct seq_file *s, void=
 *p)
 	regval =3D ioread32(pt->io_regs + CMD_PT_VERSION);
=20
 	seq_printf(s, "    Version: %d\n", regval & RI_VERSION_NUM);
-	seq_puts(s, "    Engines:");
-	seq_puts(s, "\n");
-	seq_printf(s, "     Queues: %d\n", (regval & RI_NUM_VQM) >> RI_NVQM_SHIF=
T);
+	seq_printf(s, "    Engines:\n     Queues: %d\n",
+		   (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
=20
 	return 0;
 }
=2D-=20
2.54.0


