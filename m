Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC23C7B70
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGNCIa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:30 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:59539
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237356AbhGNCI2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1Y1alP8u7lw7CE8hMFhjXAc5b6nZ8gSty8mBeaVo3w4Opu463XBrQecqCLxgsLBqsqnHrU5YoyPrPxpWRHKKeESOG6ORs3HEvUDbTsUibQOrKjii3ik5DeuzbUdpVMu0jw5W0tl9MP8ZAlsdJn4cShrSYlXP4mnKo8sRyyqerbbhrl747dADC9MR775aHkxkBHcgZ/tIlJBg/BXPyTO8xEF8H5n+0oYFOzLfhYGNSK5Xz4D9KJUQcQ07hUSz8KPUwaJS0P3S6xMNA85Qc0/omxigQG7aoztMXH3C+Umxc/uKvQUhK3Ufl45lWlK1xU0XRkOcJ9LpNqFcUV2KhsAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=GZnwcZQRBZSnxkqfttz6hjAnW/9fPkvAVKCN007qupy8eAN6kVSiqlsH+CI1kw818a2fjQi4HETrpYrNTCoNhxtGxffstfmEPSSJ96js2Nj8R+zOmJw046evYAiUhHesuCPgyErKrZVMYID0lCOFzc4XWBJLt+3UtvOpmvJOQkUZ+u6rvJuoP6vLL0h/qeG3vZEEQ1VuR7uswnqe74TqlULFoXYHztY4oF5wqGnqdvl6946PdnuTV5Y3lM4FYvGCHzJEjEtbFkt3MYMCfFNF5evRTC2yEHeVlFI4xwpqYEpVNLMTTik8Kmj8O4iP3umEh82azrQ3oL+rsappvyuxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=c5GJNGuJhm9Fp1laxHoTi6MpFqKdxhsUZfV0iq/bD76A1MDvP6x13P8wH0+2xuQAq5qWcAlGhZyNOJX0dJnyyO0a6dR7QflMdmMRPEoO/6F3lcZMFfYtVUzLEvhkkHc8gBJULSNyQnSt7+zSW2bfJWF3I1riYPOX7NRk3joh7VA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:35 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:35 +0000
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
Subject: [PATCH v16 10/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Wed, 14 Jul 2021 18:20:50 +0800
Message-Id: <1626258052-22198-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a6d183e-0698-48b4-aba2-08d9466bde16
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175622015D99EE632CC792789139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0k/axdldK3Cjby3OQ0t8+EgXopMYKRA10rKe17p1aUZo2pvhvH5tSVabBEAauBwI7INFDtECN3b2OTyPzD9nLJzAvGVv7gGdt/Xj8pkfLkQtYFACA/2P1OTjSqgbqaAJej8GJrlx8BpG5NmIrtEvy2WWTRtK3FbPTozAaV+T3Fx+rcqCkCcEtLPrDbB7dlHEMIrTpedZVCaWDw8UGSCi0Ni/UeNqsMnhQpkYwxIWOlAXpgM9Qb7oXp7B0Has4YVjxrcyiMZ04ubdTed88B8v6xXfp0u4eYy09fc6MNTeMjFQoz75ouOdXozC7uan8qF5AZj7K5XRl0S9hvl5oZ+OzzPklzPawj923QwfUMOfdKqosRcywG2nDvNrHzXXTr+No64RqHSax6j4ubF+oM6qJ+AxJL/hGEZxCcx81KO0tin6eHiHwxZK0BCQ5aAYxjdPS6UjrKBK04JLZ0AXbZhlWGL839iZMGDtHPpkK/VZ1WcqaI+DvITgsMBIApx5ehNjn3DW7DqaBUem17eb2ivyT5lAAS8/e7dVjssWQ1xPZg9Lfk+nAELGYuxQ1CBVlDvg838stvookj+bcPtddd4vxkGvautcg0w9ZiIOm0VHa/We0Uzrxh+mmzEnu/S+4Z06abpNuhcELPpJ5AHP/lXWIl2A14TE1SLi2ZT5oIo8ERUnrS9jK3idEpuSehCfjP607eArexEYrHQ/DOIv4gmvOwHNR8n24oa6q9azutgd2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyoZf19gdLDYraHDNA2HIuncYMSWzE/FG/R06BIM0+Lewp8frLua4RvAw/Dn?=
 =?us-ascii?Q?osWk/x5nw2xV7qgYmu5Bhjr3QxYt2Au1c2Z3YIUtWNtp2r0ZusTcmxal1rs0?=
 =?us-ascii?Q?L7Va55j1c5xymjAXqcFKxwrm/6yW+yZsjQ7Zf+dAvTgfT4EvxId68fAkfhUP?=
 =?us-ascii?Q?K1Tp/yQA9QXj/6+Rq4xPPkCYNlTkDY1ZXwxdL0u4WC6YRIwh9Zr19hh5GjBZ?=
 =?us-ascii?Q?H45j+9xdldm6UFTTIzDKz+WsaVhg87/Nbd5mWlKgJscL1jtu2+4IxB55KRe1?=
 =?us-ascii?Q?dQaey3WC4LMvuBhnr9TJBdgFkUQRSFioGq1chnWNgQFRAXUjr7cDwbmtyXG+?=
 =?us-ascii?Q?Yv5Jts30+fM331OQNkdmN/nVw1lyUnkqecUg1TFOji42jGc4oND/bpNN4YUy?=
 =?us-ascii?Q?1XBLUjbaxMJYWNP2SEWzYn4o5/9QimvTFcmgNiSE6Gca3mWgkG0VO1vStzg6?=
 =?us-ascii?Q?EAEgOq9b+jWZn7I58mQlhZ8i5x1ApyW4OX/q8UBSUx2eTKTTWwZos92Gnb06?=
 =?us-ascii?Q?M0HADf6RZAQPLOzdVbsVd6hYborunNUk2GJ352GA9OwDGIol8Qpc1cj5c0P1?=
 =?us-ascii?Q?Zmj817bXmyFIboXqtWuQBgch6u264o38n76/TBSiOT3YnEFa6ddM9PMMGbhc?=
 =?us-ascii?Q?0jJSG5aRNCSTCBK+PChp2bcH0Y01G0fssNMrUiZd0DIZ4KVyn/G1Q99NXv79?=
 =?us-ascii?Q?0FRRcO1z9ahFUwzw1osk7ZZM7AbMhTfqHVcL3md1FsVNDm/+Fm9JbH1Q0gR/?=
 =?us-ascii?Q?ioOV8plaAMLHtrR6jLboM+Q/qCQyI5LNab2Dge4F809sv3fLxE/YAoS4npCa?=
 =?us-ascii?Q?R3t4aL0twetTLRAvVslPXBRzqMwOmlv6wnpvG2HVkVlN4n3y5LxfUfbSBgMg?=
 =?us-ascii?Q?b+Qy8U0rgt0NV3hec06nKIuBDjmUaKCUK75RrLUBQfvMHKfYmgzHArWrq9WA?=
 =?us-ascii?Q?GVqZYo6x2j3HCJdkVPyoX6LgnvKbtu9tsC8RpccT01Fl9Jylj4Ws+89EWVqv?=
 =?us-ascii?Q?bQrWnG0EX9XzptaWN1c1komrKFQdHSpFWg0kIhiqfg1TJxPYZ5TOCo+f9DMz?=
 =?us-ascii?Q?m7Ma5zx6u7rT6rwKBPGr8a84zj91yIqyVJWNLsgHNMU8gc7hDauuff1QIyc7?=
 =?us-ascii?Q?/tMuJS62lY7qFBAExsjcTX3LmXbtD0OBfpjCOzsm62LTorUx86Bfn0gBqHnL?=
 =?us-ascii?Q?bTxlADpu1Ju17Pqrv74tsmvDNhDo1gXULhtmrwkxZntibflRSUZnMeuS2qnC?=
 =?us-ascii?Q?9s1tQa3etsnk0h2x6/kYdn/Wj36H9T4mQN9+855mAqhAgXdKw5zsZbL2UJqD?=
 =?us-ascii?Q?590pLlqqW8d0noNNkBnNv6B+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d183e-0698-48b4-aba2-08d9466bde16
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:35.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySJWx5dZeFD5GQqS1gyU71euIubsian3+pIpUIT1x2NSurA1u4IFNuLfJ5us03aX0SdhPa4OJRDCjPH2M6Z5Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..12c316f 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

