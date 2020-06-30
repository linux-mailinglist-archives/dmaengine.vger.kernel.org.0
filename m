Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3493320ED60
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgF3FYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:24:49 -0400
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:27808
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729429AbgF3FYr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKOUzcaAm0Hbk+XCidhjPYU93ALuGqMSEPibYsESKsgXWX/ppHd/VyC1+tELlOwPj52MSn+pfSJPUXgOfcZzbU2NVV1pUxIDHVPottEvzYibkHbK5C4tgycmopZnJdzeh5I0m7LyQU7YhOCr9RD/qD2TWewLoUdRFgECWPEkXO5pTsejOp1JttOiKkwC2Q98cJEWDnXaUmLLksaPGkWUG8MC3sf8NCI6dmR1TfsmvPw/mmVbi/jnhB8rhAuyU1FcsROzPn/9ph3bMXk2QIt6zaB7R+J6VDZABAFRB+YP5GyFZ4zzrwIWPm25LlkUExTVdo0gtXi86eQTDWhO9H/f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=G1eSCJQLTLYrVJ7C6XqMakw1cK+5XFRkl6fhJ0ipWtFFWDd8CrZ+qjpCa8w+IGTRWRdtmCOHp21ubSosdn/Xlj84TbN4wJggTvjEcG3Y1g8XGFTywjn9ve99TmiMltx1nJJV/65uW6wTvJiR637HJil6AZCb8bEjOIQ7QwT5goiGMlPi38ouhgFIAPqE8ic26qixHS5FwVirDWka/MEtX4bk17A6PJ55sCi8tAi95GehQZ7jN35hqXq8Q0y+bzrySyx6A3Yz5l9IS0O3XdZ9Gcl9O8hltwV6o0m3k34mBpct4SXOsA9ro4SUtf7rHc8kRu9IslwnPFGe9wXjsQU3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=jYrxVPKx1whSk79TUnbfKlK0qzQgUMP43Y2CFyPMSEKIeFI9xAJxTHANqffw0R7U+LabdfSoqWVvmLHNPUafm0c5Qy69kiGchktDCVJSNrj5JXjMnX9I/d+1dHAWEokOBdCDspeXkpL3HxJFUoLJ5sHl+KuBheVc4t2O+JeDNJI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:44 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Tue, 30 Jun 2020 21:31:07 +0800
Message-Id: <1593523876-22387-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc80ae24-7547-47f3-f42d-08d81cb5e559
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66407821D41D933AF2D8BBCE896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMu9+mQBRNx8yC5/nVDcs/itvaRg1ksj1kmZR15S/8DG2EwtJKvkEO5DkE+zGeUIwkO6Sb/TAnhO3A41Dre6ComUhTibwWllX2xfxMpK1wXtvBcRgM30G0wcBuz6nBYea4rOVRqko25L5cKkv2pRM1PfPQzS4LK0jSFBX3pQQ8KnDL7ApE7dloJ0/mCY3aeROpv8PfNbTKczlKe8/HFXOdYWqSt+qcZHcdoRweHYlFhc+MjErd+RKoWbhVJxN80TIGMMXZGa4ky7XFLcAgc3QwVppNfU2UZeWn4kgjZP9/MSRsP865QaODscA1KP6ffILmXFpvRJKFmQO4mnVfVPlJoLSDIPGvC3+uFdgISPFYeADVgh/h7niwIVMwgkibsV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +/XH65o/mOhYD5+trLY0On4cN/32lFGPhZF5kD3Gz5ct+ZHfz2Bkuiop6Hf575eOupcRb5kTeSL5dNfUyoS/g2fuHn7ZBga6bvEsM6EQHQjBNDhvxFbFi/QjpOMybneuH4Zbpd1g9+HjlvmOHxxu0RbxNa+8KaHOoaUpH2mpS80PCCSMo0BCduqdP67c8wZJgEZBnRunx2LVQaYtkYoi51fT6JmtCf9t68+fuudi7LoSHcdzF05zvvYCI5/EuoCMfpQcmZJSGxGPLJXhnoUQAj1/obkOeyPwU7n0J84K7NVu8r1mlVESCWdNT3SJMUsAAsHI4md5e9JaPjREPxC6VR5fr0cKaMuuSXySIRZivlBinfemCeE7ocRkbxUJmVyx9F7eIkAclX3rNybKWeckK1TB3tpwTrMpCdscDg9x/AEW0qz2AsJe1V68V9t60hwySMdv/483hL3EkKq5TU9wcv2W5y1x3z5mlzPC29iKeC4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc80ae24-7547-47f3-f42d-08d81cb5e559
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:43.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qIQ96zN+MBGlSdhEM68R622cue7qgol2+WQO5q5Oc7HE4nbTErJx+Zh8o0Lxmnj4bs9OoNJkzk1emMr6NN0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
index 270992c..d305b80 100644
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
@@ -1337,7 +1330,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

