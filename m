Return-Path: <dmaengine+bounces-1072-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E501685FBFD
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00BC284805
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B2148FE3;
	Thu, 22 Feb 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Sguijdpm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72F133439
	for <dmaengine@vger.kernel.org>; Thu, 22 Feb 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614787; cv=none; b=rUIw1+FctZNYZXswMlvloySWJ8jtUCW0nv0FavsIwgztN+hkyMaFLXc8PV1QOENMKzP+xh6ZulKNX1sRWb5Ge2r7H+zKikoAQORa0kk+3JO5IWLaabXKmOZjcdWthTwYqA35KU+yhC714SoccRAk5ERhzPJ6Y5w1NXsMWQDz3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614787; c=relaxed/simple;
	bh=6BFk0y00HAQKaJOF+NauTEIi8nEF3A99wjD20akaeqg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dNvR6/oYaZCzem4iya1UYBMJ0bbnE4bX9C+a4UqWtIFVW4zGIwieytFMT9EI8Su03hjmCtEjzrZWp66lkWpd7+cnI/iWXOm/vC6xMUq4F1bAbRoV/1hQp4IWNKv33mYXPRoQXsR+iNP4xNSVe4h8/MhJIDXTDGP6r/l6oniRV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Sguijdpm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MEXhdh030385;
	Thu, 22 Feb 2024 10:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=J2jnJK1zdM8CGOpB1vS
	E0M3+6f/a+TNhLEnRSFO1iNI=; b=SguijdpmxwOOI6eZQGfvNJFniFImdSLk7/p
	zI5zlKR4wID3sZ1B8bemT/BEHI5/OKhdZektIzothBt5MIA8GlGiSRDl46taXviW
	BXQLaNSD8JlHiC/sz3zq2kZnpCRzMhPXYgztbGP97WZGUo0ENSSL3djrvh9dTW/i
	tvo/2aV8VACOyd6JWdAtKScBuvYbmj1c1x2nua0cuiZtU1dFAJ0xei612O3ojlNq
	sQefCDEW2CVIdZOAop1cOg/5wYkmpmmoKz6FIIjZpfdOs5LKZVzLc70fuZBpMA3j
	ThrbuYWRVrCnlYdTxOkLUOjc4vrMnj5khA4nezNLPgTadPQ614A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21gh7u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:12:52 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MFCo5Y060151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 10:12:50 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 10:12:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 10:12:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 10:12:49 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MFCe40017151;
	Thu, 22 Feb 2024 10:12:43 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 0/2] dmaengine: axi-dmac: move to device managed probe
Date: Thu, 22 Feb 2024 16:15:49 +0100
Message-ID: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACZl12UC/33NQQ6CMBCF4auYrh1Dp1jAlfcwLko7hSZCSWsaD
 OHuFlaaGJf/S+abhUUKjiK7HBYWKLno/JhDHA9M92rsCJzJzbDAskBegpodmEFpMJQGmIJvCUz
 Fa7JC2vZcs3w5BbJu3tXbPXfv4tOH1/4k8W397yUOHBCNFMIo3uj2qkb18N1J+4FtYMJPpPmNY
 Ea4kpWosCmtbL6QdV3fetM/9fwAAAA=
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        <stable@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708614963; l=993;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6BFk0y00HAQKaJOF+NauTEIi8nEF3A99wjD20akaeqg=;
 b=Hdy9k7Qf63jnTx+C32CgWEhTD6/yxwe9GuREjN7OjdSs3PzWmqEnIHGcPZdvXLBl+NGXUbwz6
 HSnaRSKzA3TBebLmCv8fTVViSdU0ufZHEZZ+As+h9ajMWeb16cNWF2O
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: sMsuXbxBf0EoQtaQOwK7F2x42Jz_agaq
X-Proofpoint-ORIG-GUID: sMsuXbxBf0EoQtaQOwK7F2x42Jz_agaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxlogscore=581 mlxscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220121

Added a new patch so we can easily backport a possible race in the
unbind path.

---
Changes in v3:
- Patch 1
  * New patch.
- Patch 2
  * Updated commit message (request_irq() is no longer moved).
- Link to v2: https://lore.kernel.org/r/20240219-axi-dmac-devm-probe-v2-1-1a6737294f69@analog.com

Changes in v2:
- Keep devm_request_irq() after of_dma_controller_register() so we free
  the irq first and avoid any possible race agains
  of_dma_controller_register().
- Link to v1: https://lore.kernel.org/r/20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com

---
Nuno Sa (2):
      dmaengine: axi-dmac: fix possible race in remove()
      dmaengine: axi-dmac: move to device managed probe

 drivers/dma/dma-axi-dmac.c | 78 ++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)
---
base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
change-id: 20240214-axi-dmac-devm-probe-d718ef36fb58
--

Thanks!
- Nuno Sá


