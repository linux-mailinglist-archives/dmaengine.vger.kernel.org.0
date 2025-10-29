Return-Path: <dmaengine+bounces-7033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDDC1B4A4
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201B4189A007
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715242C0F68;
	Wed, 29 Oct 2025 14:26:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530F27B353;
	Wed, 29 Oct 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748013; cv=none; b=ChuhmQA2AzG+6ZPzJTlqRL51LQkBlV2oHEDzStCLWXJr63Wywc92y3hAdIEIloYf9/KVLYKJ7WQhpSZx/cSjSEMFxBQWBJv/mvxo5yW3af5KJUISZSzJRunh+uNlb61Mcj8M4/2u4eTXOn6XctIW2g0IBMl/l4cUZy4sSMl2svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748013; c=relaxed/simple;
	bh=NVqYGgr6qdo986oUW8Ip5NNWWkRzmFjH5+Nm6cQ701k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5OGKWinUoIUZ+Cki01Hq1zMke3JEqmsnOxLV0OYBvF95tJ7vaCIq9RyKq4o2ldf6tuKDq+wkZ7jea57U1OjEx/3+QzWM5Y5gzHE+FPF2EZ7qCrSCRV/38qcNjKhqeAT6a5UAAj/cDKgqHwAb5F0Vjnt12XJ56ED/1ozdIbeTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 59TEQUhB080378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 29 Oct 2025 22:26:30 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 22:26:30 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 0/2] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Wed, 29 Oct 2025 22:26:19 +0800
Message-ID: <20251029142621.4170368-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59TEQUhB080378

This patch series adds support for the Andes ATCDMAC300 DMA controller. 
Please kindly review.

CL Wang (2):
  dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
  dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller

 .../bindings/dma/andestech,qilai-dma.yaml     |   51 +
 MAINTAINERS                                   |    6 +
 drivers/dma/Kconfig                           |   12 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/atcdmac300.c                      | 1556 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  276 +++
 6 files changed, 1902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

-- 
2.34.1


