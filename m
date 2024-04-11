Return-Path: <dmaengine+bounces-1810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9298A0602
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 04:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2371F23E16
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BE13AD2E;
	Thu, 11 Apr 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bwl2Fdbb"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2128.outbound.protection.outlook.com [40.107.7.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3613AD21;
	Thu, 11 Apr 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803004; cv=fail; b=IxhqpdI0Of54orHkx7+6EZY4OuyaouIryEkRFXR8CNrn0G7uLA7roSC0KeVNwdwU22DXG/oy7WMZYvtLGDUnr3Op7hA9tretIlcjQD/mWtt8Vm7EmjHhqgmqijp8B97gsgCbNfKmcrmpkDEHI0Wr7X//lxldPCZEUGBgslw2G6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803004; c=relaxed/simple;
	bh=tX265sbi79Pu040bIFCGj1m0Bh338HDwnPtUOo80U0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zcjn54yNWVDDgxPDIPMDiHgP3hP51s+5IJopsLcOjQJMf/O7889iziGzQS9pEU+ntSYz64HNDfrB+znTRXvrmO8/0VJV3C0L3a8bzlPv6n0DmIyrU+5w5+dqVH73GGXMYPiwjUqv/M7YJCjCVrOOZlapPxJtJZROuJRHt9qZKDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bwl2Fdbb; arc=fail smtp.client-ip=40.107.7.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug0C35cjQivoB3mFEp6FtKieIVTYFAGnkzLchmKS68/F9Dx3zoviTgOqMfJwrTj/fz/rrAO9x8iNsOGYZq3tuhucPwfhdF9P5vmRlJXALvmp0A7+dBMvJHoo0nEDZRFbZV0cGjRk9s/idvhIZvAwe9DJond8xg6AvhqoEJpYpw0h2jzFDy+aRaK311SSoZrct+8yeu+cwIBRRFHZH2JFSIOPugYdQ1iNsALqVYPL0quLvT8a7C9mMHgZY00AP+UdJkUVlnthf6tDf6ajLV6ZlZL+dQbwbDJcC2bh9mt2GBCvN+AjIpK2agDUfy2Zg7JZpavNYDcZK5uQueUmESM8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpe/T8giLK7UT8DxsrSx0Txh0rlOr6bfxIcdJfBkDJ8=;
 b=VyEsAQeebDdFc3l1FSEpPtN+TT4VAe6IkZiBKyJU5FCxFCQkFbQgqBJ1p9oB3IyQTzwjsxdubO3iJKznRl0iyC4Wr6KbGxTi39QOmAxoHuTShH48yPnSMirN8VjiPhfuiB63VdV+GdVH/T4uONOIvzpLFDad6LBBtqM7bxxOmW9PDL5PCO27Ny6rh++zqHeoiWtb0cc41hFjvXYX6cvLlAzUHBLb2NGXSAXNOJtqCxWnvRIJ2XIplmtc1X8fA72xZkhzOSdxlg86KAcLVwO5reV9kawNoqDHgwlGax12+nB0EjKky4fwbcowfz6VZPKMEJgaApQoGgfGwpjQgTrZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpe/T8giLK7UT8DxsrSx0Txh0rlOr6bfxIcdJfBkDJ8=;
 b=Bwl2FdbbZs1Cx666ozEE2ZidKwaxFFZPE/VRko55lOnrmPg7SAsbgCCIGOGL8hMXYF7YQH5B6IlqGWt0OikEKOI4WPTek+Sn4JsqepilICT2hlpuwiiVCBMc7J7AezlsLdoZL6twP4d+5DCmizK/gS79Mxbq1WLomj6c8otclAk=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 02:36:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 02:36:37 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] optimize fsl-edma for imx8QM
Date: Thu, 11 Apr 2024 10:44:16 +0800
Message-Id: <20240411024417.2170609-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB8599:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L9ydlOpWlRazUmD8YgB2JdsuIGYb0YAl95S61WMjvYz2zSfXKPOFQOXpjeN70JvwOGb32AjcBGUNvj8+dP+jzofYZZDPHHaYQjM7cGP8ydBjYlytFNznryGO1Ps7fHHhp7hHNEQBjCE82I2emfkBvfmVT/tXX4nKf3f0XE79+NqTYb/NZbnjhFSGz9pBnd74WtFsQBZfhqdmXjLg4Fohbn8PzA4va/SkCHs2pjtyMIvoBqOMmiMfoil28xHR898mTRdbMd3qD6txfkKhANh7+haytEUYK0rbywdxJsg3KBPaEYLPqeHkb4RbiMrGumnOjmd3SC8BQisMY/5kICUmNEmuoxlAUJ0ZsPCnhaG7RenlwOHuoU2Som0muQmxnAaPwIaMU5Otn3+ONdkYMHb9f4vyBnPYZtDwHxYffNaz8Mge2aunpkBfcRbCvHf9odqHAt+5QD+x8M752BO9aqLEREEwHN3asfJyiKBK4gjQyJ3QIJ5iyQt94qhxwXAuGlO/t7NxuHRLHvhNuzfHhSacJRgC+wNJxykrR0IHTbl5Bkqe6gtVzmsyTBr4Uvg1RookmVJUE5fj/n8noorviqcxqy7yJlJKn/O09CNowP8VoOuuAiTGfXDJf15fyiNBUxF3T80MUSL7jVJkdutXp/1ILKjUj3lES06H07f+6+nV20aJZgE8ByuBg79daPXu563i0WNU4NK5BWhxvYH36PRV9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rw9FIGDFDETqsqRsvTeKuP76m70IAVuX9nN4jCopqrUZgSBsbtsRykB9Tqz4?=
 =?us-ascii?Q?ngrhuTPwxDUt0iJAA1NZlTQirXG1y2OZ4/5lHFmUhPNdQkIwA/9Q02gg23G0?=
 =?us-ascii?Q?9hFam2J+Q5FnK9E6FidSugRoX9DVOb51Upzi0wzzcWNU3t0FyUUB6mUt/JOq?=
 =?us-ascii?Q?pusJ1vi8d2SoBoWL69qOhPZLNLAggvhwMuEPUXdA4Y2yO8C7/+oAn8MPR4Q8?=
 =?us-ascii?Q?A7hwxfCDshW/DKHzpU/8ow60ngwbCkr5xw4dmiBsVgY8MGZOJynHrJ3cJUX8?=
 =?us-ascii?Q?PjN9TEwEK/wdK1rIMAevYugUDfpxgfJnW5l/zv6WyYtHEFwDnuBiuMn3ZHbb?=
 =?us-ascii?Q?M1AWGbinTLgzho5re1d0T/Fszkb2vjYKI2yaRD8z9N2xHpK3UOHhDdt2xn8v?=
 =?us-ascii?Q?AsMmLjBw/eA4uMQgPRrMaiemg0ikacvz4RmlG7yVu+W4QzmU5r9gQjT2jzN0?=
 =?us-ascii?Q?qMD3ceUAHOCbmbrzQCyUt4QJReHpwAKAGPc7AW+2ry3QuAR/uzIzFHQOe3sC?=
 =?us-ascii?Q?J2ZqMESUKbTqzutP/w0h9D1A0DfUxYMerIyX5BNr7HZEmku71yCF6C8gwAVC?=
 =?us-ascii?Q?LSqWucnGp5GiKdKMkY4yU4ep1/xC/eRHywyEPQKrdkFPYK8dtQEKb/zRnK+T?=
 =?us-ascii?Q?GXohup3yd//ZM/d6wmI77US/rFhHPe9+oHkXOdGh8zXpb9HdFXaB5Xn2w+zA?=
 =?us-ascii?Q?jsRoXydN9voumHRt0zl+7i7L3OWmQbOAXCoW9pVDEDR4nmtUH3ZCz+yVvHJF?=
 =?us-ascii?Q?VALsiO2uFaI5lRrbjx9k3E/eTo4wPifwRgm7+I1ACyyxawppuuyN6uXmv2m6?=
 =?us-ascii?Q?5MONB2opn16+Lasy5Lf2rthuzGS9haaaKmPC4V8zYljbIHUG9aTqfU8Cj2pf?=
 =?us-ascii?Q?3XX0h1E47DveFuXA50/g/yDkwHzrZ270LcD9dOPhRoB+OPuUIcfrXTWFpHEC?=
 =?us-ascii?Q?d3mh+hE+FuCfiWdW40KStjt1RC6FOApcfGWi+qL1OfEMEI9MM+6326Q2g9WM?=
 =?us-ascii?Q?C4I3rFx5ic6q5aCHu5nMd/kkLVZ23EE3rI5SByMRS7yTqhaW3xTRHKgzH7eJ?=
 =?us-ascii?Q?amg+jAqge+Q1RwdkL5Un5o0ALAtdhVAalQci5I4Bz5QCfcS5DD1TFsbRPrdY?=
 =?us-ascii?Q?wxC8GF5xauPgXHz+BW85HoRu51mwPfg/smTkNWjn3rOv39HxOQzp6EczWSxP?=
 =?us-ascii?Q?6WBY/5z7WOFb6otwpBc7TJjZ4vI5HJnM6vLeOWQq1JHSovNQaFyW2IX25fJf?=
 =?us-ascii?Q?MMh4clpJwmlMwSbbKpN5Yq/J2SctlXE8x6a9rDhd5KbySHLN84loHR8H5bxb?=
 =?us-ascii?Q?yCJNYgwqp06H4z6WjhGy50deJcKViTGirfS8jTdQzr/K3FAp3zo7G7nHzYHQ?=
 =?us-ascii?Q?eEZ/SBkzpFv7K5AZXax4BcGGcfX7mQcAVaIfSv1dK6wumLGFd9x85dm6AkDb?=
 =?us-ascii?Q?2zagLUi+EhdgStKznKV5tCZ2nWuJw1AlJNTcqUBIT2LqrqvZINYMKLSWy9eu?=
 =?us-ascii?Q?PXoQWPsoTF129wdnYdaFd3U+pOV4SJUMQiSSAhAQXViEP/xylH9YiLqCamQR?=
 =?us-ascii?Q?ye1JbgGrnLHpE6ejsVgWps2Tzbbu/DYjHTGoPBMa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f221a183-78a6-4dad-557f-08dc59d035fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 02:36:37.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VyyLLrWmzT7Mg8/1YTnYbGovYMSP9uxNQLCz3Dwlrs4zqeWs8y1JED97EX/0HdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

The patchset optimize fsl-edma.
For the details, please check the patch commit log.

Joy Zou (1):
  dmaengine: fsl-edma: optimize edma driver for imx8QM

 drivers/dma/fsl-edma-common.c | 16 ++++------------
 drivers/dma/fsl-edma-main.c   |  8 --------
 2 files changed, 4 insertions(+), 20 deletions(-)

-- 
2.37.1


