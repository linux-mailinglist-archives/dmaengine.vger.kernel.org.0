Return-Path: <dmaengine+bounces-3738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC779CDD16
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 11:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885E3B254A8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F51B6CEB;
	Fri, 15 Nov 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ir0QuMFP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E11B4F2A;
	Fri, 15 Nov 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668223; cv=fail; b=jkSwH2RoW4Io7FCGZFn3/7QC81mDhnS8lbMzie1jGUp1oeUf+fSEp+0be2xaeVLnf01RZ4+RzMWxN0K5rVk+xE0iHJTjBKlgLoeFyfnxJH4JuHPoXC+lXM5hLjwuy8QunCy0wWnmFuDU7+KyY/r4Ax/gHrwKRiUQ1ybYQn2YXgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668223; c=relaxed/simple;
	bh=rMh79KrAMVkhPQt0GUUHsuB7DhF18En26blPigZDcRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKQfWQxVdQWgt9HNi/bKzgXfDawMvRNNP+PjIsZcVdvbMepjZTfb2zysrdrQ2OudUbweaWBuRDAQi+DW6jOUy1jqoGH/3MvpqOUNFjXvCYEesRlzGXbJ1YrPxUUAnMiwcQVy6a3uyAplU+O/Sl4WiYlFHdlT8iGL/ksx+MCSn90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ir0QuMFP; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6bmKZCM5Gh68crRzQb6tsHngsVhDu2ZgYYPLjaVHHOLtmfaTIBQKSCxSIG/wrIv6sVo540Dg65FUTJCVPwwUOLLB8KV37L5QwW7fPDTnvOvBlmxp7t9krdpH83K3lUz1aFj5hRWYhWZzqa+TrDU33ZEHGjNGBmFNSJVMkiMYKy1N+H3HjeMh9MjGjp5/jVMRLD7GoXM1SsrzNKs2wnchje+zoiDEjSkAZnL7d+VC5bXqQMgKUWuvdxahRRwpmDIPWOoTzPUZ5CNc9kH0BvNsqNLXpcwVkQR0C+evvfUfsw7n+pRoe5OaboFidQmrTKZ1Hwbq5JoG0Wrex6rje1gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q65kXmIixyWranXYOaxt/D1cL8R8/LmZCl6ae/IciN8=;
 b=pE+3yxqLSqk/DnrpXx+lygoC/1rOQsRD/P9UKfBdcT/CC/cOuXwt0+TbaJdnRM/WBeOMCs39egUZNXOoj/kCSfYErg+R6PutqGUZ5BRU93bEfzlybZPj/KMasU4F0s8xggoOOTxN6YZm4PblRfSSzReZyFNVbAJV1wdrcj/+RTeJWzEsU57yGS5w4NOiAdew5jlnA+vx4u/KUrdRBqpjcM2Z//38bIJDqq0jIarUYbs14+6pBJO6ZbgVQRdSMa9Aw719S3pFD5rHch9jGPrPzL6Yu03TmtvzFFaYF18jAUtvJNEnE0imcFD2nrRRIoeaKNw6GG7EIKbBjIHifZXcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q65kXmIixyWranXYOaxt/D1cL8R8/LmZCl6ae/IciN8=;
 b=ir0QuMFPCJH753Xz0fTyGvDY4Hze2IocpbBWFXJt9TtwIXDz4aVDX/4H7ULUH7G1zMDJ8/KJExrDflI2Jn+/DcRYwpAxKVxdkVrIKuoJ7QtyXHMhdk5P5dgOkWGO+XBHvm8xmDlmQJAFEgXMKo+yyBP5CA2DjoF84LqnlV4dzVDomAILi5IkUcZ2mkVVCsxkpS6AT3Z9KV6O5jtbpKDDl0m/3JXQVA2AMFiNaLbIE5+yj5uvmb/rVArEk3BTwJNHZ2YV0f0wnJ5LITOZY3ls5WftpbxY96PFbUOKX29bDc/DBbhYSy7CvrFpCVHlFxbZr9AZ0RG5JZexhVt1qUbxlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:56:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:56:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in remove path
Date: Fri, 15 Nov 2024 18:56:29 +0800
Message-Id: <20241115105629.748390-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241115105629.748390-1-peng.fan@oss.nxp.com>
References: <20241115105629.748390-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: a7496ac9-e996-4968-a5d3-08dd05643a73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8t9+MpUBeGPGs6GqmdiBlYuW4iPS1TAqDVmUSBfok5V5yFF5ADN44lj6X6XG?=
 =?us-ascii?Q?BbbIrAYywXkwoHzBV9t1nqxS/PXVjCsi3+MZiH+bFPLVLCjSpEaNpGI3GvdE?=
 =?us-ascii?Q?M+y4gMwzgb6wG/95r4DdhMLuRYxIWo3LrP8dygIhc5TGEMz4ur/RS6o93Ffh?=
 =?us-ascii?Q?iBT+Onas/jO5SPwjewK+DTM7UfTcfH0CAQDLryE/lb+Ak1drXork1pqZJMPI?=
 =?us-ascii?Q?DuAGjLF8u0aBoiXwaVXU5paIKUJ/u3fcjniZUQ1D2d1Wl/vuZj0srCARuw2Q?=
 =?us-ascii?Q?fkLZzkg4ogSvNPeErE31za8kCvyNLnpYN1ir6hbepfPbBT56Ae4Z52JfPqMe?=
 =?us-ascii?Q?p6/c132F+5hb4u/aoPFxSrGZPHV3CvOhR7WfMi3RccboDIhWoxKFLN7ttmG1?=
 =?us-ascii?Q?o1wiBU8nDa/hZZiuavJzVVYv4y9XHqYF6bplaGC7/LlBQd2v/8wnMKkVSD7p?=
 =?us-ascii?Q?RlRnsIBRnqCBsKpLduslt1V77t6Ycqb78N5OABYOLe6dvXwVlMjCl++dtzZw?=
 =?us-ascii?Q?mjmqL7j9I1VxjDsVGvrNfn4SZRaWEv2uol0OPl5ZEWRwp+LnW/URvhJ7sHk4?=
 =?us-ascii?Q?kKu4BCL/uvV7Cm2qXX6buzb5kijZ3qe1BVmGLUJEETQMLZO8a09HVE9z/Gkg?=
 =?us-ascii?Q?u5PMGfpSw6SUn/I0gG3OfG5ocmpoNAeCxsAtRZPLcejdvhPvTQEmFxjlyRBp?=
 =?us-ascii?Q?2PjD1rAEoPO7UywIiLuBCAAbxE8eLYSzd43lwGNKvT/4RUZDlA8A6/F10i3G?=
 =?us-ascii?Q?NpHfQeLK6lueseSMMxbljWakLRVkcjWQY4mvj++nMv9PlGZkeeyJRymjAp8g?=
 =?us-ascii?Q?vK0axpdu3XEf8Kd6ZJ2jvp0E1u3c9PT22lENjFDPQboc2v3KzdQAZSAYFWdd?=
 =?us-ascii?Q?ObQLmidLEMsJuIcWBiRzB+lwXG7RmcpWugrMUu8GxRY28+4+c4n8LHt5CSql?=
 =?us-ascii?Q?BgVOoKLAu9dthdwSTSkTwBcuMYdpO0zm7JolRjF4xGgsOuEiiI4HuCC2ioBM?=
 =?us-ascii?Q?mN5Rhq4WgL+cQ1H8hYenxZbFZNlJV/l1iPxDH+Xgw+q4fFRGqIJVhQFdPFWH?=
 =?us-ascii?Q?mioMqepQ4lhsUwlzRMNoAWOvT9TVXsW1ZgEzJcajm9SPx+V+Rj/NM+nGx3Mx?=
 =?us-ascii?Q?tfF7/xbHTKzzX3TM//yGtbZcc/2xon+Jh8sE45nBGAMkKclMTVnDqfTWo4W7?=
 =?us-ascii?Q?ktCad92JiyK6oznhqA1Okmsz2XFJtB0girh2N7698BG1hl4KsuoLSbbD0+qk?=
 =?us-ascii?Q?FMFSQMf8RzTS7X/MkstOIMkH5eWxjFzDRU7w9sXBx6c9zNx/r3DVV1iTQg/3?=
 =?us-ascii?Q?pJAl8bBEscObazBk8sH3oCyRR9LhPVY3/vDGuzRA0KZLwsL/qCZXgo3TzdLz?=
 =?us-ascii?Q?4PNVXCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rU0i9FxphGnhS2soAobiizvmcVfieZw8RLg/T8MZ3PopPrfl4N/hYFmYdNEH?=
 =?us-ascii?Q?AmOaHIETTxWwtmL42rtu/5FvePxl3MXs1Xk3yVKNNnPG5eFf1wm02dP2ie4Q?=
 =?us-ascii?Q?l/tOBoTHUbxE0AprvxInp3doNOgAX+MB438PVbmBqpF3l+dqR2iaDk0fr+tj?=
 =?us-ascii?Q?JpikVpaJVqUoIy9V28zrr80uZY3oRvtG1tEWKQPoo4xnFwt6fCoaEDCiD74b?=
 =?us-ascii?Q?OT5Djbl/UPHLLy5ceaFqOVlL38kX2a4yJXhIqaJtlplt0MCrft+LZzRhxhR9?=
 =?us-ascii?Q?za7DoHEzpZun+WwEdJEgy+6CIi0jrnOZbO5UOjYw+9+MQkmY9ZiKTIXsMarO?=
 =?us-ascii?Q?QMh7xP5KX0RIdivz4SxKY6BCuWsEZP3sTi6t+eGSX3n4BfAoVsfneaIETOoV?=
 =?us-ascii?Q?M5QZiF+n0SvWOPN/FNVZoBJCfll5m3ka9mpOjFXAULd8CGPp3bdaaAR4fcCF?=
 =?us-ascii?Q?Se2qYmbfdIKCc06V91ZJ8ylCpkwkJk850Z+CgpG4px8tEQM8mIypdK9CB/WV?=
 =?us-ascii?Q?19xCR6b/0V3LSHmZWDPSuKSUjFl5AU1UpR89wIAxImqMS7+IGN6okEMm92RP?=
 =?us-ascii?Q?LjBSOz8+l4dOYSihsgux/DEYTmuaerckPdaHtSXn0a62r+g/GJ6qyv1wl/n+?=
 =?us-ascii?Q?iKhMqB+Rx+bnuFy6Ee5RTrUlVJEONg47CdywewIzdCEUF73yUv18/wrtUw1q?=
 =?us-ascii?Q?BuCm59An54b46h1hcZuqZZkGHzn0iyJPHuLWtQCvhgjnOHDXIZXgUCNpXFiV?=
 =?us-ascii?Q?evIDkN9YzcKFC2JFl10u38HcCo+SGgmFbAHOLZoJb0yYwWJVXr9QWfjrWepA?=
 =?us-ascii?Q?1iCf57SzEVqje7HcIczHTUBEp8WmWUXAKQ4ibRxTmezgPMb/EqEgllRg1AUI?=
 =?us-ascii?Q?bk7VhxQIYIb6975PCa2u32iPigmeX0mPd5rGdrk8fBeSlY5brGr39k172iaO?=
 =?us-ascii?Q?86ynOH+rQzMaDvUmaf5Z5+Iipd9uxfCYbyMaf1gmQWT2mNtI/LZ3eLfYZh8P?=
 =?us-ascii?Q?Kp+OZil3F4Q55zgTS2+plPeNqAtSBpZa75LsqLaOcgdBkV6ZnpsIQBHelP1t?=
 =?us-ascii?Q?4MLBpmv6vwQE2hQsP209L7lBu8YIJ+3pRBmBnk1EK+LsBWdfHejLIQ37a4/1?=
 =?us-ascii?Q?opSmPn79aCPDYTnVMFY+fnM2K65fNHhcwMbtzGRJDj4RS/UUpMTI3I9hjEDu?=
 =?us-ascii?Q?fmZl0oez+HeEpIJSjmi6hPq5DDb8WgxXrUN0Ww5M4uEM8MBQrPN0GTgxoNPt?=
 =?us-ascii?Q?C/aX/8iytl9QuW3Edj6n+CBtrz2RfKbVYbclhKnyXH76hO33afHNfrIpIEja?=
 =?us-ascii?Q?39eRHo6dQQ28F/5JV1PNmduhyJn0zU7mxhidjj+8mri+lvTxf1D92Hge/ATx?=
 =?us-ascii?Q?FGv9qnzcip2QHbDXxHN682vGPisZ0rDTIeIydCupeCtB/iVh/ieH4YZsixdE?=
 =?us-ascii?Q?1DrPj+u0q0xgJwwfhjoIpURrcMjnJ+tzIckCWnjxozkSzSxqgdyc/BUENGQz?=
 =?us-ascii?Q?8UhVkfMtMqTSHA2yU9Oz5AA7Q1uXitn3x3kM6LZd8kSCLcVKJ78z0FuNzjjr?=
 =?us-ascii?Q?F1jc0TS7sDxjfCJjKsfEa32w/RE9Kr2fAqpIT97N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7496ac9-e996-4968-a5d3-08dd05643a73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:56:59.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5nf/Vj8F6Yzv4MBWmLtOEm0dyTFwnDv11SZha92WiCPP0DgjHggRycV2OLHk4XZmlpioH4Pl8jMUEBaeNnYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416

From: Peng Fan <peng.fan@nxp.com>

To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
fsl_edma_irq_exit to avoid issues. Otherwise there will be kernel dump:
WARNING: CPU: 0 PID: 11 at kernel/irq/devres.c:144 devm_free_irq+0x74/0x80
Modules linked in:
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc7#18
Hardware name: NXP i.MX93 11X11 EVK board (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : devm_free_irq+0x74/0x80
lr : devm_free_irq+0x48/0x80
Call trace:
 devm_free_irq+0x74/0x80 (P)
 devm_free_irq+0x48/0x80 (L)
 fsl_edma_remove+0xc4/0xc8
 platform_remove+0x28/0x44
 device_remove+0x4c/0x80

Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V3:
 Update commit log
V2:
 None

 drivers/dma/fsl-edma-main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 3966320c3d73..03b684d7358c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1) {
+			fsl_edma->errirq = irq;
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
@@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
 	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->errirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
 	}
 }
 
@@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
+	fsl_edma->errirq = -EINVAL;
+	fsl_edma->txirq = -EINVAL;
 	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
-- 
2.37.1


