Return-Path: <dmaengine+bounces-1198-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFE86CEF2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BFD285E74
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BD7828E;
	Thu, 29 Feb 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pXE4uxG3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FA7829D
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223646; cv=none; b=XQIXsq26Y4plcr2rzCgHxDo/E16tu+wHnVMxYIByBjDiovIJi91qqO0s3J7wwbYkBXiysZNsnqAumQP2k3T9L9Rv0QJaWmPMmdDmm3aRoIdw1hQiUdgWVt+4b5vm+lLNOsvSY0JVJTiYKH6bC9ln7xa/460GulqECfatI7HxPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223646; c=relaxed/simple;
	bh=XPjecJVgILETFitquX4Ub1RqqD+qTgTUae9qAAfLUic=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=vGYv6mkgNzZM5GkOWy05D1UVom8rMRip5ptIWubvmUxEWU90aVYiwbNVymTqdpl60od2W1HsIBhBT/OReGno5LmZLcb+vB+I8ZMTqE1Z4Luplyz2jdUl4l89NFmch8vhdvjJZmMGcZS/ogdNVc3hMrmQX1P9iZXFD62FSLsZuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pXE4uxG3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEaiUR007950;
	Thu, 29 Feb 2024 11:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=ij5h2GWQC95T8hJki1o
	XwPuJda/gTCPEH6Sq3AZh4XM=; b=pXE4uxG3d6i8Ddt8vMQHdNqp1IA5i38aZY5
	TJp1yk+0IdqtNe3Z/vpHkUX05L31WiqMPKeLDXF4WuiN33nz3W1zm1Yu+Lcy4D1n
	talJu06thOWglsDY/DqXm52qPu7632y22WV6hr1GKE+kJFf9ZP65ieCoUeIW/lJK
	YgGFu22eb/pYdvy4rep4wat3tmzchX/Mz7yshwYBVRufCHu9XglAhcOdb8KAvt/u
	wu33BeSs8lmYL0PDqzgakDXIS/G5oo7v/rxFvt+kbqhRHq3NKSwDmY1p3wOF/dZB
	fPWjHupWsGmaUYhCMUXZYSevh/gP5V31Ft3Ibgi1UuoO01Yt6ZA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wjcr2uv8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:20:28 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41TGKQIa035243
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:20:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 29 Feb
 2024 11:20:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:20:25 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TGKHwZ019308;
	Thu, 29 Feb 2024 11:20:19 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH RESEND v3 0/2] dmaengine: axi-dmac: move to device managed
 probe
Date: Thu, 29 Feb 2024 17:23:15 +0100
Message-ID: <20240229-axi-dmac-devm-probe-v3-0-f0e78d2ab5b1@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHOv4GUC/33NMQ+CMBAF4L9COnuGXrFQJwddHXQ0DqU9sIlQU
 0yjMfx3GyaNxPHdy33vxQYKjga2zl4sUHSD830KYpExc9F9S+BsygxzLHLkBeiHA9tpA5ZiB7f
 gawJb8ooaIZt6VbH0eQvUuMeknthhd9ztt+yc7hc33H14TmORT+1fN3LggGilEFZzZeqN7vXVt
 0vjuwmM+ImoeQQTwrUsRYmqaKT6QcQHgjiPCMiBy9oarUgWVn4h4zi+AZ4F6yhJAQAA
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        <stable@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223821; l=1190;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XPjecJVgILETFitquX4Ub1RqqD+qTgTUae9qAAfLUic=;
 b=r0pJtOXgjp4IqERXWp7JMeZpbih4N342nyq/SgbFLllqZctKoObWOfTCaDXiUleu5Bk/vuKyb
 Qehpycp//oOBhwdIgvNqQixfU0X4lo3g1UDV3IZ6uWNy2hsBrEs9wAc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oHizItM0bTfFAudWC-u_77Q8ULnevOI7
X-Proofpoint-ORIG-GUID: oHizItM0bTfFAudWC-u_77Q8ULnevOI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=626 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290125

Added a new patch so we can easily backport a possible race in the
unbind path.

Vinod, I'm just resending these patches. I applied and compiled them on
top of the next branch. Tip in:

716141d366f4 ("dmaengine: of: constify of_phandle_args in of_dma_find_controller()") 

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
base-commit: 716141d366f45d62ffe4dd53a045867b26e29d19
change-id: 20240214-axi-dmac-devm-probe-d718ef36fb58
--

Thanks!
- Nuno Sá


