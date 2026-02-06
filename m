Return-Path: <dmaengine+bounces-8806-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDkPFIFBhmmoLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8806-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:31:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991B102C27
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1FBD3004607
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3122857C1;
	Fri,  6 Feb 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kjsy5FAP"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25584A35;
	Fri,  6 Feb 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406268; cv=fail; b=fjTeZvBBYqf4GqHJfRjI1jJ0OUWSmOP9EH+TvTv73S4RuKanYOliowL1eedoJhQiCPohSn/T2XRSoDtegKVfepIjR/V61oMI7W1hTm4u2/sqxbGs3tYmu5YycnDZw0eGGvZ+QX0vMfOvDXl75FNvaXs+NJRAjRekUJBC++87enY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406268; c=relaxed/simple;
	bh=jcKMFm5j4GKkAA6PM/dy/Qe2JkZpM1pT+5KmTB5A1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u6iNjsgQjKHLJ0S/+vYr8s09lxE1AwplA/kXxQ3RtM+x6Gl/PM8OzKh5/oYDdNwbyqA/QB5vemiwQ+TT/Iy8+PmqR/2inXx1IsCUIFRx1acjQXKKnB/10RSy9y8H4rdAFZZ6hlY0lg5CqmJfqZvnLTpPVRdlyDyS/C2cMxiz7AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kjsy5FAP; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+HAMSjzDt0+Vc4lY5yg4AZ08ZX9hvZb5imxHP1fI++3y1uZdiU7CNU7gwfOirf0K/bpLQwEr2Rby40vrTFhjA5Y7yaZTqxFBGWdhvAxerZqTzSBSxZGyCyVvkH/3FplaLOewNaIkeqjB9xTbDyT9sv/YRXvp2iFtuRxItKxEm+lRTnXn1O4Jw4FDS6IsTwNO7KzbbBSBlI09SbUNTA28726gRQzQZ/uEIAj5BdsEKRKWS3SUDxcAx2Nn1Y86hLdp+nk0VRX/yYraRZ9JC6OJzQtEvYcsxqTvSvXY+2lJ8Bu+ldjTimM/qxsxXZGfmF3xwKxDL10YfHNV0NeTDblYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZqSUzR9Dgq1s/6HsOSp1d3uhQDcXGZwchMUQqXPBQc=;
 b=AHN61ofT2VvjCSn8BI7fUG8zUgzD7xQvnPOdShG2jNUFokr91pG6KGj4J4fAwxR/akmJI1N6m4FG0DoDz3IlU3pzaLcQ/O0Ozb1aJbyFRhsMtl8j2zNvJiXNkrg4jkSiltQldO3U/jr8QbWzUsz7IijyZqcLcMU56H1xMY9MRuNBWngzqPjHD6DN/qzPvnG18OBAWXCace9MOG12hdzo4yrWJKAwA4wapy+TguEVXRj2uCA/nv9vOXwr06fLF8LvGHoVZczngZt7wZITK54WjFJSQGvjGX36cWJonfIp6w6r5eleo6SaJV6qZUIJer5pw5U1fnAig31zFifkTrw+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZqSUzR9Dgq1s/6HsOSp1d3uhQDcXGZwchMUQqXPBQc=;
 b=Kjsy5FAP55X9ZsN3fyxerb9rye4UTnzrfMIm49QFuqS5i5VhyKObHhtHjA+7O/2H7fJJ/XjGmcZAnR+2RxyjpCnhk69rFd9z9GGKL+7XF7UO9BlYo2wOeY33KCxHLNsQOq71z+FcKpRVFNXONJELrudkw/3wE3a53MMhR0ZrgMubW4EXKLw21wkIpOjDAUqhVXYryLqRB39EmUSfOwAzXcTUGjJwTX/zgtNdt4yPBCyRp3iKwyTJh5FZIeU9EOtrHGx7tps3kTEhOLmLKhtjXbMdd3kDHqfmlauOhrD8kzH5ZPXh/NGmc8ZMQpYnln3IWEKZkmcVz6PytrXCr/9NKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:31:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:31:02 +0000
Date: Fri, 6 Feb 2026 14:30:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pat Somaru <patso@likewhatevs.io>
Cc: Tejun Heo <tj@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Vinod Koul <vkoul@kernel.org>,
	Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: apple-admac: Convert from tasklet to BH workqueue
Message-ID: <aYZBbfktpZyu5u1k@lizhi-Precision-Tower-5810>
References: <20260206090137.1127897-1-patso@likewhatevs.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206090137.1127897-1-patso@likewhatevs.io>
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b423f3-034f-4812-1288-08de65b6432a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L4l+Tijn+v5gX8j0pB7TQ+pwbI+olFqd9WMLQzatixsdeo0LxW5Lfa2ZQ8o3?=
 =?us-ascii?Q?gB5r6O0Ovor6AzrlxILnYDDObmYUVtmESY8ZpoWVbP/UYEMi7dILOU3RZsoO?=
 =?us-ascii?Q?9Wc1hVsAc9wEohDLPIEuMyAr6FB5Vi5S1KXsnoc8xbA3+9MsLCQIsxHUbKkT?=
 =?us-ascii?Q?jWpfePG3+Q/KxRD4uf7vocP6pZzYMS2mb0xqCKErTRE2Al69dkJMJlLBzEmb?=
 =?us-ascii?Q?kuASo6DXMPhl3hzwJwb54cZXDGswylPG7sS+mct8TsKKt+En2Msj2ahGA3Vj?=
 =?us-ascii?Q?RRaA9kzYQXB4JLilD7yfulN/22pJvvO0nD1xGD87kCvhSY1pFinSNQiQDlsG?=
 =?us-ascii?Q?cRRWq0LK0cplJVCIJL+0vcnLfu2wPYiC6xCBFmXoEq7we9dybBzt6FGEs0iC?=
 =?us-ascii?Q?QX+JiHeHJmVe0UL0uRtdy7mFgCJV1RKilsdzxyG8LVmEG3oqlwe2WVeIt4c3?=
 =?us-ascii?Q?E4rYC+kydYykIcazRXkidIdBxZDxy4QR/wVdjaGU07+pQ4fTaYQ3SZw6DcyT?=
 =?us-ascii?Q?PLasXHQzRFxsFAAVRj39KNEmm6Xl/VmfuU8TyjIboI2r2nrLxYs8TLukXq9z?=
 =?us-ascii?Q?mgIh3zjmZFF9wfn7lOU7FYd8XIe5L8pOY8ilWhz2ql1/ho++jKZ9DT7BVY6k?=
 =?us-ascii?Q?lux8ab2WBlkKntYFzi2wqgxXSX9qzkLqEMKCAaaT1k3qaXKk8QROqSnjcApr?=
 =?us-ascii?Q?ArPNCgWg5E+dHAf6NqekXmItiAx9VyTz7u3yXs/aLpdu/S3WRBGSRGLb0g9O?=
 =?us-ascii?Q?n8ay7h9uJVCJD7nbjZChTuHq2bEe8mEYRjj8eNQAV1hl9iR4aYuXxTyl044Z?=
 =?us-ascii?Q?Wj6EugJz8+pjYMvw2FT5+MeD8es0EiBHv+y70afNYgIrEX8saJRYMFzMTcCc?=
 =?us-ascii?Q?RB2/gJGww+ktdZtL5pWwOXr9wy2lda+PyGKyN9wsZ8KZ3FowTDAwDK6XTsyT?=
 =?us-ascii?Q?TRGzNx97gitw0MILWK4R45ODlu6d6WhaN8BUCL5xEpQn82xfaET+VXV+70X6?=
 =?us-ascii?Q?MxOVC4FSeI35eTR+60vt1UPZkjzfDFoPb5fj59iC0BZprFZxhXF+wruhw86S?=
 =?us-ascii?Q?ZEq89SNp/7/XOIcDwcBIGowr1Gp0g+RYa4d6pONdzFPVidluC0gvxu8iVW4B?=
 =?us-ascii?Q?ShgQU+Vml3ssiN9So5sFC/AA3kxulKExgnRSkdlIJ8cj5gQSU0/RRRWC2Rnr?=
 =?us-ascii?Q?tmpt+zq/GWpu5PccjmTqABMq6lSgMstfsXP5KPqEEYBsn1HpmjuUsiHtxLIm?=
 =?us-ascii?Q?I0U8c0/5ZussmTJ2Qt1SWkvUniY70fOpxF0lIuskEzUUeUqQhMBV0Xnp+aBY?=
 =?us-ascii?Q?T0kw+J0faUHMwC1stFdV10aNBZhG0IMgeIhu/M8DBm77ItY8VDxwaW68FjiS?=
 =?us-ascii?Q?B1N2cWh3dVGWSV8gs8FvfmP6F8QLP6X/GhZUMQwLdY4r7fLVFaO/7dWrhckv?=
 =?us-ascii?Q?KtybsPqoi/x2TDJcZxPl3/ka/RF6ic1zi1+b04U7OAfNX7eP3v4Rk2rTxjab?=
 =?us-ascii?Q?13vOYsXOr7WUyoUd5t+Js4oS1jNxtj40ctXSALB4lKyOPNLrnMSzx3MEtcUg?=
 =?us-ascii?Q?IA5Jltq3BJ76hMeXrCHbKNBJ0wXR7ZSBwkIb/1XeR38ik9kjYuZIu/eqe1gU?=
 =?us-ascii?Q?MDau84/oIUPL/d+chzW8Ays=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDCD+S3fJgp7Pl/3Whyw9Dw/c1L85sZZy9wrml61Nlen/hwPgEh0zTce1cxa?=
 =?us-ascii?Q?bjEsRZtwZRSb59b/2K2aaRFQRag7eHIzsYjcebp3jNKi3WdXI4cs38K8TY8i?=
 =?us-ascii?Q?cptHxS6nB3kpABb6W9bqRBaenBf9UL+xms0d2mXZbVfO/wVY55cZf9eB770Q?=
 =?us-ascii?Q?nGo/Y72ZYSVu2JUN23vz8UBaOVI9aNgaTfihpm/eU48EAgeuCgqJPgnHDE+y?=
 =?us-ascii?Q?1lD7znKp+SNPQtZbgEKZlF1Cnwx0wqXupyA3oS7/+TGfhuUWBXQv9+/+N8kZ?=
 =?us-ascii?Q?CFDGD648bTd2lI2u8/kVwVMU6sppzObztqUKHZYD6PGPIZ3X+Oc/cRRxCOKu?=
 =?us-ascii?Q?XGmR0bo+jNZiIkYqkLb5msapG3b/qxg5QnlYbZ/ntr2trU9yzZRMFaG3mnPn?=
 =?us-ascii?Q?9GHDYy79GWy35sefv/HOC5In0qSA8+kHTplTp6UcbX/48vk3bY01qlz9KmJz?=
 =?us-ascii?Q?HUED3idHQWPA5c1bwRYy0QhfXP2puApp7P4OdC/j5mA+yCW1eo+Ygt75Ipik?=
 =?us-ascii?Q?t4TLVYoffOBEqGw0OVtII6yVM0miWmE6nguXHdVVE9W7dBhkj7ArvveNpFXL?=
 =?us-ascii?Q?G7qFt4iXteUld2h0quFaLLvfggXMJbS4rM5TzjMQwLNa0uIS7kSRlKLmcUAo?=
 =?us-ascii?Q?IqqdVqR5AMD63pvhkAPuOepCHKnbpD4REIkASIQlndEvZKEc177pzYGQ9RdI?=
 =?us-ascii?Q?kVtv1vrb7mPah2FhY+F2Nc9a9hwHAJDfY28KvxlCPvZRHfJBaW+NvTcWpwUZ?=
 =?us-ascii?Q?7752r0hboeyFKDVmJI9nXF5UEtnmqBn2JEpbWVAk8wIVbDy8gkwgsMF/bM39?=
 =?us-ascii?Q?x7Vxk01tP5y64zFTv5bvHMesHbBJSanlCG1EQzjmwa0mlK5rTUf+QK+F8Znh?=
 =?us-ascii?Q?oGNqEf/drXjtpXLdM8MC9QEekIVvWrafzSk96BZq6uRCcsl7ou/nYFjNFk3m?=
 =?us-ascii?Q?CnNaxT1FD1QG4ymZDitK8Z1Vgje9KzY94xKHPkanIq9go4inqHxywJr4TQFa?=
 =?us-ascii?Q?lDrB2Lteuyh96DavpTqxsJp/lh2528NrGW+HvblEvhcR7GW6Leqw3JL/toZ6?=
 =?us-ascii?Q?tlm7de4JdlC3KNEyh8tXPE/eK64T63ys8OgUDLw5BHNmfJdfetIPvTrjbDLR?=
 =?us-ascii?Q?cYcA8XOvnuulwET8/VObkE2++4rxeJYidTY9UscEhgjjwViJCz090TYEMwNC?=
 =?us-ascii?Q?FczBIkihBJrJFi4Mfjob7XdixfIlASPVr5M/c1MhovDDsicFB4c169Izxyh4?=
 =?us-ascii?Q?IRSLhsrrXuKH108/O3uYS1EmS8LrJl5nuKWN0pq94Do7M4fgxgGae9kYb3KW?=
 =?us-ascii?Q?Q8CELe1RQWynCDiJ+bw3uJYEUVSkl2ckE5A9gsHmdjD48wprkLftJCcSUoDi?=
 =?us-ascii?Q?QaP2bbQgnGuyoAl91IQLIxWgAIHVhahzBpO/U9yV8o1b7hawV+/bLaV7Gqbj?=
 =?us-ascii?Q?t31VID+lkDLcwsFUCnWFMLTFZZb69m3qZMKES8VAf/paX5RyQ/CkoXmHL1EE?=
 =?us-ascii?Q?kQVAYOOnzF8vXinaeMjsSmLK25dswrk8NL4UVSvLhpH5ol4ILmv1d2rnHrJ0?=
 =?us-ascii?Q?qPUhEPyVhQy+k7yH0/CCCxpPJOhTUMy37ZiO7/wOqhsuQkbO0L0AgQtITqDs?=
 =?us-ascii?Q?/EVmbp4tLo0nZ/4nsIuLomIExyHW22ZPhazInZmUASDhldim+x1+dj8oBoVY?=
 =?us-ascii?Q?vyJtu/9wvGXiEb5zMXhl5DkyYYaHg2HK+/gQGTt/hsgK8AU1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b423f3-034f-4812-1288-08de65b6432a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:31:01.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8++kKjweCyYtZ633teaRDo3G0c0HavRUeoopJ8/k2KCzbJb3TTRu5YXrPUeyWkvzSO0Fp6q8fxKe3Y78mgBDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8806-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6991B102C27
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 04:01:37AM -0500, Pat Somaru wrote:
> The only generic interface to execute asynchronously in the BH context
> is tasklet; however, it's marked deprecated and has some design flaws
> such as the execution code accessing the tasklet item after the
> execution is complete which can lead to subtle use-after-free in certain
> usage scenarios and less-developed flush and cancel mechanisms.
>
> To replace tasklets, BH workqueue support was recently added. A BH
> workqueue behaves similarly to regular workqueues except that the queued
> work items are executed in the BH context.
>
> This patch converts drivers/dma/apple-admac.c from tasklet to BH
> workqueue.

Avoid use words "This patch",

Convert apple-admac.c from tasklet to BH workqueue


>
> The Apple ADMAC driver uses a per-channel tasklet to invoke DMA
> completion callbacks for cyclic transactions. This conversion maintains
> the same execution semantics while using the modern BH workqueue
> infrastructure.
>
...

> This patch was tested by:
>     - Building with allmodconfig: no new warnings (compared to v6.18)
>     - Building with allyesconfig: no new warnings (compared to v6.18)
>     - Booting defconfig kernel via vng and running `uname -a`:
>     Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux
>

Should move after ---,

> Semantically, this is an equivalent conversion and there shouldn't be
> any user-visible behavior changes. The BH workqueue implementation uses
> the same softirq infrastructure, and performance-critical networking
> conversions have shown no measurable performance impact.

>
> Maintainers can apply this directly to the DMA subsystem tree or ack it
> for the workqueue tree to carry.

This private talk to maintainer, put after ---

Sorry, the same comments for

https://lore.kernel.org/dmaengine/aYYm2pA6l-ksXvkk@lizhi-Precision-Tower-5810/T/#t

Frank
>
> Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> ---
>  drivers/dma/apple-admac.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index bd49f0374291..8a0e100d5aaf 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -16,6 +16,7 @@
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>
>  #include "dmaengine.h"
>
> @@ -89,7 +90,7 @@ struct admac_chan {
>  	unsigned int no;
>  	struct admac_data *host;
>  	struct dma_chan chan;
> -	struct tasklet_struct tasklet;
> +	struct work_struct work;
>
>  	u32 carveout;
>
> @@ -522,8 +523,8 @@ static int admac_terminate_all(struct dma_chan *chan)
>  		adchan->current_tx = NULL;
>  	}
>  	/*
> -	 * Descriptors can only be freed after the tasklet
> -	 * has been killed (in admac_synchronize).
> +	 * Descriptors can only be freed after the work
> +	 * has been cancelled (in admac_synchronize).
>  	 */
>  	list_splice_tail_init(&adchan->submitted, &adchan->to_free);
>  	list_splice_tail_init(&adchan->issued, &adchan->to_free);
> @@ -543,7 +544,7 @@ static void admac_synchronize(struct dma_chan *chan)
>  	list_splice_tail_init(&adchan->to_free, &head);
>  	spin_unlock_irqrestore(&adchan->lock, flags);
>
> -	tasklet_kill(&adchan->tasklet);
> +	cancel_work_sync(&adchan->work);
>
>  	list_for_each_entry_safe(adtx, _adtx, &head, node) {
>  		list_del(&adtx->node);
> @@ -662,7 +663,7 @@ static void admac_handle_status_desc_done(struct admac_data *ad, int channo)
>  		tx->reclaimed_pos %= 2 * tx->buf_len;
>
>  		admac_cyclic_write_desc(ad, channo, tx);
> -		tasklet_schedule(&adchan->tasklet);
> +		queue_work(system_bh_wq, &adchan->work);
>  	}
>  	spin_unlock_irqrestore(&adchan->lock, flags);
>  }
> @@ -712,9 +713,9 @@ static irqreturn_t admac_interrupt(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>
> -static void admac_chan_tasklet(struct tasklet_struct *t)
> +static void admac_chan_work(struct work_struct *work)
>  {
> -	struct admac_chan *adchan = from_tasklet(adchan, t, tasklet);
> +	struct admac_chan *adchan = from_work(adchan, work, work);
>  	struct admac_tx *adtx;
>  	struct dmaengine_desc_callback cb;
>  	struct dmaengine_result tx_result;
> @@ -886,7 +887,7 @@ static int admac_probe(struct platform_device *pdev)
>  		INIT_LIST_HEAD(&adchan->issued);
>  		INIT_LIST_HEAD(&adchan->to_free);
>  		list_add_tail(&adchan->chan.device_node, &dma->channels);
> -		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
> +		INIT_WORK(&adchan->work, admac_chan_work);
>  	}
>
>  	err = reset_control_reset(ad->rstc);
> --
> 2.52.0
>

