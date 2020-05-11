Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51F41CD50B
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgEKJc4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:32:56 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:23550
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbgEKJcz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:32:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwlSZMU+o9EzMPl7UdP+UuIrp9qYmUcLUuOHlrqzyqs4IEVk3VYsP+QhUQLKgGn8loUkNVBJ8dkQdDVYGmstZkvp1DXcKdxLWoVE80EzxBoEzX6Gi5/5l5ikOjpcteVWBmr221D/K9tMjVtO3oBt2fRkv7OQNw0g5S+puPOwaPDSNk0K3ZS8YSnVjZs2T/46ssG51TR6mbK0bcxQra9FQbstKP8LCs/RSs5iIaYyrp0vBMRdOapxX4VweLUt1Z+MA4walJe3+bywJK2DHZSqa6lnNooXP+Pxv2m97dLuewKQkxj3W6U15ZpJcrAloX0q7O5QNLPDOMSDMyYetC1P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZVGY7HSfJlKI0KpbP6KFaPYGNl35gy4W2Hb3NamZjY=;
 b=enjz+HI7cheetYXI8W9oMyVWbw8dRlU/WreGeSIZ9xL1WdNeqqnupPwtYy55mYo862uJj5YYXlf8zGQufky1idTQ9r7cXoEOvp08/3NZmg5OdVW0GeoWggWBQz2Wt1lC2kIqRtDTcOoN8JW2sI2SHSmV5YXMZEOlSbInUuXN5b4nJsCNwaqyTiihjSyhCUWbpuXU0WT2nVOx/62AKdhqfmnF4QB48RE0uRLzp5gy/VADFieM/uGcENQi+OeW5A81QQf9r5ZtlqoFhJMFwN2GGhBiG00Vnz+0o2kl7rIoRqt8jQc41GlKPgIFQvTlMU4DL9lTAhkwFZeiILefzbFdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZVGY7HSfJlKI0KpbP6KFaPYGNl35gy4W2Hb3NamZjY=;
 b=XgolxBPHL1W3fk4J4CWTu6uDpoBOJK0m35Cbp3RcndredJdcoHPGfqcSWkfjDPX4wo2OCP15sfDXOQWtIDaAdpINekk4RnVb5ZSFkXBFXCWPX8gEdQ1OoA7gragbh8PYDS761G/nhzRQ2i+xkbUOqlAmbsy7E01LXTNzNze4SlI=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:32:51 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:32:51 +0000
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
Subject: [PATCH v7 RESEND 06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Tue, 12 May 2020 01:32:29 +0800
Message-Id: <1589218356-17475-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:32:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8270c7c9-7e49-466a-6e3a-08d7f58e4696
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6637526D1D446EBBFA7BE0A789A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NzsFOG296kQ1RCxW79YVHpchPhy7Kkwb0D8meld8scRUDb8FHM87cbUJ5KdxtNz4Zt+vH3v9+Mk5UX18hcle3tIBRXHi9F9c8UIIdojnfaGT3gwLLe4HQs5tzi+euKZS4HCM9EjHA62B2kc4foCJBcNmdteRDRpNszzNvSAm5rhKdxhgZdeEfIVovYAyhnCzyDoakrAp2U34Gtthv3DmuwtC3ncyYnaFdxJFlD77V9lbWfSJacxqq9ep/PPJMZHLERmkrXK4dYIMJSvO4V6dMd0q+Ch8ySSWxJeu3Gw7QgXt5DOd/ed2jCJw4Ozu9fxgkLsPqSN/2FyBvzBHvjUN5YMkrfRVgCRnDHjdntGUI7+uEUrsK5s6yHdG1RxnL3jRfWMj6pdYdqxied6UZVKpPog6l039rJ+jLJafcUX2WrV7o3oFPtDa6zOrk4yx4Rb7/kUBkmZKaaz1NuZ+JxSdBCxvjLWndjwllhheTkHN6n+phgDA7B0iWR1iKpdQ4kfB76Mr992XCoYjFKCVKB5yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(4744005)(66946007)(66556008)(478600001)(86362001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5mW/A4pqNddUB6r/dhf6OaLp0i6qRV/hJzybr/M+YTH0dv1UJF9OplBA/cf00uYZKC1rLZjM7/QaGNRTSjX1I3yHUo/SLIFq6nGJUu0inASPeBrzFImLhu/t7lm7uNPOAPmmDcQCKOt/Q+LcPpa8lzSiospuBnbPftnfG2eq0qb+aDXE78yzFE7BbtRrYOS0P3ymxgu3hdtWkKB47TU4HMJxkE6GDMFzdYTHFG2XnUuLF/rSox+HhA7deoNOi7qScPA1hT/KRRKnHCCGaT1I3BUqSWgSGslg4HjgGIkVe7yO/is5ow2PuK2ThBu3v2afgXpYcHQayQudpjC+mwMHxNDP54uiQo45hT3THcmPsLLWDBRKR+T6Vwv8YpZw5IMj+Rk4COJUuHYtcxjlPY6x/0zkX45ZSrbKc9r2M+q9TuCuMTqv6TluHl1LV3GO8aT25cyJuIkcmRF/cpSFrKyfKKbFaHpaL9GEIia3X5WjpWQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8270c7c9-7e49-466a-6e3a-08d7f58e4696
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:32:51.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeD863tDW7rrcHXe+KL9/RteiZdQeikgIB1gsYZBv8/w16XwqKtYgsx0a9COJIPCtOPk+uNqpRsm5ReWYtwLQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 69ea44d..e034375 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -920,6 +920,9 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

