Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C709D7B6C74
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjJCOyt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbjJCOyr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 10:54:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD71B1;
        Tue,  3 Oct 2023 07:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2DsTnJ1wRfXUFs6siVFJkSUUTlctN7wDZeTdgpwtXDC+sI2J15NgIy3bDRDiD4732QvC04S1s5LVSF+bdaX7gveorIghXYlc+bGo3UlOA3Zl4o4GOJWdXc1e77XkL8jPm5Q5Xn8J4p/0yB0vOYWUcQk2Fyne8CeI8nvCcanNeZHwG+BQOTmecjSWH/k8shnTtSmVZy26Mm/B4NLTSayF4+aQ5W40bPhFU4ml7T0ACQov+wthRQ/N5BVQdsgpu87efzPyT5ebhK//G59xHXvoMCDUXL+7+OX7Ch+T51el6bk2CwUha7foBcQ5Qeh0PyE/y/7yrMfJI9t+kyg9uzWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsHRCYpEctI6Zzn89z8ATSekt/z2xOHV1+DaQDxRwCI=;
 b=YRwcnkQ8VLLn+tjmlU84DKM5OlasWOke7JAZiDZNnoeMTbvoyTosXjZpjR69s18PpHbsZwmVKEWxapa2NQVNA3uczC1WUkQ1MihwCRyW6G/kzJBbLiFUFmShD7GdHtq9KW1qTY6ANu75UiyeeBfyQnrkWchkP/ftygbrZx4+98qNfG1QyEu4OBCh3na/FYFBWXincibd+gJIm8icgpjwIKuVHmB1M5wvE/MaKu6Dw5EQAbgBRboPc4xsX0/bNKmYJmcOuxtESAsuhfAnfVrbdROQEIPcboKr0bBe4uKQpr+rwRmR2s2N6aHKxPyXCGlrG55Xqj9KVLLZ5danrJ6dHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHRCYpEctI6Zzn89z8ATSekt/z2xOHV1+DaQDxRwCI=;
 b=PQtnblVo0rhbT1nd7yO5pONJUb1hbpXVTdqeZjbwSaGihbYkMXznJK3v6hvSRCYUmbBP3Jdr2NGaYBcKRHXTpICZT5sBOu96YeYHVc766aFDvhz22QE9qmujOeTF9xLeIhNFQIdd62YjbuUsM48q1PKOwlwvpAJuN1g5qplOIXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 14:52:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 14:52:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v6 1/3] debugfs_create_regset32() support 8/16 bit width registers
Date:   Tue,  3 Oct 2023 10:52:10 -0400
Message-Id: <20231003145212.662955-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145212.662955-1-Frank.Li@nxp.com>
References: <20231003145212.662955-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1ca539-7e22-49b1-3489-08dbc4205fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmfIDY2sQjEJ1D0o4G0y6lhHD7U6kRj4xSxKubx39Tsy38RmUeP095YZ7q/0XpmKaI0n+BeNoM/DhDP6+u0rZRkNSyIdM4FkEvnY6es0oaXTl7UiehtOUaMu3LgBycqzKlhd+6A1ScuX2DcfwniByHDit7WKuo+HJMSb7S5l/Kzu+pWHEzfAH/0VpzELWASO2HjcrZi6p87NE3YC99ZQ3JhJxPa0z5STDGwVidmAlX2GW3GphcJ4nos0QwFpVDxog8Fwo7olwRhoSerrMPx6CYVLDkzrtKIFC1GyBBeJO7fdKbo1j7frPeoSBWtYoEV7MlIueZblqDHsdLzb9hbW3lVbM6UKc/a93YlGrYfLbijblfcSRsDtrL12moRD1+x26tZ0ON4nMZkFuRmKrbsbQSxL61m6+f7oohD0oZMgGGIvqA+BFgI/WrXHSjty4Clh6/2Uk+OQEQNgdg6tlcL20A72zh0clmzIi+ixTaStE9xUwZsU0rYxR4fJ1E8gNAPalf0TQiiQ5nFMzyx0ihrj1QFvQSn6Gtadt0mcqjiRoZA5uWuipX54ZKirqzmmaki+Z/LEuPWWtUk6Nu0CWP3plALalBDtHBOMHHPCtwgTadi6ctZyId06/twBXzZ3RuuP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700002)(86362001)(66899024)(8676002)(66476007)(2616005)(1076003)(41300700001)(52116002)(8936002)(4326008)(66556008)(5660300002)(7416002)(2906002)(6486002)(83380400001)(6666004)(478600001)(6506007)(6512007)(316002)(26005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkT19nXjxNM/FY/PQvzOriNyZnjM8sMUhYsDXvMNiz+/vUCQH80OZfuMVKb5?=
 =?us-ascii?Q?lnSarIFXZeXzZUMLb9paXESKyiP/bVyDFscVetfUJpnKhvZQHgbcKga5HN0O?=
 =?us-ascii?Q?jHGsOfSoMIsRikkxf/swadKgX0TCCSBVCrix5UCehGy0RKJRqcMSgEf0XtzQ?=
 =?us-ascii?Q?nheNk6IcNb5dBQJJkANP4cGthFRTuM9JGGffeexNpFuudlWWXxtejGQTGz0p?=
 =?us-ascii?Q?PjUpoGMW0KyitmB9VrXwOFy84x1Qf8WpqyEKx7Xhqt/ERpGzxPxlaB3z8UOO?=
 =?us-ascii?Q?Lf2JUm8OaWFGPfxRSW3M7lszdEmxfz/FJYNDbXrwLGddikkY8X1lSdLfDmFx?=
 =?us-ascii?Q?CnW24gsLVGH2LelJBhbPKdLJmfoexRuvrupsTivSwFkVi7FWS1rbAflhJ1Ub?=
 =?us-ascii?Q?WEk5MXzUleO4yeuZ9MBzb+ObQ3F7sWvbiGHPYpt1QTAhnWIRTJnqIDGFS8s6?=
 =?us-ascii?Q?CXchCWIUjQ9Gh7kpmUhBDDDvLh6PgBlgLgOMM1iMYISDCznW5vhNBe46Z18N?=
 =?us-ascii?Q?CGsqzndJxXGDy4xqilp5Kz9LlPHpQ+4NgrvqUewwXg4fJXH7Ihd7abGyGWLY?=
 =?us-ascii?Q?M9Bt2NNXJiLdbWPk/fXSXvVSD/Hp14iuE57Hv40MPs2sMjHt03SwupNTtvj9?=
 =?us-ascii?Q?CiK/wcxJJgPAfYHGkm02h31XFqtsB0chZWcr3yLcNAVXQ3d7J5I/WtAAk2vR?=
 =?us-ascii?Q?thgZctVFyLwci9zqcTryAe4ikt1XqsCkKhCB0LhR2JQ65lWGllA24FYNxa+x?=
 =?us-ascii?Q?dTW46b5/MGANbAFgKWY/F1LHvX0yH2oejdaN1QXCww1L9WXfMuBvSAHu9II2?=
 =?us-ascii?Q?HuCOVu1LvwNupG9LNIB4vQGXcR7rdooya/8C9pi6vbKTsrwnYw8yw7dctxzK?=
 =?us-ascii?Q?6RncCAU9R0insk7wYU8Xk+TJVNocECWkUDcC8ocy8/+TMOjgd5xgLu5+S4jF?=
 =?us-ascii?Q?WXcvC24Drmk26AmbAfHecw9+Ow/FoT4Teo3ySsYjJL0g99Ll1PvFsw2J2yzC?=
 =?us-ascii?Q?3qasx7mnWes7/VN3+5HSVUCnrLWTFxPDVrdrnee182a546bk0hC8n9ZGtCcR?=
 =?us-ascii?Q?vCcCY9e0PtCdqNAYIWeHO/ZaaTmUSUmVniUYDiNXeYa29R5tVqyf5O4ZFLB/?=
 =?us-ascii?Q?oY05thd4udtxJfN276V2YfebWzZ2C9BOo/CrG13//KIi/XJVnOTjiNOTwzKt?=
 =?us-ascii?Q?A9prIkRJ4xueB75Y+MEzxpD0L8jC2URVPmRDuWAGaU4h0Oq2jT2zPpM2aLSx?=
 =?us-ascii?Q?DRl6xWxzDgbiHrYlO0SMGfXcopEnyW0B73E5EkUteJIqK4TanmxH8eK/+99W?=
 =?us-ascii?Q?NnpCa2KuHoSZ3EfS7NE+oH5C5KkOXzNcWm0Hmf8Leep/mDaH9dlqNp+REAvL?=
 =?us-ascii?Q?py8A5rnOAzrcZ/Xry0nKTMS3iKLARXptML5f8dwCCL6y4TlCnn+Hm87Vs3Ec?=
 =?us-ascii?Q?62eLFSA/eOrq5ptFDzMPCQvndepPmJfKrhys2j9RqyCUj2A1KkFkfKw0ACd9?=
 =?us-ascii?Q?3HVCwN26D/RQZtjrYV6CvaUCItYpHiQ7bFFFPrKZvpiZ05LEZJLzVwdYuDER?=
 =?us-ascii?Q?8r5ZPmIz4Q6ad7zg+DBbHTGFPe6+IlurPqXHkfaZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1ca539-7e22-49b1-3489-08dbc4205fab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:52:32.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy+nGYDAIXmNljuMnIRFawOBmlaKjjSslf6jC4D10u6XFhekbQCjF2FuxY7NF5j4Y+6ELhJkBAPnEn7kDK9Wjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
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
 fs/debugfs/file.c       | 54 +++++++++++++++++++++++++++--------------
 include/linux/debugfs.h | 17 ++++++++++---
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..2f2baf5ee3b3 100644
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
@@ -1157,30 +1157,48 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
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
+		case sizeof(u32):
+		case 0:
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
@@ -1188,16 +1206,16 @@ static int debugfs_regset32_show(struct seq_file *s, void *data)
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
@@ -1205,13 +1223,13 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
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

