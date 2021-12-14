Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64A474C94
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhLNUXO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 15:23:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:26058 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhLNUXM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Dec 2021 15:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639513392; x=1671049392;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80llF18aTTSdQDqrfqSVWy3RIVT/txIDomhlHD19L58=;
  b=LqoRppoJy8lRngqFjyrLCRcNX72241eI53GxbpjmxfJLzQWnPYARS8WT
   5OdnA+a/NDaiFYIJadrm2nD1g+i7Iwllq7BD7GgsZm8ExgXloFOIMRchZ
   ZYtXhqm6povi2lPh30UPXr/XAlujZ1o/CAt18eHsyRl13FLOEV0Lo8H15
   skB8JxOpkDticuR0Lvl+Yy58SQfO2C7xvfW4E6/wRMtNLTb0iC3PdoPq6
   LS+FiyvPx5fSbpEmQKX5i1G0NLa4vqW2k3FuDom1IM9Fpl8sgpq6du1Rf
   M/2kpD/46Ctj/C1rzDTOSWt+ptKM4jYRUiU4+9bch+kd08TWUYQ7DaCee
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302455609"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="302455609"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="754942347"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:09 -0800
Subject: [PATCH 1/2] dmaengine: idxd: change bandwidth token to read buffers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 14 Dec 2021 13:23:09 -0700
Message-ID: <163951338932.2988321.6162640806935567317.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
References: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec v1.2 has changed the term of "bandwidth tokens" to "read buffers"
in order to make the concept clearer. Deprecate bandwidth token
naming in the driver and convert to read buffers in order to match with
the spec and reduce confusion when reading the spec.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   25 ++++++++++++-------------
 drivers/dma/idxd/idxd.h      |   12 ++++++------
 drivers/dma/idxd/init.c      |    6 +++---
 drivers/dma/idxd/registers.h |   14 +++++++-------
 drivers/dma/idxd/sysfs.c     |   42 +++++++++++++++++++++---------------------
 5 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3fce7629daa7..573ad8b86804 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -678,9 +678,9 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 		memset(&group->grpcfg, 0, sizeof(group->grpcfg));
 		group->num_engines = 0;
 		group->num_wqs = 0;
-		group->use_token_limit = false;
-		group->tokens_allowed = 0;
-		group->tokens_reserved = 0;
+		group->use_rdbuf_limit = false;
+		group->rdbufs_allowed = 0;
+		group->rdbufs_reserved = 0;
 		group->tc_a = -1;
 		group->tc_b = -1;
 	}
@@ -748,10 +748,10 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 	int i;
 	struct device *dev = &idxd->pdev->dev;
 
-	/* Setup bandwidth token limit */
-	if (idxd->hw.gen_cap.config_en && idxd->token_limit) {
+	/* Setup bandwidth rdbuf limit */
+	if (idxd->hw.gen_cap.config_en && idxd->rdbuf_limit) {
 		reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-		reg.token_limit = idxd->token_limit;
+		reg.rdbuf_limit = idxd->rdbuf_limit;
 		iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 	}
 
@@ -889,13 +889,12 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 			group->tc_b = group->grpcfg.flags.tc_b = 1;
 		else
 			group->grpcfg.flags.tc_b = group->tc_b;
-		group->grpcfg.flags.use_token_limit = group->use_token_limit;
-		group->grpcfg.flags.tokens_reserved = group->tokens_reserved;
-		if (group->tokens_allowed)
-			group->grpcfg.flags.tokens_allowed =
-				group->tokens_allowed;
+		group->grpcfg.flags.use_rdbuf_limit = group->use_rdbuf_limit;
+		group->grpcfg.flags.rdbufs_reserved = group->rdbufs_reserved;
+		if (group->rdbufs_allowed)
+			group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
 		else
-			group->grpcfg.flags.tokens_allowed = idxd->max_tokens;
+			group->grpcfg.flags.rdbufs_allowed = idxd->max_rdbufs;
 	}
 }
 
@@ -1086,7 +1085,7 @@ int idxd_device_load_config(struct idxd_device *idxd)
 	int i, rc;
 
 	reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	idxd->token_limit = reg.token_limit;
+	idxd->rdbuf_limit = reg.rdbuf_limit;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *group = idxd->groups[i];
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 6353e762286d..da72eb15f610 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -90,9 +90,9 @@ struct idxd_group {
 	int id;
 	int num_engines;
 	int num_wqs;
-	bool use_token_limit;
-	u8 tokens_allowed;
-	u8 tokens_reserved;
+	bool use_rdbuf_limit;
+	u8 rdbufs_allowed;
+	u8 rdbufs_reserved;
 	int tc_a;
 	int tc_b;
 };
@@ -292,11 +292,11 @@ struct idxd_device {
 	u32 max_batch_size;
 	int max_groups;
 	int max_engines;
-	int max_tokens;
+	int max_rdbufs;
 	int max_wqs;
 	int max_wq_size;
-	int token_limit;
-	int nr_tokens;		/* non-reserved tokens */
+	int rdbuf_limit;
+	int nr_rdbufs;		/* non-reserved read buffers */
 	unsigned int wqcfg_size;
 
 	union sw_err_reg sw_err;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 3505efb7ae71..08a5f4310188 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -400,9 +400,9 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	dev_dbg(dev, "group_cap: %#llx\n", idxd->hw.group_cap.bits);
 	idxd->max_groups = idxd->hw.group_cap.num_groups;
 	dev_dbg(dev, "max groups: %u\n", idxd->max_groups);
-	idxd->max_tokens = idxd->hw.group_cap.total_tokens;
-	dev_dbg(dev, "max tokens: %u\n", idxd->max_tokens);
-	idxd->nr_tokens = idxd->max_tokens;
+	idxd->max_rdbufs = idxd->hw.group_cap.total_rdbufs;
+	dev_dbg(dev, "max read buffers: %u\n", idxd->max_rdbufs);
+	idxd->nr_rdbufs = idxd->max_rdbufs;
 
 	/* read engine capabilities */
 	idxd->hw.engine_cap.bits =
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 8e396698c22b..aa642aecdc0b 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -64,9 +64,9 @@ union wq_cap_reg {
 union group_cap_reg {
 	struct {
 		u64 num_groups:8;
-		u64 total_tokens:8;
-		u64 token_en:1;
-		u64 token_limit:1;
+		u64 total_rdbufs:8;	/* formerly total_tokens */
+		u64 rdbuf_ctrl:1;	/* formerly token_en */
+		u64 rdbuf_limit:1;	/* formerly token_limit */
 		u64 rsvd:46;
 	};
 	u64 bits;
@@ -110,7 +110,7 @@ union offsets_reg {
 #define IDXD_GENCFG_OFFSET		0x80
 union gencfg_reg {
 	struct {
-		u32 token_limit:8;
+		u32 rdbuf_limit:8;
 		u32 rsvd:4;
 		u32 user_int_en:1;
 		u32 rsvd2:19;
@@ -288,10 +288,10 @@ union group_flags {
 		u32 tc_a:3;
 		u32 tc_b:3;
 		u32 rsvd:1;
-		u32 use_token_limit:1;
-		u32 tokens_reserved:8;
+		u32 use_rdbuf_limit:1;
+		u32 rdbufs_reserved:8;
 		u32 rsvd2:4;
-		u32 tokens_allowed:8;
+		u32 rdbufs_allowed:8;
 		u32 rsvd3:4;
 	};
 	u32 bits;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 13404532131b..6f1ebf08878a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -99,17 +99,17 @@ struct device_type idxd_engine_device_type = {
 
 /* Group attributes */
 
-static void idxd_set_free_tokens(struct idxd_device *idxd)
+static void idxd_set_free_rdbufs(struct idxd_device *idxd)
 {
-	int i, tokens;
+	int i, rdbufs;
 
-	for (i = 0, tokens = 0; i < idxd->max_groups; i++) {
+	for (i = 0, rdbufs = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *g = idxd->groups[i];
 
-		tokens += g->tokens_reserved;
+		rdbufs += g->rdbufs_reserved;
 	}
 
-	idxd->nr_tokens = idxd->max_tokens - tokens;
+	idxd->nr_rdbufs = idxd->max_rdbufs - rdbufs;
 }
 
 static ssize_t group_tokens_reserved_show(struct device *dev,
@@ -118,7 +118,7 @@ static ssize_t group_tokens_reserved_show(struct device *dev,
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
-	return sysfs_emit(buf, "%u\n", group->tokens_reserved);
+	return sysfs_emit(buf, "%u\n", group->rdbufs_reserved);
 }
 
 static ssize_t group_tokens_reserved_store(struct device *dev,
@@ -143,14 +143,14 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
-	if (val > idxd->max_tokens)
+	if (val > idxd->max_rdbufs)
 		return -EINVAL;
 
-	if (val > idxd->nr_tokens + group->tokens_reserved)
+	if (val > idxd->nr_rdbufs + group->rdbufs_reserved)
 		return -EINVAL;
 
-	group->tokens_reserved = val;
-	idxd_set_free_tokens(idxd);
+	group->rdbufs_reserved = val;
+	idxd_set_free_rdbufs(idxd);
 	return count;
 }
 
@@ -164,7 +164,7 @@ static ssize_t group_tokens_allowed_show(struct device *dev,
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
-	return sysfs_emit(buf, "%u\n", group->tokens_allowed);
+	return sysfs_emit(buf, "%u\n", group->rdbufs_allowed);
 }
 
 static ssize_t group_tokens_allowed_store(struct device *dev,
@@ -190,10 +190,10 @@ static ssize_t group_tokens_allowed_store(struct device *dev,
 		return -EPERM;
 
 	if (val < 4 * group->num_engines ||
-	    val > group->tokens_reserved + idxd->nr_tokens)
+	    val > group->rdbufs_reserved + idxd->nr_rdbufs)
 		return -EINVAL;
 
-	group->tokens_allowed = val;
+	group->rdbufs_allowed = val;
 	return count;
 }
 
@@ -207,7 +207,7 @@ static ssize_t group_use_token_limit_show(struct device *dev,
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
-	return sysfs_emit(buf, "%u\n", group->use_token_limit);
+	return sysfs_emit(buf, "%u\n", group->use_rdbuf_limit);
 }
 
 static ssize_t group_use_token_limit_store(struct device *dev,
@@ -232,10 +232,10 @@ static ssize_t group_use_token_limit_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
-	if (idxd->token_limit == 0)
+	if (idxd->rdbuf_limit == 0)
 		return -EPERM;
 
-	group->use_token_limit = !!val;
+	group->use_rdbuf_limit = !!val;
 	return count;
 }
 
@@ -1197,7 +1197,7 @@ static ssize_t max_tokens_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	return sysfs_emit(buf, "%u\n", idxd->max_tokens);
+	return sysfs_emit(buf, "%u\n", idxd->max_rdbufs);
 }
 static DEVICE_ATTR_RO(max_tokens);
 
@@ -1206,7 +1206,7 @@ static ssize_t token_limit_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	return sysfs_emit(buf, "%u\n", idxd->token_limit);
+	return sysfs_emit(buf, "%u\n", idxd->rdbuf_limit);
 }
 
 static ssize_t token_limit_store(struct device *dev,
@@ -1227,13 +1227,13 @@ static ssize_t token_limit_store(struct device *dev,
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
-	if (!idxd->hw.group_cap.token_limit)
+	if (!idxd->hw.group_cap.rdbuf_limit)
 		return -EPERM;
 
-	if (val > idxd->hw.group_cap.total_tokens)
+	if (val > idxd->hw.group_cap.total_rdbufs)
 		return -EINVAL;
 
-	idxd->token_limit = val;
+	idxd->rdbuf_limit = val;
 	return count;
 }
 static DEVICE_ATTR_RW(token_limit);


