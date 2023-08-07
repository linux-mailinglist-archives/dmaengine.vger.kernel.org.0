Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BDA7719C3
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjHGFzw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHGFzu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:55:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9691989;
        Sun,  6 Aug 2023 22:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpKmaxjXVd5oWiYZoI11INMjDulGzT77La/6fEovf4nlfM9xYVnFFa+SzCU5ns2RLWgAJzEDzPXBrsZ/Jc/S8bmVA5chXdXbALm/ptkhrTvvHOtuHJ/E+n+QUf9GaRrv5X3eU6GzaKvdWLEl0NNQx/oTxl5jb/smTEEO38dM7eTALjnSUoir3DpRAA+jTs5HNthOF2GqdGkJ6XXGm58intWPNfU+p/TOLS43qIY6OjCTMMciPSZGIU8TWppw91wGUNPIEmj2gByqdMO+0BAJ5CEKDQRlHEwm/Ekgp1AT5tjWXzl3whkrS44UcGoRzTNSx1GxR/hhJ0tkXdk4+okJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5lz0i39971gVN1YorGg6V56PQdFkzyeERx2LnSVCH4=;
 b=k9AjKe7rI0dHRARcl65hI8obiuokpTErN8JVRdD2ZuUGdNi+XRRVkGac+uYmwI1VtfFB2Axo/2nAAx5u4BSUWPGhDocjlHyeXU3rEVFVx2mzJwbs+U4sf+mkDneQY/gvntym+Jdl1jT/Bq1qkbnR2dyTBcueqtqUAEKfGvVrQS5n9kESsuCCSMD9d8tu/xJYC3pZRSYWd6hTQWH77lX4irGhOzv4J+XBqFut3OCxhuQQYOmsMrYlz1ZjneMDIFCmRBRlD6hGc08C/BLxRBtk/dPG3/SvaUnJigHdJ+tAki6EB0y6df+T9T/f3Gs9fZH0gSAV7jCdYngdzOA7R61ggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5lz0i39971gVN1YorGg6V56PQdFkzyeERx2LnSVCH4=;
 b=lOOViVwFMScD3JX9enf/P2j7TGArWvw/22tK+dJZRLnxW8oSBd7TJ2hAqHglTwTkmDgqmUvd6lbXo8qE7kMuTWx79DjOOm5ankJlbNFwkSO5muRH9V23gj6oqALjsrzqCM+gz2D1okPZbz5B5wy1SQZpUiY7FG6BRt5NTbN639Q=
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:54:05 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::ca) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 05:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 05:54:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:53:59 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:53:39 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>,
        Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 09/10] net: axienet: Preparatory changes for dmaengine support
Date:   Mon, 7 Aug 2023 11:21:48 +0530
Message-ID: <1691387509-2113129-10-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 43845fcf-756c-4a3e-de1e-08db970ab737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsuv0rdP86pRvFIqXiZob5EsOq6isF2zskIPHErARc/HrRE0K05bKPdRCVIVDyPKB5Qs/A8fdjR/1g1nzE/XYhMsjn8bwvWvwot4s+zsszAI420MNf/2BdWmr4sg9zuPDs2b9biL1Mt2A+5dGx7BTktbDBwGKJj1ikGKO0kDToNCi+KCSgTQO9/1iLpeFcpMvIxPlUqnM+2oviHvIqIriEclySMmy1qDfHhz2Ei3m9zyTJeVPjBdQ/YrVXfvAV8okcDMdZlwXxzMlG74hEoV9Mc/hntPxSbMjwnQ0TZI+Ym7R41hIKQS5PYbgNuMX1rxF30GF9wUOaW/Cn9MgOJ6iKPSgUjOSnPGx3mif4c1axEfVu7VYAKF4S5IpXiC8rlNUaqQql6iy4gQjaOp3pRSL/lIQi0Nq1slDiFcYZXFU/2VFxea8Hsn6AlaAaHLvPmDkH9m1rGs3qFW/9+oHF3T++j5vQh1FL0MKm7oa2xkdMX9926yBEEL5mo2kzejyXCwf9KCNxMDe1yja4ZxZCWkbweTjPQoZpUyd+KpLyAoesogTpH+QgfJia6vz8gxbl8/H9oGtrLXD1P030csmVdak2u/GwMLNQwLiqz0ig0/DkHBlGcvRqJ5XPAUd/hLxOdRdwNmnWgG4X8cehnt16Isf9g49dwgLBF//WyJ+LHBOLlKrBiHiVy5Ks6X6Z7hm21kcR4Ag2qOHHcSYOvis7q46WsqznfbMlVUJUiPfprwvZi8g6Qa8F6GBzDmGR4IG6bP4A5Hshi8VfSj230YbwadYbMZzXTBzpWjd/wadFnHqRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(186006)(1800799003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(47076005)(4326008)(2906002)(70206006)(70586007)(336012)(6666004)(83380400001)(5660300002)(36860700001)(7416002)(41300700001)(8936002)(316002)(8676002)(30864003)(40480700001)(81166007)(921005)(356005)(2616005)(54906003)(110136005)(426003)(478600001)(82740400003)(36756003)(26005)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:54:08.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43845fcf-756c-4a3e-de1e-08db970ab737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>

The axiethernet driver has inbuilt dma programming. In order to add
dmaengine support and make it's integration seamless the current axidma
inbuilt programming code is put under use_dmaengine check.

It also performs minor code reordering to minimize conditional
use_dmaengine checks and there is no functional change. It uses
"dmas" property to identify whether it should use a dmaengine
framework or inbuilt axidma programming.

Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- Fix git apply failure due to commit
  f1bc9fc4a06de0108e0dca2a9a7e99ba1fc632f9

Changes for v4:
- Renamed has_dmas to use_dmaegine.
- Removed the AXIENET_USE_DMA.
- Changed the start_xmit_** functions description.

Changes for v3:
- New patch
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   2 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 313 +++++++++++-------
 2 files changed, 188 insertions(+), 127 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 575ff9de8985..3ead0bac597b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -435,6 +435,7 @@ struct axidma_bd {
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
+ * @use_dmaengine: flag to check dmaengine framework usage.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -499,6 +500,7 @@ struct axienet_local {
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
+	u8  use_dmaengine;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 8e32dc50a408..36c77248a55e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -588,10 +588,6 @@ static int axienet_device_reset(struct net_device *ndev)
 	struct axienet_local *lp = netdev_priv(ndev);
 	int ret;
 
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		return ret;
-
 	lp->max_frm_size = XAE_MAX_VLAN_FRAME_SIZE;
 	lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
@@ -605,11 +601,17 @@ static int axienet_device_reset(struct net_device *ndev)
 			lp->options |= XAE_OPTION_JUMBO;
 	}
 
-	ret = axienet_dma_bd_init(ndev);
-	if (ret) {
-		netdev_err(ndev, "%s: descriptor allocation failed\n",
-			   __func__);
-		return ret;
+	if (!lp->use_dmaengine) {
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			return ret;
+
+		ret = axienet_dma_bd_init(ndev);
+		if (ret) {
+			netdev_err(ndev, "%s: descriptor allocation failed\n",
+				   __func__);
+			return ret;
+		}
 	}
 
 	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
@@ -775,20 +777,20 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 }
 
 /**
- * axienet_start_xmit - Starts the transmission.
+ * axienet_start_xmit_legacy - Starts the transmission.
  * @skb:	sk_buff pointer that contains data to be Txed.
  * @ndev:	Pointer to net_device structure.
  *
  * Return: NETDEV_TX_OK, on success
  *	    NETDEV_TX_BUSY, if any of the descriptors are not free
  *
- * This function is invoked from upper layers to initiate transmission. The
+ * This function is invoked from axienet_start_xmit to initiate transmission. The
  * function uses the next available free BDs and populates their fields to
  * start the transmission. Additionally if checksum offloading is supported,
  * it populates AXI Stream Control fields with appropriate values.
  */
 static netdev_tx_t
-axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+axienet_start_xmit_legacy(struct sk_buff *skb, struct net_device *ndev)
 {
 	u32 ii;
 	u32 num_frag;
@@ -890,6 +892,27 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * axienet_start_xmit - Invoke the transmission function
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK, on success
+ *          NETDEV_TX_BUSY, if any of the descriptors are not free
+ *
+ * This function is invoked from upper layers to initiate transmission
+ */
+static netdev_tx_t
+axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	if (!lp->use_dmaengine)
+		return axienet_start_xmit_legacy(skb, ndev);
+	else
+		return NETDEV_TX_BUSY;
+}
+
 /**
  * axienet_rx_poll - Triggered by RX ISR to complete the BD processing.
  * @napi:	Pointer to NAPI structure.
@@ -1124,41 +1147,22 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 static void axienet_dma_err_handler(struct work_struct *work);
 
 /**
- * axienet_open - Driver open routine.
- * @ndev:	Pointer to net_device structure
+ * axienet_init_legacy_dma - init the dma legacy code.
+ * @ndev:       Pointer to net_device structure
  *
  * Return: 0, on success.
- *	    non-zero error value on failure
+ *          non-zero error value on failure
+ *
+ * This is the dma  initialization code. It also allocates interrupt
+ * service routines, enables the interrupt lines and ISR handling.
  *
- * This is the driver open routine. It calls phylink_start to start the
- * PHY device.
- * It also allocates interrupt service routines, enables the interrupt lines
- * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
- * descriptors are initialized.
  */
-static int axienet_open(struct net_device *ndev)
+
+static inline int axienet_init_legacy_dma(struct net_device *ndev)
 {
 	int ret;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	dev_dbg(&ndev->dev, "axienet_open()\n");
-
-	/* When we do an Axi Ethernet reset, it resets the complete core
-	 * including the MDIO. MDIO must be disabled before resetting.
-	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
-	 */
-	axienet_lock_mii(lp);
-	ret = axienet_device_reset(ndev);
-	axienet_unlock_mii(lp);
-
-	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
-	if (ret) {
-		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
-		return ret;
-	}
-
-	phylink_start(lp->phylink);
-
 	/* Enable worker thread for Axi DMA error handling */
 	INIT_WORK(&lp->dma_err_task, axienet_dma_err_handler);
 
@@ -1192,13 +1196,62 @@ static int axienet_open(struct net_device *ndev)
 err_tx_irq:
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
-	phylink_stop(lp->phylink);
-	phylink_disconnect_phy(lp->phylink);
 	cancel_work_sync(&lp->dma_err_task);
 	dev_err(lp->dev, "request_irq() failed\n");
 	return ret;
 }
 
+/**
+ * axienet_open - Driver open routine.
+ * @ndev:	Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *	    non-zero error value on failure
+ *
+ * This is the driver open routine. It calls phylink_start to start the
+ * PHY device.
+ * It also allocates interrupt service routines, enables the interrupt lines
+ * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
+ * descriptors are initialized.
+ */
+static int axienet_open(struct net_device *ndev)
+{
+	int ret;
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	dev_dbg(&ndev->dev, "%s\n", __func__);
+
+	/* When we do an Axi Ethernet reset, it resets the complete core
+	 * including the MDIO. MDIO must be disabled before resetting.
+	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
+	 */
+	axienet_lock_mii(lp);
+	ret = axienet_device_reset(ndev);
+	axienet_unlock_mii(lp);
+
+	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
+	if (ret) {
+		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
+		return ret;
+	}
+
+	phylink_start(lp->phylink);
+
+	if (!lp->use_dmaengine) {
+		ret = axienet_init_legacy_dma(ndev);
+		if (ret)
+			goto error_code;
+	}
+
+	return 0;
+
+error_code:
+	phylink_stop(lp->phylink);
+	phylink_disconnect_phy(lp->phylink);
+
+	return ret;
+}
+
 /**
  * axienet_stop - Driver stop routine.
  * @ndev:	Pointer to net_device structure
@@ -1215,8 +1268,10 @@ static int axienet_stop(struct net_device *ndev)
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
-	napi_disable(&lp->napi_tx);
-	napi_disable(&lp->napi_rx);
+	if (!lp->use_dmaengine) {
+		napi_disable(&lp->napi_tx);
+		napi_disable(&lp->napi_rx);
+	}
 
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1224,18 +1279,18 @@ static int axienet_stop(struct net_device *ndev)
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
-	axienet_dma_stop(lp);
+	if (!lp->use_dmaengine) {
+		axienet_dma_stop(lp);
+		cancel_work_sync(&lp->dma_err_task);
+		free_irq(lp->tx_irq, ndev);
+		free_irq(lp->rx_irq, ndev);
+		axienet_dma_bd_release(ndev);
+	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
 
-	cancel_work_sync(&lp->dma_err_task);
-
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
-	free_irq(lp->tx_irq, ndev);
-	free_irq(lp->rx_irq, ndev);
-
-	axienet_dma_bd_release(ndev);
 	return 0;
 }
 
@@ -1411,14 +1466,16 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	data[29] = axienet_ior(lp, XAE_FMI_OFFSET);
 	data[30] = axienet_ior(lp, XAE_AF0_OFFSET);
 	data[31] = axienet_ior(lp, XAE_AF1_OFFSET);
-	data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
-	data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
-	data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
-	data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	if (!lp->use_dmaengine) {
+		data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
+		data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+		data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
+		data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
+		data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+		data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+		data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
+		data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	}
 }
 
 static void
@@ -1879,9 +1936,6 @@ static int axienet_probe(struct platform_device *pdev)
 	u64_stats_init(&lp->rx_stat_sync);
 	u64_stats_init(&lp->tx_stat_sync);
 
-	netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
-	netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
-
 	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
@@ -2007,80 +2061,85 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
-	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
-	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (np) {
-		struct resource dmares;
+	if (!of_find_property(pdev->dev.of_node, "dmas", NULL)) {
+		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
+		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
-		ret = of_address_to_resource(np, 0, &dmares);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"unable to get DMA resource\n");
+		if (np) {
+			struct resource dmares;
+
+			ret = of_address_to_resource(np, 0, &dmares);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"unable to get DMA resource\n");
+				of_node_put(np);
+				goto cleanup_clk;
+			}
+			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
+							     &dmares);
+			lp->rx_irq = irq_of_parse_and_map(np, 1);
+			lp->tx_irq = irq_of_parse_and_map(np, 0);
 			of_node_put(np);
+			lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		} else {
+			/* Check for these resources directly on the Ethernet node. */
+			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+			lp->rx_irq = platform_get_irq(pdev, 1);
+			lp->tx_irq = platform_get_irq(pdev, 0);
+			lp->eth_irq = platform_get_irq_optional(pdev, 2);
+		}
+		if (IS_ERR(lp->dma_regs)) {
+			dev_err(&pdev->dev, "could not map DMA regs\n");
+			ret = PTR_ERR(lp->dma_regs);
+			goto cleanup_clk;
+		}
+		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
+			dev_err(&pdev->dev, "could not determine irqs\n");
+			ret = -ENOMEM;
 			goto cleanup_clk;
 		}
-		lp->dma_regs = devm_ioremap_resource(&pdev->dev,
-						     &dmares);
-		lp->rx_irq = irq_of_parse_and_map(np, 1);
-		lp->tx_irq = irq_of_parse_and_map(np, 0);
-		of_node_put(np);
-		lp->eth_irq = platform_get_irq_optional(pdev, 0);
-	} else {
-		/* Check for these resources directly on the Ethernet node. */
-		lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-		lp->rx_irq = platform_get_irq(pdev, 1);
-		lp->tx_irq = platform_get_irq(pdev, 0);
-		lp->eth_irq = platform_get_irq_optional(pdev, 2);
-	}
-	if (IS_ERR(lp->dma_regs)) {
-		dev_err(&pdev->dev, "could not map DMA regs\n");
-		ret = PTR_ERR(lp->dma_regs);
-		goto cleanup_clk;
-	}
-	if ((lp->rx_irq <= 0) || (lp->tx_irq <= 0)) {
-		dev_err(&pdev->dev, "could not determine irqs\n");
-		ret = -ENOMEM;
-		goto cleanup_clk;
-	}
 
-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		goto cleanup_clk;
+		/* Reset core now that clocks are enabled, prior to accessing MDIO */
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			goto cleanup_clk;
+
+		/* Autodetect the need for 64-bit DMA pointers.
+		 * When the IP is configured for a bus width bigger than 32 bits,
+		 * writing the MSB registers is mandatory, even if they are all 0.
+		 * We can detect this case by writing all 1's to one such register
+		 * and see if that sticks: when the IP is configured for 32 bits
+		 * only, those registers are RES0.
+		 * Those MSB registers were introduced in IP v7.1, which we check first.
+		 */
+		if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
+			void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
 
-	/* Autodetect the need for 64-bit DMA pointers.
-	 * When the IP is configured for a bus width bigger than 32 bits,
-	 * writing the MSB registers is mandatory, even if they are all 0.
-	 * We can detect this case by writing all 1's to one such register
-	 * and see if that sticks: when the IP is configured for 32 bits
-	 * only, those registers are RES0.
-	 * Those MSB registers were introduced in IP v7.1, which we check first.
-	 */
-	if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
-		void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
-
-		iowrite32(0x0, desc);
-		if (ioread32(desc) == 0) {	/* sanity check */
-			iowrite32(0xffffffff, desc);
-			if (ioread32(desc) > 0) {
-				lp->features |= XAE_FEATURE_DMA_64BIT;
-				addr_width = 64;
-				dev_info(&pdev->dev,
-					 "autodetected 64-bit DMA range\n");
-			}
 			iowrite32(0x0, desc);
+			if (ioread32(desc) == 0) {	/* sanity check */
+				iowrite32(0xffffffff, desc);
+				if (ioread32(desc) > 0) {
+					lp->features |= XAE_FEATURE_DMA_64BIT;
+					addr_width = 64;
+					dev_info(&pdev->dev,
+						 "autodetected 64-bit DMA range\n");
+				}
+				iowrite32(0x0, desc);
+			}
+		}
+		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
+			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
+			ret = -EINVAL;
+			goto cleanup_clk;
 		}
-	}
-	if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
-		dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
-		ret = -EINVAL;
-		goto cleanup_clk;
-	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
-	if (ret) {
-		dev_err(&pdev->dev, "No suitable DMA available\n");
-		goto cleanup_clk;
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
+		if (ret) {
+			dev_err(&pdev->dev, "No suitable DMA available\n");
+			goto cleanup_clk;
+		}
+		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
+		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
 	}
 
 	/* Check for Ethernet core IRQ (optional) */
@@ -2098,8 +2157,8 @@ static int axienet_probe(struct platform_device *pdev)
 	}
 
 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
-	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
+	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
 
 	ret = axienet_mdio_setup(lp);
-- 
2.34.1

