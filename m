Return-Path: <dmaengine+bounces-8554-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKM7EBQxemkx4gEAu9opvQ
	(envelope-from <dmaengine+bounces-8554-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 16:53:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD577A4A92
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E39AF309C476
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027E305E2E;
	Wed, 28 Jan 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hq2JCOXv"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EB3033D0;
	Wed, 28 Jan 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615298; cv=fail; b=Mx7js+z2l5aGnIzJ4X6DGXKZjnueA5nzmSSKcmrUlgCBevuYJGkT+F5quV+dZCVD6AG5kMqLXjTTxSZfpHGm4t20+pEU4t7xjf0o28hoLwTOsN7QCO2enKgNsvm1vrrfrnYlnWMRoih/9pbFuH5xKMQi+gkQgiorr/KIv/Z8j0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615298; c=relaxed/simple;
	bh=vVlRTp2bfcZWMWMByeYkQpkueqJXRDqmi+uhCHQJRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kAYVqVOufSsO3O6butwKHPLe8F9vKUJRl2hOaXC/rcsqcJ7soYjOhAX53elKTrsVlAVjG8trhqcdy+S8LtQXxuKXq8puRIx2hc7L6JWf9JEZS+YFbc9T4vNj9ui1O0NKUSR/uB7vUIYIJSuNLq3+PpTkbiRYxdWAVa5zlehF91M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hq2JCOXv; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVNO0PbMh2xYIumWXE2GrNqDF+A/bL/MHlRTnBKZd3yeSU/QwVAsfVLlbiBbuK1lk5/8FfVZk0Dg1NOdT0zSd6LxCsllMOvuji78iGcqP/UJMkfvCVJVdl5nzk/n7I3M7Hv5shQbJuW9rhLosVfM0LIXwsmq9A3PXEz1AILhx5uvnIjBFM7/GlZ5ePtg8/9Zz3+41nHPPaToLIHNyZHQbplTimKJ//WAz/mcfrxXdjP+qRG2bZMf0a/GFdlQWJJ71V0iPu9w+k1n3MijmtKMuL2Jumbvksx7JxG/qQvneP6mx5+ACEWTwfNbT4WMjoxa+hBhZXL7UbgsckXkqvQuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h26f8cO6+TlVXbuJHUdxboyB6vDSUAZqh3hh+Phw8Bo=;
 b=i5KhqA2hYs0Ob1E0Jd+PUiQCLZiIM+QNBnMOcJ5lx0otOx+UDnCUfueoH8Z9fAayoQTR+VyFjhdQnh2CqvuTRwUaTurkol7xvzmMcDhoSrXUHND0ydwI70TOuJfgfdF4v+lHz8E664pbF7nBqh0Zw+ByWakRmdIfrxLlNNRw40HLonxhVfxcubPRmZNsRTkZ6C40TemIX+Reyko0EoKWZIqIbqsGgZsCIV/xDniHYBPMM18b4gB9QGRzzQBcpUkqhIwEIYL2MMCOPeESDmRPSAt0vJtmvn6TA1siccPF4NSGmNgywIJ4reHsbGKCVwZnNoOgMTtr3JZsr58zWDQN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h26f8cO6+TlVXbuJHUdxboyB6vDSUAZqh3hh+Phw8Bo=;
 b=Hq2JCOXvmxqsYP2nRUVcr4wut043H9qFkRGd+LXgBKQKFT4NAH2FcmoMxQR3xDPnob7/j1gXn39TUPSBZN5E+ChuHX62rqXDLOimwWRMmzmcwRXQqc9pBBoKuXMbhkYQYmekfQnJ1gd6Jm9CQ5NXeQ/96/qe409kh10HugTx2Yh7fpPDv8xuQnwDFwis/ZKGH+49j/njnV8AGNZGtOlx9e3LCU7nYam0epICL5Mk5LZA/u2Vj69f/sQX8IkTJjWNMfvI0cDhce0NOGZvvcfHoOVMTpis1oipv+JzJcGp2N4RjxmL3QDRL6WTBT8LeFxcCm1prgnBgMUClKFAqVJETA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 28 Jan
 2026 15:48:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 15:48:13 +0000
Date: Wed, 28 Jan 2026 10:48:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127033420.3460579-8-den@valinux.co.jp>
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: fa292885-c981-4df5-e8c6-08de5e84a4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|1800799024|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkYqM2Y4vvpdFVtpqZdxNJvbFtyD4oJRdGpoNZ7puZ4NK1ijokrM1nlQN9d1?=
 =?us-ascii?Q?HUCHMWj8GRCpiP0IxOrmMRYzVsrk6jb0LF4613DjdgurzYM4HSOfFJdeB/OV?=
 =?us-ascii?Q?TQWbmphGHKAWXH7jwqOZLnJysoC+ZJhCsFRVrCXN0rg9tAlNk+biMcKgRYiI?=
 =?us-ascii?Q?ltiI+2dFof8inZ6CQ9wlffvehb+jMo8e8D1mUcve2CI+Pb3qDKl6DJx4m/AA?=
 =?us-ascii?Q?0N+mpCbqS7+1GjrH5b966hFRt1ox3HOZ2bi7P86CeJYHgqFW4jVYaHBXO/Sm?=
 =?us-ascii?Q?lGUeuJdFlWlJV5oFrji3dRun7slXYqlV3goINw/8JLf3wim5Elb8Y/R21Yxa?=
 =?us-ascii?Q?1g41/VqwVIQT94eNLQ6JiviYhW/5tYocbUo4HsWV+9NBP58o8G6EYHqlEmZ8?=
 =?us-ascii?Q?NznIu+IlHJ0RE+/S1Tbglm5RECFNtJ3Ke0KZO0N2EkZxC9kTxDrmw1J0GYNu?=
 =?us-ascii?Q?oH/Km0k+CcQEMcW3sj9LfGj3v+QkNvD+YiwTbVE1/fW2rSXSVkMpC5veesZ9?=
 =?us-ascii?Q?3CyE2kZD1ZTlvn7Repn/BzYolL1H4eS7IO7uRtwgGhXw5TCL/v8Cw5FrLnKy?=
 =?us-ascii?Q?bi15i+qDgXn30MiYiVeW603+zIo/Ec5CLSet8iqT+RaxBmBrwP6QVyTIVOPd?=
 =?us-ascii?Q?pXzGcwiky7xSuGgRZkGUQ5y/jnxceZ2wAthPcuDLGGgvD0W8JHJcXd4EHCOz?=
 =?us-ascii?Q?02sbW/pX9ciJJHDM1+FXCbfVVW+pp/yqUvMPIk+YSq/f5Pc2S8Z0HSm2BAR+?=
 =?us-ascii?Q?FBF35rVnpRUdyfK1wzz4gktFtwOXYfdYoQO/oun0N+PtcBvYLunbemtISWYf?=
 =?us-ascii?Q?02yLsxTVLnkuxZAanDCFPDed3daCSDPL+GDpCpVsb4FzsML0XHCfDcD+fLka?=
 =?us-ascii?Q?YJzgwe2nwu2M5jUtCdCVFg5PZQHaTmZIPDJZMWUv6IP0MMSXCI86dMLbaJiW?=
 =?us-ascii?Q?M+iP2023aF6T2ZkM2jhuL6vQgbsX5uxjcYwrv6d+NtcFBpH3NxLuihVsdKie?=
 =?us-ascii?Q?gDzrasBBihJ3yuzKro6S/e3Iak04he3lJA98cTK4BU5Yh5KHO9zHwJKmSp47?=
 =?us-ascii?Q?a6l+PzMiT65p2d+XperYQqMquaqiQP8LMw9CsFS6x1CAZqtXu+W0O9iunymJ?=
 =?us-ascii?Q?YY+Ag1fNVTQvcvmVVAnqVmQNXJg3PLBQkgYFW48pqWKHeSVUK9YC5PKkMPZI?=
 =?us-ascii?Q?4Y9P7BoiDftJnUUPRi9Oq0wzzXIZZ7EB7Zq25z9uhmLAiVY+4It2voHK8Oel?=
 =?us-ascii?Q?zGYwcBdemKtuircnjW7KY1coINhK37wOulSs6kQyOQmQ3QotxmUnW3tDVONL?=
 =?us-ascii?Q?xtTnpYeg/gC7qco3wsDQHmJsASlkkuaFdFmgvNhFsjimbYPGqTDqd+NzC8aM?=
 =?us-ascii?Q?1uhx6eT/vppnrO3ew/9Ca5bIH6gYumLr3K7vAqnSB08Kt6xAbb2FQf+xTIjr?=
 =?us-ascii?Q?+275Wx/Js/NEwgq3vCHQufJKe/l5jLiJJv67sLKg1udknKPiqBr0UEFMS8jl?=
 =?us-ascii?Q?QyqQ3tg2HuSRdzxkgLikmCYjoCYBwDSYhDM7TS3AQmkPYUzwNYgUcFFOewCY?=
 =?us-ascii?Q?lw76cAIXzFzvtWE8WLdPsiFdEJip98ApUrUP5qzv3f2EtELRRoXz3nWDH8nh?=
 =?us-ascii?Q?wbavgfykpit7DX53no/Bs3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(1800799024)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwKE2bqgh30JRmrOWSZkGR1f9rz704u1YjMYFKv0+mxMi/HazxWGbGiOhrou?=
 =?us-ascii?Q?xgYqEFRi+8iFMfhFW3zQZOzOXNW84tOvkoXTS7HKe6a47Kb/8uu3mlkaTEBM?=
 =?us-ascii?Q?bKCn+ZQqMoPLtX1qRp8BIFMANn3Kzrh1EV2plmgK7rI2dIPj5yJNXF33ge3k?=
 =?us-ascii?Q?5DApULW93l6yafpaDFCak9eqVuBbrHG1DZs2j/fjFnmPH8PV50WTNaymbYqC?=
 =?us-ascii?Q?ptZuighGEi9NIhfiGkdm3eQihc7Im8UhvxaDcngfFi0z/QwBW8wzPB57ifU6?=
 =?us-ascii?Q?fg7VpkERkOJlCpEvyt82FvnY7xdYE7Y7VvZw+Lf4qbLLlQQAlmZL9FLfoAvN?=
 =?us-ascii?Q?vAoMmm8WPIMDrZW3Uc38Xl7uuFWuCy4NBrfbIK4OAi7i3er21r2Cw3hIjKBL?=
 =?us-ascii?Q?y/hv9JjDnDou8q83aoboCk2MYwE8a7OCYHYwLS4+e/S0OaYDFr+Y39wKXU0z?=
 =?us-ascii?Q?EKCyGnEYP56aPciN7D4j3h391kB2xB04db+2Z5z/IgfGJAvtkmBY/NNiOCNZ?=
 =?us-ascii?Q?pe3dVripZaD6ichlWIQicsknRVvhG8PuGcHKZDwaWs0v4+0g9Id0OVcbpmep?=
 =?us-ascii?Q?5uZtWC5iRzfp7ilfUrxyb05RwZgGnc/3Z8BuKw2HAyQddOSXiiPUGBnST04K?=
 =?us-ascii?Q?XbL7/zcDyRkmVgPj78Zb8CJ8IDE2U4YQCcagxi+MnMGzb69gwInH+dIaGiTR?=
 =?us-ascii?Q?d+w9aa5zMP8Nru8ZvnAefDXZh8WzO45RgLtkMCCm+LCOPVHsSspTAesbwV2v?=
 =?us-ascii?Q?93BV3j+7KfxKp2j6fzteqqlvQ78L6HtsA7bBmI87hBqq4nTaBgTxW0oBx9bz?=
 =?us-ascii?Q?i1yWcL+cyxuIcxJsdmFuljQZY/X8xTFQXCRcak9Bxi0YVYdzx7c3S6VG5Y0e?=
 =?us-ascii?Q?3EzjZMffWowfnNErjrXLdpRzdKbDWA+E9QaMx+SEETg5QxXmtTOY2fvENHNp?=
 =?us-ascii?Q?QeZFtoWQ6LsLsRd6SQuPqB2P1eOD0ZKf0gXsAa7wTgOpBiQ7MBZAMNXBbiMa?=
 =?us-ascii?Q?FH8MV1epP0GxzeOzH23hbEqoVAiSDT7EJ2DmkT108yIk7x3Y8w6Dm74T0ouG?=
 =?us-ascii?Q?fe66PXsvKVtm8ZPzYL8T+cpQuFVcJuPa7u4lhsO1CcHlb0FzYwxRhtfvBTQP?=
 =?us-ascii?Q?SvuA92ZaCOl/idXtFf2bEieRZctcgOBgbM8j6aRFWfd/mzpIyBJdzgIs//KZ?=
 =?us-ascii?Q?P7zhviYuNE6I9yNR8tiqw004MyZTS14a5m0LueTDCWS8nuIRA0ns2BA4c41f?=
 =?us-ascii?Q?zdIBoMdbCMtwPnlo27Pmk0+4gGQE3yrTGeEKvGe7SQ3jM6JacUAUzOcOicjA?=
 =?us-ascii?Q?GK8w8n5WqUOqy4B/VBlziN3dxaCoYBXg4AWwqxazWbYt6Z6gmXVLIvQh4Vx4?=
 =?us-ascii?Q?j9vaNdZO3XyulSFNPuHRUJtaCHDG44JVvEmPBEcwZ74gmFNd3wxGA4cavxxd?=
 =?us-ascii?Q?XoYqWKN54J0F874QswGnN8kHGyjWPVvERdol+lBA5ytFz3MggwXfH16edNyv?=
 =?us-ascii?Q?00vLxFgBJXLVL1W/JNMiE+R3iZ9WCIt1XBd5QbsH3/G8dSxiBIMKErsXWC1u?=
 =?us-ascii?Q?zC8HKx6E9nA/jCceeZuM4VvBDaGT+bBbFm631xtQb289GHl8wLN76YM6dowk?=
 =?us-ascii?Q?FjUl4htTiKmmDqgaHVCSLALOsQoaTcoqxRBQT6ZcJ/XXIFCCHoZEuicnU9de?=
 =?us-ascii?Q?nkUkvC8vx/3NXK4FUh3RBK9HhPYIFiVkhx2xGdo81cjN+kQJhhT2Bf9viM6B?=
 =?us-ascii?Q?vcQNiTTDaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa292885-c981-4df5-e8c6-08de5e84a4c4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:48:12.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GVSOrdV4La8bJP9QtAy/7317tThZqocOyrNOYpRBquEeMga0kRbBcAyAKv1J4qnBCkmebSkZEUcZxQ5uyvMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[dw_edma_chan.id:query timed out,valinux.co.jp:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8554-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CD577A4A92
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> providers may need to expose those LL regions to the host so it can
> build descriptors against the remote view.
>
> Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> the LL region (base/size) for a given EPC, transfer direction
> (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> helper maps the request to the appropriate read/write LL region
> depending on whether the integrated eDMA is the local or the remote
> view.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
>  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index bbaeecce199a..e8617873e832 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> +
> +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> +				enum dma_transfer_direction dir, int hw_id,
> +				struct dw_edma_region *region)

These APIs need an user, A simple method is that add one test case in
pci-epf-test.

Frank

> +{
> +	struct dw_edma_chip *chip;
> +	struct dw_pcie_ep *ep;
> +	struct dw_pcie *pci;
> +	bool dir_read;
> +
> +	if (!epc || !region)
> +		return -EINVAL;
> +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> +		return -EINVAL;
> +	if (hw_id < 0)
> +		return -EINVAL;
> +
> +	ep = epc_get_drvdata(epc);
> +	if (!ep)
> +		return -ENODEV;
> +
> +	pci = to_dw_pcie_from_ep(ep);
> +	chip = &pci->edma;
> +
> +	if (!chip->dev)
> +		return -ENODEV;
> +
> +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> +		dir_read = (dir == DMA_DEV_TO_MEM);
> +	else
> +		dir_read = (dir == DMA_MEM_TO_DEV);
> +
> +	if (dir_read) {
> +		if (hw_id >= chip->ll_rd_cnt)
> +			return -EINVAL;
> +		*region = chip->ll_region_rd[hw_id];
> +	} else {
> +		if (hw_id >= chip->ll_wr_cnt)
> +			return -EINVAL;
> +		*region = chip->ll_region_wr[hw_id];
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> index a5b0595603f4..36afb4df1998 100644
> --- a/include/linux/pcie-dwc-edma.h
> +++ b/include/linux/pcie-dwc-edma.h
> @@ -6,6 +6,8 @@
>  #ifndef LINUX_PCIE_DWC_EDMA_H
>  #define LINUX_PCIE_DWC_EDMA_H
>
> +#include <linux/dma/edma.h>
> +#include <linux/dmaengine.h>
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
>  #include <linux/pci-epc.h>
> @@ -27,6 +29,29 @@
>   */
>  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
>  				 resource_size_t *sz);
> +
> +/**
> + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> + * @epc:    EPC device associated with the integrated eDMA instance
> + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> + * @region: pointer to a region descriptor to fill in
> + *
> + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> + * (LL) regions for descriptor storage. This helper returns the LL region
> + * corresponding to @dir and @hw_id.
> + *
> + * The mapping between @dir and the underlying eDMA read/write LL region
> + * depends on whether the integrated eDMA instance represents a local or a
> + * remote view.
> + *
> + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> + *         or not initialized.
> + */
> +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> +				enum dma_transfer_direction dir, int hw_id,
> +				struct dw_edma_region *region);
>  #else
>  static inline int
>  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int
> +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> +			    enum dma_transfer_direction dir, int hw_id,
> +			    struct dw_edma_region *region)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_PCIE_DW */
>
>  #endif /* LINUX_PCIE_DWC_EDMA_H */
> --
> 2.51.0
>

