Return-Path: <dmaengine+bounces-9899-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL2aF9t/1GlLugcAu9opvQ
	(envelope-from <dmaengine+bounces-9899-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:54:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CEB3A9862
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241AA307308E
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52737475B;
	Tue,  7 Apr 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohFNyTwp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4937475C
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533953; cv=none; b=VDme6JHwh/JCN8TSxoWxvcCuo4CuIl08jra5PlzMDPV+U9z9cN9J1wiTM7VflPau/PdfuO+9FMy1TPpjQ3erwkOf293Pq2dxiIf3d8gO1GJRR7FBD0LzZ8aEbAIItvEXbSUvmcRXHDDSNPEdRqXlm9bkQWn8EDSIUaAtDCfsckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533953; c=relaxed/simple;
	bh=hWTqrbgs6Ynu8w+0/oInRnFbfmZqm7O0l+BAT/oCoac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5q9qFxPIAOhWGVMP8cw6aKem/HxO8E/fipzcSOJeeg2kVmp2g2pWamVZ5yxiR25DRP3iOP80IRdaYAwbcTY6mXXpExIjJpjLXoHB7TKzb+zB/D7HP0NxMSFh0blqjm6grHdtZV7eQeCsCnrXktm5RwKL0pphT8jHu20KxNxthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohFNyTwp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d65f4073bfso362240785a.3
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533948; x=1776138748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqMWReHNfBZQ1cD4RbW3GJ+O9AwhazTgpk4nLCPXKWQ=;
        b=ohFNyTwpi5Tvc7uwHySSIle/sRaBmd22CfFhvUNx/xpplRQC5ZdGvejTK2n9Iy5STL
         JCwbiTnJ1ECJQhLbWPTO9mvvz1tbpQzbN1fP+mjBrl0Kd+ztwVrrxnXd6IJC00MMSVw1
         r/AHG0E4Ynzmjl8U3nUMuUtAn3pkRo6n89SgWaHQJPO+T4LxxvnatJYxGTiw3NOYD5br
         mxbfbzY+EfwpJpr1tEHKPNKo5hytS4YX6OqxJiLN4hhJZPZwurxeDIge23xbqEi5t2S7
         s/zI+gK42i49tKb1ikm9Of+Ga5dYS6z7gnGJj47KF+a722BAVi3tkRyv41mXIgEYQRdg
         Z+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533948; x=1776138748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqMWReHNfBZQ1cD4RbW3GJ+O9AwhazTgpk4nLCPXKWQ=;
        b=YYQExYQRVHOqTZbKFs9dqdwgf8IaXapEkbA40OGsOYq36AACvjoPtTu7tQ7bg4xmTM
         aGz2SUd/boyCxRnvN2Qu4Dm2P3IFbcuMHPE9eU22/vSEUqwAxLyresMVsr1kPXbZqo/p
         2Vuf4C4lkk7uO5UD2+fah83GhCcSXihXcXNqkVs3g5omUIs1rnhkQ1UOx7xXBf6BmrSd
         TAVVlARjrn/OyDRIiu46T8ucKm+oDbUrd8x1qxdDBrM1nzY606SYwyGu82H3+tAqnK30
         fAnVTCIdDQA+pOfN0SGHGr3Z6OXZgC02aXpkB5OQjpnapwZCPkgj1mHvStZInYvSf6Uk
         pw0g==
X-Gm-Message-State: AOJu0YwwUoHNJ+S3OVB2CjOz9cosxSk02LYiVXhy8onOgOSkqk4c/1+z
	BAbq2XhYzYees24jbrgHyTZrBzt9iqrFuCvDOF/tBcWmcVUMeRzgM7REqK1gJw==
X-Gm-Gg: AeBDies2SIZRduCfVQfQ6S2gciuKawxtppS/iVXqLwjb3H4xWgqAmw3xxYrHDdu0mQf
	Uidv/0wTEsKkvLu4uoPP5YMI/jqTMZ4neY59Gh3q8CoM2NiNq6h3onKpqfTphQGz8KRb0FHwJjV
	on3pqDdahJV3xvjSIy9pmCsMxCxQjLXwKxX/P+j4nOPYMry+8Ce5Lpf5XcP8YrmeCoSq9LWavgR
	k735HuBr9YxZyBjCSYwXni40vsduroSMVer2PPHMyKzQixgbWmGDlEtzYmPsZmEwW4cVdGkx1Mw
	SPwd/zPsaID6XxQ7lvFSOFjMfsMPsi4n/3DuvgnbWaCdt2QW+vGk4xzKY3xr8dxHNBZzPqsu6SI
	PyreNdG/CaCeeYzFlH1sFY8w2rt5I5/l6essc4nu3OgPnaFC2/FqIBRdtQwC+OHTBzolw6x4mZw
	7b3NyY83EegP6nHXwJwgERvG0qqXRhW4SEgXn9QufUrNBj2GVD94TrzkD5S+QMUYKiMg==
X-Received: by 2002:a05:620a:4104:b0:8cf:d3a9:60ea with SMTP id af79cd13be357-8d419961f7bmr2287785185a.26.1775533948373;
        Mon, 06 Apr 2026 20:52:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5e69afdb6sm687935285a.40.2026.04.06.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:52:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: pl08x: use kzalloc_flex()
Date: Mon,  6 Apr 2026 20:52:10 -0700
Message-ID: <20260407035210.99085-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9899-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06CEB3A9862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

kzalloc_obj and kzalloc_objs can be combined by changing the array type
to a flexible array member to simplify allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/amba-pl08x.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5e88fd44812d..255b33064945 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -268,12 +268,12 @@ struct pl08x_dma_chan {
  * @adev: the corresponding AMBA (PrimeCell) bus entry
  * @vd: vendor data for this PL08x variant
  * @pd: platform data passed in from the platform/machine
- * @phy_chans: array of data for the physical channels
  * @pool: a pool for the LLI descriptors
  * @lli_buses: bitmask to or in to LLI pointer selecting AHB port for LLI
  * fetches
  * @mem_buses: set to indicate memory transfers on AHB2.
  * @lli_words: how many words are used in each LLI item for this variant
+ * @phy_chans: array of data for the physical channels
  */
 struct pl08x_driver_data {
 	struct dma_device slave;
@@ -283,11 +283,11 @@ struct pl08x_driver_data {
 	struct amba_device *adev;
 	const struct vendor_data *vd;
 	struct pl08x_platform_data *pd;
-	struct pl08x_phy_chan *phy_chans;
 	struct dma_pool *pool;
 	u8 lli_buses;
 	u8 mem_buses;
 	u8 lli_words;
+	struct pl08x_phy_chan phy_chans[];
 };
 
 /*
@@ -2709,7 +2709,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_pl08x;
 
 	/* Create the driver state holder */
-	pl08x = kzalloc_obj(*pl08x);
+	pl08x = kzalloc_flex(*pl08x, phy_chans, vd->channels);
 	if (!pl08x) {
 		ret = -ENOMEM;
 		goto out_no_pl08x;
@@ -2854,13 +2854,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_irq;
 	}
 
-	/* Initialize physical channels */
-	pl08x->phy_chans = kzalloc_objs(*pl08x->phy_chans, vd->channels);
-	if (!pl08x->phy_chans) {
-		ret = -ENOMEM;
-		goto out_no_phychans;
-	}
-
 	for (i = 0; i < vd->channels; i++) {
 		struct pl08x_phy_chan *ch = &pl08x->phy_chans[i];
 
@@ -2962,8 +2955,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 out_no_slave:
 	pl08x_free_virtual_channels(&pl08x->memcpy);
 out_no_memcpy:
-	kfree(pl08x->phy_chans);
-out_no_phychans:
 	free_irq(adev->irq[0], pl08x);
 out_no_irq:
 	dma_pool_destroy(pl08x->pool);
-- 
2.53.0


