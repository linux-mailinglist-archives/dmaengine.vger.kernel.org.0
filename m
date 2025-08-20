Return-Path: <dmaengine+bounces-6078-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE6B2D9C2
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 12:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6420F1C45770
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57B2DFF19;
	Wed, 20 Aug 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cZ9XghdK"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593362DFF04;
	Wed, 20 Aug 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684321; cv=fail; b=VW7L/TUaDWNS46xV1XbT2ynzL3ZydjwYw2gFfitQSlwzyj+ve0+On5fzBNh5/suMpEd6HPB+CYtICGkrKOjmm2CoY1ezq6w2PpNg5toM4SP/od+/MIHBWRvmyQFhC1Q5hB62yQL4d2NWFuNyZYpP9epPlZ8kxKRTYaO+Sfx5jXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684321; c=relaxed/simple;
	bh=RDPKSXI53wCqO/03+f7lXcWrEenZWSOlVZ/dlwBT6LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p90SviiJorXEjyV8PVrjH9DemBGALxQvsgYwGoVZBNfBWNFVY9AGime2vKnC8kO6+DuideEmnQY0Aj2wkBrVaj9RiW97CbhU0iYZvWsNnulToxAruhNvrSqNe0ug7IrCXGYGMg7+9O9fu5pN1F6KRs2kGyl3mv8O7/ooylSMKDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=cZ9XghdK; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clmit2FkyfYhOT1Ut/p+E0hcwASkYSGAjinm7ywVGLJA+qjfK9pf3eGAxl6V/prtnuDNusQ4UxA+argZtPKR7OR7j3RsFP5Ovm8eWX1lS1GbGOdbriIeqctmuK5b/PvSSdotdnuVzwLNH/2yfHuywobhFkWK3I3PmrV3D/V8wge+ssdDhUtJmfhg5YhcR7shueTuaaX3U46iD223DJm0e9tSNgEeBMWkGXxl9Sy0elj31qu7mz+VwYMqoYsnF585AJP1PcLXv19cwkJQyP0pXq4Su/zwFzGH7SpfmFtSqWA8Gzg4NaUtyrNDcH3drENCSBYYPHmDd6XO/njp7P0OAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEll/FYFPd3pViZY/fJHjfqBdOprq8UGgy83F3P+sJ0=;
 b=fc3C0LVIZvLVCElPnsvQKaSoJ1b7euStJ5XzG3LSIY5181mVcgMdlgQUDkXGGkBFPeNSJB4TMdWqBMeGRuDTyGmkc0INtv3yCFS6bkrk8pToPuTFXgLHVG0vpMcp+3BaJvucU6LjVh0+RgyLi0NtUMhR+hq4XvKeDlE1lXvw43a+Qill8+hmMPlvqiOmCJ/3yz+GY7UleltwtjYz+GAKUvFyRm/HxoM7urJRzOOXnZdy84K53NRUfJBNqwx8dFlbSbe5+LN46BzRc1P6EHVT8i6uacPI5sv03SMjAt2RTGi83B9J7BwujPc3h9wdnQ5XwnwcIJZkpicW4dKit4YF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEll/FYFPd3pViZY/fJHjfqBdOprq8UGgy83F3P+sJ0=;
 b=cZ9XghdK5aLsSJNwWsKttTaOTquzwIYpV21iR5mK8hAldkl8Q4jfXT2zKfx8vipWLbxQV6r4ksuVtfVS3/zSJHZy7hkw+0eIZGpDcn7SX8OzzGVUfIWk7SGO3hCyNbg7KoQN1DS7thmb6eMU79Rx62ZD6xAVx8ZopfV5lcEZsx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB12004.jpnprd01.prod.outlook.com (2603:1096:400:3fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 10:05:15 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 10:05:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 4/4] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Wed, 20 Aug 2025 12:04:25 +0200
Message-ID: <20250820100428.233913-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820100428.233913-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820100428.233913-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB12004:EE_
X-MS-Office365-Filtering-Correlation-Id: efa18206-4532-438c-ee2f-08dddfd10f4c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2z3xZKkVeU0e9+Ym6OIDl41m2pBFnD1TPjgy1eirnUAoGQk8Am7fzHsAeGG?=
 =?us-ascii?Q?Uq6NUqqF1Njs0sYoYmDbOy91jus8X0Nmkuv3dOQKKsJHFwX4niC/9mjHG7ua?=
 =?us-ascii?Q?Gh3YQU+UNexJ5qNN9l/ZiWO4NRkTXeDUlFczL3cJojbxDG5QXzpvKIvSUAcZ?=
 =?us-ascii?Q?QVlfWP5gbkAhBr+G10UzSGdAGnBJmv8GQV+kaIlSgLqc7Zg4L6eV9QUOuFgK?=
 =?us-ascii?Q?/wCATG2OqpDTvQbAwEHpxeUVccGXnV1k0G4L6iMW+2RA5p0zOVCcEM/neggT?=
 =?us-ascii?Q?ONU8miMfqzlwJYieZHuFVSBgjdyOoArblDq0ob4qFJUXJwbBMUPpO1TWMeFr?=
 =?us-ascii?Q?jp4JYNb0ScmRr18e+/OjoBbELzK45oiK/85tKr7ZVDSAf8AXeBFOZIDWs5e6?=
 =?us-ascii?Q?tEPnEAkQ7tsf79qCIzcGLWuZ2BpuNieli+wxVljevfKAf8HaqMLCSuahj2Ds?=
 =?us-ascii?Q?5torHQqnk0C3vqpWVcaoKr1GsNPWHyrAbu3j+iYiqPm0BTCMTwOWYfBF+CjU?=
 =?us-ascii?Q?4bxg0ihi6z5Ujzv04lH2CNyE8sNFa5VNZlFTjeIroTUdmrt2acKUwcjMTr9q?=
 =?us-ascii?Q?3qzx4jA8z89qZsPM+T7gUH0Upm9Km3Jt4CCwg8kotPVUEe4gk88hMRLh/H9i?=
 =?us-ascii?Q?hnOWHgymJZP6UNy7mMYfFSRgDSWpjwsa6jN6V7CknV0YIe9/ZrMPCuNqsZ6I?=
 =?us-ascii?Q?EHiyQwA4vHrUSveMe1NgHNWLQDb/iGw3X9dk6QFEeunhLzhNEQ3ID1gBhQhq?=
 =?us-ascii?Q?85Lu9Bukj6uxw1ZdyjrEkIRm8/AKbIThyizjrIgXdbEIfMpYIrRvLbhvxApf?=
 =?us-ascii?Q?3NU+Xf9AZgQsB4jXjDSlBXYERZUz1PRD5NRCW6JrcTcQafO9WifN8ynMqMrI?=
 =?us-ascii?Q?nZgzWmIFxligy2/AnSrKP1w1CAXAi6OLInXrNsemFCJyZN7l2I1oi0WERx6s?=
 =?us-ascii?Q?l5q9GCD0CKKDU10mSdGMUr9ugp+tjzHfS6ke31xpLqEx0iaAY1DtSsJReDch?=
 =?us-ascii?Q?8YNOutNlHHzin8BnD/+P5nFiViMrUi+kr7de3aqEH5NBs8i7Ml2vhY2dAfvF?=
 =?us-ascii?Q?Vizol5Jg8LsNhH1cg0Kjyr5B6LqR0Fd56FbzJo2yJN4+tqQh687LCdUfHh1A?=
 =?us-ascii?Q?bnDOswNZRxLFL94pir//h3IKkVWQopsu07CTLanincIPR+s/RyekOtKe7KDZ?=
 =?us-ascii?Q?aVqs6GHrpkUAuL6CIWOfddXgPxciENtoVNvOKZo9tkBJEkJ4/Ezqd2aiK9RD?=
 =?us-ascii?Q?dbRxKkBINDhv+PnYStEMssuD/17Y6vVd6Q5s8Rse5LwvD1lA0Wq3XQ6GO8Oa?=
 =?us-ascii?Q?u6jNE4Fdy02NBNgRndh1QabFSM6kRqhQyxsEpscUtiZjRUV7Yl50/xFhJQqB?=
 =?us-ascii?Q?an5orrXuVZh3B+8tAHrRFic5Ime73hAH426vqMZjIBuo5V0MqhxwAepIvza5?=
 =?us-ascii?Q?wzIJVq+4vNSENyVTlXo8KVqGDPYVpbc7wuMuU7KVCZ8o9psDMHNFkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nylqvjiPzWmD0zDAJt3f9M6ZUVTBxGNCxmfmH6yP159UZffD8OeTEtgArHdU?=
 =?us-ascii?Q?JRLtQ/WfjvLmR3DJgLo35VE3d2EUBo7aXf0JraG8lJf/HzmxFgy99N3JGXaU?=
 =?us-ascii?Q?/ZsJPbVnhBX3hW+6mUJbdSxOdwNl2ZDTdesR094wMUsvAqHaJHiH35+o4XHG?=
 =?us-ascii?Q?IDuKjmsIvAQz8wCp4TcFbqaz08BZn1MuCKwCM+h6NpuR0mK9MHeTMO05sox5?=
 =?us-ascii?Q?o2nApvZXFgAnkGkI6qsNW+3FVibYcclkNto7YKjAaMce0hLgrTlRoPjj5Zka?=
 =?us-ascii?Q?Shp9uuZtoC+dIw4GVWuvOxdPgxehi6oDeDR+m1XcsKbcK1lEombCa8C4hljy?=
 =?us-ascii?Q?sPn+cwtgDU5/xrSmTgsO9vBv2AKl1ppqVwIY55AjCJiiaGQMpC+q+pCLhhjj?=
 =?us-ascii?Q?zYDoYd+xNAE9RkbF2HULWrzBplSXyNl3vkTahdiBeqvqV/WCma/U3k3xK4iE?=
 =?us-ascii?Q?L8Ns5qdTIsvSxsAA5TI7g3AIkV/YdI6czecw3KmAGmDm3iihV88Q2290EuQ/?=
 =?us-ascii?Q?X+pWVuITgpz7YfC7uMXmvwUVKo4zaFVcAgZ7Z0iwxgsuTrMlRxBiwXChiP/b?=
 =?us-ascii?Q?YT/5Z1ioHX+eM3kW4Bow9M3p0ahwH1CV6fmD+XGXtJ+WwkdkG7bslxKt8Dq0?=
 =?us-ascii?Q?cd/MdGXDVuDV/P5r6h+ruc+3wsqdE3mPpxW+7+oictITwsS3Rwjlocn2P8yL?=
 =?us-ascii?Q?kqXMYYJarmXP9hIgiHq4Fn1YbWf+Z4LMHYUiuBZ7Z7yhrm4IBRf4Yp5/9bet?=
 =?us-ascii?Q?vHgQhKDHTvGeb7fjbNWOeZbNcmX4B9Z5O5Tw+bErlhngh9Kku5UJkYU5xs1l?=
 =?us-ascii?Q?ZOpONfpjpAUuT3LnniJTzkYlrq4H204OKR/h0mwlrm0GA8L8qZei6f7WDBx0?=
 =?us-ascii?Q?eLtiEkchZySnfjg3beMXsNJMm7YgqoiiV7qyOITjRHHpP0elBAR2KDqeh22l?=
 =?us-ascii?Q?N/47aKGCuNtERqXwvo6j5ZBMIp+1vStDhcHHqpi6ploh6YRsDY3hqw6yjdy9?=
 =?us-ascii?Q?ylJuwZCb98nCZgVTQU+BtSXfiEf605n2ftSUqRkrBsCpp+vtLNwLsLPo4PUF?=
 =?us-ascii?Q?L3tZtIPbeW3m4S64uLjnrAR/H8j7bcbAuiDcpKDa5KCeeGxH6WBgb3I6Nyq+?=
 =?us-ascii?Q?H9Vq/cGXnSdLxjG/IyhZbWNG9Q/01JQeI2RoQW0ZMZqk8MCKnfkvm+McXCts?=
 =?us-ascii?Q?cqvGrzJoc1VxfpYrnWKXjlAXmMaLU06WxBWj3G4HltIOXcnb3B8jQdmiep4Q?=
 =?us-ascii?Q?IAaUDZ/Beam/cFHE2Sr4BwDFRB/JAWcy0wlK2/3P087CbM3odKGKxKqsVrd1?=
 =?us-ascii?Q?N+LGYTlmiatZLrBPBpiWQ8VVagWg77cBgoHWh+bBjKpO39EJ6qpL920ViHV5?=
 =?us-ascii?Q?AawYbo8+/zu9V8R5C0ZsZky4+p4qipbOjohmnYy7jg6mDYYGC+ABUL/v8rLu?=
 =?us-ascii?Q?M/b86faxxoGRYFnMcsCtKCztTCFMeFohtOtkfjD+IBr4GWuCLVN2MouJuiRw?=
 =?us-ascii?Q?VUA75BRk3yJ+nI5d/qgekUZ1vqoSJu014vKkInxtI2WFQjPvWco0Ekh+6OfZ?=
 =?us-ascii?Q?lMjOCS8LEYhZSDsvO9x48rO7GcCcwK4Rz9rAImXH/hqVtWl4w+5xgwg74klT?=
 =?us-ascii?Q?v6gL3sJoaMibiYDIr2Uu2Wk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa18206-4532-438c-ee2f-08dddfd10f4c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:05:15.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPP2/b86xsBJZ7DO65HCBqU7JaVFtX/EXruG3ksIw2yJij36If99REyiNIMRDFrok2QjuzVdKedF3hFNa9dwKGm3YPJ8TNNMzu0ZjeylhpgpTRep37QdKkOd9c8pMEqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12004

Enable runtime power management in the rz-dmac driver by adding suspend and
resume callbacks. This ensures the driver can correctly assert and deassert
the reset control and manage power state transitions during suspend and
resume. Adding runtime PM support allows the DMA controller to reduce power
consumption when idle and maintain correct operation across system sleep
states, addressing the previous lack of dynamic power management in the
driver.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 57 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b8..2f06bdb7ce3b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
  * DMA engine operations
  */
 
+static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
+{
+	unsigned int i;
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (i = 0; i < dmac->n_channels; i++)
+		rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
+}
+
 static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
@@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	ret = reset_control_deassert(dmac->rstc);
-	if (ret)
-		goto err_pm_runtime_put;
-
 	for (i = 0; i < dmac->n_channels; i++) {
 		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
 		if (ret < 0)
@@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
-	reset_control_assert(dmac->rstc);
-err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
@@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	platform_device_put(dmac->icu.pdev);
 }
 
+static int rz_dmac_runtime_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	return reset_control_assert(dmac->rstc);
+}
+
+static int rz_dmac_runtime_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	return reset_control_deassert(dmac->rstc);
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	rz_dmac_chan_init_all(dmac);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rz_dmac_pm_ops = {
+	/*
+	 * TODO for system sleep/resume:
+	 *   - Wait for the current transfer to complete and stop the device,
+	 *   - Resume transfers, if any.
+	 */
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, rz_dmac_resume)
+	RUNTIME_PM_OPS(rz_dmac_runtime_suspend, rz_dmac_runtime_resume, NULL)
+};
+
 static const struct of_device_id of_rz_dmac_match[] = {
 	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
@@ -1068,6 +1110,7 @@ MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
 
 static struct platform_driver rz_dmac_driver = {
 	.driver		= {
+		.pm	= pm_ptr(&rz_dmac_pm_ops),
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
 	},
-- 
2.43.0


