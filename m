Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193450A2EE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389615AbiDUOry (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389719AbiDUOrp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC5EF2D;
        Thu, 21 Apr 2022 07:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqN9sXNceL8hhRGKOiG4PmllIGAlFTnkh102hIa83rmIa1qv/BFRc6YO2klcQVAiFLpP0Exi0h0qQN0MM5izDXQmmAAbY+v+TzhtbC0uKdwSiAKBW2LWo5ZB2DjdRhBo6R1Ae5OaS13wxZubUx6G/qK5zImc9R+91KPUclIiHVXxDjE/hmQXObPPGigQJMV/H5z2yEi9m0PjQUcI5U8BbggN0ostxYzaWtEIRjtJx314nH2uUcvA0PUaIjcp2zZNz+x+RDwiO3qkRlUPJ5qf+tVm2A8MIHALmRg4yef0C3LL177LqDEccXHOqt7N6odIImXILTdv5Vb+MpCgV8Z/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj/pveH5kPziUMCOxK05/YsFnLQbVdu/IqeDPLzlQX4=;
 b=OnD3C+WGWcTah+cDAFAn6W+d2h2XFTtMtby9mVfFoCZ3FFXq1Of3th8JAVeGwu6S2iz1gxpEXi1PnJtPP4fuSQ6yfMBfWfUIR9CAqz2UWefcbKbBEgfqPDlBR/NvrgEs33HBNb2XW50XllKDEeBORcwUBJr1T0g6DXsXwDO0ITh4at4l6cJ7EWZdaNcXAbTr44omdHAp885Tvt4m3d/j7te8+qtBnJi+7Kin0pzcBV7U8tbeZnI7Dv+VERv1cms235afsZMMrc5A6WoVAye1vB0FHMKn3Oke2kJjamCOIci/zcFqD550VA1oit8i70BMh9B7ZH+fuZ0CjAzqY0yPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj/pveH5kPziUMCOxK05/YsFnLQbVdu/IqeDPLzlQX4=;
 b=e3EAQgK7pjEihbniQhb8tBbWap4rFzDyfJ+Jwkd8GZOz3LQ5SffdFgC2BWN2LQpkdc2tAC3Spb0Sv46wN30D09UG2QdOwdS+qnMT60TkGKxeehatXaLFJccHeoGnSvZrzaP1CJRyezwXioXOx/KCxqVUIP5P2nLMz6kZ0BBe/Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:52 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 9/9] PCI: endpoint: Add embedded DMA controller test
Date:   Thu, 21 Apr 2022 09:43:49 -0500
Message-Id: <20220421144349.690115-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd5d5ec-74fd-4d72-8b3f-08da23a57e93
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689B70AFD17FD63D3EDDAFB88F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfTkx+/B4HPP/TgJRQ2343wZUk8aqFZF6ySe+ojX5wTpp52q+jUN80h6BbRWaEdnUpVlW1mjo69cCjf5O9fhtTw8rNEjfXc1znorrArLYlTznoiydtFHCrH1vDu/Y6qbr5QM3gp58HEOm3/avIAajuZ7POJM5Hr4x2Ek5tRu2sfIu/HJ74sVxt+Sh/+6BvdvKjQvNmk+l1nztyyqyLrGQzrVuB/PtSA8sKpyFWseA5HLvQ2WoL3L0wTAeh6k/5WOlwAjdzSAopaLSM0DW18rzOi2yPiqGQE3LoZfKfWFc94/QTbWkKIXnpJpObCsE/KPL7kg/h7gbBzzCEuBsEc3t9Yn+Bz/YByuUxRf1FelEQ461+5Q3nJhcGS2bHrcR15eoWNZwPVkfFrPsqfwT2W/ll0YZNVWIYjG4RR+RtU0mX949ZixAFv2HOXhX3oiEHpM2PqkUg/KWjfsqQWoojR8cdbWVsvmcaNuEg94iVdi6EJAKNHVDvJNyvaSfH9cLxg/5F6Dz4f0YLWyuvwfUzMfL/qZngExkAF4uhPR3vdXZIxwWhq4atNA1tg7Y9gtnDRPHIbKauEc9eivkFQhNQromvJb3r6NIf6gLMMK0Zm5wJfFDSP2M73TW1pl2AIXqqqof4RhIB0MBRN+iLCV6gWXBQ8CwHhiqPF/ToHbQxRxf6FIbuMDjcKzRgrx0+fyqIObOEUsJjsLdjF8cLLLZTdgaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(186003)(86362001)(7416002)(2616005)(36756003)(5660300002)(1076003)(8936002)(2906002)(8676002)(26005)(66556008)(52116002)(6666004)(6512007)(508600001)(66946007)(66476007)(316002)(4326008)(83380400001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xo1Bld3A70QopxTQdiHZ1fifwgdcQDRDIhlUxEqr/OC0UkXG492wyg4qs+Zw?=
 =?us-ascii?Q?ohEEDgPyTrbt7QkGgS0BiohmfFggQ6oXjxAwzxztx4mam4X3ITQFdYACL0Fx?=
 =?us-ascii?Q?FJLELLjyNGmeEo20oI+4sTir+/p964LDgNlLCYWYBhx9Vws2CzQR5JzzeaNg?=
 =?us-ascii?Q?yKetXD8vTB/AHLiEHUL+DumAviReqFHctKJk9Gr+m4XIimZuT+WS7sf3Mtpw?=
 =?us-ascii?Q?sLlqtapAJ1EyV4DYhKYcRZniBOJcmSI3tj1saOAzHiG/2iCoN5ol5M24CdQp?=
 =?us-ascii?Q?f3IFERR4Ulm3tVQWTGvgMeFBlvdCgpJY7COGb/q3QfWYzSsI3t0q9FySrdOb?=
 =?us-ascii?Q?wHmvu8Y8ezmitYzM541qWXSR9/KrGKQA4J3RghYL1+oEOg5Lz62rNPsFrYmb?=
 =?us-ascii?Q?MyFQ9YaHvaJ9hoPtmhNW2i/FAMFTrPGDtmbK5NLe5gN2/1napdhhrlk2EGvP?=
 =?us-ascii?Q?WHpYhzG2iOUqhbcRAEcjI8hchdGFTHKL7G4Mup6TLeKDQZri3iPw2qsevIXv?=
 =?us-ascii?Q?p92WdqhZv7BBnS1/TETcuy0LDpMgXSKdzL+P0svyuPnLNXTDIJjkXbxfWmQ2?=
 =?us-ascii?Q?eqeiPsC83CgcfPBvVnTPcd6LHPZUwba2D+JDMMyGuOS4BCUYAKqOE5QVybX9?=
 =?us-ascii?Q?AdbEiA66klh57cZSd9sMf9L1zvW0u0MDVHEhiBsv5TVSqEsB4wXa+/mmpcHS?=
 =?us-ascii?Q?yBs9F0m+1FHrdJIFy0Yp1Kaa4/MbeLE69LAuvcGsdXgKnrw+/rIbP5JhuGe1?=
 =?us-ascii?Q?uFN0J6RQ2sQw/7lG0Cf4fiI8n3nNiorNE8yriKqN+ZlcGlBvSiziWQJTF0vw?=
 =?us-ascii?Q?N4o+hxdc48/7Cyr3FdUQtvgX67GMEj1fBQYy4Q2Cn4V4MRVpMmbnFRrkuemh?=
 =?us-ascii?Q?spkrGfnuZb3HntvD5vlp5vQY8dmyVENW4FWV0bPVhuoXCaUSGSw2sRHMQmSS?=
 =?us-ascii?Q?Exs5zKL1EaJuXPk4FSbuGomJhjzW7yv3c8GxzsscIArJMRAQ6gFcwA7o4fDO?=
 =?us-ascii?Q?k3KrYgmIlOV34VOgcFIqDEW/QOnkqWpb2XDpjaAK9l+LuYNk7lvNjJmTUF4r?=
 =?us-ascii?Q?kda4k4EG77vxS/Yc7LN+syfMxAlTqKfEvMcQfp5C66MtDDPP20Nh7W/xYTMf?=
 =?us-ascii?Q?buZe+hQCIKHCxvBTT2yW8UKSxpJ89aGzO8Mrocd6QPxYsAJy3SpLeWTZFDGh?=
 =?us-ascii?Q?yfCoqu/cx8DVvJVguoYGY/vtQkzbaYNAuJbntoG3FnB18fOzs1h+PHEBgfXi?=
 =?us-ascii?Q?MTm+b/DBXTdBV9BlZ8NrY6bHEO3gtdhHc8jZ94AwD9pvKm8xplMhr31YfOQY?=
 =?us-ascii?Q?8pYiFROqICFIytYmBUj/Gitw4yMeVxkAJhPfdpuu/Pt719KnqIwtOYSVkdlI?=
 =?us-ascii?Q?ALAG8Bqtou6tpsKALJvoVYyZBdzqa+OifCcDS7k4SpMcHQjN0ieVrwHCO+MV?=
 =?us-ascii?Q?oz1TtbdAspI/lNoZkWrVxAjWhatFPsj8B/Df1pYE1plyoPwrHTr7tL58jYiT?=
 =?us-ascii?Q?oyPGoa3rkm2ChmHz1PX73gjBOqWuokbhT1n/IE3gbApTF4NYABZw5qxdI6LU?=
 =?us-ascii?Q?nXt3XaGPg5CBRgdAP6LTWTEPIkIKgeigYxl2XfF2GFG4p6Cd/h2RIqDdFmxt?=
 =?us-ascii?Q?rcwG8sgi2PVB2N5yOF4RTfL2pN1/MX2ZWkJxuzsa3SyNzz84zmMzUGNzuF7i?=
 =?us-ascii?Q?Y9x5mmokwsGoJ8PEJYm3+O/moMM45f/976Wox0skqkVJphqz3+VZCMJ55Jc0?=
 =?us-ascii?Q?mqnpxZuh7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd5d5ec-74fd-4d72-8b3f-08da23a57e93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:52.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuvsnRRYldCey1jE/38Bzb6teMGWnSoJDuVZtyJ9/d07hRUP1rO9LQ254NyEGzKZDqdqp+RBu8bxUE5qYa2jjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Change from v6 to v8:
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

