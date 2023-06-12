Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4372D098
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjFLUfG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjFLUey (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BBE53;
        Mon, 12 Jun 2023 13:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8bh0q7gllpsW9PbhTL+Gjl6LrV9mu9vMG0bN+Ep7BCNyCp77pFfcQyogxsL8oV8+9wlUNp3Fqhm1G5HG3F80MzACCV7xa+YSR4qR60OoEAfBSDssC6bXQ/roHKhN+K6QL0V74Hy/Kf5BEfqdWZ44kuHBha/6Oll0XDpHKOjUIuYTVviLjOjUhGUrwjwnnXV7J1LDLjbkY1c4SA0XI7gZ9U4XJto7ArTz9yuyzbBBvaSfUxinwbXAdc2/6vL9+mW81q6VwFol2OlpwDUC7fo3+fmY+AUsbXHL8L1Sc54kZD6eW/zaTHKSp3GaNJM6sMVvI6/lTHoov/GCkOyhzBSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=Us9fpYs3Pn7ZyBTTnZyW/O6CIr/0vu5cv+fR+7YFuMo0OdCe8+W81MEmQj46GntxdVJQdSbzcu31hg9c7EWjJ7Ke0CPEuqGblZL0yDoNmbjBQREonZ05G0tu5tgAAlJ8CagQrzlfd0tjDMvKCxlNNwJnaDXIPEMt9OcIksfFNeAkY7cvCQBfmAK1fFz9FYUJ3ofetCAeHdsHxilsiLDJrIpEzv30bkngIKuOvGuCr2DvjZEv3RqmGR08dmeqCXe7E++S6aJcU7YBu3g+RT2XkkypKu8TzihOH+SFSGScIiAW5BA0iJvyYd0tSiIp+gDjZ41izWB5TyNCT2EGquDMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=p3TUu30VxybNwYK/wZyAvRr80x57wwJ+kw+lyQ0DCNORbTB96dC8HBd3DGM/UI/bUZBGRFrvCBavIyEf1Y+VzALUHejHoB/cHwHVMw15fDqGn2We73jVdQ77OMiZ/o9Qgw2pVfay3YjNNDIKkH+CwynIDJqLRArUT5ly+a5lK7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:34:49 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Mon, 12 Jun 2023 16:34:10 -0400
Message-Id: <20230612203418.2017769-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 619ebf41-ed30-430e-1e18-08db6b84776b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 496Mn2yhPcX8b84zEWKFXkdlUCeKTbEtFlvp39vXyjEbdm2kBPolx7KrurmtrV5Uc3ul5LFHGLhRR7DzrtSQm17DvEGwNDrD9EjktDfTS3IaGtC6GFjCCvJkibSNqt3hVVq6EM6qXjOBFOD42x2N1LKA0gcBT2AMlJrjPL5Qj59ge39wuOaBpncAe5fAxn31B7p6yPUWf9CvruiiQPGMqOIoOX2YyHxYx/4E4sPJbUxoPrzt972ujpUsVgnyAxH0cH93+HEoM7XWNP1SsVncR5rbgDxlGMHcnmi/AULi22LM1PojMyjnUKQxWZBdt0L1FmToPdlaFW0N+USssOBM0vhpLwEaFr+d/o9/mbqxPwe2jEAc84on8blBDb603tiDIA1+emB/pjEnJrOEwp13avyKOOdNkpII2ziCpynnEg38aZhonqxQgk0F5ayIC9f3ttiS2m7qOJJiqBJDjMciceI0QCLAh6acmf1iykZwk4dR4f0ujGO2+ktHCt+3+EtG8ZFUH/Tz/McAJbN1s4NbPIIGUPH2E9KlHWwxOO0pnxru4quRk7vhIOPOC7ihei9A8jeGMy6iv6h22q3bJ0ZL0BVwj+WFahSVYe6AZhEAm3EyCkW04Y0m93wBl/vptBTyXOwoDVGmf8iXfJg8yw3XuCl0t4x8x3KX83tHg2gEeQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0OWPnU7NfrmqJ/G9OTU85rNQr/5jJaWbzOy4zz+qP7TtiUSmNw0k7g5NJUY?=
 =?us-ascii?Q?BiuAlkBtxIKg7Q7nInAuT1xHa1uzLMwM1OIsFKxqmSwhFhlDzSKrLyWLFij8?=
 =?us-ascii?Q?w/NOR7zAecXS8zvMIruQ7h8hgsu9tvOtqtAOdQrhKjFmctYAFvNYaX9YsmOY?=
 =?us-ascii?Q?bsoZxv05uu8A4IF+e0qgqWJsALYrgNlG5ED85svrNzaGwpxMAII9F6CvTcad?=
 =?us-ascii?Q?mFkvR5Wv1ZfoxhLMGQ5dJjbF4Vgwh+fTRCfRQxwevG8myjsKghzQcDTneZI7?=
 =?us-ascii?Q?Oo/TuuYRS9a52T89e2rkDfVEfckyYyDMASXYCqP9nAZ4vb7ZYimDIEfAYzLd?=
 =?us-ascii?Q?HCoFamRmHYkv3sKiKtCg7H7lvpy+hnnM2sQzu7MfFbwZIem55G827bNtEAIE?=
 =?us-ascii?Q?NIIS3/ffVxglUl1+U8Yk3X7kICEbNrGwRV6J+gHq/dNerzi3jzP+Y5aTqU3b?=
 =?us-ascii?Q?U2E18MLOkVnUEXgD5WmkASqV8QVqVO3KvsH7Vj9VscbijJ+Is3v+ts3T+mWn?=
 =?us-ascii?Q?8t/Rb8HB1X6mjaEdo4EEc6yLvZePjUEMqWoUTY+u6PwWuxXpIFNDgmPIETEz?=
 =?us-ascii?Q?Fn9Cn/exrY+AhZKCkM8Hpil2SVZHFaBD65/cQOhlZVXtzlMdKpvzg7KsxArq?=
 =?us-ascii?Q?TEmJKGAWSB81xuu523Eiu/+7VqLr1QQTo5Rg84nS4txpRNCYOQ0rdXKX0R8p?=
 =?us-ascii?Q?Hk7GxA2DRjhSUKZ6JlRLFjdqq7QbnIazD5mO903SwhlWJ9vAX4iKMzWN9O89?=
 =?us-ascii?Q?d5EtFUMHQcWDdEW2JcIGfjSBLejlhajt3WO6EzqOk6hMa493991Ieha0z7eq?=
 =?us-ascii?Q?q7ZOSfQI+645b7v/t0g18vbJ02H5eXZ+eReG/JU6jXp03khoiwQHStsy+DeJ?=
 =?us-ascii?Q?aLtCYz4pePKP3cT3+J8QHo6eX34v8nT1LiFFNhlmi063skhuAGdq3m+wEbk9?=
 =?us-ascii?Q?5fitOjCl8gh+8YU/iLmHZJWAZf+rnh3Fwm07BFG9g8xp078v5GeB4YpSqmoH?=
 =?us-ascii?Q?N6eS2n/tZyKyRZIcZrerO7sPS7jDv6r62ED8ltqQLUJni2Gabi9oMytbxisX?=
 =?us-ascii?Q?AaQwq1JGvatArJucL2Y5vt5TyYtU6UUBFAvlfAV3o4d1MgurctgkflAM/KgD?=
 =?us-ascii?Q?FWujIuu3OdKBZW4yLNBjb2/ZzaJAxHnavIYSEm5eHt/ZGEzm7P5JXq4rlCAi?=
 =?us-ascii?Q?VNe4Qy2a9doHpeDExZYzLUP9seWqIaWtJo497GOp4le/jWyO0n5yjMg8j+f8?=
 =?us-ascii?Q?nNWFi/1VHqbmFJaDT6oq3hl3594LwhQ5La6X+YUOp93XMBUUk+UkbUnoBXmJ?=
 =?us-ascii?Q?75iocX3ou9cgsLdVL0MCehorlGCLfRn7rypuaP1CK/zFmr0sqyjtGeqFvj/n?=
 =?us-ascii?Q?3/pAoQo4TCv/ew1HG/mT9+bA/WXz+2TLNpsqWMuuqZ1qBsT9vd2bxKMhEvQo?=
 =?us-ascii?Q?31QDvDwKgJckePALhu2+NHu1YVMxWCis7BASIGIWV1ppjlIZUuO6opiKqGER?=
 =?us-ascii?Q?2qkrIon3Tzd4/YKSTVCUt3BkTI6AVYSWU38NbuYucGVdgzuxMxAKdCwiI5EF?=
 =?us-ascii?Q?bijBdapyDJmnf4CfVldyW/XOQLUNP1tmrNxcVQnV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ebf41-ed30-430e-1e18-08db6b84776b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:49.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMDI7yTaIFOUx8ekromkjLL5vJWJALBZket+EHgzVyYkcgV5NX3PiLN3ZrR95Gsn+w+SrsktCjRyzHbv5sDDWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The enum edma_version, which defines v1, v2, and v3, is a software concept
used to distinguish IP differences. However, it is not aligned with the
chip reference manual. According to the 7ulp reference manual, it should
be edma2. In the future, there will be edma3, edma4, and edma5, which
could cause confusion. To avoid this confusion, remove the edma_version
and instead use drvdata->flags to distinguish the IP difference.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 47 ++++++++++++++---------------------
 drivers/dma/fsl-edma-common.h | 10 +++-----
 drivers/dma/fsl-edma-main.c   |  8 +++---
 drivers/dma/mcf-edma-main.c   |  2 +-
 4 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 10dcc1435d37..9948babcadf6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -47,7 +47,7 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
 		edma_writeb(fsl_chan->edma, ch, regs->serq);
 	} else {
@@ -64,7 +64,7 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, ch, regs->cerq);
 		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
 	} else {
@@ -120,7 +120,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (fsl_chan->edma->drvdata->version == v3)
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_CONFIG32)
 		mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
 	else
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
@@ -682,9 +682,8 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 }
 
 /*
- * On the 32 channels Vybrid/mpc577x edma version (here called "v1"),
- * register offsets are different compared to ColdFire mcf5441x 64 channels
- * edma (here called "v2").
+ * On the 32 channels Vybrid/mpc577x edma version, register offsets are
+ * different compared to ColdFire mcf5441x 64 channels edma.
  *
  * This function sets up register offsets as per proper declared version
  * so must be called in xxx_edma_probe() just after setting the
@@ -692,33 +691,25 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
  */
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 {
+	bool is64 = !!(edma->drvdata->flags & FSL_EDMA_DRV_EDMA64);
+
 	edma->regs.cr = edma->membase + EDMA_CR;
 	edma->regs.es = edma->membase + EDMA_ES;
 	edma->regs.erql = edma->membase + EDMA_ERQ;
 	edma->regs.eeil = edma->membase + EDMA_EEI;
 
-	edma->regs.serq = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SERQ : EDMA_SERQ);
-	edma->regs.cerq = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CERQ : EDMA_CERQ);
-	edma->regs.seei = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SEEI : EDMA_SEEI);
-	edma->regs.ceei = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CEEI : EDMA_CEEI);
-	edma->regs.cint = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CINT : EDMA_CINT);
-	edma->regs.cerr = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CERR : EDMA_CERR);
-	edma->regs.ssrt = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SSRT : EDMA_SSRT);
-	edma->regs.cdne = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CDNE : EDMA_CDNE);
-	edma->regs.intl = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_INTL : EDMA_INTR);
-	edma->regs.errl = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_ERRL : EDMA_ERR);
-
-	if (edma->drvdata->version == v2) {
+	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
+	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
+	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
+	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
+	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
+	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
+	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
+	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
+	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
+	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
+
+	if (is64) {
 		edma->regs.erqh = edma->membase + EDMA64_ERQH;
 		edma->regs.eeih = edma->membase + EDMA64_EEIH;
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index db137a8c558d..5f3fcb991b5e 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -138,16 +138,12 @@ struct fsl_edma_desc {
 	struct fsl_edma_sw_tcd		tcd[];
 };
 
-enum edma_version {
-	v1, /* 32ch, Vybrid, mpc57x, etc */
-	v2, /* 64ch Coldfire */
-	v3, /* 32ch, i.mx7ulp */
-};
-
 #define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
+#define FSL_EDMA_DRV_CONFIG32		BIT(2)
+#define FSL_EDMA_DRV_WRAP_IO		BIT(3)
+#define FSL_EDMA_DRV_EDMA64		BIT(4)
 struct fsl_edma_drvdata {
-	enum edma_version	version;
 	u32			dmamuxs;
 	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f5cf95d185f8..47bfef1c562c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -225,22 +225,20 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 }
 
 static struct fsl_edma_drvdata vf610_data = {
-	.version = v1,
 	.dmamuxs = DMAMUX_NR,
+	.flags = FSL_EDMA_DRV_WRAP_IO,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata ls1028a_data = {
-	.version = v1,
 	.dmamuxs = DMAMUX_NR,
-	.flags = FSL_EDMA_DRV_MUX_SWAP,
+	.flags = FSL_EDMA_DRV_MUX_SWAP | FSL_EDMA_DRV_WRAP_IO,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
-	.version = v3,
 	.dmamuxs = 1,
-	.flags = FSL_EDMA_DRV_HAS_DMACLK,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ebd8733f72ad..7b05e303ba51 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -172,7 +172,7 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
 }
 
 static struct fsl_edma_drvdata mcf_data = {
-	.version = v2,
+	.flags = FSL_EDMA_DRV_EDMA64,
 	.setup_irq = mcf_edma_irq_init,
 };
 
-- 
2.34.1

