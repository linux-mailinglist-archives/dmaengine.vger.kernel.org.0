Return-Path: <dmaengine+bounces-10975-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OWKAOhzzFmo6ygcAu9opvQ
	(envelope-from <dmaengine+bounces-10975-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:35:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD95E50A8
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F111307D7FD
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB17413255;
	Wed, 27 May 2026 13:28:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B95332EAE;
	Wed, 27 May 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888532; cv=none; b=PojQCuuR9S/4rLQEXMk1kZA/4T2VhfOsYQbFUgaoasPGNMPtVFIIQEoZHuoMEy7e6WD4uWAHsLo4qJ8+ug0aHp2u5u20XMBLsV0inbhr6vzjh47k7LXGvEJrbfPOruC45GI99i3uOR7XRuixcmVPcJgSlZ7ZZZFiiHu6POZOEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888532; c=relaxed/simple;
	bh=i3ueMIiht6vtEnDeWTQlI+Ed5qdjYFMLh7I9aXdJ+cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3V7zj1nC/4O8KEXi9uwJJwXhTfMwu8/u2gvbpTFgsDJgDdd8od+80veDILZ3VMUZ6f5QOztBF6icGHFcdTUUAj+VZyJg0EHt7tlSedX7bHvPLar8GMy6bFz0YRnnJrpMmN6dZE849MN4uMoxGSORQF4/9KqSB8Gis3j+EjlrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 64RDSO8s095410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 27 May 2026 21:28:24 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 May
 2026 21:28:24 +0800
From: CL Wang <cl634@andestech.com>
To: <vkoul@kernel.org>
CC: <Frank.Li@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <cl634@andestech.com>, <tim609@andestech.com>
Subject: [PATCH v3 0/3] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Wed, 27 May 2026 21:28:12 +0800
Message-ID: <20260527132815.1211195-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 64RDSO8s095410
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[andestech.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10975-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[cl634@andestech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.974];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51DD95E50A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series adds support for the Andes ATCDMAC300 DMA controller,
a memory-to-memory and peripheral DMA controller that provides
scatter-gather, cyclic, and slave transfer capabilities.

The ATCDMAC300 IP is embedded in AndesCore-based platforms or SoCs
such as AE350 and Qilai.

Changes in v3:
  - Rename DT binding file from andestech,qilai-dma.yaml to
    andestech,ae350-dma.yaml
  - Deprecate IP-core-based compatible and align with SoC/platform-based
    compatible strings
  - Dropped Acked-by from Conor Dooley due to the above binding change
  - Remove "andestech,atcdmac300" from of_device_id table
  - Replace deprecated tasklet with threaded IRQ using
    devm_request_threaded_irq() and IRQF_ONESHOT
  - Update locking from spin_lock_bh() to spin_lock_irqsave()
  - Use builtin_platform_driver() instead of module_platform_driver()
  - Remove "select DMATEST" from Kconfig
  - Add separate MAINTAINERS patch (patch 3/3)

Please kindly review.

CL Wang (3):
  dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
  dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller
  MAINTAINERS: Add entry for Andes ATCDMAC300

 .../bindings/dma/andestech,ae350-dma.yaml     |   68 +
 MAINTAINERS                                   |    6 +
 drivers/dma/Kconfig                           |   11 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/atcdmac300.c                      | 1505 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  296 ++++
 6 files changed, 1887 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

-- 
2.34.1


