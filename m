Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49735650D
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbhDGHRD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:17:03 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:43331
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349390AbhDGHQy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxINwIkMTaxYrNOXyY6TpQnq6Y9RBkr+pshIErFpMFAyWBV59h+39Te2pDNTGUZ3zuAxMel5mD8wIEnDIgKb+rb/5JaLPkGzxt+3Qc8ywYRfCNbQ8qkaRqdqCXnF8YL0YbxK/fnMK56xLbkYiCA+5JE56ldGPl5jzmgXvgKrK0nhNvODhndGodGqvxaawYabyYxWE3dauJPlyUoBGvMV+O4ODJ0vqaq40tvUJPpIorPX5mLq68vbbkMnJ/lZIeo37Jl3H1K6SVPz70IByEHVS4Knn4KeoDjflvFbwrFZow8q17ZqJRalDAzV4zSjor2u5xfPS8zBz0IwCT+gYnrxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYa8r5TxtWVOSf7TiNgPJ8GJxUj8rQjNL69BTbnVrPk=;
 b=N6RcPmw+Dl5cZFFR3Su37W5PGV/JvSl/VG/nhIBl+Wj3Bo5h6d/AmG1oxG8oo7rk2Vo41d/1l5hE3ENgYdN1zcIWwxAw18K3wOab/cN1VLli8pbq7DwNkmxq619UwyvSfuWwktfw4kgY2HSeAQVUhK+84Dhx+609quRv1Lg9KpAtJx4ht5uQh1hTNFpq+dj0tKtWx97UfhTEqJtqj/yMmNGmEkx48Da23C3Xf/yk2HUkbORZvKaqKzE51mXyweWJE/he7X+sj5HAIfan+KEJpypdmUhjJpiAqoWvcFwkI6afFsiLti2ZNnUBBkGMICxdahS5v14CcveXIcQmTvmNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYa8r5TxtWVOSf7TiNgPJ8GJxUj8rQjNL69BTbnVrPk=;
 b=rM4itNMVfeEtpkS1fh5bnyiEkX7PIIqBxURK3r9nygGCL9A4WXYFdL8Kv9kD9VK+aZlHx6/9PaWtv0TwczG2sG8612E/siRSVqcvVSEW+VLkvJbyVzf0VjIPTOw+OxLCciZbjIc/IX0jmqfRZdZYK3gQkTF9KSsCGMNr3uXHB3o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:42 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:42 +0000
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
Subject: [PATCH v14 11/12] dmaengine: imx-sdma: add uart rom script
Date:   Wed,  7 Apr 2021 23:30:55 +0800
Message-Id: <1617809456-17693-12-git-send-email-yibin.gong@nxp.com>
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
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43be4d34-d30f-4326-378c-08d8f9951852
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65092973515ED97248BFB04C89759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +E+wyeNLMgCIld4BfR5vWGT925gSZXPq2ZtOxyzwNrB8xxCt5uBVSZ7MA2RwhLryqdYFAf3q/yYTugSNjghYt53GNwXUTExjyX5+co4W7BAmuCaPppNMbmDp6yYvI24sAfgI3fQM/ltqM5WNJJ/9yUPVgkunfU/tiGgQ1gHEzHPW+C/KOnPBd8Qc2rxFB18SDZRkszVRqaHSMQh6B18FGfQlbntnwFom3HWBB0boDA3yutzOlv6SOsJV1BeGiUDzuut6Xun64edqoexo3kSnKDBaJgYqItQY98WQdld3ayWPQb/2Hvp5BR5VRylSgip9pTAl6GyG2MG335VzkNAH8oJ2BGsHgUHVgE19h2MdVOa27TI1f8Mk4dbp4FPoDHkq95qh6Wliqze5zagIvnieuVDdGEZtGxrhp/TXGZlAX922hYQrTBAr2QOf0rT4SG23X2c6BGSxP5pPgltSvk8H7Xl5GoprpzG73s0bdwuC1YKBG0jgV9yM6HFn80hrKjqrlthT3zsKwl+E1wshoVRNk80SGjXdRGe0VpqOrZ6vuu5vx+3ccD2xs1eiiZD9ISZmdXBpr/Nrfr2nCICn+cbtHkS4Mj/Xu11THqnNGY+rs5FKIKb8BEXgM9msWlfekTgck4UjG4kBmFG06r4lfvO1neTIAh6kNj3g/cNr6jPm374mX0pZfysMlNzGzoUw1QAnGe7f33I/5e8jU5ZbY1ql/5EgGd1lT9iDoliFwntXY2MTeeJHqnXkz9mhx5Rdxn2Ix/SitapJ7JXFMxAq41zABw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(966005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1nQ+Fyjv0n/LQZQGbQO075PcX0hcoNtDIpmcU6xGgmqQzMpAkddA4PuuSNzC?=
 =?us-ascii?Q?mc5kyK6+jbO+9p6gsZFP+O0Yyk0uyrQkgHs902D1fY9NYrWrtsN8EDAa3MtM?=
 =?us-ascii?Q?04apfH8TmQyojDrCJyhn0zbRkafI580lFat7GliLD0w70kNdLvtS4R/BijnB?=
 =?us-ascii?Q?OKUpMQRRcw3JVo+k/eLUx/E9/x/lyu56UpTT6w2+uNGNeD8ATK/ECKpH5zjl?=
 =?us-ascii?Q?dHQfqi76PDFfCnePS0EArSzWKjFXy2h3UTON9vrqPCpZbBrbHry0iUT07PN7?=
 =?us-ascii?Q?rn4o8/zooetDIGvcel3+8hJ2dIjH7H5nTGttRAu5OZgGCg8xFHKtUp1E/dPx?=
 =?us-ascii?Q?z9b5oDKZT2qC+hrUYp3Kbd/AwOv5YJH0mBAFGXa/r2cIWEbazYK/rDqxJ//m?=
 =?us-ascii?Q?9TSAZAcRGZMVOu13j2y8zm1xfwAGVPoLkd71Lw5TMD55IFY2q0Uj/lkYvSUB?=
 =?us-ascii?Q?hJbveQ6J9ipeezV91JsroMN6lO/SF/S9hyQ7J/TgxcT32lQVpRkymoQmpVby?=
 =?us-ascii?Q?F1VgcCnOAcQkZO0PQpgKixgmYUHUHlcGn18dUgq+ivNY0wrH0d4aM6O40KA8?=
 =?us-ascii?Q?qMmg230RR1YpOoD94iU01LHfgDn/o5exCiUKJ/844Ay7yR/y/z5BGieSpUcs?=
 =?us-ascii?Q?ZL8xYqTEf8r8BpuxqRJaU6J1/C5M/iu6u+NYfjX2Hy4RukYJ3BXLA0h6gFV1?=
 =?us-ascii?Q?LEJXrpbsgZwWJjY4qmooFDdAY2Vm0gaRkEivA3AidcOydUWe0xJvo9+8Rdwl?=
 =?us-ascii?Q?8pR4ag96cxizLy/DwIe1TCrO2VJl0jz5vESC+8EQIRarjPjTGfweX4acHqOQ?=
 =?us-ascii?Q?1OvFQ77X1Xw1gabTyw8x2V9MXZI84SRfKbbbZhv704rHBYFsHI5LxioCUSNc?=
 =?us-ascii?Q?WwHPqeEHIj30HUf3TYO0jYAz+m2IaCuvVY2PLAlF7YVzfCM61dxWec5tfGEe?=
 =?us-ascii?Q?mB5hmFTt6X94WwbywjX+WcMjCDurQ7hVwUkacZlJFm08G5DGPVXaLCnQX6vc?=
 =?us-ascii?Q?tijqgHYMBHSSvmNN//qrGPCgzahOvE0gK9B50n7tN6oE9eFPpIDgJV5lNM4i?=
 =?us-ascii?Q?XIwvS4eTRuOaThEHVZTTYxNgl+aTNyNExpGLYQMrZLCRU56nqnux5AdNzJFU?=
 =?us-ascii?Q?7N4PhBXdyNiDk5J52YZs79sIdlCLyc1aSTcFkkt+mow8SH0NHxdkYP7Eo5uI?=
 =?us-ascii?Q?2nWY2g4TJqRo4xqpvW0Dbx9EE2DA7On4RLX/OsQebOrkTxiqgkA5wpjVyEim?=
 =?us-ascii?Q?xfZ7NqqNxl7pOyaeoHc3vEdfxufAPaLDRdA5o2nqBiE34vEYYgsQzNm2ZxTY?=
 =?us-ascii?Q?MACuAodymOlmxpmL3P3JiHn5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43be4d34-d30f-4326-378c-08d8f9951852
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:42.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Df24RH6fI8nChE9j6Dba2Bw8thNHOazpNJVaLdlqwT2qlFPZ9jRHlLYVuX6C+eHx/KN0PgW+C0GMb7DrCCaag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the compatibility of NXP internal legacy kernel before 4.19 which
is based on uart ram script and upstreaming kernel based on uart rom
script, add both uart ram/rom script in latest sdma firmware. By default
uart rom script used.
Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).

rom script:
        uart_2_mcu_addr
	uartsh_2_mcu_addr /* through spba bus */
am script:
	uart_2_mcu_ram_addr
	uartsh_2_mcu_ram_addr /* through spba bus */

Please get latest sdma firmware from the below and put them into the path
(/lib/firmware/imx/sdma/):
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c                     | 17 +++++++++++++++--
 include/linux/platform_data/dma-imx-sdma.h |  8 ++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index af85116..9519b41 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1696,8 +1696,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
@@ -1721,6 +1721,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 	for (i = 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] = addr_arr[i];
+
+	/*
+	 * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
+	 * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
+	 * to be compatible with legacy freescale/nxp sdma firmware, and they
+	 * are located in the bottom part of sdma_script_start_addrs which are
+	 * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
+	 */
+	if (addr->uart_2_mcu_addr)
+		sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
+	if (addr->uartsh_2_mcu_addr)
+		sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
+
 }
 
 static void sdma_load_firmware(const struct firmware *fw, void *context)
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 725602d..91dac29 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
 	s32 per_2_firi_addr;
 	s32 mcu_2_firi_addr;
 	s32 uart_2_per_addr;
-	s32 uart_2_mcu_addr;
+	s32 uart_2_mcu_ram_addr;
 	s32 per_2_app_addr;
 	s32 mcu_2_app_addr;
 	s32 per_2_per_addr;
 	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_addr;
+	s32 uartsh_2_mcu_ram_addr;
 	s32 per_2_shp_addr;
 	s32 mcu_2_shp_addr;
 	s32 ata_2_mcu_addr;
@@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
 	s32 mcu_2_ecspi_addr;
+	s32 mcu_2_sai_addr;
+	s32 sai_2_mcu_addr;
+	s32 uart_2_mcu_addr;
+	s32 uartsh_2_mcu_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
-- 
2.7.4

