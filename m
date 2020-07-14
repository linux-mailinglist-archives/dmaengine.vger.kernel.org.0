Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA43921ECBB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGNJ1f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:35 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:40878
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgGNJ1d (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIdVnGZyUxjb9JIbM9K+RAGayJaKxnHoq4/1vAic08St/3SvG/v9u1jDmy3sVuDCv+h0kD+GvpcyGBFIvS1vWx9JM/fJM+a+IK4zYunVvnaohHPnWapOa/nC1H9ewqvEYSt57oBGBuzfHyFmawK7C575sAKDjGFFpNcqir2t8okV9hziEwYMtM1i5RCQz//S/2+iU1vxsb7lcLNR5VkgobWdHtOllFIfnPQYcqQX51wuOuJqJXk6GjDg9N/1Z77+Kg++iECIjyghF24bzaeZHFwKRjhPlVf9+eiiDDnt5kyGM8Fp8MhWjS2+FDaN3JDzFfAOukfW/wbIgZVJVdwF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlMSjTLc9bPxAbh3RbYyMXN3owo0JtZ3jcwGfsNozXA=;
 b=NOqVFa1jLtIM5lr6MJXuS28HV0BWs/xERzJ+Jibp0NXYL7owfnwqQtwWPbWxvwabwmgGAM1DfoDHjuyF5LOgC//aIYyQZSkYCG6DOtamd/irKaWzfuYDYoNhE8H+7KdBVZkA/uKpDy5wk64zp+kCFxnfg6jIk3+ouAxa9b5KdeYqpt4zE+CQGIoFSBa3qhKIfIJfMEC5+g5clw0cuqrwMt4agX8PTwndOslJQiZ5sqFXkU3IHHukdWvXYgs0/mbb+9VvFZA8UJ1wxcqJpB6HZulYVCN5D3WJc5fq6YRX3ZdYAkPgjnT865FEm7T9GWXzrfzYuSrfInNmFKRdBP+XUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlMSjTLc9bPxAbh3RbYyMXN3owo0JtZ3jcwGfsNozXA=;
 b=hETJGMTPJZNg/c7VdkopKrzU7KW8vYBv3R8R26XaYp51DFOYtIfhnt6rC6FYkxECFHEb28Ec0G0qQOMenuCQZwZRKUO10xdUs9ekmHI7OrGKMI5IzH5VIWeAeMjOqH6XH9IwroBY3iFIRr1tFVxgOmZOcI3nlgQK+QL+YTjjjEc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/9] dmaengine: fsl-edma-common: add fsl_chan into fsl_edma_fill_tcd
Date:   Wed, 15 Jul 2020 01:41:42 +0800
Message-Id: <1594748508-22179-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbb510bc-7135-4206-a49e-08d827d82199
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6270E3C2B9CD7A775282F66689610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVTtIiUX3NUYaMbNmv55bRMhz7Xr1MJFckRHdyjitnr4p7mV8n/68KcV8l5bdTq/YRqEi+Jdz7Jy+nZKhJDkcM6PJUTx1QtOXf+m0dZh+wjiYYN7zkCIZL9CrYCukutA9dVdTEEHk63yQXYgK/5Ez1ztHTDWZoaWw2KS8un3ORGH0V84Ag95tCOxXfhsT8JViaQAbYeaLe5Lnhpmbmvcui2MnQ5QO1OJasvlhuNLMBcLnLU38bk9Z9NIkTEGt3aIbP0wulrryf3wirGHb9zEh1b4FyTRCpzF1n2PpMYEQqwfsQkX9WO0Z8g2jkCNm+cAnV+KLYJnHv8HNVUDxW/USg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(498600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /KJv6eYtuapuibIKZsoADYCvrgGKCBCcHDQkYH1v61VD1Ru3J81CC5jM7WvtTnAJDVw9YjCSVhDNmBpLQecyQC1nWFKTIqJC2pgZOQ4CqbRrlVyfZH62Vy4rp+9uXIELUNdwMHsSByPrhCmzZIzMB3aTWjbe2+QcC/MgsVHhkWoMRnjRmhFEs7Br/1R8T8pNvpG8sM0yaUQZLYy2CVEUr5mrXQlSKuLrmQi2hnkrmiQ6zRP8S+8Bq7xlRLa5d3SrAKhof6FNHQlCFZEfPnbzS9b3PzaRMJxt+r4xsaDpTqqIxZDIUCdM5e3z0KEUPVBPJE6uUFMH9lfmhdl7YXlngldotBnwQXNKyhqDfSSikkJDNWW6ey/vuN4/dMqQLYTaH6zfbyqi324QnAo02JtFpxKWbxplovBCje8o5EgOhenzlA/fC2ES+tr6DHu0TkXN+jqxbMmlGLT+ffyeKNQktrljpUWdIjY8ou5ZCzGcjxU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb510bc-7135-4206-a49e-08d827d82199
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:30.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wefrXcgCPNtuf9NZmb/XMMQPIR23mw5AJMO2XT2FiD6VxRq5fZl+ONB/KjwI7Bl3Xng8LjaFt/AJTswtXyxeoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For preparing for next edma3 merged so that any member of 'struct fsl_chan'
could be used in fsl_edma_fill_tcd.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d19e8a8..6ef083c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -376,7 +376,8 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 }
 
 static inline
-void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
+void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
 		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
 		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
@@ -504,9 +505,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			doff = fsl_chan->cfg.src_addr_width;
 		}
 
-		fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr, dst_addr,
-				  fsl_chan->attr, soff, nbytes, 0, iter,
-				  iter, doff, last_sg, true, false, true);
+		fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+				  dst_addr, fsl_chan->attr, soff, nbytes, 0,
+				  iter, iter, doff, last_sg, true, false, true);
 		dma_buf_next += period_len;
 	}
 
@@ -569,16 +570,16 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		iter = sg_dma_len(sg) / nbytes;
 		if (i < sg_len - 1) {
 			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  false, false, true);
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd,
+					  src_addr, dst_addr, fsl_chan->attr,
+					  soff, nbytes, 0, iter, iter, doff,
+					  last_sg, false, false, true);
 		} else {
 			last_sg = 0;
-			fsl_edma_fill_tcd(fsl_desc->tcd[i].vtcd, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  true, true, false);
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd,
+					  src_addr, dst_addr, fsl_chan->attr,
+					  soff, nbytes, 0, iter, iter, doff,
+					  last_sg, true, true, false);
 		}
 	}
 
-- 
2.7.4

