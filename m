Return-Path: <dmaengine+bounces-10818-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH1eHi7sE2pCHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10818-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:29:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F25C66E7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53583024A3D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954FB3A3834;
	Mon, 25 May 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oI4hFCmj"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021138.outbound.protection.outlook.com [52.101.125.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DF3AA9DA;
	Mon, 25 May 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690293; cv=fail; b=AZA2TsqoxO7UckgR1wvnL4PsP3VPtXt5BA1fLml7vOM6Gms1z+5/ckCBo2lCgW0ie7cYouumJ9gxFki/+vewh5ryJjPvygTwrT3tBBSB6URUf5Rwf7CtWhCfaWUvadCUwNG2VJKJrAQVXTF0rAaedkRakDp5wwMXH0b/grV3uZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690293; c=relaxed/simple;
	bh=b6Hj4IwoE6650ZWzm+LeIgx/bSn0m65GeStGqKRB7fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srkiAn2+0/imgqLFy4UIvIX1vafuMQ/wraQCNJjsBKYSmzV7wu3gmJj8/0P4kYHZGHvvDh/37BMxda4zm4Tow6o07BGfRstn7egejCOEhmQMF5VGurotP0iob4r2y21b907uk89lfvgInFSejZo43k5EN2n4zFPnf4yTFkud0n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oI4hFCmj; arc=fail smtp.client-ip=52.101.125.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7dz1/5TxT4Ec/0o2mAaJnoUgv8PEXRwl3dL2DMYZ7scZiveywbxiSUmwVoSMYHOFzcs/iXh1DN6KyXJPgnxwS3oZLaBNjGDD6APwAWSuIAfCZFTovr+HCf16Mb+bDC8OECUp/eDLaLLlCaebg3M6WeBRXMHQlGxzYRdylISBB3SFTxG0LLokP3LV5aa2YBCdQKklyLzvHVllXQRHT4cfVf+1cB9wzwVBHWLRjqOKfw+7CeAlwqkNjEOOSrTQv7CSz0LXC7ka/+gTfsictl5S8rKbKbPROxJAVS+q75mE/BlwmzZjN6ThG+vZRymNcs0N4Mv+BZM183IaRVM+KduYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TedH9z3u2BejPGVP0vHxbI4xD8cn1/8v4mwkq+xK9Nc=;
 b=mf2cEWauSDLxQ6wym7LlJtXVSb8hTBQR4nAUxu8XXmkm0ZzQ+pis4cGVdwpkv+xcGD/OGz1CamkzPTiUWSi+MIm4ybkaGJRt+Q4DrNuLx9yBeOMEN/P7OGhXRVAaHaBUX0G4QvGKLIdG85K0yxVsvCncWOLo3yvbqv//MqqKTHaZOe5yQl4xQlQDxKehbMuKmP8PehjI0BOcYCQCU0N2kbS5iwWat2D0J5jCrcpVWLTZo5rlzHAgWn2kcUN32dTgN2O6rDzXqpyxt/dUhHQxRWClPK/K7+TI/Xfe5O0Ebr0A+b/8yVxXE23xfZCnRdU3A6H6KulSOpvjswY6tHO2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TedH9z3u2BejPGVP0vHxbI4xD8cn1/8v4mwkq+xK9Nc=;
 b=oI4hFCmj0JfFjXbl/uaTwNiBiowjrU13Pt2SOGLTYfGgs0tpE9QXPQUlJGcMMCf7A8XyZNHT8Hs6lUdhjJG3J2l8qcPSj/qlzRWfUlSTZaTKJj5OImD3B4bHbq/l8INa8nVu/F+K48oTkoY5OockLgN8gld4N2zMpGveJwPwOBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] dmaengine: dw-edma-pcie: Add chip flags to match data
Date: Mon, 25 May 2026 15:24:20 +0900
Message-ID: <20260525062420.3315904-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c91f8f4-f230-4e83-2ff1-08deba264f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VQmmLNq0SBV2PpwPIbvzMHDl91zwa3xDlqeFsSEwe32JayIQrLeUgJUvq7WUd+IN5jP2FNTKgW147Is4T+TjhEi5cn8DlfPxXWDoEOIUdsL6Rr2i7rPiRblaXBD0Jt7XgU5X4zKGWFJrtO9b2MFy+JZrTbSBCpzvMLxJf8D7TK82shQAtpPxbZvxSoX7cX49OJvNtWsDqJSQCVpM3jz5CW3oP957IgJohF1T37ve9Iym0uwBrncpH7EJffNTsyTl/QR/WPjU/D6jRD0PeNIT9goUYXleTWEYh1n2MFOQoruPEThAiAJqwZ0Q1Ac08XmXC5qQUfGw9uwD+K4r5nJzLLadsyLHOLisy5ug6KmdeGgfE1Yd7EQGIPK1CsDgzqfTNsOoPLyWJYeJSYPgn6IfyYZXwvc2o4BeaUGEUXqrZ3CEPRMFQs2f0vxqyuF+ZYZ3NpYnHDLNoTXkGV6YKQTyh2ua5HTs5yinjzMXSZOJpykRc0zpzEhytmU8Owc0tibgLN1HUMHXhk4KAPeUOd+wkfTGYNFC1h/FOal9RHhcx7xD7BXNKNe1RXXZH0Wt2AcZACmiS96ej51W2ieu3gZBasd2eHDAt0tXVpRp9+u/tcfzOwmZyULaZJOi4jt/HQg3jLm1xHqUv2fEbhRN957uM1L9+Cw/bD6bqD4NuKrMYRHKUTOoaZxDpFtudticpONv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAo8SId3FijZ/6UJFNzV3w4xnTzG05G0mLWv0tTjGw5y1/HSGRVqdUuHWnlL?=
 =?us-ascii?Q?pLQTMVmZGpWVvwPnUqWN3sPj4twaTlmx3TfE1QBPAWa1zQ1z7An4PbfZnAqb?=
 =?us-ascii?Q?SeAjvMU9hG0cxEBotyCebkXr18nJ3kuYiEw8piJNvSBRXv3QXS2snhk+J3i0?=
 =?us-ascii?Q?DBNtFeZEsfDbFbIIA6qgTMcyajtWryeOFQxaVH+h43lZViF5Dn+f8pc78weE?=
 =?us-ascii?Q?Z+OfoHaJGKqMVms43ucIjv/gAj5/PakberJ4BPPyWFIWhtHbcKB1pTemF85L?=
 =?us-ascii?Q?9E9pAnRWLZNRFwxq3ELJIbj8qUV0MYJnB4DxGw3r6fsCh7UCGvkxg8Wg/wdd?=
 =?us-ascii?Q?4SzzoI8KU04dA1Z+TYRH3INvkwerMJ881wOf0bm5xljVxzK5SXAChmC58Vjw?=
 =?us-ascii?Q?59nVu8uxbzzn9DxrZ1SquXK90X6cUP7X5/7zcU4nJG3U2rPZmjajmMSlst6M?=
 =?us-ascii?Q?8XMYNWtUYXtz/6mzNvaFBC4VF0sWOHt4pOrZZPcRJzO4qTm2BECIVyqHpIEx?=
 =?us-ascii?Q?qrXRaxYGaXulbxf2p7WJCQhYKSzKsptL8A9Dgf2p1zW3aN+WEnYb7JEePH0E?=
 =?us-ascii?Q?H5M7oKvKa1XE0Z26nZ2vOGhz2Go//UbDocYdGLPAtXCt/Je93SnOsxwhRUfR?=
 =?us-ascii?Q?IbeQhds5E0mhMktG/e8J/MQulDz/3D5fvPMsgwHqdgSwwNAO8gOknkk8nGr/?=
 =?us-ascii?Q?0pLQxknS4UvKxxV2Z/LnzXdLDIQpcMI3UoDluQD6ChguPCFjCJFWaiLOdsJ1?=
 =?us-ascii?Q?Z42M7XWrPqx4fdVqGbk+20VlofXH6XV7it5rQ/+21wJwym7ljRHLMYHPwRgK?=
 =?us-ascii?Q?hdWVafwQQuRJxYpVDvDNKIGY2OqZ02QoYz2qeO0EZb5bC8Hx4oUnvr+ePXT5?=
 =?us-ascii?Q?Hzx8g7K3ttRErLGfDmwk3+FPWjcsuPcaFjl3sqCwgu+6MjhN1All5pYvSIGl?=
 =?us-ascii?Q?9jtyjSpOuFh3JrEWlK1iOShss+xBidrs0zWOeI2mfUGC0Tg+u/EC9HoXwK2T?=
 =?us-ascii?Q?tlpP2qQqXyqkDNaqoBF6NXDF4jeFyeLdP/wDP2U2U6RddOIgqeIm03UnJ4jD?=
 =?us-ascii?Q?Pne98qYnm3MyXizMA6G0gh/ddnOeBRjvfcsqSy816McNEpcRFkxLGezt161u?=
 =?us-ascii?Q?M8jSIp36PqCogxst7VrfTKWPh5oi+Q9EdwndeX2JkTm1Gi9fSZPbAOn7VGrr?=
 =?us-ascii?Q?LFybDYdoZVJFwu5LkfpuyUOjRi0xSrJ/3O2+4wPYkueG8Imx+EB7Zvs7kOAz?=
 =?us-ascii?Q?9Aj6ygZH2Rb7UwmXBhtSHADiYvLKk5ThxWE9NigGkiMIKo9o1J3yPyQsuoM9?=
 =?us-ascii?Q?i5+79p/IQ8HzOz9vzyJIei7CgJ34IGd68shaJnVlZ7O+LhQHAF2LWyuchWMR?=
 =?us-ascii?Q?bbMmafwwxRkl1ndkkKQo0AdTqtOEmHtk3vLeZRFVm++DhfXaHhhkMIh9uAT3?=
 =?us-ascii?Q?K93KK+DExbiDrajGcGvkrP0jskVdNubksX+EkAzubvg1Za+MFvvRXc/xirCr?=
 =?us-ascii?Q?wjPzubPElqCydh0E1bu3LfObd8APl7u2GIhpFYeuwh0eGb/aGzS8OuAC1gB9?=
 =?us-ascii?Q?D8widM2PRW6hsEAiKX296Vn9kdfvv+Og5TXfqxCuz0au4Vh6M/E+xrwx13BA?=
 =?us-ascii?Q?gPAAVNBSLaMGYcH1kAz/NcjaCQd611FxQOtFDPNDXF4LCy2Zqd2IkNxQW1yM?=
 =?us-ascii?Q?gxbvxBaeDveJpDyw7IgZH3wgYiW/CLaqRz9Ee8lbRSr8VNznW3EaJGldSv/+?=
 =?us-ascii?Q?J/MlOiciDMWF/SMU+OPpC5BlMLs6Acaw1a2mZRSsRy0VoylzZIKr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c91f8f4-f230-4e83-2ff1-08deba264f93
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:44.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4jqZBAPGS7O54dzX5NwvFqGALXLEeXsQgCqtIvbWQnlMUTowPG+x+b5q4j2hQXEh140ZZwdIWr8p9kBH5ny2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10818-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 115F25C66E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
This keeps per-device policy in the match data instead of open-coding it
in probe().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Refine the commit title.

 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 00e9c9775e3e..12229a9301cd 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -87,6 +87,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata);
 	unsigned long flags;
+	u32 chip_flags;
 	enum dw_edma_ch_irq_mode default_irq_mode;
 };
 
@@ -451,6 +452,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->flags = match->chip_flags;
 	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->plat_ops;
-- 
2.51.0


