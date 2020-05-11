Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43F31CD51C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgEKJdN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:33:13 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:25615
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbgEKJdM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUe4h8jb4mlTBoBWfvkHIVG6uukxOlbGgg5pziXUOy/e9giTFumemSIM/bNhhtTzyx52mDjoc79OJI3diliRFIJLASYonhS8h0BT2zOgSM5O1S5C16qNs4H5tzOFaIYjiZlESehE/Qbboz2elVYsX0wcUXkOhngKEbGWk99oNVF7+AFCyfmPenbVN7o4sYThrHUjqD//Hq8N+hcJhydpaEUWRFk89grQ51w79bztGOYBYxcYPIcs0GxW23qhiuqwDkBjh2kGLRFC+Eb5utG3ng5MiFYEyDe9QU9nLD9BDOkcI4KjJIp9++bSgXZomVxOcXI+w+TI/JquFVJlLsnejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=Dr6Ei1i3YJW53NQK/Zxc9pbm2UKMAyoPxP8UIWmFUkMEMibrO/uzK4hrAZjHYOedPfJcpMF+YVJmEYYEcferum+lf9nXm34cIvlbrRmf+5cescjPSUnexlN3fc/gAFc/euayzFiJzVD8UjPY2wadS22Xrm3wSMDzMflaX7Hm4MJpMdH8lx1wIs8QyQjzPVyHRnGTda6BZhV9143wMeKKsYlz9hp1iFoLvHIQrOSJLomY8rmlzeqduE4cAbFP70QhhWCZCqgZyfdAbzsQlWPBoZ3da4WjOZKZ3zernQaEw6wPRhG2JC4QqKOdy9fYWg/kpvhx/XnG304DjRrOHuw6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=DdwExHroUUn4/ECM9AGoyvnyfQsr2/X89oS0JSai9kTV1A9jHK2fagmKCU1b92muul9WdT8OG41HifvH9JOaYEvtBjW4IW7Bhd4pHZAWC1fTZNybl7011Z65vRwdWVuDs4uqKgDUyRQByTOd+g6nSsNnQwL81/apHot2uS+SqCE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:33:08 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:33:08 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 09/13] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Tue, 12 May 2020 01:32:32 +0800
Message-Id: <1589218356-17475-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:33:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dfb31ab-c213-4c48-138c-08d7f58e5046
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66373E2F5D22CEE902A9DF0089A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1hlF/VuvGy7erhmQ2HiDqqqE+1VOUGVqhfxrrP5FWYjOzEKAb+kwmKhB1hbakAoiO7z5e44AE38YLHsZwIV2Q5YKEe5IA7sFqdR/qzTmr0oWPNozFBL4PaekuDOlQOCcNMF8r9quEHZR245LF8WZk4MfiwQmcfpo7J8K5HofFQ0tflj46Ckr1MsWMD3I6VgDUQ5+sRwbO4HXf3+QxQ3Y+CRHxURkClUQ9D69f+mAUHblzrHfC61++kZB64w6k8+c9WTdc97GkDDiQOPpmpWn3gUpgxdcmnKzKY5mSS0OPSZfCNBMfpRyjky3Xhy8+FS44imzL0VRkfyl7tGc+m4n1ttjkqWxfsrh1ZS0BwU8qD5L8uL7ZCN1ZMVXAFroSqyXg8kQfgabFtd1a+2dJtdOhMVupugTg4DvFv6tuAx3ggUrl9xxsqfotY5roVesKcv0xvcDk7Wpg8JTRcN5371Qm9Y4ZBtw6cEANvtoWCTI6QF7oW1lRU73x1uY9lL8fKCDEE0R3IFPAzA9LUZyh6mIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(66946007)(66556008)(478600001)(86362001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: t4Aje8EXEeUbFm7IukMZVnqPGhal59RwhDd3whRFEwCkC3Kpb4K//pnvsXM52qxyf2fvIBkvPZHGr1My3LxaKiLhvxcNEmRYcwWq8QsC7ycv1Z3MOcdExtx/OBv7nXHc05hberLxTjtZAhlkKC0Mld82rPVRCAPBtCxPbtmR9cTE6QBwzUq8x9E5cOXg5ZtNUEMK855ScwMrOUACZpcvo/TbkpiO4SSXe2fkLNcyWiVqUMDUIWmpnTBB3t4aOhrJzrULQZ6tOXlS8kYmnU0h/RcxfMpOnvCfO/Wie/lFHS+BpzVQxNPUhQjTo4/Ol7No4eyx18OEE45pUWdAQqsi+rezHOb66VSKkx03YWweHWSx8PYYA0ayf99sEheP/8SYE2JeWaxh0Y6Xj8LXx78LaVQf6TqXYhDE5AZkuWN8Ka/DwTnHc0OmKt0mL6rXqIMRKWxax1lOybZt9aN6xyLHZefhlqNGJkqG7EHawKKoKOY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb31ab-c213-4c48-138c-08d7f58e5046
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:33:08.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F++7PwSzV+tFowILnxoF6iagp12PdNHLbeSzDHnfSRnNQRvP78lKrbR10im7zSvYS23indmeb11W6ClpQse5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 33bc58f..0a529ba 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,6 +10,7 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
+  - "fsl,imx6ul-ecspi" for SPI compatible with the one integrated on i.MX6UL and later Soc
   - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
   - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
   - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
-- 
2.7.4

