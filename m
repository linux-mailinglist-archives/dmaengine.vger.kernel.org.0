Return-Path: <dmaengine+bounces-1265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990AC87165F
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0891C20969
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F027F7E2;
	Tue,  5 Mar 2024 07:10:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017867E59D;
	Tue,  5 Mar 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622646; cv=fail; b=ZCoIBs80vpEryyahSQ8o/0FYaqljT06y6J71xD4eXcEzoF5MtUHsyJSD0j0b9TFoDeDJ7F2NEP/jPLu2dqecEtK+mn0SlfEQdHD5/xhYvag3RFDp5ELmTI2SIQgpChGxwlKvXpgfAWLRUemg8Rv76FYxHgMamZKQKHrVOgMjzGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622646; c=relaxed/simple;
	bh=fvpoLzKrkpHtFHcG9EX8hP0AgMkpQwrtWBsaj28pfxc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSOuiPL5GUiw1O9iWMcfu99cQxj2/e23qjHbXi15OlRhXZald1wdvzeqYUtu8iwY69V45ZKn2bRypUL/jzvZlQWuu92bT0J7fzl6aHEiLqbDLzZbi8jnIrKjuOmsJOe5lgLcvQscWhAOnsHxfWsQAk0sDUtTp2j5qBLDEXV6WFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhCPF49ZIBbVVhrmsM5X5ZkDi+rU7s0UrQUWU7QfNt3sPXwERVji3T7GTnKhNLquucYrakXNz9q6AhZ2v1hyPd1MwwzIQ4GTvo496nEHguihGx95pnec2b1oVpd8o9YVTEZiR4ln5n5yzrREKU7i1jzVp+KUBhsP4eq8ridshWT4I+53nyX+Bt1jqCFWzdvGT7bRjK5HCt73rIFlcAZ9G5J5787BZhA6RNPvAGSeiSoyP7IRj1Mz5Afx2TgwtAJVyvL/1wsdBqH1rQy9UFc7qmRlaOxPqYwxFa9tphGV02hskjyBj+v56wL/RHo8goh7/yaWb9zUdbj5gLYjRygjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vg5zTDVfx3zry/Rcynyfi4N2hWHxi4ZNRXcgpfI4UY=;
 b=SYnxNGhIxW99TTFy4uEvjJ8q6S1kwquanfA07OudWu3cy4grp0d2QRJVPR2hdFvbuF9LxZqQrYszPdQrH8ydeoV5/g2nxdU8cBFKUF/vPfrTyHgyjAw4tzYWjmauzpOQaAQ4VSVSCvm8cgshhS2iSBVE/5S0dOPGtMMuEZ6DXizPnF697P2/lqiAYeIc/j0OKEC1AXFlSOdJ++imwkAO3kqDHfxbA91je/Q3Jt1OP/7W0GDt5+U/YncWeZp/2lmqh5h6s9OROFwce2xpy3fjGqXXy0hUUYERZcg4eDT0fzIDG4VLzy9coXFcxW5JpNGCuA8Fyy+wUnm9NK6N7kEatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Tue, 5 Mar
 2024 07:10:31 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:31 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 5/7] dmaengine: dw-axi-dmac: Support hardware quirks
Date: Tue,  5 Mar 2024 15:10:04 +0800
Message-Id: <20240305071006.2181158-6-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cfa350-87a4-4430-7352-08dc3ce3583d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3Ygq72zUuaILTEh8qs+vNObodS/oVzhxLL4Ly7o2M7txlK0ZoU4TtWAiQr9iLk7pxOPqNlhgb1RvdrsW/z+eON7LKa/BTiKVLeBFoMim4AmueeWZVFqAlv8URVFKDfOHFIUCIyvY/DHOwvX7SF/rpMr7Cc+XtwpR7Dj6cym01isURVfT1luUCI0Z47oP1T4aBx0hbybffyMd5AQo37oQImHRsjKrugufxkWhWpk2e1w76JTXzHcPTLv8DENqQDJK3XbqrapNs8s00iSQq/6JU3hNmzS2tn0h9qSMRAEzoRGU6J6cOlq0SYHIGSuNsemljM7GrgbzfbhECY9lQxzpJNj4j3Rj4qGtS9rSB+7jWCfOqyTJKOhhF+sQBCb/kXbkjqBVliorKukT+oKwAw3LfefAE+PLys4NLfwl2iuRta5rv+d8rFRZzZ7ujsE1oolxbWSt53WkO7WokJLp6oQJZXKBVtxc/mGRyHg+D/RbdmnbecrdBtE/B7yjOeN3gcnttFmyLCo3M9rRW1ZjV4OO48ctbfu7k27ppND0EZY7lwuTr1/mfFvhBRyyL9VqyjD16Gn8n2qYKtaNWyuR6zwcbzrqxkNDnc7FLMaNf24LutEAtJbmkq1hKXkwhLc4+PvKQLOe/GsWmS2ORiUXCaVnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpj3sTR8SuCOB1z0wpt+g+4QOo9ZD9uUZ73fjBI9CZHZ36lNk7B3i2ZFUawX?=
 =?us-ascii?Q?qu3+7oWjX47EV6VYstK0binmqnu2LbNnyGoeB1nELbKD+P8Y1Y3ZOEDjpDX1?=
 =?us-ascii?Q?Ap0F+HW4PJLjLFxPwNE17mQm0kWG+FpsI3qoQ4fReK8O2KfwjbViIDBIM3im?=
 =?us-ascii?Q?MxFC93dorQim/41oI8QqyP/YprkSQfCl9TCncP6Z+uyDvNKl56UwXVmOMb9z?=
 =?us-ascii?Q?wrRIWjgIhoiGF5SZ1yZxTOGQnYUql61AT++U/sdtxv2LLlfbeBADb8TPAWpV?=
 =?us-ascii?Q?KmGLzTbEZdS1VFubUooYvPgAt3b9jbGud8uStn3UUbCX55oNXaAcZUdlcClz?=
 =?us-ascii?Q?kezwtS8txjXC6HMTIbUuyfIZ+smQObFiGuDx/z14HK98wyG30ENQ8Bq1r2Rg?=
 =?us-ascii?Q?kCevuxE34CeQDAJgmZ57DA+LvaELluKwOSLP8zauLshtpo3U/JWfwtkkQA05?=
 =?us-ascii?Q?BXJ0igNL7QL974u6M6Tdo+k5sIUMesKnYrSeWLje9BV2o9KvBlhNqLZpMpdn?=
 =?us-ascii?Q?WV5pUkulQOFDIPGGKiYfossfqJyQiJHDeZx/kHApbOxcjB0OneHGgArvjPHV?=
 =?us-ascii?Q?7QOMKXGnoql2tlaYl6SfASQ4rU8/lhOKT9Oub/rGGuVV02jEdDXOl9V9UMjL?=
 =?us-ascii?Q?PKgOmWVGiLadmTuwLSLt4NbqGIRYzSFtQw+d0s17vSENyUOB9QcDDyzjCBrL?=
 =?us-ascii?Q?8a3Enr4Zb4wC4UudwPNyt4R/iI6QZ/2iG0/ciSRhUkoiZZQubET0/xJgtsdE?=
 =?us-ascii?Q?KCH94lJTnO+nGLi/rqJypH5/HWX0/YGdGQEdP1ZAB6edPf6cPcr3IHGVA8Q+?=
 =?us-ascii?Q?95nGOycMEcQPlwHHw3/VQ/9uOThXBtZV33dlC8LniR7mfwxqkaShWoIzNv8N?=
 =?us-ascii?Q?y+pYFK8P/oZUt43I86Axf6cEMj4bin3tRWgjWbS7qK1RlW7IjRZLmR/nm2Cs?=
 =?us-ascii?Q?On18Mcs5gL4yl/lhHYkiwILaujFJwflRXaHAq77CuukgQA6dXWGt/jPMFXcG?=
 =?us-ascii?Q?TB0QWYfD81coSQSfpRJzAC9V8lWE/OcsMIcYLLd5nUTsjcEqyRlPV0cwA3hS?=
 =?us-ascii?Q?Q4mTlruCUcrnAc4mfUMi8qCmCi7fiW84CTueYolNEuY8pmN+Zy//c7ev+/2+?=
 =?us-ascii?Q?Z50vw6TFB1ic08Jw3oV+4UXyJsyFeOFSVeLQ/8606x1UoeYIpuNedFIgTEsA?=
 =?us-ascii?Q?D8AVGLP2zj2BdTMOS2mJjEjl0ttihwz31Jtps3iZDuCH/XE3J995vpSH+XXC?=
 =?us-ascii?Q?NgkCAoKESol09oEqrky+ptueY5g6WdqsB0wcJloDcS6qwqHArzOd1BqeWyv3?=
 =?us-ascii?Q?STyFQeV8mpMtvXAx+R6ZpobjvOjrNFriTfJkyy8um9G2wrZSu/iv+H41nGkj?=
 =?us-ascii?Q?pwhul+Y8dIcsPbGNTVzLVDU/XkXkvXpOo44dN5ec2pSAtox+yh/5EqAtX3fW?=
 =?us-ascii?Q?+/dTicO9RtfmUnh0wJ01bW3aOISBDL+0vhHtbJdGmXHIMdveykmMozLpFuNM?=
 =?us-ascii?Q?9I7PJDh6W4Q+TVyphVZqfR6b6K49chBOZeohghrOOSxFgZRsJHdxXLsRnXQ4?=
 =?us-ascii?Q?j9Tb0cWVBy2ZcCYusjDOHnEdeYJj1/J2S3S6pdrAhGVkOfRyr+0X0AUeO/Q9?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cfa350-87a4-4430-7352-08dc3ce3583d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:31.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QJVEyYshNA4JZhMilNbJ5iWQl4FMYTtD6BB0ZZ7bwtNSM7UqB6hvqnYJ266KhFBG8xuX6OcVIxtH8izXdJGgESEyIkzmrZOz/ikZj3mMiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Adds separate dma hardware descriptor setup for JH8100 hardware quirks.
JH8100 engine uses AXI1 master for data transfer but current dma driver
is hardcoded to use AXI0 only. The FIFO offset needs to be incremented due
to hardware limitations.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 32 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 ++
 include/linux/dma/dw_axi.h                    | 11 +++++++
 3 files changed, 40 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/dma/dw_axi.h

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..684cabe33c7d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -647,6 +647,7 @@ static void set_desc_dest_master(struct axi_dma_hw_desc *hw_desc,
 
 static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 				  struct axi_dma_hw_desc *hw_desc,
+				  struct axi_dma_desc *desc,
 				  dma_addr_t mem_addr, size_t len)
 {
 	unsigned int data_width = BIT(chan->chip->dw->hdata->m_data_width);
@@ -655,6 +656,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	dma_addr_t device_addr;
 	size_t axi_block_ts;
 	size_t block_ts;
+	bool hw_quirks = chan->quirks & DWAXIDMAC_STARFIVE_SM_ALGO;
+	u32 val;
 	u32 ctllo, ctlhi;
 	u32 burst_len;
 
@@ -675,7 +678,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 		device_addr = chan->config.dst_addr;
 		ctllo = reg_width << CH_CTL_L_DST_WIDTH_POS |
 			mem_width << CH_CTL_L_SRC_WIDTH_POS |
-			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS |
+			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS :
+				     DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS) |
 			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS;
 		block_ts = len >> mem_width;
 		break;
@@ -685,7 +689,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 		ctllo = reg_width << CH_CTL_L_SRC_WIDTH_POS |
 			mem_width << CH_CTL_L_DST_WIDTH_POS |
 			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
-			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS;
+			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS :
+				     DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS);
 		block_ts = len >> reg_width;
 		break;
 	default:
@@ -726,6 +731,17 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
 	set_desc_src_master(hw_desc);
 
+	if (hw_quirks) {
+		if (chan->direction == DMA_MEM_TO_DEV) {
+			set_desc_dest_master(hw_desc, desc);
+		} else {
+			/* Select AXI1 for src master */
+			val = le32_to_cpu(hw_desc->lli->ctl_lo);
+			val |= CH_CTL_L_SRC_MAST;
+			hw_desc->lli->ctl_lo = cpu_to_le32(val);
+		}
+	}
+
 	hw_desc->len = len;
 	return 0;
 }
@@ -802,8 +818,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	for (i = 0; i < total_segments; i++) {
 		hw_desc = &desc->hw_desc[i];
 
-		status = dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
-						segment_len);
+		status = dw_axi_dma_set_hw_desc(chan, hw_desc, NULL,
+						src_addr, segment_len);
 		if (status < 0)
 			goto err_desc_get;
 
@@ -885,7 +901,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 		do {
 			hw_desc = &desc->hw_desc[loop++];
-			status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, segment_len);
+			status = dw_axi_dma_set_hw_desc(chan, hw_desc, desc,
+							mem, segment_len);
 			if (status < 0)
 				goto err_desc_get;
 
@@ -1023,8 +1040,13 @@ static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
 					struct dma_slave_config *config)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	struct dw_axi_peripheral_config *periph = config->peripheral_config;
 
 	memcpy(&chan->config, config, sizeof(*config));
+	if (config->peripheral_size == sizeof(*periph))
+		chan->quirks = periph->quirks;
+	else
+		chan->quirks = 0;
 
 	return 0;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 454904d99654..043d7eb7cb67 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/dw_axi.h>
 #include <linux/types.h>
 
 #include "../virt-dma.h"
@@ -50,6 +51,7 @@ struct axi_dma_chan {
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
 	bool				cyclic;
+	u32				quirks;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
diff --git a/include/linux/dma/dw_axi.h b/include/linux/dma/dw_axi.h
new file mode 100644
index 000000000000..fd49152869a4
--- /dev/null
+++ b/include/linux/dma/dw_axi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_DMA_DW_AXI_H
+#define __LINUX_DMA_DW_AXI_H
+
+#include <linux/types.h>
+
+struct dw_axi_peripheral_config {
+#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)
+	u32 quirks;
+};
+#endif /* __LINUX_DMA_DW_AXI_H */
-- 
2.34.1


