Return-Path: <dmaengine+bounces-2501-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE309122A8
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9662828B09F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B4172794;
	Fri, 21 Jun 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="svwwJ0Yb"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874A173326;
	Fri, 21 Jun 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966493; cv=fail; b=GeSf/ttztqscrQPy4ZGD5c3A4kpOxUhEO31NnnJW1opt6Usqphuoamr2ZI9xLzRWB2jtoiuM16eL8aK+DmCdsAwivnso8hOnGq2DEweKaT61sViLw18QIgoghcb94wtmJ+V5O/LuGnfaVnOgwtngg0DmOhV/kfofsEjcHJ0W7yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966493; c=relaxed/simple;
	bh=kvOgTwXcO/zksQsy0DNcMtFU63B5yhNZOtrAY2hUOUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InjHlc2YmFeg2phon3WBESehOXp86GakqLnyyjq3FZ4ZBlFizL7bkNKUCdWQ/8IHbfelr7iSL2D9zmXDCLDAEm0yffr5rvcfbOqiqZ7IoVE5iNt2wTLUFNpq5+3NBDLS7NPRIDJvvJs4VJAYIYRudHws8b8L/Ui9iu5TptpT9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=svwwJ0Yb; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKbOxx2Wq1bm9BHXMMk1TKayWQBu2K1sMUZnkUv7RQAa3LpM24VJYS8XSSOPDvwjyZUvE7EiBRcVwELe16AUNWg6WCU8wBorDege5TMZRgOIh4M6KuEqab4XqpASKRkOLlOip6RFPqozmR/MiBaiJjLKoWR1Mz5FxioFZ4Ngg6LWNwi9RD23UXk6yz23zeqjV5ht3sItmmGOeO4YjgsfwyyN9HfpabBVjQD7OmauZ0iyATmKsUmv9P4chn17R/MAJZPLPAX1OS4MVyHdh/kBlO6JM4kCsr5RB/ZwhK5fF2ES30dW4CDKiMWowvdzbc4zrR55rty2R5xB8Pm6kuXMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoXrkpXc/GN3H8vCKkwQBfNQvUGmNk0VwDxRWo3GBoE=;
 b=g2TeW6tZ3Q/+wooGM2KmnJmBvweOiKSjuUnFQWy5JvmdY3X12YTQPou2s6+2/B99bhSW64QUfWJyBHitjqP20LUMcOV4+RN7+YR1wSpZB7w1KC5ewgvJBS2Bj7kioU2rTsDpFNS+sGyiTCkdAOHY4xoJaszNIsU695KqadFQSXpp0BZSnHR+uI0a9Setyp7zVdw3m/TiKFvgpOBXOUkYdGq2TSkQ1WPexvzaZNwUeVlmRWwEaEEW6tvGzPJukZBY5cG62Y9dGFxtV7ZuLWAP4G9s/uO09Xpr1i+2xFRAQvTQoLcLiTs2N5GnCK1q1Rq0H5eby96isTBTQhYFpueoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoXrkpXc/GN3H8vCKkwQBfNQvUGmNk0VwDxRWo3GBoE=;
 b=svwwJ0YbyUf0sfRtkdykBnQh1G/C5hUt/8lIrMuiCLu+4JicyzAqvLjz96z+lrUdOZhEkPIPtdA6Pcqd53MsDtBqxaI99Xu6RPJiYQUUqQ8n9mu6BX0Je4SB/3qbzLCApW2DPbN3g+WrgkPZtW67Lst2klLIhqQnZ/D/NrL0oEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8801.eurprd04.prod.outlook.com (2603:10a6:20b:42c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:41:28 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:41:28 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dmaengine: fsl-edma: add edma src ID check at request channel
Date: Fri, 21 Jun 2024 18:49:32 +0800
Message-Id: <20240621104932.4116137-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240621104932.4116137-1-joy.zou@nxp.com>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6cfda5-1d22-4511-ae06-08dc91deb49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xYjugEP2i4dsa4Knx/LYiJpV3XFwPehzlNYupggJsL6CWcn8dJVhlfFmapgT?=
 =?us-ascii?Q?C+aoKnrsmA/ZbNrC+PVxBtZK/DIBnXQHkbqnlE/mi+RigO5uFy2hXHRlWUSk?=
 =?us-ascii?Q?hYLRuLNCKC1Q4wbYq69tqCiiPKQfolMWRT69cHt8c0s2zfnhfoAdll2TzlpC?=
 =?us-ascii?Q?xuA4fFWM4sohkgzk0S1sNr9Zt1sg0mZpCkpj2jh5HH3dCjfpFfcrygIufl+c?=
 =?us-ascii?Q?LZ8x8O3uHxHE9u+3BdMosuS2bwxmjkV0tNDmKIjUqBeWbWF9fEAEa6hQ06lc?=
 =?us-ascii?Q?/ZWwzxzPcQGISpxpjCH3sS1M2qgQJLiajM2YUUPVh/lHTfKrT/3nFn4zXPCk?=
 =?us-ascii?Q?ljgvoBZr4MiqObzr7alzlnSn5KBZiGwGBfZLP0kJ0/p/2cgqY/b5wDQCMYu2?=
 =?us-ascii?Q?7hjbxwe9bJGqkCaTJ5La5ij3czPO3lkSEA2ebrCqpi8gTiRqEsUh3X12YAJS?=
 =?us-ascii?Q?4FlP2xX6Np2Wni7gBQixMc33uw3VN/YZjEsMiV5PZudfB8OAM9ARE4l1OlOq?=
 =?us-ascii?Q?euq9TVLVttcdQ+VGiGEoiPnc6oEqZ16YRmYqcoxk/V+Vl3V1enHbQTh9jxUZ?=
 =?us-ascii?Q?b3XzjflSxVcf993JLWLG9sNb9gjoYG3XUBH64aL43xd83eNTbWDN0gICZEDm?=
 =?us-ascii?Q?ikovp2zzDarOo/vyFqtJRej+/JDJ4rp1lo7BESQkIiX95l7xqkeeJG+Zz+tC?=
 =?us-ascii?Q?0znETmQkzsYTlwjbdKHxdIytA+O93BVc5blalpf3+NY5O9yXUqNH8CN9lWay?=
 =?us-ascii?Q?K5utJh7TLA+013mh7/ZswHATmZOL2tHhQf5HWzZADYyusTM9PVF18AD0QnNZ?=
 =?us-ascii?Q?YvD6Obcb7uzLCdwSLD+j0B053jYw0yY+E5gkIcPKMxR4KcyLytxo5jqDVwgf?=
 =?us-ascii?Q?YyFTL/rz5c0jeZ1DQSqtZXxj4oatvPonDNfSFOg9c6YbXadqAxqg8gMsSsWk?=
 =?us-ascii?Q?Ey/Q8sone46WlpLfuZ5Te48i3JgyLskxUjUbqMHth9/y0JU6wECEYn188TFT?=
 =?us-ascii?Q?v0i2F8E9bFVFMiZ34sKYD9Xjf8ezGip0oWv1zEWlh+ha+HomKvug+GYYBT+Z?=
 =?us-ascii?Q?Q/AGAJ3iPyzDpQzN1fxMx3hqRSUaGbOtDrP+5gzW+JpcHjbVSPs+DE3wlHlk?=
 =?us-ascii?Q?fQbxVOn1eA2jyqnH23H70UaKgoBH+W2nELXKRM80d1x/qROPtYCNVILCPJ5P?=
 =?us-ascii?Q?A19I2EJHPhCYlnU7NUWsYP+6CvZA/NxiIQ3G8WyukUlHNlE3rc5u1qI6xd5X?=
 =?us-ascii?Q?1e9VUaDyqJXnJ0HlovpsfnxfQVUhoiiptv12kfpi6NRvBq6O99hP0CR0EAUA?=
 =?us-ascii?Q?L/D0dDUMuPUY0fksd/LiekCx7nGSQQ4X+4aApOyvqGjM6WITEAGi6QV6lnZG?=
 =?us-ascii?Q?XXZsrG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2jd5oOuOyCDfYvr7AzlS4rDTl5f+JQ2EkOgzTlZycvoXSKX/MKQ4rYJ5VYsV?=
 =?us-ascii?Q?MLdVjve+nO6L4ztCpoHHeJ+YBDbw6xhzsSGdSZ+sG+YCklcgGEt40B9Oxsn3?=
 =?us-ascii?Q?tDPP1gkdd6kdjQVIZ887hBoWjbhsm7V3z+PMV7BKaE3v4grGQU69tPL31Vb3?=
 =?us-ascii?Q?1mBw6KvUwMJQyvo4pkyH/ZT3zA/25mEwYMsZzGwRnAP6w0j3uscVsNC5/dl8?=
 =?us-ascii?Q?dDDHIBfDdcrwQEFLwaZkyst/BmdYzl847U9lQGhe7LZ0WvoMAY+1ucH3qOWT?=
 =?us-ascii?Q?U64DmrLZg6kjojiAqkN9OG4+fJaYUOQ8Pcgq2k92Lblvv6cVRkKT1oV8AiTZ?=
 =?us-ascii?Q?PPZVGxSLDOmlygs2MKua16GTaBciJACX8lO2ukRRIiyswmN2dVswSlKSrCLi?=
 =?us-ascii?Q?5NWu0i9hRAMo8+e79P51AgTTSs030g6y2jT2CaUGxqlh30JNmaRaCMyXeRaG?=
 =?us-ascii?Q?Hmp1r/JvSUM+5FKjvhm9aQ+Fj8ojyX6NRuLIzr+Osj1idTjs6ruJWTDYv+gs?=
 =?us-ascii?Q?UEZzEKv7v7u80fYgpAxSZ5aqpldVs+dJq3bManPVoqquXgzZAwsph0rT2SNl?=
 =?us-ascii?Q?YSJT7Xolmv0jToqhQME3DPNTXr7MqH30oPABRfIATGiiITw7+9Im92/yCTKD?=
 =?us-ascii?Q?/ZGgcpwuO/L6+eJdz+Dg9xEZCc0kWJdxTDQpN0fV+f6CgZUP0i+BFJWsROjh?=
 =?us-ascii?Q?uysB/movDJtSJCGwD8Ya9DmsNq7gBgCqlcuT7MmsgB1XVFAOen5xzBreaDFX?=
 =?us-ascii?Q?iqkjsPtdo37FcnqC0HxUQUMC3oTkF8om7daPno4PDW+3Fr2eRWscd6B34aLR?=
 =?us-ascii?Q?NTUZixSPzvxwkcZUa/WwGWwxZIc5kfbaaPE9He1sfmXyuuBpEieN/yfCzxxc?=
 =?us-ascii?Q?yraCUDgm7PKGycK0gFT+mfihegnCO4D8WJPr0UdzTUC8PJEnf4A4j6to2Mrk?=
 =?us-ascii?Q?9Rjbdbg84uw6T2khRWgItMpM3WYmNeijAPqhDOKwFZilM/V7URIHiq4zac8f?=
 =?us-ascii?Q?DrXfwA4xKIcfMoia5ECSllWBX3cxVqsh2spT2ZxDDmjth7b2K1pTNgEBYVtx?=
 =?us-ascii?Q?2ytLk3c5hmrZTqfXgjEJW//HBUTCDtlmjwCfSUmN3mWPvJTM630GW3Q+rOLG?=
 =?us-ascii?Q?d7FtlOyfnqVIXqMo9x8Vb8ZtkMQ5Y7YsBTS0FpFVKfkHGhvKr6ypBRBco7uw?=
 =?us-ascii?Q?VEB1H3kEwwmpn+yQQbY4gjWa3Hj1ZPMlU6//kU5fWTQGEPULVy1T70X0k7k0?=
 =?us-ascii?Q?2B/sJ59eOWFFzN413qqaaMPJDY+DznZ8tt6iRIp447FeD0glmKF+D4eEJ827?=
 =?us-ascii?Q?NVkSgW0ay9ukPB+LyHgh572eKpVxkvwemG5vf8IUTmeCLAXRYY4jDt5VrtUl?=
 =?us-ascii?Q?6Yl+la9BgYsdbPLMieZsrWaymBL6nJ98OsslFjA+jiF5803Moy+2WZQp+E+Z?=
 =?us-ascii?Q?vQRRNjmDQ1mrLz2ZGc9K/e0ZTUBkbhLprLZu3tj0EJozNz5jrGMoCdhfTCXR?=
 =?us-ascii?Q?4WpY3a02tnsCMlwp6Ls6FY2H3KrCcSpjhfGwVqEV6QRaBAgsmLYzM2drOf0R?=
 =?us-ascii?Q?8G+YAzx6X3edviorX/Z9Wdi18/ZS9lbqIvmXW0Lo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6cfda5-1d22-4511-ae06-08dc91deb49f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:41:28.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx6UOAmJ6F2g3yNs+JtOQ+2R1OEayqKp9+Q5+cSaSDN3kLXSLidSTn9tt8fs+9ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8801

Check src ID to detect misuse of same src ID for multiple DMA channels.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index d4f29ece69f5..47939d010e59 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -100,6 +100,22 @@ static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
 	return fsl_edma_err_handler(irq, dev_id);
 }
 
+static bool fsl_edma_srcid_in_use(struct fsl_edma_engine *fsl_edma, u32 srcid)
+{
+	struct fsl_edma_chan *fsl_chan;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+
+		if (fsl_chan->srcid && srcid == fsl_chan->srcid) {
+			dev_err(&fsl_chan->pdev->dev, "The srcid is using! Can't use repeatly.");
+			return true;
+		}
+	}
+	return false;
+}
+
 static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 		struct of_dma *ofdma)
 {
@@ -117,6 +133,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
 		if (chan->client_count)
 			continue;
+
+		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
+			return NULL;
+
 		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			if (chan) {
@@ -161,6 +181,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 			continue;
 
 		fsl_chan = to_fsl_edma_chan(chan);
+		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[0]))
+			return NULL;
 		i = fsl_chan - fsl_edma->chans;
 
 		fsl_chan->priority = dma_spec->args[1];
-- 
2.37.1


