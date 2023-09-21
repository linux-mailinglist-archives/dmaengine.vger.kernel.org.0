Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AC7A96FD
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIURK5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjIURKE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 13:10:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160A72A0;
        Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvtX6KfKC6KaUJrscAjvju3jSJoZ6vhJSVEYtraTmZLulMnixLYlN8RP5AiL9qveCW2ueuCZoim/4oy+Xgm6Dd6Zd0MgiPChn6v8KNsFvIEnYp0cuFBKIrDzUcpLNk0h43xtC3NHOqA4xqKHM8+eX1hUU1++ziGqvvLzRXSqLD/pa0x7n28OigU0RcO1Ubap9ULPMg2VhEsHEa72aRAoBw6ujE67Axxha+YZGspz+kwrMR+F1eAaTcW2lm0FY966kyOdnrZmY3WD8/DeHH7bGaJJDigaOOAAxsyN8n8t+oQ7fvfHGil34mzWGztc+Jzrlg156aKY5EXusMxLLcpuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7UL96OhVHBAKyJd8PS1Vq3LsJ9v9ZzBYW/nGw949d8=;
 b=jkVfdGQhqfVf0h7AjBg8mMYN8NTHUjsZEEw8M2Mj2fLonqBgyLCLl+3rdwiUo78/InYzHfcGpepHExdD+t7OaoD8+ZXKv545WUx0OGxe8h6cg7fi80t0hECkWiHylm0rGU4YK8fH7iHfRw8TqlI/bKhI3VP1lU8zj9tm8wn04+Vi/CQZFle6t+DT6NDZdru8N3+xi2KDJdRVuSMruhEv4KzXwJk8dRFdKSrSjMRuHBnchiPtt+JlEjmXMjbManRqR1N3sJFr/bM/Z5IVgXW2UWtW0gqqEZC02JuiFOMH6iV3MZJqYnLveDNdom0szuIo7JkzgP0CU/LVcA706DnksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7UL96OhVHBAKyJd8PS1Vq3LsJ9v9ZzBYW/nGw949d8=;
 b=Z5IHAQYu0sSEAdKQzg/34NsqsdOv7LTZyKx9d23CGNhK+7jHJnJEodhK62caOyeknuPGC8wQslfY3YlS2lVzVl63KHe3bB+xN9BwFlJHR75jvkNTDaBM/3L9aNqdZCSwie46itqDjwUW+1pCFKwmVnkxvaS3ONyzSebPFP7aSy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 15:02:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:02:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org, vkoul@kernel.org
Subject: [PATCH v4 1/3] debugfs_create_regset32() support 8/16/64 bit width registers
Date:   Thu, 21 Sep 2023 11:01:42 -0400
Message-Id: <20230921150144.3260231-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921150144.3260231-1-Frank.Li@nxp.com>
References: <20230921150144.3260231-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 573ff046-5e89-4a46-d697-08dbbab3b996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qM5ciWH3SF6PCJtHXD8SPlm5fbTzn1zhnVjGUlB+TYKYcsnnIwgd2kKTr/QXlOixTkLU2Q0Pffdxr5mrIm9hKjTv/pHO7hvjrWDqxylyj43b1n4nCkiwW4g4uGCgjpcLjZ5Val058keGmep5A1FUMVvPrG173Wj41QYoyXO6IfhgPg8SbQsSyyv9ZzOu/eZeOn1sDqXDYzjyEERlqyoTGj6WJ+ScQHK6BBOkGX/N9FBM7FhAX6fW8NLowulrRN8SImjKQ/07aNCX+g99Dkh2SZPyi3G+EN252ZxJrX4C+zGuj2LavTG5mu4BjDPrekmZ0lhff+GcritDChijyCy2e0ibm0JTDYdBOjzoQ/MMABs8UI4cPXvoIFfXt7X7TeBWfBTpkwTQezieO4bxzlFxzooaNCr9nwemcDpHWbLIJLeKf4CvwFiOBqYrxXyEYVddFM3/z45aRX3U/U/nIEott6Z/WorJo+6Z8afmH5Ic88GqRZesf92sE2x2q62n7yA7hhBFiEsw5jImV4spDk11jKcNSJR255+tponfoEYMsIfsx5Xp+BNdow0cHRlWX4zdP09usO0uYrVq9/PJSCk/BxMyCooUNMxKYZAvh1sDnPSLKM54aNuRfPPQLEpfVrbZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799009)(451199024)(186009)(6666004)(38100700002)(83380400001)(66899024)(38350700002)(2616005)(1076003)(6512007)(41300700001)(86362001)(4326008)(2906002)(34206002)(8936002)(8676002)(5660300002)(6486002)(52116002)(66946007)(66556008)(66476007)(6506007)(37006003)(36756003)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gAJcqJZ8KtdXR35jtEHJWWZp3goBZaLoCqrfMtF9wk2YidEpiqC4hhIGu4Ta?=
 =?us-ascii?Q?eY+P4MMwG+zZkf0PtLQjkM2lhn0GrZKDKxf34m7vSXtDMTP3SzLz8Z0rNxp0?=
 =?us-ascii?Q?Y0mAWYYxjVSy7nY9BhLz4IHixbCqzfQego2Z5Lv//eBxGr3ujfK7P02LJL0l?=
 =?us-ascii?Q?rp6l3EbmbE/Q2gmunlEFLhIMNrqk5eHBFkTXH9F8BC0bxnIWISLdE8HRmIrt?=
 =?us-ascii?Q?ALQUVY4u1MMfrZuHUBgye5XNynsVOQsE8Roj3a79K9HYdXvuDzwPvmh3eD23?=
 =?us-ascii?Q?N72s35+LbS/fvipPDFFmkedp8n92J16VmeQgJQLutrfqD9ohP0gs2X+mYSVA?=
 =?us-ascii?Q?MABTBwOR20RRMGYLGiGS9Z0NzjhvqAgvOiT3ewDpZ4RAryvB10og67to6i+9?=
 =?us-ascii?Q?cotYXZ16SRiRk8VCZiKmd+o/P3qQ8PnAFKG/JY8ZEYIMPud+53cAkrRorMF7?=
 =?us-ascii?Q?BR2S/Or8BP64IIBn3e1fL6TDFZLlOwDIdVQfhGpds1aIEar7mjkygK26CfrA?=
 =?us-ascii?Q?HmspIl4L7Qh/WtKn9MRCYF72U4x0BbqiJx63BSlgRXDWM+aDQKHjeqUiMW53?=
 =?us-ascii?Q?GIu8DCNPVVu4DquxmeSrUUVJeyIA8BB8uSPvf/BSDHHTOvIQ+phOZUlHm15p?=
 =?us-ascii?Q?+RPAthorlrrr4tn7HMTiVqUxIPshdN2AOTbUtFKa0kQ2FMn1RvqhwFiORb6Q?=
 =?us-ascii?Q?KSjr2P6i6D8hG9unGOfSlid3AFAq93nzbrqz7BSk123ZFz/rvFroqhlzsT8n?=
 =?us-ascii?Q?undmUurqIGRE5kXHlJta+Wh/zelx/d4UXZ/WFO2bNVREQcpFMsami/H6mwOf?=
 =?us-ascii?Q?Vd3C5XCJyBlNeziJsP0QseB5byOFwBdc2VvXlXaXkiI4/7E+H6NsSWyvwrPj?=
 =?us-ascii?Q?A6B8EZrba2+QP0AIqT/B5rVwWz8plTp2k2YTN2i5S4xsWtVfWUzjpVwdRtty?=
 =?us-ascii?Q?Of+cVAmZeBRRLVT+G7k2QQKxUal5BbT9H0ezmEukqm/H1B7nD5pE+C64rHos?=
 =?us-ascii?Q?fpvpaD2BK8NEpCV7/ACU4N3Nj8ED3i1YuDYOAnOCy+XBl+ykgTQuSs5OJT/W?=
 =?us-ascii?Q?rWV1h0Q+3omJvws7fR8dv8YlEKS6+tttAUT5i1CRJ93YHPH/Qp4Qyp6Hi2E9?=
 =?us-ascii?Q?CYINJph2SfEPIqNAEcSGVjKofnzEYIz00uOdyEXiJGSlvvjE9JgUn0Fz7oDf?=
 =?us-ascii?Q?ma7YI7cR1klA9ykJXTd8kz9wGXtZa8jQ2cswtjMTfTWbp4BqRmHO4yFe2rZ7?=
 =?us-ascii?Q?sXO29UinlysuWp0FvLgYxjEfx+0wtbE8z/hpZxrlVl554l2ObeKD9k3A0z+L?=
 =?us-ascii?Q?vNztiP+cqxqlphLQKZXV0Dkssa5zFtFWiQp6egVr1b69Ja9IB3cTQ6/YpoFY?=
 =?us-ascii?Q?JFzgdVFC28GKIdh0k0I1JMnyUQlE+mvwlu2f0XoJ4HMeiibPPLkopoLQjjoO?=
 =?us-ascii?Q?UQMCDBOIfaLON0xwIHRd26wA13NZL/8ikXa7BDx3hFQNeZ+o9/ClZEf6H6zc?=
 =?us-ascii?Q?pgjgMs9Z9jNZ6ALLC6YkEN21pk0BIwFA329cXJDDgq36EdB011B1xo7OfQmG?=
 =?us-ascii?Q?Pok5nPx6bcjpxtawRkgpAP/h7Vaq5qXVtvmkvhCJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573ff046-5e89-4a46-d697-08dbbab3b996
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:02:08.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8vB4eVCSbdUoUnD9WtSozqWDtm+/K6c66Smnga4N1WCDcgdeE535UxJnEwG89aVrqfVrDap9O/Gy3puqwa2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8590
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

