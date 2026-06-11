Return-Path: <dmaengine+bounces-11451-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ecKnCbpsKmqTpAMAu9opvQ
	(envelope-from <dmaengine+bounces-11451-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:07:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB066FB22
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11451-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11451-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53ED9322E9F1
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949E36F413;
	Thu, 11 Jun 2026 08:02:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B48346E6C;
	Thu, 11 Jun 2026 08:02:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164954; cv=none; b=rWwel29VJXlYvSswznIRJuS8BHL/KhX6mkChgcTRyFX/KzhfkwkczW8e6J+zhryA6dIZwdfEk/pCpa3U4trPpVrTKG1Yb8AS3gqzoDixsCHyUNUFmdlhYw9+/EM4ErI6WV77Pl2HQNUd/yylEdXNcO3LbDTpPLnBCb46YP65L8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164954; c=relaxed/simple;
	bh=d36X1M2+WFXjZ/fe9+lt+5rfBqoEbufZt5FXSojVHis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nr6H8s21bUKTHMG9hENY/En60LDg5B089V5xrXuaEbQPtumQ5KRQ6ZBnPVoWpUkSO/sdJ2GdwJ/ZpU/iPBkE3xcanA09a9h7y3rLdM0VOm7o+afaxhAdeM2DBHR6N8n3FqMsqhOuQ+J5i4zekYf3XjablYCzGFT4cvRHFgXasc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 99E1F1F00893;
	Thu, 11 Jun 2026 08:02:32 +0000 (UTC)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] dmaengine: Use named initializers for arrays of pci_device_id
Date: Thu, 11 Jun 2026 09:45:08 +0200
Message-ID: <cover.1781161455.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wvveo1hJouj5NUD1ONrzfSDsQHCNL3dUWGC5HWm8yvQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKmeFhzLPeza6aB0faKdOWAQZw+YdTKnVFKZjK GnUlighG/OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaipnhQAKCRCPgPtYfRL+ TjPDCAC46J2buav7B8yiPNls3t/phBMmry6qzxzg3XonfzCWsXIa+LV+e2p+ZJ7rItoxl+VUhf1 goIF8dw0TtTsOUVnVhpcrZn7z9FsY2Uy0mOLgVzhj7hKyI/FqRr0WtgGZyjaP2pr8JPxwOsjQnf 8NUKctZKg7OULoq7vxhtO3XRL9Rd2sHhHpLb20UD16xzkEG6mWAU1BpZuNGj5Qm6yBX+yt3Rsax yfXVQpTg9q2vfUO6SY5fEsRv7Qb3OgGpfmf1TKGEDkVeJQXNu4cnqGY1aRXTMrJcJJMBQP8YzQh bemEAaJrmBd06bNlSZLtPa25Jc2QTvQzke9ZdZL1NrFSfFoR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11451-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andy@kernel.org,m:vkoul@kernel.org,m:Basavaraj.Natikar@amd.com,m:mani@kernel.org,m:vireshk@kernel.org,m:ukleinek@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84DB066FB22

From: Uwe Kleine-König <ukleinek@kernel.org>

Hello,

(implicit) v1 of this series was only a single patch, it's archived at
https://lore.kernel.org/all/20260504102008.1996139-2-u.kleine-koenig@baylibre.com .

Andy criticised that the changes to the HSU driver don't fit to the
remaining stuff in that patch. So I put that change in a separate patch.

Andy also suggested to use the PCI_DEVICE_DATA(). I didn't implement that as we
don't agree about this being better. He likes it being compact, I don't like it
as it hides assignments in a macro that I prefer to be explicit.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  dmaengine: hsu: Drop unused platform driver data
  dmaengine: Consistently define pci_device_ids using named initializers

 drivers/dma/amd/ptdma/ptdma-pci.c  |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c |  2 +-
 drivers/dma/dw/pci.c               | 22 +++++++++++-----------
 drivers/dma/hsu/pci.c              |  4 ++--
 drivers/dma/pch_dma.c              | 26 +++++++++++++-------------
 5 files changed, 29 insertions(+), 29 deletions(-)


base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
-- 
2.47.3


