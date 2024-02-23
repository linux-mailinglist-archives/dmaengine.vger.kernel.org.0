Return-Path: <dmaengine+bounces-1098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3A86113C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3721C21C09
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE67B3D5;
	Fri, 23 Feb 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XwtZwSGq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9C25742;
	Fri, 23 Feb 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690302; cv=none; b=LftFr0mSHAEil0vqPCqzZvcZK3qAKyVesy/91YAtUEc9DhSmGvcmP9Y53+SgjHVSHomt57DcvH5lrF8WsocR1p4m2gefVHjq0yrTJI7GpSQbq0dng0kVry4EopZuYKmtBbppHPeRXAJpqy8VlQPFkKOnIDRIH4XQlT1kE8F4MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690302; c=relaxed/simple;
	bh=vEHWJ4mFFQD8t20Y/2sTFpAm9vga4enu/i02BRzpi2M=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=WvSneO1C9RMyGek85UTy1+25WQwupOXsE/Si89CIV8uQ83FkhhU+E+NDRGKhHiUIR/1dMS9AEai5i01RY2TjCFGZ2atGXeseE+YWwrASdGc60JzFsJ0Ujo2dY1kACeOGsCAzG2s5WBvUnCaiwkN9jSfO5DXpa27X/lncD9iFWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XwtZwSGq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6rd0i030350;
	Fri, 23 Feb 2024 07:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=j8afl28WKkn2qowBbkq
	+mc34EwguI2rPkwFLr3iiGdM=; b=XwtZwSGqvFuEL4hU5RnAmUnmYWmD9dixtit
	ZE0MAdHvQBIupEB0nJV+KOie5+/NP+DW+nAFQ5l6Ob2ls2WsOlfdWTedGJwwjmRi
	qsmuy5R97kV005Ez7glQsbLdPwtcm0vp7T7MXovhB3qc6EAdx+C2fvpP3w8/cuON
	a38LOP4A+ZtxNPjq8eTkKaS7JltR/UNUJb9QNdiMn9M8PZEHHm+Rm1aJNQtwz4Mz
	YXO8vUHnqaDFYzTTotdwwAObuZstWo0Prq5kQHrDAATYetbvOd6GQmpd+6G2FPmB
	Mu1iUlWhwma2jN/06fKD7Ud5UJPCQy4aIMz2XM27kPSw9ZG27Qw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wepgc11ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:11:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41NCAusc004366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:10:56 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:10:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:10:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:10:55 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCAb2R032246;
	Fri, 23 Feb 2024 07:10:39 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v7 0/6] iio: new DMABUF based API
Date: Fri, 23 Feb 2024 13:13:58 +0100
Message-ID: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAaM2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3czMfN2U3MSk0jRd09RUA1NjA0NL0+REJaCGgqLUtMwKsGHRsbW
 1AKc5cJVcAAAA
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Paul Cercueil <paul@crapouillou.net>
CC: Daniel Vetter <daniel@ffwll.ch>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708690439; l=2488;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vEHWJ4mFFQD8t20Y/2sTFpAm9vga4enu/i02BRzpi2M=;
 b=8JMX1H4q/6Nb2TCb1A9VZrpSSThjCsDfFhXLYOZ5PE8WEfm/Af/LU5sNSgoKAGdr5Id8gmVUw
 3y8buCXw3YaCTwjkg5F8Zlxfr6vZBBJRaEoyhxolMtUW5XLgY28Lwom
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kCYwEmDuPOxAFUUZ2trl7DIyXKH_VMnZ
X-Proofpoint-ORIG-GUID: kCYwEmDuPOxAFUUZ2trl7DIyXKH_VMnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=765 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230088

Hi Jonathan, likely you're wondering why I'm sending v7. Well, to be
honest, we're hoping to get this merged this for the 6.9 merge window.
Main reason is because the USB part is already in (so it would be nice
to get the whole thing in). Moreover, the changes asked in v6 were simple
(even though I'm not quite sure in one of them) and Paul has no access to
it's laptop so he can't send v7 himself. So he kind of said/asked for me to do it.

v6:
 * https://lore.kernel.org/linux-iio/20240129170201.133785-1-paul@crapouillou.net/

v7:
 - Patch 1
  * Renamed *device_prep_slave_dma_vec() -> device_prep_peripheral_dma_vec();
  * Added a new flag parameter to the function as agreed between Paul
    and Vinod. I renamed the first parameter to prep_flags as it's supposed to
    be used (I think) with enum dma_ctrl_flags. I'm not really sure how that API
    can grow but I was thinking in just having a bool cyclic parameter (as the
    first intention of the flags is to support cyclic transfers) but ended up
    "respecting" the previously agreed approach.
- Patch 2
  * Adapted patch for the changes made in patch 1.
- Patch 5
  * Adapted patch for the changes made in patch 1.

Patchset based on next-20240223.

---
Paul Cercueil (6):
      dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
      iio: core: Add new DMABUF interface infrastructure
      iio: buffer-dma: Enable support for DMABUFs
      iio: buffer-dmaengine: Support new DMABUF based userspace API
      Documentation: iio: Document high-speed DMABUF based API

 Documentation/iio/dmabuf_api.rst                   |  54 +++
 Documentation/iio/index.rst                        |   2 +
 drivers/dma/dma-axi-dmac.c                         |  40 ++
 drivers/iio/buffer/industrialio-buffer-dma.c       | 181 +++++++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  59 ++-
 drivers/iio/industrialio-buffer.c                  | 462 +++++++++++++++++++++
 include/linux/dmaengine.h                          |  27 ++
 include/linux/iio/buffer-dma.h                     |  31 ++
 include/linux/iio/buffer_impl.h                    |  33 ++
 include/uapi/linux/iio/buffer.h                    |  22 +
 10 files changed, 894 insertions(+), 17 deletions(-)
---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240223-iio-dmabuf-5ee0530195ca
--

Thanks!
- Nuno Sá


