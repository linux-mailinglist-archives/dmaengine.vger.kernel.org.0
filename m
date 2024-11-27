Return-Path: <dmaengine+bounces-3800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F39DA014
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33C52835D5
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A964A23;
	Wed, 27 Nov 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GkgwajH/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011018.outbound.protection.outlook.com [40.107.74.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656B208A5;
	Wed, 27 Nov 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668138; cv=fail; b=X6dUgLZ4iY+BvuPxh79OCNtwF+8N/EkTU/sSCBjQ3QtECDwxRD2khDthRDVqCwCAhT21Vobwi08K6M3sk/79sf2K1SvkdRX/Zk6hPzOY5ScYb9huXTSlLxOGbH+jgg/tg7rAI/gp1vKoMiyTILpDc/eCnIrHYZVa83iRigH/rXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668138; c=relaxed/simple;
	bh=2H/Jg8y01qFAi1Ca/C4FjmbpoRRtGw6pCUguVpvswUY=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:Date:MIME-Version; b=PIk7qu4iZRHrzBKxmIHQPlILQ56oMJCXx+CqelVPZu5Z7YBobflIK37Wj+dX+9P2x7PGMA5OF3RRc2lw8mHTAE6gpX4X2MN8VSVCrpbBsh6bH83VvuLkyq/w/al3/NRWnXHRudiWupSZstemhztXo1+d1Xl68VMt/1dlDqHerAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GkgwajH/; arc=fail smtp.client-ip=40.107.74.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQiZK5lsDebkFmBFvJ0so3Ci9KBzZ0HegBjmAMDAd/YItdrEttmUG+qO6/e1pOeGFEK8o9hs/qDwEBp7lgzO+3uuedTV5PJBiM9X4NHBJ/Cka6Wk9cmvCCy45vAoFsNyMhY6BEz1r1x57/nKv8Z2PW5RAr8I38zpSF5sCVIEDqG8FGVCJGNssheQ+9QR45kwDf4MC0DFpz6tcylMOCY9Bov/wEiVaeElyboziasvHqcj1BOBNAFrEG9hWFmAJ3nsbgXa6pxyYX1tZu/s76NV+b0tWG0MTN/Fva9xHczQgBacVUKsjA+jtHJJZZX1RDR4W3fN2MeRLfYQRF15hDMpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA1Cn8qu7cP9WlTueUMDfPwoum4a9O9NH05B0Gs3ddI=;
 b=QVGPHRtF9J3aRdtmyPSCqc2HEEL8yKZtpl1NbvsN1Q90ags6tDwyTl9pN/95vXxk+dAin083EGCxsrGURQz/wG6iiCKrjWGnBoe9SLrXZZR6QHbfhuWgmuhWD1Qy8hvruTex8UpMVmGEUUJF3wUqEqK2kZ6/okjuvaOAEl57PZXkgKMw6adALuLH+3fUonXSxCSUY68IKH9VPq1oCCH8oXEs6qHfZGlkHrQc1kTg8V3f5yeRbn+9V4dckb/Ppmn3ZE0HEJgiA21mmeFdCHHw4QslKUjESdG/pSmjeJxDOPycBJ7hXBva/oXpXfxt4EZNnKazN7vOMg1TC4h6gsWF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA1Cn8qu7cP9WlTueUMDfPwoum4a9O9NH05B0Gs3ddI=;
 b=GkgwajH/aw7PxplYLVRCPr3dxSMn9iO9IyUDlqtlDsvmHhvKzs6EjhkXGHmAZSqX2WH8ZISY3CLSazaGAEJxbnGGUleSniy7CvZaEmQp+IZ68OGNsQTMM2m943JqfYX3t0a4q8M5p8fIhlJOL0FhQJPhFrFIunAagcPyXt9gdRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB9629.jpnprd01.prod.outlook.com
 (2603:1096:400:1a7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 00:42:12 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 00:42:12 +0000
Message-ID: <87a5dlwlr0.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dmaengine: sh: rcar-dmac: add comment for r8a779a0 compatible
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 Nov 2024 00:42:12 +0000
X-ClientProxiedBy: TYAPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: acc83149-6d48-4151-ea96-08dd0e7c5507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ce1m/cDM5jMe3QpGKBgFda+oXkzgwNdROJoL6pAFzTlw2itngAyXq4jdva2K?=
 =?us-ascii?Q?umCV9lxSr7idUKw7UMh+0qVwW8q+k+uf5yNLHM1gVwwONE2FIzUa58wLdLc0?=
 =?us-ascii?Q?gyf1tYedbU5ghdyT+sI6YDg2GVY+B88BmR2FKF9M4LlB4NaSqmdmcoEJR8Qv?=
 =?us-ascii?Q?Uyoo1IoKXqLWzb6kPMCdBINT1Ss8VQGUMLNgE8kd84pfYJYN7/VilgcjCyzO?=
 =?us-ascii?Q?v5OFDp8vbg/k7qdHLgzp86wYnPFEFOpJoBbPyxSXpIkHMAwnsbq1LUMmdPAh?=
 =?us-ascii?Q?CrJLrT0DRErF9vvNwAoDZrpIOyQl2W0MiRavuKBfD9pF+BbgKQDehGQAvaPS?=
 =?us-ascii?Q?LInu25r9am2wooRlpGFtWJwLi8VJHNW3QL3knT0tjTfgxLagmVxsN3rX41cL?=
 =?us-ascii?Q?LToPjHW6SIzLNa4uaH8hOwsuh8XKUctMRHj1dsAga8wUv6BL5uOE2VImDvGD?=
 =?us-ascii?Q?4t0mqFA5Ew1h9XvrL9S0jd7/o9UlGT7puavHaucHcZU4NJI2qXMPGsBHzxRU?=
 =?us-ascii?Q?l4Lq+eXIsjwHseOYYTyIVVSmKLWbK+OqVgQ0JhxS9GI/odNvzWfLHi/I/xAr?=
 =?us-ascii?Q?eSfRTtQvQlW4Bwgy779UG+LWott9Nr4Xc1PZrk91VRlBVMuSsm3HtjOoVCma?=
 =?us-ascii?Q?Xg/2V8XFJo/RB9LviLWmJ9AAwv4XHKkFqF2mRmX/pIZucrbXuc16sOoCPFWV?=
 =?us-ascii?Q?HkHmMqeAbD7WwOVrb9B9P2VsDPpHqpWfxCabygYnm8EW4p8mOQXomvDs/Xlp?=
 =?us-ascii?Q?mknzpdwWxdZnWJnDXfV5DKIWrtJRzhnxU41R285p1aCzZZjQ624PjPbkwfX/?=
 =?us-ascii?Q?SDbdV3ppSxuHxs0uuYNqfsck1/ioyJ1tJQckVASjahJCdDnvzqi/GEdXrNcF?=
 =?us-ascii?Q?63CMePEY0t4843v77D20yV36lhqBo/+RW3tXdvCC86wMY60TzuyzYTXhwy3u?=
 =?us-ascii?Q?b9veO3RcJhGC14ZjsZ+GNr9B5erUQWH8vY+/aEzoHGmV5uKBftcZeIrVplb+?=
 =?us-ascii?Q?XwFrCKDQNzC801NeCvL3HhfF7kOo+bPB/vUOxGMNZkaUan55gFxY3NueeT5p?=
 =?us-ascii?Q?i1awYLThun/POvGy1sI6Dm71aH1X7Rb0iAk78EJsHgedyHyOahMf3uXnubuX?=
 =?us-ascii?Q?Zuw31s9jvkM/vvfwntveAW1ZoloFqTQy3fL1aA23qNZKu7cuRm8eTDaZMOQf?=
 =?us-ascii?Q?ndamaOhK3IBKE/ltwosy0AfLiJa+ZiC2zetYg34pi67nRyysn/f7uQRTSiaS?=
 =?us-ascii?Q?VN7AfISUq9txn637ipmKK846WtzTkZrnUESwmmQ2euJcJ2292TCMRwGz7s59?=
 =?us-ascii?Q?xPRNHuu3BaYbrmtnL5Wj7wMRnHooWqmoArcOD0TOTXtUdRTrvil5aJ7Vk/2z?=
 =?us-ascii?Q?O60vllC8aUrvO3eyykAax/jBlWm6/4Dv6sqvEee7R9735h8t1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SKOzdJYn58q+R4p4m9a/dXu94HeC3W6UyyQwBYZnwVOIvDjUF+QkHyRXiU9?=
 =?us-ascii?Q?TX3yRZMeYgqD9nnPLaWidYVsurrZNgloiD7fay/e4Ijxq5V6Vx6CFgpmvOeZ?=
 =?us-ascii?Q?1/3LZtmZOnhofYx2pQX1l487yJWVfx5kLJh/aOugm5VzYlUCJMXglJRiLJ8l?=
 =?us-ascii?Q?mdJYClMZkXDtjj1ZLiBMjH6Mo3m7KiF18Fr70HaYGhTmhcYQAxn3p8YPAS82?=
 =?us-ascii?Q?pmzrcn3XoKmw3FZBdcQYCXNzO04PXcvvKaY9zOEhvcIUWTyEWHoCInmNse1I?=
 =?us-ascii?Q?7PctmrintuuULdbvD1l5ZphPWAzYuZ4xwuLFNBkCw2y41wIYoALBLhAK8aQD?=
 =?us-ascii?Q?XDskPjrEsCKCTAWBYcW9/T3UqB/KY71zKdeBmqZRSfv6UzUy5RDX7r9A1fXe?=
 =?us-ascii?Q?srhHw9j7cBVKdVcbGvhLpsiQziyxFeHkI0CpNx8F4wWVSn8r7xn8Q9QVfRWP?=
 =?us-ascii?Q?zvLVL16sSHmgkYcwyJLlGekdUT1FjpvR3KkCkuPzrWqR05AdeYGLZOUk9Gbp?=
 =?us-ascii?Q?8IQw7LIG8jmPVdrYxrayipHOOxePkwEdtWxpbaQNrjQKurwGyqkqM6b4qfXW?=
 =?us-ascii?Q?R2FV7pEClmXrv+iqtEn7I4TVm9T2iUrcR1sOcKwSqPPaNAkE6rNcUt34gwMn?=
 =?us-ascii?Q?0TGqMZw6PMxSctGEeDCuo/trALlq4wy/2uul3TM0UiSHCLFVigJpd53Vu484?=
 =?us-ascii?Q?MbhIZlAEMCkpIQEiBKyFdDbhAlBmGrzBAule8qBF0fJa1T53C4cSYjRF3ZHq?=
 =?us-ascii?Q?rm/yu0nvca7zap/bfbFHoX8enWAZ1o2ypHLr04n/1N1xc8cOIQbEKiCfk4KF?=
 =?us-ascii?Q?2t/pLIY2Zv41XGjDRFAal5uiP2lHYlSwilG9/8hprHf5GZkag7AsAWRf2g+o?=
 =?us-ascii?Q?LxUWLvpWNEizT1w58Eg+hBQm0OhdStC790eY+dAmYDz/n4PXlyt3O58J/5lk?=
 =?us-ascii?Q?uwg6UByQkn8Y0F3zUe5xk2NCdkeQjMpasUDZlAg4kslx4p1HjGQ63O3VraBG?=
 =?us-ascii?Q?zRURgLG/BaOsp3Rc1PX3FWNkYAxNwJvwO3CrP0KJoXQQH8eETBTyeknoIEMC?=
 =?us-ascii?Q?wmZQOpYVjtlpG6ie0KX1fJ7453U+86UjMlTObO9GaEX00nvWTkFxwPEkC2cv?=
 =?us-ascii?Q?uCka5Jkh6XNPyjhp8hhdhe0SMn9wvtEd0E2gZ10PpV/Mg8KMJAV3ZDDDdZKC?=
 =?us-ascii?Q?9A7QlsoWZH+qmZuaHiL/H66ypxooskFdIvgjh+wCznOK+K2gR/4Y0F+ouvmw?=
 =?us-ascii?Q?PDwr9gQsyYooOjZmBROkPZUp2ZWCYPIlV1RF7uE4a5C/IiIhQDIkuQRsis8f?=
 =?us-ascii?Q?6DzfQ7hi9wJPFF9t25RPeOxbTgs9qnOaocBvjJ6+3t9QkmLlp+aVC0tfdAYt?=
 =?us-ascii?Q?pTg9ggVXSEiaTyK+hQ3MkDP6v4Mwt8sr0Dwq1aycvWDZyA65BjrzeD6PiXTq?=
 =?us-ascii?Q?n+uKPY6Q9KED7GMfO3brE/QOoENjYwok/MT1xkpqdM4uLbDkaJvFdTbTCOPZ?=
 =?us-ascii?Q?wTelfD2HD+hGSHccy3PYo/H+KKf7fk0pnNoVg/ikRDZfBOe6TWL+MSjRCbz5?=
 =?us-ascii?Q?wchoIXb+roRknemfGqBQZ+gJtg3InrSugzC5+wQl/JsZH5RbTVs0gO4WE9we?=
 =?us-ascii?Q?SfGfVB4BkAFKWw8aus/5Bfw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc83149-6d48-4151-ea96-08dd0e7c5507
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 00:42:12.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz9gaMSPSYqsaqplEe+05hb4iDAEBCOe8XL17LGGLLS/TYeKTgweR34rjraTz/YaMhOC3Oe1ghVrfFZJXUn/E1/uNhiymxCLn3VKtPgDoR7TQrB6jMJ8APCFiGz0v3Dq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9629

Add the reason why we need r8a779a0 compatible.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Hmm... It seems I didn't send this patch yesterday... (?)

 drivers/dma/sh/rcar-dmac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 1094a2f821649..c712e66641696 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -2023,6 +2023,10 @@ static const struct of_device_id rcar_dmac_of_ids[] = {
 		.compatible = "renesas,rcar-gen4-dmac",
 		.data = &rcar_gen4_dmac_data,
 	}, {
+		/*
+		 * Backward compatibility for between v5.12 - v5.19
+		 * which didn't combined with "renesas,rcar-gen4-dmac"
+		 */
 		.compatible = "renesas,dmac-r8a779a0",
 		.data = &rcar_gen4_dmac_data,
 	},
-- 
2.43.0


