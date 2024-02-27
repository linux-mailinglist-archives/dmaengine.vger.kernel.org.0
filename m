Return-Path: <dmaengine+bounces-1128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A4869C65
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099811F2415D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58EC4EB29;
	Tue, 27 Feb 2024 16:38:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C514E1C3;
	Tue, 27 Feb 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051906; cv=fail; b=BpHDDCsCkDxPyKBHNzZ6ISTe7TFpc1XsdG9n3BUg1U87093IxLoZDbUv55I+Erj0AXK1B9Bh6gQlYUOka7c6womzJ0EW6S7K0c5XHB+Z5zIZ98UJSrc3t8jj+z7pk4H0QZnGm8ukJ8uuLJhuvlkCgk7fYtNxt+uxqE8Ww3hgK58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051906; c=relaxed/simple;
	bh=vQnIwome/RITLxSEPdPg8zVumEoQTRVPxvyoCagaVc4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAMhqgXQjaR8jNOrikj7AYSi29qkx8bOlR26TgZDKtUvc8SYBvJeE8Dsf9kt1qDJ7swVFGITM6aozvgaT4Ek/VcKvu5qbvhfZbtkMd7TRe8EQiymo8QOX13wb2QHUmspPRSC0LSdQ4mikq7VRybokSWrm6DeWQdzsuyT561waa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWN/+B0xwP8yxGDVvO4bLH3Vqivjv58r9nNrPR+UesOSAsRzFLdc0mJpQ3w/vqd+kKDrD11IlRQUX72SvL4A0pPH5F+ydBN+VdPCv5KvjnfvL3eGVt+dlZVg434c/w7aSRppr1/ypkHeArFEiNi5SvP69OgoLATElKrCt6OYANz0V2KuibQW49A70Kcp9M9TnOIX/tOfYaCYIq7JiujwBlm7A54juMOS/a5xdBQuVAb5GWFBAvgYhdV3cINsXva4o80svJx013PyHQDZIM6+dAw2zzCLtWlVDDzIuWXCPqiBKWSdAx2Zt7Ywq8VvNyQ6ogQovVtKlTpXAYWmdnk+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jGezz0QBGIpjvFyJPH6QH02UJsDnokrqshu7vZ5iA4=;
 b=n0SBF2bwY1WF9UgLiCbjyLQA4HMiTFBXGzZuey4hxLCkoIHlHHPTPVgLnjlvkZRt4phZDF7kD0XSn0sXTwUnRhBfAenVb+Hl/+4VOe0lp25f5enr+NOXAKuLXod5XvCmbFh8kI5CrDLe3CsJjTtzZcjmbUNmICPHoOBqAGEwKECoY+yZesz9ggu1I9mIf3JixO1+SLPzlVTDJs06tGjfilCFPaOXYkD55Os2RDXxX7I4uG8vlzm4PZUGuDqouMK0nbEX3UY3ZM8buYwPMjnpGlwovS3JxajRbQtgzO/1smoi9w5zUmgSIf0gmIrhfTnwbF5QvKxYVdOtlrxPsMqUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:12 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:12 +0000
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
Subject: [PATCH v3 4/6] dmaengine: dw-axi-dmac: Support hardware quirks
Date: Wed, 28 Feb 2024 00:37:56 +0800
Message-Id: <20240227163758.198133-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::16) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0685:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a74df0c-d8df-46ce-8266-08dc37b27d2c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oGGMQQsjR62/3cN7BHyPMqlen+M06t2mnRXpW/q9lMXUGc2BrKSgdEh0mRT+yDnNviXoKUzaYR0qFim4pyVX4Q/V4E+AajXRIOCLiRX1de+Rn+n/1c1wlb50P+7TngQk6h5Bey91uYt8021TjYtyyKEpDaH+HFGDJUrD3gbsALXgMpmVZgaAhVK9iERaVcY5n6FADu+GnszBAy0VxRuPE61eBRl3vITtv9XJUuM35Uo4KJl5HW1BZB3xYOJ7Msss1cOdKEII4alfqNhckwKrjMXLNdcI+sfRwlIxbz1RbeblyWSyt8qdP3WpEjfpodVP7liIWEJN+WpKJ/s6nyJUvVxIiqJH7giEJz7CZV+dmDLThfNhx8sg3Z6zmFOSoiaBH3mtqWwTxtsjRyL7ONAWYxnDrkFlAisHR61Myjqf/Jm5XuUX9e9ehiZGXTmt9PHjgtND8y0njEIZ5V1PODJj1AS+nMee4v6km7oMpwojs0zI5u5ojT6zex/UNCyujldxLi9JG7G3Fgy3ragrclUItghThzb8H5aj2WDW6IEfs4XX/DvnnssDbKvAWgBRjBgj/8hJ7NL76hp7x5zA0JJMEwMvYBnUWPPVVD2Y1ByorhN3Yk5uoiT8aio+EjRotFgz8Mt22GUTPLpFs0ZhylQGNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sR6iK6JjR/2slLkwXiexKlrR668uaimqAK1lLkOXBGPm4DvQm20WJt0N5de6?=
 =?us-ascii?Q?P3j3ESFjOvFsyvFAySM4Wtt9VmADrlaXcvFLGYcq8WJsUgzGuIwEo490c9GP?=
 =?us-ascii?Q?foEVK/7J5YJnivqehEbbCviEB3Mg0tFpv7odC6kh65AEE54yNIKIHRj7QlIJ?=
 =?us-ascii?Q?YXhvh3Zbp+WBhdQrDA/JiUxEH216xPRlsN0Ll0UQvpx76dF51ArZo9apBhSl?=
 =?us-ascii?Q?+MlUlc2m6ZxFpSWgdzfv9xJlNlUDLfQrldpGGsLTRgfqd0hgpLgmpuoNizlb?=
 =?us-ascii?Q?CtKLvJrioFTfZOvcLZ1cQuTbtEnCBulqFut3JESwuOewta17terc7QivcHJg?=
 =?us-ascii?Q?KrtfWlHRr7y2T6SPLnMxfObyRPr0qVE353VuzgdD+SJvyznrYL0n/F6ZmBIw?=
 =?us-ascii?Q?XSOZJmQOhtPtMOYE0Q8+S/DIFewgZBYfh7udPcz+y/93sbRUdD/bAa6/ovfa?=
 =?us-ascii?Q?Yqdbs3ffYIoPt36dcudrKuLeMkpQPTvXGY/9gz2M9Xf51ESE+IQKb5q3MyLE?=
 =?us-ascii?Q?PiioZg7F3hnGWUNoM76Ss2o8MErj7YuKG9VHbeRsoEOXJ1Y2dvELgQeM0yeK?=
 =?us-ascii?Q?ygx29IOzT7fHAn8Zb/YG4X26kfioEiaN7wpjb6FzUUr9jKtBJxoiPk/BbUAJ?=
 =?us-ascii?Q?WDgtWkU8p9OHC9kjWDASopCjq+IUPeGjivGh4VTnU48xsK8RUdTd7p65pcGl?=
 =?us-ascii?Q?580OG4MKesLgEBHNtVQPn2rqcDGAHCXynIEKZ2gD51B9FoerPQJBhyQGMVx8?=
 =?us-ascii?Q?z6a5cMtqzZL3Hps+o4BX1p/RDFLbt9WNHnciY+3xqWgE1M/4oLJEguueK3K5?=
 =?us-ascii?Q?CHnmXLln9fa4F9iyZ00vgWwE2/3Ish9YDO5s5gZErbspy2BMTBN5j8+Pe8r2?=
 =?us-ascii?Q?nMI84gP1uKW+yFAtus2Y6w3DRHdEdx58fs/DqOBN8ZzBJCSL2w2t98KkIUwr?=
 =?us-ascii?Q?mHrPNBUvcJBM1wySAPYcnYHRuZ/qDB5UdL3lNdGa9suWLoPvRsXxeGUwioH0?=
 =?us-ascii?Q?QwXpTHMWiRBsTUimtvYQIR9I9M/L1ObQcumweMj1MN/mv9Qbs6UnVcd0j4Ih?=
 =?us-ascii?Q?rB3mWgzp5qMJl0lH7/pv23sbSOSp1ze8Twx35cbb4qXYWqlhSwGapirR9KVQ?=
 =?us-ascii?Q?YNJ/LwgQ8IDjy0HA2AARdjGpZ38vAfeVEat9z8tLP+/1AJoi1uYxfIMjXCsy?=
 =?us-ascii?Q?2KYE0h1HjStbzWt5u2i/rX6zS1TWegtg+K0vItlURS05SOwPWIhPdxKxs/OP?=
 =?us-ascii?Q?/SCb0BE+uJqiMZd75fXdbnZ173mRLTIbiCY/vku6Y+HraEmRCmPx8PHu5WMw?=
 =?us-ascii?Q?LLVu5Ygk+h7wVwNtvSnA44ygVqbQrJMAfSA6DaWcwEysf+1RdXbpame5vA1R?=
 =?us-ascii?Q?y4xydnUEyEciaxeRzxZfsUfA0PMbp9PPxpK9tLcLoooaFxDLJGzAPIM69cNA?=
 =?us-ascii?Q?tAPiOvAM5s08khzgI478tH2+IbJYV660OmniMNsebXd4XB7G97aLDjz2y9wj?=
 =?us-ascii?Q?+LLIRgDaHnxy8jNtdxrZYDIEgMVE02o7JcfDRDdWP24VQAq49QS2yRIADYB3?=
 =?us-ascii?Q?mjhClV7D5UuvT7duS1pXgQng44CnBkXI169DcXuWfqw6qkSZYF61oDwHT6Vl?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a74df0c-d8df-46ce-8266-08dc37b27d2c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:12.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rd+bLuZcAOWU+5suisO60Mrwzy3zkoS7tN5+/jFShWqtucuQJ68KeLE88/hYjdOZ3P8/1yIEjwmxWVRvNNAHN/vL/8hb0tHHwcCqRS3Pkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

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
index 2a4747917a3e..056b6ee1963b 100644
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
 	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
 
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
@@ -738,6 +743,17 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
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
@@ -814,8 +830,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	for (i = 0; i < total_segments; i++) {
 		hw_desc = &desc->hw_desc[i];
 
-		status = dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
-						segment_len);
+		status = dw_axi_dma_set_hw_desc(chan, hw_desc, NULL,
+						src_addr, segment_len);
 		if (status < 0)
 			goto err_desc_get;
 
@@ -897,7 +913,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 		do {
 			hw_desc = &desc->hw_desc[loop++];
-			status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, segment_len);
+			status = dw_axi_dma_set_hw_desc(chan, hw_desc, desc,
+							mem, segment_len);
 			if (status < 0)
 				goto err_desc_get;
 
@@ -1035,8 +1052,13 @@ static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
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
index 652e983409ba..f0ab5b692b21 100644
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


