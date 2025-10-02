Return-Path: <dmaengine+bounces-6744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E8BB4014
	for <lists+dmaengine@lfdr.de>; Thu, 02 Oct 2025 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F32A1543
	for <lists+dmaengine@lfdr.de>; Thu,  2 Oct 2025 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00863101BC;
	Thu,  2 Oct 2025 13:17:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E32BAF4;
	Thu,  2 Oct 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411058; cv=none; b=mnDsqZ2OQWXytUkkkAAj2ta932GzN067Bf9+cPfjKIC/nOmwSl0p1tOQ6s6s4BX4xwTAUM9jDx/4djD8FAk6CIfDUcyjEO9vMrmP2vYidptX2qsg3NTLwiL8HPyKi9ezOJ927ZjLxCX9eaBmFwG+EMJCUkpsTEsWGGSjy7u/LsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411058; c=relaxed/simple;
	bh=Oerz9ilgF6OxafYN0wflIYKhFfDP7R6q63cIIhLj11c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9PiFP8HEA1ztSOyJT9uo3E2XNfd7xSIkNAA1JNocK6k8buZ/jXHKHLeAzhpsdang4HmMfOQPdzFcUz3Tn0rflxO18FOzdB94lA4/oa0giakcmayjc+pzcz2Mw7g1o8oJ+YaISOiln/jF+d2HBGWek5nVRzVIIQGOsY1W7zeLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 592DH60c031764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 2 Oct 2025 21:17:06 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 21:17:06 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V1 0/2] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Thu, 2 Oct 2025 21:16:57 +0800
Message-ID: <20251002131659.973955-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 592DH60c031764

This patch series adds support for the Andes ATCDMAC300 DMA controller. 
Please kindly review.

CL Wang (2):
  dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
  dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller

 .../bindings/dma/andestech,atcdmac300.yaml    |   51 +
 MAINTAINERS                                   |    6 +
 drivers/dma/Kconfig                           |   12 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/atcdmac300.c                      | 1559 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  276 +++
 6 files changed, 1905 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

-- 
2.34.1


