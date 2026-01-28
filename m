Return-Path: <dmaengine+bounces-8556-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OmBAKNLemkp5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8556-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:47:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A304BA721D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A28E3022474
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F936F407;
	Wed, 28 Jan 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvj8gA61"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253D36EABA
	for <dmaengine@vger.kernel.org>; Wed, 28 Jan 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622373; cv=none; b=Qyp4EfceKGIxesQRRJEtnvSuZpSXLyUTn2lgrW3Rq+K2OWBsGqPB3qz5N1LWNAg1UmqAfxEtIIKUpsZHaG1D7gy2TsVEDFq+9gP6u9qWC7pmWztWd2Iim/iEkCSKtkVr2JjnJXOPd4qJ5rilp3nAJBxx7a8m3YN4j72xcpHtCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622373; c=relaxed/simple;
	bh=GZQASIorF+d2e8n7uK82rQVsSClAj+OH+BfLkjJH3g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcO61zV0yk/XcAt6+2vndI8zEpI1da/cZakW304N44Tek8MyZ8oZ6Q7/PfD00iwPdg1EoHPN10n0dCvSAJKiAFWeoctMaLAVQbNLA09xlswHb5X5swZ7RbxYbc2VXwOUtpRT2jEwq8kfNw0syaxmu1DaPMwLEdridJHvi+PwmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvj8gA61; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07fac8aa1so321095ad.1
        for <dmaengine@vger.kernel.org>; Wed, 28 Jan 2026 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769622371; x=1770227171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iStp3p9u6vHuRquvuUjNe1DnkCcopXtlaiCjEmU2lPU=;
        b=Pvj8gA619dsJ/2VoF1M7GCxxSWwPUKIwCaG5mRO/k9F3H8LrJAK7ZEYyB2t/kCWby8
         PEQlR3uRXlx95m12Zu1dg2nMKPuIukAgPV6dcU7cbidmj8vEW9+a9fO9+pLrp/42vemM
         afTL9JJeggONMwlr/p8ZkWwdyUf0eYrdh4vnRwqYN3+fOYsz1Pg3k46WnsDHB35tza3G
         YDhbSPoZMNxWH+yOLNzQuXIxT9tOJn7PMQLGaXSghG1uQrXz/j1LnxoTv9WjMqZyfJgq
         ON1ugJvKsXZ9zFZwDzuGAWIBMMFRpynY9AHDQ8WF/8z9ZmDQbrz/2Iu8KDcRNx9jECvx
         XnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769622371; x=1770227171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iStp3p9u6vHuRquvuUjNe1DnkCcopXtlaiCjEmU2lPU=;
        b=nF53DBDg3WavOo8TmIQGE9ejAaSGtQMSql+WBVBz9x513BkoILaHAB5cg8LcV6Xhgu
         llpQ/46iZOLV8dTEZxv88W3IllI4dyY3YlSt2Grlvt3FFJMrlUXR2P+f0XlM79klupY8
         1DNcLV7V0Qx1xzI/GPft3gTzQy7DXPEqnAjXhu14ORLINVk8jJx5QoQTaLQwg/zyHxjz
         cUQsN/wthPgQ4+TDHq8wExI2dhM+/OHyjzubzhhWBHKCxUwXoWcf2gRpqkrl7+Sn7kn4
         NKVguxAukhikUT7Di3NwGH9L1PbvRiDXyHEaCVRmXrWGgFQK2XrCcIFibDb4FXWR+x9f
         M9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVAtPAgMGZrEoUCWLT3+ms27Bi1w7sW9be3dvy1Mrn+QSiI3jTmFht0jca3GuHPVaYRbFYT+y8S1OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGG9RTQEzP3aLIG8uSp7zHPTzXHfhjH8no6cztinJOOXwfx42
	na20AMeY9N80jJaLQyFSY7h5b504xB6aVPLL1tBiLTto9MaEy6+wQGL8
X-Gm-Gg: AZuq6aI1nCHtam9KwkRrbmS6FIqspjrqVVtJP5dCOXXZIFxxcGvB1XXAMek50JRMwuh
	8dQhDtpYuIqBncjSxq6OHiF/dEssrC57GHNU+GxSSrqkhxf1miEJmUVfcyDt7xdx4zZGqW/KXEb
	x6k1HimKkrA0V1RU078o4bpCOvceOepgOYaWuXqy3zal5QBGSDj4dSM6Q8KNH1D+vQ/ceo8sSEP
	Lb+b0jqRhJk2t1oekkrcxERIrAtDTGwRzHOY43LWIj55hu1s70hJyaoCcAEpV/6O/VGKh0CNWKv
	fADFDcIlQvHvEziZsX+OvQdhCxICsvWR4KxcFVRMe9mgOBqlfLXhM1OxP0WIIIwl5w1/j5GPlM8
	56zhJVcNLMs/Sez11cHu2oKlz3CU8YhFdBLqrUC58vzZDvyK/FotfLg6i+hVN9tR7nl758118f/
	7hCG2GmCbkr7nv7mupHCv0ktS0JkAeSXyprBU=
X-Received: by 2002:a17:903:90f:b0:29d:975a:2123 with SMTP id d9443c01a7336-2a870e24a22mr51461255ad.60.1769622370699;
        Wed, 28 Jan 2026 09:46:10 -0800 (PST)
Received: from localhost.localdomain ([183.223.93.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f7csm28169275ad.35.2026.01.28.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:46:10 -0800 (PST)
From: Shenghui Shi <ssh.mediatek@gmail.com>
X-Google-Original-From: Shenghui Shi <brody.shi@m2semi.com>
To: vkoul@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shenghui Shi <brody.shi@m2semi.com>
Subject: [PATCH] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Thu, 29 Jan 2026 01:45:52 +0800
Message-ID: <20260128174552.3710-1-brody.shi@m2semi.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8556-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,m2semi.com:mid,m2semi.com:email]
X-Rspamd-Queue-Id: A304BA721D
X-Rspamd-Action: no action

When using MSI (not MSI-X) with multiple IRQs, the MSI data value
must be unique per vector to ensure correct interrupt delivery.
Currently, the driver fails to increment the MSI data per vector,
causing interrupts to be misrouted.

Fix this by caching the base MSI data and adjusting each vector's
data accordingly during IRQ setup.

This issue was reproduced and tested on:
- Device: [20e0:2502] (rev 01)
- Kernel: 6.8.0-90-generic

Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa..516770388 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -844,11 +844,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
+	struct msi_desc *msi_desc;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
 	int irq;
+	u16 msi_base_data = 0;
+	bool msi_base_valid = false;
+	bool is_msix = false;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
@@ -869,8 +873,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
+		if (irq_get_msi_desc(irq)) {
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
+			msi_desc = irq_get_msi_desc(irq);
+			is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
+			if (!is_msix) {
+				msi_base_data = dw->irq[0].msi.data;
+				msi_base_valid = true;
+			}
+		}
 
 		dw->nr_irqs = 1;
 	} else {
@@ -896,8 +907,18 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
+			if (irq_get_msi_desc(irq)) {
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				msi_desc = irq_get_msi_desc(irq);
+				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
+				if (!is_msix) {
+					if (!msi_base_valid) {
+						msi_base_data = dw->irq[i].msi.data;
+						msi_base_valid = true;
+					}
+					dw->irq[i].msi.data = (u16)(msi_base_data + i);
+				}
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


