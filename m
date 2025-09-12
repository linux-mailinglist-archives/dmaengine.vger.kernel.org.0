Return-Path: <dmaengine+bounces-6475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2BB54008
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12141C85CD1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 01:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE5189F20;
	Fri, 12 Sep 2025 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vBO8HqLW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E513AA2F;
	Fri, 12 Sep 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642257; cv=fail; b=ECJ7C5cmC2RxQ2ajzOcE1JDfaDtSiWscvoEaD6BDMUsQNQNpgZAEeAetoqnCYx9VgIo1ZTsYtcq7QKKPywAfP7bFJBj9ncrvRalUnJ+JXoLGnh9Lbqy1DWrzPAqyTivsAqMNG7TPkaTjY2bXl3dv84Pu1r68IMDrdGprO2HxEbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642257; c=relaxed/simple;
	bh=UrYS+Y2ky5QcnN1EZ7nASvPz+Vf4ARxHEJrPc7Zmrvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l4F9XXpjO4PdenPn3HgKgrZPY79+dPXwETM2mPDoy9gKcps05CyOLhXx/PJ6a0gSHoo7lOZzKBuOF98KtcJMRGyQaB2eFBpEaYA4BgOWIs5ie9yNm8mcTXOLW4XHTbFV3RsDZDMc/ZCAq2uUG/qmHe2Gg2uYkv8E0I6rQaicB8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vBO8HqLW; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYZaXoV3R4GO6PJ/9UxTxZx/DJ0ZdcBchcySlQPKqExX2sgtRA3T6I5aX8XiaGXIhEzqu4OHt5oEHkUKUNlSobWWoRRwvAwyIrgsJ+XH1QTXYKGDT3rA4AWMdFPtqPjdA+sU+vQosZk5kB1phnzr03aItPcwb6D38XVkimodhlw1nINaARPS9QWlp0FtEfmtBUZ548A+53hUSJg/Dpq+H6JBcMl/wLz1opmNbQEttCvY7y5uUMON/Ds0vdHafLBE8wtXSX5n9k3VvRsDRJHKRCfX8bR2Z+Z8R0MvQ++EXjhUMPjmsqDm6g6jNGj5LMfQ8I4uNLQjfx1E3ngiCUeMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrYS+Y2ky5QcnN1EZ7nASvPz+Vf4ARxHEJrPc7Zmrvw=;
 b=HMDDUKM0HYL1ZYI6qnfIn/covu7ywq8wxu2dAz2kQ9WFd5QAPIBFaSn/ms7JKOP5PEn1SoGqlIt0gLiQhPhO/5V9Q5N+Xj3H81d/LkKNkBJQ5sKJJOBozTWjw2gD/CoNzy0V4g8Pmfi6ORI+hh866nr5GRzKMSTV02gxwsfWS4c2FATwlicGLI6SSMxca6vCipQAaDkXhN2dbPqo3TYiKJuGoLXEmv+rZz4OUahltxGseVbUU9iO/amEGq1aksGYLb1a3kVQh4nkToNsq0IiBvnm78ZQ5pPKzjcWzgqpKejYJrInEBUHZUK7jn80hm8vOYR9FyALrLwKZMYnMhp6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrYS+Y2ky5QcnN1EZ7nASvPz+Vf4ARxHEJrPc7Zmrvw=;
 b=vBO8HqLWxe4BJV+fnu87VCJk4QRviNfdPo0KUc4Zqrtx+zgnX0TGmq2efaWBwaXL1YsSLHNgc/G3YFYO/HWiCzPf0qtls+WnaHfRrVe4h1VpJvARm9WtMlwKN907taxDkJCO4GuC4pKOOcH5p28QU/8BC8nV0Bi2ZB7mzgvym/Hjmd1gtbp28wPamtvjaWcaiSYxLZDLQgB/CC77WG2740TK5GbD2tQrKDEbC+vOfUiROcwQjji9rpIPXnTLk50YJiILEHdP0j9cOUL2SFl82D/NeHe2ZnNOxqITQXZf2r3XIfpztLy2JpKuCkPJND1NoAFuA7l/4ADzzMQtbv4DpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 01:57:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 01:57:32 +0000
Date: Fri, 12 Sep 2025 11:09:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 05/10] dmaengine: imx-sdma: cosmetic cleanup
Message-ID: <20250912030902.GE5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-5-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-5-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 35980739-9fe8-4674-eeea-08ddf19fbc65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CurdYfRMwwUA8KAT6TEmg4elA5d35kvOZ87nG08szgfQ/79JoaAiC2ZvfCXQ?=
 =?us-ascii?Q?JHL1ySnU17FL0M47BBvPeCSxpJRwnCNXrtv/RLfbqf4LPQswPg+hZG5FFrr6?=
 =?us-ascii?Q?ygp7aiIe6JYwmt+KfX0OCcbt8FFlkfHCIzx3TAAsqr7snA/a5CEUxdc6ho/K?=
 =?us-ascii?Q?5RFjM4HACQP7FZbfJROCIp4qEV2ABUUjjrUG8m5VlOfLwl8cwoFL9svk0X51?=
 =?us-ascii?Q?CdtiRtgE+KpgHb1gvIjRZ3IjeqXmASBZokMXkvxIfPd81C8/I8viqrk/6att?=
 =?us-ascii?Q?k2mOVJrU1u52wTHkk4PoCwzvwNCy4DmazwdxtycBd31G5nMWb5OR8CIXpCpi?=
 =?us-ascii?Q?mX+ECeiyjoTos3kTmLCLJifXpG/B53s+PsWph9OwnKlo7Ar9QTeK3/zbjaGo?=
 =?us-ascii?Q?1oVS0kB/gU43KX5NR5CYJ6AXE31x5X1vhmQPsqDG4oNFoxRPKaErGSqrzj5C?=
 =?us-ascii?Q?NAXwnKKsWn7fRl/fTUw6N1GeR4xFtM/9+1gDoFM7FbFQoqVTw9CLvbTDvV0L?=
 =?us-ascii?Q?ORpqj0XW5ZbiD1H/izsCJOcxSPfvA7zeyPG/mkP9YfmuX3/s/o9gSMUvt3zo?=
 =?us-ascii?Q?iSkM3vN44K2II4ZJjDFhplgr8mJFqJQlqczX+WvRz8+dVD9CD43WQXaEYkpz?=
 =?us-ascii?Q?FbMnAxpht2ZKI+US0HGEhLBOMOv3WWL92ZYHBOceouFl8fUeg6eWeiM4I2Gc?=
 =?us-ascii?Q?BE0wRODQY6oKVYLuSIFoI6LiZnGHTY+Iw4EI0O3VLPgKwaORpTk66LGZq9X/?=
 =?us-ascii?Q?93a96fvYYNFm88NdGU4AVkAaghelc+nS89QlwUFVCVPRpa6nxVDuNT13GtxX?=
 =?us-ascii?Q?Dpp+7Q2sTZIjPlWImr3EEoNzoUlSaXtX/+5UyIZYxhLATZPB/PfskWZA5/N7?=
 =?us-ascii?Q?hKdSQssChLRd4pBo8ob1Zogjy6IQ8kuWwquj+omolXg0EecN/vwha9dAqL+r?=
 =?us-ascii?Q?/PkGjaUrn+q4ehbq1cR7au+uzNO8VWCiyOwId5LhwniDGAjg2vrLkC3w6MdJ?=
 =?us-ascii?Q?tDAT477AGSBS8q3HejSkM9CVBKICV7IBUc0JmWi8CAbt3K8eqUh9mTlnQPo+?=
 =?us-ascii?Q?VW96pgvPmXIdZ/NE6+CoONldd7d224ulc/6u0KxFR9xyHd+VzLP2ORk/jF1+?=
 =?us-ascii?Q?938VfWfbKyd8ST3m4dp6HV8W3E8pJoNJBXK2LFshjQofVECVshBGoAV78mOk?=
 =?us-ascii?Q?EXqPbndmnf7zOjbunBnt6NyrpxaEWU6KWuV5i4jw0S2WlJE3tCp+VERic/+4?=
 =?us-ascii?Q?Hm8y8M+HQ/XBX0EwMjuFe5yhAsgssIvXcdXcuhJTwmi7eOGQQyuh6RnA5Dmu?=
 =?us-ascii?Q?dSqHiXv53uaxy4+WFYakJmahrvRkKQeEfhfZDqywKbImeVKdcrrc3RqMU55k?=
 =?us-ascii?Q?2+A3e/Lsv2lrP40KhYJkzgAAGwoAXv5RslxL3ktRndvNki5YE3Cq/j5M1Sba?=
 =?us-ascii?Q?QYwizTbU+rE+zqg1xiGw4OBFIUMGHpXkyVd+otNF0LZg7/ws6Y2a/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RhCLWBPnlkGHdp0w2bbnzQ7GKeCFOE8MJvVeUIu8Z3MMH0xI3SYX/g+PRLfF?=
 =?us-ascii?Q?fc6VeWObGkVU/iyZlfHvjI1k5+MChuu/31KN81dnwDiF73kFq7T4yyFQPpYi?=
 =?us-ascii?Q?lyPaRHgxwYQqIHSRpzrVBbzEr/ud2w2iBDmjtHIj3YHFtMhYmVO9d0NcDdRn?=
 =?us-ascii?Q?ze95c2xgx6+Mj2MEzEBioz/sTsWFaG+p9czffuZOQIUNqHHCkBKelmUKd/Kk?=
 =?us-ascii?Q?3jzbCEX46bIMBsmxYKmLa4fs2HCYY6jkWCz2Gym94rhkRod6DsYlyckEbt7h?=
 =?us-ascii?Q?KVBhYfshhjMemSqlT43ggMCHG6wU74O3Dh57ZhoKaDIOaIhQ97YmjLSTasC1?=
 =?us-ascii?Q?oYyAYDYoxxFC0D4KCfEkKb9j2Vv/QtQQ+SNpZIZLOSYUUhAbFwQkSXJPbFxH?=
 =?us-ascii?Q?6r2g7DRFbQyN3cck1ecKU5c+pOpmfhSmD4+p7Q/8KdXrOV0gXJ7aR01jekFu?=
 =?us-ascii?Q?2T0tOvUHzNRBM/r2rg0rUG6J2dlbac+k6SVWvCvtNDtiqjehyeHN/oVeI3wz?=
 =?us-ascii?Q?iYgyrga+gfNJ+7G5WtazwfAw8E0ryJlhqWS6aO+uKonmNxU8lxgJ77YCHMAM?=
 =?us-ascii?Q?NIFn4T/6sAK0f1ZIfm4q6w6BqzSZqhxYy/SBVja+xbCNNKwGKPWlQoBGFJey?=
 =?us-ascii?Q?fmyd/2dUI9W347NIn0ChVK8IO1P8RgWioM1wbSzVNBOc6J8BhpUkJHR/fKaM?=
 =?us-ascii?Q?ubFBj/TuLG7s20hp6cRxxGwIoa6B4f6WklEgi1hFpG+NepIDWrqzkJekVdzz?=
 =?us-ascii?Q?m/z0AfF4OrV/uZuJIlUb3wj60bGFk7mj6XYDgEd4hyxyir6dRv0+6NI9ii0t?=
 =?us-ascii?Q?0PcarDVfdq4kFwtZRiWMmWXDL/zqxjCqb+NpVPe1V2IKrA5FxBbFKGArn+de?=
 =?us-ascii?Q?9vsmgMrUk274tzxSsDIvfsiV9Ekz/ICbA5rCKRUiHEAtxNimJjNxEEMlXQck?=
 =?us-ascii?Q?SVflRIlvcdWf9Kq7gistzEWzNypdm8lnQoA0vaktQm+0HIidyDKmei7LygXq?=
 =?us-ascii?Q?+Iw1xVQRCQfQDrMLAwlJ/y+fsddLvUD1ArhlebtqW2BJ7TlQLzk+ate4rvwu?=
 =?us-ascii?Q?AxkKra44SA5Z7h16qiWAurj1hEgI3rznXdB8x8dDy5u3cpn/1pgjioXK4v5e?=
 =?us-ascii?Q?eEho5b2wnaQDVsDGl5/r+avcwhW1PsZMWlEW2+q8h5Yc49Itf08iU6bdSaBp?=
 =?us-ascii?Q?XjL0Wmk7j2zfs+1ajGhnvX2nU6LyEYGSePfDcndYS1KG40OR8eu9i4UpTiG3?=
 =?us-ascii?Q?/ECDdsQ0DMh0ZnF53WWsoHC4tFGj1yH/AatwOJI3MtV7k4uqvG6yOBZs/Kp3?=
 =?us-ascii?Q?lcVCNR0h9Kbzls4T8K/rIDdRxWUAvfFXkE4m8EPl953ZXsc0zCPqWYZEeUKd?=
 =?us-ascii?Q?mu7vLu6pgFsUHpl8wZ0FdZ+0mHJwrL9iEKpwolyMTHqdSyNiY8h70WZ7cqop?=
 =?us-ascii?Q?x5kEr9ITNFo4XEHHjF9lI1ZNRXO+rsHVoZu8mXOuueYJTRDS6M222YPYaXsY?=
 =?us-ascii?Q?ByKzEZm6VJYmqHS3TkkpTIUcGfNv/Ytkp3ykq0j8hOtfwJh7d7Lj1TJFIz6F?=
 =?us-ascii?Q?uViPHZwW0pGXkiOl/ijkgrkP2qsqoygHmK94t38y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35980739-9fe8-4674-eeea-08ddf19fbc65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:57:32.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5TGjghRv5zHE8hndcOCLcrnWJ+ydPZuWyDT1tJyfd11W9qirlCB+NbEWFmJdVy+JPq8+Q8tHAzNw43qdKtq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055

On Thu, Sep 11, 2025 at 11:56:46PM +0200, Marco Felsch wrote:
>Make use of local struct device pointer to not dereference the
>platform_device pointer everytime.
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

