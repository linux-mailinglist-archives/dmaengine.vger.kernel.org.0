Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7735650F
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbhDGHRF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:17:05 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:43331
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349414AbhDGHRE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPeEub9zPvivYaqgeK7f7tFytrQNRoi/vEzdh9dliJuy9jX8BzBAIKvNVQyTXPtejqI9hyJ4zu8LEB3fRLlehvrdXtKcvQ/YWgn4DRku11PjazUS+Wa+GlYh4s1xVUHYK7l4cvIKS6GbLyRXNbGVBkEQn3fkZJQdfNoM8RiifdVVYxajFclXxiSW1aQ7SlFrkVCkzi+kEa3fODsZnWFkvKIyhSG44tKeCZUc+uh+zf4ACBbGt78p/pD43eV5ric0kaRJvkIRYn0YNxp/T7gvpHOzCtoFjJ4VAdQzInTSLd3v1OdPvR63TcrsBQGzYRePGhSifj2yJwlWN/4pwQ1C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnKNg6HF8H0zCLKEHAhfnF4PwBG+Kv3Zqrvtux+Dlg8=;
 b=ZFe52zNJlYwLjq4/jIxCmtuA5yCyEBTmBlEI018AmS/a1Vs4B/0gOqs5DfoScjeCp7m26EeyjwaaosJ7NSJzvcAKxm4k9tX8xuKgz/m90WcXcMjI6RdDTvUk9DvpzyhsK2hQJiIbt0dhMVT8M3mHfF75ukinFtvy6kOo9StDPn9NYJB8M4UaGV/Fq6TwFGuo1HTeO/Rq0IcLaKS3waYacsIH2ZEyfUTDEJaLnzscE6bnu9eh3rmfAq3SAKyADdP2WC21zmPb4eVicm+4TO1WTyRAFWEd8TFPA0uW4CBA3jJBaLv6h9YE/mgkNKYSGa1Hh43MW3id00I4jORo6VhpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnKNg6HF8H0zCLKEHAhfnF4PwBG+Kv3Zqrvtux+Dlg8=;
 b=YGNIZ0YbYje1cAuMFG0zuOuAQmlFeMOAj6T5T+zNz3E9Wt6R8jZKiR9fb+38LdkhQwKThxJr5Bj2CxEat5/QWViE1r/OSSnAaOxEIsRt+oep7VUt3PvBtSQOq5LucZMeUF7Szx6cr7dOsovEb5p1qJ8rAJI1uZr3VR02xsyRfJw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker
Date:   Wed,  7 Apr 2021 23:30:56 +0800
Message-Id: <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384ee712-0b80-49d4-d8ad-08d8f9951c05
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65090535ED98CD88A238A5DA89759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h2HfPjWJR1xuAEL1bjT+a9UGq3QsXnQynWGnWIRo0AnOEGD5quobCgLfaSmeNvxOCgJiCvi1Rswrj7gMcqJjptPyPO9x6ey4FoVNI3gm3Rs5YU2tiBGgwnd5Pza/VtCiwCA/W1ywO1a9J5qyWoFkTSng3r6/5xEqH7ahytCl8lFf35WGThvXaFPzqkt4+jlS0jfraMV3R88x7E6pCJeRRRWdgwFH7O+S0OmngNFsSEraTz7mbB6rawu3EfQAPh5Myay2pRFrWPPJndJp12cnD15nYvBIfwu0x2Cf+3IeMWvJgQuLSsbQVlVstoLUGLegwjBL0/p3DRLG+Ek9baoSX/JWKqF0sNwOPmOouYl11bUb/du3RhIFDLdM3BV4c7iYPOMGoHHfXEZaQWPIFOb9b2CkNRn0zo7hy5sWCsvFWv1P+S9LQWCsmBrXuqrVmoXKgwbumcZX2zlTWufakucybCLOI8RmuYNL0PQ3i7zzLnK3bggpuLjmceWSWlntfVliGWeZKS1/VK0LNvCeyCWu+7GAhDyfAEVGLGFnO1YqMuXHBs+8PnzAaYx4vBt+ge1kjFpdFtL5gldjZWuOCAT7W3MZUq0MHXPYxXXjBQvS8/AKp7k0BANdRbjzV/F8Wo2B3jeYbkGYInAUhgc/aGtr5LLIS4fzlv0JylTf7YOD19Ujz07iF1QNpwm0PQ+ufCTeRvsmdaiNPEXm5j9Bo24TqD152YobC29l8JU5MXTLsc/4NwX9HcPtEXOLogQUjb0Kg3kQfO0j6awIEo778M9xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(966005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0d5fuVncq/Vm88gQF+OCMC7gPmo2ZI1CmG+lLPIzu+iYSWPjxYuBymSpJT+K?=
 =?us-ascii?Q?KoYOenIzO+UkRMBkuxifR6Ua25iAOqke3A0nUQ0/sH+ZlH49CzZjZTA0NiUH?=
 =?us-ascii?Q?zhkJJl0ZgiNvporJJ7jp5Y/8kuRXVnEkcV1frdMJhUrK96dIWK/4/AqoROW8?=
 =?us-ascii?Q?fAwibLtMZS7O5jAO9OLhYvnVPvps2SGisTS+bUaNWLGqxAhSiWaQeeFRmuDo?=
 =?us-ascii?Q?qycFDIdA5exP7S7Wwg+CHGwtsdK+wECFAU4nXSJh52OquN3wCxTmjBcfNv3F?=
 =?us-ascii?Q?ypkuxdS9EKuL5XFS10Vrs5rILEWXgiUsyD2THcLtNtR64utzt+gZsyQ0fhX2?=
 =?us-ascii?Q?k7vzt0aHR97mAsskaXt5y3ezy80rJ5JO9hq/JIfLv29oXEEHDQfW8YJMS0Ou?=
 =?us-ascii?Q?rpNO6mnjSqngjD7vRu7WGyvZ1QfR6m+IY+iRofl0j2W4RC7wicACpoQuDmO4?=
 =?us-ascii?Q?pPvcIn5shSbZ3OQh5M9J7BBBQf/KwQFARbextQLcyprSt9RBQsVeXf1pZ+lH?=
 =?us-ascii?Q?VbosGrKUoNIeYLU+EuINoqsJPgYrrMh8PMr1yo1HWrTlLKMRPqj8D3sEWKK/?=
 =?us-ascii?Q?38VOOaiCGQ2i/jxYq2ZxlLTIZtVhCcSopTrJvdpfWBhscKmIKgw5AMprE+Ry?=
 =?us-ascii?Q?+DLG7agEzfcnkPZxG303ScASdi0XNTaJFsDlhoPOwCtFjzdINA5hANS8mtdL?=
 =?us-ascii?Q?VKxZF8LYXvTh6otGqtw8ZUx7SdC1GYwl1cpjbHvKJ8poXyXSyOK48za6bic6?=
 =?us-ascii?Q?vg8xtmj/RwV7n7QvI5JXgZjMrogud1NiqLccYNNQeDsE53grPBmAcF6/qO+e?=
 =?us-ascii?Q?URUSiICxOW4gVRJed8vm2D4B0qp9nApFIHGch1ED0eIbmFTOX2sQ9KCd8Xc7?=
 =?us-ascii?Q?Rz3I+olahdG9ai5/6PK+vjHPzDUMEblNfDDVQKbp+4S2c5Du+tD20hI2WWCI?=
 =?us-ascii?Q?HNISlCijjjsbwqqXq77wgxLFV1CRqNFlo8WgC5OBjy5pI9k1SuGt6h9fdCVR?=
 =?us-ascii?Q?vRAmuFSFqjSp0z1c3G0vOHBpJqSKd5K3IqTfj+CAGohO17loNfKZZ0jY2AJF?=
 =?us-ascii?Q?p3qBjDoqyk4zUc0bVGAkayePKzuXEJS5hcy8nHV0A05egBU/8bWESdkr8n9Z?=
 =?us-ascii?Q?zlrCIScLam4bWCK/KMjx2HhqzT29Lz0t50YeGTxLtkZANJec7B8TtG1dQWGU?=
 =?us-ascii?Q?qBkUlzXRsMwma4qTFiu+RY/EzhL6/d/aL9v3Neo5721cxVz8Q69tyRZnrAWN?=
 =?us-ascii?Q?0jUUpBmqXbpdVy7O2p+XRlAfZTRs/UcgAl0xEm+rbfpPeqDgXQ+KMJ7OGguZ?=
 =?us-ascii?Q?PXrhO7tJWtzrBQtgI7x++U78?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384ee712-0b80-49d4-d8ad-08d8f9951c05
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:48.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9xtfrlx6Ym/PQShDs0cjNHl/ETJcA4w61fBr0TOCJshmouloR3TcjuY3+MOs6+uSr/OWB5lES6N7ge7yXJYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add terminated list for keeping descriptor so that it could be freed in
worker without any potential involving next descriptor raised up before
this descriptor freed, because vchan_get_all_descriptors get all
descriptors including the last terminated descriptor and the next
descriptor, hence, the next descriptor maybe freed unexpectly when it's
done in worker without this patch.
https://www.spinics.net/lists/dmaengine/msg23367.html

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9519b41..4174580 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -381,6 +381,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	struct list_head                terminated;
 	bool				is_ram_script;
 };
 
@@ -1041,9 +1042,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 {
 	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
 						  terminate_worker);
-	unsigned long flags;
-	LIST_HEAD(head);
-
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
 	 * (maximum is 1ms) should be added after disable of the channel
@@ -1052,10 +1050,7 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	 */
 	usleep_range(1000, 2000);
 
-	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
-	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
+	vchan_dma_desc_free_list(&sdmac->vc, &sdmac->terminated);
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1069,6 +1064,13 @@ static int sdma_terminate_all(struct dma_chan *chan)
 
 	if (sdmac->desc) {
 		vchan_terminate_vdesc(&sdmac->desc->vd);
+		/*
+		 * move out current descriptor into terminated list so that
+		 * it could be free in sdma_channel_terminate_work alone
+		 * later without potential involving next descriptor raised
+		 * up before the last descriptor terminated.
+		 */
+		vchan_get_all_descriptors(&sdmac->vc, &sdmac->terminated);
 		sdmac->desc = NULL;
 		schedule_work(&sdmac->terminate_worker);
 	}
@@ -2075,6 +2077,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_LIST_HEAD(&sdmac->terminated);
 		INIT_WORK(&sdmac->terminate_worker,
 				sdma_channel_terminate_work);
 		/*
-- 
2.7.4

