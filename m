Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C31356501
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349387AbhDGHQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:44 -0400
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:23958
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346476AbhDGHQm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f58vv7xZzNFKT26mudm7isPXstPN+Dt4SdMgL93LqNkWNKtf97tYxnhGah9vKWEprhfO+jcI2H8wfnXTwoeg0DttoCRxdygOzse7BjtQn+ol6oZmS8OMpau7l9tPW4Iq/OxxDC8ftqn79ZWz6iFHH5ypKMD/3b3EsU89qM2ydKv2Vj8UU7fXdHD2+NSTOs/t5EgtDYXdWW/H8Qum57hlhuycEIGKLriBkurLupw7kYMsmvPU2oR2ErPjua/5XcLddFalhiZ3HBB9V1Gje55J2wSeIijEfUHP1S/i8xT2fZ1945xD7qQNh/flE0ZS6J3Eo1Etz3MKCf9M+Y7tfxo+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiLrrVV2i4glZvF0Sv8xK+s2y7uQfS+YPmBYdyvVALM=;
 b=mkbCNSSUwHizQS7WVqk6ERk0kCdvfrqSGuY2cDGkzUzLFJSIR+/OeGKaLbV3Q8B7DNFKxge2aIjx1BGwmnbePb7DzXGF0YT9OjcPxMVId9kq5s5aqniK4QvyB/q5DC6r1YTYAYPInRUQPX/zdJ3YPwu1hSGt8jiyVIxBPGnQvwFDYMFDUP+O/TuDRy40evQLjmNBkGwPHdkT0CFL97V3ceYv4W0hQK1R/YRdgbb7Asrs/5T8Hv+ZzfJYoPgc6XEFrOJOSPWZGNPo6Cnwi4z6tXfpd2df0ExSBd4lWKKDHDNeT8EdK/rLEHK03CwxfyH/Sx6eRKoqPu4Yv5Wzby3wMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiLrrVV2i4glZvF0Sv8xK+s2y7uQfS+YPmBYdyvVALM=;
 b=UwJu9zo7+M5mIPaOeZycqKzmm57+zAY+lKmU8Q7gnJaqwQkx0I8m8Ttq+vU7r9u9T46gDqTCP6bCQa/ybWNzXHksryDPV0BuR1KEUEMPNyNDMWymRqs/dGWglzdCSDpgJTX9ar1FDpGi6mHJqLMbaPr7zm83Qc/WdlnvzfVesr4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:30 +0000
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
Subject: [PATCH v14 09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Wed,  7 Apr 2021 23:30:53 +0800
Message-Id: <1617809456-17693-10-git-send-email-yibin.gong@nxp.com>
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
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ff1786a-b380-4467-aefb-08d8f99510bb
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65090373C9FDC2EBB3DD385A89759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmTwzZSKunf3M/NsWvFAq/spjrzvR9FCHM7MJ1JKJ4pGi2WEeADAbC7Uj3HfFyuFZXoYlwPWKk6jM99mXYTjHvMD+6NUmdEZN7rs8mNOi/e+GezaPyks9F3DZBsnEnpVCDOdU8uRQe2MmUhmq3fsoTm4mH/D1KS+KchEu9VeVc2YLvHISgP5rirlsCqLrGthsd83yLkrsfnd8t2d7DZZOrSr/1Ycd4Zui1oUpwzl7HzUZFS88NdqQThv0+UVWCq80sqD9v5k5ojS5raGkzGfnQO40iTkjONQSn3XI4KCtDwa0tkOtsX+8Nz3qveuUoP2ER1TvYstaNEJI/ICvVFCHQKG11qRLtCpIC8WqV4hc+CzjiDEDbgyHw6S33ECkqZV+ko6ddnzfdKa4v1rMhu3WrEglSa/GN92cBdQqX+GPVeWRtTlF1xS1Nyz+4gnw+QzUIIyoJycQUR8V4+9eMSAZT1YwA2+JtoSavPzSKvUYwJrzSTDypFdKqKmLBWZ1uPo24/D5iGL60O+EJnEeeiIXqxgfFfnq95JtN9hP6HKenpTMCyQL1TuOxE5GTmj6EcvsdVB8BJKJLYhtCxiKOAVViGH6zBgVBWfP3hEtYgVG2bVd/pfarOMxoz5PkWOtDW8FRkj3owqYq1nuq7QJNAUO7nj0K73aNT7/b3BCFg81NwlnG2jSodlZCdBp0NaeNA91OSFwUUua69L3ckhQDk9hPxxhZya6TA4oQwjep5xM/eDPsK8FGEdIgW7akbGyLmvxsDZ06fZ2aZNhG8Vlc8RNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(966005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S4J2LMeh3JDaZ0QYRbKzOlLBhDkGPN4WqNaKbhXz44U5w29lvyi3m+uvVRsg?=
 =?us-ascii?Q?aIHrY7VpTqbxS3XR8HohBh67YJQU0UG1XuQ86dQ+YcZCk1AUboM2b2tCWNGE?=
 =?us-ascii?Q?safq9JzXbAkJB3F6Cojv16yIuj53hYZm27z8u38vDROc9X5il/Q8I4Hn/KTF?=
 =?us-ascii?Q?8k/zQGmKIuwM/rzDSFhWwYUOJaPs3IfZbMqEFlkbAZMx2uOAgmxngJ2mjq6I?=
 =?us-ascii?Q?iLE//lZRC4qHDKKuWIdjALwmAcc9JRKHHyby5xjxmhuV0tkK1z4piC4tgS20?=
 =?us-ascii?Q?1vMFFFo9nDEoRZg5KFxiQjbNyf+GYd1ZLvkvl4eDWLAAZNKlCRsBVbCj0XmI?=
 =?us-ascii?Q?BXUb4J/RoXq7bTnt4OwV2SDqoPeZpfaxVOeg5nuI7pvINp3bhBFgMWFfqs0w?=
 =?us-ascii?Q?R8FY6cAI18cpue2apO9ENFEqGo3dZ7RFu/lB7PHjoT2YW6l+riwCDAw5Ij+R?=
 =?us-ascii?Q?9nfKnO/yjD68ZsetcAIIY+78Y38i2esQ0qgf8i6P6dZTXBrSMsGJw0JjH6Li?=
 =?us-ascii?Q?Q78LT4lxoyU02SU+J6by2u+9hJ1jvsUJVUiy3Q3iqvZzgMjBf6kOyVF2FnAC?=
 =?us-ascii?Q?g9Q/Nf71UMQ4uzeiUjUKrOtjb2dpLCSQfUrRvF0YtYtsTElxtF1GenSiFAMe?=
 =?us-ascii?Q?GtemPFIcl++v1La6rBLcSRHWq+UdeDHipStfqW+um441WK6RxyDG1ZBDJZG5?=
 =?us-ascii?Q?jlN4diEiIZ/m3pUatP+lg8ZDHvx+CD1JzAS/JjvnRAeMyxBUZIoU/glPqAym?=
 =?us-ascii?Q?L0vSPf6khLv1A+6kWnFvrabes3D23+CKfr0a6cfbkucJRee8/20BJmu9f0Fb?=
 =?us-ascii?Q?0advJivbxTefZuQ6c0xlZmMFsl3KGFcpeO9O3flE4anWwqonm0rbl8KGdAXR?=
 =?us-ascii?Q?z7B2uT9Tqjy8JkbyhJe8ZIDuVJifh7my/i6I3dLYt+YdyyG7sOLmkkNqkW15?=
 =?us-ascii?Q?hcw8/3RRQEa1D5Sxfb8IBBIYowwXxZ7j7B8orK7jQVkyUL7eR9gcTkK+kSia?=
 =?us-ascii?Q?wy/epirn0njAhiKEG+y23N+gHBxVxgwqjPs0A0tjPRDNujCsVIZguZrFuRDL?=
 =?us-ascii?Q?w/SZqwNx/maD4Cie488t144Z+Tepd4SyJGxWLIub1hfw+MzGxd4g8lDrrxHo?=
 =?us-ascii?Q?cTIhwkp0pgkXsKuKLbYqZyIWlo6LN+E+1DYISaqnu/ScAJ/e/lPBv+qGHVUm?=
 =?us-ascii?Q?OZ0XbTzFm7AbcAaEns6bv0Hy8K6epO7dWXRADkSne/JivXdj1k7rWOzO92Lx?=
 =?us-ascii?Q?yvqd2sXk36vf+zTuPDrc8lCI187ozT9sox9zGFYw2OdPyJ//QRglnE5JS/80?=
 =?us-ascii?Q?Kz9IYlWJs26HnCjyiD2yJ9BH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff1786a-b380-4467-aefb-08d8f99510bb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:30.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1lpTYRBkPYJ2GeZ2wLSTPXqxvGrl31hK1YSPOn8mEi4OqflBrrIuBMDL5PnLIAwkSj+j82FzyWGPq3CDV1Xmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 86bd383..af85116 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -422,6 +422,13 @@ struct sdma_driver_data {
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
 	bool check_ratio;
+	/*
+	 * ecspi ERR009165 fixed should be done in sdma script
+	 * and it has been fixed in soc from i.mx6ul.
+	 * please get more information from the below link:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool ecspi_fixed;
 };
 
 struct sdma_engine {
@@ -542,6 +549,13 @@ static struct sdma_driver_data sdma_imx6q = {
 	.script_addrs = &sdma_script_imx6q,
 };
 
+static struct sdma_driver_data sdma_imx6ul = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6q,
+	.ecspi_fixed = true,
+};
+
 static struct sdma_script_start_addrs sdma_script_imx7d = {
 	.ap_2_ap_addr = 644,
 	.uart_2_mcu_addr = 819,
@@ -575,6 +589,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1144,8 +1159,17 @@ static int sdma_config_channel(struct dma_chan *chan)
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
-		} else
+		} else {
+			/*
+			 * ERR009165 fixed from i.mx6ul, no errata need,
+			 * set bit31 to let sdma script skip the errata.
+			 */
+			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
+			    sdmac->direction == DMA_MEM_TO_DEV &&
+			    sdmac->sdma->drvdata->ecspi_fixed)
+				__set_bit(31, &sdmac->watermark_level);
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
+		}
 
 		/* Address */
 		sdmac->shp_addr = sdmac->per_address;
-- 
2.7.4

