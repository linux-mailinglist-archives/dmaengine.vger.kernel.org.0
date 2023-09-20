Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62627A8DB2
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjITUTW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjITUTV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:19:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DCBB;
        Wed, 20 Sep 2023 13:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIesLwc8WbHCGfK1BIr8XpLFT1FjGziVQt8nN/Zb9tOM2/U1HZwLYy/Lqe/jbBLxGd8/gZSM2QMr8ivTliWxnIzuatZKJ70yrShz756PF8HoNzyAIWcS+d/5yMa5WtqD1WH5kOZEwBryH3riT8Gf8Gaau/4ME3NKetZ4VRmrDzCR9WdB58JgFzAgonj2cDk0GSF6DHCW1SaAtXHN2Wni8PWw3w9U8Jrv8wNFc7ekadmDgA73eXkubCALJuFsoYObS+8Wjnj6JAMdZLEFjFnyggLFcsDmuVrocRC0i9uGaIxqo/L0q+1hWwwJOo0fBp00oA+Y+u5EqOttCiWatR8aUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7UL96OhVHBAKyJd8PS1Vq3LsJ9v9ZzBYW/nGw949d8=;
 b=fVILPk4qtkbJYdtWox2/QT167qXAuz0bbaKSN/ZbtnC5wHBe4vZbQkQ4CPxI4OKBRx4zNzr5X5bglE70yMcLmUXF1KVfsd44eatXVcScyHTf+OnM1SA8MLHVfKQUEjvETFpC2XhSt1QwwIxgPW8s7fIl+eeAWiiP/NKOMnJewuvU1PCSnGj92PAAGsCJ0l7hwa0af+z81a8zNFIqirP3PaLWCxv+IqTtNrPpYXpfPLPzellnn1pKBDiSNFiH3TkbEbeBoyZisTqduZDp+qXQca7r10VS3pQ3Lzv9D5NN7FFrRM0wBrT+oxQnLEqYYxZhJHZJM645DfGl4AeJqk03tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7UL96OhVHBAKyJd8PS1Vq3LsJ9v9ZzBYW/nGw949d8=;
 b=KYi337xM8TNg99gGip5ag95DlBXOOtBbxoLceyq5RjCAXziM0UyXcmKv7RJPbcPRX+nz1RrGiiBQF5AQGbA8vBtRaXJAf3LIzGO6KzGF9uhTBN2lltrTVUI9WNdsUkKX6yVicGime7mS3co670UPSzqiC9r2TPOtiDzbFx9L0eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:19:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:19:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lkp@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        vkoul@kernel.org
Subject: [PATCH v3 1/3] debugfs_create_regset32() support 8/16/64 bit width registers
Date:   Wed, 20 Sep 2023 16:18:50 -0400
Message-Id: <20230920201852.3170104-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920201852.3170104-1-Frank.Li@nxp.com>
References: <20230920201852.3170104-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 12df183f-f58d-4c82-8a6e-08dbba16da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho5IoJpmncIl+4cQQbT/ckEPnyFn7SMmJ2p+oYbEPEjOnZJt4dEDOwvzH08c80qIVg7oVhB1ERK21NVP/8UF6Z0oUPv8KsEv46Rw0C6zTn+rtkyMss/iP89qFd4BxzkAztVLLZA2WtHfYP9pPHJycAIPPW8CmpZfWVuqtEGYXOttoV8RkXRfFqicbQGgJ6Ao/IcJmwcVgpANWyyGGjWBYw/EKIRwtg6ufb8MWl38VFpLA46nIfbArTvDPdooLFMsWN4xu5D+AbgdfeXby/cjaTY0HAnGejI1yLDeKLtUalo3vvGLrgHsYH3ya6KFCCBA0uFXyQKa0MiGUtMofsi4GzarcRGj2LyIjZllvzlxYZFAt5sv9Wft3bm83795TvLPPV50eQ1++gG3QIYOglcFNJLbGlAUm/Nwmra3FA6VXpVz4SeusyMuYkozmApHdqAvZ5m9BCfhUEcynfcxvlN1q2oF/jykDn3rBrIcASmy2YQ9bCImKdatKfZx4Ff3VDWW3y9o0XMRHMWGRCQERXF9M5v0A9DM7RBdATPkGVT8e2hsseMMUILTB75tuibk0aqXLl+I1HF+CiuMzqaS9HyFV3+PJr0TxSZa9isjsU/kThepGFVK1xMMmOfFE6kJP8B2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(6512007)(52116002)(66899024)(6486002)(6506007)(6666004)(38350700002)(86362001)(38100700002)(83380400001)(36756003)(2616005)(1076003)(26005)(66476007)(316002)(66946007)(66556008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBaUpYGXIq5q2Q5GT8MvV+jW2AituXPA9ykfefzX2VCFtMGpOn5yh7gFKWBz?=
 =?us-ascii?Q?T/1o1FTKZGyf7OggPRJporHxIWfab+Mgu5dKjSmDTOM7fXZfncoJrxkbL59x?=
 =?us-ascii?Q?b6Ps5BreR+i0M1+PBPIB1L7V6xpacl0diBKGwcxo6X7t0v9OHKWmnzP7dmdq?=
 =?us-ascii?Q?awnf7Qeg0t34JQBvqXiQnH3VZf0ZwdHxt3TxCiQHA9Xq1persnic2fRDN2+u?=
 =?us-ascii?Q?HrRu7kXYrGRghxq2Rq3Ct1aDxMpx7AWUlSX7C2sls/XZNtde2qWpyBWHS98Y?=
 =?us-ascii?Q?XHnAJysIPJ+fDf8uscEZQ0a2Ttm6YsuKzfigfTWD6wELY2aBMwjC+4hvsEjc?=
 =?us-ascii?Q?qT7ZWKbXos2LyyDeiyM3cva0/6ZkfEfl/VAO3BAnP/UUJIvwH9wcXe2fPInA?=
 =?us-ascii?Q?oVvPAbcXcV2+/Z7eb32sWO2HHJqfnEwQLcuGRHYs0Qw3gQDd3QmCIh8JJs/w?=
 =?us-ascii?Q?rLEZty5aMU05DCdCP84apwh1tnGL8mgzI/Ph9DYUO7wvJZ2Dmt2nlCQv1MLv?=
 =?us-ascii?Q?JbeSP8pdQNnnRaal+/9V7KjnDO8gLvsaMVOiHrVkITGAIsvT+CSVl3zf5mps?=
 =?us-ascii?Q?tLhhQxjtfR/xyTK57p9/TpVXntC0ad8cuxKgzRZpuGSAj0OXH/uOACPoxv+e?=
 =?us-ascii?Q?Sr3BmM4ekE1IHokMjTn+D+BlrrEYGQkiRxRoQ3gJLbx8njuc5NRblv4eHyyS?=
 =?us-ascii?Q?IDLmSX51PBKWDI5iidRCnthXN1yUjpbYUCSmgoP8V2oUPF0Ls2F4pDeTaGVB?=
 =?us-ascii?Q?n5NHPUqMGhNMsPr5KFd6b39vbDWnJn/UCjJ5d+KUeObqqAl2AvoHLfuufVDc?=
 =?us-ascii?Q?gOe0E7RJvODy6vvpFig3JqzpWvwFfmnKzcaBG69DrG14IBrA68VwoEo4N5fI?=
 =?us-ascii?Q?5qhPNaRw/5WlVN654scvLjl2hwJTJQF4O3YeKKKAvUU9bxqgmQkP/fZusoYV?=
 =?us-ascii?Q?Yzhxzh67ZclmHN5kOkLvkHX+VsppfJzB3kHBbcvE1lisaAOeXWAXDdzx0qFR?=
 =?us-ascii?Q?725FjJk7PZ6HGwdnynQsRPsXaLAsXfX+/3Eqjnn9geiJQSjllG68VKwYy8hP?=
 =?us-ascii?Q?rLzOSP8dgxjn6ax2FEmgmMy0pXutTjPFt8/Qb5Kp0CZUqrxWMZOfxgRATxLM?=
 =?us-ascii?Q?R5VHW6Wh9jnxZ3cFqJBsv3F/KOujTxLb0F+M3SZW7K38nrbGr4UEew7PjYnf?=
 =?us-ascii?Q?aNKzhv6K8esopY/oWyWfGguHwOBASfh4GK4rPjHHf2JAK08gkqbtNE5cmqZp?=
 =?us-ascii?Q?OLfx9TgBrpDJvxcIV6lpLFfH9/k5SLEcN8VPpC+8uvUj/4fiG9fnkkMJVBMC?=
 =?us-ascii?Q?OjKDsHeOa7VK2vZKzS1mKZCbJOn1GYS17TVhq5DQu16+HGuK/otUNG9GHrdL?=
 =?us-ascii?Q?mXGb/uWG8TdRjexsA00gS7ywUGv+YGffjbRGU2qVwPFoguEDLZN5/2NxpCH5?=
 =?us-ascii?Q?S+N33b1pdOdvE2MV39XlYBd4jfU0H/wCIdqqMrt2aDu068jVz6KJcqIzI7mu?=
 =?us-ascii?Q?HQyGCYQJ3VFXh5ck+bBLm4/05wzy42qNxibo5H28yn3WhG8MVDXOr3Kv7P5d?=
 =?us-ascii?Q?bhT/eOYehs5R14O7xB2RGPjwv5exRAlEdJ2AaKpM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12df183f-f58d-4c82-8a6e-08dbba16da57
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:19:11.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZrGCJwJ+BlXFDE8ySOSlDebFk0lfc7MxzwdrkKLIs9wLkRu2rBZZLTOcThUuR1cr0cqJJs5wVH8GCSEumbZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enhance the flexibility of `debugfs_create_regset32()` to support registers
of various bit widths. The key changes are as follows:

1. Renamed '*reg32' and '*regset32' to '*reg' and '*regset' in relevant
   code to reflect that the register width is not limited to 32 bits.

2. Added 'size' and 'bigendian' fields to the `struct debugfs_reg` to allow
   for specifying the size and endianness of registers. These additions
   enable `debugfs_create_regset()` to support a wider range of register
   types.

3. When 'size' is set to 0, it signifies a 32-bit register. This change
   maintains compatibility with existing code that assumes 32-bit
   registers.

Improve the versatility of `debugfs_create_regset()` and enable it to
handle registers of different sizes and endianness, offering greater
flexibility for debugging and monitoring.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 fs/debugfs/file.c       | 59 ++++++++++++++++++++++++++++-------------
 include/linux/debugfs.h | 17 +++++++++---
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1e..5b8d4fd7c7476 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1137,15 +1137,15 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
 #ifdef CONFIG_HAS_IOMEM
 
 /*
- * The regset32 stuff is used to print 32-bit registers using the
+ * The regset stuff is used to print 32-bit registers using the
  * seq_file utilities. We offer printing a register set in an already-opened
- * sequential file or create a debugfs file that only prints a regset32.
+ * sequential file or create a debugfs file that only prints a regset.
  */
 
 /**
- * debugfs_print_regs32 - use seq_print to describe a set of registers
+ * debugfs_print_regs - use seq_print to describe a set of registers
  * @s: the seq_file structure being used to generate output
- * @regs: an array if struct debugfs_reg32 structures
+ * @regs: an array if struct debugfs_reg structures
  * @nregs: the length of the above array
  * @base: the base address to be used in reading the registers
  * @prefix: a string to be prefixed to every output line
@@ -1157,30 +1157,53 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
  * because some peripherals have several blocks of identical registers,
  * for example configuration of dma channels
  */
-void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
+void debugfs_print_regs(struct seq_file *s, const struct debugfs_reg *regs,
 			  int nregs, void __iomem *base, char *prefix)
 {
+	void __iomem *reg;
+	bool b;
 	int i;
 
 	for (i = 0; i < nregs; i++, regs++) {
 		if (prefix)
 			seq_printf(s, "%s", prefix);
-		seq_printf(s, "%s = 0x%08x\n", regs->name,
-			   readl(base + regs->offset));
+
+		b = regs->bigendian;
+		reg = base + regs->offset;
+
+		switch (regs->size) {
+		case sizeof(u8):
+			seq_printf(s, "%s = 0x%02x\n", regs->name, ioread8(reg));
+			break;
+		case sizeof(u16):
+			seq_printf(s, "%s = 0x%04x\n", regs->name,
+				  b ? ioread16be(reg) : ioread16(reg));
+			break;
+#ifdef CONFIG_64BIT
+		case sizeof(u64):
+			seq_printf(s, "%s = 0x%016llx\n", regs->name,
+				   b ? ioread64be(reg) : ioread64(reg));
+			break;
+#endif
+		default:
+			seq_printf(s, "%s = 0x%08x\n", regs->name,
+				   b ? ioread32be(reg) : ioread32(reg));
+		}
+
 		if (seq_has_overflowed(s))
 			break;
 	}
 }
-EXPORT_SYMBOL_GPL(debugfs_print_regs32);
+EXPORT_SYMBOL_GPL(debugfs_print_regs);
 
-static int debugfs_regset32_show(struct seq_file *s, void *data)
+static int debugfs_regset_show(struct seq_file *s, void *data)
 {
-	struct debugfs_regset32 *regset = s->private;
+	struct debugfs_regset *regset = s->private;
 
 	if (regset->dev)
 		pm_runtime_get_sync(regset->dev);
 
-	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
+	debugfs_print_regs(s, regset->regs, regset->nregs, regset->base, "");
 
 	if (regset->dev)
 		pm_runtime_put(regset->dev);
@@ -1188,16 +1211,16 @@ static int debugfs_regset32_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
+DEFINE_SHOW_ATTRIBUTE(debugfs_regset);
 
 /**
- * debugfs_create_regset32 - create a debugfs file that returns register values
+ * debugfs_create_regset - create a debugfs file that returns register values
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
- * @regset: a pointer to a struct debugfs_regset32, which contains a pointer
+ * @regset: a pointer to a struct debugfs_regset, which contains a pointer
  *          to an array of register definitions, the array size and the base
  *          address where the register bank is to be found.
  *
@@ -1205,13 +1228,13 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
  * the names and values of a set of 32-bit registers. If the @mode variable
  * is so set it can be read from. Writing is not supported.
  */
-void debugfs_create_regset32(const char *name, umode_t mode,
+void debugfs_create_regset(const char *name, umode_t mode,
 			     struct dentry *parent,
-			     struct debugfs_regset32 *regset)
+			     struct debugfs_regset *regset)
 {
-	debugfs_create_file(name, mode, parent, regset, &debugfs_regset32_fops);
+	debugfs_create_file(name, mode, parent, regset, &debugfs_regset_fops);
 }
-EXPORT_SYMBOL_GPL(debugfs_create_regset32);
+EXPORT_SYMBOL_GPL(debugfs_create_regset);
 
 #endif /* CONFIG_HAS_IOMEM */
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c79..247ae4217ea51 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -26,18 +26,24 @@ struct debugfs_blob_wrapper {
 	unsigned long size;
 };
 
-struct debugfs_reg32 {
+struct debugfs_reg {
 	char *name;
+	int size;
+	int bigendian;
 	unsigned long offset;
 };
 
-struct debugfs_regset32 {
+#define debugfs_reg32 debugfs_reg
+
+struct debugfs_regset {
 	const struct debugfs_reg32 *regs;
 	int nregs;
 	void __iomem *base;
 	struct device *dev;	/* Optional device for Runtime PM */
 };
 
+#define debugfs_regset32 debugfs_regset
+
 struct debugfs_u32_array {
 	u32 *array;
 	u32 n_elements;
@@ -145,12 +151,15 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
 				  struct debugfs_blob_wrapper *blob);
 
-void debugfs_create_regset32(const char *name, umode_t mode,
+void debugfs_create_regset(const char *name, umode_t mode,
 			     struct dentry *parent,
 			     struct debugfs_regset32 *regset);
 
-void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
+#define debugfs_create_regset32 debugfs_create_regset
+
+void debugfs_print_regs(struct seq_file *s, const struct debugfs_reg32 *regs,
 			  int nregs, void __iomem *base, char *prefix);
+#define debugfs_print_regs32 debugfs_print_regs
 
 void debugfs_create_u32_array(const char *name, umode_t mode,
 			      struct dentry *parent,
-- 
2.34.1

