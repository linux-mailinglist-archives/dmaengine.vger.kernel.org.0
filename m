Return-Path: <dmaengine+bounces-3803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214A9DA587
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302081641D4
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98C1957E7;
	Wed, 27 Nov 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vdvXHjit"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66109193439;
	Wed, 27 Nov 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702610; cv=none; b=Ub/KOlt9646LWPYpw0SIp2PT4TzDmYYYrdKkBj6v5PQIQ20cBsgVi8dZnnZdHgLox06O5b0KbKvV9M/UYZWoWgiqV74l6rlEJ6rioHvnpfXm/ORiXPs/9vdVaiu0OIJO3oHlz6WoAg+WetudnqLKrUi7wbGGVr6dZKH5ZWm4zcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702610; c=relaxed/simple;
	bh=XvxKCLYDY+Inutay6x+JwSdqLrc74m6ShyrsolokXDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McZZZSAkCYOEIf6H/4ajDy8t7r+cAuv4uHRhJ4N5KfY9d4ns9mc9ZRAL04XHlYIsZ7itQPKWnMvv2qn7griyBQhYtbfXnFI5SA/oIxTky8T7nCxkM5pvWVEfvf09rxM7zTuVe07Pryi4VWOa1f2XaK6/FLw78IiLfO5WVejoofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vdvXHjit; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ARAGVO6063741;
	Wed, 27 Nov 2024 04:16:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732702591;
	bh=BxWCdFqn68UVfyk6swddq5DsS2ruANygdfVr1uWB7To=;
	h=From:To:CC:Subject:Date;
	b=vdvXHjit2C1Ym7Nklg+6Wdp9qVfaIF48LVfPgxhIti1XKPIB92kfI7sSfizXDU7fx
	 wsLGCeacIowU+zqxMQLS74gspi8OVqn0MqZ8U7t5IPcbJe3CoRJMQDR26U6I1pMOQ1
	 Odv91A7lHvEnwKdadtm6fwaXsCRtQwTfK4iy9DuI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARAGVbn026741
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Nov 2024 04:16:31 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 04:16:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 04:16:31 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARAGRoK104602;
	Wed, 27 Nov 2024 04:16:28 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v3 0/2] Add support for J722S CSI BCDMA
Date: Wed, 27 Nov 2024 15:46:25 +0530
Message-ID: <20241127101627.617537-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds support for CSI Block Copy DMA (BCDMA) instance on J722S,
the BCDMA instance is similar to other CSI BCDMA found in rest of TI
devices like J721S2, AM62A. It supports both RX (CSI2RX) and TX (CSITX)
channels and is identical to J721S2 CSIRX BCDMA but has slight integration
difference in the PSIL base thread ID which is currently handled in the 
k3-udma driver from the match_data, introduce a new compatible to support
J722S BCDMA.

Changelog:
  V2->V3:
    * Added missing compatible entry missed in v2.
    * Address Krzysztof's review comments to not wrap commit
    message too early.

  V1->V2:
    * Address review from Conor to add new J722S compatible
    * J722S BCDMA is more similar to J721S2 in terms of RX/TX support,
    add an entry alongside J721S2 instead of modifying AM62A.

V1: https://lore.kernel.org/all/20241125083914.2934815-1-vaishnav.a@ti.com/
V2: https://lore.kernel.org/all/20241126125158.37744-1-vaishnav.a@ti.com/

CSI2RX capture test results on J722S EVM with 4 x IMX219:
https://gist.github.com/vaishnavachath/e2eaed62ee8f53428ee9b830aaa02cc3

Branch with all the DT changes on top of this integrated:
https://github.com/vaishnavachath/linux/tree/j722scsi

Vaishnav Achath (2):
  dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
  dmaengine: ti: k3-udma: Add support for J722S CSI BCDMA

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml     |  5 ++++-
 drivers/dma/ti/k3-udma.c                         | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.34.1


