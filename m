Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB31F0758
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgFFPVm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:42 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:4772
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728796AbgFFPVf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgiVD/nAxUGEYZYsQs8qIsoTP3tZjFKFD4N7t5kohcLl2nvnAi20gglt1QwwHidKxz1tRpmuPELeji0ZQByKcy/TMzkaXHEkhgaokukb2Wv7J/Dw6qDxazVHYC/EwKc/L7hTCNAVr7grUvv2I/R1EmJGU76QE39A2Fs1SAUD2yLRnAV8NT6PeT1JbLoerR7/AMCVA9vfwI3iSH7pyeKV4TZkmvpJUOSvU9qPA8lWKam8gDhqfGRFGlrk6ecBdfFMHxU+TMTgRfAdzEpoNQzpDm+X38Is0mNz4KByaJvwIwkOsAcYa88Ett+6ycpv1yv+ixlKs2wPrwupovPAQN6Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qQFl1M0PiqWRUkPgPmPfPvDrIW1FM8N4ycyyrFKX0U=;
 b=b/FpYjo/3nYpS3oA+GizDUZM1kORhJ5qNGLjkmSlWk4LXKtLFhwKOK5eRMRmXzRfMLqfrdRhxnqGqZvJAI0jbM6Ay6JZIGrildVs9pOHX8ORVQd3RNvkLsKqHu9Il0Hc0OmCNRQNYwOKuZUBB7dgO5Wm4GDWLkuVIsbj5P2ftdyC7K28XUTlcjm1vRhO3TB/o6/93PoTGOf9tODSGiP+p+1Z1GSqvwMLZyMPFxtgLhsiFb1o/Z6q2TR58pa2/O9np6YbIu7O4NoknJ+ptoNg+kFx/6Gm9MSF3WPLDgBX+HQY+DqRSuu7Z1cdN0wbjKjbrMp0upJOhmn3fcEgczwOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qQFl1M0PiqWRUkPgPmPfPvDrIW1FM8N4ycyyrFKX0U=;
 b=nDbLBGFDuW0OybcKbZLn/++WHjDoLeZD+WdkTYqxHmLERx3GaJzpRul5SvPeIAqQUMOvmorvTtzk20ZAYbF/MdaMWXDg1auzvvvFGgK46IgBcRQXfcMvuor8eZOLLhL3VPHrxIk2bw5pTpeQCgkLCVJ/brFIBYrAYlvGTJzdzZg=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:28 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:28 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 04/13] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Sun,  7 Jun 2020 07:21:08 +0800
Message-Id: <1591485677-20533-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8c30ea2-6689-42c6-7728-08d80a2d48a6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6511D3EE6938E1EDBE325DB789870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsTQ/OSsLxKpdwqlXLLCrcB//dkCufayHpqpHehciwr9SR5GVR9VQ2KIRwvvuQwC1yubk3fKoVpiQIlL/m102aPTNE5ZXJrP4EEPs0k/eVt74uavJd/ofVcQZxi724mWEemzyUwVEXx9LtI+rqzUnZL6BxF100tHjB2uKKBDvtNq0Ug8OivCt5UrX+yiw4UVVM1OoWJDsDRh6xTPSUlDjWF5reWlMcFaw6pYtmGvrlzsnFHJjeH4hJhCAj/9Kp0jXtUdcj0GZhfdzSFZV7rv67VgwfT5TEBt/1eQhKns3QTGtksLQn+sdi1QAztvaEDybsxSaB58ZYlSwXkdsV3gVr3KLms2DTpR2aWRWbUSmhrufP4BgKqUJHPXYBZ3vMRB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(66476007)(16526019)(6506007)(66946007)(956004)(6666004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hyukN2eJkaNeplzcILKDE/EYI2KfNsLewCuCpXYT8AxOvSRy69cfo/HF/3idrBQhcvGqJEqETYDCzAGtsH27tAubGvzY2nhu+JQJBWnqGzD3y87BN2jFS6owZzhaojc2NQFaaw2fH0mlMexp+0ucV2SFF76HJhNKhwEf/6NKqaoAlA8FDXCgdhlOcifwp/xlqaXX9SeBkkj/aY4YuU7dKOMwIsYBcKrQVCaH+o7uz2O3u2Fiqy8G4iCESOFaSuGF9wy/06Vcaf4RuNUfGxqfQWJIRSBHGCEImmyEfk/x4d6z6c+6DUs761jSnro6OPg1FAY2N4cY2bgvdC6YRQPAP5Gm2NZIckdI8DL4/gLwsIThLFs90xkSFoxEO6CpFgiHIUKffs9d1cdCnZHe3KDNQTnWeC08Zzf08IMeaUVYg7k3Fs123mT7dyuvJU3aUHYbf8BgDvO7nQFx4Oej4gard6c7D1AxGsLiqKzch9AzFFk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c30ea2-6689-42c6-7728-08d80a2d48a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:28.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 852c2YOqcAMSgQizp4TfxcwAY49FQa8+lId8e1kDSXH0J38/DOzC7IHZiHh9+5rAelR14SneWGcyjWiWsIjYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
in spi-imx case, burst length may be changed dynamically.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9177403..b1f61eb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -377,7 +377,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -984,9 +983,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1029,8 +1025,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1069,7 +1063,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1338,7 +1331,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

