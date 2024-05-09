Return-Path: <dmaengine+bounces-2010-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3088C157E
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2024 21:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3827282D8B
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F87F7FF;
	Thu,  9 May 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXU9vJW5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93007F484;
	Thu,  9 May 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283344; cv=fail; b=bxKAH9vTGMPMO8p0/nJThKMxqo5B0kr9EhIaJt+tqu7cu1Np1d8oFtwwUdBcTGs1keVl0TdvS0Ozu9JGrB76Bc4OYL9z1sdaNU2rLqownfUBg4OXr2bj+Fftz6P21vhQ0tMeP+QoFcb11zkFk1g7Z+Z4cYMiMEjgQ6igJXHowLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283344; c=relaxed/simple;
	bh=AQZ0lyGA0qVI0Kk86XtGqJuqsTfqaea5BYC/0voR6Dk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f/IRKm8q+tDBA4I0Nv6h3orKwjxvBk0WvD5okR6dXmhiP0Px+8qeZcGeq8CLrN85grADCamZh12wqU7dFUr/FXySPSAv4urj0ipMPAcvjpVSUw1q62zN/ZCWV6SirT+lT3t57fgLIIiVXs39i+2bdI1TnTIIb9JrCqS/gIsoVVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXU9vJW5; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfcoaP9ZQgBRtrvRBVbn0+R+x7WoAPvOYY7xnZwC/jsPKPvksHlY8b7mQCAB9QxKjdSu498rmu04lQZ0SOWeVFnYZXGuam3gnmAoFmRnoxp1CASW+Ng6kyhCUltIBCDtq1BhGtNH6roN/gLAZCvVZbNMyIkKSNdY6Da6Uagad5OKhv/0IR0GXAqRKDviHkxRWq2Lku5G2tBLm9KTHdDhCBo92fC0A8D+reNjZgh7wClOuVNGsXPGL5bz8fkSrcTbKINnenrkC4l+ggwDeuqQxgkxpyx0hFIG9nJ7IvG5VaVaB+x40RuUVG/+LGB2ykYqKzBHnAn82j4ZuKUnFlRGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJnwvN6tD7vs5tI5L3JideZA2K8pmydLibFmJmAc1xg=;
 b=S/msjou8FUtVDuUze+KK9I+Gsc2F6xEj+FtpL5GCUCfLFjQ9pVAwzlRYIPhl/fAVGamvoVLG6Bi/TECEhqBQRuQn4hM9HU2fxz+JzmIgI/2TeOf+v9A1VyzV37fke33ExzZCm65+Qr3jhKyeVXlRnVyONl2wwlAjZgrQXxOB/IrECsQvKTSmS2KCbOh7KhVyfYRnRgAxFRK3aO9edmXJGIQHfwnRnw1j10iunVk1Kkh3yHftlJfKJDSzW+DTqHyipHIURQwpDRBot9EcompCjA2TtI0tb5xBIBdoaeuBc3SO1r4aN4rHAXvD2pCgPSe2Ho9V9mbfYxzzjtjeGp3CBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJnwvN6tD7vs5tI5L3JideZA2K8pmydLibFmJmAc1xg=;
 b=mXU9vJW5yb2EnlXrYWIPZmZd2Q1XUwZSPsieDGGhyBSJKAJVgD9dFWIzaWcUIjUDvTrDuVDMI/vXA+Qhzzrzj8yzCYnIxTn3bA0/jEA+p9lUGA1ZWeHtaxjskKGRxN77L8WhzwRyCpniBktQ/gV3Ftl/yQk3xZfqEjP1ZmfNaFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 19:35:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.048; Thu, 9 May 2024
 19:35:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER)
Subject: [PATCH 1/1] dmaengine: fsl-edma: merge mcf-edma into fsl-edma driver
Date: Thu,  9 May 2024 15:35:16 -0400
Message-Id: <20240509193517.3571694-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8286ac1b-0115-4992-1d30-08dc705f3465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8a8SkXfS82uthq5LUbxEj219WKcMarPNhOPB3lNjFrkp6YzG77UeAnRcvT6?=
 =?us-ascii?Q?BXJFMQOAOy0KCcai1aBakND17NXMwhJN5Q1Ajc7vq9IElMfNGi41zb6g6ISr?=
 =?us-ascii?Q?BaYA8OojynBfpAmb1IspkLMzG8E1BWdIpqn9dpEDDBg5Sbg/DlT4klpswF/u?=
 =?us-ascii?Q?4O05aGqb26Vs2l6l/IQgnx6DAoRu3apj6Ad9aWZEi5UtAdZy2iGJEP9QWbpn?=
 =?us-ascii?Q?F1XbufGjhZH7418TWOX/oKiOwdvPMO8bNNkirVrT1xm4ZRRy+tJwwSpSNvVk?=
 =?us-ascii?Q?h8tCfNs62hNsqjtmPF3lmGVCsMOziOVLtHwX2exlnZqeZhEP4HBkyC6j61jk?=
 =?us-ascii?Q?8c5qzyZYNDafcbeEoan+1UUzMFOi9VUnueVoTQrJ2tZCMWQCmUUNna49Ti/Y?=
 =?us-ascii?Q?KXCEbcQE0GWVqWVLGfgfPmcym42ZRTLVvsVe80ORtEOYfLkBD9EmhDh5bTuI?=
 =?us-ascii?Q?ST9YQdA7ul/M3AVVTJrrYe8AYpZ42G9/+MaMTozItM6uuMAvUcdyjk4Wx6qJ?=
 =?us-ascii?Q?JNUHIBn05y/H20iqI/TdnPOBFw4C6wQMGps2sgtXCZq4tTLCEbeZV4YGnpZa?=
 =?us-ascii?Q?Q2n9k+LH3SsGg4fVcIgs2z/PAcqhRmDvSFm4VwKdLKv+oj4/h95+pRhTuq4X?=
 =?us-ascii?Q?EJ2++J71AdaSYSLQFj3vN/3F11t4UtUq8F9V1/AnMkuW8eBkkImJjDMSEa0B?=
 =?us-ascii?Q?JO8LNvfzP4LjFcrxzLuqyHHQNorvCM/il2BGLa3Fjlo1TKw66ilPDl0uZgSI?=
 =?us-ascii?Q?8Iix0quCCz/2ijIuWsgtplAfNRll6s52GYg0b6PnJl/rztpaCvKgJVfuQZ76?=
 =?us-ascii?Q?IVgPgnT4nnk9Nmt/zAhk3gdfBfETl+v9ExwxUs7SxJtgVYmY99UO3lMoYxmH?=
 =?us-ascii?Q?BUOcgZXtX0ZCIHqVZ5nqBtMpfvNkyPx3dKJOdBgzaQ1f28DJChpm8RH7k5cS?=
 =?us-ascii?Q?KVwDzSfS1QbQeStHLEcuCAEYz5l28/xX/KsdlMFZbsmQ1AVUXkzx6xVFSFku?=
 =?us-ascii?Q?GF+To5XXbAk2NacD8x00B40RKNIDtC7LTlmP2J092s5CCgSBbM2YywQk/fjt?=
 =?us-ascii?Q?wJRAgiQJnGCIktcsL+KGrs8zuAC0b+sE7W7B9e08uWhw6bovtd5SWfNdGMGF?=
 =?us-ascii?Q?Fh/vuGHEsQDZscFgabGUA3dpahPOaeGfTSY5Wqz4gSiQBGEyv6F/TX01L9vP?=
 =?us-ascii?Q?W6uYFE3uabV/y2UPial/vPyNr7utrSvWTmLhGwGPdJni/vMRoqIbK0lZpWtR?=
 =?us-ascii?Q?fpGTQDsNOwzWEBhhmJZ4FpaQQPRrx8cx2fUsBmeEkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAfM7koeM8e1PiKzASRVHq0HLiqxNcnh1UdHr3Ry+2DNqol1phdg5no4FQ2z?=
 =?us-ascii?Q?xmxwgcP54G8/cFIXmweAyiYFVsmXq6Bs+fWFccPNFAN0S88MbW5GTQdZQNIj?=
 =?us-ascii?Q?n+S7NY2vpdwWdljtuoyqzjECChNbb6GgEW7cCCDHXIsdFW6zd0T4RB1NsSvM?=
 =?us-ascii?Q?67TWR5gCFm6nE5754T9qd6K1BOZcfrMZfNovbBKAg+dJ3Jj4tHSF7eCUdrBr?=
 =?us-ascii?Q?Qxq494HBeFVzYT7p9Z++S+STV+bCB+DzCenV3cnR375GZwaUVddX3QY3boSe?=
 =?us-ascii?Q?/do63pLILbnjONaBIwBMKnWb0Y7PZi2QXvJ+EFyP0iNu0wUVRCFpvqzyU3Um?=
 =?us-ascii?Q?R9Q7H6AxXSG8HH5eX9IuDiHAwVL2wM8SgHLYbw2EZGh4EqkLrb6th656Wx0q?=
 =?us-ascii?Q?ju5g3EVxWzHPHm5bFCb6Qtdg6pBMLNX35pcMy+PWe5ASLnDy2PYkz5B5/2nW?=
 =?us-ascii?Q?hAsDil19zye5YCEJFd4BaTVI3bV/6McySimCBSt5jt6trO/tyjfaNWM2Nsji?=
 =?us-ascii?Q?oC2KMUQvajajcprHKSsUaB5kZ1Nh8n8f5uelXi6GF2bgCXgv3bi4xLVUBRmY?=
 =?us-ascii?Q?0DL6ZSTA/gcarbqCv+aCLxub9jszKgsw4om30p5TAKfgFvoXKJ6Hz3pZHDaa?=
 =?us-ascii?Q?XAir8QD/Z/zMxZxfscn3Greqo2Qil2IR80+LyDIKkx9EMchIWKtImRp1nK65?=
 =?us-ascii?Q?0h14k+Iau8TeHBOo9zAnSpSVSMrODQHzXMQeikQ/rSxtdnZL5DCG1MCohuTN?=
 =?us-ascii?Q?a5zZhKlQ7VLx6iVVgqmYeX8Pt8WjpeL2MDt8mG3R55+vTsqOv3W6rT001WjN?=
 =?us-ascii?Q?Ns1mAa+Y/Vxx95r89pBcaa9A0Xmg4iFVUTAU90Ja/+rPzucVU5hYUO1Xvvir?=
 =?us-ascii?Q?lTUf7vU9NruG8YR8egmWHdenH74FCeKdhcKB5c7KJ5h8/jallGYzYQws81d0?=
 =?us-ascii?Q?hMIyvmkc0bPvXfGCkiBuKRNuFoYwoIe8fnywHzj1s9TeLaAOOLy5oYdu2qX6?=
 =?us-ascii?Q?GLNa5jCMQaXDYso7qbgXveJmp6RayvleTsSikmNepYSX+jdUYVV+0pJtbEDA?=
 =?us-ascii?Q?M1wnNZ8EXiIXU2hu6Y/a+q6c5pLorqt9Ylmt9JDbpLH1SeHeoqztsa6b2Uhh?=
 =?us-ascii?Q?gJn0ENt4QbaNszGB7Az1kRgq9B/qn6EcAiLOjxS+6kPcaZZu65d2UdpaYWGk?=
 =?us-ascii?Q?UnSmkwdgniqFbay9sEfoz88u++vDTvvNM+nYGK14VfEZ+/Nb/bBGYoC7fpc7?=
 =?us-ascii?Q?YAgetIQKwDwU/uoM5ng63OQ7L0NXdnRC60CVWGtY4K7rn0Wq6VULlDhr2/P+?=
 =?us-ascii?Q?+/BYeJgq2JMizdO+GJtlMPFX9wwvKM0InZN7YWiGrz4XSNVV7HdTRMUARZCT?=
 =?us-ascii?Q?+WBsTpWaXZHel4GvPDlD4edbH2gQgIqAU5yQfYVKJZLrUJaxz25powp77n6/?=
 =?us-ascii?Q?ymN3McNfYZi/9Swl9vQzAEECNmaDNBgdrhEsRArAn083DU27k4L2SavNRtj2?=
 =?us-ascii?Q?bDfAD9VdPz/Ms3ESUPDLSGFckls5+3kodUEFx2c46Oxf+htNLzfMNYYbrvsm?=
 =?us-ascii?Q?tiETk4lx5jiYnnboQyQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8286ac1b-0115-4992-1d30-08dc705f3465
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:35:38.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URuvgSYbYVWqcc6eFshnTXTGUrAJD5JF9cg3lTHrATcE6kC8CRcbgLLzWE8U4sv5rw9ge2sWGT5v5tVyIBTiAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761

MCF eDMA are almost the same as FSL eDMA driver. Previously link to two
kernel modules, fsl-edma.ko and mcf-edma.ko. These are not problem because
mcf-edma is for m68k ARCH and FSL eDMA is for arm/arm64 ARCH. But often
build both at PPC ARCH. It also makes sense to build two drivers at the
same time. It causes many build warning because share a fsl-edma-common.o.
such as:

   powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
   powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'

Merge mcf-edma into fsl-edma driver. So use one driver (fsl-edma.ko) for
MCF and FSL eDMA.

mcf-edma.ko should be replaced by fsl-edma.ko in modules, minimizing user
space impact because MCF eDMA remains confined to legacy ColdFire mcf5441x
production and mcf5441x has been in production for at least a decade and
NXP has long ceased ColdFire development.

Update Kconfig to make MCF_EDMA as feature of FSL_EDMA and change Makefile
to link mcl-edma-main.o to fsl-edma.o.

Create a common module init/exit functions, which call original's
fsl-edma-init[exit]() and mcf-edma-init[exit]().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig           |  8 ++++----
 drivers/dma/Makefile          |  5 ++---
 drivers/dma/fsl-edma-common.c | 28 ++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  5 +++++
 drivers/dma/fsl-edma-main.c   |  6 ++----
 drivers/dma/mcf-edma-main.c   |  6 ++----
 6 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec806207..45110520f6e68 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -393,14 +393,14 @@ config LS2X_APB_DMA
 	  It does not support memory to memory data transfer.
 
 config MCF_EDMA
-	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
+	bool "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
 	depends on M5441x || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Support the Freescale ColdFire eDMA engine, 64-channel
-	  implementation that performs complex data transfers with
-	  minimal intervention from a host processor.
+	  Support the Freescale ColdFire eDMA engine in FSL_EDMA driver,
+	  64-channel implementation that performs complex data transfers
+	  with minimal intervention from a host processor.
 	  This module can be found on Freescale ColdFire mcf5441x SoCs.
 
 config MILBEAUT_HDMAC
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 802ca916f05f5..0000922c7cbfe 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -33,11 +33,10 @@ obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
 CFLAGS_fsl-edma-trace.o := -I$(src)
+mcf-edma-main-$(CONFIG_MCF_EDMA) := mcf-edma-main.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y} ${mcf-edma-main-y}
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
-obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
 obj-$(CONFIG_HISI_DMA) += hisi_dma.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 3af4307873157..ac04a2ce4fa1f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -888,4 +888,32 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 	}
 }
 
+static int __init fsl_edma_common_init(void)
+{
+	int ret;
+
+	ret = fsl_edma_init();
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_MCF_EDMA
+	ret = mcf_edma_init();
+	if (ret)
+		return ret;
+#endif
+	return 0;
+}
+
+subsys_initcall(fsl_edma_common_init);
+
+static void __exit fsl_edma_common_exit(void)
+{
+	fsl_edma_exit();
+
+#ifdef CONFIG_MCF_EDMA
+	mcf_edma_exit();
+#endif
+}
+module_exit(fsl_edma_common_exit);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ac66222c16040..dfbdcc922ceea 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -488,4 +488,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
 
+int __init fsl_edma_init(void);
+void __exit fsl_edma_exit(void);
+int __init mcf_edma_init(void);
+void __exit mcf_edma_exit(void);
+
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 391e4f13dfeb0..a1c3c4ed869c5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -724,17 +724,15 @@ static struct platform_driver fsl_edma_driver = {
 	.remove_new	= fsl_edma_remove,
 };
 
-static int __init fsl_edma_init(void)
+int __init fsl_edma_init(void)
 {
 	return platform_driver_register(&fsl_edma_driver);
 }
-subsys_initcall(fsl_edma_init);
 
-static void __exit fsl_edma_exit(void)
+void __exit fsl_edma_exit(void)
 {
 	platform_driver_unregister(&fsl_edma_driver);
 }
-module_exit(fsl_edma_exit);
 
 MODULE_ALIAS("platform:fsl-edma");
 MODULE_DESCRIPTION("Freescale eDMA engine driver");
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 78c606f6d0026..d97991a1e9518 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -284,17 +284,15 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(mcf_edma_filter_fn);
 
-static int __init mcf_edma_init(void)
+int __init mcf_edma_init(void)
 {
 	return platform_driver_register(&mcf_edma_driver);
 }
-subsys_initcall(mcf_edma_init);
 
-static void __exit mcf_edma_exit(void)
+void __exit mcf_edma_exit(void)
 {
 	platform_driver_unregister(&mcf_edma_driver);
 }
-module_exit(mcf_edma_exit);
 
 MODULE_ALIAS("platform:mcf-edma");
 MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
-- 
2.34.1


