Return-Path: <dmaengine+bounces-7762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB530CC86E0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3D131113FF
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87F346798;
	Wed, 17 Dec 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Fy5S4OBx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1F34217C;
	Wed, 17 Dec 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984592; cv=fail; b=WCXJMgBzyt591tygKaytkiXiVVdsW30RZwqbRO3a5qy1p/Mob/52cRNRnvlx3L/k/ZAhBqPh2IrXguyvTVf1RYG5Uf/NAZSv1IdIF1fvkjRmgaWiHfZG4B1kQnhTfc9Vlm1nAIgRLGlDNNyyXDe9ol/JJW7qldUzK+qeXCP0f+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984592; c=relaxed/simple;
	bh=T5jp2zaMFoMP6W9EL8zFQ87tVN3MnldH4xZjzays6U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulo3d/LcWlsZPfptyet3GmpK1INEdvBmSJlb/yxVIF0u2tahji+wgthFEWu9jp/uVE0vhK0OvLWqm6l74BA2AoWxxOkp5MRpCL+vYKbKvIPNpSbyJ+z4fLUYhUHvARNtMFYakxr06nnO9ZjqOoDu6QwkmoxgACRi9K9HpGfqw40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Fy5S4OBx; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQSnL8nH6xU8hjAMYAk9vIcQeklxOo6SgQWIipoL0hcvt+6OPaglnvJRoEX85ksA5JSIVTVy4fZdz1CsE05facpMzIBf9x2oidIzwKCW0EaloQnDZbKYW/Je57ZlAMnMxBcjLkWRP/TKlVE0mSQWs8YGMxaFoSBZScxWkQcPPFphiMAdcjXsHvaObk73WxJVQNkswlsLAhYXWyaaK/tp481BDYRII1/dN9EdmhQMTZk+QdcXtyJpph/23b/5RNsAtfLfYgis1p2Z8le47jW8DrCvW2AwYv/q/RfB1fisy1x7VhlmDRtd7r5oDnLXbVrdvwzuEIguwUB02JqG0grnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJNUYYkWVAavRFQ6IR47DRdNP1DobuH8bxwsyzuwkNo=;
 b=RU1ivh3/o4YFLX3ATJrPHeWw3ZCY7wl764Y0A6D8dXlKsIDo5pPBSaTw6g9F58NzV0BdHVrCyXrXlHjXr91QPg8xTu/ycRLIRcpG1DdGC6gMerAGkjHFlevC1IynjSidm1U6hfPG5EgS9S6oSYAHsRziJ2JAMR9yzzP9ZXzk7stW/j2P2a9StD+2jhik9iHbzZ8t+LFNMYI0+jeumQzG2wQ3D01U55idGp3Ayde/eDtV0xd4nWFyBympAJzo3OoNBXkLyx+vMcnTng5clmE7RAGgx4AQhFrhghdTl8ePjk9oM2V582ECJ6IXz7u5KX4AvEwKfmOMe1jlsO9qqm5w4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJNUYYkWVAavRFQ6IR47DRdNP1DobuH8bxwsyzuwkNo=;
 b=Fy5S4OBx0uNdKzJdt0Cs597aDEmcxme1zsEYrzr0aqXfGKJmvOKbLNad8opRGo7sp44Jsjunbn4m/hxz1Po1k2W+jSXEmVvYcUWjFjUSqvfwHY6L1Nq5FPl6Ih06aqI884lfPCuytX1vB0WaBTYfPAyXoAMFFgTE0J4dLmKESOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:20 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 08/35] NTB: core: Add .get_private_data() to ntb_dev_ops
Date: Thu, 18 Dec 2025 00:15:42 +0900
Message-ID: <20251217151609.3162665-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a62180-2624-453a-a797-08de3d7f3b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Phc8SXXjQ4lS4MvD/X6PnGhGil39Bgg1dPLa3A81d/5iLFEDxNmxetkdN4Os?=
 =?us-ascii?Q?QOqL8hcim/Y8PoNrXqc+W//vV9qBV7MD404K0pzgbnRM0VgZR8oNM3NQXBNG?=
 =?us-ascii?Q?RA9lrO8fSDYPWb1fuBJxtyvvdjUc6CPDJ1qkHUylLdQR/O7bpVt2MWqZHTkR?=
 =?us-ascii?Q?0ETn6irtMsBOzdJCnHSZDTze+mu5bTg9itLDH0geiQeU/uG/z5UjdDzo/13Z?=
 =?us-ascii?Q?HeBvmE7dfrSrJfYa7UzUu1wQ7gelIdI3Kg9XG6Bk33g5NrO40BqpSE2+naGQ?=
 =?us-ascii?Q?YV5B+NRrWN/Pm78Hue3wDGno0O+ZPSqgIvBtyB4OGaWcIbw3i/wluxMhtt0F?=
 =?us-ascii?Q?AXo6RBDI/FkVg89GQiC193XG72RwMCcwF+ry8kiEQcSooxOqYaWq6mZIQyFW?=
 =?us-ascii?Q?NwkdfTb7LugudMENiB6x302PaYYxIVQRs87qewAq9pmrrbLfSQDTbkymdPAG?=
 =?us-ascii?Q?iuNuZdsoTgeybZYUdVL0ftD1sAjpFlxyKOlqStNWOcYGcAteLjz0Fjive61Z?=
 =?us-ascii?Q?dych+nWBwt2XVkul8HrsdvpSe8z9A9nZqK1X0PKq+198kpi3pLza4LL6z8B0?=
 =?us-ascii?Q?o08DBh6g15QOF7fzHz/jsDiD1Tlj6x5r0tQDBSmqePk+/OTWFm5tLR12gwyK?=
 =?us-ascii?Q?5S42oXYkHjp0RveAgFDpiBr1E4owcG+3eS/S+Gxs21pZOK3SJ3IQ1xXxDnpn?=
 =?us-ascii?Q?iOqEkoNfKl1/gwmSCRg0HmGpI/RCSBBL+QJzNDMDyqZfp/2RQwEIlQILVarD?=
 =?us-ascii?Q?7pimyXx/VYepJG2GC8sbccpsxnqfatf9aUMcWZSBCksl9Gcc29q69vipZcfJ?=
 =?us-ascii?Q?jG0mY8OEcUr8dBDsS9NeljLn49xgEE3BGhc6YK19vC/hofIEWoEptTWzaYmA?=
 =?us-ascii?Q?M7g7Af+cM8KKWhB58bs04uw5dgtNxMpeU4eYA+CRteIFMOpqHDw/crJQM0gu?=
 =?us-ascii?Q?AedYR2SHNEx1Klw+xxDVwkMu6qTWlXo2Xoh9kOMXhQy7eaOYsscXM/lXPrRi?=
 =?us-ascii?Q?+9wiDmiXCVof/+ncnZvZ18fz9m8T8V7+aORNY+y16MFQabEJZOGAdrgy75zD?=
 =?us-ascii?Q?dL9bhpLhF4Ui+eVD3btqacjz4HGPQFOCEQjL4/bLbmCWRSEMLMogrEOzs2Z5?=
 =?us-ascii?Q?jqfls1jD0wO+/5l9E5MnkZmguK2WiguUMaM0+gFwOKfs90vk2GZFNEBaSlgG?=
 =?us-ascii?Q?UO5CwAXLYfxxsrgFfKjqwnN6RFVjPzFhn+CrjAsNPJTcbXnqjojhE1vvDaX1?=
 =?us-ascii?Q?KpfumzQKkl5qq5QiUrhcBc7QHZNWQeT+k4YSPFXlp3iBdGkrVa5gxfig1LCc?=
 =?us-ascii?Q?P6aPsnxWX56rYpw6+GSEJa26pp+XeMGBIGLpgxMFuCMn6RburlwhmVadbKTT?=
 =?us-ascii?Q?N+5MWY49D9L89puoQlJxm+qlciVGMLb03XojkjBhu/hpCr+0CQedF3JM1sA4?=
 =?us-ascii?Q?3aTcnsH+Yyg2qI35ytaN0yt0Zc0N89wG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUwm6HckkKgYSy038p0ENaizXyLnTmWjjA+J18I4cg9kFqlXi/fCi6+XBJzl?=
 =?us-ascii?Q?HH7b2qOwULuvzIpLI4GtaPnuZCUzJkkrr6uG7izKQy4pe7CJtK9pQ3QHAtAM?=
 =?us-ascii?Q?JjLBtjRZKpf+PFlpHVRGUNEwN9qMtIq3XGIENMK1MgiFwHY7b+7MWnGgrGwq?=
 =?us-ascii?Q?nBVD5guL37b+GvuTRiX6jY+QX5rntL3BH0eINdezZA6wXogDLg+C+5WMHAr9?=
 =?us-ascii?Q?gNhouYXlpbIPczD0vJcvdx2Tmv7OKZ+6xdlHQcGdaxR4LsmfOJDkCkr6I26M?=
 =?us-ascii?Q?FMDkFqDVylQbhwzYru8ZVONpAWAvfdZXEPcs+hEQRN9MpwWExnpxPhuCn96G?=
 =?us-ascii?Q?4VoGcMp3NWTSJtANHLKurXZamXhOfCKsoRLOZuLeclah0TEZjBIjXdLp+ZB7?=
 =?us-ascii?Q?ouwi/VBt22ERp8dkTIoEU907MfHw9vrhsFPTqZvC6DmJlsWbuY+euW1vsiif?=
 =?us-ascii?Q?tvG+uGPxrBcJERRxzLm6MF2+pAiawBS7ohnr7SJ5gl1c8zbH/10gijr+RNQd?=
 =?us-ascii?Q?lRaRHuHWMLPsUQhlBQk/hiDvishPVR7Y9Tr4FLdlEIEJde8AdNQ8c5XPzwAE?=
 =?us-ascii?Q?ufMPrZsf4/m/5MW6Nyb5WwofECrjbwXk67R7Uvj5OJtoy1kwmpx4pbnUzWMQ?=
 =?us-ascii?Q?OOm5iu+p8cGYDc797OFYNwrt/Vs2/aYtOWha5HTzVCIlWS8CVdQ3fEoH8xzH?=
 =?us-ascii?Q?X+KNE3yp/wpgKzp0c9A9jvafliVprMfh6MKe2vKwLZnkPaRSbJmbs1lHeIth?=
 =?us-ascii?Q?sVzNz+k2vMW31CoUHF1VdsjXWVmn8n4u+pPmX7Y0ausnz4Hd8B447U6/xwxh?=
 =?us-ascii?Q?UkkUVvOQn4iVxKpaIz0wyfTzy6lLTgEz0/Lp5D2paTnauVCZ+saoSv5PEUA8?=
 =?us-ascii?Q?GR+8aXD0jCQg24uPkANUTmF0PFUj6h0p5h/vLFbxOLJYWngZ5Q7Sb2kdyaqV?=
 =?us-ascii?Q?oFbvyZlfk+EMCDgCG+qs/eKi5yAzdY2uWr8gZAx/iKfd/xYD0YRG3w9hiAQR?=
 =?us-ascii?Q?52X+BJv2Eqf0Bf6gjF7IkzZhNtlS4F9s0s2VZWs6uw6DYlwi25MJtHDttg5K?=
 =?us-ascii?Q?+G72rzxail+M5bl1TMQRTkKpd2Z8pq2JqiAbJsk2npr3sZTm63ULd1CouSu2?=
 =?us-ascii?Q?ZA1eRJt6KppwN519XCPBD+eRGTXwGcKGFFDYDy7OCypFaeEeBdjcGp0FKJYt?=
 =?us-ascii?Q?XhE/L8k7HGHcFnlf5ksw6q7vt3onw4C9aLYYsagREk9aTUGR7fTHyq9C0mFb?=
 =?us-ascii?Q?ZY2Ucxm2baqthL0bIuh/oB/2Pn5IaNFa92sJikshVbnwv7tPoJ1s3okYysy9?=
 =?us-ascii?Q?v88qn4iVznqWZws1/4SW457W4qW3zfOwf/z6AGYxhREAXUKIQkYVta3YG6nq?=
 =?us-ascii?Q?43aXlee2ZlJ3/zRTnZ0Clnb3z1VZ7jlFtxLDRgi42R+yOFh23B9UPbQc2sN6?=
 =?us-ascii?Q?C2wobNj2jK+gNDyx/pF0W9IE5VAbc5FK+jrm1qNPcruzQKCkM/Dit9rJ4gCX?=
 =?us-ascii?Q?pUrO7TAfbIjJsLzgarnTcIFDg0hFG7f9ZLywd3DHn8e1fTujwQkVJ+6S9Mgu?=
 =?us-ascii?Q?Od5EJzlCRSBhs9dMe7uuUoBn6uCaIJ1TQcldVXMkidvHSxIsBk9FJO3DKqC2?=
 =?us-ascii?Q?ZkGEs0NjT/wi/sYq7KVUmEE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a62180-2624-453a-a797-08de3d7f3b9c
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:20.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrvG9RLaULOUFSGej2KBeu628cwFH6186NZxvbEdrdw7WXnXlCAiAEZ6A064QXoMKd62Nmzg0B0+dkCu+lq0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Add an optional get_private_data() callback to retrieve a private data
specific to the underlying hardware driver, e.g. pci_epc device
associated with the NTB implementation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index d7ce5d2e60d0..0dcd9bb57f47 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -256,6 +256,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_private_data:	See ntb_get_private_data().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -331,6 +332,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	void *(*get_private_data)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -393,6 +395,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* Miscellaneous optional callbacks */
+		/* ops->get_private_data			&& */
 		1;
 }
 
@@ -1567,6 +1572,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_private_data() - get private data specific to the hardware driver
+ * @ntb:	NTB device context.
+ *
+ * Retrieve private data specific to the hardware driver.
+ *
+ * Return: Pointer to the private data if available. or %NULL if not.
+ */
+static inline void __maybe_unused *ntb_get_private_data(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_private_data)
+		return NULL;
+	return ntb->ops->get_private_data(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.51.0


