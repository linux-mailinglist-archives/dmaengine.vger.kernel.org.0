Return-Path: <dmaengine+bounces-10766-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOMxIyG+EGomdAYAu9opvQ
	(envelope-from <dmaengine+bounces-10766-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:35:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E954B5BA1C9
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21E5301F31E
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44830385D86;
	Fri, 22 May 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="h8jqUNjD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420D37C101;
	Fri, 22 May 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482077; cv=none; b=ZISMFSBiejOwYc9egzzcOgDMAFslIROaxGhgZtyT13jWfFW/JRQISnc9fOROrI4aHVDpccASCNLjdVI5GMf/nx/gjR3yPmy+6UmIq7Mq8hRhftXn92spNUXrF/utZjD2GUvvlGq1k5nOQzCgZmC3yOl6UTVHeuFnEp0tkNZLfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482077; c=relaxed/simple;
	bh=lfgcV6eeEGAB4djyNOUGzCR8McVdJ+2Waff6hNtw7Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj48XhtP16NlFFLK1ZcsEHNdf9fT3PYuCIGR0MzXRbCjJkVU4YgXTWFCkixinUdtWc6m9beaaRr8M69staTixRk5nFE/B3tTzH1bRcH9H6QB00IpBT2mlVdN9FfLGdcOPqGR4NDBP9WwrYx5GW4kq00xvGpLJUgezBKRdItERnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=h8jqUNjD; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MJG0194042744;
	Fri, 22 May 2026 20:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=hp51WmELFstg2
	AmWoHcDn8bK640IwiyjuFoF808nHPY=; b=h8jqUNjDNl2DQh4eOfelFEUSeRvXY
	qW0zgbgnumBnj9b38kjK5sFtaZaFDy236RacqCd/6E3pu/cZadutpJrKbJ1sjz0n
	o3qIvIBly96B2j8VTlV01+KCnYjDW6r1NF6w7b7BLLaiAxp2OlbLsR/VXx9TIj7G
	ZiH71VPcWZ0FFN+TwMmiur0UQD2keWvD+ZrOSpSC/+TYEg2t7kvlm+o8PmsfA9+A
	CWGjVPOFFfdi161zn8+iJOWpr/qqfAGMvJePNSDibBHE8rolaMhyFP6C/fRekHGN
	IoMoDG0m+lVs483cQriYHdINV1FEYqbTwV6R89tsCErCt7yp8fE9kLHpg==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4eaw5agrft-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 20:34:17 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 63987800EA8;
	Fri, 22 May 2026 20:34:16 +0000 (UTC)
Received: from owl.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id B2375800EB5;
	Fri, 22 May 2026 20:34:14 +0000 (UTC)
Received: by owl.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 3383827BEFB; Fri, 22 May 2026 15:34:14 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on initialization error path.
Date: Fri, 22 May 2026 15:34:14 -0500
Message-ID: <20260522203414.336549-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522203414.336549-1-steve.wahl@hpe.com>
References: <20260522203414.336549-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L3pyN4tyGaqnshXQb4p9X8oerGz5uQz_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwNCBTYWx0ZWRfX+KsyG/1VT48S
 Wp640tOaclEnbMDS8gDu8y90qamggJj9S3wp2DAywWW3141mjV4F6qSFgcP2L1nTTILd5flTLPc
 Rm1OIFmMZwzsSElCcCcMn2zTWHjYKvw6aVr+/AyEr3gRX5gXWOGaItsc3d4LLXBmIalxifjfCcf
 KDKyzpcd6KJ82UKFMqnUNVLDSMhyjYVDrGNA/GZ41ZTxfMvHnkNfzpcQ81A0YdbwMhvozRFGPgP
 N9FDjR4r/ScifBY5E+VKlL7fUQkIgmtNhPWb1pvjqg/VMwDMPvRxzdcvUOdSYVrd38h5N8mPMr9
 UoZsvEKcKnGcfMmacdw0nHHWBvjTpLol3CJZlQhX/mX2Mnfseep3+2OVq18Bu3B72V4Hp8maCLB
 XhBQbx9Igb2xCTBsT/mG+o3W1P02m7/8ycOc9nxVJ0jBhASPfbZIeTcVNBk9hL8vK6rpg4v+P/L
 A1xRK/aDYVpAKIgt25g==
X-Authority-Analysis: v=2.4 cv=HfQkiCE8 c=1 sm=1 tr=0 ts=6a10bdc9 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=g3u0LPWLDYfGfufhFw6-:22 a=MvuuwTCpAAAA:8 a=QkGq_3HF2cR0Z8LhDQMA:9
X-Proofpoint-GUID: L3pyN4tyGaqnshXQb4p9X8oerGz5uQz_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
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
	TAGGED_FROM(0.00)[bounces-10766-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: E954B5BA1C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Error paths within idxd_pci_probe_alloc and related functions end up
attempting to free memory already freed from idxd_conf_device_release
via put_device.

This was encountered running in a kexec'd kdump kernel with reduced
resources, causing the "Device is HALTED!" branch in
idxd_device_init_reset to be taken.

In idxd_free and idxd_alloc, do not attempt to free allocations that
will already have been freed.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
v2: split into two patches as requested by Vinicius Costa

 drivers/dma/idxd/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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
-- 
2.51.0


