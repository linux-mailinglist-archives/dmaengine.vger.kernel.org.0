Return-Path: <dmaengine+bounces-4815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B6A7B763
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 07:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F063188A4DE
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB1149E17;
	Fri,  4 Apr 2025 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijh/Sg5N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED222E62C0;
	Fri,  4 Apr 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744982; cv=none; b=Bxzb+y5ZgbTsDzAXQGoo54YtcDkyQxdH6P+geeN9jt5p2IV047hZJGka8oalV7E+SOLeudfS2Lw3nM02kGCg4z9OJKHZUeZxCfcxyc2EMxEId/DMiPyHSwn71XvSTxAqwmxv0xMlRM50yAgwk1kc7siL5Zd7wQImJCiq+3tS9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744982; c=relaxed/simple;
	bh=sH0klwIb6iMG8a+GHaUTW6izLmJ4ZdiWbxeMoGEK6Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fztmDhDC4bKOeFOHHwOmwNTyh08m0iH/7IJgP6qbX2ziMCar+oxAnXjTB6xefV5FkDv0DyF6LXPAFm5rGPX38KCkznH2ErDiBO8XHM0i17q1Kce2RPhQk+HFs2hZZUtC0xXnjTBOf+fwR3LjSHkjYGu0MQvE4W5J+pq0CGXuq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijh/Sg5N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743744981; x=1775280981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sH0klwIb6iMG8a+GHaUTW6izLmJ4ZdiWbxeMoGEK6Zs=;
  b=ijh/Sg5N6BHTLD8T6yhKRhmkBK+8pjA3JgdIx9i4VOJk0aUUse03j4Gd
   Lc1LXuVnYCLSQwT1JmnniKLxPNMIvlz4Gg9y/zHBE7IxOT7WdU0sRSx0F
   pZ3cuF6/aAYJGmJ1fPJRooc/e7pE5TURkn0g7H4allg71unxVW1S5grTy
   zzokt99iAZ1sKyK3przSWE4hU+rqzMa9kIUrA580qZn36kRvtTDhjJiZH
   vP7oz3k0Ke0qMlxefUJ4p5A8dnbatFd/YgK3fyVJOiNPoHqjXy+8MwAJt
   vcWJDb4tNCrxy/1q9T9cRuOM3N22WgJjQFQm6Df61imj1vHIeFXH2XAsV
   A==;
X-CSE-ConnectionGUID: s/fLSZZFRN+Ef0EeflXcpA==
X-CSE-MsgGUID: RM/F3UOqQsamn0a3bw+SQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48831681"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="48831681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:36:19 -0700
X-CSE-ConnectionGUID: RuBuIHTUR52g5wLw1mubMA==
X-CSE-MsgGUID: vBGKuWHCQpmsz0qboZ0Elg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="158191484"
Received: from ysun46-mobl1.sh.intel.com ([10.239.161.21])
  by orviesa002.jf.intel.com with ESMTP; 03 Apr 2025 22:36:16 -0700
From: Yi Sun <yi.sun@intel.com>
To: vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com,
	yi.sun@linux.intel.com,
	Yi Sun <yi.sun@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Subject: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Date: Fri,  4 Apr 2025 13:36:14 +0800
Message-ID: <20250404053614.3096769-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __packed attribute introduces potential unaligned memory accesses
and endianness portability issues. Instead of relying on compiler-specific
packing, it's much better to explicitly fill structure gaps using padding
fields, ensuring natural alignment.

Since all previously __packed structures already enforce proper alignment
through manual padding, the __packed qualifiers are unnecessary and can be
safely removed.

Signed-off-by: Yi Sun <yi.sun@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

---
Changelog:
- v2: Change the subject to match idxd driver patch convention (Fenghua)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 006ba206ab1b..9c1c546fe443 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -45,7 +45,7 @@ union gen_cap_reg {
 		u64 rsvd3:32;
 	};
 	u64 bits;
-} __packed;
+};
 #define IDXD_GENCAP_OFFSET		0x10
 
 union wq_cap_reg {
@@ -65,7 +65,7 @@ union wq_cap_reg {
 		u64 rsvd4:8;
 	};
 	u64 bits;
-} __packed;
+};
 #define IDXD_WQCAP_OFFSET		0x20
 #define IDXD_WQCFG_MIN			5
 
@@ -79,7 +79,7 @@ union group_cap_reg {
 		u64 rsvd:45;
 	};
 	u64 bits;
-} __packed;
+};
 #define IDXD_GRPCAP_OFFSET		0x30
 
 union engine_cap_reg {
@@ -88,7 +88,7 @@ union engine_cap_reg {
 		u64 rsvd:56;
 	};
 	u64 bits;
-} __packed;
+};
 
 #define IDXD_ENGCAP_OFFSET		0x38
 
@@ -114,7 +114,7 @@ union offsets_reg {
 		u64 rsvd:48;
 	};
 	u64 bits[2];
-} __packed;
+};
 
 #define IDXD_TABLE_MULT			0x100
 
@@ -128,7 +128,7 @@ union gencfg_reg {
 		u32 rsvd2:18;
 	};
 	u32 bits;
-} __packed;
+};
 
 #define IDXD_GENCTRL_OFFSET		0x88
 union genctrl_reg {
@@ -139,7 +139,7 @@ union genctrl_reg {
 		u32 rsvd:29;
 	};
 	u32 bits;
-} __packed;
+};
 
 #define IDXD_GENSTATS_OFFSET		0x90
 union gensts_reg {
@@ -149,7 +149,7 @@ union gensts_reg {
 		u32 rsvd:28;
 	};
 	u32 bits;
-} __packed;
+};
 
 enum idxd_device_status_state {
 	IDXD_DEVICE_STATE_DISABLED = 0,
@@ -183,7 +183,7 @@ union idxd_command_reg {
 		u32 int_req:1;
 	};
 	u32 bits;
-} __packed;
+};
 
 enum idxd_cmd {
 	IDXD_CMD_ENABLE_DEVICE = 1,
@@ -213,7 +213,7 @@ union cmdsts_reg {
 		u8 active:1;
 	};
 	u32 bits;
-} __packed;
+};
 #define IDXD_CMDSTS_ACTIVE		0x80000000
 #define IDXD_CMDSTS_ERR_MASK		0xff
 #define IDXD_CMDSTS_RES_SHIFT		8
@@ -284,7 +284,7 @@ union sw_err_reg {
 		u64 rsvd5;
 	};
 	u64 bits[4];
-} __packed;
+};
 
 union iaa_cap_reg {
 	struct {
@@ -303,7 +303,7 @@ union iaa_cap_reg {
 		u64 rsvd:52;
 	};
 	u64 bits;
-} __packed;
+};
 
 #define IDXD_IAACAP_OFFSET	0x180
 
@@ -320,7 +320,7 @@ union evlcfg_reg {
 		u64 rsvd2:28;
 	};
 	u64 bits[2];
-} __packed;
+};
 
 #define IDXD_EVL_SIZE_MIN	0x0040
 #define IDXD_EVL_SIZE_MAX	0xffff
@@ -334,7 +334,7 @@ union msix_perm {
 		u32 pasid:20;
 	};
 	u32 bits;
-} __packed;
+};
 
 union group_flags {
 	struct {
@@ -352,13 +352,13 @@ union group_flags {
 		u64 rsvd5:26;
 	};
 	u64 bits;
-} __packed;
+};
 
 struct grpcfg {
 	u64 wqs[4];
 	u64 engines;
 	union group_flags flags;
-} __packed;
+};
 
 union wqcfg {
 	struct {
@@ -410,7 +410,7 @@ union wqcfg {
 		u64 op_config[4];
 	};
 	u32 bits[16];
-} __packed;
+};
 
 #define WQCFG_PASID_IDX                2
 #define WQCFG_PRIVL_IDX		2
@@ -474,7 +474,7 @@ union idxd_perfcap {
 		u64 rsvd3:8;
 	};
 	u64 bits;
-} __packed;
+};
 
 #define IDXD_EVNTCAP_OFFSET		0x80
 union idxd_evntcap {
@@ -483,7 +483,7 @@ union idxd_evntcap {
 		u64 rsvd:36;
 	};
 	u64 bits;
-} __packed;
+};
 
 struct idxd_event {
 	union {
@@ -493,7 +493,7 @@ struct idxd_event {
 		};
 		u32 val;
 	};
-} __packed;
+};
 
 #define IDXD_CNTRCAP_OFFSET		0x800
 struct idxd_cntrcap {
@@ -506,7 +506,7 @@ struct idxd_cntrcap {
 		u32 val;
 	};
 	struct idxd_event events[];
-} __packed;
+};
 
 #define IDXD_PERFRST_OFFSET		0x10
 union idxd_perfrst {
@@ -516,7 +516,7 @@ union idxd_perfrst {
 		u32 rsvd:30;
 	};
 	u32 val;
-} __packed;
+};
 
 #define IDXD_OVFSTATUS_OFFSET		0x30
 #define IDXD_PERFFRZ_OFFSET		0x20
@@ -533,7 +533,7 @@ union idxd_cntrcfg {
 		u64 rsvd3:4;
 	};
 	u64 val;
-} __packed;
+};
 
 #define IDXD_FLTCFG_OFFSET		0x300
 
@@ -543,7 +543,7 @@ union idxd_cntrdata {
 		u64 event_count_value;
 	};
 	u64 val;
-} __packed;
+};
 
 union event_cfg {
 	struct {
@@ -551,7 +551,7 @@ union event_cfg {
 		u64 event_enc:28;
 	};
 	u64 val;
-} __packed;
+};
 
 union filter_cfg {
 	struct {
@@ -562,7 +562,7 @@ union filter_cfg {
 		u64 eng:8;
 	};
 	u64 val;
-} __packed;
+};
 
 #define IDXD_EVLSTATUS_OFFSET		0xf0
 
@@ -580,7 +580,7 @@ union evl_status_reg {
 		u32 bits_upper32;
 	};
 	u64 bits;
-} __packed;
+};
 
 #define IDXD_MAX_BATCH_IDENT	256
 
@@ -620,17 +620,17 @@ struct __evl_entry {
 	};
 	u64 fault_addr;
 	u64 rsvd5;
-} __packed;
+};
 
 struct dsa_evl_entry {
 	struct __evl_entry e;
 	struct dsa_completion_record cr;
-} __packed;
+};
 
 struct iax_evl_entry {
 	struct __evl_entry e;
 	u64 rsvd[4];
 	struct iax_completion_record cr;
-} __packed;
+};
 
 #endif
-- 
2.43.0


