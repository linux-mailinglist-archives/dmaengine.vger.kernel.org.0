Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC1501F33
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiDNXkh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDNXkg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE911BB93E;
        Thu, 14 Apr 2022 16:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy/Sb1Vu29a5o5UYw0y0h3SgUcw5he90dOHUF6ChsqQnluOnDdP6XsMtQvLsm83qONdIum6a3TyK7ATyCPbgyvusnvGRnCUUfHfMTHZwsBkUphN7rIMgAl7qksSykFlUX2guNVGZgQkXgIuJyGeJa6ypago9kSznMqBWL3LU+Yx/bXGbUohRZs4fMNecyXiNYemTMLnfR5N79s0+MQ+kw/8OgJ2R4GniaxMqo2Vpsw/vzGg55nIKP6Yj+iwR/YQGJm5DH/aRKcnNygDN6xQpfogmWFAOTQk66ilrXAPFbqtBy5znU4G2dEqCl74Tbqx2LRf6HqE4oM+gENtSKiIC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn1d7cVWoyxCwrJyzGvhKmS7ivgnjxhrbTi3k68JI/k=;
 b=YS1mP6lO75eruiiqJXiBQPdMHvezNqRMpzVvVB3M89YOleRLOyyalPXoBSqwvwFcM1CrkjBryA+D9uVeGqWMcUN5DjczAfMs+66BiYsaTy7D/bED+HTUBL/O2FIT92WJnyezmrSiHLnIFn76lktp/iQ4CZKAG72mtE6Yj30Sj1MgtgnGdk4uBcCxdv9gRGGRrMlX9MjbRkvbqpLvA6j2cxQn1r5+T3FsiAJxV2s3OHkZlvsk6kr4Kom3rdqiqNgustkEZd13NwNHu1PwbzrAOf2DrS+GR2TSXrOa5S4wSZyy0SZFiGUbFGLqXbCGUVU8wtclgkMhs+mkg8jFjk/13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn1d7cVWoyxCwrJyzGvhKmS7ivgnjxhrbTi3k68JI/k=;
 b=f8nNkBOpBoWGoqdzeaU/3FgLGTBVfRxP/iuCU+pvxP2Q0/2YTjZUY2Ehk+9lvXgRHKp7BuVNErNfC1VQ3cgAM9DvN7BBx/8rp1tGKROirAhqIzTrvdrzj/FoIOtyQ0kgPOfQZY4KJZ/TDzJMD+XTTcYune+hE0SPICblzIze5wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB6046.eurprd04.prod.outlook.com (2603:10a6:803:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:38:05 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:38:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 9/9] PCI: endpoint: Add embedded DMA controller test
Date:   Thu, 14 Apr 2022 18:37:09 -0500
Message-Id: <20220414233709.412275-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233709.412275-1-Frank.Li@nxp.com>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cffc9318-8aa5-4ca4-f4f2-08da1e6fd2d0
X-MS-TrafficTypeDiagnostic: VI1PR04MB6046:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6046C536D60D447C11BC143088EF9@VI1PR04MB6046.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RjiWoXG+Yqpn2Q7wwGZ9t4021v228tOfAxBmUmOD0Mf5M7OTiRvh9SYO1NuYGOjCU2NTPvbLCWD0RXiFy6Q51AtKRnzvk8d2N2wLPqbepNa4QCUYZEi4l3cShgnYZ5vUmrknjWdpQPKBIldg5PDT+KLJz6pNyg37qIEHzTmeQ0s18QNXgzhPJupf/tXPw9s0c1MHcBk2W1jmVkAcVxSW9Zr35VkWMoGscRcshOUR1jnafh5guHLJHCj9dKJGaord6sVYWze/+f4WHKPq9wqJPFKRiwHpSg1LreWfm6cYRMC4PfTE8kB9rgyOv38HfqOgusU4Siy6Yy7zlFNT3XjXp6c+nJ0n8fdS+MDqAXbgLnvT6Q/mXef0HGUPLjSZRABv3gY9Fb01n6uLWZERuMkErv5BvKfEfl0bYdRu6QV27mPIb1cpsycngU/Y6JiVmiVKwhT+iWAuNUmtxL0jlcz/gmWGP8kPjd/3h132LUvp/qC/YPMSMmHlLryLxxsGov4BXDGkuuoh/MHYZFZlmc0f3otTgV5kyvswDtg9bZPDDIdjoTLkyct2YzU9mbfxbbCpzSv2/tASE/xU2pVLeshla+W6TC3XlpN1eslvDEkldTqGkflnOsYD57Qfb4i9jWf346pthA4vqwnKWYeXxfYQZH97vfecWhh830yK5fhT8S7bGUJXgyQ2aCRxP3rgnPYGoKp4YL/elNGo5wXZ4akGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(83380400001)(316002)(66946007)(8676002)(2906002)(86362001)(36756003)(38100700002)(1076003)(6506007)(4326008)(7416002)(38350700002)(8936002)(6486002)(508600001)(52116002)(6512007)(2616005)(186003)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42B85Pvm8FNqWM7y910d5X9Dy1Zsh4KaP50GdYH1JKu4oOuhuDDJUoUOHN8R?=
 =?us-ascii?Q?7teqkww78cizTEh1DzlXg3DQGUlcRikjlZgxOjmvdb23+k4nMSf0pmZdcT0M?=
 =?us-ascii?Q?Nirv5d8TYgevdrH1XkkjMFfKT/vSxQ9nb+qyDwQRuYrq2lVh7ssrSUTxqr/Q?=
 =?us-ascii?Q?anQh4JIvtXJheAzknB/1dO9HyesAoq+pTYxUD4u7O+EjD6yUaiuZnZ7laq2R?=
 =?us-ascii?Q?bM4eykEJzyiybg8IRBP/L9GJUktD+c8zfcrgfaLF7Kke0ofg4jFTqMzYDLEq?=
 =?us-ascii?Q?QmzRCBIXoH8ShiGen+CVaum/u9V1eZ+hky0Ls8VaOY55kXDnvv/RpeXC+zsj?=
 =?us-ascii?Q?nbNUBs1yHvm9rA136wXYXNEKnRSVmci+gCYBEm3qmLpniu2OGA5u2R8YrZf0?=
 =?us-ascii?Q?3yc6hUqphEJhCUsGTzHS5E93Ded07gGYkjuExCTh2E8lD310CbWYVBm4aOwk?=
 =?us-ascii?Q?Ahg0M4JgJoS3iRotYF5BHJWTAJw/0r1uIaQBEqkjB5XKip6xyOlKUJyiw313?=
 =?us-ascii?Q?nOGl0avQDN5jgii8M2m00Djgq5QYe9lBeDYxCu7ZC4bhgup01Z834lc0NQK/?=
 =?us-ascii?Q?Iggjw1JvKABBPMdp86S84FbTabCDr9au82hvHf3/r2926eVhjV4tvbEQ1Zx6?=
 =?us-ascii?Q?hvGz4EvANlrP9PlnDtB74mWhRIgfKdaaptqT0uO/AR6/b6Hbtpbqfoor6SAc?=
 =?us-ascii?Q?Gc1VN65OKMv/+LUn55bwLRWw1ZhzQsWz5vCUCwqvdDuPg2eCQlpe4GS1uy31?=
 =?us-ascii?Q?ecH+6oOfncwG1vKl7IjkQ3HtVZmohCgG5Q+AlJa8H/G99mxP/WXj4wiW2e6n?=
 =?us-ascii?Q?ti9LR+2/xq8gtIxcsbtf+36A0aHyM+4vG/i3P6s0azf7yfXK6UO52iK0rqVh?=
 =?us-ascii?Q?h3pwbaHJ2cVppp6hgAGjbNNwvH/APE+2RyNuVDjhozkuuZ97/GvUooEhpOuN?=
 =?us-ascii?Q?HTDj8v/QLeiZVGOIzsgijSwQL3zK7halnY8pwgPxnda+JzddEk34nVxIVeCw?=
 =?us-ascii?Q?D81XGTXkoVIvZB1YybI+vT14A6oR6/QjYEPKn1Li8u6w0/f9tI4THlzyQS9F?=
 =?us-ascii?Q?aVPaU54TxZo20RNIsBRvrIvbKI/HWFMfhhHM7Lgt1nObwOf4piVxepWqXymL?=
 =?us-ascii?Q?mxsiGYwAXCZmH5vFw78NvkcFIuNLhApzyQnyWNHiiXvcWr2KHkvb9fnHHMCF?=
 =?us-ascii?Q?ubM4rmvtj9bTaNEl7Emq36dSfolIC+GezI1nVgOaYwFoLZu3WiYHZkZ0zxFT?=
 =?us-ascii?Q?Xq8j+Al6JxNCtnBhoNh5aFtf+4LAJnvXbgYXVf4niEWhxfPCzi+kYcdy+x6G?=
 =?us-ascii?Q?tCjbN9SlNYpnDLwIfgXd6dzzTJ+46DKCewv/M4TPTuISyAGsxN0CCrWFn50n?=
 =?us-ascii?Q?RMOt5EsA/gUYhEF6YqQlu2qY5ShvozQDDO1XYWTeurvPBs+zuZTFW0xnRH+j?=
 =?us-ascii?Q?D6T7RMevErTH+STl3Iu4armlOyODFQ75+3vAw1aLmm44wLBmQAiEynGLDdCI?=
 =?us-ascii?Q?QPJ40zBQbhb82H6/05ruFJ/fjKoL5biYNE6uwjBvOHM07lgoGq8g7IBLYLxT?=
 =?us-ascii?Q?dpQac/6ty0FWEM4JryHNDChxNrIHPazmBSOC+4UI20NTOAgMCq1vG7mQ+gfo?=
 =?us-ascii?Q?bgyULBgKQi42uYF0VtmB+7WLEuQGOcbE++OsjKdRs9o9XKTXca/TzOMIv8E/?=
 =?us-ascii?Q?URJraXdc2Ri/lKsxE9QiCu8rpnuMART2MqU/dLHdM3JszKEMjLIF15ZrVcNz?=
 =?us-ascii?Q?Z6c+FMSY7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc9318-8aa5-4ca4-f4f2-08da1e6fd2d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:38:05.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XMdcm15CaBETbXObSPbEjbFUbKK3Rn7NBCfc6Z5wx4Rk9c3jHWrkuCyM5Rf99vKytMSqOdg0c9YM2Ir4kzypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change from v6 to v7:
 - none
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

