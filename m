Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201F532D56
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiEXPXO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiEXPXG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D35715F;
        Tue, 24 May 2022 08:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKfep7JPscO0r/TfazBzLOajZ0X8bAd9Q6IEV5wWqN6jIwijsGYVNgY61SUk+ATrknhLbeamBXZfdYl1Lx6r5AAhfTb0xaYy7sGc7+FAVBsyNGUeTpLyTdu1dXfwnJtqiHXp3HEj6/qRtjBl7Hg99hs8HM6co7PAjxpa93f03jdBe46O3p7yke8jPhOZAXxqX9U4xMMvGe7fj9NLK8tclxkYUTY35PuJ/JoSVBi0hGCJq+RUgkWNjYhyB2d1n0t46TV1t8MlTfLl1zZDKXIoq0uQQPzcM8xLp2IC6wYXxyJD/p5Llp1zspR+2IIvadct/lAuvk5R/4afVZMF5nnD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUl4xK3MiOMAFiJxrMmhTFnUxSXfq0wb8AMP9oRxT+Q=;
 b=bP0zvuDSvcvO6X/IWda8xPmzn7XQt8UNdZz3HIedRzLygZSjgm3bHiMUzOPiSDzmAA9EbIwnHO4Kuj/oWar0Dk0vraiBe8ErkbJk6gupi3WgDpTQdVZl/NiVsIhLiCxX/Bp7pb/CAxr3gtVv/gRGZyZm7Tx5OkqIyPxm8jpalUHtK5qeHoJX6+HcT94euMlvX+luoCCCzRfMN5W5tBSgisqbVk1z1pphiQmuiC+e4fGp1YT4C3h/xKRbP4ZrEDp9nXCe82xZ6k6jAaQf+LQlwS9eMAj+femnxU/DL+kQfmpTzKz4oTrw6er6e/02ayP8GphxNN4OLbcjiesH52tn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUl4xK3MiOMAFiJxrMmhTFnUxSXfq0wb8AMP9oRxT+Q=;
 b=poN/luJb5ZsEBoiWY0IzRJqSBqECYSC0bw8zAO4Ayaz3QO/pi1KS2MIWEi9pxyBxz9IJY+PEsdOSLgYIyNlQ29VkkGx3TJyPT7c1v0J84QkcKyRZ3BJ2bpfuAOfdQHIpIP3CsaSVzQqWinCNoXmkmHf3iDrfykJZkZrFwSiWHEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:52 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 8/8] PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
Date:   Tue, 24 May 2022 10:21:59 -0500
Message-Id: <20220524152159.2370739-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3243030c-d5e5-4dcd-690a-08da3d9944d2
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5672D6CB7C87ED18B4BD8D4F88D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBYQejlq2yWqbYN/qzOmn10JNGE+kjZfOpOMy5HwBhsBzI5Llr5mkCIVSP4j5+xbKxVPsHCOWzDj1MrX2ihuqz7UjH5vMzoQPDMbG8DeX4WcOZRVSGux7/9c0DI363+pCocz8DphcIjtwk6cK6yjHyrtL0N8adHi8EuMdqfzdzJa4a1u4TSqlOML8hgArwYy8SLqdPOV4gZXqlK23LYeFFeNW2c1uUaaDyTkfjJARH6xOryAUVcTrECpO/jd1Q9dMZaEQwTdZEyn4B0UepwzpSr9+8KZ+RnZdq4La+N/ruWZDTwM1w1J6pTAdLjH2WWofXY91uCAneVHmM6f12sq0OdKr72MynNWax6ZuDHRVFSEhn8orf6Z7tprZUd3WZLQDsehh0qgZEJPW2jf1jXg3tdfWmVMzWTZ8EpquxdjhuAwvJgZ0Aaq9Puax3tzQ9vqSA9Id/DD9dbZphsJSIg/wvAc7EdZIIyaziNIF1Kpxz1/7NTwXxBkFaYBePMpB/Ap4xViDuuCJ1KI//qCr9CULEGNBlWI+fV07SDyDUVNgn6Mp5XkoatM1oBPaY+fQddtBk4a3H+Gm23k+DY09kYrXbRhD9QS3C9F6s72ROM8Usinxp1w5OcWZ9cSINfMA58amYnWQT8tHLJ3Lcmz6GAhZBSOjqzJws/PiMY81wjuyxVLr533BUHK5HnkzoVdj7fP/8KHXkR8yoJVAjuiESovIDYJ8Ix8lGb9XExIIU1aNKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(1076003)(921005)(36756003)(83380400001)(2616005)(52116002)(26005)(66946007)(66556008)(6486002)(7416002)(86362001)(66476007)(8676002)(38350700002)(6506007)(316002)(38100700002)(4326008)(5660300002)(186003)(508600001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UInq8I1/cJgk6659hDDms6UONwi7FIs5Jjd1eKYAJKHXREoZ9LOD0kjXiQMg?=
 =?us-ascii?Q?kOk2NUKuPa5uKTbQ5OuEy8hq4poDkv3Bnl395x6ODi3Rn4ah3k4Dy1BPaSmU?=
 =?us-ascii?Q?UPX8c8xGlYYWCsuuP97ojM1uI2nW3MEXExxgfKYmeITIMXJuADcYjoTFXTJ9?=
 =?us-ascii?Q?zVmbDX56vMX4vqmivItCN16kxKSxO31OTCv4i0VX+1FOn8+ZrQTtw9zyYg31?=
 =?us-ascii?Q?ftd7dBDuQWC4xPn1iigwD2vmBo4zGxuU6mnnkFklbnxbaW+ZnxhW0rH6xEtP?=
 =?us-ascii?Q?WeHiWa6IO2y/nANl/thEWnKO/dbA7w/z0iE8lQQcQya6fiuNjyOOWlgjuc26?=
 =?us-ascii?Q?GtOfvLQ8G6ibUnEzglPGz/zH4GB+G5GDVnq6nJqrNW6FQNDB+JoG4FCbvMI2?=
 =?us-ascii?Q?g6jHViGyHiO+4e128A9I4gXJ57RDqIe3CZ5eWL20tHSnp/Dmd5oge6lRNwc2?=
 =?us-ascii?Q?rLQBjH9JhVGLvux+LjlmiCfqX5+txtDfHuSj5cMOtFZNgaZbGaTOyb6SLjBO?=
 =?us-ascii?Q?NVxnEIJmcJpFPHE/jhHVyH1tK/blxbEZBTUpUnfc2zWU4e4aRCpjdU9LwVwd?=
 =?us-ascii?Q?h7L/FdDVk8PtuQQWc8hK1MtaDCXFeeG5z9lRZbtqCk7rCBvxUwzV8mzrxBdJ?=
 =?us-ascii?Q?8X4I/dGwLhIDGit91D/XaQtu71d7DkB+dyJBLv/xCToo6CiOgKlQ2Vo1PGVZ?=
 =?us-ascii?Q?OddsP02bIuWsUFHNnd88dO9l0RgUSDIcrvr9XMnRWO4OGaccl09WBTxoYYMh?=
 =?us-ascii?Q?YYGgP/RW4i7AcdmGRXp5Z0F9L30ujm0aiTqgi8X1a21uLkO2HbEPK6sl7fEf?=
 =?us-ascii?Q?HkLGFD1rzrnIrHOl8/yxYvFINkUz64NSjvdhud2c+t/IX/FW/wM0xyrn2A7I?=
 =?us-ascii?Q?VWlLD67lPxws6/tyAeRkRwTCGMpbUF+21Go0urElag13/1GjnEhX8J2cdt5W?=
 =?us-ascii?Q?lPPLxU+PLZzOPbM95aF/jyZXDzDSrTlSjnHofVV5UuCW3jw787HsVXclDK2/?=
 =?us-ascii?Q?R8vs+98KlK+MMuF6zpIY/SO93C6+QWcvsk6tkn+MXOvzT53v9+uSkd5LCALa?=
 =?us-ascii?Q?N3bGlppogIGtt1fJoNsQ0p2c/zeyy4noUQ/UffJ3ce8xvjxuNFXQMUkVhEUs?=
 =?us-ascii?Q?BHNJdtFnsu7nvoNLHd2VNaSDaKyK7AoRMWlH3c7uFv+uaLD67Qk1ZxQZg5Et?=
 =?us-ascii?Q?rw+sbm3qpxbseFKDMATGnps0ZgIi1zkjeMVzI1eNiUbP74+vP5L8fkPz+uqE?=
 =?us-ascii?Q?44iY77pfW/oseNtbrtgWN6Z9XNPcmYQT9kSJA1Ce7VuN4H3jrgz7FpxBUyLo?=
 =?us-ascii?Q?KdCtlmHB/7zgiWjwUVH9CnshRXh7cNazKoSnWphPw29j1xhPizAmRQ+Qq7Uk?=
 =?us-ascii?Q?G47oIvDefPBgV70Xnh27rL3bmi2+23X1oh8IHGQYyNsBbH0EFl7IogB4516o?=
 =?us-ascii?Q?3/m38rxnh4LoL13zmZRtsAT5bQfPDd+XaZ3MF14PiuEtjEyuJB/RWpYdiVQ/?=
 =?us-ascii?Q?BRQgZHBhaWl8UKclucfspeR1aj3n2dHyuQw2WOic/TNm8BNJf47gzRGHLRqu?=
 =?us-ascii?Q?KtPJQF8VN4NlLIaDIvxI6yAv/pb6skDVL4cPPsN2ZAmrfNpwNMjxgJbSQL0/?=
 =?us-ascii?Q?qij8RBuUk+vzpz5MABSE1pdaXmpqH85RcUCByFDfM/DQu+gjWD92U0Bwyep6?=
 =?us-ascii?Q?3O1vvyYsGiskE8udABBoRVBs4lo78WJXiNpKhdPfo9jfvrbhDfL07Q+KlNU3?=
 =?us-ascii?Q?o2GSGflyvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3243030c-d5e5-4dcd-690a-08da3d9944d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:52.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvWFaaT5P5HPAMUdFqRrollIDFL9OAJK2aCL2rNJfbhQOgTtV9TuXIUeDlnpR6kZ7bBggg7GeLsfluybrCNFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some PCI Endpoint controllers integrate an eDMA (embedded DMA).
eDMA can bypass the outbound memory address translation unit to
access all RC memory space.

Add eDMA support for pci-epf-test.

Depending on HW availability, the EPF test can use either eDMA or
general system DMA controllers to perform DMA. The test tries to use
eDMA first and falls back to general system DMA controllers if
there's no eDMA

Separate dma_chan to dma_chan_tx and dma_chan_rx. Search for an eDMA
channel first, then search for a memory-to-memory DMA channel.
If general memory to memory channels are used, dma_chan_rx = dma_chan_tx.

Add dma_addr_t dma_remote in pci_epf_test_data_transfer()
because eDMA uses remote RC physical address directly.

Add enum dma_transfer_direction dir in pci_epf_test_data_transfer()
because eDMA chooses the correct RX/TX channel by dir.

The overall steps are

1. Execute dma_request_channel() and filter function to find correct
eDMA RX and TX Channel. If a channel does not exist, fallback to try to
allocate general memory to memory DMA channel.
2. Execute dmaengine_slave_config() to configure remote side physical
address.
3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
4. Execute tx_submit().
5. Execute dma_async_issue_pending()

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change from v11 to v12:
 - remrite commit message
 - wrap code to 80 line
 - difference error message when apply tx/rx channel
Change from v10 to v11:
 - rewrite commit message
Change from v9 to v10:
 - rewrite commit message
Change from v4 to v9:
 - none
Change from v3 to v4:
 - reverse Xmas tree order
 - local -> dma_local
 - change error message
 - IS_ERR -> IS_ERR_OR_NULL
 - check return value of dmaengine_slave_config()
Change from v1 to v2:
 - none

 drivers/pci/endpoint/functions/pci-epf-test.c | 113 ++++++++++++++++--
 1 file changed, 103 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868f..f232dd8eb19f0 100644
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
 
@@ -96,6 +98,8 @@ static void pci_epf_test_dma_callback(void *param)
  * @dma_src: The source address of the data transfer. It can be a physical
  *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
  * @len: The size of the data transfer
+ * @dma_remote: remote RC physical address
+ * @dir: DMA transfer direction
  *
  * Function that uses dmaengine API to transfer data between PCIe EP and remote
  * PCIe RC. The source and destination address can be a physical address given
@@ -105,12 +109,16 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      size_t len, dma_addr_t dma_remote,
+				      enum dma_transfer_direction dir)
 {
+	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ?
+				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
+	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-	struct dma_chan *chan = epf_test->dma_chan;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
 	int ret;
@@ -120,7 +128,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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
@@ -148,6 +171,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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
@@ -158,10 +198,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
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
+		dev_info(dev, "Failed to get private DMA rx channel. Falling back to generic one\n");
+		goto fail_back_tx;
+	}
+
+	epf_test->dma_chan_rx = dma_chan;
+
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failed to get private DMA tx channel. Falling back to generic one\n");
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
 
@@ -174,7 +248,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	}
 	init_completion(&epf_test->transfer_complete);
 
-	epf_test->dma_chan = dma_chan;
+	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
 
 	return 0;
 }
@@ -190,8 +264,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
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
@@ -280,8 +363,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
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
@@ -363,7 +452,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 phys_addr, reg->size,
+						 reg->src_addr, DMA_DEV_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
@@ -453,8 +543,11 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
+
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size,
+						 reg->dst_addr,
+						 DMA_MEM_TO_DEV);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
-- 
2.35.1

