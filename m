Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778CA2574AA
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgHaHwp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:52:45 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbgHaHwW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIyq0PoZF8UO38Qs4+Hg9ecBK7Db65MYvSPfJix7COpetZlK4odIHg6LHYsnI06tCEd3QGI6Hq+O398XpyleMGflOWrhj1ZyFyac/hLHJ3JKub21dPFETi5mN3FXgIYCrADLHuOPFWjNdFJx2WitGBvm8icamfZHQ9NkhZZBE+uLtVASbCH9LD+uVkxAresxI0Nbwiv2rBAu13PqSH26NcIc5qWI/bWaChcXBgbEHBiXHsrG3nLVwrxxJmGwgU8FOs23WwUeKdAfxcJZB/8D+qMvxIFKHZEv3u7h0iFmNHUZiedOYkPuSF/M9PYUF+ROjWralY767nafoiC4t00sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw6vTorR3E3XAElDzrUJJdF1wDmUb3tjnC2gzeCv5cg=;
 b=oHFWbLMcq0/3wVlLN5e8zp15cQJyS2fAT1+/cyzy6gT/FyYlRKO157mSlY26jmST58AFze6jeKBgrrZf8vmsxJWWZgGg/DuqW3AA1U7oAbAqSUBXURGiF+SDk3C3lQy1vrFDP4gjqT4Y4bFMMP1v/0L/drt2oKPB2F5VzPO6bzvvuLFN2pKrL1U59NBSIPsoST9z+sejV4u8nZgyi1o7ecslfRmx6JTGA4p8gVViIknGexQ6RbEz0CyZDMgwoliYqY+M87rzp/vkAnENpB8aPBLkHhfU3EmqiO6bWIK708GminltYSC2QljXaBOjJ0mpJ0hWLjDqfpC5D8lQ4gw0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw6vTorR3E3XAElDzrUJJdF1wDmUb3tjnC2gzeCv5cg=;
 b=K1V5nrkcBWboGff3e5pMS43OznJIVHy+EG+ZAbvNqAL44kxPIZLqoCuM7r8UgoyfFmrnRXGMDXkpfSywd05TVT4PYKz8cAAoeLVxreNdZQkuVWgZH92ePf7lz/atS+JsF/aF72Y52+mF9oxpE0c02OsNtblx5HeP/pJ6rnEDkfM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:43 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 11/12] dmaengine: imx-sdma: add uart rom script
Date:   Tue,  1 Sep 2020 00:03:24 +0800
Message-Id: <1598889805-30399-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0dee2dd-8ed5-49b8-0097-08d84d82b3a8
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB56949392AA245AEC0A0BCAF589510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MotlVVHVIQfpLzvRn8u+dlo3WVEKGXCAr9B7QpMVtvK2bc72AY1xjHrPs9Is7jg4OUw0dJC0B4AbBn/RTWqMy25A2azEhpgEtMzCwsAmJwH2tCCfXlbV8x+wHV5S4IhBXCtUOXwyQQE7QjjLLaMPFhZwjs+MUEI8HLWIQ0wxfwEt0H+h08l99Afa+Nd6GQTPgvNLgf3ER8Wz6DB5zbivXVg2Ear8dXmhpR1jaQOoYVdFFEPROufpQ6WMLD3aHTp0GxZ+P5u/EYN++N7tw+e+M0myk1FF/rCmtnlkLs1Fc9V9Q7NqM9Tmsq8GB/yy++Lu2y9uKDRVxhzvZS8F4SZPkrPyt3fXyh42K7x/2mR4mx7IfrPA7N9lpW+6KKT/BZG4t8c6LhAdjkJHCvGuKnGSeLzIMQAoff3eXv1UC8QYk3JGNL89jzB0q/9t3b279o7TNGpoYlg98H+j0GLPP4wi8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(966005)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oeaPZilblcZQXXjAt7cNuIHTEgnjrmlXDNkXdFXDin6xcik4FqvGyYpKdc4eieMmOWfUlhb+hVFXZsDfPZdV1IIhxJ8zUztXqjTHz3AjsVLZ38UvqRdax6ljnW/MvJQ1rN1/HiraM6ywm6edrUfr8wfOGF4VGa5ONoR/qF6JZ0Df8zctjx5CgFW6aYEtiLlDOkDqxWU3o4MhEBAcpMTbY2QSqCgAW9QdKiQkfBS0Ojtzw45x16nQJR1HYOByCt9wxvlD4EfUEV5/oMrwW2Z62uO0DnMzgeYGmlNxYIqwdyZcRHKPLZtU2CtUx1dSUYFt4+rR+bJ4uBxSkUqWcAEglIj++bUQgZwVQgGs8GWc+z9vOvpoKb4G0T3Js+42DBKd5Q3atqkPBc5dY55KbzS/+XZTTB4olBCiDdiYoyesK8XSXfEv8FIQoZU0LVPBVwYOljP81u5LiE1wc1szB0F+YUUQHkZXJdFaiSv3lLBj77wlxjbk7cNQPLRBJnOPczelb6JV3/AA4dReYAHOscOl3CUu51QX2If70qCm8A67Pi9F1bAdvT38YU5HqjtqWWdBikhzNncgCeP4s9LLhQrcfOreuByIYxIsNYJPqEh2N36KHcVblPLuxhK4ObtbqFhihbX2KuDbHC1djFOJh6LxtA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dee2dd-8ed5-49b8-0097-08d84d82b3a8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:43.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNVcKIutGIZCD2bxfsAln95SsrEoZaFlHWHzeBcGgGC4ipHvZsrg5SIBR+WjeC49w2osbeYPvDfuvZMGm7p7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: dmaengine-owner@vger.kernel.org
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
index 147ea88..9bb6270 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1731,8 +1731,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
@@ -1756,6 +1756,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
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
index 30e676b..e12d2e8 100644
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

