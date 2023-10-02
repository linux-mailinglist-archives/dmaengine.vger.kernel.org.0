Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C507B5A4F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjJBSiY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjJBSiW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:38:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B99B;
        Mon,  2 Oct 2023 11:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCqe/o+6BZHYOekuqNCR/XYCzzbojao2xy6aE3Oj355HVFHtuQZR8Y154+iOFs5cKn5vwKO+K+LaWitYRA93mlesDZfh1ewULrueIf+9auhrlhgGoyyaxxFKh0LBQt5YPf1/iOd2+K+RmPKDiW+8XUTPJbuCtXmpz4dIAYjV9oQCf87/H32Mb+IZAcLoGoNu1Is0QRsxd5W3CBALvzTTd9ztUDRCbfTVb0SzUAOtpi6wMhrluJbq4CNBaITh2KUk4eHPKhbJC4SfrpFzZY61cTikTa/cuFZWPngv40RtwyuDoMM5CsIHswrsCN1G5HcKXslxq5r586HKBa2nI8ZCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE/E2an+MC2WTwMy3CtHu9jt6k/DAy24enLTD5MbX6g=;
 b=kuD11T/v6BPPrOlW3/AOh1m2fNHl57rOqk8opzYY1z2rBLuSOlcVHBSPnzrNVqk7sY4G0/WG+Lh2iOGACMs0k99uDK7ucCXqBngXEZ9F2hCsuYWuqFnelYtzraxL0Tv884VDCW+he4MHbWzIYBPXVKgW0nRd1rgiol5xrbaHeaBjaT0sXn8TN6WLOTsovq4CYsdSWf9+3cCHtcsPNXjPfbuDrPEnBCb20Re0SftAEaOnTtM9bgTtzVS7crwsvmh6sJdFI7h1Xg9FtIw2QIarJShdVDmhhh26XJRki1KeVHv/XffhmnqYgogeLVXBJf9eJL8D84iWwgeRqASa/f2Lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE/E2an+MC2WTwMy3CtHu9jt6k/DAy24enLTD5MbX6g=;
 b=q6JdHP+F+HciG9OaU56P/g8cPXnwqqSTR1Il0ZhrJ9og4h8B0JNrcEAQdtD2xal628ER+FuYq420y/4WhSCTvfMfk4ClmMrO2ZqghyX7ou4s/gNYdNIui9naMEgFPcvQYH+vMw5KuomqqgtUPlWsZmr+BN2HWgC1uckLyQPTMRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Mon, 2 Oct
 2023 18:38:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:38:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v5 1/3] debugfs_create_regset32() support 8/16 bit width registers
Date:   Mon,  2 Oct 2023 14:37:48 -0400
Message-Id: <20231002183750.552759-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002183750.552759-1-Frank.Li@nxp.com>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 843d7dfc-7c23-4c50-f680-08dbc376bd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be7wXyLS8wti8/CpW/oIAHj7jWrgS0wi5fi181hl4zhfx2Z40pZVbvmu7KRZLMT+kWPSJ7n4DlOu9VL75AlJ7Z6ElkEpYPNwlSGTBAzamyL5Fqf/akhQ8pOYGQ13JacFPOki3UXTex8YUkOaKQaK0YK+eBBCSLQdmMshmhmqhcYGzVC2Z1ayG8sYL6tqFMXDrJKSKYvvXtwFvy3/MRvtYpU/alMuzAsaF8vMfQA2Cy9p/51JTKeacqT8zL4x9G6av4+Vw7rhh7i46l9TwXaSttOkRvnwt+q38MgQf7JH+6Hx2dVJujyb56BEMIcOMcLc3ytKha2WGghpdi3SjZASrYHQstlvTJUAqyHRzatuLz10mzQQXyST1jhBcESDoBf/7yBF0UeS5fKsl9dFs7+KYd6f3eDeSm3lQtMFvsFnWzFWep99mxKnFeFzdZnjBVu0yVAkch5NT21tInqyA1pYP4T+ez2+NVRZM3Ugz0bxPlN3/TJ0iGsNt8jK5DKHQBrhcAL2X4jzRSKHWG+uy/QDpdn5a8pJp6RUps4vkeeUeYuT2oTPrmU81FNDbiko0bcX8IK0RO6t4rz6MT9qQD46vAwW+CMSk9NXl/MYoOKH1MaKyBHWtmQ3O1HJyac/OSBU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66899024)(52116002)(2906002)(7416002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(316002)(36756003)(66946007)(66556008)(6506007)(478600001)(6512007)(38100700002)(6666004)(1076003)(86362001)(38350700002)(2616005)(66476007)(83380400001)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0bFeTwWm1pleQHFAj8NANR6Rsv9MEOjDLKkfDubW8we+P36do0OBZItJayE?=
 =?us-ascii?Q?KbR0QmjHuSmF4cC5W9C9suP9+rliMZRmfq5BalfD5iUGU5x4lpQbzxHd676E?=
 =?us-ascii?Q?nRd3m79d06jRZdKh1BNMhDNs20JWUf7RPCYwEdn2efd5Rs+3trlyuNs7KIln?=
 =?us-ascii?Q?3EtiNjB4hhog2JkKgKux7LLrU6CBvZ0EJmNrYzNgCrsaF+b/kwk2GMuBcCGa?=
 =?us-ascii?Q?6ryuQV+0mMYBK6kpMGLV05kyYM3yeBB/lI6diGyl/gwUJhmRWqERh9X5Hrn1?=
 =?us-ascii?Q?mbCniMXizrgvC97yo1pMt2Ri8m0NKtKE9OW4gSIY1WfC9pMa6xxL/feWFW5L?=
 =?us-ascii?Q?WeutKesm9ubU9LJlZ3aDYXqqNhMpsraZoT2BSrjOTbY8/ipJmRxcDleIig5A?=
 =?us-ascii?Q?hfBJdyotdOsw+DVmxYYGNx9s8CIMoJ27XtROe4YxF3nzfpKqya1N0JQ40up8?=
 =?us-ascii?Q?znIo5WbzRlx1QskTiq1yB7HThjiOIl+2UHNVZ4uSdUQtk+AbU+FLh5QYMle2?=
 =?us-ascii?Q?53o/JTtihpJMWbCW0r+dOawhJ2kFR71isNlDnNgGLA/wc6ezCOMkIewwBtGv?=
 =?us-ascii?Q?G2XAIxQlZzkYPvP6HP7oFeMrCBH7YhSHU4AbRsvYDxqMAbxuKX7Lo/2yghwv?=
 =?us-ascii?Q?wU8vCAaqj5UPW5oPqgqunHbaC5yPe+89xqSnLmbQW3eAB4h2cz4Ea+jsyR0M?=
 =?us-ascii?Q?NOsiJqLqPMQeEZId13K7we7I8sLLUhThEH40wcA/hhMzQofFeiunCkF2R2yN?=
 =?us-ascii?Q?zYBQO9kVGQZtf0I/MRdlqIXkLcRd6FJ5GGZuAszNzQT937efEU7L/81nviC3?=
 =?us-ascii?Q?4oruKL5ObOhxa6JjjfdCYEWiqt/UWCTgxgaojxrYrkJerrfFR0TAlJmuLvLn?=
 =?us-ascii?Q?RfDA51pGIYSotlmugdbMQ2IGRV+55xQBUwCGGLuu8jlxSa1HP96yLn6GJABR?=
 =?us-ascii?Q?yCJezgKDC6w5Q6dhKJbKEHWwK+JGIFee/FeFetnPiDhuVRCd+WNi/pB0LFuM?=
 =?us-ascii?Q?1N7Mk5TQ1klc5Cs+ELUfVQy7Hf4rp1o+Y+3QB4uZLm4QXUH/E+cXB/zrJlqr?=
 =?us-ascii?Q?5FcD/isIXbsjMFFXuLR2UOa4JRlEuMAc0oi81cZ3QphdLrDRUay4CrX9QfC8?=
 =?us-ascii?Q?RGr/4iOWyYxd7XHLa8PjY10cumLNlxJJwJKEC5EbKxPArCggP//+jOosw7St?=
 =?us-ascii?Q?9PNOqp4D2VHa9W6XobGbBJv+vK5x125jIUzHvAi3zjHFb/Q6UaeA+94JeuN3?=
 =?us-ascii?Q?X0fQ92B2weMDoiXrbVteEXd18+eTa3pzz5dCmSuudEl656eDCKLNXTvb6qn9?=
 =?us-ascii?Q?BdZcoRyyVX4eLcdBk4Q23L4hNXFuJwxtHfwVsdvO444JBY0jpzcCAsHPfsYb?=
 =?us-ascii?Q?FgqLSZOJDaeyb55mzrNtENHyKsVZRnmMJVpSQIuJjPOoUAO1TwBFtpgyTcn7?=
 =?us-ascii?Q?YG6V4oY0zFKLI3IsEKMYgkIPY3UnIT6+Mi3qKdQv8epnWQY9t2OduRR4WMQB?=
 =?us-ascii?Q?Ir24n2Xk11aNezKKbdPAJ8nBUXGTdGPN5QSV9ByHNclKZRmWT0Xu08KA/Ktl?=
 =?us-ascii?Q?5GkcgzcSnFdkZjupe7b1mAUeW09VCqTUJMGug3VR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843d7dfc-7c23-4c50-f680-08dbc376bd63
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:38:15.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThWc/+4UbEXe1ZSQ3/2MpInLh6s9rMcaL5TgRePx4PDpGr/D1Y7cqIDYjM6eti22qpDjLQuC7g2nwsSbSJKSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 fs/debugfs/file.c       | 53 +++++++++++++++++++++++++++--------------
 include/linux/debugfs.h | 17 +++++++++----
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..62cc96bb6d72 100644
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
@@ -1157,30 +1157,47 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
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
@@ -1188,16 +1205,16 @@ static int debugfs_regset32_show(struct seq_file *s, void *data)
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
@@ -1205,13 +1222,13 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
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
index ea2d919fd9c7..247ae4217ea5 100644
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

