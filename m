Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD04F6762
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiDFR0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiDFRZ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94C4BA29B;
        Wed,  6 Apr 2022 08:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4oQyBBlLgR9JHSftdchT2ctJMJFFe3UGq8yND/d8YblwfDfzwkri3Fv0R18pBY42gO8mTGhme5b93nn/+Z/nMMMu6dHFQ6ND6jKXTBGQ0D/BZ8s/VgvFz0KNb153155VbxZexJ+BI8IobfUYWfyUvh5ld5S4xQxJ4IwV0dgxFf+uCVZJlqE3p3odEMNKHTY2SIUllkt5e0KwwmqcCD7AbgC1LXyF/hIs82pl7yGQNlI0zzjlyko7wnnMi9sisJzZORk1wHhH1pb3imyjnnBnF2Maewito7jtWUcPP8Dd6bHOP9QqcBscClDhrhjvJon+SLbUCLvH/fctw7wbaP6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJtXm+zNJZQy6tHmSCx01cwTZurxDWNk+J06aO/kHt4=;
 b=Mz4gUJCm+h3HrGN7nIaVoEg53XSEAVzNolBhrtVrmcvJb1UP71JFcOanEHs8ynXQ8uQWnd4MdM744bXMGP3Mdh1vcF9jDRGNaQt7kHCt3XwUjPZslBhuMF3Xufl2P3MkYxxyIWqtH9375Fn27QicX67dO3u5Z/F9eP3zVvJIvhE3CaRnj4HhQhamXYv9qspEf4eA8RXEaa7C66UbX8FLlldNNw0vA7kPL+IfP/4hYwUyITz9j3/UtVHGQbMZJ+URIVXM8Pb2dhf2Q/cTsJ+qj0EbkFbKG+yZJ632dzAE0eOM90mN5TxohEpdKKMBT7WucV5uiX+/DeicmcCFbOthxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJtXm+zNJZQy6tHmSCx01cwTZurxDWNk+J06aO/kHt4=;
 b=jGsFr0KcUys4jDlFrm0+QrQdcByWcMGSGieXirQNwcwq4xjTY/tPXQO/aqySmF0Fy/Nxd+XZVGQ2c7SPxAXUqRdgRJyhAkj9KybwsZ8KtiePdErmvUqYq3QfpcqTggOAgriIntmtkDBIyrsiDsbQ4+FG50EpXo9FVhgKPAHo/XI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4033.eurprd04.prod.outlook.com (2603:10a6:208:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 15:24:57 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 9/9] PCI: endpoint: Add embedded DMA controller test
Date:   Wed,  6 Apr 2022 10:23:47 -0500
Message-Id: <20220406152347.85908-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5b422e-4e10-44e6-9072-08da17e19b4a
X-MS-TrafficTypeDiagnostic: AM0PR04MB4033:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB40335CC8980CAC935DAE749A88E79@AM0PR04MB4033.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITfGYiky0Df9sEHcHD9Iqye9LZfHfcPghHMyS7CcRgu99zdpTTPaG1xx8QuQSeeax09vZpbZaFieoWTzul4+c1yFyB9amQqSXC7qULFeGlSzqEj/xudE91lZnXmOngtMIFpb/0kbayf1UXE2KKf4hRkdbmNrHpLQHKqEIrhbd7JKnP8G7gvWFgbZjtbx0zY1mzW1zYFVxFa0oqBFZwUJTaepzFd0BrD72zGTFJ1XResghUX3qb5eXMTg3/7CLsNvobWqoMKNQ9i9Ha6Gn8ZJlGGNMNrHrYBenvaGia24wVINg4G9xqXSm70noD89gQcGqFbiNtVgOg3o/Zp5ivtZlGkU4KcLStCyuvvEQji+GRjqEukKOmBrNZ/jPkP2w/hB+VVVoqcfw4IlxIOPYnQmkMfKkKgV5wjlSslvK56QG32ASqukP9gT08zrTp2QJEUVzjyFv6zipFODpFlYrk9lInijIRkwvcpayBwkpzofIrvIhEskC8Awhbla4gDt7wRVva/GvwhoYHEAfgqdmf/mfND5thmeOQwj8wB1FrL9LWLouKhUsXVCe1hWtA7TqNipPkxZ4dCHWUJwS3rYk3vqqLeRUpp15KUJ0nUqdazv2uF760Ojf4sTYjeP4zOaFNowBV7eJbm8bZVxNfCMOP/IskoDMavir4GKAvhvWFPhbBQzrD7N4OGR1RE2dBxn2q8yLxHAosmkyAExW2g2qe2CMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(26005)(1076003)(2906002)(2616005)(36756003)(83380400001)(186003)(8936002)(8676002)(6666004)(66476007)(6506007)(66556008)(86362001)(66946007)(4326008)(5660300002)(6512007)(316002)(508600001)(52116002)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bw2YUmzZk+K9JEiZIQ5jNCNe2ByinhYqRiaYsa7jtlyKAtLqjnfMj22eKvi/?=
 =?us-ascii?Q?KskJyYrp82ZHMzwxa7tlQ3dVijTrotRJoKZ8CPzq12ScNUcWGpgZ2bpL11T0?=
 =?us-ascii?Q?RI0yHBCx3qKB8I3hSEaXaKlXipGwM8KCbOU5doXPNu3+iaAQXrpY4jE1PkH9?=
 =?us-ascii?Q?9QwWypdT336ks7fY5/XWHEiX/426krZa7urOxPTWKvE+Frsra60Gt6FpRMIl?=
 =?us-ascii?Q?lOoO/jQrYjryQlH0w7a60ay5s2Memvtq5NFwti6BtjpxEd4bO0Jj+DHp9t7m?=
 =?us-ascii?Q?lG2sfCIEdIz+reyimVVvS8YJMHVdurmXW4kQfnMW/dPnARDbYIp9hbGvpshJ?=
 =?us-ascii?Q?eE+HOuPRFO5r6rbenAVTtHhTyAQXLST2/6cWC7EzEUiEv7IrFp5Iw0nbV6HU?=
 =?us-ascii?Q?ryw/VguygBGGLxBxvEaAhtil/oQGgnu0bsDEd8WHIi82cFir8JdXBqJaGSRZ?=
 =?us-ascii?Q?6CatmMaUqG7765J20Jz4ITexTmy1F67FsiRxwAnfalX0EsVNmYrb9VzKP1C5?=
 =?us-ascii?Q?RMtExaOGLuFCvd+mPljkT7aVrFAeTst3qBBqdVGXiNwRWXnJWg2Yl3TuiSkk?=
 =?us-ascii?Q?y+e958zm8ljuiPfRokTwtgnrgbvgee5X6DfZVl2TrYq+O3iimxmDSRAYRPTH?=
 =?us-ascii?Q?73zl0VLE2wOoL1ujA6IQl3qiCC0eztbsyR3gBMlvSHEUaX+NcWSWceo7AEWc?=
 =?us-ascii?Q?ZJnWSvJfYIl9s4lqJEoJC7akDmwN0vLLkprZ0yFCL7DhGh4gkiqW9q0E1Thw?=
 =?us-ascii?Q?QA+v/aT+y0OTPr6M5acOqgBa7ee4IEjOTrbBUu7vhR4DR+PonqNvKnYIc4so?=
 =?us-ascii?Q?hHFfZG0bxRFpNWaPuQLGdHf5WShXftdiq0t0AbdIZ9pyGxHhJanlwwDylOyg?=
 =?us-ascii?Q?d9VsnPMhjdTMJGQkk5v5Aki/wQknKkhwO5MJroKGowM80Xn/59cllpSWsZhY?=
 =?us-ascii?Q?dtcayyYJUb8FxCSdLg+VTjd+tfAOIhQhQmtVfUSQQKWgDE02NvQL3yQEUmA6?=
 =?us-ascii?Q?GWUQEHE/vCvn5sevdHMNEsbY3VrGivAZWhj7DsLA4V5qbceQXKJ9rdYlec7n?=
 =?us-ascii?Q?rTbLBr/KL/hzp2+hSAGoTfP2yGD+aypltxHcfNglW8N9RSxmaH1ZwHkRylAE?=
 =?us-ascii?Q?cBnHHEDf4IN+dOtolm8bmlVvY2kHt7CGmTLUrRqICIQyRY2h5pzpSoEghq0C?=
 =?us-ascii?Q?AYTHxc/R7GZjdjd6Ks/Ztqm0Qrl/MEOrlNtZAswhyeSI9Hkv4uTUahyCbVDK?=
 =?us-ascii?Q?cx3etRmUfwQNvaUrTR4BrGmC26uJ8rhKgOfOOb62DV3mBeLnaYLbuoTf+YmD?=
 =?us-ascii?Q?6shSUqXKpO+pCwZb+vitoGnY5Ldb1nV//9L1m6zpKmiTU6rMCdAayPX6Lv+9?=
 =?us-ascii?Q?nTpVPZZ0rmH7VteqfiMnFGB/MgXyle+ExNJ1Cj12zKXtnwyDyEkbTPOgpd7r?=
 =?us-ascii?Q?jJmHaemst4R9I91Ts4cK6I+9/8F1MSia5pNtjMA9AkijXvFHBQVfkqIp6qqG?=
 =?us-ascii?Q?SiwwyKq9QCfVPxAx2To1F3DzXRbr03seFSKpUzmduk/DiyXDcF7s/WKwOu9c?=
 =?us-ascii?Q?m4NayZd4q3NkOPknTf5h7sQIIkQqksrca44FJM24CPjW8WTzwK/F/xATSFdW?=
 =?us-ascii?Q?sPSTFMB720Lbtaov3VS8gFaF6rUJB0ew3naRWUHrRSf6fxUl49LeLfR7oX4r?=
 =?us-ascii?Q?TrsQUhs+L+xB4zAyF3T0DR2omSOuMSnbaIuJP5JxIPHg61wmQJvdI+c2Y7Ce?=
 =?us-ascii?Q?loDGuaFVDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5b422e-4e10-44e6-9072-08da17e19b4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:56.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Pr5QoAMnyJzh1IDaJ/cyIIXYvBihDPXEJ4yIchAKLEVHrdfjj1NbezM/BZ3bn1ifUXMPKqngDBPkbzbayR8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Designware provided eDMA support in controller. This enabled use
this eDMA controller to transfer data.

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
Change from v5 to v6:
 - change subject
Change from v4 to v5:
 - none
Change from v3 to v4:
 - reverse Xmas tree order
 - local -> dma_local
 - change error message
 - IS_ERR -> IS_ERR_OR_NULL
 - check return value of dmaengine_slave_config()
Change from v1 to v2:
 - none

 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868f..f26afd02f3a86 100644
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
 
@@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      size_t len, dma_addr_t dma_remote,
+				      enum dma_transfer_direction dir)
 {
+	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
+	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-	struct dma_chan *chan = epf_test->dma_chan;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
 	int ret;
@@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (epf_test->dma_private) {
+		sconf.direction = dir;
+		if (dir == DMA_MEM_TO_DEV)
+			sconf.dst_addr = dma_remote;
+		else
+			sconf.src_addr = dma_remote;
+
+		if (dmaengine_slave_config(chan, &sconf)) {
+			dev_err(dev, "DMA slave config fail\n");
+			return -EIO;
+		}
+		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
+	} else {
+		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	}
+
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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
@@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 {
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
+	struct epf_dma_filter filter;
 	struct dma_chan *dma_chan;
 	dma_cap_mask_t mask;
 	int ret;
 
+	filter.dev = epf->epc->dev.parent;
+	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+	if (IS_ERR_OR_NULL(dma_chan)) {
+		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
+		goto fail_back_tx;
+	}
+
+	epf_test->dma_chan_rx = dma_chan;
+
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
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
 
@@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	}
 	init_completion(&epf_test->transfer_complete);
 
-	epf_test->dma_chan = dma_chan;
+	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
 
 	return 0;
 }
@@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
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
@@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
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
@@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 phys_addr, reg->size,
+						 reg->src_addr, DMA_DEV_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
@@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
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
2.35.1

