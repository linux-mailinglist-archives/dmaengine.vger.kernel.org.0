Return-Path: <dmaengine+bounces-6477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD654B540AC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642843BD0F0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E35204096;
	Fri, 12 Sep 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ggYhhhyi"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8184D02;
	Fri, 12 Sep 2025 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645441; cv=fail; b=HkYlfDe+iOc4EFVSgjuHCP5uGv7Q0M0xWaMZs9bSP4yUQ8opFPpKfNzSfntvSJsrv4b95gYmYfjQFjt0V+TbmSCdRrr76mOX5laG1CXF4SF8ZOH1cyBrVyuUGElgQxtd7fdsLgsQbpQ7o1guLW7ZUgAUAnZlulXtvEphOkqawXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645441; c=relaxed/simple;
	bh=nMj0vl8O1vrE7W+UvMYP5APXZz8PLxb923MxaUfCeAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0WtRlTNckojRpNMRb/QJYuFp+9m3sVLoQq4BDJ4XZoiN8sz0luQ8qWeMgxWzeLBsfBPKvE/2OtkHPjGnkz3dve1dhsdlwjQWppcu+yomQCXQTDxscuIXOPMMtQZBUEeGgxYL0InI8iVS1qvdrJ5AwXNzA04Zxw16h1K+JLErGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ggYhhhyi; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN38WiVM7kKAQVloaQNR44+a8xO9vhk9aSmYq2zOMhrM1P6IThL1zGLGtAzK7/AAvLf8sLIcEEoEAX3oJ5iu4ROeIINplIKYzXLdFyQnqatmpYdMhgVo4aNvSt+FxxwcnCmNWLYgWjagVaiZcrb8MhhnfvggXlXoqUu6il3Qgz6406Qp7bZybSK94sQ+7ugDl7nrOSOcC9/PlkGTgVFR6x+9R794RIpYy/eFnauHVZ/IlUEMiLvhzSgjQBH2xD1w5m0d6QF6B5GWP8yuDQlFUwxMS9dlmXF9dt9ZyyCa+hraKwXxQ6OIs/g+TzD0BVlVoeQp8+Dw1Iyb2/bm3HMKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMj0vl8O1vrE7W+UvMYP5APXZz8PLxb923MxaUfCeAo=;
 b=tZHd63kPlJaWVDwqlqxd/YnFxh3JhIlIpFAG4KpJeu/+3yqRifJ/V1kdejjK7xWLh7li2w2PNaKRvA9jSEC47+agG4pFUDDoVtHMvFWHID1WnMb5mI/c/PZQdXyvwvQkSI/sgkwarfhjv5XwDdfMXOBJazvmMosaCqsecKexVWN/S4EC+joMSBEbKN68eyO+KzH/uf8GzuzVpLV30rjsFc7wV8bKeHx3j7x3vAFK8aDR5zJcYI7D4utWFxiB4XPrk7ML5xdCbjMqgi3kkvFaGoC/dllHeAVo/KhwjqShdrTbCkDKrm68E4fn0dRGHKfwVr83BlE5MxiJ5fEgyhYQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMj0vl8O1vrE7W+UvMYP5APXZz8PLxb923MxaUfCeAo=;
 b=ggYhhhyiMRj/pzbKWcWdpTEYDHKlAvCcgZh9nHgcBWBzcfr83I1/IixzpM4/l1QDmWPpadRJF6ZyfTZTjLZkY+8xjp3fFlZpnMHuH1cPJT3N4KXLpNRH/LWwtA4IvJby+FrhyLdCkIdu8XebShl1BaB0lN0oHM/hWUPGrnfQh2o+dmkfXqudbGp4Gf6oz5dJSgVhDlIz9fgA0zmOoLE8mvs2NvnNL3sP9BQ83BfXvk4sz95TZe3vB411XVcJGnNCIfPaONGn3uPPpYuZ4DSx2CztqaO9yzkIcxXNN4K/uoWiFfk6CXwuc9px15erKor1tNThoLFFZGaeRN/e6s7Vnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 02:50:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 02:50:33 +0000
Date: Fri, 12 Sep 2025 12:02:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 07/10] dmaengine: imx-sdma: make use of
 devm_clk_get_prepared()
Message-ID: <20250912040203.GG5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-7-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-7-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8bc634-667c-47e9-3e16-08ddf1a724e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bge+UOX7r5JmJ9yylh10NgJsMYcRWzCiZfhjvDV/0ffLUBCv4DMo6KwYqn0p?=
 =?us-ascii?Q?DpbI/1odHoJPzdbx5LwmZ1jrnEZcTT6/de55RIOnkvLmEKwbvM9BJxCPDxjT?=
 =?us-ascii?Q?tMpnAJk5UDDViJ733d7Xvel7cB384qMKgu3TfD9vZm+qNaDnA9MXUtky3GNQ?=
 =?us-ascii?Q?IssnQ7Te8j0gBwPR6mYip2Syma7gw9UBIHbYdSEpTATdhMdzF2Mvl7i+6ETE?=
 =?us-ascii?Q?SrRtKoePRSiGaMA2KxkFnW8g/Pno8YYEnEjbLoMN14ubDrSkGGWcsLrEWptN?=
 =?us-ascii?Q?CzhT85vtJfysh/XMaBSt4Dc2nHPqHt0zMqVZFN4YFCiJtSL5hjIudUZLWNZ1?=
 =?us-ascii?Q?0hMQZOPYatc+nMNyJrQJu1FPDYY17H1OSikyuuhlFbyrUklDcNq6+dhE6J7a?=
 =?us-ascii?Q?5LgRzKG522jLEDZQ2l/we/aH9pngt+NG8zmsh1LteCMQTda90MAPOhoboPsi?=
 =?us-ascii?Q?HS7PzjBmuUskNUcIu4SfpRUU81STbMj/sX+3iSCPgegRZk1sY1a2he0HVGbB?=
 =?us-ascii?Q?ML1vJmhA4I+JBOFcqG2JpoW6GQKkEudSithhBkO71GQ/Tn0kV3u1ycH0uHaC?=
 =?us-ascii?Q?merxvLH78bPt056aH4gVqk1n0U8aWY+zBQnd4SoTYnfLdUdIoMI935XE8u4h?=
 =?us-ascii?Q?SHMV+p/rUtfcys38xW/+LpEl04ot0ejI6GDVUxaq1o7GNB8TtoCZHuJK0VOE?=
 =?us-ascii?Q?cFMOFe/x6BXL50hIajsPEzBN41gYWk1JkX0ymq0GWEPtTbmMNSWbvTVAoXQu?=
 =?us-ascii?Q?b+0/zn4EpsjaDYxaVT+rNdlStQ5gpmmBXOg6kv0AC+mztDwZlH91ZCyxqvQT?=
 =?us-ascii?Q?zqmBAHO/SzU157HrcFP1GoYjQjN4BqfBRw7Oxw7czxaT6uhuGTDhitIOLJlR?=
 =?us-ascii?Q?wTKEhwSlYu03iWjs28hucbx7TWh+YkyPXELftiINW9ubM/eGZQaAY/H/KJYE?=
 =?us-ascii?Q?Afc94b3HxSY39PaCOUCx/ZlBQnE253gNOUDrD60hSBpnHQLxL0zxu3NqW3Ih?=
 =?us-ascii?Q?ZaEox/7F2HSpgYEOXf3PzGiwc7VT2H7ulxqKJG0BmxRjvgB8C2Ed9psDJq7M?=
 =?us-ascii?Q?1DJZhhIFMZUSfUXdj8Aa2qehuISed11blgo7ipaZRnwqSEE+hZB5xFn+PeAF?=
 =?us-ascii?Q?0PfdlXPjC8dXwTRSiBw3gyiUkt0pL8gwMQXPkX2cPWW1ZBBUfYzE01+YTnW/?=
 =?us-ascii?Q?CD8VJ+/GKkoaSi1y03QA+SqpYPrq9jOKw3ZWPqGkiko2wgNQ2xfF7W9jmCAd?=
 =?us-ascii?Q?lwUZ0H36HAv1RbaahF9TukEiXujTulUOLpcl3IWquO56xq67vRpOhvxgtMys?=
 =?us-ascii?Q?x7luk90MdfyjNW8pVxpyG8LR5Ys+p12V5ta7PAAyAuTpY8Z64p4SFnmo/eSp?=
 =?us-ascii?Q?m94Mj166OmYAWJaDlXddL27ppsCL/PsXcr6x1h1s7tM68vhg7iYAy8yrlqCn?=
 =?us-ascii?Q?rVFSVd7XQNbK2TDXBg6LqtUnef6V/br/qXRlEX2404VR+wY77DE2JA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AB/zAe+fD83YUSeC+Zzlcgiur/s2f5DQpAKwTlGA6Lny0aX0HUnor1h8ESiU?=
 =?us-ascii?Q?7VzSLS+FKUJovDSfHgfY1XE3rQMAD/zJGXIPxtpzELtEBzdcPZ70BkQ0rbtU?=
 =?us-ascii?Q?sdnHwLIH9ZSW/Tu8TcmWX4XjTp4gR/5HVp3zOMmrPsAZvcELhuqrlBrD3W0M?=
 =?us-ascii?Q?XizpfwAQZiWOoj7/PWA0vs49Ah6tmC9/VV0GlKjXXMxVe5y3/9nClktj8h73?=
 =?us-ascii?Q?pLNztKpjQvNeWWdwtKauYzKNgCHM/KrJg8HZNhmKcUXBzltR85HYsVk9sG9q?=
 =?us-ascii?Q?Nlq0wNmvm3Jqd1fdFdDLQn3J8+Co2+NFB+dGxzGpFKxkjNL/TJqCNOAXIoGj?=
 =?us-ascii?Q?UwHvb2hFcXYGaupyEzfgujt1lB6ceD3U2z2IbVjFuLMeq//RpAc8CTxeSGZA?=
 =?us-ascii?Q?TooPZ3M7ez1shXn4BU10dinFIzKEfc5jZ7DWPKrzhhAiQKYry2BuezdPnM7l?=
 =?us-ascii?Q?nvw+CDys/k9VivrJoegQL0BgIfparPveaD/CmOWfw5QhwFq5rzJQ8fHERENe?=
 =?us-ascii?Q?MpqsPMrRH7dOyAjVd6BxoH6LAXmIF+bmGlZ5ycJ1vEUQwvW08QufVn/MQICK?=
 =?us-ascii?Q?M1u8NE770GAb2D2mHfYW5sFUhyM3gCcGsOjWGu+4KCDi0Ra73mVbNmDX5OjE?=
 =?us-ascii?Q?eDtdnla+sAxumwNsVmNvW2SgXF1M/xksBzAIkS4vPpAFVd+8z55gl9QKkkmN?=
 =?us-ascii?Q?ES3mxUsNaJdanZy2ep8VGa27eNabaEdi8RonhDSyUwRyEgeJXkkuTSFWxTQn?=
 =?us-ascii?Q?yDADlLchiGJqdDp90CTNX1ysHcdsCae6hFc0+3TTicFzNyuemKuzz3trStBK?=
 =?us-ascii?Q?58clJAHdxP7A9U6vRS8aaaKRGpC+Vn2XCzW+9wnaVUiFpP/QBwRgjzcBija5?=
 =?us-ascii?Q?cz77g81rtro6AAPRF+NSSlDAG51sw3mI4ZJeOzvil57v34abXIoFcq5Q6jlN?=
 =?us-ascii?Q?89IytYmWdjaFGTs2ZGi/qTucTT3Op+vPb7369rWw8JV36k6uGcdbDOgnnpVC?=
 =?us-ascii?Q?DgA1Q8OJGLrWNJJiBRQGDBE8N6cbhUThujtaBTC5aoMb8aOdwRS3BoQuXaRe?=
 =?us-ascii?Q?WhLhrl9uE4HHCg8WKMDKREdz8EjXr5S52wVzoPwAX3hr2k9cTUljNgOPMDRw?=
 =?us-ascii?Q?A0PujgdM6umeRIklvtq6oQoUn8FXH36OcfR5g0tKRERXoBu3Xhq0fcqWggWK?=
 =?us-ascii?Q?LaEvjrVO1OWdPR0D9ivFcZ4hdkwkcZFQJY9c+UE1XKJCFkSGB3quIAIheQ7L?=
 =?us-ascii?Q?5AZ3OcukKfQ88PUlnTST+8hnqQ7UdbxFZg8S2WP6E5/4qmEqUYc36OaOC6Cn?=
 =?us-ascii?Q?gViGyinZmXj6IRisuCrEtSxDhr+9BuKPhrIlbDmvvJYB69ieCTOIdn0jYKQL?=
 =?us-ascii?Q?V79GUbjv1n9Pt45Bn9W+JSpqO6ZL0ZAKdYFB3YNtMqV2+PjecAco9j+tWif7?=
 =?us-ascii?Q?6/h2Vr2oyGB0CcusiDajMRkIXhuIX0tpPg+8JSXk1YgDBzQq0uydcQzGyFBo?=
 =?us-ascii?Q?4XmpZBVi6VYwbDdvqf8dq2kTpurk4TA7EOm/oi+619/+SJQRjXvlOPltZLQx?=
 =?us-ascii?Q?Upa+7Bl7+/iJUUdIfKByLFqXiFQODFV1gL/N2fk+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8bc634-667c-47e9-3e16-08ddf1a724e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:50:33.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRyJHMXKkY4GrakxC2N92BjYPHtAyXIJYjqvlRElVpHP0lyb7bClWbJVFTgBqONB0MMycXr4xlDLRiaxZa3D2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On Thu, Sep 11, 2025 at 11:56:48PM +0200, Marco Felsch wrote:
>Make use of the devm_clk_get_prepared() to cleanup the error handling
>during probe() and to automatically unprepare the clock during remove.
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

