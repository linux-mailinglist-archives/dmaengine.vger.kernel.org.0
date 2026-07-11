Return-Path: <dmaengine+bounces-12351-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ghivAGNZUmp1OgMAu9opvQ
	(envelope-from <dmaengine+bounces-12351-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:55:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0D741D78
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:55:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="Nw/R9HEd";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12351-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12351-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26A0C300DD7C
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29229C327;
	Sat, 11 Jul 2026 14:55:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BC27A476;
	Sat, 11 Jul 2026 14:55:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783781726; cv=fail; b=bMEJi5FjVnGMgAjvPWMjHCdkdua5bkUd3xUgfkKnmlCN7EgCxpJmZCBmM/FcCNZp+V/hfGMBR3bxyoZuDcQu2t18PiiJoUYzjaIhBewi4y7/OMAuaSpp/Zk7UUUTyCCXm/lFwbXVsoC7lfRjhiWwp+czJR31BqvbUXbRqqGTrvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783781726; c=relaxed/simple;
	bh=QkPdqaejxlKErSUBDsnvAbtlTX3Y4RP+k0ogFAP9dec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEsALc1sZ1tXHvvp84nOSTxwC/+HZNBuQLcU2LOGSmqs/fgOCN7y8Jw2WYpnfMKsUo4Tic3etAlJRbiYzwiBhyPfBKxCNN6870s6bSeh84aZbEHCgQfXVMBUx5UoroejIlsuuRYwrfjN71DiFT4g8u7dthpIP5GUIX7QTkMTGhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Nw/R9HEd; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOHIG9JSRAevtXuBHaUu3oZ2FOpK36UvxmJOCGnVs6C6ubLnGE4kW86l92Xx0G7JEI1hy6vydESiSfvBHEhz1DJkDdGKhqgVa2NYWqctESen2Z6HgZiJz2u+wqibPUWWMtPA8cbbgEGAy+NOw9KuQs8bEgng72NXfM0/fVtUnCz/BriJZOTRSqEWtQTx8dyV3N+O4mCZMILZOW6oZtcp0EFxcvANAclRKXPFBBIBf3p5fJq3/P9WUIFN9ftbCRCWj0Msn6ibKlewJYk8wy1bfDHmbSoYYvgNh//WXw7Etk6qTE6abeIHnfnsvIpjdbP47LPjc/cdMC1Q1TDSNXr1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D19T7ilfYwrNzDjm0SjnNnSFw2WsJ8D3TqEFDYgPxgE=;
 b=jEhcB+SVyQdnHTy7rKned7auvnEKTgI41fEfv8Y/q2DAXPAVxmqq6xBWHBSZlN8ODhGD0U6Hy1OKnoTNaN5Vzn/Gx/Htfl4UZ9XAbpYaEkZzMF6BFRqIKrciKJmXpQkQ9wK/mnHzEQruZvdUjobAWcA9fBsYwoE67kp++ryo3MQIy/izjPqpVY8BQcpMLXEq2qfBb+ybySxgo+TfxobEt45e8FQXB3kT2xfwC9YeSqIEIpVIi3Cl6BUczcacS8/i/LCExmI7Gq/vTmQFk4o8S97XSbJE79GSWvwDYnRx/t8QNKC+/8N/PReOfKai9yol49HQKBM1SNI2Xpw1rZRtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D19T7ilfYwrNzDjm0SjnNnSFw2WsJ8D3TqEFDYgPxgE=;
 b=Nw/R9HEdcQTeBtRmeJ17Jn41hsf9e2XWGHNoIbDaR5tmOXqlBYgi55A3YzhDOtSUZQ1Gwqy08rRH2zrXTxGIV+EhAfRfMtVeNj48WB6jEGJeAM8N0GM+apNBH0yrfsX1dKexSNz+jp/fMmE5FVFI/il2JFmVudCbgqnK9MNA+JivMY2PdrmtX3OcSCAdTuRglXVnz12ByGHll/PBECLYTmiQVX1TrAJhygdxu6K8a5+r+/jB4E74dr9ppwYu/ifPuebwnq2+2dByqwZElvwV5VQT3BccXObUDn/wFXp495I4kwG6Qn16+Bfo1FbNNtAXB+qOJCpmsTscIhlWOxDZSA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10520.eurprd04.prod.outlook.com (2603:10a6:150:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 11 Jul
 2026 14:55:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 14:55:15 +0000
Date: Sat, 11 Jul 2026 09:55:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dmaengine: dw-edma: Defer channel IRQ handling to
 workqueue
Message-ID: <alJZSKF7D-tx1BV5@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-8-den@valinux.co.jp>
X-ClientProxiedBy: PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1315f8-b79d-4c28-af5f-08dedf5c6ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|19092799006|376014|4133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kfeENfwa6HFWNeMUjMdNNjaDQeA3SW08EAXOezYjE1cMjaieZv25N1b8vH0tJ3D7ynbckKX4e6jq/ttg9kpj2iFljxmPOG4I7Pj1UOZJ0rPgA8yUlNICIS6Bz7AWOuYyF/l8y3GD6dGCbNz/CHIab/HIoK3mM9Hp5gPSUqJuia8/YGqzMViZQux0fin6LbmTjuNPQJyKKXzYuzo6W/sT3SfKCP0rka4Wjgmk4QnmntPYTqkzV5ffs2BmPy2zn+yUFLT9mpglzVDuINPQPb7sDws20MIfLP8WdrYx5BzFT6AFSJp9RhQQyWjuguoDH5tAlNTvB5exNb3ZMM5cwr0hjpMDbLwxX5Y5xB5iqpfx57nbnHjBbq9d99bKOkffENH7MhFM7Ff6sbGll7k1bUWBsqz/YfgRUtm/ZRm0P3iQ22PJZ4TFXXRiGiapmDhsYoqq5SFe1e8AV+XpT6KoR1xe1Eyp7VSlJTsXMUt2gwfvW6rUxwUr/MdQFyJnZy1LPTt7hHnFxbJoME7W4Vn2xBzeihGaScHFeWIBcnmJgVbRlhi0iJ3CZE2xBSDjiKbLGeKAF4T3Uim0KhGXfqlrU56HELLnC+C93oubQQP/dxUb2ZU9PpvKXDCy2Qr7Y8Q6ZASZiYKjlmIpz/HJPWBPkcQpy08YpBb1n/3tNVeAoUR1nUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(19092799006)(376014)(4133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nb/aWjvI7p4Lu4ulNAw39k0VXvXh1JnH1f2yDOmJDAO4jkHgWcvWfRedPv4E?=
 =?us-ascii?Q?6WREDOzm2ubOh07POa7SHdj+RTfDHCCGPysyrvmtkW23Q4lsyZ9Dbk1gFA1c?=
 =?us-ascii?Q?PNlVXRsIL4B/E123tLcuN4HaUlfQCpb9ryB5S95LSPzOIWzQr/nBpjQUkE+F?=
 =?us-ascii?Q?nuNeeTtsDRPoB3O6C+KvQ+ZlJN8moh1Garxv0VMv/IGSeiZ/M5YoSWHeYn+h?=
 =?us-ascii?Q?q+7LEbahYHq3TiuNZdiBNy6lXlNG//gIgGWdwZlr8P6xAfRjUmqmC1qTjxpH?=
 =?us-ascii?Q?6zbT0Igf6O9G4HR3TjoxEt08qPyyl0pI5AxBCCLi7fRcuOBZCElLsg+qeFne?=
 =?us-ascii?Q?DBJ9kukhFSuzvDlavrGxiixum8n9gLKbO/8Z9AIPb5+/wc3hj8ycZ4nBNuNU?=
 =?us-ascii?Q?Pa3XUXDa6ohkPItJ3NzxQSykiGlRBcrp9lk2M3E36FyMGGMHjscQiJh48/pC?=
 =?us-ascii?Q?glRChelhmn5xSTbwxT/X5hr1pnPJj64sq0hhyU63xhQ2nLB7BTHr2x3/aZFL?=
 =?us-ascii?Q?KNsxCQMj1q9C8rfBHbFDm5ixdj30VnuG/cxiYmdYuHzk3O6anmudRwyyRAH2?=
 =?us-ascii?Q?vN/AtEA5uN+llPs42X60VAZQsGWsCkGTikCKv9DCViX/qDpHO0hDW7COPs6k?=
 =?us-ascii?Q?cRqcykeZPGv5HExoWE9+v2GnYoV5mDcrpWgXrg0x1GlYf4Z6NMAVd1WOQjrC?=
 =?us-ascii?Q?QNYWa+LeRWEj0zH4N6Y2ZiPhOxNcVs19iQN/nNGFVFHRTnfxGPwYtPWKa6+6?=
 =?us-ascii?Q?KFcMW8kz7M19eFAW7VzRwQvOxSHS0LTyUWFJrseu80pUW4OR/RxXF7iyqhYd?=
 =?us-ascii?Q?r1h46weMyoD2bWicccgTvYSIiiyXj8hq/Fe/vVu90/wcAqjVzCNXeRsV//zf?=
 =?us-ascii?Q?n2+IzUpmhHj1HSWICTqEbpC9lbqtNYq1L2fc9JH/kd7Ep61eZ6NmPEYa2UT0?=
 =?us-ascii?Q?DzyYs7Uyg+ChnVCTyVp3SsUthchqyO/nZ2Y0oEKXVEyM3J3kXDLkSv8RB6j9?=
 =?us-ascii?Q?wmXol5QooTGlvPLHvQQ5B99MTD+ffcPnfCY3Av0KwoUMCqEtoQNZHRwNjlbv?=
 =?us-ascii?Q?Qvbk0/WXE/Jyd8sUkYbLH4cPssmPzuW5jSPM1YsmH1AiYilhwotxm1jZtkqK?=
 =?us-ascii?Q?qLyLincZaIJZmyia88IvjlihI/+sSz/6BCkuVw8eoN97OLHZZYoEbUsGYzmk?=
 =?us-ascii?Q?K5CU2ZOE6ZYL0ZTKSroporsXpUKPr4Ucf0mlfheW1iXIAF/moMrtrvpf3XSG?=
 =?us-ascii?Q?yDNO3AjjaHmFh5mNMiOpPz2150z87HXK9HpLbcPtak5YxQAFiEjUr9Uh+oRU?=
 =?us-ascii?Q?ue4CFkzV0aPiP4dCDdwkoGQLBbW2QYjVszKBKcjHsuwxXS91aw54FJooodub?=
 =?us-ascii?Q?Gk5d8mMKdK6IjAPkfOBnG/8wqwVD8dJ8Iu+SKiHRfOz3YwMbPnhpA5vgKtml?=
 =?us-ascii?Q?hYmHqDCWMK8AJ5t6GoONbLBB6QQWBDWRkINgzmwUXaSbTuFA7fDt6xJlfBWj?=
 =?us-ascii?Q?AFmUqwoHYA23PkuIzqAM8I+ZFj+rWpfKLFp7NrXacUjKveC3ahtaFQWgI0Ki?=
 =?us-ascii?Q?ECS5Nx48vkPs+hYEyPWep56D8she4gNnc0vZZRK89L08hESGYO9cl6Nd1wSs?=
 =?us-ascii?Q?8MQYHE2OF/odyFdw6c84CzAOFPBLK41MLDruXBl2ZSQbYT3Gz0mrTAeZvOAc?=
 =?us-ascii?Q?PE83GurCGWg+jQnZScThMC6gcnL4h4IqibN4vNibS+qGj/SYWZ7e/p7m0Hql?=
 =?us-ascii?Q?d3y2aJCyVr6InSJrcWEN++N8jx0g94hpxx661scq/BAnHfYsyR6R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1315f8-b79d-4c28-af5f-08dedf5c6ab4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:55:15.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJUvJFFzw1dfPwG2odY1BWtZ7PHf7Wq51UHVOzCCblSyKgT/ovuHI9Phn5qTiT3lO66LrDMXTN4FtcBEY7vShvmPQOXNLi2dIDKJnRwl4lBMYfWw+3aC3RLgDoTcYGbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10520
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12351-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FD0D741D78

On Fri, Jul 10, 2026 at 05:09:03PM +0900, Koichiro Den wrote:
> On some SoCs (e.g. R-Car S4) the endpoint-side eDMA raises a single
> fixed SPI that is hardwired to CPU0 and covers every read and write
> channel. Handling channel events directly in that hard IRQ context
> serializes the completion processing of all channels on one CPU:
> descriptor recycling and refill, client callbacks (the vchan tasklet
> runs on the scheduling CPU) and the doorbell writes all funnel through
> CPU0, while the handler additionally spins on each channel's vc.lock.
> Especially under multi-channels heavy load, the contention becomes a
> performance bottleneck.
>
> Keep the hard IRQ handler minimal and have it just clear the status and
> dispatch, defer the per-channel processing to work items. A work item
> per channel preserves per-channel ordering while letting the channels be
> processed in parallel on any CPU.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

It looks good, allen try convert bh tasklet to workqueue.
https://lore.kernel.org/dmaengine/CAOMdWSLVk136RzEyiN76zqk65VLwYms0hCDi5Kww9FQppie12A@mail.gmail.com/

Please double check if it can apply to dw-edma?

Frank

> Changes in v2:
>   - New patch in v2, posted as part of this preparation series.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 73 ++++++++++++++++++++++++++++--
>  drivers/dma/dw-edma/dw-edma-core.h | 12 +++++
>  2 files changed, 80 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 5664421c6f15..704d8f9746e8 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -31,6 +31,11 @@ struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
>  	return container_of(vd, struct dw_edma_desc, vd);
>  }
>
> +enum dw_edma_irq_event {
> +	DW_EDMA_IRQ_DONE	= BIT(0),
> +	DW_EDMA_IRQ_ABORT	= BIT(1),
> +};
> +
>  static inline
>  u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
>  {
> @@ -748,6 +753,44 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	chan->status = EDMA_ST_IDLE;
>  }
>
> +static void dw_edma_irq_work(struct work_struct *work)
> +{
> +	struct dw_edma_chan *chan = container_of(work, struct dw_edma_chan,
> +						 irq_work);
> +	unsigned int events;
> +
> +	do {
> +		events = atomic_xchg(&chan->irq_pending, 0);
> +
> +		if (events & DW_EDMA_IRQ_DONE)
> +			dw_edma_done_interrupt(chan);
> +		if (events & DW_EDMA_IRQ_ABORT)
> +			dw_edma_abort_interrupt(chan);
> +		/*
> +		 * Correctness does not depend on this loop: queue_work() can
> +		 * requeue once the work item starts running. Staying here just
> +		 * coalesces back-to-back channel events into one wakeup.
> +		 */
> +	} while (atomic_read(&chan->irq_pending));
> +}
> +
> +static void dw_edma_queue_irq_work(struct dw_edma_chan *chan,
> +				   enum dw_edma_irq_event event)
> +{
> +	atomic_or(event, &chan->irq_pending);
> +	queue_work(chan->dw->wq, &chan->irq_work);
> +}
> +
> +static void dw_edma_done_interrupt_deferred(struct dw_edma_chan *chan)
> +{
> +	dw_edma_queue_irq_work(chan, DW_EDMA_IRQ_DONE);
> +}
> +
> +static void dw_edma_abort_interrupt_deferred(struct dw_edma_chan *chan)
> +{
> +	dw_edma_queue_irq_work(chan, DW_EDMA_IRQ_ABORT);
> +}
> +
>  static void dw_edma_emul_irq_ack(struct irq_data *d)
>  {
>  	struct dw_edma *dw = irq_data_get_irq_chip_data(d);
> @@ -842,8 +885,8 @@ static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
>  	struct dw_edma_irq *dw_irq = data;
>
>  	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE,
> -				       dw_edma_done_interrupt,
> -				       dw_edma_abort_interrupt);
> +				       dw_edma_done_interrupt_deferred,
> +				       dw_edma_abort_interrupt_deferred);
>  }
>
>  static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
> @@ -851,8 +894,8 @@ static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
>  	struct dw_edma_irq *dw_irq = data;
>
>  	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ,
> -				       dw_edma_done_interrupt,
> -				       dw_edma_abort_interrupt);
> +				       dw_edma_done_interrupt_deferred,
> +				       dw_edma_abort_interrupt_deferred);
>  }
>
>  static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> @@ -930,6 +973,7 @@ static void dw_edma_device_synchronize(struct dma_chan *dchan)
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>
>  	dw_edma_wait_termination(dchan);
> +	cancel_work_sync(&chan->irq_work);
>  	vchan_synchronize(&chan->vc);
>  }
>
> @@ -972,6 +1016,8 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		INIT_WORK(&chan->irq_work, dw_edma_irq_work);
> +		atomic_set(&chan->irq_pending, 0);
>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> @@ -1185,10 +1231,21 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	/* Disable eDMA, only to establish the ideal initial conditions */
>  	dw_edma_core_off(dw);
>
> +	/*
> +	 * Deferred IRQ works are queued from the hard IRQ handlers, so the
> +	 * workqueue must exist before any IRQ is requested.
> +	 */
> +	dw->wq = alloc_workqueue("dw-edma:%s", WQ_UNBOUND | WQ_HIGHPRI, 0,
> +				 dev_name(chip->dev));
> +	if (!dw->wq)
> +		return -ENOMEM;
> +
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> -	if (err)
> +	if (err) {
> +		destroy_workqueue(dw->wq);
>  		return err;
> +	}
>
>  	/* Allocate a dedicated virtual IRQ for interrupt-emulation doorbells */
>  	err = dw_edma_emul_irq_alloc(dw);
> @@ -1211,6 +1268,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  	dw_edma_emul_irq_free(dw);
> +	destroy_workqueue(dw->wq);
>
>  	return err;
>  }
> @@ -1235,6 +1293,11 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  	dw_edma_emul_irq_free(dw);
>
> +	for (i = 0; i < dw->wr_ch_cnt + dw->rd_ch_cnt; i++)
> +		cancel_work_sync(&dw->chan[i].irq_work);
> +
> +	destroy_workqueue(dw->wq);
> +
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);
>  	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 6474cacf7195..a6a9ed09fe1b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -9,8 +9,10 @@
>  #ifndef _DW_EDMA_CORE_H
>  #define _DW_EDMA_CORE_H
>
> +#include <linux/atomic.h>
>  #include <linux/msi.h>
>  #include <linux/dma/edma.h>
> +#include <linux/workqueue.h>
>
>  #include "../virt-dma.h"
>
> @@ -87,6 +89,9 @@ struct dw_edma_chan {
>
>  	struct dma_slave_config		config;
>  	bool				non_ll;
> +
> +	struct work_struct		irq_work;
> +	atomic_t			irq_pending;
>  };
>
>  struct dw_edma_irq {
> @@ -109,6 +114,13 @@ struct dw_edma {
>
>  	struct dw_edma_chan		*chan;
>
> +	/*
> +	 * Deferred channel IRQ handling. WQ_HIGHPRI keeps
> +	 * completion processing from starving behind saturated user load;
> +	 * WQ_UNBOUND spreads per-channel works across CPUs.
> +	 */
> +	struct workqueue_struct		*wq;
> +
>  	raw_spinlock_t			lock;		/* Protect v0 shared registers */
>
>  	struct dw_edma_chip             *chip;
> --
> 2.51.0
>

