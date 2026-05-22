Return-Path: <dmaengine+bounces-10765-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPr2BfS9EGomdAYAu9opvQ
	(envelope-from <dmaengine+bounces-10765-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:35:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081C5BA1B8
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2767300E38E
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC0384CE8;
	Fri, 22 May 2026 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nWOlKDzN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429B3812C4;
	Fri, 22 May 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482075; cv=none; b=Q6RI69VEm5KggVNH2rrORumXNJlfvopmXYLKWkphQvAYU2LQ5FFA3QI1JjF+Xc2jHqM3Ly4ND6aV+toM4sfLwfqYQsjxtm9l9WrfMJkXCKrkKS1DAJiVrkm0KOFMyA2FsLcXFRG6yD2Fup3/3SLBEB+ic4VBL+qKR3+1+naHFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482075; c=relaxed/simple;
	bh=q0dpwtFe71vQ+EhgbbhYBjeaJR9ZVQSsPWj6FtwVay4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxY9xiaEGveGIENrcXyFowK0JQ7CezANFDsMdgK/HAfcCX+l9i0GhYWEB86AwdEpo83IT4/W7LI5bAzkOnISy8AUmLM3LO5XQlJuHIwM7t4jjE0bz+XnfEroWj/3f+4Y0NMIB2IC5H6vi5RVYaCVSfQlPe5A2I8I5glLUypYIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nWOlKDzN; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MDjxle3145624;
	Fri, 22 May 2026 20:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=q/aqM+FITvd+0pCIS9OmAvMAad949chLGmbam
	6ZV3tw=; b=nWOlKDzNlzRilPOsSB2SNW+gOpOFv1XTIgCxGazVkGdCvLKKdf3V+
	VDT/LskzOaAnw+OpJgfOmw+vtZJBquC75xySYxCBOlBfYyjT5MAPckawWlXEv652
	bNoF9LmSU265DZ0jh70spBep6rB77wHHFExolHtLylwcfFlwZpIn/M3NYSuBdO1o
	z4gx8q2NeEXkLZkFfpYe0ATRZDCdpwqQd5fLkomSabC3X+7OcjVnAyVIL/WKnung
	nZtzz7wV/xqjxod3xQ53lIVMHCEZtvDFpFzbv1EuVEJCsUhp4iwfGaWKAzHNyI2V
	zmO9XWqrSvc26drOxR19IQWykTGM33wKQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4earancbcx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 20:34:17 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 63821800E97;
	Fri, 22 May 2026 20:34:16 +0000 (UTC)
Received: from owl.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B3651806761;
	Fri, 22 May 2026 20:34:14 +0000 (UTC)
Received: by owl.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 2329E27BECD; Fri, 22 May 2026 15:34:14 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v2 1/2] dmaengine: idxd: Do not call destroy_workqueue with null idxd->wq
Date: Fri, 22 May 2026 15:34:13 -0500
Message-ID: <20260522203414.336549-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZoE4Q9qHb6SNAedVAFAmVA787jI3YeMv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwNCBTYWx0ZWRfX1CquXjpgUYx2
 OH+6f5sZVEbB6fSgS+sQTfWmWqF1REFB9z338F5tp4dtMjQirWUY8aOCjl2EFdltQVL6pcJg+mG
 sq1kYKHtgeJZvnqyHhzbUv8MSoNRU/83rcPViLLhU21Lz/SU1me/mEEqwVLDafEAByk/w2plV6Z
 8b+aAdDr4vlC93JoALyex1fAYZfOb9MAqHegOC7vjNTgxNLq9fuI+f6KM9QsDWj+J65/joFUwlV
 WF0ZOb5lfJKLcROkqZWktQ1RpZAmPMBI1dsSGKJrqVbq0bvIJzhinOVkZVJZd3+R4Zujymz6vOF
 X0Ax6zwPPe/9m7lSkxMi2QKUxCfhJJajYF8qt1A7pGoVEwG2x7GZ1ZmEZ7soqYd6hdApYZJ3asJ
 nubhA5rulabi94P7xlQbrD6Eyc4TVPbAjAO76T8efkXZ3x4TSNaNSOCFdV6XXvAKJviVsWz6QzG
 OV0QoRcaDdfmqFj+mfQ==
X-Proofpoint-ORIG-GUID: ZoE4Q9qHb6SNAedVAFAmVA787jI3YeMv
X-Authority-Analysis: v=2.4 cv=BbvoFLt2 c=1 sm=1 tr=0 ts=6a10bdc9 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=ZSrvDirOKP4VPF05hnFf:22 a=MvuuwTCpAAAA:8 a=6sNNQ0ycvtL7J_oK21EA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220204
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
	TAGGED_FROM(0.00)[bounces-10765-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hpe.com:email,hpe.com:mid,hpe.com:dkim];
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
X-Rspamd-Queue-Id: 8081C5BA1B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Error paths within idxd_pci_probe_alloc and related functions end up
calling destroy_workqueue with a null pointer, from
idxd_conf_device_release via put_device, because that allocation has
not yet occurred when the error is hit.

This was encountered running in a kexec'd kdump kernel with reduced
resources, causing the "Device is HALTED!" branch in
idxd_device_init_reset to be taken.

In idxd_conf_device_release, check that the workqueue has been
allocated before trying to destroy it.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
v2: split into two patches as requested by Vinicius Costa

 drivers/dma/idxd/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
2.51.0


