Return-Path: <dmaengine+bounces-11452-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7sz7FtRsKmqYpAMAu9opvQ
	(envelope-from <dmaengine+bounces-11452-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:07:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B564966FB2D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:07:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=LFMlJFqL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11452-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11452-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02DF73097EAE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464E2BE621;
	Thu, 11 Jun 2026 08:02:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81312370D52
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 08:02:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164959; cv=none; b=WRsCuwQgS7q9+yXr7j6JAIL+PKrne/CiVhQlqlJvgJrIOEbIVwFoN5GzNe2jOXZM1e1eQHCXH0RpXmWotCcW3i+NL/ah6fSY8Ik5wiEZRwEgpb2sWCxAwWcEDFq09Y13dtSduNn5s8r4hu8EMNWzPbhshzkbUVWJAHjdoLWzuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164959; c=relaxed/simple;
	bh=Zrm+oZDs3ZbFiWC0WQ2HtqPbBFIJZ2JRH8RomEI+Vm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4iQw5RM11gL4OUSU+qeQD9oLK4vQ2uOwS9bqBLEgK+RNo6dYSAdDVk2i6Zi2j5HyCRxlpG49l6pF44x5JcSdS54D1c5gS1s/qIky8DWmsN2hykHy2KzRuyGo0z0m5AdWJGkZjmpmDBA80/cHy4+EmCFbioOgR+1N8pfzXj/pdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LFMlJFqL; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46066e640easo279400f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781164956; x=1781769756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioGPONC0PtdfREiNCw5+gRRkbJ8CSiYqx/5Fs1awRNk=;
        b=LFMlJFqLozGGnMYDRmW7b0Zk8COdVvaYl6FFNec4+O+gqWn21NH+F0yP/P2CZuM4OT
         rCOKHyrF/CQCZ9nUF+IKne33LDDAmjUXa+NXph8XDBExEySG012BvYIfW4DrksYBcTkh
         E+GfFTzakqfFN5CYJx5/tlZJIFiQcaMAL1Vx996rTusiH/buO3vTsHgdAaz8JJ0uP9LY
         2o9RU5nEMAUtsxiOubXctiPHb/KVmtt0j7CQuj0a+d+weRK3jDEAkzUBMKPlpkiusvxJ
         eDHeZ1LLlr0FGxPcCn/XY0wIB52oehFIfh6vJkTb1d6FWiaDfWJmwyNQdRZTk0ReUvKV
         8pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164956; x=1781769756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ioGPONC0PtdfREiNCw5+gRRkbJ8CSiYqx/5Fs1awRNk=;
        b=ly3oow62bAiob2WCvaAPiKPUHPBpzw+sqbDjGy8gkrcmz4kS3IP5OTxwpYXXUkPdGf
         oJ1TxKG/1+IkM+w+eCZo6rcFmc+lLo3fu8G0U+rJs9K5tOsZBZvE5E9sGGzWgzq4MJsT
         1DMs0yU0qZk26IssyUmXZX+HSh0uXYvlac+TjVcI5MOMy3oqYPqc58X6/PC61SxT8zWS
         rSsuuFCjFx7UXCmoEDVtsF58j2nqlEc6DC44cGAlNr4xlW8bR9MvLtu8C9fwGAFfVfF7
         t5KHXdbrHT6EclE2Ld6QYzXT7PJZNVRkeT/OImFj43T8B7ffNw7ZnRjKPkm75nhn6Jcu
         xwFA==
X-Forwarded-Encrypted: i=1; AFNElJ/kMeVus96/oY5ntzSta2JAtBEJKMJ844vTbDmfduT1drnA5AwqQUeyJeH4uFB3or9rfiGOfwlb1Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5alBbVKMRgbquoE3EQFDLrLIVwJuddLnsWZrcqg5wesduv8K
	EEtVEa2lMIYqaCxd2GExCoe6ws6grRREXwsytvFolXVNr2G0v4GOdrpAXMdyYFdvLV8BG3LOMTj
	Qu8/udPo=
X-Gm-Gg: Acq92OGxC8EepSFXeJurSXO0xMoFwxI/ROZKqDrNfBnASuihAV8n3frNW5bdq3DaVQg
	B4LQ6XIo89UG8qvw92+OAGqqcA28C6zIUtWNkudUKAljfLRhIup3g5Zvkse7iVzocxjIJTZ9LJq
	Pw23oxpLbx48dhwLpT3BSnp49XTIf0MYcRW73KxtyeKUK/siQO6gv+CJAwdNuYeZ3YsR8CNVPB0
	eOTZhkVdxI+UOS9iD0AtX94LBcFAqciO+GDoapFmSIKaYmUoVxFooin2MVppRNacxlhUM7qpe3s
	5GZvIKsTGloNgEhR6z8/JrgRDgRyjGB8utconh82y5wyjLZnKKTcZP76xeXtTVdfz7VHceHJS7k
	0djkjQFnp8q5eeYQuv+CbyOnj9SRczUS1CRM+g9GadhlIKgWAUYdBdPsiGcWzzYrqyqmisFyPZM
	Wy92FPV6OxXVzE6kumiFOiW8bxdMD3JsTQG3pOOwE=
X-Received: by 2002:a5d:5989:0:b0:45e:945b:276 with SMTP id ffacd0b85a97d-460677cabdemr2223747f8f.20.1781164955750;
        Thu, 11 Jun 2026 01:02:35 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcae2sm84444961f8f.6.2026.06.11.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:02:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: hsu: Drop unused platform driver data
Date: Thu, 11 Jun 2026 09:45:09 +0200
Message-ID:  <86a23025da12369034dc7444f43a7763f2e515fb.1781161455.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781161455.git.ukleinek@kernel.org>
References: <cover.1781161455.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Zrm+oZDs3ZbFiWC0WQ2HtqPbBFIJZ2JRH8RomEI+Vm4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKmeI57kLdGlex/iJRkMRiWIRkzwQYQOKL+lyW bk3TmXGxZOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaipniAAKCRCPgPtYfRL+ TqRvB/96SahiQoDIqA1T3SWuK/pRXTHons+yb+UKMN/P6CRkJK0rEOyVWP/uQ7ZBlI1XSnf/qWe siZew1qLu1oK1HW12pV272DxhB4X5dy7dVxK1iVszSNdkq7++lfbKIRL5UAQmDSfQUWV0Yqx2hR jaR2r0pD294nPLGMmmhnB8gbile1l9u/VUMd3q5DhwXUroXzJuMaI6tSyVRc/JOl9UKag4Rdy/E HxYYqmAabZEuUqghB4I3B/JpOFe77HQsTrcrEssewCqU7SGNbXukjE9OiRmk+qDNnT9Ex5aOet1 XqTHWv2ECtGB2IH/d5jxQmkmVcfsgRFIXggjiX+KeaAS9N1+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andy@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-11452-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B564966FB2D

The driver explicitly sets the .driver_data member of struct
pnp_device_id to zero without relying on that value. Drop these unused
assignments.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with builds on x86 and
arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/dma/hsu/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 0fcc0c0c22fc..b42c9c0887a8 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -116,8 +116,8 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id hsu_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA), 0 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA), 0 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, hsu_pci_id_table);
-- 
2.47.3


