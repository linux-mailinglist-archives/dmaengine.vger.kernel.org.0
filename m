Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38CB570D
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2019 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfIQUjA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Sep 2019 16:39:00 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:8999
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfIQUjA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Sep 2019 16:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoxK+6hdDGJ9DXibGkOyuf/1bPBITn7y22Pk442OF+RbQa2CVZfcJmI7fgahP/iBDPdmJLCezU6HVipOXCchV9J8F5UWh+eybjIjnI2da79h0ErcO0ABb7yxBpVUSrCFi2xTZ+HOKLFTqixPqx7A+opqsqSD8tWgFR5JJZVVownjIS5zoBbiB5GF0dMgte+GQJ7VlRvRz2fctKknd/kQm2vinUXf4IUP4a3dtG3Eb2zKdtd0Lt3qTDgJu99pKX+VQLGP6JOcDEx489t4dMjIi6QXDIAnAFGtBcQQiXVCgUqnMlQISckS+xG2YnMSq0Gy8qDR2TxZuJ3YXhOSOwVboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwXrvOmDVmVyq64hMbhAF0PuJaQpuzxzcUF+0Dlr9E8=;
 b=aIjj4mAqF1eEAJ9ypFbDqajMje1VHLC6yGd5AlsZmp3PNuO+Az1VDwFrsphtkdYO9fZ1KqjXg0lLSO1GLfHhRL+6Z0toco8BWVE6qEkrikhKxVacya+Jyz0P/bKSVyPZrXFE+NRScWHDHnAlM3MupAif8YDlDc4GveDiA7nAdaHfFWPLryfD/COJXRNuAWow0I4L8druuJBjMO7tminlzwiawHR+BDzU0vq4/wRh5OKKZ4hl6HFx7iKcJvzr+ZdzrVBmmvMiKZY2M4YZIdj+JfztoE7bkUWuDq0d4iy9t6u1veQ24Fs6xN0nVMTcBGJzkSBOBnBmgPeO8snr0g7fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwXrvOmDVmVyq64hMbhAF0PuJaQpuzxzcUF+0Dlr9E8=;
 b=ByTn29Hmt4cRE53rhz5BqLLt/QwproNSUEuawLXgEVVq9khPVKX9/yj0g++Nvubkqhtfls4MjUA23Af1swSQFybuiOXmcNaXL788Ioi52EdpgABxrvPdg2n1O4yOAAsyNLIzi6LYPXi+ruvmxgzJl7KzwPM6zeRchW0fm103UjQ=
Received: from BN6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:404:5f::24)
 by BN7PR02MB5329.namprd02.prod.outlook.com (2603:10b6:408:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13; Tue, 17 Sep
 2019 20:38:54 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR02CA0038.outlook.office365.com
 (2603:10b6:404:5f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.17 via Frontend
 Transport; Tue, 17 Sep 2019 20:38:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Tue, 17 Sep 2019 20:38:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <dylan.yip@xilinx.com>)
        id 1iAKFR-0006CB-1j
        for dmaengine@vger.kernel.org; Tue, 17 Sep 2019 13:38:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <dylan.yip@xilinx.com>)
        id 1iAKFL-0007lR-Ua
        for dmaengine@vger.kernel.org; Tue, 17 Sep 2019 13:38:47 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8HKceMQ012737;
        Tue, 17 Sep 2019 13:38:40 -0700
Received: from [172.19.2.242] (helo=xsjmadhurki50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <dylan.yip@xilinx.com>)
        id 1iAKFD-0007kn-U1; Tue, 17 Sep 2019 13:38:39 -0700
From:   Dylan Yip <dylan.yip@xilinx.com>
To:     dmaengine@vger.kernel.org, satishna@xilinx.com
Cc:     Dylan Yip <dylan.yip@xilinx.com>
Subject: [LINUX PATCH] dma-mapping: Control memset operation using gfp flags
Date:   Tue, 17 Sep 2019 13:38:35 -0700
Message-Id: <1568752715-11704-1-git-send-email-dylan.yip@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(476003)(486006)(7696005)(16586007)(8676002)(9786002)(6636002)(36386004)(50466002)(8936002)(48376002)(47776003)(36756003)(2616005)(81156014)(426003)(81166006)(6666004)(44832011)(356004)(106002)(4326008)(2906002)(107886003)(126002)(70586007)(186003)(305945005)(316002)(50226002)(336012)(478600001)(14444005)(70206006)(5660300002)(51416003)(26005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5329;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4283e08-03f8-4cf7-1b4d-08d73baf0e2f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN7PR02MB5329;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5329:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5329C1702975982D5FF13EEEB08F0@BN7PR02MB5329.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01630974C0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XdU5Cnv2+jHyDVq9aA0O3vqbqrgnM243bdwEG4U+XsvlEJnsKQnltvJw6wqw0ufisyoGIsZQ51K/J9uaJriJDiGxsSLkQCIlzPWvzs9I3fwRuQZ5ErP8hxJDMis6m7kUaD6foShT5WhoRqaFdvLdIKsT/oIEfj1HJrl/vnGDohWbDU8K7pav0bJBVS7rqqf4jH46W9bNaAGSRGzRGDecXkvBe8O0R5OckuTPkDCWsyms0yDf60Cg8V7dJFa91ytH4UuRiOvwYZ01uYqHW/d41g+NonffYMtc2M0VFxvCHvXV+im6CYLKlTfbSTxsX+fZk3X7qqAV5m3Y8Yt9O2+3Clh9dIdYk7fdZjuuP2rjQraOm+h2DLWCMNlhRNTD8BwbqZ/SI4CIRcRVf0fAhggXj1mjBPq3tRquvcSpEdTrq5k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 20:38:53.7096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4283e08-03f8-4cf7-1b4d-08d73baf0e2f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5329
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case of 4k video buffer, the allocation from a reserved memory is
taking a long time, ~500ms. This is root caused to the memset()
operations on the allocated memory which is consuming more cpu cycles.
Due to this delay, we see that initial frames are being dropped.

To fix this, we have wrapped the default memset, done when allocating
coherent memory, under the __GFP_ZERO flag. So, we only clear
allocated memory if __GFP_ZERO flag is enabled. We believe this
should be safe as the video decoder always writes before reading.
This optimizes decoder initialization as we do not set the __GFP_ZERO
flag when allocating memory for decoder. With this optimization, we
don't see initial frame drops and decoder initialization time is
~100ms.

This patch adds plumbing through dma_alloc functions to pass gfp flag
set by user to __dma_alloc_from_coherent(). Here gfp flag is checked
for __GFP_ZERO. If present, we memset the buffer to 0 otherwise we
skip memset.

Signed-off-by: Dylan Yip <dylan.yip@xilinx.com>
---
 arch/arm/mm/dma-mapping-nommu.c |  2 +-
 include/linux/dma-mapping.h     | 11 +++++++----
 kernel/dma/coherent.c           | 15 +++++++++------
 kernel/dma/mapping.c            |  2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 52b8255..242b2c3 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -35,7 +35,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 				 unsigned long attrs)
 
 {
-	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
+	void *ret = dma_alloc_from_global_coherent(size, dma_handle, gfp);
 
 	/*
 	 * dma_alloc_from_global_coherent() may fail because:
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea..b715c9f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -160,24 +160,27 @@ static inline int is_device_dma_capable(struct device *dev)
  * Don't use them in device drivers.
  */
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
-				       dma_addr_t *dma_handle, void **ret);
+				       dma_addr_t *dma_handle, void **ret,
+				       gfp_t flag);
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
 
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle,
+				     gfp_t flag);
 int dma_release_from_global_coherent(int order, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 				  size_t size, int *ret);
 
 #else
-#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
+#define dma_alloc_from_dev_coherent(dev, size, handle, ret, flag) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 
 static inline void *dma_alloc_from_global_coherent(ssize_t size,
-						   dma_addr_t *dma_handle)
+						   dma_addr_t *dma_handle,
+						   gfp_t flag)
 {
 	return NULL;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd659..d85fab5 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -136,7 +136,7 @@ void dma_release_declared_memory(struct device *dev)
 EXPORT_SYMBOL(dma_release_declared_memory);
 
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
-		ssize_t size, dma_addr_t *dma_handle)
+		ssize_t size, dma_addr_t *dma_handle, gfp_t gfp_flag)
 {
 	int order = get_order(size);
 	unsigned long flags;
@@ -158,7 +158,8 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
 	ret = mem->virt_base + (pageno << PAGE_SHIFT);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
-	memset(ret, 0, size);
+	if (gfp_flag & __GFP_ZERO)
+		memset(ret, 0, size);
 	return ret;
 err:
 	spin_unlock_irqrestore(&mem->spinlock, flags);
@@ -172,6 +173,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
  * @dma_handle:	This will be filled with the correct dma handle
  * @ret:	This pointer will be filled with the virtual address
  *		to allocated area.
+ * @flag:      gfp flag set by user
  *
  * This function should be only called from per-arch dma_alloc_coherent()
  * to support allocation from per-device coherent memory pools.
@@ -180,24 +182,25 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
  * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
  */
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
-		dma_addr_t *dma_handle, void **ret)
+		dma_addr_t *dma_handle, void **ret, gfp_t flag)
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
 	if (!mem)
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
+	*ret = __dma_alloc_from_coherent(mem, size, dma_handle, flag);
 	return 1;
 }
 
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle,
+				     gfp_t flag)
 {
 	if (!dma_coherent_default_memory)
 		return NULL;
 
 	return __dma_alloc_from_coherent(dma_coherent_default_memory, size,
-			dma_handle);
+			dma_handle, flag);
 }
 
 static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b0038ca..bfea1d2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -272,7 +272,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	WARN_ON_ONCE(!dev->coherent_dma_mask);
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
+	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr, flag))
 		return cpu_addr;
 
 	/* let the implementation decide on the zone to allocate from: */
-- 
2.7.4

