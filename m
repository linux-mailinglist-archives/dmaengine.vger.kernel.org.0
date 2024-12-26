Return-Path: <dmaengine+bounces-4075-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A09FC89A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 06:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26BD7A06EF
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 05:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3514A4E1;
	Thu, 26 Dec 2024 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvEMZV6W"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAE149DE8;
	Thu, 26 Dec 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190870; cv=fail; b=o5Rs2N4ubVn62o9aukA3KZi0kq/KfAPOEKqEQoIURHlySWeg6fZf44IaOpEeUw51dSrNpaDCzv9g9mbAuuMxPv42Qz47vgskm77gS7KIoG8D/CyISULtvwkaPu/6qFrRbbog4FFzhI9NeDvbxTi3Mesa/3h9lMwJ23raaBOIwR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190870; c=relaxed/simple;
	bh=drf3SGcpfl2W+3l618w/JhvNVN1fMDE4dcE96BI1bjA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nMdcakZ39NH5NFrz3AtiQ+EUR6K+0qsoR+DsmcELLuaLh+ykioRvzeihWLMArXmjU7nrzKrdUUMoMBie67Drssbj5ID2MmqrwrYn+PGSShkGo1ULx1kj0u83WzKv7pSccLa/7ktlxcYbLB4WmJJfZF0/R+5PRK4e86/pCRg52No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvEMZV6W; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/C2RausLXw3g/HYote/E/kwIOOehHNLr01G6jUGXdsd1+qSbHW4OVOuxWiWypM271oyF7i+KzkgTgwg90hSQT49qpzUqDTpagDB8zajDzX8rHWczYtXNn1XLrE0rcbrcy5GSFxaZvWWIkIrdNyO+Jdz0bsi5bj0q+tSZFypbkMUnZ8hFMPVF8rYqvLfelKFBJ3JQynObpNW45kwvJOU9a0JCqLefDgfptZ0HVDjb4NNlg/ltKI2ge36lxvFaPa+QE6xGouvFZzugnVy5qmixsGn/w9wJhJWYiBMHPMJhhoVdXHcEvmtpfeKkU6QIaAM6v2LkB0jIJlLWodJsEeUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mcoqw47BhqDj9IotfFQSBXDPta0at69MhcMYmKzrKA=;
 b=MCFi2Ax9D1vZ+KFuQ0t2RhL4MAQsnkRBtxOOCEN6920y740SjfPVpXFfUZocsRZOlGvhIO4bn2ByNTu+Y4tUDMBbrt1rYG0fZMGWxt7DNKq3EVOjACO56yHHMPgS9M/952rZb2H3F+E9+6mmdm+p/k4E59P2MuaulyqBYX33ZFHoIixnJOyus/qHaZXzBMRGRV6QIh3cbtD6e/LaBFnA0OGgGtOJTXLZ1eMgIu7wXvFGYIs8Hyi1itntWqwxNVt3WLpunEoTTezV32szIr/sYhd6sBxCt55nRcBwi7j01pHHzwCjiiHocm8t0qIrCQ8g+igzpc7ANqVL0dQe7HMtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mcoqw47BhqDj9IotfFQSBXDPta0at69MhcMYmKzrKA=;
 b=JvEMZV6WntKjMgq/EOCpbJeqKP4rftNvvjIQLWJj27EVQ9YBvaNlwgop8kE9aOkCGW0ELy6LDNaxzUuBUICtkdTQ5pB77wRS2pbW5i9BRgMDhfD4BN18cGtdaT/V3D0q79pzDfvxZp+mpXigDIrbE6uEecw55Fe8Z3qGwztR4ngaI96c2N896RJ6x/uqYi5CDyqfEMfA6yiKnH0Ehsc6vyj/p6Qq+h/fKwDC82TWyfRZl1qn451VRugLN5hYu+qGzZV56XnabJMQaCbCq8JCtc88dSFy0HVf0xSAe3m1SQL24fj5TGi5POsS5ItlWER8DonReKz4aTjTc55xRS/M3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GVXPR04MB10520.eurprd04.prod.outlook.com (2603:10a6:150:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 05:27:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%6]) with mapi id 15.20.8272.013; Thu, 26 Dec 2024
 05:27:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: vkoul@kernel.org,
	frank.li@nxp.com,
	shengjiu.wang@nxp.com
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: fsl-edma: add runtime suspend/resume support
Date: Thu, 26 Dec 2024 13:26:43 +0800
Message-Id: <20241226052643.1951886-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GVXPR04MB10520:EE_
X-MS-Office365-Filtering-Correlation-Id: ead1187c-ba5c-4461-4abb-08dd256e039e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWDMDcO5+RV98ix/+yrFzVDx5LxXhmOmye7D15eyZ5+oCnIvEy6cY8LYgnjT?=
 =?us-ascii?Q?fiP+K8VXe8tWiZ+qyD7UsGsd+92VSosn/KrBAnq/67olSFGxVwkYHoZn4FA6?=
 =?us-ascii?Q?KTi3MJSA6PyThxzMsQp45b3wAzF5dUdhWQmx5xT2GXwAmk0NT9iVx5ouIKVQ?=
 =?us-ascii?Q?76LrTXP3v3wkxue5amyhjhyrGsdUo1f97lJGcjCxVTj+s+VWvb+yvv9j/0DI?=
 =?us-ascii?Q?/I7O/juIYV7dMLJYBshNelgqy44VMsf6gsFAabi6Gqj4Q2cbGO3btTSuhqRN?=
 =?us-ascii?Q?JWGAHFaDq0xS8zXh2hHnyyk/FTTkKFbESkKji/HpPWZQSzMuF14DqcKmQJu1?=
 =?us-ascii?Q?kak9pFl2Oe9ZMSn+uDHgOr2Ahw5LB18UqfMyujeN25GaPtbrI6UT6B7Y+Mgs?=
 =?us-ascii?Q?A6Nw2cdJaJ53QuJ8NYeovno0Yeh5NveVBdfQxY59NGR/gNHVpenNkUtyY15d?=
 =?us-ascii?Q?RJ5ZMlAAal82pBMVj6KKO3+aH1+4oKWar6tiG06bJh8RnX+MAXQjEv432iE+?=
 =?us-ascii?Q?X8cdK2vA2FOy/ybW/12dX17bPPCZw/L+bNLJ0wOybqITsJ8cZDUeSX5WIydU?=
 =?us-ascii?Q?kKEKwkbJvPprgW9OZ3deAdAc9iUTF4otjSVgpy410W4wLTondfFboQ6YvBfb?=
 =?us-ascii?Q?YxHCgCxwBL+hEoWcqy1SUwNMqTmHdHBFcpxx7weW++ljpcmg8JiA+eopbmQr?=
 =?us-ascii?Q?YlUsn2qnhETqogbrrNhSUS4dxM2gztE5xi0n4KlqqIJVd9HvfuPhe7cALVnC?=
 =?us-ascii?Q?Z7+YMP1WRjkdfHOhyeWi3yGR3HL7biRtg03Su/aOxMpQGV01TSpo9ub8in7y?=
 =?us-ascii?Q?YVwOFookqVoe/057amvpVnc49fNTxxupAQHW5oHWxPVTMmFB5Stfb5tAxyi1?=
 =?us-ascii?Q?erwwvtHhiSjUPC0LiHpL7M3I9Ah0q/Nk764L0ObxUiqxFHqS+YNWfyEiFe3I?=
 =?us-ascii?Q?eXDtOI1oujpcm+Aah9LzRbpY42a0u8GBBv16XBBnpU+1Y7+UlqyZ6oVfcS2B?=
 =?us-ascii?Q?3V3vHe/9Of/04ijU/VfR4NSTP1Ajb4xXTX765ngu+g4MPjcSGNt+oXPrDH+i?=
 =?us-ascii?Q?O+Iitmqjyt/c624ySh1CxboUZ9QWd94KPbj2vvOyPOFFhS3eohk5LtKoPxeR?=
 =?us-ascii?Q?VbKksxlLAD9a1ItgC2evzbz9YR2nrOFl4uv23YSgoV3FOGepsbMu6jES4n92?=
 =?us-ascii?Q?Q4nfvEatLq6myY674W3XMlpmj/9akWMqndl5Tvfa/EmY0pvSxVAdlFNNZdMs?=
 =?us-ascii?Q?/f3Srd7rrMO7I8lKKs6PrbuoRTmlBQfhfZQOTf6ziyGk8C4Ro+CBFiCqcTLa?=
 =?us-ascii?Q?DSAoboMb9IyOszS/LMmVWv6uY3W2+sHAUJu95BHegSkRqCpxdCxKmRrFo9TD?=
 =?us-ascii?Q?/KFwgMruBL6uBWfdZ9bGVUZZ84R0kcGTJWmAWwN42aGlZTjT/5pqOYEvU9tP?=
 =?us-ascii?Q?w5YlFL+ashRRM+M+0OpBJaxs4Vlw0Shd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeCexUcHaYktaaRe6IGs9Kn73a4gzAYbwl73i7GynkMP1prxV5Wok2GSjBLE?=
 =?us-ascii?Q?2D7pZkW3ApH1sXU0L7pbE5NClZ2JP+dGLZCRHQ5UhvQ5p9NcZlyLh6hS/3ec?=
 =?us-ascii?Q?PNOODX3j7TZD/v2RyKh8CzJgzr7UxFu+zwLcpwlgkvQB/So6DB4B7l/Dl+Nt?=
 =?us-ascii?Q?MzesZfgxseL3sHe1SH2kTFhU3iD2Pr79rpjzuo/dEmYNcAk89bQl/xG6VbTY?=
 =?us-ascii?Q?K1VdLf1epRlHOg1nQrLLOZaXtsL3fzaIEjssqwgD6wW4RtgoxtQUQ7bGa+IC?=
 =?us-ascii?Q?l/J5QKUpSKHbqVych3CaZtwDMqUa/kVrAznAxfxFnyevP66nAVLoNlMgmVcQ?=
 =?us-ascii?Q?tZf3l29r6TFNLmuCxcq9rhk44kB0qyiA223MblSEkoyZPHbEYo8qYhnsghEr?=
 =?us-ascii?Q?2bPU7T3+B60dms2iWmhLVmBeaE24QOpBHsGadqgrZ1TutRH32sTWFo0IYJ+R?=
 =?us-ascii?Q?pJseKITSnKDhMGkNUtnE+SR/ujS+ylllnfUhxPkWupfPOFymgyD4NFrJwAVj?=
 =?us-ascii?Q?vA1a4VS0IWu7PAteYALUqVEZ1sEKLs2yvEXkuHNalH1ttGZ0KKVtU3wgqEul?=
 =?us-ascii?Q?lLcCh8zvTk98nNcr3m+bAZyM4QvccoLebpVwHn6s+Yx59GE8bmkES5f0Zyy8?=
 =?us-ascii?Q?XnKGypm0djB48iK1Mzs24dSVOhnCPP2Doxdm2krfkyosLMmHAi5fzYzz5A0z?=
 =?us-ascii?Q?pVj7dRbRxwPwG/8mKSOvJT7BIVuTYQI8ecd5vMMeyCbBr9dylWHeWNHfiK/u?=
 =?us-ascii?Q?BiIp9aZ0UVa5tbOqddO/5rip0b8tTbgjkDi1bFN2juMKPGDFzLPEIrCY8HWx?=
 =?us-ascii?Q?b9vkIRvumCt1RhPlK+rWSrBhAG/q+ar/i7r6aKsdiLs8ENJ3zDw6ulc7iLLY?=
 =?us-ascii?Q?LwdCM80qj07E/o5Tz7gHRqyEb1qlhHTTONTIKan1zK3LtF7bsvjJyphT1Dyt?=
 =?us-ascii?Q?WYEUKoRSuZ/wYDMAZAsk+v+EUN+/Rr/0IRUWqT9vS4D4QZWrt1F6UY3hiWhe?=
 =?us-ascii?Q?9uABWOqMvmDs8o33xTt4mNghlAFaHud5kO74yXIzX+QzXQoN4YOuKeBDVQPZ?=
 =?us-ascii?Q?YS69GMOQn2uTr4db1dS2M55FUlsneDjGug6Tcc9XKWj5HMtYHfuWPioDYD49?=
 =?us-ascii?Q?VxlZA63bzpCLoyytT2UeDCMLuobUS2Ex6ZCWsfYsfgZc6MvNfvF8HpFvCojl?=
 =?us-ascii?Q?a8uCBuAHxxbA785UmBQrQqLFuNprmdNPy6dnn531JdXpz5rvz+qJtNSSpu01?=
 =?us-ascii?Q?NJdMfiNOc28n/VF8FKRQMY7B0laYIc6eJBDmA5o+SV4IlFkIOEfy0KIFT2lF?=
 =?us-ascii?Q?xfW0zmzK9KQaEX2glpK2F1QhLchJHkcTM30a6lXORaEIlE7C4x7D5hGrDc1s?=
 =?us-ascii?Q?4h4nmbsDa5sN4FRyvaeznaaJCS5a86Wm42xOe56IZV4RxTBPp+xzjjtkvbwW?=
 =?us-ascii?Q?mYwALRvfhngQr1AN6DIxSWa+CyMfyaiI8y0ZPTMQ8ugooF4fmGW9sdIh/91J?=
 =?us-ascii?Q?5wJQmI6WjkVyznilc4C+6jC6+JzoWqnzaWr7MrvIJeQpGYfEpEZ/qCDTR+me?=
 =?us-ascii?Q?m2J69WpDiEo6vcErGM3aToIvdQ1SHZOx1Xkc2q6x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead1187c-ba5c-4461-4abb-08dd256e039e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 05:27:39.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMzQc2efZiD1Txm/YIePFcdum8nBMpfwP8dqBQsvwaUHgdAqv/jcgvE/gswgjapa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10520

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes for V2:
1. drop ret from fsl_edma_chan_runtime_suspend().
2. drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
3. add review tag.

 drivers/dma/fsl-edma-common.c |  15 ++---
 drivers/dma/fsl-edma-main.c   | 111 ++++++++++++++++++++++++++++++----
 2 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855..fcdb53b21f38 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -805,8 +802,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
+		return ret;
+	}
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
@@ -819,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 
 		if (ret) {
 			dma_pool_destroy(fsl_chan->tcd_pool);
+			pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 			return ret;
 		}
 	}
@@ -851,8 +853,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..f3a47d36341f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
 static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	struct fsl_edma_chan *fsl_chan;
-	struct device_link *link;
 	struct device *pd_chan;
 	struct device *dev;
 	int i;
@@ -439,24 +438,35 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			return -EINVAL;
 		}
 
-		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			return -EINVAL;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
 
 	return 0;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return 0;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(fsl_chan->clk);
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+		RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -583,10 +593,15 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
+		if (fsl_chan->pd_dev)
+			pm_runtime_get_sync(fsl_chan->pd_dev);
+
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
 			clk_disable_unprepare(fsl_chan->clk);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -645,6 +660,34 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			struct device_link *link;
+
+			link = device_link_add(chan_dev, fsl_chan->pd_dev, DL_FLAG_STATELESS |
+									   DL_FLAG_PM_RUNTIME |
+									   DL_FLAG_RPM_ACTIVE);
+			if (!link)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d\n", i);
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+		}
+
+		pm_runtime_enable(chan_dev);
+	}
+
 	ret = of_dma_controller_register(np,
 			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
 			fsl_edma);
@@ -685,6 +728,13 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -711,6 +761,13 @@ static int fsl_edma_resume_early(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
@@ -723,6 +780,33 @@ static int fsl_edma_resume_early(struct device *dev)
 	return 0;
 }
 
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_disable_unprepare(fsl_edma->muxclk[i]);
+
+	clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_prepare_enable(fsl_edma->muxclk[i]);
+
+	clk_prepare_enable(fsl_edma->dmaclk);
+
+	return 0;
+}
+
 /*
  * eDMA provides the service to others, so it should be suspend late
  * and resume early. When eDMA suspend, all of the clients should stop
@@ -731,6 +815,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	 RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {
-- 
2.37.1


