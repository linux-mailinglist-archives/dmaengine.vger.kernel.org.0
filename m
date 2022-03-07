Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD994D0B67
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbiCGWt2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbiCGWt2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:28 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30057.outbound.protection.outlook.com [40.107.3.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA44512758;
        Mon,  7 Mar 2022 14:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb0vmAjMuJEheB4uJk2eqWaZNJmRbyg2mX0r60CUCpiIHKUOdXfL/klR03taH7daX6hnw/+d11u3vDuauVMpUKOu6ihNhzVpX/MgoYqeawlU6rUZu6ia5im6JbuzcosbL52naBW8exg1o3DDNT/Z281TPMhItsD40Ou4EIth9HNNi6JzSd9r2w/yzB4sQ1yLpFRrFTiA/aE/P9tAjasOZm4i/pDCsOnmkRX4Em8nZegg6dLRmyLKCIwSsN9RDzuzAg4gFYtDmKP+w8UYhxKprkmzz37qliyiwY6kq9oM8EYvQT8hc4fVs06eq4tLFcgG7kh6cv1GeFGDhXCdkRbIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJsK8o8oPKxVJur6QrbRbhKIRvsRU4Om1INrgQTBMOc=;
 b=cODQtFGQn/BHGWhlX7eqwpnIIrxhwdvGFEH6gz0mkozo6GBVSDWa+5gpftButa3PIw58bsa1jygsxVlWl0JAJSHiPGHCyJiJvjwJ6+0KeirVrdq0B45aLO61aP2jbg9aaMeX4XLMOyE/S0qSxCB4heFMmughaKU/6YVanbhUErnuNSwgPF0hfzbFCBCtEjhUEV8D4LHGgxNYX/G73NfZyvUBMO7EENGtK6T+VHTz8JnXND+4+wKDE35fPpC2XnONgzDBHjUJjX7ktwx8WAz9wfRK76fSw4AHrM/TJUtzOjIT9HHOE20G825TCkf1VtC/Q5xyZO30lmsGdZZOx+smEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJsK8o8oPKxVJur6QrbRbhKIRvsRU4Om1INrgQTBMOc=;
 b=LldicASiZhaKbqLKZPNo/idjW4PDXgFjnclxRB4qzgJqfH2KvujRyAPhVDVIwsgrVCvl3BLKjdAncRsy+JoJpSofPsPA16NDwY4cqiMFJqFybZH5YPnQlN2IO3zTWNBoB435vNi8Guf84/yU7tz4QKhO7JfxAXPp/NRuUn2v844=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:30 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 6/6] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Mon,  7 Mar 2022 16:47:50 -0600
Message-Id: <20220307224750.18055-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220307224750.18055-1-Frank.Li@nxp.com>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e7cd7c-24b4-4762-52f5-08da008c9991
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4946E3209B749F46BCDA939688089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBl0Gt4lsPfdV8wh6LkGt2tKSQUMTplsJq6yqZ5a+m+nV/0y8GIVI0IviXkCuFg32Zp8ZHfs2yMDPdonvJHJMGnjgfojTx9Ip1VRT3NSRViSTpBRbLNx1/zhMLwt8UyZSfBX9xeUquErP72CjexoT1YBrio+w7vFzYNpmHq0yVxFcIOv7UUlRwHq8JAtniJyEjEyg0i94f0LoFQZmw3SIm3ED+KRrWzNKakgQSQy/dnbrAJt4lzEqVXUU7UPNcsvTSkJt33h2y3E2Y24DtoSqTUIAVmA1pdfYT/m6afc2xS93C0qTgz7/+F9Zl4suiY9kEun6ywwHbZCWDpJ0qFFhquwqdp2YMGn3kMzPF4JaKcI0aPzex1t7TgRqBBw+v3D7E3VjuLv+kch3ChniS23uZ8vtJowrcYlLJFGHOgQpGuALmwCo1bLfa4BAtFZ2A56Ik5Y60mD7hIKrPNyReH3bNfZ/0tK4mJ1OGv3a2OHPwQOSYOQuZOGzXa6AGHkES8tzbp5gepJqk5voMfD1mGiqfOqJdnPJQCe3klNtoA1oEbgBi0EFGTrKFEg97R50o440mYvg4HywHQ9mi6D4ac2tS13I+MFdHUHXBs/RfRAygwxMCzTAuWgBM4R3n1TEW8s2uL626b9ZY7uKFGzh1AlGcrVwQGcYdX1v6wwrOKHyQKRQx+ml3hE+pksRFJuZlhkd6zd6IMzlNnHyTZFpLdv4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(8676002)(508600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUbzKksp7jb1JJ59YMdibeSgz4+hkpDdha0Rpv61im5SMoyuTnXfX/WDsYOb?=
 =?us-ascii?Q?Gd3Hcf9uOuUazbzU+s8PtGC0pnDfQtoRKHcQf8OmhLJMO4qf7uq6xPMtO0OV?=
 =?us-ascii?Q?ZWRUeYEl9PIyJMTQAKjoxNI1Z4Xmf/V3SZBT2yj9s/7Mar6aGKP+1zHONAjt?=
 =?us-ascii?Q?3X4jHcgYGbCQWwz0rRlBK6/o3cLwCLbo/q8p4a3lLkgUH3YMbnZp8TJF13UA?=
 =?us-ascii?Q?XPUAyNmni6GRVtTFso0VsMGwV36nYYoRIqB6y9Go3VyIk1gDwSBpsugDUyUU?=
 =?us-ascii?Q?VZx3KnGaBs9HxlpnLHGl0WTRZY8BNMP3kOWfVucG9fBIjth2Vynsi+WAfO7i?=
 =?us-ascii?Q?OdTq8ZPljbmzHSQ2POx7kUb10dI77xyk/AFfxu/VdWJY/2jhiAnx3WGIzU/U?=
 =?us-ascii?Q?XF7Ef9JME4vjAavK8DGFxglvIIN2x1phDJm66e+l1+1UrhdrvxLBJaRnSBC4?=
 =?us-ascii?Q?3CO5XMpBOwa01cdZcIlGU9yQTgeTsQzOMBykSG1MrDMMt24zHrBnei4kj6ou?=
 =?us-ascii?Q?QDtFinckXnujdw1u4RZvdauXyZPs1YOQ5yK84JSNZ76Bpmrn/GR+zqCMriMW?=
 =?us-ascii?Q?TGO/fxb7DyMOrQKRTq3KAZVDepd19KtuZlrTv0lqM7HgXaBxV5+Xx2GmMfMY?=
 =?us-ascii?Q?IXx7oMvl2hcZYfwn6vKhRP/G2JnUmXryqqApOkIyfTcnECzAj8n1CSW9EKuk?=
 =?us-ascii?Q?CeRtEGPk+YtiiTk1+8Q1QNncLvN+bwrQLmTSkcIcfnKm3WgHxgqGuIGhrG74?=
 =?us-ascii?Q?BTrBk2t0fVqHIOwaklxQBOqo9ZKKG+PNUceIxtY4s7VbakEf9+qp/icuhkzh?=
 =?us-ascii?Q?qP0v+8Vy2o/KCR68nIeX0EUVb7iKQB/hQogfgjrcCPruq5lTIsVJpQOT7wky?=
 =?us-ascii?Q?0q1vZmG91A0d9FW2PVCVXjPf325z3FVuU0cA11TqOt49UlIMWPFkndL/LSZI?=
 =?us-ascii?Q?H3+usRWKd3KxohonzoKjOmVnH04FB9ePNeCKJunzOufclLKiGfkRSjoozb7J?=
 =?us-ascii?Q?2B1R0ey+GAtYcLzpeG3O+nnDPlUmt0j1T+1U7cRtfH7r2fyI4EdBpjMlE/b/?=
 =?us-ascii?Q?DZ77xYNwI0jHqv72LizVDpxM3LyyizMnRC4LGn0t29z1AaY6+l2E4E15OWx7?=
 =?us-ascii?Q?7UKi2P9/x4OoObAKn9GHk5Hn0w5yFOOrCTexvJPVuFFZ0yCbwa5oZBdfiNew?=
 =?us-ascii?Q?HhVusdl+3CjoiCJiWfG6nEL7mN7dDORGeTXbfWKs4CRkKajeNsOZybeidcXW?=
 =?us-ascii?Q?ehvwhd7x3QgH1Zs9QU2Oi1ymg9pUt+Noz3JsmTH/gCi8uKhEqE8D0HJKTZ6Z?=
 =?us-ascii?Q?xMTm45mnC6xYkk+9A7tfIpqzMJ87cAw2NZ0PEvG9MeLpVts0IwgPvz97CyoF?=
 =?us-ascii?Q?Fb8CWI7yhZRKBIfGg4EySdkiktlqr/ze7BWDfyRct6Ia6eE2la19fCnoa8w+?=
 =?us-ascii?Q?o/ZLcPgBuQT1vCfw/6ZZVvNAcAn3tFAOyDlRQ7fe9WQDhMZei5s93sIKjlG9?=
 =?us-ascii?Q?wJuw2BCkdLzA0+ARBgsZEuy6Hi0KvdpuKg7Dx3H/5LOi2PVYrT8s0DF/rogR?=
 =?us-ascii?Q?LPVFsbVMIDFrKuGJTTkCZDWAoKqB8xiiadCYhvJopMBFBkNUtd7WjE2b3NAX?=
 =?us-ascii?Q?EWNuXGDXa/oInoOiWK2lhLw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e7cd7c-24b4-4762-52f5-08da008c9991
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:30.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ4dx+lWl91OqB0kBQPbuMrDhaHXqdf6bvNJoMJZ2K+tV0uc6VtJulttUJKYbmC4bNG8LnTgLRuwuwT7kkmzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Designware provided DMA support in controller. This enabled use
this DMA controller to transfer data.

The whole flow align with standard DMA usage module

1. Using dma_request_channel() and filter function to find correct
RX and TX Channel.
2. dmaengine_slave_config() config remote side physcial address.
3. using dmaengine_prep_slave_single() create transfer descriptor
4. tx_submit();
5. dma_async_issue_pending();

Tested at i.MX8DXL platform.

root@imx8qmmek:~# /usr/bin/pcitest -d -w
WRITE ( 102400 bytes):          OKAY
root@imx8qmmek:~# /usr/bin/pcitest -d -r
READ ( 102400 bytes):           OKAY

WRITE => Size: 102400 bytes DMA: YES  Time: 0.000180145 seconds Rate: 555108 KB/s
READ => Size: 102400 bytes  DMA: YES  Time: 0.000194397 seconds Rate: 514411 KB/s

READ => Size: 102400 bytes  DMA: NO   Time: 0.013532597 seconds Rate: 7389 KB/s
WRITE => Size: 102400 bytes DMA: NO   Time: 0.000857090 seconds Rate: 116673 KB/s

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resend added dmaengine@vger.kernel.org

Change from v1 to v3
 - none

 drivers/pci/endpoint/functions/pci-epf-test.c | 106 ++++++++++++++++--
 1 file changed, 96 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868f..22ae420c30693 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -52,9 +52,11 @@ struct pci_epf_test {
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
-	struct dma_chan		*dma_chan;
+	struct dma_chan		*dma_chan_tx;
+	struct dma_chan		*dma_chan_rx;
 	struct completion	transfer_complete;
 	bool			dma_supported;
+	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 };
 
@@ -105,14 +107,17 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      size_t len, dma_addr_t remote,
+				      enum dma_transfer_direction dir)
 {
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-	struct dma_chan *chan = epf_test->dma_chan;
+	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
+	struct dma_slave_config	sconf;
+	dma_addr_t local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	int ret;
 
 	if (IS_ERR_OR_NULL(chan)) {
@@ -120,7 +125,20 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (epf_test->dma_private) {
+		memset(&sconf, 0, sizeof(sconf));
+		sconf.direction = dir;
+		if (dir == DMA_MEM_TO_DEV)
+			sconf.dst_addr = remote;
+		else
+			sconf.src_addr = remote;
+
+		dmaengine_slave_config(chan, &sconf);
+		tx = dmaengine_prep_slave_single(chan, local, len, dir, flags);
+	} else {
+		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	}
+
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -148,6 +166,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	return 0;
 }
 
+struct epf_dma_filter {
+	struct device *dev;
+	u32 dma_mask;
+};
+
+static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
+{
+	struct epf_dma_filter *filter = node;
+	struct dma_slave_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	dma_get_slave_caps(chan, &caps);
+
+	return chan->device->dev == filter->dev
+		&& (filter->dma_mask & caps.directions);
+}
+
 /**
  * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
  * @epf_test: the EPF test device that performs data transfer operation
@@ -160,8 +195,42 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	struct device *dev = &epf->dev;
 	struct dma_chan *dma_chan;
 	dma_cap_mask_t mask;
+	struct epf_dma_filter filter;
 	int ret;
 
+	filter.dev = epf->epc->dev.parent;
+	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
+		goto fail_back_tx;
+	}
+
+	epf_test->dma_chan_rx = dma_chan;
+
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
+		goto fail_back_rx;
+	}
+
+	epf_test->dma_chan_tx = dma_chan;
+	epf_test->dma_private = true;
+
+	init_completion(&epf_test->transfer_complete);
+
+	return 0;
+
+fail_back_rx:
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_tx = NULL;
+
+fail_back_tx:
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
 
@@ -174,7 +243,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	}
 	init_completion(&epf_test->transfer_complete);
 
-	epf_test->dma_chan = dma_chan;
+	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
 
 	return 0;
 }
@@ -190,8 +259,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan);
-	epf_test->dma_chan = NULL;
+	dma_release_channel(epf_test->dma_chan_tx);
+	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+		epf_test->dma_chan_tx = NULL;
+		epf_test->dma_chan_rx = NULL;
+		return;
+	}
+
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_rx = NULL;
+
+	return;
 }
 
 static void pci_epf_test_print_rate(const char *ops, u64 size,
@@ -280,8 +358,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		if (epf_test->dma_private) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
+
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
@@ -363,7 +447,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 phys_addr, reg->size,
+						 reg->src_addr, DMA_DEV_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
@@ -453,8 +538,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
+
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
-- 
2.24.0.rc1

