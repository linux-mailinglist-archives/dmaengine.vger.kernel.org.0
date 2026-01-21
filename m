Return-Path: <dmaengine+bounces-8439-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB5aEmQvcWmcfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8439-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:56:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAB5CA8C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03EA486BC17
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFA3C1981;
	Wed, 21 Jan 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuGGVB6w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7D3382C0;
	Wed, 21 Jan 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020498; cv=none; b=pVPAfxHYi6YYEQee8AMEEi9glqSpGcviyczEf3lun+SzgRJTSPyVgRgpPNorsa2OdPKdwXrSTDFm01h6M2iMWONF6Yhkh8TDzd+OkLgk21aw1jj65D27v5V0xl2H3jF0xocJE8uE2jRRurguyMj7dcaEU7SIvcNnS/X+6e3Q7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020498; c=relaxed/simple;
	bh=hWRj9Gm5OI5P+wlANzk0Wr1dMSXj/Z61cRcLS4GZ91Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nYekmO5Tjhgn5+DBZJJZV2871vi4GPLnH6spr0yrhhU0mjoFmGitr3uTEG5/0lSkEgXqk1i4Uur/+q0ZSrikIj4Gq6QwE4lJS0rQu5snLBifNn3+ZEqaGI2AhPmoXa6a5bHvhjztWg94GYaXpXmz/2bUScXmh2qHFPBIYp4QaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuGGVB6w; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020496; x=1800556496;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=hWRj9Gm5OI5P+wlANzk0Wr1dMSXj/Z61cRcLS4GZ91Q=;
  b=iuGGVB6w7p1mGCI4TxtJmPRvz/zcDyjssj2BOrBTHxyIs8zl7j1oog6A
   y+6kNLTzpMoEmLLbjrgfj4t82cDwY8mW3Tv3V4XJDdyHn3Xj9nY93y6Dh
   YTzzmFlrqlq430AsWlWpVeOPtWSiXPnxXqSCRG52qxr28XrrP7oxE6XZA
   PzRgtzndEW7EKhJayy4Bvfb3y+m93cJH4JGfeV49Qkyix9P0ZfmnmnccG
   r9vQLT6uO+A+dBZkrG5rUgPbCo2r9MiFWvMyc/5NHygdWjVY6Lm3DddUO
   JfH2pHpuX4xqBDpC5PYHhLSqRW85WUfra9gwj4GZ8IeRhcN+SUfV+pHRQ
   w==;
X-CSE-ConnectionGUID: v/3/ZpEhRXuqi4nz0Z4J0A==
X-CSE-MsgGUID: 7mWJGMBrR4CKKfsSr5aJMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349890"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349890"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:55 -0800
X-CSE-ConnectionGUID: NLf1FSUeTaiyZQkbR2El3w==
X-CSE-MsgGUID: UN/744EQTvGF8rZkeqDNLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678452"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v3 00/10] dmaengine: idxd: Memory leak and FLR fixes
Date: Wed, 21 Jan 2026 10:34:26 -0800
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQccWkC/5XPwQ6CMAwG4FcxO1vTbgzQk+9hPCB0uoibbrBoD
 O/u5MRRj3/TfH/7FpGD5Sh2q7cInGy03uWg1ivRXhp3ZrBdzkKi1FhjkeOzA2OfYPoA3sGVg+M
 eHiOPHCEpIGVU1Zy6iqpaZOYeOK/PFYdjzhcbBx9ec2Oi7/QPPBEgFIwSzclo2dLeuoH7Tetv4
 osnuQAl/QDKDOqt7oraNFjqdgGu57dLJNI/Q0xY5v1G8fKyaZo+LRSahmoBAAA=
X-Change-ID: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=2295;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=hWRj9Gm5OI5P+wlANzk0Wr1dMSXj/Z61cRcLS4GZ91Q=;
 b=4305r0WiOuB8q1/BDj4ekbqsiWKfUsHaxZd+Zz0x2x34FOKPQATmDqPEu4WGcaBqKqTYLj2eL
 d4B+a+EQkfNBLvkCJLlAQsJl2CjVxgG2e9vk3Rq4t/DSlxvxPmPbki+
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,intel.com:server fail,ams.mirrors.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8439-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 14CAB5CA8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

During testing some not so happy code paths in a debugging (lockdep,
kmemleak, etc) kernel, found a few issues.

No code changes, just rebased against 'dmaengine/next'. The cover
letter was edited to remove not helpful text.

Cheers,

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Changes in v3:
- Added missing lock to idxd_wq_flush_descs() (Dave Jiang);
- Link to v2: https://patch.msgid.link/20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com

Changes in v2:
- Fixed messing up the definition of FLR (Function Level
  Reset) (Nathan Lynch)
- Simplified callers of idxd_device_config(), moved a common check,
  and locking to inside the function (Dave Jiang);
- For idxd DMA backend, ->terminate_all() now flushes all pending
  descriptors (Dave Jiang);
- For idxd DMA backend, ->device_synchronize() now waits for submitted
  operations to finish (Dave Jiang);
- Link to v1: https://lore.kernel.org/r/20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com

---
Vinicius Costa Gomes (10):
      dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix possible invalid memory access after FLR
      dmaengine: idxd: Flush kernel workqueues on Function Level Reset
      dmaengine: idxd: Flush all pending descriptors
      dmaengine: idxd: Wait for submitted operations on .device_synchronize()
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

 drivers/dma/idxd/cdev.c   |  8 ++++----
 drivers/dma/idxd/device.c | 45 +++++++++++++++++++++++++++++++--------------
 drivers/dma/idxd/dma.c    | 18 ++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/init.c   | 14 +++++++-------
 drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
 drivers/dma/idxd/sysfs.c  |  1 +
 7 files changed, 78 insertions(+), 25 deletions(-)
---
base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
change-id: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178

Best regards,
--  
Vinicius


