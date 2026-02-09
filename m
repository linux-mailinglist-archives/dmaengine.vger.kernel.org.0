Return-Path: <dmaengine+bounces-8835-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A99hFQK5iWlDBQUAu9opvQ
	(envelope-from <dmaengine+bounces-8835-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 11:37:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE710E324
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C4DE3014424
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F297366807;
	Mon,  9 Feb 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3GB6D6n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F213446C7
	for <dmaengine@vger.kernel.org>; Mon,  9 Feb 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633469; cv=none; b=SHyzQpePYjYXUcwLtssqZqvICdRq6u9Xrt/Yh7kk/sdAMvCsyVJSQcuTikyc6cDSluQ3Yz8Xs0HVxSS1Md5If0DVo1Y7isCCB74OxpYDP8EyWH9fyoI22pz7qkfbgYocdGg3xN1YQsdD1F3spgqGgzkhhiNnLseG67VdpEyBG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633469; c=relaxed/simple;
	bh=Zjbt+MNN20b1ZhpPOOtZM8/Igifx4iU2KQHUcp+BhAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEh8R/Fk8pQOTuordpd+urdF1rqVxFPSvXl6oIiewmAiZ1w98wMGmqYA9fuOfia3dF1Foqhu9+KIUImHUdXCNfSwg9sa7lvfLlRUtt5pWSadDV3QzOnlXBYAWmI9XIAKs7tYltCBT0ivGRUR72INttUYMZsm2GEbMR4yLc+Td0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3GB6D6n; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81dab89f286so2086681b3a.2
        for <dmaengine@vger.kernel.org>; Mon, 09 Feb 2026 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633469; x=1771238269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOJlBBmeTmihfWXAZmaRsMgXk3WY7j4I4ECMpqKaiiM=;
        b=h3GB6D6nSdXSVxLBDl6F4EpLZYsYEaOnUz5eKW6wOP96SLHCbrpMHwGbfkCAtukgwA
         6t3MzxQeltvdy+tVIgefGwM+VD7FHBjnkY84XguvRIKQOhtbOvu4gP/tolXgbSiZ+f8W
         BIcpf/8kYO3YQpCxdoXzvdXNGV/ZWcEKXXvcbXJzJkonU0sT+Vb6qX5BllifTCPDcKmG
         v4MrthSMMwA2wIQOmFu46QHTYD6Bg5QMs5ebylkv4PGcEVE6+/VNuSwOfB6jUg2RWBAw
         Zy+qnSJoEoS7Dmqf500e+68wW86aY7JX7PykLx25CGN4XmWWM1J+d0Wq70/NXQy1P06b
         tC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633469; x=1771238269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lOJlBBmeTmihfWXAZmaRsMgXk3WY7j4I4ECMpqKaiiM=;
        b=WyxXUQfqWjcbQL94VeMWwRztFwBYST5UGudrA2yEBRjlsNQacDiHGoXQXTpIQAcOD+
         eLHSQvOvFU8t4/9y7Ar/htBXT3NUEKrWzy8jUc5I99I+mcRnu7YY149MXo4nDlBuxHFF
         tvKS4NnhVmLSQqCouSBr71a7Je7WJTA35meWWQ7o5r8sXC7goXJ5ud+eizwXyW9uTrPH
         vGLD35KFKIR8y2K9NZkSYYyVrT+zxvkn3LO+8ZGyW/GVax+xaSHjnwCnBvMHF9rduMFw
         Jli6vazrL/FAp0K8/h5WDqCO+1b6E3gd6uhq2AZNPP84d0ifYFdZ39lSTd1KUeCzOp56
         1olg==
X-Forwarded-Encrypted: i=1; AJvYcCVwSHxH9c4UKngwRgm3Fth7NxLb5waf+6oV35AmYPVwz+BcNAN4G+/hUobc9f9iIAne2ZawZE+XTRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpdjmkyzBEp31gVshGL7/gvC4TBBRtoU0PRBoxKgrFPTO4yhN
	0DnVGXF1ynYhfMXncgztZy5wWugLz8DFppO4dM3wsI9EjE+ZBbdlZCRc
X-Gm-Gg: AZuq6aL209VFhFa0q+bdWcl6fwhUZgZfXc89/VLM4JZSVW3mbKVabp2Kvo4O20HIsFc
	MIbFyRiMpd/uYdovTtN1f1H3QEb8WqiFzdn/o5upPw0eEnTZtGwF9evN3e2DAmfnMXskw9neDg5
	P7ukBHXywDGua9bSPfQOVCErMKs33BblWcjhqqzgQYvIiVPmdu/cek/84T9XRYBZEIPBlm9SYx9
	uwQFKkFGiOIqFVQBWY8q+WQvEioTYdbrNf3n8GlSqYlzKUhTDqABywbd4sOKIOla98Djo2IMdjC
	QstFaE+7Jh7L87QqOAAUszW3YdgEtfrz6QdPgWZnKPBI5mgjRaxonSa7rwiRzY83DZJUpFksgCu
	KbW96800HtdYtVFTuoAUszDm7Q+SwxP5Jl1QTUK699/1FmBNuvhlGV5O4d5IGEyxdOurl1uhIji
	Tponx2lJK4bnRN4UKnX50L/HRsGLL/wdMa9fk=
X-Received: by 2002:a05:6a00:2d9a:b0:81f:c6d1:ec6a with SMTP id d2e1a72fcca58-824416f8993mr9058480b3a.45.1770633468688;
        Mon, 09 Feb 2026 02:37:48 -0800 (PST)
Received: from localhost.localdomain ([171.88.165.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f6dfsm10428558b3a.2.2026.02.09.02.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:37:48 -0800 (PST)
From: Shi-Shenghui <ssh.mediatek@gmail.com>
X-Google-Original-From: Shi-Shenghui <brody.shi@m2semi.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com,
	kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com,
	tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: [PATCH v7] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
Date: Mon,  9 Feb 2026 18:37:25 +0800
Message-ID: <20260209103726.414-1-brody.shi@m2semi.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260209093642.273-1-brody.shi@m2semi.com>
References: <20260209093642.273-1-brody.shi@m2semi.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sshmediatek@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8835-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,m2semi.com:mid,m2semi.com:email]
X-Rspamd-Queue-Id: A4BE710E324
X-Rspamd-Action: no action

From: Shenghui Shi <brody.shi@m2semi.com>

When using MSI (not MSI-X) with multiple IRQs, the MSI data value
must be unique per vector to ensure correct interrupt delivery.
Currently, the driver fails to increment the MSI data per vector,
causing interrupts to be misrouted.

Fix this by caching the base MSI data and adjusting each vector's
data accordingly during IRQ setup.

Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")

Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..22d906426d75 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -844,6 +844,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
+	struct msi_desc *msi_desc;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
@@ -895,9 +896,12 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 					  &dw->irq[i]);
 			if (err)
 				goto err_irq_free;
-
-			if (irq_get_msi_desc(irq))
+			msi_desc = irq_get_msi_desc(irq);
+			if (msi_desc) {
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+				if (!msi_desc->pci.msi_attrib.is_msix)
+					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
+			}
 		}
 
 		dw->nr_irqs = i;
-- 
2.49.0.windows.1


