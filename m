Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C453C6E78
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhGMK2o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:44 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:5319
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235595AbhGMK2n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbIT9zWX4fttyzNoPTf+ZHP5OapjmDaegm0t18vHIpi+7pqx7U4nzJ7foumX1FFQBKetQ/4wgbtWtn0ss0O5aeTPSTpDsT+VzrQvDdamO8piyVSUK7fofHRC4F7IsSdowvViIuRJD8H14EeoOqfuRRTwQ4+x4WYV0tAaXEqb3ZO+hXJfgrKEwdd5mQvJnblujXDC9+vPoqAVNav/CdLz6cCR2hnOWblSaMc2Pi6+TcbNxDBOLYBj5V6dY+LGh5rc6P46Ddt2UJGjIXZ4p6eyiTgnSSGuf9gMJ8fvmbEphPYXdn48gHv6yP03SQf1nIvPUZXrkpE79+WYrAMPUFKNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckDPSsFVzv3NWjjrNqcD68iD8bHaj5KBipoUq89jOm0=;
 b=LSxUMQSe3R1l+yFMw6sH6TD59pIVkjssnuUP4Sk2URKRUfKf71SW1UL98ad4DuqWG6UKJ7Nf0+r9IirX+wSDMWdTzunaqvcXl68hOGRKcV2mezHkX6AHjbUflbOK7gFaEYrv3S/5wmsfwBT+7KWP1a2ZoF9uitd9P2r/JrDYA1Ed4LyPjDrYGqiRbwTs/vQoVUszkhr86sG1P3R+06k3Ci000Hx80sOPbR4XpcGSNRC+5FwO7ZwOzYM0YRiP2vZ4hiPgklzdbITm5C0erXlbt8+j08dzjGzSDX6QbaB/ggy1mV83FRo3Xozp1bNa5L0qkXJURUfFBCt6C8v1T9QqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckDPSsFVzv3NWjjrNqcD68iD8bHaj5KBipoUq89jOm0=;
 b=dTA391NdtttNgWHjBsbqfyHffEqbSQGg1xCRsPJ+gQOjxTVgUK8M3gj1orrbZZHtFebFG4IKXiZZPXgC3gHlDymiqpafPyNO3eddgP14+2LGFJjHRg2v8EK+S6MONQTnKi/3WOpjCh6/EyknphvX0t/OGJ7GsDSeycslFmgHirs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:51 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:51 +0000
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
Subject: [PATCH v15 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Wed, 14 Jul 2021 02:41:41 +0800
Message-Id: <1626201709-19643-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0387ef-e881-4164-ed83-08d945e8969b
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB22889F3FC9F319EA881A81B889149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ez5Ef3PcwebbzjWH6MEjz8JzwouDTOjO7DxqfYgV6DuSncjSTbOHctjeiRjUCrwJ5pb6g4VDoWcjwyL64RUMycO3/MbaulnYnpZOKNly/HhVlDHZ+aUvQtpa5W9nF990kh3NC+ng3zMbY9n8JVlsEzZ/cV7gSsvb8AaEG8sahk7EVii6Jhx/aSu/hl9Q5IcUuHXAdtngJezgE4lnAp4JsbeGvMLwAA+7VgsV+cvMfGEcREEUIbsEQBdRaFVn1iNAoizJSPqvf59XQf/h1RguN9UP4a63GP43I/4VUi9SIGdAlWTWgMEei2s1wjrWVZifR1drl9tytLX+RC3WCUXrdXdO6CUDbbwAQLMy7ecK7TqaatvX6DrIJMGhPJ5ougLFDye5BF1qKDfsiQxKHhsZAaNegOumgdOpWT9cWn+qtiKZ9rIByKthZn2wyAmlf6q16rGrA7u+D9holgpsspy+eXtb99iG7DnSx3aFt7SWXWWsEAshCrXbv6t8ObP50FcBr4tMFFDbcLJSI8reE4x1krSw9tnvNIVsUKpYQlYk1xKluGmYu+hvooCoCoMR/SxLcZN1/9G2XkYimfcT0/VFYZtHbssth5OB8jWtvRe0wi42MbaGcKocm8XcAHH8NhPafTO8waeyiqTCdHNUxeRdnH1PGA0CiqBn9oam8gIXgQNXITkUyHmcLvrKYFXc18Zp+OZEIuZ7SFExTtjDj+O21Re1RW8/qgQ5Pe2NccIxHWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzdLGHxl8pTxshZ3vTH8pbs4pqh4Ffhhkv3IFrYZHltFXWcrgYNmiJndiszr?=
 =?us-ascii?Q?tiRpivC38pUWUPaZYrXnj+53FN7/ibFgXYXZHWXChxum5YpqDXuBDJbVvFxT?=
 =?us-ascii?Q?rALPpwl2fDar7lbx9c5Y8FJnoltsiQrHcD7tjABAwEwTJXd9vWBMTfVtiRPA?=
 =?us-ascii?Q?6yBHjCsLd8hv3cAPL0mQerSzOnZXEYoJltbSGyPwWnAPjXMYPkdMPe0zpt08?=
 =?us-ascii?Q?iVumLltxmZxGgUviAyHNxd3ULwE+GWytq0AYY2IFscE1oZMi3Kal7q3V4AC2?=
 =?us-ascii?Q?Q54t+qSopjxfQFSnEtCRmsbxhIhGjV4Ee4HCuovXrhBOjgEVVXNbvXTDOKi5?=
 =?us-ascii?Q?sMMYIPevNMG9C+WTZSwXK4kHqGghjzpaR/c+F2WbDqeSwBFpoITnVEQmU9k6?=
 =?us-ascii?Q?mC55sy52nVJmKGQrmAn8PKKEvd3DWLWtd47BjDIsV8M99S6VDr6NhAxdCJYs?=
 =?us-ascii?Q?cq1r3Ogj8nDt7xdVQhTPpjZH7/is6sWsAggSWBNEFY5ez4BDsS4MJGkl/EFI?=
 =?us-ascii?Q?EV6z7yD/mlWULJ9/nQnM9J+OmAGA1MUQ1V+WNRuvl9uvUTKermQpjvu9bPca?=
 =?us-ascii?Q?NWQrcH+a1InJmw3phlXVrZCOJ2d6R+VNu0Lnj6AIZKvCuLWRp7siiOkyMCAq?=
 =?us-ascii?Q?JYkYX5Fqw+B2621q4+zEyKe4tvyepxS9cHHEMVu+fdl3LabIOo8h4cQjLXcJ?=
 =?us-ascii?Q?KxofP8Tqw8UuorKmm2JQVkRyLxM7CJLJR2iBU8WH/3P7sJBYwTZjKJ4Zz1xV?=
 =?us-ascii?Q?GekyErC79P19/u2Y54ETWsxkXzf3YxBnKNS9vd1nVbFBKeyBDyG/FR0DXDl+?=
 =?us-ascii?Q?n+a7uTxbDXpkIZ97a7mnh4RT1y356/ediOquHo9TjrMGZYNfMDJRodDQacvb?=
 =?us-ascii?Q?YJOpm2D4FHiGyBz4vpefdEkOyvelKJ0W1dI1OhKc6asy70PVnfgawIJhfabi?=
 =?us-ascii?Q?wDaPqsCs/7ppHdHAxFoEkl/6ZtKOxLhhWylb8oReioPjt7IsOXReuKKhf0kK?=
 =?us-ascii?Q?DVHki8ldLgsgzUKWsXnkZSxwNOwrZYqf4rcXX8JFv89CeY/YNkQOxAgpXrv6?=
 =?us-ascii?Q?zXQXf9ijg+gBD4xIx3VJ4EwmM2+Km91for9xyvLZ8xb71u+3o4KxB37whHIn?=
 =?us-ascii?Q?lCHdalNt5Ba0JUJQdlrDBVwKIK8xwU2MSkZpCK0JZzZa+e3dd4yY5is4tOUO?=
 =?us-ascii?Q?pTyK/gOD4zbmDzAWDtw0ANCrHQzg2A0A4CXj2KK4KydzHV5SadWCX9aLhoO2?=
 =?us-ascii?Q?XQl5Xs33n8PX0YPQJaov2aevK5oukLkmjqYbNAo/zNOMDZiA9JdiprpA36VM?=
 =?us-ascii?Q?ACxzdD2KhSGCs4/vByKmrK58?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0387ef-e881-4164-ed83-08d945e8969b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:51.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHz4o1ERHJexjpu+avagBUAVQx9VCHNOiRWSk2jES6ej84Z3YY0VHjVHGktHFeyOKpEJcnAaQcJTWTDshnxW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e510df0..665ccbf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1161,7 +1161,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1201,9 +1200,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

