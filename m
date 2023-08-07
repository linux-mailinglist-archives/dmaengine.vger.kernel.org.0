Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28A7719C9
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjHGF4N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHGFz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:55:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB091BF2;
        Sun,  6 Aug 2023 22:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQfCehiL8aG9QNigAXu3rTDSd5xZ4A32ZwsJRTO9wsAO2FDLydcHumZljPaof61UleJK3EHQojKli3ywclTOOvCmNGgccv+rOPhHOVrosKGFNhM05HTkgqpHAIBReJtYXUAwq5sxF49ryq5h4acAAjiPFxr5e6V+9cXoZ4+/T0lgmZQohV8Oe/BfZ284avvDFzZIhxussR4of51+Pf1NXythNvTqLh/2aKnISW/4TtqdOZEBImKghQDJ8CvOZz5n7WChvYlXTjry+7fMBlNhyEVdT/94N/UQ3iIeGxmbQohpWGg/KokXTKHGnFoR02/Xg+48au+ycf3+Hj6XJqSRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8NsdYxs4qSRxk/X29PUVeQbqGy5c9nrf6+pHBR/fe0=;
 b=PzLeMujmvHm/jo11MQy9EKtNlOIN9geTrrpN17DV5VLhLYv1j079cUbMEWn647x4wHcZWbkks/7Q5WPUtSvXuxegDaMy4L9fDvzo7KjjgdlFDPovT0pxfEJi97l9Lqfd5Uo8UEAvbWQ0Katmpuph1CVtHwTOugK20BxmGAPFtNgXw52NShn3a1YZio7WDKY09sHGHl1MlQ4Ae8WJWikl6OQnKOeuclpB8tk+CmeH/nZ0fkS7jubHUsf5tmkXrxq0rkiqqFmrHmrKzN88ZZTfKTirnoM51MYGA2wVDDt1mgBqa110SYCHPlLkjt1Zpk/aUsy8Y/QPQFUyE4P8iTFsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8NsdYxs4qSRxk/X29PUVeQbqGy5c9nrf6+pHBR/fe0=;
 b=a4MJqCLEDXUrJdlmy5AkNlO8Xv0LS7RRBTVc0Y9LvUfiaLzsJqHewoqk9RR30MdutFcBzFkLFM0ncrMNUrjPCNu6wHA0QOg9ErlimFlnruncXoDpUlN2O5IPrUJvcZNcoktQ2gkcH1JPaAgB/bTLJLK1W/iV+bdvAfg7iLOlTC0=
Received: from SA9PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:20::16)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:54:35 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::1b) by SA9PR03CA0011.outlook.office365.com
 (2603:10b6:806:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 05:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:54:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:54:04 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:53:59 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine support
Date:   Mon, 7 Aug 2023 11:21:49 +0530
Message-ID: <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c01516-c522-4d2a-5331-08db970ac78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liIYpu7+vQl27hKSexAbp7QzCPYAsyqUTIWgAdfwwmCYbzEiJDwKfFZVahjvaWGbF2kn35DGfqGip07gGcY6u3LLc/LGxfW1VtnBN3Vrr0fOkOqaluSSxoyROwjgVT+dK6I/rOnMAD9NQz4GYfOeEHSga6I82qKCD6svaSEX12OxXlYZu2UQhiEbZkToa9QpGXpwX8NCPN6P8q/DgvAlHzeRy4v/XZc3IStbTaeFS2exnqzdeCS278pVjoHzmfxk9CJa+xMJeit6A123Yp9oJtP5f29AFixOBHlgNU752BYqYeP9LwBiBHyjZpkDlZRrdyj5K9YL/L76EmAu3D+dTNoeaX1XBzY9GeGQx+A7KgGYozM6icFwZAIQ3UYlCZkg8nMmBXF5Mhug5s+zKtJN63SHLJIc/eaM5KhzlE//CJyiArtYSa27Jd3atPQAF5VEjOuseAADjtG9JQ/dwPeAkOiYUFUkWY47dnD7wDAucRKkgeIC71QssF/INMv6RABo61GQ0cqgajNlggJPOzGx1+iYh/WNeImaujkFDfm/zXptkqxjN6w3CVfMTmpJ0WzaCV4leYJfG0640DBC/mvHQazKUINlQ5o+0giJA9Bb9b5Mgwvfgi6UPoJ86FxE4Jn7iG+IpJBBr8ThifYr2Gxjl9/Zs4Oe1QmxCRahFdwZYOo4+dAUQFgtrLNiipS2fnx4D2Ecez6ZY0SqSRmFfPapez7THp2qoIl+MLW/mVkbAIak8gBT0drwQnSsVgK2/TPR75i9t2z/qPxBe1ZWQxZUo5QgD3kMOb5dyPH+QvMAEo4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(82310400008)(186006)(1800799003)(36840700001)(40470700004)(46966006)(6666004)(30864003)(54906003)(478600001)(110136005)(40460700003)(316002)(4326008)(40480700001)(86362001)(81166007)(921005)(41300700001)(356005)(82740400003)(70206006)(70586007)(47076005)(83380400001)(426003)(26005)(2616005)(7416002)(36860700001)(36756003)(2906002)(336012)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:54:35.5958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c01516-c522-4d2a-5331-08db970ac78f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dmaengine framework to communicate with the xilinx DMAengine
driver(AXIDMA).

Axi ethernet driver uses separate channels for transmit and receive.
Add support for these channels to handle TX and RX with skb and
appropriate callbacks. Also add axi ethernet core interrupt for
dmaengine framework support.

The dmaengine framework was extended for metadata API support.
However it still needs further enhancements to make it well suited for
ethernet usecases. The ethernet features i.e ethtool set/get of DMA IP
properties, ndo_poll_controller,(mentioned in TODO) are not supported
and it requires follow-up discussions.

dmaengine support has a dependency on xilinx_dma as it uses
xilinx_vdma_channel_set_config() API to reset the DMA IP
which internally reset MAC prior to accessing MDIO.

Benchmark with netperf:

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t TCP_STREAM
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072  16384  16384    10.03     915.55

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t UDP_STREAM
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992   65507   10.00       18192      0     953.35
212992           10.00       18192            953.35

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- Switch to amd.com email
- Modified commit description. Remove lore link, mention reset API,
  add performance numbers.
- Fix kmem_cache resource leak on stop.
- Use dmaengine_terminate_sync instead of deprecated
  dmaengine_terminate_all API.

Changes for v4:
- Remove the AXIENET_USE_DMA.
- Add dev_err_probe for dma_request_chan error handling.
- Add kmem_cache_destroy for create in axienet_setup_dma_chan.
- Add XILINX_DMA dependency in ethernet drier Kconfig file.
- move setup_dma_channel to init_dmaengine func
- Remove unlikely
	if (unlikely(ret < 0))
- if (ret == 0) to if (!ret)
- Rename DMA_MEM_TO_DEV to DMA_TO_DEVICE
- Remove else check for lp->use_dmaengine = 1; in the probe.

Changes in V3:
- New patch for dmaengine framework support.
---
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   8 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 321 +++++++++++++++++-
 3 files changed, 328 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 0014729b8865..35d96c633a33 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -26,6 +26,7 @@ config XILINX_EMACLITE
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
+	depends on XILINX_DMA
 	select PHYLINK
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 3ead0bac597b..d8c6d0afa8a3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -436,6 +436,10 @@ struct axidma_bd {
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
+ * @tx_chan:	TX DMA channel.
+ * @rx_chan:	RX DMA channel.
+ * @skb_cache:	Custom skb slab allocator
+ * @rx_chan_skb: List to store RX descriptors custom SKB pointer
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -501,6 +505,10 @@ struct axienet_local {
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
+	struct dma_chan *tx_chan;
+	struct dma_chan *rx_chan;
+	struct kmem_cache *skb_cache;
+	struct list_head rx_chan_skb;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 36c77248a55e..1de5c4992ecf 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -37,6 +37,9 @@
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/xilinx_dma.h>
 
 #include "xilinx_axienet.h"
 
@@ -46,6 +49,9 @@
 #define TX_BD_NUM_MIN			(MAX_SKB_FRAGS + 1)
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
+#define DMA_NUM_APP_WORDS		5
+#define LEN_APP				4
+#define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
 #define DRIVER_NAME		"xaxienet"
@@ -54,6 +60,17 @@
 
 #define AXIENET_REGS_N		40
 
+struct axi_skbuff {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	struct list_head lh;
+	int sg_len;
+} __packed;
+
+static int axienet_rx_submit_desc(struct net_device *ndev);
+
 /* Match table for of_platform binding */
 static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", },
@@ -726,6 +743,108 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
 	return 0;
 }
 
+/**
+ * axienet_dma_tx_cb - DMA engine callback for TX channel.
+ * @data:       Pointer to the axi_skbuff structure
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for TX channel to notify
+ * that the transmit is done.
+ */
+static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axi_skbuff *axi_skb = data;
+
+	struct net_device *netdev = axi_skb->skb->dev;
+	struct axienet_local *lp = netdev_priv(netdev);
+
+	u64_stats_update_begin(&lp->tx_stat_sync);
+	u64_stats_add(&lp->tx_bytes, axi_skb->skb->len);
+	u64_stats_add(&lp->tx_packets, 1);
+	u64_stats_update_end(&lp->tx_stat_sync);
+
+	dma_unmap_sg(lp->dev, axi_skb->sgl, axi_skb->sg_len, DMA_TO_DEVICE);
+	dev_kfree_skb_any(axi_skb->skb);
+	kmem_cache_free(lp->skb_cache, axi_skb);
+}
+
+/**
+ * axienet_start_xmit_dmaengine - Starts the transmission.
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK, on success
+ *          NETDEV_TX_BUSY, if any memory failure or SG error.
+ *
+ * This function is invoked from xmit to initiate transmission. The
+ * function sets the skbs , call back API, SG etc.
+ * Additionally if checksum offloading is supported,
+ * it populates AXI Stream Control fields with appropriate values.
+ */
+static netdev_tx_t
+axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 app[DMA_NUM_APP_WORDS] = {0};
+	struct axi_skbuff *axi_skb;
+	u32 csum_start_off;
+	u32 csum_index_off;
+	int sg_len;
+	int ret;
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	axi_skb = kmem_cache_zalloc(lp->skb_cache, GFP_KERNEL);
+	if (!axi_skb)
+		return NETDEV_TX_BUSY;
+
+	sg_init_table(axi_skb->sgl, sg_len);
+	ret = skb_to_sgvec(skb, axi_skb->sgl, 0, skb->len);
+	if (ret < 0)
+		goto xmit_error_skb_sgvec;
+
+	ret = dma_map_sg(lp->dev, axi_skb->sgl, sg_len, DMA_TO_DEVICE);
+	if (!ret)
+		goto xmit_error_skb_sgvec;
+
+	/*Fill up app fields for checksum */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
+			/* Tx Full Checksum Offload Enabled */
+			app[0] |= 2;
+		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+			csum_start_off = skb_transport_offset(skb);
+			csum_index_off = csum_start_off + skb->csum_offset;
+			/* Tx Partial Checksum Offload Enabled */
+			app[0] |= 1;
+			app[1] = (csum_start_off << 16) | csum_index_off;
+		}
+	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		app[0] |= 2; /* Tx Full Checksum Offload Enabled */
+	}
+
+	dma_tx_desc = lp->tx_chan->device->device_prep_slave_sg(lp->tx_chan, axi_skb->sgl,
+			sg_len, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT, (void *)app);
+
+	if (!dma_tx_desc)
+		goto xmit_error_prep;
+
+	axi_skb->skb = skb;
+	axi_skb->sg_len = sg_len;
+	dma_tx_desc->callback_param =  axi_skb;
+	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(lp->tx_chan);
+
+	return NETDEV_TX_OK;
+
+xmit_error_prep:
+	dma_unmap_sg(lp->dev, axi_skb->sgl, sg_len, DMA_TO_DEVICE);
+xmit_error_skb_sgvec:
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	return NETDEV_TX_BUSY;
+}
+
 /**
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
@@ -910,7 +1029,43 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (!lp->use_dmaengine)
 		return axienet_start_xmit_legacy(skb, ndev);
 	else
-		return NETDEV_TX_BUSY;
+		return axienet_start_xmit_dmaengine(skb, ndev);
+}
+
+/**
+ * axienet_dma_rx_cb - DMA engine callback for RX channel.
+ * @data:       Pointer to the axi_skbuff structure
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for RX channel to notify
+ * that the packet is received.
+ */
+static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axi_skbuff *axi_skb = data;
+	struct sk_buff *skb = axi_skb->skb;
+	struct net_device *netdev = skb->dev;
+	struct axienet_local *lp = netdev_priv(netdev);
+	size_t meta_len, meta_max_len, rx_len;
+	u32 *app;
+
+	app  = dmaengine_desc_get_metadata_ptr(axi_skb->desc, &meta_len, &meta_max_len);
+	dma_unmap_single(lp->dev, axi_skb->dma_address, lp->max_frm_size,
+			 DMA_FROM_DEVICE);
+	/* TODO: Derive app word index programmatically */
+	rx_len = (app[LEN_APP] & 0xFFFF);
+	skb_put(skb, rx_len);
+	skb->protocol = eth_type_trans(skb, netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	netif_rx(skb);
+	list_del(&axi_skb->lh);
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	u64_stats_update_begin(&lp->rx_stat_sync);
+	u64_stats_add(&lp->rx_packets, 1);
+	u64_stats_add(&lp->rx_bytes, rx_len);
+	u64_stats_update_end(&lp->rx_stat_sync);
+	axienet_rx_submit_desc(netdev);
+	dma_async_issue_pending(lp->rx_chan);
 }
 
 /**
@@ -1146,6 +1301,112 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 
 static void axienet_dma_err_handler(struct work_struct *work);
 
+/**
+ * axienet_rx_submit_desc - Submit the descriptors with required data
+ * like call backup API, skb buffer.. etc to dmaengine.
+ *
+ * @ndev:	net_device pointer
+ *
+ *Return: 0, on success.
+ *          non-zero error value on failure
+ */
+static int axienet_rx_submit_desc(struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct axi_skbuff *axi_skb;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+	int ret;
+
+	axi_skb = kmem_cache_alloc(lp->skb_cache, GFP_KERNEL);
+
+	if (!axi_skb)
+		return -ENOMEM;
+	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto rx_bd_init_skb;
+	}
+
+	sg_init_table(axi_skb->sgl, 1);
+	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);
+	sg_dma_address(axi_skb->sgl) = addr;
+	sg_dma_len(axi_skb->sgl) = lp->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(lp->rx_chan, axi_skb->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc) {
+		ret = -EINVAL;
+		goto rx_bd_init_prep_sg;
+	}
+
+	axi_skb->skb = skb;
+	axi_skb->dma_address = sg_dma_address(axi_skb->sgl);
+	axi_skb->desc = dma_rx_desc;
+	dma_rx_desc->callback_param =  axi_skb;
+	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	list_add_tail(&axi_skb->lh, &lp->rx_chan_skb);
+	dmaengine_submit(dma_rx_desc);
+
+	return 0;
+
+rx_bd_init_prep_sg:
+	dma_unmap_single(lp->dev, addr, lp->max_frm_size, DMA_FROM_DEVICE);
+	dev_kfree_skb(skb);
+rx_bd_init_skb:
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	return ret;
+}
+
+/**
+ * axienet_init_dmaengine - init the dmaengine code.
+ * @ndev:       Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *          non-zero error value on failure
+ *
+ * This is the dmaengine initialization code.
+ */
+static inline int axienet_init_dmaengine(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	int i, ret;
+
+	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+	if (IS_ERR(lp->tx_chan)) {
+		ret = PTR_ERR(lp->tx_chan);
+		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+	}
+
+	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
+	if (IS_ERR(lp->rx_chan)) {
+		ret = PTR_ERR(lp->rx_chan);
+		dev_err_probe(lp->dev, ret, "No Ethernet DMA (RX) channel found\n");
+		goto err_dma_request_rx;
+	}
+
+	lp->skb_cache = kmem_cache_create("ethernet", sizeof(struct axi_skbuff),
+					  0, 0, NULL);
+	if (!lp->skb_cache) {
+		ret =  -ENOMEM;
+		goto err_kmem;
+	}
+
+	INIT_LIST_HEAD(&lp->rx_chan_skb);
+	/* TODO: Instead of BD_NUM_DEFAULT use runtime support*/
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		axienet_rx_submit_desc(ndev);
+	dma_async_issue_pending(lp->rx_chan);
+
+	return 0;
+err_kmem:
+	dma_release_channel(lp->rx_chan);
+err_dma_request_rx:
+	dma_release_channel(lp->tx_chan);
+	return ret;
+}
+
 /**
  * axienet_init_legacy_dma - init the dma legacy code.
  * @ndev:       Pointer to net_device structure
@@ -1237,7 +1498,24 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
-	if (!lp->use_dmaengine) {
+	if (lp->use_dmaengine) {
+		/* Enable interrupts for Axi Ethernet core (if defined) */
+		if (lp->eth_irq > 0) {
+			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
+					  ndev->name, ndev);
+			if (ret)
+				goto error_code;
+		}
+
+		ret = axienet_init_dmaengine(ndev);
+
+		if (ret < 0) {
+			if (lp->eth_irq > 0)
+				free_irq(lp->eth_irq, ndev);
+			goto error_code;
+		}
+
+	} else {
 		ret = axienet_init_legacy_dma(ndev);
 		if (ret)
 			goto error_code;
@@ -1265,6 +1543,7 @@ static int axienet_open(struct net_device *ndev)
 static int axienet_stop(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	struct axi_skbuff *askb, *skb;
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
@@ -1285,6 +1564,19 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->tx_irq, ndev);
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
+	} else {
+		dmaengine_terminate_sync(lp->tx_chan);
+		dmaengine_synchronize(lp->tx_chan);
+		dmaengine_terminate_sync(lp->rx_chan);
+		dmaengine_synchronize(lp->rx_chan);
+
+		list_for_each_entry_safe(askb, skb, &lp->rx_chan_skb, lh) {
+			list_del(&askb->lh);
+			kmem_cache_free(lp->skb_cache, askb);
+		}
+		dma_release_channel(lp->rx_chan);
+		dma_release_channel(lp->tx_chan);
+		kmem_cache_destroy(lp->skb_cache);
 	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
@@ -2140,6 +2432,31 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
+	} else {
+		struct xilinx_vdma_config cfg;
+		struct dma_chan *tx_chan;
+
+		lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+
+		if (IS_ERR(tx_chan)) {
+			ret = PTR_ERR(tx_chan);
+			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+			goto cleanup_clk;
+		}
+
+		cfg.reset = 1;
+		/* As name says VDMA but it has support for DMA channel reset*/
+		ret = xilinx_vdma_channel_set_config(tx_chan, &cfg);
+
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Reset channel failed\n");
+			dma_release_channel(tx_chan);
+			goto cleanup_clk;
+		}
+
+		dma_release_channel(tx_chan);
+		lp->use_dmaengine = 1;
 	}
 
 	/* Check for Ethernet core IRQ (optional) */
-- 
2.34.1

