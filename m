Return-Path: <dmaengine+bounces-10570-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLnGOW7MDWqq3QUAu9opvQ
	(envelope-from <dmaengine+bounces-10570-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 16:59:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4059058E
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025FE3032657
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75E3A1E89;
	Wed, 20 May 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="RfAMS1bl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB83E277C;
	Wed, 20 May 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287870; cv=none; b=JaYq2r7DKReMfRcie37YBXF/V7zQi77qMBnQr0ffrZIkUVyF4FojdTyY63pKRvwsXhzz4B1AFpuGHTc2YTcmWexgzfx23RWM01hayzEuINuLbktToEBIlZlH+f5dy45zjLsLO3NebolGR/g1U2tASLqfhnIcGOJq+XA3g+nNCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287870; c=relaxed/simple;
	bh=bzSTQCZOrBFSOsvbvDnpacFl5fPNGDFOQPEqbe+W6G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RL/TJflO+e9N0vabZZhMSB/Ju4nmSWTSGyeFkl+yHrkGkdFUbYLGVDQU92sTFWAqzgOiebdmZ7lG1HO6FHHALhzZeXvCOQzQEZjgPGD1w6+rwdZxVt8svljyl4O5PaoxrPho+yipf5u2tIXLkcChuZOrywk2TBHpssOdo5MA6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=RfAMS1bl; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE4JQr2574521;
	Wed, 20 May 2026 14:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=m+z9wNOWDyOlXsbnO7ZPmGxfgPL235d3JQGEO
	IPdDrE=; b=RfAMS1blEM27Z//6XZ5j1qtv1APGBTZiQQ/W+FggQKPNNGgLNpe63
	0jvXCt21byw7lb57nFvj9t78ItJzbW3SiNu5Qnzn9H/Zy2rqsGQyUDbELDXvquS8
	NHkKnYEEZwjedB2dkCx1/Ll4nk1e051KF9cN5ie2RnDxg89fIaeCU277ToAuc6K6
	h7MWqymiTXKeMSDzcGVHTIwjbr4+MGyNp2kHdLxGvrFwWQS5AKKh1xTCk0o2uSFq
	t+6FwjLURKeSMwKQbPThy/V29ia7cVwIQ10rfWg/P/PXBgtWL8tKz6vToAEoZKXD
	Ok5N7eqgF/XSj0cIGESYa+7SvrKRCSBeQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4e9ed88efk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:37:33 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 920C681B869;
	Wed, 20 May 2026 14:37:33 +0000 (UTC)
Received: from owl.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2C31F808721;
	Wed, 20 May 2026 14:37:33 +0000 (UTC)
Received: by owl.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 8C70527BF7F; Wed, 20 May 2026 09:37:32 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH] dmaengine: idxd: fix problems on initialization error path.
Date: Wed, 20 May 2026 09:37:32 -0500
Message-ID: <20260520143732.119407-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a0dc72d cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8 a=BfhZxvNQlJ6Rn41qmWYA:9
X-Proofpoint-GUID: X0pwTLlWog3NHyTTOVKLaq5_PxIXMCmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX0zVObHs1pSzh
 tUVo9OIEh305hyjt9FmrpPB3W1FaVwIOdI9MpNHKOHgnlonb4C+zYTYlMcLVK7EYEeLuvswpxt+
 MaqSU6ZO3vqH79i+xK7FV58zwXCbg85qKYbL1/whfkpsjV872kokF47/XT5GOyk6x873swGmeZ1
 uXtHvD33zFdF15fgJ33P3FVIad4YwANJvlG7g69pDqUFw99xcBTy+QvQ+30ZKaYHrW4lAhLkOav
 62wwtTLHPw46kQvsqAzXxE29Hkv8XKflUIHZIRQd8lO9FEbOB1eZ185baBEnDCBglqXtw5YvNNn
 7SzIM8pLmMigoOk7HsvFLwr2C74Jr3xowEX77cU1L5w2+ZVYD4tmCdmOEcQcCD11ElVe5X9o9kd
 OzK/jHyxp9L1zmORM+ek0fWvAWrygSB4wO8ghNJkiKkpWDZ7YSDotN4x371Z4XT8QSgIGBZ1Com
 SWNibkLPvOBZPryKTKA==
X-Proofpoint-ORIG-GUID: X0pwTLlWog3NHyTTOVKLaq5_PxIXMCmo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200142
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10570-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steve.wahl@hpe.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[hpe.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 61A4059058E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some error paths within idxd_pci_probe_alloc and functions it calls
did not keep proper track of what has already been allocated or freed,
resulting in calling destroy_workqueue with a null pointer, and once
that was fixed, attempting to free structures more than once.  These
conditions were hit running in a kexec'd kdump kernel with reduced
resources, causing the "Device is HALTED!" branch in
idxd_device_init_reset to be taken.

In idxd_conf_device_release, check that the workqueue has been
allocated before trying to destroy it.  And in idxd_free and
idxd_alloc, do not attempt to free allocations that
idxd_conf_device_release, called through put_device, will already have
freed.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/dma/idxd/init.c  | 10 ++++++----
 drivers/dma/idxd/sysfs.c |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1cfc7790d95..227e323cc5a0 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -607,9 +607,6 @@ static void idxd_free(struct idxd_device *idxd)
 		return;
 
 	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
@@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	return idxd;
 
 err_name:
+	/*
+	 * once device_initialize(conf_dev) is called,
+	 * put_device(conf_dev) will end up calling
+	 * idxd_conf_device_release() which will free the rest.
+	 */
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d251095c350..d5ffc641c856 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	destroy_workqueue(idxd->wq);
+	if (idxd->wq)
+		destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
-- 
2.43.0


