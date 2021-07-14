Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AE3C7B5D
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhGNCH4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:56 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:6252
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237428AbhGNCHx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+BZ/ZMlEAsYyr4kQcUsATuzdLruiTfTvvcN85+0Cozwozy7dK5siKkSUtTORN8/1J3lwTnRBiWob+ROpmJ3i0PVSyouXIdLB1PUSLYq6yrnQjHYwcWarAXtiYMvqjJqjW/HXaPDheP0ZICVRMpM3LTjFitZqs/zYhgLy+o8kzflBtFX842LvAfZPH1oDUo5g1B0D4nCeyyyINz1yeQYZDD3m9STekbWRowQ1M2bA6nC5r3zSIYxmb7CCjDHTKtX+ftr7IDjUY6IEc1RgoqbBSNia99CxV5d3tB6/CXVHCFYpPtZ9HvLVPvme/Ivd/M4JiXcwDatJN1t3vnvu8R4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+wNYSXkpgwjMDrrP/9fWqjfNAb2CmAVUWdGJvYPzQQ=;
 b=h6cDmDm5tdosekmCIjiKnnPPYa4VfoswWKJYYp6Meak/QOByV9BT/9lNI92U0ORXWVpid/LEd6muXogTdOCJ/epssKiFRmtC1AFKZtqFnqFYtrYyJyIQkL+myeya1xDFTdluu5Ob9xQYlhtYuRBSaR4V8qaUXJyd+DXoLK4zo+epQTYBwNGar5xzETEv1lWUDNhGj9sm8xip5VZo9SLx3DGPo6mN31hT6DaDrBoKsH3Idf4C6xGUmZRz07YYx6Q9NQ4GeQVTrQjYMA5sTcoAwgfTbRnML1wlwxbOnnLj9Ss5ROOcs8psr5YFcsEojrSEKl3nZB9iyxze/y/WZB6ECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+wNYSXkpgwjMDrrP/9fWqjfNAb2CmAVUWdGJvYPzQQ=;
 b=HheEpRqOLpFr8U6zXTr25mmhcOHt4KgOsEe9/JRxS0apx3SO0XGpoAwgZWzZCB3TD/hU+Nd2RHADYElbQRL5eHHWaULhohadZUN+iYKHLyaTh9+ndC0bZKrGosaIwV7hG4eEFajBYdHvR96t8fv6ZUlWX2Yf+i6+fu7E8eZtMxs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:00 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Wed, 14 Jul 2021 18:20:45 +0800
Message-Id: <1626258052-22198-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c91c20-3fa8-4783-c999-08d9466bc949
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175C2C80D9BDA0B5C4C582989139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZqRkSR2sejJWzwzJvktPfvOBV27KCbwjIzKM53e4x+vMlL8SZAhmRZ9UtGO/Tt3Ea+afNqRC8u8sTATAAY6RYqW9Vk4mKy7FxR8e4Zr+/6p0ZVUMFG2RdvxZHG0ySWTMm7Q72BAAl+JBTB0RsH8AHrMBW+KkHRgC+a4scQnMF+qFoZZcSdGLUEivOI4VGcCBsS6qJtDeRWn+155q7rRym0WhBk/K6cFkJKuFbY2Wv7VmjzW+5hhQC7S63HwledMgIJbKRcITYIKrNl6nAtF05uyXdtWPFvH3Ucx/Nymw1oIUvz4J7N6mv+jmEVvuVjvwmZY22xlhBCPcit8i5ybMtbhkfzk9yuKpi7XGuM45Oedyar6730wY6DN+vn3tgJoapA/Rv/Pd69Yq2++MvOvHJk4IU1mFdSpp/utdVcl+g9eAOUoTPsBp7y6s0bhhQQs7ZaxvoNHXakrpsgmXd/geCXDgx48+0VNh/9l46zsv8s+nrEBgIiN6E7b7rx3t/v/+AXu7dLUCdvP2VPAfxsIU2/PzqmO2Q3fZYo5Ni5fAIq1R5eOxl2Ag05YL9Pz16yTzHXr+DAomm4Pf3xsAbSmdiASYrRj1460SH+pSbgNJfkz1My76jKTCZD5T9L6D6pgXpeQ7Q1i3GbFiNV3pUthnHdaWVvkgRtr4KdVCZ96y/oJkrnSEOiCg5/zI5bCN9uWdHdVLVEs620RxsBqDrL0EI3E8p/ZuH0S7/tNR3c1dso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U820x/kAKbbma9XOIy1HoN9k4gE833G8enmUldlf8xSJBbzYFlv6N/n5ugkP?=
 =?us-ascii?Q?ab0mxv+AJ/Vwdzm9lMbwwe+e4oM5ncGNKIvZMavwlM10jb+oanWbVahaPWHs?=
 =?us-ascii?Q?nWCSJntNwiE3ndnKACOk3LIz5Qz7VwK1TwQxdmhbDS5/5uWYPcBfzZ/XbAQ4?=
 =?us-ascii?Q?NAsBJK3TFbJ+7xjRLz1U0M9U9SdG28f0q7ZVThEfd5BpU3gPmo9kzEtlLVuy?=
 =?us-ascii?Q?89PzompJ18ZV822PZMpwhv8+qOHLG7xJlY8wc/sFgQKNpW0bPTkpnF/TiIk/?=
 =?us-ascii?Q?f79JU0EjeGzvBfzgOFtjHMSHmTIBJMt29KBr/bn92kWZdnq7WZ1USkJBBcOB?=
 =?us-ascii?Q?BDG206Uisl24yh+EKYah/GlTSnPjXXFChrjerU/BbW7rjntv7uK/mwXpS6Vo?=
 =?us-ascii?Q?cYU+x2/zl3QqLaf1ZgvYBOKC6F/F1LcIyUSYglLfMgl+4WeoseB2D2AhG8HF?=
 =?us-ascii?Q?zWnpY+g1rEV/+njPo3iieGBHmhB/GfQ5S0Y00E+ZE4xmO1msOf/7aW7sk6mi?=
 =?us-ascii?Q?lmz8ToUnCNRXJe70XnHYhInvqeiPwSfcmORdjeufVUChD+8Bwjyi6Gn+1pkR?=
 =?us-ascii?Q?k3/bHjj9+IBSUbe9AsRMK/XzfLO3+K4KXvcBRdYCK8lsj6WgUp0PdQkYpRYW?=
 =?us-ascii?Q?8TQmn0A1VF/w4kkPJ1OhK9WGJIa51UDZ4NhgpBjbiJe1hwIE9+RFwLUAaVEK?=
 =?us-ascii?Q?+iQUUiByWbjodLZmCd6mQ2SvA3dk58jgMTu57URZ2D+A3OBJaxWJCJ881hvI?=
 =?us-ascii?Q?JBtv6/bQqeV4TS0XlKruIWA954Y5EK9hyAdEY20fGV7XnClPe+E8R/vPvcN/?=
 =?us-ascii?Q?By/8BXUVO5bNP8wHjfzoN2k6B49SmrdPAHv3LKsJ16E892Ig8APRw4LqoO38?=
 =?us-ascii?Q?olxGh4wAwFeBNnrUHmmkK2CG9lQO7RmrJTlecVEE+TpQOevUpjwJDF81tS7c?=
 =?us-ascii?Q?6ELnx7yEElIF4rSAYSEkC5Dna43kPqr5PepNydVemco+o6QAzIs7FckXqr0A?=
 =?us-ascii?Q?YrQntFWVDkE8UaJgmqz3MFvNa2nY6e/FKuihGwiRE0P/wm35Y3qQRJNyQUP5?=
 =?us-ascii?Q?akHmRl4k/lP9G3JZaEq4OvEJacZ/s/QqONxypLvUXVLPx45abYsef2HvB5te?=
 =?us-ascii?Q?A/MmG6qUlP5kDSDswCajXyYB9TJzAkUHixyilFTHHKkiHpOsY6AxvF/33kIg?=
 =?us-ascii?Q?lUpenmadSmTjrIHKOaTOrDQtF820wl81PM+DxZlJzU12zOTKZGdjwryMHSw9?=
 =?us-ascii?Q?FeMkL4PFE3UIqU8Uhzfsz2HPbvM/ZYieObt4CdxCMUQwRmPr0YJoRA6OYK6B?=
 =?us-ascii?Q?gERU+CNx0AeTH+eN15XpnyIv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c91c20-3fa8-4783-c999-08d9466bc949
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:00.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP4wnIGZ1cbAhB0Z9UwQXEJR9Kmj4tBSe0JXKjN3bcLPi43tTBigmeTMfLzegyEZP3SUVTsyqKKvhDVFD3dqCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add 'fw_loaded' and 'is_ram_script' to check if the script used by channel
is ram script and it's loaded or not, so that could prevent meaningless
following malloc dma descriptor and bd allocate in sdma_transfer_init(),
otherwise memory may be consumed out potentially without free in case
that spi fallback into pio while dma transfer failed by sdma firmware not
ready(next ERR009165 patch depends on sdma RAM scripts/firmware).

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 665ccbf..d366198 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -435,6 +435,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	bool				is_ram_script;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -498,6 +499,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	bool                            fw_loaded;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -918,6 +920,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_to_device = 0;
 	sdmac->device_to_device = 0;
 	sdmac->pc_to_pc = 0;
+	sdmac->is_ram_script = false;
 
 	switch (peripheral_type) {
 	case IMX_DMATYPE_MEMORY:
@@ -953,6 +956,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_SSI_DUAL:
 		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
@@ -967,6 +971,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
 		per_2_per = sdma->script_addrs->per_2_per_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_ASRC_SP:
 		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
@@ -1363,6 +1368,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 {
 	struct sdma_desc *desc;
 
+	if (!sdmac->sdma->fw_loaded && sdmac->is_ram_script) {
+		dev_warn_once(sdmac->sdma->dev, "sdma firmware not ready!\n");
+		goto err_out;
+	}
+
 	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
 	if (!desc)
 		goto err_out;
@@ -1792,6 +1802,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 
 	sdma_add_scripts(sdma, addr);
 
+	sdma->fw_loaded = true;
+
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
 			header->version_major,
 			header->version_minor);
-- 
2.7.4

