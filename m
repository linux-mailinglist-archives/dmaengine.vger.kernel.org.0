Return-Path: <dmaengine+bounces-8930-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYbEPiulGk2GgIAu9opvQ
	(envelope-from <dmaengine+bounces-8930-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:10:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9B14EEF3
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15CF3304AC03
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10182BEFE7;
	Tue, 17 Feb 2026 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B3W53GdC"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DD1A317D;
	Tue, 17 Feb 2026 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351781; cv=fail; b=FnvAGjFx/3Q2+pAarCr4RWbiuNCMwziawFAlhCpP+vd7Klylml0iDXrzUQ/1eNObIptr3a9XqKNCz+z4PdT3XJLJktGB+4gYRB/4Y4bS3qD5UK9nRZfW7YnRgWGtsXQKTmmfZqZQNIB2O7zPt7kPtNW6kLDgdLpaqvv2bKZ7Yq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351781; c=relaxed/simple;
	bh=CmBIG9t0VCyEoQmsX3dLy/6IuMvLG/40A42ilnALqOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OfIoaldFGdO4bqvk+zZWcV0Xt8LGvKzKaFBUSXtdRZRD7AUp/Ay9dY+QVvT9aqUi4g7Ai8J2YYA7zUtPhHB8k+zdgDsU31U4QEbCf7S3zpmqnkZN6rlQ0esegRzXQRy3bdKBDH3apyZV9gidQeMpsoUvyFHXLOKnUFuSZ93yi8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B3W53GdC; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLr4s2JdiyTpnStGONz1N7UTqU/RXsNF+N6Eu6CDFeD2jE1hwFKO3chVmyH0l4eRGkSKKq8jM+unOtTz/dG4CFpapYmJtdV5LbqozRs3CMtx/+rYpxCDbk8nO0Qm/dzPu8BI6jsMMgFF62aFTYbHP97XHqItADwTpuHFI2qXTzihOeICx5aooZ/aYdjXA/KaHyaJpk7y2CggNFoTd9CrUcIVQlrJFZsHScgllXGw6msXRcEtDj6+rLoEDPSBl072fnsNtT1bvhOyTGCnO/RTYL5OKq2x6W97CvpFucrTEtK6Lr/zy0UWUXXRyriZ51DYx9DUH758mTKhx83MELD9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KzlRe+4kZtM45aMI3gzd6eXLGLmZyzdX3F8Xqs5CBQ=;
 b=CcajhwJaTD9k00PYlHXG+s+52r0WqH8uZ7MPUb/q3Br/lLSunNw6qjSs+mdaarbWZWnaeqJz74NM8qatO27PsQfuMQ6400OaixwSqjYU/cbFeJvKr56jHBVJwQtc9ER0MMz5ea4azbMx6Si1pIfR80wvP3ML9l36kueYlyrJ5yc5B1DQZfxjKiqSIhVId2uEr9hOYjU9g6u5Q3+aM7D6y6jxf/tbPNpHa2pM4YdCjIGJst0HezpMeeTo8Zf8A2YOKEJ8ogtX9dgsX3JcpAp9F+TVya5BTZa+HzxqT8johMqlqs5dlpyc/VfvL+ORIQ3lcR1ovsmL45Fo1JuhfT2RNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KzlRe+4kZtM45aMI3gzd6eXLGLmZyzdX3F8Xqs5CBQ=;
 b=B3W53GdCfSLPFY8FUlMnPi7MfsMw59IhvHY0h0tYZB4N2DS3gpTx/tygPwK0mWEfOstC6Uko2DXI0K7uyzLLc1A4uapb7cjWicSKv87dPBB0urMDDV1xCVIaS6JObGc8PpZDhpPc3gK+qpUZTRVa/bm3LVmf7dX8FvI47djLhOIbURBHJ+WKNZnq1AT7RWCwz/GbAZaJAgD29CAqUK5fyYWZZbw4umAwR+R8I51iSB921tyKjfpatu7aXE8woblnGi0vxByF07NfMPx+ayutqDBy9YLKHYdTyUYXA+7wEOONNPouHzhv0E+IVJRc9F69AvaFU8SQUEIOphSehGLe+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8507.eurprd04.prod.outlook.com (2603:10a6:20b:432::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 18:09:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 18:09:36 +0000
Date: Tue, 17 Feb 2026 13:09:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 4/8] dmaengine: tegra: Use struct for register offsets
Message-ID: <aZSu2D0BIVEmSqpU@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-5-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-5-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH8P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f9f81-f883-4880-b739-08de6e4fb5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kk5uDwkfge0qzRw8j8O6lyJmMpufdB+4aQ/FBTeIhEpeta/KnhmhsgsACHDE?=
 =?us-ascii?Q?GNjb27L8EO4Us5UQJdpwy0D0RzvBinkohpUUwG1NNkZ7CkQho21Q0J34jYih?=
 =?us-ascii?Q?UsxwiAkTPUW5bw35wUTRt5si58d/bk3pGSWuTKhHoQtY4PQBAiTGxtrHPOT3?=
 =?us-ascii?Q?QfJ3KCeDdPUnbdCnGKPbANjn9A4UT5kbJlUEZkK6Hy6gbug9S9VY4fopPVaS?=
 =?us-ascii?Q?/VmaoeIuBE12s3NQ6d6MBvp3w5tVq/hJ6eKYcvUh9omNJ7yUGE4cpX4Yg9Yf?=
 =?us-ascii?Q?Q/fJsj5ucN3CHwqTwsxDQip/3mMk/IDsd4emdK1SEe/cc8VMi9yprqbd+Jdl?=
 =?us-ascii?Q?aPjS2mGj0fW9ubb1dxOJjdvRmNLmmtBBiyqJCFLLRJuHy8BG64+D48BdWKpR?=
 =?us-ascii?Q?zBxwx1eIoig5MpJWt248tFahbGDS/1rvcF1CLMVkXoSZUa/tUzEEUelRbeaS?=
 =?us-ascii?Q?nbE4T4Pg4xQ15kw2TY/YwHmKLDJYfsN7fRiWoeZED95jU8sLP5zMkF5ru+pI?=
 =?us-ascii?Q?NtDHjBc+jGI8P3js9k3mzwsjl01mIQ3m57bgVyJNFOZ81qt5cBOZHrm/WlCQ?=
 =?us-ascii?Q?b5lZJhqQlV5dPvT834gLrkgfYVlIvCPn7VweU5ktJM5xT/7xqNgeoZGTFD45?=
 =?us-ascii?Q?WBnIFpw2AfmnsDw3VZ/UCkqIAYq3u/4wN9MtVS3NKFoHtj/ntGexLWcsm8Gk?=
 =?us-ascii?Q?nOQxT6ZjO7vRU6Vt8Dg4T2xUDs6vpczooeNvucGGb6IuqxI5emLts/q/VppR?=
 =?us-ascii?Q?xqj8lW5nITpd2j6Q5yeMWfBGjY/s3YiNEERf63+XqwPLZH0Ka1+DrNvua+GL?=
 =?us-ascii?Q?9Z92c8x09ev8cDhsmY0pXmBc8JBhnSbLDva/DaJ+X7IcVDgBCFp4nVyRadIK?=
 =?us-ascii?Q?Q/4Sw5EGsoh+AmzK5O4jDjovGYrzfWXhq0hERNWVOFJl/tUH16+3JcI5y6RE?=
 =?us-ascii?Q?l5t6MAsS4YXkYQQn34WSGLUkLcdmqXG/712w9IJnfrd3ZvQ5zKLZyIbq02ko?=
 =?us-ascii?Q?Yf7bLxu+/zlNtbWWQv8w4fZbMGsKOVLKXLBpFb1ieDspUSmSuc8RpEbdz0xO?=
 =?us-ascii?Q?Q7lgJ2nTPrWbGm0kgInod1expFeYqg2WTmJMwmz63isJRO64T8qZHUapJatd?=
 =?us-ascii?Q?NPz4u5k8FjgJ+G8vPmgDVpiRVRxxtbISJ3dU7pStqpjNL+/wDPgRUaMrCS/l?=
 =?us-ascii?Q?TFT/0CYD+Q5QqYj9iysAcvLrV15BzA6fsd0P4h+p1aRbr45J5S5DUjazbviX?=
 =?us-ascii?Q?MA04/qOhDLH59IL90B0EdgWG+pb7OwWJGAxqgLB5N4H6ZN4HuUh4oPIhsAB7?=
 =?us-ascii?Q?ZMRD65jqMRJSaU/EX7rMvzqj1hKJy28dg8Q4hiPHO9oWtc21Q+QgQh6QG4wd?=
 =?us-ascii?Q?+DIOK1gLjEJdLZCOqkuN3d0oFCMhsfy383ijakvNFJLlVLYp2XHzVQR0Uq0i?=
 =?us-ascii?Q?nPWQkRd6u9aDuhA/7Lvj3KjshKniKimZKz+9DWSjbtbdWA6yeHpYI1yxHDbp?=
 =?us-ascii?Q?7LTIdPHGgdP72Ss8RS0exUmgNwMlNJUAn8V2ZKHguXxNa9r5DN5exOLKUaZB?=
 =?us-ascii?Q?4H1C7WUuMXeX26w8AEShriOhGjVeBcdIReQN5fyEd/0pO2JqWIJGwXyqQOIx?=
 =?us-ascii?Q?v6tn2DS0FMT4DC4I18mRM6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wgpHLU8kCdJVdK5pMvUQkKQ5TTl50EnweyGWm9VSCL+lUoyWBymeT/kzqa+?=
 =?us-ascii?Q?yWnyNfKh6/4WqQi84F2XCFexcufD7OD7lhzOTwsCd/JY/ENZkcMKMKSBeQGv?=
 =?us-ascii?Q?uKY/1j+MahbA3ogUTc39VxzOj27EmYSdE6e0TanyqKz2GOtQRKOwWTgUq8Ne?=
 =?us-ascii?Q?jN4j99Y6WkFZaLgRPvDaKkbuZ+QuCkZlPkOj97M7XJo8lhYu6xoFg1Qd6KaS?=
 =?us-ascii?Q?jfb34YdU4cuEkvIX2Yj7WDK7vJAtk2KyDsMKOrQUPkJvea9yyvy1wzhPOSh0?=
 =?us-ascii?Q?rE0U6lV/WLHBbLQ2GQcbL206BDZKbV1F8VsKQlmWFFKTFhEbqlC13JTQJy6b?=
 =?us-ascii?Q?Tpj/OZ4Wz9poicrb0smXFAJOBeAi3KjU7IRGa5QORwt4yvxWD1wLo4CjOki2?=
 =?us-ascii?Q?A4jwKkVENNaO1qVdEjWhPeU4Dyv2bLCjAMRSFDO1MRGxzauVIT6YDu/fBsoS?=
 =?us-ascii?Q?17JUuk9spsmHuR1GJ3dDYWh6E02j74WVN0tMeyP5QBSphGrcZ6eYFre0c3Cf?=
 =?us-ascii?Q?XGMDKuL6OcE6hs5p6h5O2yLmlPNjdf8RRZapW17lqusex+H0HdoNNmjlhZ2u?=
 =?us-ascii?Q?Zjf0ly4N5Kvd3XPhtGXGO5JUEOq5K8LYacOyB7cTTkjOC9VeiLyRmoRH0jhk?=
 =?us-ascii?Q?aysHOhnuIKQhDYIL2vZuLwogqRv2riNs8N0AEX8dYITDwbazvCuY5MBbXSjV?=
 =?us-ascii?Q?6vs1HlQ+adQAIJ1GUSc8cjPFTbfWBcACvkdwu7Znt6gfUZTac3oU/4mDabJY?=
 =?us-ascii?Q?Q4mhbFOsqtdfHf67CPhLzQb8P2pUT0SLC0V/6av7u1w5uOLXENAexdgZClho?=
 =?us-ascii?Q?PS7lhBs98dK/ZkZcOnMgw59nFcpI5T+DFsifhFMTYgb9isjm4gRjnnzRJwvo?=
 =?us-ascii?Q?oghqyy9GGSGcAYQICmoabG6qkvLtfjV7zcigvv7bIX0SRIWsdesHBWLgnC22?=
 =?us-ascii?Q?UoyBq171xktIkJmzcg9l5aXElrX3tLaOnDJiWDGX8vQXOH0IR+q136XGPHOb?=
 =?us-ascii?Q?3sYki+xcGDDXUZgYIGGl7Erhr97l9TFZkmGtK9gRG0YMKKdwdJEJ8J4ehDG7?=
 =?us-ascii?Q?RbUrnM37BW/ttiY4SumCwgAdHCBdg8vCQY422LaziVI7Cm38JNvf1SKRYm6c?=
 =?us-ascii?Q?MOTax0TuUtAtXFffFuJgevCCTRoAJl+YinT2+R0xyBHSY7mJ+/K2gEGD//x0?=
 =?us-ascii?Q?I4iKA0E2+Uwkd9PfB31+DzqTxH/a3sQ5ckaLGguOBLK2k8+9CC9AbdBXUIRQ?=
 =?us-ascii?Q?YSwl2LyFiqq2UTk5jWA0+h2BprCx5EAe0WEiqJdCx6zQOp+5yothMUgI5D8C?=
 =?us-ascii?Q?CW28qHzjSe4OnP6Fm+Z6lLMOxXKIiixS3Q+2/P6JG2PgChmEI/SYWxefn+9v?=
 =?us-ascii?Q?pqTTiHhAsTkE6qJx7+Lr7J4kaCA8iauPXJ08Pn+2Tsuu0bkb7/G4Qd04fO4x?=
 =?us-ascii?Q?tV0uOcCo1dZxzp3E0Cved7SuQpT+nzeYnKODpwPNYRFU8tRudd+FP24+kNDS?=
 =?us-ascii?Q?qsv0RcET+cK0XHATW902sAKl9YLyoQrs+XqP6ZybBHH9YhoEmdG08grpsfo+?=
 =?us-ascii?Q?J2nBPLo5nH+nXL9oj9v0STBQt9X5dq8SDU+ISYacDmjucBBWkrp0hD2Ej79Y?=
 =?us-ascii?Q?1fBoJgcCO00GaA5CxzYt3ZtmXIExWgrqbUwZHFkZj8Hz0P4I1NPn6X7oB+YQ?=
 =?us-ascii?Q?lRIcLBjinWv3IEAgEtfFCwKVwcmcG5tHvWshx7d0fQ0B7UgE3i4hyzrHUIXr?=
 =?us-ascii?Q?RNIU+T/fIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f9f81-f883-4880-b739-08de6e4fb5b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 18:09:36.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGiM+jq0csllYiPWcTfHVBvIuxjDX7eIyqLUDjkkSlTnVLUg/A658WToE1RHFfdaHJ58AxBvIBgrVhp8ZENB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8930-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: CCE9B14EEF3
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:53PM +0530, Akhil R wrote:
> Repurpose tegra_dma_channel_regs struct to define offsets for all the
> channel registers. Previously, the struct only held the register values
> for each transfer and was wrapped within tegra_dma_sg_req. Now, let
> struct tegra_dma_sg_req hold the values directly and use channel_regs
> for storing the register offsets. Update all register read/write to use
> channel_regs struct. This is to accommodate the register offset change
> in Tegra264.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/tegra186-gpc-dma.c | 280 +++++++++++++++++----------------
>  1 file changed, 147 insertions(+), 133 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 236a298c26a1..72701b543ceb 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -22,7 +22,6 @@
>  #include "virt-dma.h"
>
>  /* CSR register */
> -#define TEGRA_GPCDMA_CHAN_CSR			0x00
>  #define TEGRA_GPCDMA_CSR_ENB			BIT(31)
>  #define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
>  #define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
> @@ -58,7 +57,6 @@
>  #define TEGRA_GPCDMA_CSR_WEIGHT			GENMASK(13, 10)
>
>  /* STATUS register */
> -#define TEGRA_GPCDMA_CHAN_STATUS		0x004
>  #define TEGRA_GPCDMA_STATUS_BUSY		BIT(31)
>  #define TEGRA_GPCDMA_STATUS_ISE_EOC		BIT(30)
>  #define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
> @@ -70,22 +68,13 @@
>  #define TEGRA_GPCDMA_STATUS_IRQ_STA		BIT(21)
>  #define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
>
> -#define TEGRA_GPCDMA_CHAN_CSRE			0x008
>  #define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
>
> -/* Source address */
> -#define TEGRA_GPCDMA_CHAN_SRC_PTR		0x00C
> -
> -/* Destination address */
> -#define TEGRA_GPCDMA_CHAN_DST_PTR		0x010
> -
>  /* High address pointer */
> -#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
>  #define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
>  #define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
>
>  /* MC sequence register */
> -#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
>  #define TEGRA_GPCDMA_MCSEQ_DATA_SWAP		BIT(31)
>  #define TEGRA_GPCDMA_MCSEQ_REQ_COUNT		GENMASK(30, 25)
>  #define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
> @@ -101,7 +90,6 @@
>  #define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK	GENMASK(6, 0)
>
>  /* MMIO sequence register */
> -#define TEGRA_GPCDMA_CHAN_MMIOSEQ			0x01c
>  #define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
>  #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH		GENMASK(30, 28)
>  #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	\
> @@ -120,17 +108,7 @@
>  #define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD		GENMASK(18, 16)
>  #define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT		GENMASK(8, 7)
>
> -/* Channel WCOUNT */
> -#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
> -
> -/* Transfer count */
> -#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
> -
> -/* DMA byte count status */
> -#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
> -
>  /* Error Status Register */
> -#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
>  #define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	8
>  #define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	0xF
>  #define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
> @@ -143,14 +121,9 @@
>  #define TEGRA_DMA_MC_SLAVE_ERR			0xB
>  #define TEGRA_DMA_MMIO_SLAVE_ERR		0xA
>
> -/* Fixed Pattern */
> -#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
> -
> -#define TEGRA_GPCDMA_CHAN_TZ			0x38
>  #define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
>  #define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
>
> -#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
>  #define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
>
>  /*
> @@ -181,19 +154,27 @@ struct tegra_dma_chip_data {
>  	unsigned int nr_channels;
>  	unsigned int channel_reg_size;
>  	unsigned int max_dma_count;
> +	const struct tegra_dma_channel_regs *channel_regs;
>  	int (*terminate)(struct tegra_dma_channel *tdc);
>  };
>
>  /* DMA channel registers */
>  struct tegra_dma_channel_regs {
>  	u32 csr;
> -	u32 src_ptr;
> -	u32 dst_ptr;
> -	u32 high_addr_ptr;
> +	u32 status;
> +	u32 csre;
> +	u32 src;
> +	u32 dst;
> +	u32 high_addr;
>  	u32 mc_seq;
>  	u32 mmio_seq;
>  	u32 wcount;
> +	u32 wxfer;
> +	u32 wstatus;
> +	u32 err_status;
>  	u32 fixed_pattern;
> +	u32 tz;
> +	u32 spare;
>  };
>
>  /*
> @@ -205,7 +186,14 @@ struct tegra_dma_channel_regs {
>   */
>  struct tegra_dma_sg_req {
>  	unsigned int len;
> -	struct tegra_dma_channel_regs ch_regs;
> +	u32 csr;
> +	u32 src;
> +	u32 dst;
> +	u32 high_addr;
> +	u32 mc_seq;
> +	u32 mmio_seq;
> +	u32 wcount;
> +	u32 fixed_pattern;
>  };
>
>  /*
> @@ -228,19 +216,20 @@ struct tegra_dma_desc {
>   * tegra_dma_channel: Channel specific information
>   */
>  struct tegra_dma_channel {
> -	bool config_init;
> -	char name[30];
> -	enum dma_transfer_direction sid_dir;
> -	enum dma_status status;
> -	int id;
> -	int irq;
> -	int slave_id;
> +	const struct tegra_dma_channel_regs *regs;
>  	struct tegra_dma *tdma;
>  	struct virt_dma_chan vc;
>  	struct tegra_dma_desc *dma_desc;
>  	struct dma_slave_config dma_sconfig;
> +	enum dma_transfer_direction sid_dir;
> +	enum dma_status status;
>  	unsigned int stream_id;
>  	unsigned long chan_base_offset;
> +	bool config_init;
> +	char name[30];
> +	int id;
> +	int irq;
> +	int slave_id;
>  };
>
>  /*
> @@ -288,22 +277,25 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
>  {
>  	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
>  		tdc->id, tdc->name);
> -	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x SRC %x DST %x\n",
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
> +	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x\n",
> +		tdc_read(tdc, tdc->regs->csr),
> +		tdc_read(tdc, tdc->regs->status),
> +		tdc_read(tdc, tdc->regs->csre)
>  	);
> -	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
> +	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
> +		tdc_read(tdc, tdc->regs->src),
> +		tdc_read(tdc, tdc->regs->dst),
> +		tdc_read(tdc, tdc->regs->high_addr)
> +	);
> +	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
> +		tdc_read(tdc, tdc->regs->mc_seq),
> +		tdc_read(tdc, tdc->regs->mmio_seq),
> +		tdc_read(tdc, tdc->regs->wcount),
> +		tdc_read(tdc, tdc->regs->wxfer),
> +		tdc_read(tdc, tdc->regs->wstatus)
>  	);
>  	dev_dbg(tdc2dev(tdc), "DMA ERR_STA %x\n",
> -		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
> +		tdc_read(tdc, tdc->regs->err_status));
>  }
>
>  static int tegra_dma_sid_reserve(struct tegra_dma_channel *tdc,
> @@ -377,13 +369,13 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
>  	int ret;
>  	u32 val;
>
> -	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
> +	val = tdc_read(tdc, tdc->regs->csre);
>  	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
> +	tdc_write(tdc, tdc->regs->csre, val);
>
>  	/* Wait until busy bit is de-asserted */
>  	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> -			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
> +			tdc->chan_base_offset + tdc->regs->status,
>  			val,
>  			!(val & TEGRA_GPCDMA_STATUS_BUSY),
>  			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
> @@ -419,9 +411,9 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
>  {
>  	u32 val;
>
> -	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
> +	val = tdc_read(tdc, tdc->regs->csre);
>  	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
> +	tdc_write(tdc, tdc->regs->csre, val);
>
>  	tdc->status = DMA_IN_PROGRESS;
>  }
> @@ -456,27 +448,27 @@ static void tegra_dma_disable(struct tegra_dma_channel *tdc)
>  {
>  	u32 csr, status;
>
> -	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +	csr = tdc_read(tdc, tdc->regs->csr);
>
>  	/* Disable interrupts */
>  	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
>
>  	/* Disable DMA */
>  	csr &= ~TEGRA_GPCDMA_CSR_ENB;
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
> +	tdc_write(tdc, tdc->regs->csr, csr);
>
>  	/* Clear interrupt status if it is there */
> -	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	status = tdc_read(tdc, tdc->regs->status);
>  	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
>  		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
> -		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
> +		tdc_write(tdc, tdc->regs->status, status);
>  	}
>  }
>
>  static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
> -	struct tegra_dma_channel_regs *ch_regs;
> +	struct tegra_dma_sg_req *sg_req;
>  	int ret;
>  	u32 val;
>
> @@ -488,29 +480,29 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
>
>  	/* Configure next transfer immediately after DMA is busy */
>  	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> -			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
> +			tdc->chan_base_offset + tdc->regs->status,
>  			val,
>  			(val & TEGRA_GPCDMA_STATUS_BUSY), 0,
>  			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
>  	if (ret)
>  		return;
>
> -	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
> +	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
> +	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
> +	tdc_write(tdc, tdc->regs->src, sg_req->src);
> +	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> +	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
>
>  	/* Start DMA */
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
> -		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
> +	tdc_write(tdc, tdc->regs->csr,
> +		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
>  }
>
>  static void tegra_dma_start(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
> -	struct tegra_dma_channel_regs *ch_regs;
> +	struct tegra_dma_sg_req *sg_req;
>  	struct virt_dma_desc *vdesc;
>
>  	if (!dma_desc) {
> @@ -526,21 +518,21 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
>  		tegra_dma_resume(tdc);
>  	}
>
> -	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
> +	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
> +	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
> +	tdc_write(tdc, tdc->regs->csr, 0);
> +	tdc_write(tdc, tdc->regs->src, sg_req->src);
> +	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> +	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
> +	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
> +	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
> +	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
> +	tdc_write(tdc, tdc->regs->csr, sg_req->csr);
>
>  	/* Start DMA */
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
> -		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
> +	tdc_write(tdc, tdc->regs->csr,
> +		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
>  }
>
>  static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
> @@ -601,19 +593,19 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
>  	u32 status;
>
>  	/* Check channel error status register */
> -	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
> +	status = tdc_read(tdc, tdc->regs->err_status);
>  	if (status) {
>  		tegra_dma_chan_decode_error(tdc, status);
>  		tegra_dma_dump_chan_regs(tdc);
> -		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
> +		tdc_write(tdc, tdc->regs->err_status, 0xFFFFFFFF);
>  	}
>
>  	spin_lock(&tdc->vc.lock);
> -	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	status = tdc_read(tdc, tdc->regs->status);
>  	if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
>  		goto irq_done;
>
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
> +	tdc_write(tdc, tdc->regs->status,
>  		  TEGRA_GPCDMA_STATUS_ISE_EOC);
>
>  	if (!dma_desc)
> @@ -673,10 +665,10 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
>  	 * to stop DMA engine from starting any more bursts for
>  	 * the given client and wait for in flight bursts to complete
>  	 */
> -	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +	csr = tdc_read(tdc, tdc->regs->csr);
>  	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
>  	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
> +	tdc_write(tdc, tdc->regs->csr, csr);
>
>  	/* Wait for in flight data transfer to finish */
>  	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
> @@ -687,7 +679,7 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
>
>  	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
>  				tdc->chan_base_offset +
> -				TEGRA_GPCDMA_CHAN_STATUS,
> +				tdc->regs->status,
>  				status,
>  				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
>  				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
> @@ -739,14 +731,14 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
>  	unsigned int bytes_xfer, residual;
>  	u32 wcount = 0, status;
>
> -	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	wcount = tdc_read(tdc, tdc->regs->wxfer);
>
>  	/*
>  	 * Set wcount = 0 if EOC bit is set. The transfer would have
>  	 * already completed and the CHAN_XFER_COUNT could have updated
>  	 * for the next transfer, specifically in case of cyclic transfers.
>  	 */
> -	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	status = tdc_read(tdc, tdc->regs->status);
>  	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC)
>  		wcount = 0;
>
> @@ -893,7 +885,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
>  	/* Configure default priority weight for the channel */
>  	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
>
> -	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
>  	/* retain stream-id and clean rest */
>  	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
>
> @@ -916,16 +908,16 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
>  	dma_desc->sg_count = 1;
>  	sg_req = dma_desc->sg_req;
>
> -	sg_req[0].ch_regs.src_ptr = 0;
> -	sg_req[0].ch_regs.dst_ptr = dest;
> -	sg_req[0].ch_regs.high_addr_ptr =
> +	sg_req[0].src = 0;
> +	sg_req[0].dst = dest;
> +	sg_req[0].high_addr =
>  			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> -	sg_req[0].ch_regs.fixed_pattern = value;
> +	sg_req[0].fixed_pattern = value;
>  	/* Word count reg takes value as (N +1) words */
> -	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
> -	sg_req[0].ch_regs.csr = csr;
> -	sg_req[0].ch_regs.mmio_seq = 0;
> -	sg_req[0].ch_regs.mc_seq = mc_seq;
> +	sg_req[0].wcount = ((len - 4) >> 2);
> +	sg_req[0].csr = csr;
> +	sg_req[0].mmio_seq = 0;
> +	sg_req[0].mc_seq = mc_seq;
>  	sg_req[0].len = len;
>
>  	dma_desc->cyclic = false;
> @@ -961,7 +953,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
>  	/* Configure default priority weight for the channel */
>  	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
>
> -	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
>  	/* retain stream-id and clean rest */
>  	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
>  		  (TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
> @@ -985,17 +977,17 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
>  	dma_desc->sg_count = 1;
>  	sg_req = dma_desc->sg_req;
>
> -	sg_req[0].ch_regs.src_ptr = src;
> -	sg_req[0].ch_regs.dst_ptr = dest;
> -	sg_req[0].ch_regs.high_addr_ptr =
> +	sg_req[0].src = src;
> +	sg_req[0].dst = dest;
> +	sg_req[0].high_addr =
>  		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
> -	sg_req[0].ch_regs.high_addr_ptr |=
> +	sg_req[0].high_addr |=
>  		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
>  	/* Word count reg takes value as (N +1) words */
> -	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
> -	sg_req[0].ch_regs.csr = csr;
> -	sg_req[0].ch_regs.mmio_seq = 0;
> -	sg_req[0].ch_regs.mc_seq = mc_seq;
> +	sg_req[0].wcount = ((len - 4) >> 2);
> +	sg_req[0].csr = csr;
> +	sg_req[0].mmio_seq = 0;
> +	sg_req[0].mc_seq = mc_seq;
>  	sg_req[0].len = len;
>
>  	dma_desc->cyclic = false;
> @@ -1049,7 +1041,7 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  	if (flags & DMA_PREP_INTERRUPT)
>  		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
>
> -	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
>  	/* retain stream-id and clean rest */
>  	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
>
> @@ -1096,14 +1088,14 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  		dma_desc->bytes_req += len;
>
>  		if (direction == DMA_MEM_TO_DEV) {
> -			sg_req[i].ch_regs.src_ptr = mem;
> -			sg_req[i].ch_regs.dst_ptr = apb_ptr;
> -			sg_req[i].ch_regs.high_addr_ptr =
> +			sg_req[i].src = mem;
> +			sg_req[i].dst = apb_ptr;
> +			sg_req[i].high_addr =
>  				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
>  		} else if (direction == DMA_DEV_TO_MEM) {
> -			sg_req[i].ch_regs.src_ptr = apb_ptr;
> -			sg_req[i].ch_regs.dst_ptr = mem;
> -			sg_req[i].ch_regs.high_addr_ptr =
> +			sg_req[i].src = apb_ptr;
> +			sg_req[i].dst = mem;
> +			sg_req[i].high_addr =
>  				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
>  		}
>
> @@ -1111,10 +1103,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  		 * Word count register takes input in words. Writing a value
>  		 * of N into word count register means a req of (N+1) words.
>  		 */
> -		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
> -		sg_req[i].ch_regs.csr = csr;
> -		sg_req[i].ch_regs.mmio_seq = mmio_seq;
> -		sg_req[i].ch_regs.mc_seq = mc_seq;
> +		sg_req[i].wcount = ((len - 4) >> 2);
> +		sg_req[i].csr = csr;
> +		sg_req[i].mmio_seq = mmio_seq;
> +		sg_req[i].mc_seq = mc_seq;
>  		sg_req[i].len = len;
>  	}
>
> @@ -1186,7 +1178,7 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>
>  	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
>
> -	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
>  	/* retain stream-id and clean rest */
>  	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
>
> @@ -1218,24 +1210,24 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  	for (i = 0; i < period_count; i++) {
>  		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
>  		if (direction == DMA_MEM_TO_DEV) {
> -			sg_req[i].ch_regs.src_ptr = mem;
> -			sg_req[i].ch_regs.dst_ptr = apb_ptr;
> -			sg_req[i].ch_regs.high_addr_ptr =
> +			sg_req[i].src = mem;
> +			sg_req[i].dst = apb_ptr;
> +			sg_req[i].high_addr =
>  				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
>  		} else if (direction == DMA_DEV_TO_MEM) {
> -			sg_req[i].ch_regs.src_ptr = apb_ptr;
> -			sg_req[i].ch_regs.dst_ptr = mem;
> -			sg_req[i].ch_regs.high_addr_ptr =
> +			sg_req[i].src = apb_ptr;
> +			sg_req[i].dst = mem;
> +			sg_req[i].high_addr =
>  				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
>  		}
>  		/*
>  		 * Word count register takes input in words. Writing a value
>  		 * of N into word count register means a req of (N+1) words.
>  		 */
> -		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
> -		sg_req[i].ch_regs.csr = csr;
> -		sg_req[i].ch_regs.mmio_seq = mmio_seq;
> -		sg_req[i].ch_regs.mc_seq = mc_seq;
> +		sg_req[i].wcount = ((len - 4) >> 2);
> +		sg_req[i].csr = csr;
> +		sg_req[i].mmio_seq = mmio_seq;
> +		sg_req[i].mc_seq = mc_seq;
>  		sg_req[i].len = len;
>
>  		mem += len;
> @@ -1305,11 +1297,30 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
>  	return chan;
>  }
>
> +static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
> +	.csr = 0x0,
> +	.status = 0x4,
> +	.csre = 0x8,
> +	.src = 0xc,
> +	.dst = 0x10,
> +	.high_addr = 0x14,
> +	.mc_seq = 0x18,
> +	.mmio_seq = 0x1c,
> +	.wcount = 0x20,
> +	.wxfer = 0x24,
> +	.wstatus = 0x28,
> +	.err_status = 0x30,
> +	.fixed_pattern = 0x34,
> +	.tz = 0x38,
> +	.spare = 0x40,
> +};
> +
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>  	.nr_channels = 32,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = false,
> +	.channel_regs = &tegra186_reg_offsets,
>  	.terminate = tegra_dma_stop_client,
>  };
>
> @@ -1318,6 +1329,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> +	.channel_regs = &tegra186_reg_offsets,
>  	.terminate = tegra_dma_pause,
>  };
>
> @@ -1326,6 +1338,7 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> +	.channel_regs = &tegra186_reg_offsets,
>  	.terminate = tegra_dma_pause_noerr,
>  };
>
> @@ -1346,7 +1359,7 @@ MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
>
>  static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>  {
> -	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +	unsigned int reg_val =  tdc_read(tdc, tdc->regs->mc_seq);
>
>  	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
>  	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
> @@ -1354,7 +1367,7 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>  	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
>  	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
>
> -	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
> +	tdc_write(tdc, tdc->regs->mc_seq, reg_val);
>  	return 0;
>  }
>
> @@ -1420,6 +1433,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
>  					i * cdata->channel_reg_size;
>  		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
> +		tdc->regs = cdata->channel_regs;
>  		tdc->tdma = tdma;
>  		tdc->id = i;
>  		tdc->slave_id = -1;
> --
> 2.50.1
>

