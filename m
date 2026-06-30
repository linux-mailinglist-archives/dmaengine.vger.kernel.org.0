Return-Path: <dmaengine+bounces-11891-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kA0AFebWQ2q5jwoAu9opvQ
	(envelope-from <dmaengine+bounces-11891-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 16:47:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70956E58D1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 16:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mzn2j9rO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11891-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11891-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F4D30AE633
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17CC373C1A;
	Tue, 30 Jun 2026 14:42:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339F34AB1D
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 14:42:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830539; cv=none; b=MOP5tUX+4sRMbV0LR4C5VLRu2qHZ4e1U5PxgoioxnF9h4qd1I4dtAD4lAOmvJbVcfSCU8MT1NB6niLnCKdQ4Okl3TRjPDA4zp6y4AULfuNaIUejTLFb4LXIlSZcc8V99Wh4OTmQ6vbsc9/AhaBvfOXmuptCY2FBQpuKxXdEkY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830539; c=relaxed/simple;
	bh=1fSIuyycGNehv4Bn/xKbNWxW7/B+1tyBBW8phrULOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c79V8IehxgQ5c8OB6aL/CF8v/sSE39l4cCIANSLl5kuT2yLHQZBbo3ppuL0aT7Z7T3fDXXxH2eGgfeysby/o5baN0c7izuNxST8ZFy0+VVC4aP2GGkDj1dM+qRcct0UjC6+E0ZglMVWMXYJxNcKmVndM9c+eENUGj7AXj9kllYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzn2j9rO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC261F000E9;
	Tue, 30 Jun 2026 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830538;
	bh=ghgY90btsL0a5rqrAqn2BdhEeKL4q+hGBjw6GxP/Kzo=;
	h=From:To:Cc:Subject:Date;
	b=Mzn2j9rOzWUZZ2cVk8icaYShEY3xYbkdjFth1i+jrZHOl+H9q7qdWskRvzF7GSS0i
	 f8F4UvXwdfiRMj+D7EEcX6ynRYgdIhe1h8R/DIjFdyxaNYYOo7z037J7+SCC9cHo8e
	 TSS+pLdPSu/KKoQuxuntopeqNVq4Nl+5O1zZ7Hezy8npwB8llON09htrMk3tHljH20
	 H9AgDy0jCRmBB9J1rOQwt+OVsLU1Y7jtD9+TcWo092sxp6dJouhRGfpB0vrHmbUzAi
	 QmTwNBZmtUGj/gkxH8yxYBrlR7rNgwDFkyIDkR/GDpvOfuOoLquKlXKW5njrFk9yap
	 CXLvkQROsuYeg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhenfa Qiu <qiuzhenfa@hisilicon.com>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
Date: Tue, 30 Jun 2026 17:42:14 +0300
Message-ID: <20260630144214.4080302-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11891-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wangzhou1@hisilicon.com,m:liulongfang@huawei.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:qiuzhenfa@hisilicon.com,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vz@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vz@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C70956E58D1

Out of memory situation on driver's probe is expected to be reported to
the driver's framework with a proper -ENOMEM error code.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/dma/hisi_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 28bf818f9aa6..c751a2e49e6d 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -983,7 +983,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, chan_num),
 				GFP_KERNEL);
 	if (!hdma_dev)
-		return -EINVAL;
+		return -ENOMEM;
 
 	hdma_dev->base = pcim_iomap_table(pdev)[PCI_BAR_2];
 	hdma_dev->pdev = pdev;
-- 
2.51.0


