Return-Path: <dmaengine+bounces-10061-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFoaFyY45mkmtgEAu9opvQ
	(envelope-from <dmaengine+bounces-10061-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 16:28:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909242D183
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34EA631421F4
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844D3D0912;
	Mon, 20 Apr 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWhA1J7b"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A13441030;
	Mon, 20 Apr 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691809; cv=none; b=CTnIw6hxtqhrIHC2T8BllntfbOqvEq+VmcIqQvELLcHGzzIzwnc1+eq0XB03f91hZha4l/0cOGgBzZE9atAn8IX9q95+vTnMfDvFsu/uxqjiJ5D1BY3Dmc3IMzSpndpqtI+Ezm6bPtek421Z/Gwo1z1CfNb90kiXBCKcFHKh/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691809; c=relaxed/simple;
	bh=O3+HhjNe7v6wX+n9DhCPDf3WqWmW/3tq9dJUtdWrukU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoHPPw+UAkbO531oWhWXY0/8QbgDsDh17OZjjM8Xemca22OtWNkZj6ugR+goPA0PJi+6x8MNJ8M+KJsLJlfUIQx8G8uEhLaXO+MgcgTYVbVmfp1VYfXm9+ISJxqklbmBFDiDCOykNMIEk2W/j3xuXeEU+Fp1MaANVReFZffwsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWhA1J7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1173C2BCB4;
	Mon, 20 Apr 2026 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691809;
	bh=O3+HhjNe7v6wX+n9DhCPDf3WqWmW/3tq9dJUtdWrukU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWhA1J7bxf2t+qOpR4DBbcKGKsCLQs7RcoI8bmi882a7TvEGgG8wSExkJqE5ktxLX
	 AfcRITJvy/91uTLR4Bn0op2vuIRB1zAjo8tp3d9iVXWXrDCXOUMivPqby06ZykaoHY
	 dzYQIeXcvX8HI0Ychrqoe3PjXZ88qGaxokyknwaIbtkOVpTSDCS8XQXjHbS0pLV9ux
	 VvO8YAQ+yBF9zj2RrwVVrfVfAD4Fmaa37ArDHBdq5C1xQIu+u3zuovl+OH3cIajZjf
	 WeXaQkcwywZhQbls2JugBWpkW+5Vh3EVWLFKzq/LZ3QIy0ltTRGw9agvaOqrMMwKEM
	 svwQaIr1ZR9tg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
Date: Mon, 20 Apr 2026 09:20:01 -0400
Message-ID: <20260420132314.1023554-207-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10061-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1909242D183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit caf91cdf2de8b7134749d32cd4ae5520b108abb7 ]

Move the check for IDXD_FLAG_CONFIGURABLE and the locking to "inside"
idxd_device_config(), as this is common to all callers, and the one
that wasn't holding the lock was an error (that was causing the
lockdep warning).

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-1-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/dma/idxd/device.c | 17 +++++++----------
 drivers/dma/idxd/init.c   | 10 ++++------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 646d7f767afa3..746d9edbba164 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1106,7 +1106,11 @@ int idxd_device_config(struct idxd_device *idxd)
 {
 	int rc;
 
-	lockdep_assert_held(&idxd->dev_lock);
+	guard(spinlock)(&idxd->dev_lock);
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return 0;
+
 	rc = idxd_wqs_setup(idxd);
 	if (rc < 0)
 		return rc;
@@ -1433,11 +1437,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = 0;
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1532,10 +1532,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2b37c63a964c..afba88f9c3e43 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1094,12 +1094,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	idxd_device_config_restore(idxd, idxd->idxd_saved);
 
 	/* Re-configure IDXD device if allowed. */
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		rc = idxd_device_config(idxd);
-		if (rc < 0) {
-			dev_err(dev, "HALT: %s config fails\n", idxd_name);
-			goto out;
-		}
+	rc = idxd_device_config(idxd);
+	if (rc < 0) {
+		dev_err(dev, "HALT: %s config fails\n", idxd_name);
+		goto out;
 	}
 
 	/* Bind IDXD device to driver. */
-- 
2.53.0


